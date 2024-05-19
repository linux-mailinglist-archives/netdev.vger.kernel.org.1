Return-Path: <netdev+bounces-97121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11B8C934C
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 04:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB62281944
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 02:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770253D71;
	Sun, 19 May 2024 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ua6+n3qI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4A5256
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716084871; cv=none; b=gpaOzgWfB4u7uG1qbpjUeMB2uuM0G4eJpRznyqOZkMyI1P9yqqAulpK0hZr1tp6dMetemm/3Hg/4iKu2drnky7lTL2DDcIKjtM4vRPQRBic4Fw2YQWRg4gN+hSFWgaj0jbY6DLagQIl6qzRu622zzH7omTBQvzJ8FL+XFSJz8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716084871; c=relaxed/simple;
	bh=c+PvHaTHp4UH71sdqJ103reDazsxcTOcG8SUJ8I5u80=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=THbHywYO1h2LimRMYBpeEuLFNuFkRkU6eyds5g+ZraQog09C5HG8/wymAK+EWTukHKqRJp/yAwTRfUxyTqRGlL3uuUhwsJkC0qXgyLY2A3Mw3dzVSzN6KY/O4uG48Yiqk14Pnl1G8oc6+moYXV6GdOc26VY547XfKUBdDYM3WTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ua6+n3qI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44J0wJsY013047;
	Sun, 19 May 2024 02:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RtriSzgKtZKeOQ8x3TLuatQS2axswBCMxp4iuEu3GZQ=; b=Ua
	6+n3qITGi7CLe7tIyklaamMTBeF76qAJZJwiZ7eXUtddv6LEOlRB3gqlJ52ogml7
	vM/5uwtvT+vAPaKE01cbttU836Fe4tBpj5oKyY+cwPEiV/YUxrcwEr484N4SsQDa
	NVtXd+mlCOktYkHE/OXb/nmA2E2wNDvfl4JEcdDO/GDJYkrAbsd4+0XWp8vIS5w3
	Ab6MnTxQn5vG0qHINi3cEgpWnNv4KKHynzD2ijSL+OZ0fD5InvHFgxS3QcO9+RUG
	Fywk5/TfQInGn1bsHKxtch987d+b2+eNXLZMCauT3WZieKq7Pzgpr3+txEAjLnV0
	U9NOOfPSi2MFqwnS515g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psas2g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 May 2024 02:14:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44J2EFu7030106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 May 2024 02:14:15 GMT
