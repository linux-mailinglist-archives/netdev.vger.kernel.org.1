Return-Path: <netdev+bounces-151812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD39F10A4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E35281E92
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E191E25EA;
	Fri, 13 Dec 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKZdkblv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF451B412E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102965; cv=none; b=hzOoAijd53T0cwy2Aupq9AyHDz1IEn7jSDDkC8BVO0Di9iALdOJ4v+EjaknzvFIhqynMEhzCmGiLRXrvE6Sq3U/KGVkGLQ51Eqw6FqEzcVhfh3TfGZKQXBJdcJuF7zgaMI19Ufeuj/Fpiydet+QU7F08d8/FR63nUSRtq/rmVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102965; c=relaxed/simple;
	bh=PWMoxDtVdkcOGn4zW9kZQI+Wz1ON5+gQghWQQoC+1gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6aD549p6f0KrZ02zl7O2E/wFZH7zb2SUbhiNa1gNHnw+s/v2XSv1aUIdT3YCL/C1qqyZ5lZ8PYk2YJUFMBlZRiELNRh+NFnaA0dc2HNR6c5VVg0VaMx3QCkkjFwyYZa4WG9CtxLg4Y/COggNor+YRUulbN287IJIgZwYVC6ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKZdkblv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIu5h017035;
	Fri, 13 Dec 2024 15:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CKx0Sd
	S6a3qwOz6m0OtYnu6TjW/vZYosDtQhE7niUn8=; b=rKZdkblvL5HyxCU/wmI8FB
	K7s+dviNCJn70ATmVkVCUy7itXbKMVXyUJgga77QBrHxCP4yBEwwWTEsl5rTWGSu
	hzY/QlVpj1IJ0WOOBBdbrFbuzYh1lXzmbV0xkI3WK9c+7VuTMsT4DMRbAsWj2rNz
	SWeDJzaDBXQhOzUker8RGXfuwlnJFv1r5zentxBPKGaejIC60ElZNS4niRhVqXYS
	1caRd7pn71gUtOUndiJKXgTSWhm0YLTc/kS/M1MMyPXivfz4y59owSIcCDrsX041
	KM23eK2qWVE300NNFQo3kaKdpYkWJcN/Xlc9D7NXbhjc36mXGpTrRtVc6F4VnSzQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbu1sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:15:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDFBWEu012434;
	Fri, 13 Dec 2024 15:15:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbu1sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:15:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDC9sdH032744;
	Fri, 13 Dec 2024 15:15:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psxp68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:15:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDFFg7e44958058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:15:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9DE58043;
	Fri, 13 Dec 2024 15:15:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED28D5805F;
	Fri, 13 Dec 2024 15:15:39 +0000 (GMT)
Received: from [9.171.74.77] (unknown [9.171.74.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 15:15:39 +0000 (GMT)
Message-ID: <64c67302-dc08-44d3-87a3-ea8b545d4f8b@linux.ibm.com>
Date: Fri, 13 Dec 2024 16:15:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 11/15] socket: Remove kernel socket
 conversion.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alibuda@linux.alibaba.com, allison.henderson@oracle.com,
        chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, jaka@linux.ibm.com, jlayton@kernel.org,
        kuba@kernel.org, kuni1840@gmail.com, matttbe@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org
References: <919d9910-a405-40f0-ad0b-fa3e8b908013@linux.ibm.com>
 <20241213135437.44216-1-kuniyu@amazon.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241213135437.44216-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MZPYQgzCtfRidzLeg63de-dVqL_3IcvP
X-Proofpoint-GUID: Z5Yp02qDkAmVZQLW0oJVyjW2fTbClIYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130106



On 13.12.24 14:54, Kuniyuki Iwashima wrote:
> From: Wenjia Zhang <wenjia@linux.ibm.com>
> Date: Fri, 13 Dec 2024 14:45:20 +0100
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index 6e93f188a908..7b0de80b3aca 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -3310,25 +3310,8 @@ static const struct proto_ops smc_sock_ops = {
>>>    
>>>    int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>>>    {
>>> -	struct smc_sock *smc = smc_sk(sk);
>>> -	int rc;
>>> -
>>> -	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>>> -			      &smc->clcsock);
>>> -	if (rc)
>>> -		return rc;
>>> -
>>> -	/* smc_clcsock_release() does not wait smc->clcsock->sk's
>>> -	 * destruction;  its sk_state might not be TCP_CLOSE after
>>> -	 * smc->sk is close()d, and TCP timers can be fired later,
>>> -	 * which need net ref.
>>> -	 */
>>> -	sk = smc->clcsock->sk;
>>> -	__netns_tracker_free(net, &sk->ns_tracker, false);
>>> -	sk->sk_net_refcnt = 1;
>>> -	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>>> -	sock_inuse_add(net, 1);
>> I don't think this line shoud be removed. Otherwise, the popurse here to
>> manage the per namespace statistics in the case of network namespace
>> isolation would be lost.
> 
> Now it's counted in sk_alloc().
> 
> sock_create_net() below passes hold_net=true to sk_alloc() and if
> sk->sk_netns_refcnt (== hold_net) is true, sock_inuse_add() is
> called there.
> 
> See patch 9 and 10:
> https://lore.kernel.org/netdev/20241213092152.14057-10-kuniyu@amazon.com/
> https://lore.kernel.org/netdev/20241213092152.14057-11-kuniyu@amazon.com/
> 
> 
ok, I see. Thank you for pointing it out!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

>> @D. Wythe, could you please check it again? Maybe you have some good
>> testing on this case.
>>
>>> -	return 0;
>>> +	return sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP,
>>> +			       &smc_sk(sk)->clcsock);
>>>    }


