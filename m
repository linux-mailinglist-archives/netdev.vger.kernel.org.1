Return-Path: <netdev+bounces-162130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6100A25D5C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C057A24D4
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5D2101B7;
	Mon,  3 Feb 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MGZQ0/ly"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708321018F;
	Mon,  3 Feb 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593913; cv=none; b=UynJHUv2TQ65wglDlXoMuV1IlUjIrDpQxA76o1n+81Kx5fQ3ecYQRs/IBBHomDm1o9DvrdvRlD77JIZ6NqW48lFbejpAz3H26nonZ2EQoeschhTGKMd/4xJZZ2ZTM2nIVibkcWQpEb3y7R9FpMLjKr9GTThU3gAKKr+2a9GYWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593913; c=relaxed/simple;
	bh=wXYRsc7oiNk+CkDcBkkmY/dw+fz9m01fJpgEi3hoqIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2DgE5Z8RUeo4CYkbG05l50TSyddO+9CjrrbQx4I55jmYNqiLqXT+JBj7bwlDQCSACLFPE3TJ5lS+4jh7vbyAblHgikVMKr3OZbg32bCZmJwIeoGmmmCp8dhOFLUfQTepILS74eMtAaGOP0HkbHeDIFTJLN4yH61XoXInbnuoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MGZQ0/ly; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135NtZe013315;
	Mon, 3 Feb 2025 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rk3OoVHAVYMfMoueI
	wWue8QGrekdaZap998SLuh1D5s=; b=MGZQ0/lyCPwVLqcIypxYvxAthNlyJkYnt
	1XL5ooPz15Ux1+jyaXoFXb6Oad6W8yjnZI7hjnt7itXQF2RPA3PPlbtwA810k9bJ
	dafK78daz+lkINB/oFHuEXtE+/zFH5IdIvkDqnN5wUltOrHdaRsKuLqaNLH26/Ds
	lbYsVOI6da5Eqomw0IsnOYk717urxKTl8YnVnFxS30S+e8rOQCKiijMH6s1pnLzG
	R65QeTKEBfhkTav0zRZVHZwxo3pG6HZqvEuoIfbJVvn8DwZzmCMKNRsuupZLvsE/
	2uij2qv7v8f+KLbkEPb3wzCAd+L30cKVCGcrP7wA35EeI3tHD0n2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7aj8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513EhAGi008691;
	Mon, 3 Feb 2025 14:44:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7aj7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513D1rlb005258;
	Mon, 3 Feb 2025 14:44:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jpjuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513EiWEB27263652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 14:44:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F37C5805F;
	Mon,  3 Feb 2025 14:44:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A917C5805D;
	Mon,  3 Feb 2025 14:44:31 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 14:44:31 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v7 6/9] ARM: dts: aspeed: system1: Update LED gpio name
Date: Mon,  3 Feb 2025 08:44:16 -0600
Message-ID: <20250203144422.269948-7-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203144422.269948-1-ninad@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s6AkBNWQUGQGLdVNbNPn5ha64YBgG4E2
X-Proofpoint-ORIG-GUID: C_kvxl_K3LsHVBvDebm_IR18K15Nx1BO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=757 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030106

Rename LEDs with meaningful names for easier identification.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index ca55a4fb6dff..1e0b1111ea9a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -116,63 +116,63 @@ vga_memory: region@bf000000 {
 	leds {
 		compatible = "gpio-leds";
 
-		led-0 {
+		led-bmc-ready {
 			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
 		};
 
-		led-1 {
+		led-bmc-hb {
 			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_HIGH>;
 		};
 
-		led-2 {
+		led-rear-enc-fault0 {
 			gpios = <&gpio0 ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
 		};
 
-		led-3 {
+		led-rear-enc-id0 {
 			gpios = <&gpio0 ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
 		};
 
-		led-4 {
+		led-fan0-fault {
 			gpios = <&pca3 5 GPIO_ACTIVE_LOW>;
 		};
 
-		led-5 {
+		led-fan1-fault {
 			gpios = <&pca3 6 GPIO_ACTIVE_LOW>;
 		};
 
-		led-6 {
+		led-fan2-fault {
 			gpios = <&pca3 7 GPIO_ACTIVE_LOW>;
 		};
 
-		led-7 {
+		led-fan3-fault {
 			gpios = <&pca3 8 GPIO_ACTIVE_LOW>;
 		};
 
-		led-8 {
+		led-fan4-fault {
 			gpios = <&pca3 9 GPIO_ACTIVE_LOW>;
 		};
 
-		led-9 {
+		led-fan5-fault {
 			gpios = <&pca3 10 GPIO_ACTIVE_LOW>;
 		};
 
-		led-a {
+		led-fan6-fault {
 			gpios = <&pca3 11 GPIO_ACTIVE_LOW>;
 		};
 
-		led-b {
+		led-nvmed0-fault {
 			gpios = <&pca4 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		led-c {
+		led-nvmed1-fault {
 			gpios = <&pca4 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		led-d {
+		led-nvmed2-fault {
 			gpios = <&pca4 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		led-e {
+		led-nvmed3-fault {
 			gpios = <&pca4 7 GPIO_ACTIVE_HIGH>;
 		};
 	};
@@ -368,14 +368,14 @@ &gpio0 {
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","bmc-ready",
+	/*L0-L7*/	"","","","","","","","led-bmc-ready",
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"pch-reset","","","","","flash-write-override","","",
 	/*O0-O7*/	"","","","","","","","",
-	/*P0-P7*/	"","","","","","","","bmc-hb",
+	/*P0-P7*/	"","","","","","","","led-bmc-hb",
 	/*Q0-Q7*/	"","","","","","","pch-ready","",
 	/*R0-R7*/	"","","","","","","","",
-	/*S0-S7*/	"","","","","","","rear-enc-fault0","rear-enc-id0",
+	/*S0-S7*/	"","","","","","","led-rear-enc-fault0","led-rear-enc-id0",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",
-- 
2.43.0


