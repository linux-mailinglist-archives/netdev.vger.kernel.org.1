Return-Path: <netdev+bounces-113600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1993F41F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51A11C21F2A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E39146A8C;
	Mon, 29 Jul 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pVoHHJWT"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E501465A9;
	Mon, 29 Jul 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252780; cv=none; b=dSIPsbo1turRIdCSPFRiLCWwUvSUFn8Es0cdesRN2xcsf5l3f2uzj5ZK/jEeXuN8Xto48BVNeCDzmHJvp8PmEpqZQh0asmplxBv2dztA7Xu5ZkQTMxuGgLGx7OS6DEQOtrjPyYRkTvxOAAe39nYtccO580Wi5TpW3lFaUOpvHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252780; c=relaxed/simple;
	bh=oNCTCmo3pj1dyOPcTMGqXKZq7QlnMKUwZu/U/b8VBo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRf3EruiU/ajzGDidtwNNDe+TtC3rYKEdiuRfR7mxhmonZjlk7gk5Kl1RiOGEEYKlZFkENf+BtKD80TZ3EKVEHKm99/6Hwx1CJRuZUVq5TCsvJPTTaPn+gznM5k7CFwfMzRvPVdNBP42kpSTf8hTL8G9om7zRCy7ikRBKVktvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pVoHHJWT; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWaOu074666;
	Mon, 29 Jul 2024 06:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252756;
	bh=SI7swaaG3GhebTcYRdpPTH+MrZjEiTmUuTjRNjggeDs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pVoHHJWTpEfMolwhbUJH9FfIgGKOCA8WZHBz5RYx6Hhns3GZ7h9U6IVEUquPXP28h
	 UfSVry0xhyd8WmeVXja9M/VPeMSAex0OQEpVrpPDZ9ifO5cyEyai/DKN3/SWgfIb6Y
	 bH6fCXnE/DFWiPWDL5T3ywT/aI5FpP1FvEHy2cxA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWajh092751
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:36 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWavA069108;
	Mon, 29 Jul 2024 06:32:36 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWZs7013197;
	Mon, 29 Jul 2024 06:32:35 -0500
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
Subject: [DO NOT MERGE][PATCH v4 3/6] arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
Date: Mon, 29 Jul 2024 17:02:23 +0530
Message-ID: <20240729113226.2905928-4-danishanwar@ti.com>
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

Add pa-stats nodes to k3-am65-main.dtsi for all ICSSG instances.
This is needed to dump IET related statistics for ICSSG Driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1af3dedde1f6..e681b74db235 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1159,6 +1159,11 @@ icssg0_mii_g_rt: mii-g-rt@33000 {
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
@@ -1325,6 +1330,11 @@ icssg1_mii_g_rt: mii-g-rt@33000 {
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
@@ -1491,6 +1501,11 @@ icssg2_mii_g_rt: mii-g-rt@33000 {
 			reg = <0x33000 0x1000>;
 		};
 
+		icssg2_pa_stats: pa-stats@2c000 {
+			compatible = "ti,pruss-pa-st", "syscon";
+			reg = <0x2c000 0x1000>;
+		};
+
 		icssg2_intc: interrupt-controller@20000 {
 			compatible = "ti,icssg-intc";
 			reg = <0x20000 0x2000>;
-- 
2.34.1


