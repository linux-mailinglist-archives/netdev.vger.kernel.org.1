Return-Path: <netdev+bounces-155930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D6A04606
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824DF7A2CCC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451571F472B;
	Tue,  7 Jan 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qpmidVIa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1421F2C4C;
	Tue,  7 Jan 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267081; cv=none; b=cX+mZ0WCZa2yGSXJlheqjVm3PBrqIlTQPAKK+NFHzyAwC7D1GcDrwqoD6HwxIkEEzwn/w83ISM5dZRGmvNMLHwSIWkZVZ0Pvl81E1xNyD2my+Rz9+KARs05hbYBnuUQlurZj1OifLXDC0Ye4OvO/LkhOfvgN+I6r+I9IX3Ymh4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267081; c=relaxed/simple;
	bh=qm/z6FIaigJXqglH+QTX/mvImZoDQS82rMnH6FukACg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkQcG82OQ2Frq60RgGhIwO0/45njOqvOtrPjhalZBzMbzTROLxFECcne4CsjsdTqjKhtfH8eEqrTKaOGhjHNsXEMAZUOLN4y4t++wj+yQpfRjBGRfSRhYNShYk83zxzhFrKRHJyFEyMWGwlkOYHqrKJHpMPF8eyp5WDrtH681og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qpmidVIa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507FFHZ6027168;
	Tue, 7 Jan 2025 16:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1cT7F3TlNr3e59Gc8
	G7LZ0oWAeS7DLfnlZgtZCna+Ao=; b=qpmidVIaEgckWIAd8PSEq12vHWhjstKdr
	nJbVVnpZPfICAwueVbdDaQK87ee6nbOYBMaYV107sdhseZrWQjxNmBAdGT6nzSvj
	BmlZci/bOrfQt568lPcoo7Oz3+20voMKVknlAnAa1Um0yaFw7d2T5XsPoBZkWiNm
	NbMCoQhNZvV2T8LE2dOooKTt1IJKYx3hew/SYti7QZGoWNpIQhYdNSIJukBFHxDy
	fm/THxO4pK+MYS3PuqZjfMJ1xppCnVMbzZcOFjP0+W9mSq0XPgIBFsUVxsDk7OXy
	oE4QPvcWygbqXV9o+TvigMbNHX3AaawK01neeAxw72bHCb/SJNFLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrjb8f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507FIEkb006350;
	Tue, 7 Jan 2025 16:23:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrjb8f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507DRZ1C013571;
	Tue, 7 Jan 2025 16:23:55 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yganua9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507GNsj822872662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 16:23:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FAC458062;
	Tue,  7 Jan 2025 16:23:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0507A58064;
	Tue,  7 Jan 2025 16:23:54 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 16:23:53 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ninad@linux.ibm.com,
        ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] ARM: dts: aspeed: system1: Update LED gpio name
Date: Tue,  7 Jan 2025 10:23:44 -0600
Message-ID: <20250107162350.1281165-8-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107162350.1281165-1-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kNu9FyWAwFWKQW5pCqsbM5d-YLLU1Ck2
X-Proofpoint-ORIG-GUID: XEdwy5UYo1IHao2r_gzksErmfkekzQgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=787 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070133

Rename LEDs with meaningful names for easier identification.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index a37dfd359836..5e6824836213 100644
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


