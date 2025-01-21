Return-Path: <netdev+bounces-159993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917BCA17A5F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57E97A19AA
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F21BFE00;
	Tue, 21 Jan 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fyo3SlLv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518D166307
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452385; cv=none; b=qAAjYbPzZU91ojSxpUgNQdFolYFITu5y7jE3/PXMdysanZwlzf1bO5w4ZuxaaxzIUAwjLk90CJx+7PWFhquZrV9Sxm0GGa9lih3ctyQQOEnSnH+U9Fgh7AQDaFCoBicPZLydheoN0KDycqFx6ZVkJqJyQYQFKkgtZuhArg4qETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452385; c=relaxed/simple;
	bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVALuS7Q6uWqaIAw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CSrvsD5AFZTWCVvwHe6iIw5TGDOESHpnir+Gt6XsVJTU/y++a6EGa1QuTfB4vJHBRzr7dt77oM5q0Yd83GI6qKmRbV+hmDiGSP8FizsDMs544UXoy+KPVm81whc9jr0A5gipL2l0jc6PgrpjZXvy9H7ZjktktVweAkZFlNm9/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fyo3SlLv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8Yii3021044
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DcvwkzNsryECdRx5e1rnB4
	ZRJBiQVALuS7Q6uWqaIAw=; b=fyo3SlLv/ITJ/YGhSTOEwJvfiD08nPPYn3dsIb
	CcfzwXYsxrCHCJs15jkyXjQ36LIlf0qntyoV4aFRZR3m4feVVJoTiJqwqECWkD9v
	rHqReNz07LiAs6KvvXiHbm96VY3hWwFlwMGQ2u6OaDS+VIH0qvlywkiUQNfrtnGb
	82QX/pBvZ6Wt1ZxcmTi98REYLOxdAKPufMrieBMt6s98pojrA1RnyMBPtQUQUcpb
	xaBfAIdZQcpcCJo9xxHjXvU4xMDHpMALe+sZf4kxCHy2jAp387vEf42XCGI4dXO1
	pjJxUMoHxmpvF0KJpnThr3Qu4IeMvWhwX0XWJCdW2jaI/yEw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a7nt8dn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:39:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L9dg1H028933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:39:42 GMT
Received: from [10.216.56.155] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 01:39:41 -0800
Message-ID: <029c8b0f-6d15-4511-9c95-6cb51ac039b4@quicinc.com>
Date: Tue, 21 Jan 2025 15:09:38 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <netdev@vger.kernel.org>
Content-Language: en-US
From: Yuvarani V <quic_yuvarani@quicinc.com>
Subject: unsubscribe netdev
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NSTp2uPuUFmqkyBqggThYq2S2jNPzwij
X-Proofpoint-GUID: NSTp2uPuUFmqkyBqggThYq2S2jNPzwij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=338
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210079

unsubscribe netdev

