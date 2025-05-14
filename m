Return-Path: <netdev+bounces-190378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A8AB696B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB313BF701
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D01202F65;
	Wed, 14 May 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wi8R6ldK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4347201032
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220545; cv=none; b=g/zl3Q3CmB/DWT8Qe2FsYkyGV4xEmZ7yy+zLB/O3rMwkewsNsOOQ3H/AQmfQOiDWY6DPv/dLyo00tuI64tjq4HgAfAbEpsn8wG0B60uA7Ot0RUVrufgL32WvLG1VPEOKuC1r4Y0uCsN6kRy+AilT78G0TdKrWd3i85zLYtseH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220545; c=relaxed/simple;
	bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVALuS7Q6uWqaIAw=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=GM+30JFLPfttMhRVBYc7qGaac0qBq0/94qt4SDJylAX1rEMfoWyN62OhyIRT1Px6x6sXyHlAJU9GfqTlEXkTzRyptg3Ky4FLtdwon7hI/oNIWyQeEyenlIrzeAO+su8vBCEeLZlvwZTyeS/gEukQnsehAzvkEI71erZgbYKHOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wi8R6ldK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAue3j020099
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:to; s=qcppdkim1; bh=DcvwkzNsryECdRx5e1rnB4ZRJBiQVA
	LuS7Q6uWqaIAw=; b=Wi8R6ldKfW85elKLG8rRiL+cRpYWvLr9rvUX4dlGBfZyLt
	DsFaatGm/+7uHuLcuyi3AqcWA5w9h/XgJyNqOaxsiJvdPtfj9+O+NkEl+0BIvzN8
	jIvSyyNd88NadAr8N/D/hqeNTfKNpXbfeN/q/QmRyzLMe1URe/4fvhrtzOJ4yDqJ
	09RgKWfwd42n26s4X/G9SUl9ZF+CdcyTtkPrpVsWh2wpQ1RIgpVSA2oSGJKO1PE4
	pGWpkCbdh3lKoYEVRGnu76AODbaDGuKpQzTgw9cYkXP/VpBnKwlPCTUQ0DJOK/Db
	rqUUsWMRCNA/DdRx+h70mjr2ioqv8vjm97MPhfHQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnjdwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:02:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EB2L69028509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:02:21 GMT
Received: from [10.216.24.30] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 May
 2025 04:02:20 -0700
Message-ID: <83c9e0c8-d64d-ac14-563d-39f0e30b3679@quicinc.com>
Date: Wed, 14 May 2025 16:32:17 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: <netdev@vger.kernel.org>
From: Harish Rachakonda <quic_rachakon@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ibF1khBSV-VgNMO_KXGwc9xIIjKbjLyx
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=6824783e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=s5jvgZ67dGcA:10 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=lXcb1Bjf0AM4FIPBDEIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ibF1khBSV-VgNMO_KXGwc9xIIjKbjLyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA5NyBTYWx0ZWRfX0slROOgkFDIA
 NdBy42QB4zisAtYYM6QkY/JWi9+Sh6r/7/4AgoIoXPJ9Bs/O9FfzA+hlG9e0w4ECwL1iE+dd29M
 WD247ENu81djRpX4AYKWR0+jKPlu7DaQhmfWB3qEVVmoJR4dEhf0H3YAVUxl/ZHXL16QlQLW0Qa
 ZGtSMMbv8EwGfQGv4nqTg82RE80HbjOBE/bVP1Va1zWDtpjPeHKGiHsaksD87ELJCDcXD1ikI3S
 0PFxRtyIoGrFGXvuB+mKCqN9BwF1E3JlwWcLG+pGMtbqHZQknB3rAVKWlBxRCersz5qE5QurQF2
 7hfsmnvh3Uvn7txET1NxgBvmByXNYm64GwhCZpWMz6XuTh7ndhM3DfX4cWQS8Y28G7sZJ/95xqC
 ipioK3vh9eI8kkRazOg10cW+3dR6zeO2qVIAv4qOM3o2ncfGLu8LFr5tTKX2FmdtZePk5oGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=274 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1011 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140097

unsubscribe netdev

