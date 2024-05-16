Return-Path: <netdev+bounces-96666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB28C7050
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 04:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FC31C223AD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F515A4;
	Thu, 16 May 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vlxts31e"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DB63A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826762; cv=none; b=m2vmqOAmdwevbwo+6X6tHGqdPqITJDspMkc8x+f+MEeLjEJ4wMcAJK/WVqcdjZHkkE1s2ztRoI1sFU2NzpwUsslKauYTLbEWxdxNELXnHxFbKVHtyRH6bcOC+TnS0HxzRx6xxNF/1/+njRdnGPTtcRvLAN19+Vw7JBsxklu3jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826762; c=relaxed/simple;
	bh=BJ7UKyE4jxLZ9KL9CFjehIeGcrHoQfz1PBWIc8ws/dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ch0xC9mqTKiAyRzuVjpUb90C1rMt7R1R/ZnbFs3BsBlbNodVokLfspRn7G2hCS9RXPf8ZqZLHnKJzlyzye4HXR6CRMZMAhXbS2L0Pu4eOaspVb65fqhJ6zYFuia6AwzcFXeQvHy7rsN7fnSuL4Ijd7+uQ+qZOjt4a+l3HfFzqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vlxts31e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FIkOIx026431;
	Thu, 16 May 2024 02:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/b145KEs3iZH1CJwDjwVvGTGT+e90h7dUmWQqwZebuk=; b=Vl
	xts31e9ukOwdgmYD4WvxqpB9KhXlg7nlAQ7PjJFnCzWbPmJMMTE1m6k3nPGMJvAg
	kjAoWoCmr52m7LZSKcHLeN6avz9YVSFIA2drJMFIxn9jTmVydZRXUYoKJ/20EIq/
	LRPWTAmOrHjTA0U5BZ65gYJSYwmlJoJ/xl6i3UCZCMGP+RtOKbeAOG0XA5qTZO2x
	Uu8KTQ7Due0+BU8FmMEwfSGBmu37uU1jyLSFzc8rswdcUbmqge7DL5CaEJj9y0Bn
	qpF0CMWaI0SySd5aPPBInC62Idg3R6SOAEPoNm7fAQuCco6WAP5xFKMAkMehHYSa
	IHNm18lOnm2vAi4A9F4Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47egccqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:32:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G2WTI3025513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:32:29 GMT
Received: from [10.110.99.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 19:32:28 -0700
Message-ID: <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com>
Date: Wed, 15 May 2024 20:32:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of
 sysctl_tcp_adv_win_scale")
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
CC: <soheil@google.com>, <ncardwell@google.com>, <yyd@google.com>,
        <ycheng@google.com>, <quic_stranche@quicinc.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EsIDyuEyAOtGr1ZYAKynfI0mt17RkJGP
X-Proofpoint-ORIG-GUID: EsIDyuEyAOtGr1ZYAKynfI0mt17RkJGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160016

On 5/15/2024 1:10 AM, Eric Dumazet wrote:
> On Wed, May 15, 2024 at 6:47 AM Subash Abhinov Kasiviswanathan (KS)
> <quic_subashab@quicinc.com> wrote:
>>
>> We recently noticed that a device running a 6.6.17 kernel (A) was having
>> a slower single stream download speed compared to a device running
>> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 with
>> window size 4M from a third party server.
> 
> Hi Subash
> 
> I think you gave many details, but please give us more of them :

Hi Eric

Thanks for getting back. Hope the information below is useful.

> 
> 1) What driver is used on the receiver side.
rmnet

> 2) MTU
1372

> 3) cat /proc/sys/net/ipv4/tcp_rmem
4096 6291456 16777216

> 
> Ideally, you could snapshot "ss -temoi dst <otherpeer>" on receive
> side while the transfer is ongoing,
> and possibly while stopping the receiver thread (kill -STOP `pidof iperf`)
> 
192.0.0.2 is the device side address. I've listed the output of "ss 
-temoi dst 223.62.236.10" mid transfer and one around the end of transfer.

I believe iperf3 makes a control connection prior to triggering the data 
connection so it will list two flows.  The transfer between 
192.0.0.2:42278 <-> 223.62.236.10:5215 is the main data connection in 
this case.

//mid transfer
State       Recv-Q Send-Q Local Address:Port                 Peer 
Address:Port

ESTAB       0      0      192.0.0.2:42278                223.62.236.10:5215
     ino:129232 sk:3218 fwmark:0xc0078 <->
          skmem:(r0,rb8388608,t0,tb8388608,f0,w0,o0,bl0,d1) ts sack 
