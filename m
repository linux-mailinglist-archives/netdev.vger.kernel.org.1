Return-Path: <netdev+bounces-236377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F8C3B393
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A81D4FF53F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A1332EAB;
	Thu,  6 Nov 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhxd9tg3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWLftNQS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC31332911
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435708; cv=none; b=mL2K61q6SN2pprccaNFnjoUWc8pIZov4zy8J3i4kglvD8TICk8BtyhKzTF1LaggIN78lO3SLXcg0iHNt5P+fyZxNQLg6LXew6MQRECOrp3YPmauJlXRLLLuNXIlbUN9DeoTdjG+S6iyiyqBajNRhRQo+LHZsC6I0fwos9EuudTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435708; c=relaxed/simple;
	bh=uTPUynvEcw6KdyQKFRCWP++7wpSfzU3ZtWnOxsXH5Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KS8M/IA1Yh46IFGyA0rqpZ/HX7/t/P9SX0vdPQjmvBgyw9cEMcgFqK41Y9VcR6xkNwbTeVbuxTom25D8M4I+67cLMpzxloByggT1IkhpB05pxVGq3ZvZ/4umIGa3Br8QbxmKMHZKhNmbWAQOX5HhKCU2hZ5jqRxGlN0EYaI1I0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhxd9tg3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWLftNQS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6Biskk4018554
	for <netdev@vger.kernel.org>; Thu, 6 Nov 2025 13:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K6Uln7viSoIgV4FeL3cGSMSD52CLesxi81fBrMA1F2g=; b=hhxd9tg3e0RMQImA
	13EGTQTYI0cDpPbFrOBvP9yjdtqTTkfZeoDP0BtemuHcNPEU1yzJrzbor8JwT0u8
	G+mmVwiLUN1i1T87i33NnEe4ITELZll1fru74+zbGhS9hvZX3m8yIh1Q2vTL8cWX
	r4/iJ4GL0x1IGXaeNMKov+/ppyYFAmg3l9Wi8PDxPM3CtT+PtYQ7WgX9fLkf2c/w
	p4iW6kXUdnNG0VP/BqN+7/5URdsAnevwDeM0h32H48ga9tv5UgZ/+AL4ESAdVHJn
	jRBW8qbOxI7ehcPcQxlLMHDMX6ZNpcTPW71DijnMmdpBOgmsxq1UOS0PFnLbj4D4
	DYRBxw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u2ur854-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 13:28:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2955555f73dso10118935ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762435706; x=1763040506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Uln7viSoIgV4FeL3cGSMSD52CLesxi81fBrMA1F2g=;
        b=aWLftNQS281Can3DNyUlKbIq0v4PEfvv2JE2c4HD50F0MHTVE8Il2k7F+ZGv/3AkQU
         o6MlnSOHO8wXM6FqE40sZqso6tydGUncOfRShLgzjQ7L2UzHsl4JmdKNWNRYjxl1UDNQ
         o+6b8+Q3IRmoEZ+NkCMtjYA3duQe9dA5tHqVluZTdR57FNdO4y2CuwAtXmAO2V5vA+LN
         qWVBsRIydPvtq+eJbL8H0JIVoyppMiStSM/jrlI4Sbv/QMWToheh7VV5fWsreJBYzKDo
         aEXvcDSEl3KNwvyVfjPXWFhESObfyg6co5bn02FfPIBHGrmoXNwDuljSGfEPIX+okGK2
         vMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435706; x=1763040506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Uln7viSoIgV4FeL3cGSMSD52CLesxi81fBrMA1F2g=;
        b=XI0Jh+pTxTUj9ooLc6de0Bn8rj5/fprzaq6YIz99oJVE2q0/20JP35CL1ETVeI68K1
         shpdImPdYkryJZnrbIihzyNw0wugR5LYEaMgh3vOJZjniLMG22jlhJ9Wo+GqhJ/yFww0
         gUHA8ANQ+MOBypZPvvUbozJOh1s6+fAelmTmKdIMdSpccDV1tHv1DD2GcFnWE8vO9n+R
         5UgwZx8rKM6mY92pJpO1hZWKMlWEhzXYU9vB4VCQKpGiDC394eMIKbjsNjB+0A1ocZW+
         KIJ6Rw8e08mv7cjfEcZ4XnzAKDah5Q/7rnKD1xKDvf4Kq9GiQlJTVS0Canovl1QBDAqn
         GsOw==
X-Gm-Message-State: AOJu0YxwOJtmttreWm5cRtmXDLLT7hOqFqG4bbAEot24qfa2PnBOLyrx
	CawHlv9XXmns7oFDXRPdfH9KRYSDsm3x4kou5SZqNVXMcYOGNno5M2GX8xOAQ7UC/EFaotQVhnz
	OKtqYGiLS40L5QTyADw2l+Ix1u/uwShbrLkJFbfuneuuwjuhMmXubl9Iy3LE=
