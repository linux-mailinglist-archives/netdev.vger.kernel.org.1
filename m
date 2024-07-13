Return-Path: <netdev+bounces-111238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D627E930593
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 14:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4313928299C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA8D6EB5C;
	Sat, 13 Jul 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H8FYj+UH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44B4C8E
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720874120; cv=none; b=GK4/ZEtExCYjHCEpNWyW5rp8mAqOdLy/FRXE9VvXD77ZAOIIAWNSO/Fg/fNpHzw852YdHbC2/44TYs0Vgx572l5YysBNevR+z7ELFo56NdqaGRSZhJ0p7yrhcvVGXkx8nFKq04AdqUDpLfyLvj2xSKBFe49/uYWmKLhfpK/0UgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720874120; c=relaxed/simple;
	bh=1IO2L1lcwaT4nzc76dwwQjhyJn55mgy7IbxUs6H77lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIjnNUvIABreaO6jN37tVgN+Uaz7GPQEPwzg4rMpXVx6sqO461fOakyYpz+CsILLH7Gvz11gvKxmPq2mgpHtwuWJwtKf5ByMcy73PiHOWdgfCltfRiUWXjc5VHipkiEICX3VrcqKENqVkRTyv3tHaYVsCPOxkBRVuOjotmKxR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H8FYj+UH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DCQmqG007966;
	Sat, 13 Jul 2024 12:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
	FXaOtEiG1y8RzYrcIQlZscv8YmIMqNGoI3Zq9WAYfM=; b=H8FYj+UHJODvu4GqI
	f/WlM6W6SK4km+hp0ckSbLCsmwZt1XDx/9c1RK9jD3LQfQ7ujqXgRMH2PWMMt5Z7
	Ysc1r9/anmbdqj2LReIKGVI3wMUTQfMK3leq4A2V4h+f8h+53zGKd+kaEJhrO9gv
	gdAKeVGlgPlq0QLOy1YDUyuovv9zXJky9Y9V88451ooUxfy4UPrcvkwp5wAWLT8E
	ZPJ8EagrHjiirmps83uUe8ELDKTU6MHqJZn+8KX0P0Ocr2WFmh9NFl5nNmOyihqb
	wv6gQ8x/Npq8XFdfseB2da/yymo13UWJcZLhA9fuwbzRc5YEF4iscYxtDGCKS0Ii
	IAQLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40brr1026f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 12:35:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DAV5nt013931;
	Sat, 13 Jul 2024 12:35:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn1bnqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 12:35:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DCZ9Pk2949688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 13 Jul 2024 12:35:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBFBA58061;
	Sat, 13 Jul 2024 12:35:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD1E55803F;
	Sat, 13 Jul 2024 12:35:09 +0000 (GMT)
Received: from [9.61.16.211] (unknown [9.61.16.211])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 12:35:09 +0000 (GMT)
Message-ID: <2d7557d6-6702-485a-863a-f29abeb5ed4f@linux.ibm.com>
Date: Sat, 13 Jul 2024 07:35:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/1] bonding: Return TX congested if no
 active slave
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org
References: <20240712192405.505553-1-nnac123@linux.ibm.com>
 <2245992.1720827286@famine>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <2245992.1720827286@famine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cu6xefF8oo1cdDFLKIYR4vxH1V7gN_tZ
X-Proofpoint-GUID: cu6xefF8oo1cdDFLKIYR4vxH1V7gN_tZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=957 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407130092

Hi Jay, thanks for taking a look.

On 7/12/24 18:34, Jay Vosburgh wrote:
> Nick Child <nnac123@linux.ibm.com> wrote:
> 
>> 1. During a zero window probe, the socket attempts to get an updated
>> window from the peer 15 times (default of tcp_retries2). Looking at
>> tcp_send_probe0(), the timer between probes is either doubled or 0.5
>> seconds. The timer is doubled if the skb transmit returns
>> NET_XMIT_SUCCESS or NET_XMIT_CN (see net_xmit_eval()). Note that the
>> timer is set to a static 0.5 if NET_XMIT_DROP is returned. This means
>> the socket can ETIMEOUT after 7.5 seconds. The return code is typically
>> the return code of __dev_queue_xmit()
> 
> 	I'm not sure that your description of the behavior of
> tcp_send_probe0() matches the code.
> 
> 	It looks to me like the timer doubles for "if (err <= 0)",
> meaning a negative value or NET_XMIT_SUCCESS.  The 0.5 timeout value (in
> TCP_RESOURCE_PROBE_INTERVAL) is set in the "else" after "if (err <= 0)",
> so NET_XMIT_DROP and NET_XMIT_CN both qualify and would presumably
> result in the 0.5 second timeout.
> 
> 	However, since tcp_write_wakeup() -> tcp_transmit_skb() ->
> __tcp_transmit_skb() will convert NET_XMIT_CN to 0 (which is
> NET_XMIT_SUCCESS) via net_xmit_eval(), I'm not sure that it's possible
> for err to equal NET_XMIT_CN here.