cubic wscale:7,6 rto:236 rtt:34.249/16.545 ato:40 mss:1320 rcvmss:1320 
advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:38 
bytes_received:211495680 segs_out:46198 segs_in:160290 data_segs_out:1 
data_segs_in:160287 send 3.1Mbps lastsnd:3996 pacing_rate 6.2Mbps 
delivery_rate 452.4Kbps app_limited busy:24ms rcv_rtt:26.542 
rcv_space:3058440 minrtt:23.34
ESTAB       0      0      192.0.0.2:42270                223.62.236.10:5215
     ino:128718 sk:4273 fwmark:0xc0078 <->
          skmem:(r0,rb6291456,t0,tb2097152,f0,w0,o0,bl0,d0) ts sack 
cubic wscale:10,9 rto:528 rtt:144.931/93.4 ato:40 mss:1320 rcvmss:536 
advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:223 bytes_received:4 
segs_out:9 segs_in:8 data_segs_out:3 data_segs_in:4 send 728.6Kbps 
lastsnd:6064 lastrcv:3948 lastack:3948 pacing_rate 1.5Mbps delivery_rate 
351.8Kbps app_limited busy:156ms rcv_space:13200 minrtt:30.021

//close to end of transfer
State       Recv-Q Send-Q Local Address:Port                 Peer 
Address:Port

ESTAB       4324072 0      192.0.0.2:42278                223.62.236.10:5215
      ino:129232 sk:3218 fwmark:0xc0078 <->
          skmem:(r4511016,rb8388608,t0,tb8388608,f2776,w0,o0,bl0,d1) ts 
sack cubic wscale:7,6 rto:236 rtt:34.249/16.545 ato:40 mss:1320 
rcvmss:1320 advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:38 
bytes_received:608252040 segs_out:133117 segs_in:460963 data_segs_out:1 
data_segs_in:460960 send 3.1Mbps lastsnd:10104 pacing_rate 6.2Mbps 
delivery_rate 452.4Kbps app_limited busy:24ms rcv_rtt:25.111 
rcv_space:3871560 minrtt:23.34
ESTAB       0      294    192.0.0.2:42270                223.62.236.10:5215
     timer:(on,412ms,0) ino:128718 sk:4273 fwmark:0xc0078 <->
          skmem:(r0,rb6291456,t0,tb2097152,f2010,w2086,o0,bl0,d0) ts 
sack cubic wscale:10,9 rto:512 rtt:129.796/94.265 ato:40 mss:1320 
rcvmss:536 advmss:1320 cwnd:10 ssthresh:1400 bytes_acked:224 
bytes_received:5 segs_out:12 segs_in:9 data_segs_out:5 data_segs_in:5 
send 813.6Kbps lastsnd:48 lastrcv:52 lastack:52 pacing_rate 1.6Mbps 
delivery_rate 442.8Kbps app_limited busy:228ms unacked:1 rcv_space:13200 
notsent:290 minrtt:23.848

> TCP is sensitive to the skb->len/skb->truesize ratio.
> Some drivers are known to provide 'bad skbs' in this regard.
> 
> Commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") is
> simply a step for dynamic
> probing of skb->len/skb->truesize ratio, and give incentive for better
> memory use.
> 
> Ultimately, TCP RWIN derives from effective memory usage.
> 
> Sending a too big RWIN can cause excessive memory usage or packet drops.
> If you say RWIN was 6MB+ before the patch, this looks like a bug to me,
> because tcp_rmem[2] = 6MB by default. There is no way a driver can
> pack 6MB of TCP payload in 6MB of memory (no skb/headers overhead ???)
> This would only work well in lossless networks, and if receiving
> application drains TCP receive queue fast enough.
> 
> Please take a look at these relevant patches.
> Note they are not perfect patches, because usbnet can still provide
> 'bad skbs', forcing TCP to send small RWIN.
rmnet is not updating the truesize directly in the receive path. There 
is no cloning and there is an explicit copy of the data content to a 
freshly allocated skb similar to your commits shared below.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c?h=v6.6.17#n385

 From netif_receive_skb_entry tracing, I see that the truesize is around 
~2.5K for ~1.5K packets.

> 
> d50729f1d60bca822ef6d9c1a5fb28d486bd7593 net: usb: smsc95xx: stop
> lying about skb->truesize
> 05417aa9c0c038da2464a0c504b9d4f99814a23b net: usb: sr9700: stop lying
> about skb->truesize
> 1b3b2d9e772b99ea3d0f1f2252bf7a1c94b88be6 net: usb: smsc75xx: stop
> lying about skb->truesize
> 9aad6e45c4e7d16b2bb7c3794154b828fb4384b4 usb: aqc111: stop lying about
> skb->truesize
> 4ce62d5b2f7aecd4900e7d6115588ad7f9acccca net: usb: ax88179_178a: stop
> lying about skb->truesize

I reviewed many of the tcpdumps from other tests internally and I 
consistently see the receiver window size scale to roughly half of what 
is specified in iperf3 regardless of whatever radio configurations or 
MTU. There was no download speed issue reported for any of these cases.

I believe this particular download test is failing as the RTT is likely 
higher in this network than the other cases.