X-Gm-Gg: ASbGnctsR1lGOyO3O2Zr4F8rTmQjSimm2ojE/scHBDEkfWvOBFJJQfR/h+L4l4if0U9
	ekKIYrd7pPfatc4Lkl43zE5MH4A4W3RwMrK73I52fIWgsizaeMydcs9zpDFrkPSbwWOq2+PebwS
	q9lWo5hlFZAAtk42/vPftVTL8lVRLzh7LUUYkt0BAULrqTNW825Nj6TpIKWzZ2GqoaHWaihjPqx
	HiZ5dcIT1Al1xbNSnvOvrcmqOqRBbZyXeQkRWiTwMR0L4IxcD60mp/zQBBt8Exyv2NAewZd7u7P
	v9/J+xtP4Km7pFazW09Yw+wH6DCH1jqiLCLiuLGdOWia7W4jbsjJcBVnH/gOAjoZYYzGIRi7I25
	R3snYnFRkwryaYSEh51Gj5B0UNg==
X-Received: by 2002:a17:903:b90:b0:295:6d30:e26f with SMTP id d9443c01a7336-2962ad1aea4mr84378645ad.22.1762435705634;
        Thu, 06 Nov 2025 05:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH5wlKyQgfPrvVMcvI9YDewl2pp4uhag48hOeK/UPGzA9fBI7LtxtQdulJ/CTlS0XS4PBYQA==
X-Received: by 2002:a17:903:b90:b0:295:6d30:e26f with SMTP id d9443c01a7336-2962ad1aea4mr84378175ad.22.1762435705074;
        Thu, 06 Nov 2025 05:28:25 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm28770225ad.94.2025.11.06.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:28:24 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Date: Thu, 06 Nov 2025 18:58:10 +0530
Subject: [PATCH v5 3/3] bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and
 IP_ETH1 channels for QDU100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vdev_next-20251106_eth-v5-3-bbc0f7ff3a68@quicinc.com>
References: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
In-Reply-To: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762435691; l=1454;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=hVsENnFNyiwEUKV4o8qHH64MADCXodAIn37DvsarU7A=;
 b=iKzNM9tlyU2l3rDwYcTOubaB8VZjoj1abicD2JDlL/PTPVLIcfYtHVo0Ll6PmqkhhuNna5E2n
 VpnZexmrvb3C1H0wYtVN3s+NfWlsVIc8AAo0Eymiibx90C7JMj+3/qq
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=Wv4m8Nfv c=1 sm=1 tr=0 ts=690ca27a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Vo5YzJSDI_NEo2NC7oIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwNyBTYWx0ZWRfX9rgN+NTciks1
 DeBQbXlyzFPRixN7m2C5zCPcfGvPt6Q66bOmny4sJFmlPeWhNCHdwjajSdrqzptMzbTgtPjks5f
 PKzxX44FsS7PVJkbx996JaXtDxtjUgK1Jlgkj5Vr4Y7tq9KPZFxSaU0JlZONtu/Eb4W7MnH604v
 1YLuCsJ+khZIr/9xsaYQhGKanKU6hqkNQX/w3X7sUXUo2/kpHdnSZMxAlOvZEHtp8wt4yT8dM9E
 Es5d0OaDAXfbzviBcgz+TVQdSMYeY/5RW9qVETbz7Ydw0HbqNfZH9Xqw6x/KYfV1Mwpyk7nU2fP
 E+AKVULrEPML5ZIKD6cJqXsG6w3aPh3zNQidV/oJBKdOVbsP8Odr+2729dhTTxyRMkLuO//qm4l
 kR8cvKFhnYGaxV/0tZUu2c5kCFdWVg==
X-Proofpoint-GUID: 08ie6_3xcF_deLMXpT-BnFmIw4HwabyM
X-Proofpoint-ORIG-GUID: 08ie6_3xcF_deLMXpT-BnFmIw4HwabyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060107

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for M-plane, NETCONF and
S-plane interface for QDU100.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 3d8c9729fcfc57f38315d0386e2d2bdf8b7a8e1d..eace36054af9d04ac24538c8b9beeaa37c15b84d 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -269,6 +269,13 @@ static const struct mhi_channel_config mhi_qcom_qdu100_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(41, "MHI_PHC", 32, 4),
 	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 256, 5),
 	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 256, 5),
+	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_UL(50, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_DL(51, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_UL(52, "IP_ETH1", 256, 8),
+	MHI_CHANNEL_CONFIG_DL(53, "IP_ETH1", 256, 8),
+
 };
 
 static struct mhi_event_config mhi_qcom_qdu100_events[] = {
@@ -284,6 +291,7 @@ static struct mhi_event_config mhi_qcom_qdu100_events[] = {
 	MHI_EVENT_CONFIG_SW_DATA(5, 512),
 	MHI_EVENT_CONFIG_SW_DATA(6, 512),
 	MHI_EVENT_CONFIG_SW_DATA(7, 512),
+	MHI_EVENT_CONFIG_SW_DATA(8, 512),
 };
 
 static const struct mhi_controller_config mhi_qcom_qdu100_config = {

-- 
2.34.1


