Return-Path: <netdev+bounces-113604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880A693F42B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF11F22BDB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BE1487E3;
	Mon, 29 Jul 2024 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VTs7cPRi"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB5145B25;
	Mon, 29 Jul 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252783; cv=none; b=fT6oD89I8J5NSh5rEg1gNMN6XwSkveVG0T1m2sX3NcIBVOAGbfKmiclIoOnX8kaGEEaidl9xi3OxZNcrQXJh+wna/XLpEuBxPbn5dnm8CB9tUnzmRmFdXL96QKIv9OKnJREN/k7z/mCaU4hN8WUP5wVJNrXE3GcnmIDenyA95sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252783; c=relaxed/simple;
	bh=EL/JiyFvNzIGQ8/8QcLgCfXK5gseSFmQrthgPATwWbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTDxcNZm9TdGOawFd/O4OSryz0+jGTNF7SKtP7+yxRZVac9Chqm5SylCbtvxB3Nb/7Edbb+HTrhmK/0CspmIu/TWvRRPuR4UwXsqOOrynDF0vrY3Z+MZBGL3qVssTJDKOjFMgtUYgcMkvJ1yYvz/0Qeg+1I/LSwJ/jJDNwg6U2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VTs7cPRi; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWeiG026433;
	Mon, 29 Jul 2024 06:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252760;
	bh=d4zZIJ/gkQccbtOD7Sjovr8yOnWQC2S7b6K7C9dFyDQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VTs7cPRiYmejuGXipsGGsvSjuvbWoCLbnPNmORdezdeIRbXNu1e+Dn2Uedm7pYRIx
	 m1kgfgsu+U4lK/EDiRzjJdtvGhIVSLNBErx9E1GyFxuDNAkWdAc9kwGjsDzGQYGJb7
	 v3puKL9O3ywKpo4Rts0nGYuMH3DD37qpe72dXxfQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWe27092761
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:40 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:40 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWeCW012982;
	Mon, 29 Jul 2024 06:32:40 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWdu7032495;
	Mon, 29 Jul 2024 06:32:39 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>
Subject: [DO NOT MERGE][PATCH v4 5/6] arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
Date: Mon, 29 Jul 2024 17:02:25 +0530
Message-ID: <20240729113226.2905928-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729113226.2905928-1-danishanwar@ti.com>
References: <20240729113226.2905928-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add pa-stats nodes to k3-am64-main.dtsi for all ICSSG instances.
This is needed to dump IET related statistics for ICSSG Driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f8370dd03350..090bfdc5f20c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1257,6 +1257,11 @@ icssg0_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg0_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg0_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
@@ -1422,6 +1427,11 @@ icssg1_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg1_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg1_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
-- 
2.34.1


