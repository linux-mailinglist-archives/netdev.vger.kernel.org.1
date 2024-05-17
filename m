Return-Path: <netdev+bounces-96864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399788C812D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E387B28290A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542614AB0;
	Fri, 17 May 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B9jl26wy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11021168C4
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929743; cv=none; b=X4aCQDIZtbD257Bxb0hr4fr0ocpRIT7O0nQ/YwScq+65DudDJ6xU6ppPRhBuY2YSflyKrqGMUUjacb6P4xRqnu0GeP7Awrahjo38xM67OpeSdPuT91fEERg/rLQmjAsZ98psKS3hMKC1qKLqtx8SLORLi8lqT12K5iMeKvp26D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929743; c=relaxed/simple;
	bh=TWltPxUb67lqHRqo0z9SaHFHUL5tK1NzEKkPhg1TaAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KZ3rrTbDAnXd0pBFBp9vPrO3/0BbctV/PqP5GBGi1MylMCS398EXITSG+frwtEciJ8GEwuOI/AZdL3HdcqaKgPPFABIQkoPnlJPzNT2fhRjTE66P4CDGBL35FHT9NywXZO6gnZdiwXnIWHf46WVZjzkqf/9SpJKnmU2QNFmrGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B9jl26wy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GKMZHj025960;
	Fri, 17 May 2024 07:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=X2KVZb6IfhUBA/rIHPveXFBx6NJADxpd+foVKSFpdts=; b=B9
	jl26wyIVK2yCtkSmgEj2YEA32TceMryK1/up80cURcoxdWoYvhiV9TqbNw8LSi71
	IEFmZ5Ws18Mw3PomcRRRAfGEc+N5aTNZUe/s5JkW/a21HB9gYZFAMMeqMJaW1MJZ
	HXfGGf/vdLX4fqXHDNja9JKRVF5RKTjhC/qFjRBOwdsiIc/aZcLbrZEboVePkz+/
	b5B2e2gL96+GWPRnScIVFaD4YDfLraG+sHvdghFbr8yJVYv8h5Vn5Tw4gP/IP0hX
	rfd8BrXMYR100o6OQ1PhJfG6FJpjPegF3ZaSc9M6h9+i0DnxeTuaMc4NroTz5XyS
	+rzglZB4eVg8UCojsPOw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49ft79r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 07:08:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44H78tYJ016554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 07:08:55 GMT
Received: from [10.110.99.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 May
 2024 00:08:54 -0700
Message-ID: <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
Date: Fri, 17 May 2024 01:08:53 -0600
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
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
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
 <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com>
In-Reply-To: <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A-QET8TSP4pYgPmOIMgsAV3CtBh0Dn02
X-Proofpoint-GUID: A-QET8TSP4pYgPmOIMgsAV3CtBh0Dn02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170055



On 5/16/2024 12:49 PM, Subash Abhinov Kasiviswanathan (KS) wrote:
> On 5/16/2024 2:31 AM, Eric Dumazet wrote:
>> On Thu, May 16, 2024 at 9:57 AM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Thu, May 16, 2024 at 9:16 AM Subash Abhinov Kasiviswanathan (KS)
>>> <quic_subashab@quicinc.com> wrote:
>>>>
>>>> On 5/15/2024 11:36 PM, Eric Dumazet wrote:
>>>>> On Thu, May 16, 2024 at 4:32 AM Subash Abhinov Kasiviswanathan (KS)
>>>>> <quic_subashab@quicinc.com> wrote:
>>>>>>
>>>>>> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
>>>>>>> On Wed, May 15, 2024 at 6:47 AM Subash Abhinov Kasiviswanathan (KS)
>>>>>>> <quic_subashab@quicinc.com> wrote:
>>>>>>>>
>>>>>>>> We recently noticed that a device running a 6.6.17 kernel (A) 
>>>>>>>> was having
>>>>>>>> a slower single stream download speed compared to a device running
>>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with 
>>>>>>>> iperf3 with
>>>>>>>> window size 4M from a third party server.
>>>>>>>
>>>>>
>> This is not fixable easily, because tp->window_clamp has been
>> historically abused.
>>
>> TCP_WINDOW_CLAMP socket option should have used a separate tcp socket 
>> field
>> to remember tp->window_clamp has been set (fixed) to a user value.
>>
>> Make sure you have this followup patch, dealing with applications
>> still needing to make TCP slow.
>>
>> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
>> Author: Hechao Li <hli@netflix.com>
>> Date:   Tue Apr 9 09:43:55 2024 -0700
>>
>>      tcp: increase the default TCP scaling ratio
>>> What happens if you let autotuning enabled ?
> I'll try this test and also the test with 4M SO_RCVBUF on the device 
> configuration where the download issue was observed and report back with 
> the findings.
With autotuning, the receiver window scaled to ~9M. The download speed 
matched whatever I got with setting SO_RCVBUF 16M on A earlier (which 
aligns with previous observation as the window scaled to ~8M without the 
commit).

With 4M SO_RCVBUF, the receiver window scaled to ~4M. Download speed 
increased significantly but didn't match the download speed of B with 4M 
SO_RCVBUF. Per commit description, the commit matches the behavior as if 
tcp_adv_win_scale was set to 1.

Download speed of B is higher than A for 4M SO_RCVBUF as receiver window 
of B grew to ~6M. This is because B had tcp_adv_win_scale set to 2.