Apologies, I was oversimplifying in my explanation. I was referencing
dev_queue_xmit returning either CN or DROP. On its way up the stack,
return code CN is mapped to 0 (in net_xmit_eval()). So, proper phrasing
is "when dev_queue_xmit returns CN, the timer is doubled. When 
dev_queue_xmit returns DROPPED, the timer is 0.5".

> 	I'll note that the 0.5 second timeout logic had a relatively
> recent change in c1d5674f8313 ("tcp: less aggressive window probing on
> local congestion").  From reading the log, the intent seems to be to
> bound the maximum probe interval to 0.5 seconds in low-RTT environments.
> 

I don't have any complaints with the quick timeout. I believe it has 
valid applications, I just don't think this scenario (when the bond
device is waiting for dev_deactivate) falls into that.

>> 2. In __dev_queue_xmit(), the skb is enqueued to the qdisc if the
>> enqueue function is defined. In this circumstance, the qdisc enqueue
>> function return code propagates up the stack. On the other hand, if the
>> qdisc enqueue function is NULL then the drivers xmit function is called
>> directly via dev_hard_start_xmit(). In this circumstance, the drivers
>> xmit return code propagates up the stack.
>>
>> 3. The bonding device uses IFF_NO_QUEUE, this sets qdisc to
>> noqueue_qdisc_ops. noqueue_qdisc_ops has NULL enqueue
>> function. Therefore, when the bonding device is carrier UP,
>> bond_start_xmit is called directly. In this function, depending on
>> bonding mode, a slave device is assigned to the skb and
>> __dev_queue_xmit() is called again. This time the slaves qdisc enqueue
>> function (which is almost always defined) is called.
> 
> 	Does your analysis or behavior change if the bond itself does
> have a qdisc?  IFF_NO_QUEUE does not install one by default, but users
> are free to add one.
> 

Good question. I did not try. Though I don't think we would see this 
issue because there would not be a way for the return code of 
dev_queue_xmit() to propagate all the way up to tcp_write_wakeup().

>> 4. When a device calls netif_carrier_off(), it schedules dev_deactivate
>> which grabs the rtnl lock and sets the qdisc to noop_qdisc. The enqueue
>> function of noop_qdisc is defined but simply returns NET_XMIT_CN.
>>
>> 5. The miimon of the bonding device periodically checks for the carrier
>> status of its slaves. If it detects that all of its slaves are down,
>> then it sets currently_active_slave to NULL and calls
>> netif_carrier_off() on itself.
>>
>> 6. In the bonding devices xmit function, if it does not have any active
>> slaves, it returns NET_XMIT_DROP.
>>
>> Given these observations. Assume a bonding devices slaves all suddenly
>> call netif_carrier_off(). Also assume that a tcp connection is in a zero
>> window probe. There is a window for a behavioral issue here:
> 
>> 1. If the bonding device does not notice that its slaves are down
>> (maybe its miimon interval is too large or the miimon commit could not
>> grab rtnl), then the slaves enqueue function is invoked. This will
>> either return NET_XMIT_SUCCESS OR NET_XMIT_CN. The probe timer is
>> doubled.
> 
> 	As I mentioned above, I'm not sure this accurately describes the
> behavior in tcp_send_probe0()
> 
> 	-J
> 
The call stack I describe here looks like this:
    pfifo_fast_enqueue+12
     dev_qdisc_enqueue+76
     __dev_queue_xmit+1700
     bond_dev_queue_xmit+68
     bond_start_xmit+1092
     dev_hard_start_xmit+300
     __dev_queue_xmit+3124
     ip_finish_output2+1020
     ip_output+228
     ip_local_out+104
     __ip_queue_xmit+384
     __tcp_transmit_skb+1644

Considering that tcp_write_wakeup calls tcp_transmit_skb and 
__tcp_transmit_skb translates NET_XMIT_CN to 0 through net_xmit_eval, I 
believe my statement is correct. If the slaves
enqueue function is invoked (in this case pfifo_fast) and 
NET_XMIT_SUCCESS or NET_XMIT_CN is returned then the probe timer is doubled.
>> -- 
>> 2.43.0
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

