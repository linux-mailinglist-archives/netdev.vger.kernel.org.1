Return-Path: <netdev+bounces-96788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B48C7CA6
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 20:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E3B1C20C2F
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73871156642;
	Thu, 16 May 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EBXXFqVx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4324688
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885355; cv=none; b=rHvRu7/geB+a2g+53ii7X2nYh+vWJohwTMIevcQ/Kg0o0UPyvtAD/viS1ydMX4Tz6X75mGOmK343/kmWcieoubmQDgwjGZXe8b/3Guwem1uCR7ScMbEx87aUMYjn5JrdjztvzFDau9VXzd+hQJYzUVsEaPKNgf0SnfspQ0gO25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885355; c=relaxed/simple;
	bh=kFdX91C6XMiYW3BFKRcJ2L6ONTAuw/jqw5wtuANDoaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rNFi8tKBChYsIZAlQoGSnZVhlntON+KXnzTy8B3TU04vXwrCjd+EZ2XA54sCg/d/e7J+8Ag3RBVZIv1N355Sn5EeafTn5psctCAT6MyKVXc24kvMqf6UyYPsm1Fat/6esul95nUqKGMNl04knc9n2qFyXV/ZkkXqus2DU1r5T0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EBXXFqVx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G9r576021369;
	Thu, 16 May 2024 18:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=503yB+88agAO7zGaup3zAblU4hVfee2kNdUMGBmjsWc=; b=EB
	XXFqVxZH1NaQAdc2rQnng2cDy4rBKuedV5lb2s2ujuw1FdpAPjJb1y2luTanUSGr
	tOANIlYfkQzYKQhRS78TVqJWtjEoZPSEEINLEWdaTpncERatp2a6p1WBXQ0YsW0x
	6MGChhWupfUhv1eGvBIRzKyIXy2216WJHqVMZMll8G61zGws/tx6hxAOiccNqZSr
	sHR4P8tFwpdfgJIDVodx3Zd9f7X2/kwpbr0kg/FY5qoZ/zSc6GHkLUwUrNWxPPpE
	UTOFsBh4og7eXIAnb+jrovVHYTvZJrvCyVvXNL6BIErW1RFGEK+Soqq4MAWZWe4J
	nsXLniLKOMIbiZnbFIyQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbem0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 18:49:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GIn3Iu016257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 18:49:03 GMT
Received: from [10.110.99.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 11:49:02 -0700
Message-ID: <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com>
Date: Thu, 16 May 2024 12:49:01 -0600
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
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com>
 <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com>
 <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
 <CANn89iJQRM=j4gXo4NEZkHO=eQaqewS5S0kAs9JLpuOD_4UWyg@mail.gmail.com>
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <CANn89iJQRM=j4gXo4NEZkHO=eQaqewS5S0kAs9JLpuOD_4UWyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7sqqnU5vlSN8iR4c1v636wYcongfLn33
X-Proofpoint-ORIG-GUID: 7sqqnU5vlSN8iR4c1v636wYcongfLn33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160136

On 5/16/2024 2:31 AM, Eric Dumazet wrote:
> On Thu, May 16, 2024 at 9:57 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Thu, May 16, 2024 at 9:16 AM Subash Abhinov Kasiviswanathan (KS)
>> <quic_subashab@quicinc.com> wrote:
>>>
>>> On 5/15/2024 11:36 PM, Eric Dumazet wrote:
>>>> On Thu, May 16, 2024 at 4:32 AM Subash Abhinov Kasiviswanathan (KS)
>>>> <quic_subashab@quicinc.com> wrote:
>>>>>
>>>>> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
>>>>>> On Wed, May 15, 2024 at 6:47 AM Subash Abhinov Kasiviswanathan (KS)
>>>>>> <quic_subashab@quicinc.com> wrote:
>>>>>>>
>>>>>>> We recently noticed that a device running a 6.6.17 kernel (A) was having
>>>>>>> a slower single stream download speed compared to a device running
>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 with
>>>>>>> window size 4M from a third party server.
>>>>>>
>>>>
>>> I tried 0.5MB for the rmem[1] and I see the same behavior where the
>>> receiver window is not scaling beyond half of what is specified on
>>> iperf3 and is not matching the download speed of B.
>>
>>
>> What do you mean by "specified by iperf3" ?
>>
>> We can not guarantee any stable performance for applications setting SO_RCVBUF.
>>
>> This is because the memory overhead depends from one version to the other.
> 
> Issue here is that SO_RCVBUF is set before TCP has a chance to receive
> any packets.
> 
> Sensing the skb->len/skb->truesize is not possible.
> 
> Therefore the default value is conservative, and might not be good for
> your case.
> 
> This is not fixable easily, because tp->window_clamp has been
> historically abused.
> 
> TCP_WINDOW_CLAMP socket option should have used a separate tcp socket field
> to remember tp->window_clamp has been set (fixed) to a user value.
> 
> Make sure you have this followup patch, dealing with applications
> still needing to make TCP slow.
> 
> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
> Author: Hechao Li <hli@netflix.com>
> Date:   Tue Apr 9 09:43:55 2024 -0700
> 
>      tcp: increase the default TCP scaling ratio
Thanks! After applying it, I definitely see the increase in receiver 
window to ~4M with 4M SO_RCVBUF in my local device. Seems like this 
patch hasn't trickled down to 6.6 so far.

>> What happens if you let autotuning enabled ?
I'll try this test and also the test with 4M SO_RCVBUF on the device 
configuration where the download issue was observed and report back with 
the findings.