Received: from [10.110.110.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 May
 2024 19:14:02 -0700
Message-ID: <1f7bae32-76e3-4f63-bcb8-89f6aaabc0e1@quicinc.com>
Date: Sat, 18 May 2024 20:13:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of
 sysctl_tcp_adv_win_scale")
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
 <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
Content-Language: en-US
In-Reply-To: <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZaKkTdiu0TEjMyeW0XkA7Kkb80vxaZ-N
X-Proofpoint-ORIG-GUID: ZaKkTdiu0TEjMyeW0XkA7Kkb80vxaZ-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_14,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405190018



On 5/17/2024 1:08 AM, Subash Abhinov Kasiviswanathan (KS) wrote:
> 
> 
> On 5/16/2024 12:49 PM, Subash Abhinov Kasiviswanathan (KS) wrote:
>> On 5/16/2024 2:31 AM, Eric Dumazet wrote:
>>> On Thu, May 16, 2024 at 9:57 AM Eric Dumazet <edumazet@google.com> 
>>> wrote:
>>>>
>>>> On Thu, May 16, 2024 at 9:16 AM Subash Abhinov Kasiviswanathan (KS)
>>>> <quic_subashab@quicinc.com> wrote:
>>>>>
>>>>> On 5/15/2024 11:36 PM, Eric Dumazet wrote:
>>>>>> On Thu, May 16, 2024 at 4:32 AM Subash Abhinov Kasiviswanathan (KS)
>>>>>> <quic_subashab@quicinc.com> wrote:
>>>>>>>
>>>>>>> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
>>>>>>>> On Wed, May 15, 2024 at 6:47 AM Subash Abhinov Kasiviswanathan (KS)
>>>>>>>> <quic_subashab@quicinc.com> wrote:
>>>>>>>>>
>>>>>>>>> We recently noticed that a device running a 6.6.17 kernel (A) 
>>>>>>>>> was having
>>>>>>>>> a slower single stream download speed compared to a device running
>>>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with 
>>>>>>>>> iperf3 with
>>>>>>>>> window size 4M from a third party server.
>>>>>>>>
>>>>>>
>>> This is not fixable easily, because tp->window_clamp has been
>>> historically abused.
>>>
>>> TCP_WINDOW_CLAMP socket option should have used a separate tcp socket 
>>> field
>>> to remember tp->window_clamp has been set (fixed) to a user value.
>>>
>>> Make sure you have this followup patch, dealing with applications
>>> still needing to make TCP slow.
>>>
>>> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
>>> Author: Hechao Li <hli@netflix.com>
>>> Date:   Tue Apr 9 09:43:55 2024 -0700
>>>
>>>      tcp: increase the default TCP scaling ratio
>>>> What happens if you let autotuning enabled ?
>> I'll try this test and also the test with 4M SO_RCVBUF on the device 
>> configuration where the download issue was observed and report back 
>> with the findings.
> With autotuning, the receiver window scaled to ~9M. The download speed 
> matched whatever I got with setting SO_RCVBUF 16M on A earlier (which 
> aligns with previous observation as the window scaled to ~8M without the 
> commit).
> 
> With 4M SO_RCVBUF, the receiver window scaled to ~4M. Download speed 
> increased significantly but didn't match the download speed of B with 4M 
> SO_RCVBUF. Per commit description, the commit matches the behavior as if 
> tcp_adv_win_scale was set to 1.
> 
> Download speed of B is higher than A for 4M SO_RCVBUF as receiver window 
> of B grew to ~6M. This is because B had tcp_adv_win_scale set to 2.
Would the following to change to re-enable the use of sysctl 
tcp_adv_win_scale to set the initial scaling ratio be acceptable. 
Default value of tcp_adv_win_scale is 1 which corresponds to the 
existing 50% ratio.

I verified with this patch on A that setting SO_RCVBUF 4M in iperf3 with 
tcp_adv_win_scale = 1 (default) scales receiver window to ~4M while 
tcp_adv_win_scale = 2 scales receiver window to ~6M (which matches the 
behavior from B).

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 618f991cb336..1bca7d2e47c8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1460,14 +1460,23 @@ static inline int tcp_space_from_win(const 
struct sock *sk, int win)
         return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
  }

-/* Assume a 50% default for skb->len/skb->truesize ratio.
- * This may be adjusted later in tcp_measure_rcv_mss().
- */
-#define TCP_DEFAULT_SCALING_RATIO (1 << (TCP_RMEM_TO_WIN_SCALE - 1))
-
  static inline void tcp_scaling_ratio_init(struct sock *sk)
  {
-       tcp_sk(sk)->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+       int win_scale = 
READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_adv_win_scale);
+
+       if (win_scale <= 0) {
+               if (win_scale < -TCP_RMEM_TO_WIN_SCALE)
+                       win_scale = -TCP_RMEM_TO_WIN_SCALE;
+
+               tcp_sk(sk)->scaling_ratio =
+                       1 << (TCP_RMEM_TO_WIN_SCALE + win_scale);
+       } else {
+               if (win_scale > TCP_RMEM_TO_WIN_SCALE)
+                       win_scale = TCP_RMEM_TO_WIN_SCALE;
+
+               tcp_sk(sk)->scaling_ratio = U8_MAX -
+                       (1 << (TCP_RMEM_TO_WIN_SCALE - win_scale));
+       }
  }

  /* Note: caller must be prepared to deal with negative returns */

