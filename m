Return-Path: <netdev+bounces-104631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493890DA96
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191CC282EAC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525F143C4D;
	Tue, 18 Jun 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z7rrCZMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BA13F016;
	Tue, 18 Jun 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731593; cv=none; b=NRYE6svK0nOspp6JJbBVzKmDCQCDERW1g07K6MGosXiHG8fy9OHQ9zE4NQhlahpwQRomEA2VHfadjJZ7VJItpnZXhCkLhxk2bHe284eK6exmGhG+/Qt/ddr77hy7IKfO3UtNComt71cfrGlJOkniyfhl5hf/HvtrS0S1Y18E9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731593; c=relaxed/simple;
	bh=tFb14QZSj03mGSULrT+zr8ST4fLQcL4rRqJPIDLg/TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rjYz/YXOMPSLkNUCctvgq5WgMD/tgQwmyDmVeBzxGZNhnXl6rDhANol8+h8SpEnlvwrybkdgtwbzFWpWVw8qn7yLtYVlsVU1rNcLWJIby0L6FR/2M2POukj65caAGTw23zBGM6BWUzQ3sf8iO55U3BzhcAQsd35qycfYgszjhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z7rrCZMQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IG6mQf010117;
	Tue, 18 Jun 2024 17:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5uYQm68wObYLkcMKXj05LB
	1j/UaqS+dBcVXsaPXz1jA=; b=Z7rrCZMQViXISVHTzUzBtpvKPSTdzh+1bLnX6c
	4rBk3X1pRh8+Dy4jCN4LXRpzWyEILrutRWFXjX3XBj82VQtZihAjtenJwMCMCS7I
	uGf4QnLM6haIdC6+Ksbr2MqJ+h5cH2wAk+IZfnMQu+zItuKHZuTxFxD5gQQkavdU
	8LqMuW8oCOOewt+U1v2yFJPIqUf8vMA1eVMskrEKSf2TlKgWZf/PhOebyM3hMF5O
	9vzCKrksFsaXAfO3x521YrKsrEEfkvAMQcoLz1r5BgimtihAeZUckOJJNMeDJNdU
	l1rDwe0+Fuh+rPnFPxN9pgKEtvxcn65fNONjr//Zj6T8pWMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu6wa9e0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 17:26:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IHQMXx025520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 17:26:22 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 10:26:21 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 18 Jun 2024 10:26:20 -0700
Subject: [PATCH net-next] net: amd: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-md-m68k-drivers-net-ethernet-amd-v1-1-50ee7a9ad50e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADvDcWYC/x2NwQrDIBBEfyXsuQsmDcH0V0oPJq51abVlNUEI+
 fdqb/OYYd4BiYQpwa07QGjnxJ9Yob90sHoTn4RsK8OghlFNvcZgMUz6hVZ4J0kYKSNlT9KCqa1
 S+urmxc6jG6HefIUcl7/iDm0UqWR41GYxiXARE1ffFG+OW8FgUiaB8/wB7zOxKZsAAAA=
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Os99yBkyoUukyE54xR3teedXi1bL4xjM
X-Proofpoint-ORIG-GUID: Os99yBkyoUukyE54xR3teedXi1bL4xjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 mlxlogscore=966 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180129

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/a2065.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/ariadne.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/atarilance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/hplance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/7990.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/mvme147.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/sun3lance.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes drivers/net/ethernet/amd/lance.c which, although it did
not produce a warning with the m68k allmodconfig configuration, may
cause this warning with other configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/ethernet/amd/7990.c       | 1 +
 drivers/net/ethernet/amd/a2065.c      | 1 +
 drivers/net/ethernet/amd/ariadne.c    | 1 +
 drivers/net/ethernet/amd/atarilance.c | 1 +
 drivers/net/ethernet/amd/hplance.c    | 1 +
 drivers/net/ethernet/amd/lance.c      | 1 +
 drivers/net/ethernet/amd/mvme147.c    | 1 +
 drivers/net/ethernet/amd/sun3lance.c  | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/amd/7990.c b/drivers/net/ethernet/amd/7990.c
