Return-Path: <netdev+bounces-96457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E78C5FD1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C11F21582
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 04:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83211E4B1;
	Wed, 15 May 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VRsz+pIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BE3A1AC
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748427; cv=none; b=ebz3QvWbzOqurNxr9WP/7SgU6CJXgZ098fs5VwmJArVPPSg3MNste77Z7gbhR0ocFaCvlAHxSp81g2bhRrPK44bxUJevFFnOjL8/NxE8YS/MjpCW2gdQk8LQJb7tMHrZuSiuMkiruqykIOfJ4vbf4rzyGzlEAZz1UsXzU58Tz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748427; c=relaxed/simple;
	bh=xBCO48F4VlEonIidmAAYgiXO6TO9qNUwGnzwrkOyBOw=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=UeWJOTgR5ju5HnELJSq78xszA8GSiDd5cWInzdXaH1UnozSp2KdbYvc3zmwpar7MNUf/IXEtQOJxHSIRxfOW9x083Fh0SV0ozsg8zh7rTDzTzWL+2du2jF+hgbAKxTGYYZtw0D5/Ej1eBfmCVCH7pdVI2nflHB1IKHcVRtguF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VRsz+pIZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F0DJgL022689;
	Wed, 15 May 2024 04:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=RHr/LSm25AZ44tYtvlVb
	N5CoKUPTVGevI3xiz1+4y8Q=; b=VRsz+pIZxNBN8P5eWq2feeGV1czgmK/Rf3o1
	d3ZUYjPNLrxi2fU7xTEG5IQqsNHiby++s2mVEmuk2bsEr3w6huqJBc6xBMboaLsI
	7HTQIwKv3LW5gvvfklNEVbgevKIOuKylExBuHYNgPnB4DMLMvcNpyfDdB6UpW/tc
	mlUq8StBQf9XV2zA0jhqrtS2Nv3bKO1/MWrmsoMguwJ8ZmlKBaXjXAiBxwQwxI6Y
	G/s8Jm79v0qrMfSgxG+2meysTceYhnTJc6vdfDPrl4qz5DOweFTs8V4OYZDRgm6l
	/YDvnmiaHwyElwkxBkaPNl4iw45JojcFCtMvDWaGa1SOIust7Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y47eg9x2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 04:46:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44F4kuLY012020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 04:46:56 GMT
Received: from [10.110.99.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 21:46:55 -0700
Message-ID: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
Date: Tue, 14 May 2024 22:46:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <edumazet@google.com>, <soheil@google.com>, <ncardwell@google.com>,
        <yyd@google.com>, <ycheng@google.com>
CC: <quic_stranche@quicinc.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Subject: Potential impact of commit dfa2f0483360 ("tcp: get rid of
 sysctl_tcp_adv_win_scale")
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v4dpMRLU9Lr9QuAkYvshVIRpLaTXBTIU
X-Proofpoint-ORIG-GUID: v4dpMRLU9Lr9QuAkYvshVIRpLaTXBTIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_16,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=710 lowpriorityscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150031

We recently noticed that a device running a 6.6.17 kernel (A) was having 
a slower single stream download speed compared to a device running 
6.1.57 kernel (B). The test here is over mobile radio with iperf3 with 
window size 4M from a third party server.

The radio conditions are the same between the devices so that maximum 
achievable download speed will be the same. Both devices have the same 
tcp_rmem values.

We captured tcpdump at the device and the main difference was that the 
receiver window advertised in the ACKs was going upto a maximum of ~2M 
in A vs ~6M in B. By explicitly increasing the window size in iperf3 in 
A, the download speed of A was able to match that of B which suggests 
that the RTT was high and needed a larger window size to achieve the 
download speed. We do not have tcp_shrink_window enabled.

We noticed that there were some changes to window size done in commit 
dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"). After 
reverting this commit in A, we observed that the receiver window 
advertised in ACKs matches B.

We logged free_space, allowed_space and full_space in 
__tcp_select_window() in both devices and observed that the 
allowed_space was 6MB+ on both devices, however the full_space was 
smaller in A as the tp->window_clamp was smaller. The free_space was 
smaller in A compared to B which I believe is an expected consequence of 
the commit.

Could you please advise on how we need to handle this. We are open to 
trying out any debug patches.

