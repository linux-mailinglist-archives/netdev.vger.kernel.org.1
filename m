Return-Path: <netdev+bounces-97223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A648CA16F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF45B1F217AF
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636A13774C;
	Mon, 20 May 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h3afun8X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E581A2D
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226406; cv=none; b=uL6WU+hcWKgubhW9CSNUMrDUrgH3WpTa5RGoyjDX+JU9zrBW+N/bKWbBw6LE7QwnXr2uFRHczS7PPAbj6nlY2e6bSNrOcO34htw/Y4BObgFqpkCJAJ8CMAVY6NV+2sWZUQkTVTb16U3b9V5ZU0vqpN8qbxhJYQsmJDFqXPtS8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226406; c=relaxed/simple;
	bh=+7Lz52iKUH59xMXkPoIfHoTH19XMT98VdssrKdjKMcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tOw2uBAgFJjbwnc25U+zPmqnA7VwTiQo0TlutNiboGqIsKvCw7hhNYBR6U5cerK7HtGuhqRMVieklgVpc2j0gsIa1dBfu72DOWvFMgJC63HjJ37S9tzds3Sm5zDLX33A6iqSlM+ZseBOhpzJ2VtpnVKeu7EFzV865veNqwk40GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h3afun8X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBrivf026920;
	Mon, 20 May 2024 17:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=o0dpH2v3Vxita+2kY0MzhlrninnQ6IPDeX18IiEVHSs=; b=h3
	afun8XZgsa4q6Zba0hXbB3pl7KMokcX9y1uvG8j2QGOtYnJoPrqLoLchKQNH/mDo
	fbLXPAfnN5sl6pemA3MH0MWX3YCrkCvtO8wlamR+/wQjzO5IV3TSPOrAJXY7U9YP
	gPFUDeGZGanFsQi54sNZzfsk1KqKB018EXocqDixyoSSP3QsUWRe+jV/9Jcdwfpd
	ips1znrjW1d+dFj7y1VxuxR51gPV/kB6BFkcrvzCkd+U6HMHhLsKDc5jKDDtpSbb
	QbUWieOCDzlQTqx71LhioyAJ0277UgDpLHWWrh44vIaBwekYWvNwOhJpao+UdpBX
	kFyi9ms2HBSkcO89w8Sw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqaktv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:33:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44KHXH0v022638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:33:17 GMT
Received: from [10.110.110.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 10:33:15 -0700
Message-ID: <27ddbc37-c229-4e8e-9f4f-01ca64af1d82@quicinc.com>
Date: Mon, 20 May 2024 11:33:14 -0600
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
 <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com>
 <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
 <1f7bae32-76e3-4f63-bcb8-89f6aaabc0e1@quicinc.com>
 <CANn89i+WsR-bB2_vAQ9t-Vnraq7r-QVt9mOZfTFY5VD7Bj2r5g@mail.gmail.com>
 <89d0b3d3-7c32-4138-8388-eab11369245f@quicinc.com>
 <CANn89i+YgEs1Rb4qmftmz9C-f=xKJu8AbkecNK9NCODXNQsjBA@mail.gmail.com>
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <CANn89i+YgEs1Rb4qmftmz9C-f=xKJu8AbkecNK9NCODXNQsjBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lBclxeHeyFcBWJApyEp3wgJ_3RiM6jEz
X-Proofpoint-ORIG-GUID: lBclxeHeyFcBWJApyEp3wgJ_3RiM6jEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405200140

On 5/20/2024 11:20 AM, Eric Dumazet wrote:
> On Mon, May 20, 2024 at 7:09 PM Subash Abhinov Kasiviswanathan (KS)
> <quic_subashab@quicinc.com> wrote:
>>
>> On 5/20/2024 9:12 AM, Eric Dumazet wrote:
>>> On Sun, May 19, 2024 at 4:14 AM Subash Abhinov Kasiviswanathan (KS)
>>> <quic_subashab@quicinc.com> wrote:
>>>>>>>>>>>>> We recently noticed that a device running a 6.6.17 kernel (A)
>>>>>>>>>>>>> was having
>>>>>>>>>>>>> a slower single stream download speed compared to a device running
>>>>>>>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with
>>>>>>>>>>>>> iperf3 with
>>>>>>>>>>>>> window size 4M from a third party server.
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>> This is not fixable easily, because tp->window_clamp has been
>>>>>>> historically abused.
>>>>>>>
>>>>>>> TCP_WINDOW_CLAMP socket option should have used a separate tcp socket
>>>>>>> field
>>>>>>> to remember tp->window_clamp has been set (fixed) to a user value.
>>>>>>>
>>>>>>> Make sure you have this followup patch, dealing with applications
>>>>>>> still needing to make TCP slow.
>>>>>>>
>>>>>>> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
>>>>>>> Author: Hechao Li <hli@netflix.com>
>>>>>>> Date:   Tue Apr 9 09:43:55 2024 -0700
>>>>>>>
>>>>>>>        tcp: increase the default TCP scaling ratio
>>>>> With 4M SO_RCVBUF, the receiver window scaled to ~4M. Download speed
>>>>> increased significantly but didn't match the download speed of B with 4M
>>>>> SO_RCVBUF. Per commit description, the commit matches the behavior as if
>>>>> tcp_adv_win_scale was set to 1.
>>>>>
>>>>> Download speed of B is higher than A for 4M SO_RCVBUF as receiver window
>>>>> of B grew to ~6M. This is because B had tcp_adv_win_scale set to 2.
>>>> Would the following to change to re-enable the use of sysctl
>>>> tcp_adv_win_scale to set the initial scaling ratio be acceptable.
>>>> Default value of tcp_adv_win_scale is 1 which corresponds to the
>>>> existing 50% ratio.
>>>>
>>>> I verified with this patch on A that setting SO_RCVBUF 4M in iperf3 with
>>>> tcp_adv_win_scale = 1 (default) scales receiver window to ~4M while
>>>> tcp_adv_win_scale = 2 scales receiver window to ~6M (which matches the
>>>> behavior from B).
> 
> I do not think we want to bring back a config option that has been
> superseded by something
> allowing a host to have multiple NIC, with different MTU, and multiple
> TCP flows with various MSS.
The default value still stays 1 and all of the accurate estimation of 
skb->len/skb->truesize still remains for all auto tuning users. I 
believe that should continue support all the configurations you mentioned.

I merely want to add the flexibility for users which have been affected 
here due to lack of backwards compatibility (SO_RCVBUF with 
tcp_adv_win_scale value other than 1).