index ef512cf89abf..27792a52b6cf 100644
--- a/drivers/net/ethernet/amd/7990.c
+++ b/drivers/net/ethernet/amd/7990.c
@@ -667,4 +667,5 @@ void lance_poll(struct net_device *dev)
 EXPORT_SYMBOL_GPL(lance_poll);
 #endif
 
+MODULE_DESCRIPTION("LANCE Ethernet IC generic routines");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/a2065.c b/drivers/net/ethernet/amd/a2065.c
index 68983b717145..1ca26a8c40eb 100644
--- a/drivers/net/ethernet/amd/a2065.c
+++ b/drivers/net/ethernet/amd/a2065.c
@@ -781,4 +781,5 @@ static void __exit a2065_cleanup_module(void)
 module_init(a2065_init_module);
 module_exit(a2065_cleanup_module);
 
+MODULE_DESCRIPTION("Commodore A2065 Ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/ariadne.c b/drivers/net/ethernet/amd/ariadne.c
index 38153e633231..fa201da567ed 100644
--- a/drivers/net/ethernet/amd/ariadne.c
+++ b/drivers/net/ethernet/amd/ariadne.c
@@ -790,4 +790,5 @@ static void __exit ariadne_cleanup_module(void)
 module_init(ariadne_init_module);
 module_exit(ariadne_cleanup_module);
 
+MODULE_DESCRIPTION("Ariadne Ethernet Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/atarilance.c b/drivers/net/ethernet/amd/atarilance.c
index 751454d305c6..8c8cc7d0f42d 100644
--- a/drivers/net/ethernet/amd/atarilance.c
+++ b/drivers/net/ethernet/amd/atarilance.c
@@ -79,6 +79,7 @@ static int lance_debug = 1;
 #endif
 module_param(lance_debug, int, 0);
 MODULE_PARM_DESC(lance_debug, "atarilance debug level (0-3)");
+MODULE_DESCRIPTION("Atari LANCE Ethernet driver");
 MODULE_LICENSE("GPL");
 
 /* Print debug messages on probing? */
diff --git a/drivers/net/ethernet/amd/hplance.c b/drivers/net/ethernet/amd/hplance.c
index 055fda11c572..df42294530cb 100644
--- a/drivers/net/ethernet/amd/hplance.c
+++ b/drivers/net/ethernet/amd/hplance.c
@@ -234,4 +234,5 @@ static void __exit hplance_cleanup_module(void)
 module_init(hplance_init_module);
 module_exit(hplance_cleanup_module);
 
+MODULE_DESCRIPTION("HP300 on-board LANCE Ethernet driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/lance.c b/drivers/net/ethernet/amd/lance.c
index 6cf38180cc01..b1e6620ad41d 100644
--- a/drivers/net/ethernet/amd/lance.c
+++ b/drivers/net/ethernet/amd/lance.c
@@ -385,6 +385,7 @@ static void __exit lance_cleanup_module(void)
 }
 module_exit(lance_cleanup_module);
 #endif /* MODULE */
+MODULE_DESCRIPTION("AMD LANCE/PCnet Ethernet driver");
 MODULE_LICENSE("GPL");
 
 
diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index 410c7b67eba4..c156566c0906 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -178,6 +178,7 @@ static int m147lance_close(struct net_device *dev)
 	return 0;
 }
 
+MODULE_DESCRIPTION("MVME147 LANCE Ethernet driver");
 MODULE_LICENSE("GPL");
 
 static struct net_device *dev_mvme147_lance;
diff --git a/drivers/net/ethernet/amd/sun3lance.c b/drivers/net/ethernet/amd/sun3lance.c
index 246f34c43765..c60df4a21158 100644
--- a/drivers/net/ethernet/amd/sun3lance.c
+++ b/drivers/net/ethernet/amd/sun3lance.c
@@ -74,6 +74,7 @@ static int lance_debug = 1;
 #endif
 module_param(lance_debug, int, 0);
 MODULE_PARM_DESC(lance_debug, "SUN3 Lance debug level (0-3)");
+MODULE_DESCRIPTION("Sun3/Sun3x on-board LANCE Ethernet driver");
 MODULE_LICENSE("GPL");
 
 #define	DPRINTK(n,a) \

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-md-m68k-drivers-net-ethernet-amd-0083f9bd94f4


