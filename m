Return-Path: <netdev+bounces-113599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D693F41C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54F11F22727
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B863146015;
	Mon, 29 Jul 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hRB02+o5"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD0145B25;
	Mon, 29 Jul 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252778; cv=none; b=fc6cYe3HWAvAazfiXtT7hIG8OhG2rV3jeVYDflEKEOb07SoErAys0Fh7lXwI/J5uulUS7+bVkzHPmmtYkJNfpTY1/+k/q/M5sWJJFXGJ9+wSGfmaPBR+hZyrnHfAjT7xvj8oqsfvoCqkjs9RlKQO1df9UkyAvgAFL/1ZD61sddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252778; c=relaxed/simple;
	bh=ZoXbVolpWhAtG8tLxeifVQnK/kpJO+4rhLbRQC8z4Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijlvBL7ugEiBoQ42NiZVvXrQTJpHWPB7guj9v4obN08CjVsUorzZzhyLv22JKw7oJP2IzWA4doblfQyLcZ1AqVJ6Ls49tPH+uXSbdQx2qDsuzf0+TuAIlY91FhW/6euiF22NVuC1UVxywYBQdTzKccE25fGP3OO7+NK3HNVzP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hRB02+o5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWccp061595;
	Mon, 29 Jul 2024 06:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252758;
	bh=zNQUWNO1O+y+zU26vfY0vvYw+WPjnZovMlObUq3Vups=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hRB02+o52/8DhYvRCaPS6+RLGFwt3PNxQhbC46JdIaKL3InUaSPy0qKZJTvbi9Nzk
	 7RLcLkISm3gk+K1YXPuQfO47XVpb/2jXlwj6+FBMddGyMmZxnhLs4F46ifx1WxIv5j
	 AFDKTMqrCmnfUVdxwd3tf5HhbDMBVLEJIrFFceCE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWcBt115463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:38 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWcva069134;
	Mon, 29 Jul 2024 06:32:38 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWbSM013202;
	Mon, 29 Jul 2024 06:32:37 -0500
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
Subject: [DO NOT MERGE][PATCH v4 4/6] arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
Date: Mon, 29 Jul 2024 17:02:24 +0530
Message-ID: <20240729113226.2905928-5-danishanwar@ti.com>
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

Add ti,pa-stats phandles to AM65x device trees. This is a phandle to
PA_STATS syscon regmap and will be used to dump IET related statistics
for ICSSG Driver

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 1 +
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
index 0a6e75265ba9..66bb0b913d49 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
@@ -41,6 +41,7 @@ icssg2_eth: icssg2-eth {
 
 		ti,mii-g-rt = <&icssg2_mii_g_rt>;
 		ti,mii-rt = <&icssg2_mii_rt>;
+		ti,pa-stats = <&icssg2_pa_stats>;
 		ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
 
 		interrupt-parent = <&icssg2_intc>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 8bdb87fcbde0..e548f1c7991a 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -42,6 +42,7 @@ icssg0_eth: icssg0-eth {
 
 		ti,mii-g-rt = <&icssg0_mii_g_rt>;
 		ti,mii-rt = <&icssg0_mii_rt>;
+		ti,pa-stats = <&icssg0_pa_stats>;
 		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
 
 		interrupt-parent = <&icssg0_intc>;
@@ -110,6 +111,7 @@ icssg1_eth: icssg1-eth {
 
 		ti,mii-g-rt = <&icssg1_mii_g_rt>;
 		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,pa-stats = <&icssg1_pa_stats>;
 		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
 
 		interrupt-parent = <&icssg1_intc>;
-- 
2.34.1


