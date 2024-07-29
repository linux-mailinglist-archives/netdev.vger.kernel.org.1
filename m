Return-Path: <netdev+bounces-113603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F219693F429
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA6B22939
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515061482EE;
	Mon, 29 Jul 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E7wEyMcF"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2073146D6B;
	Mon, 29 Jul 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252782; cv=none; b=J3NQmNTjidOm1qMaf4PjWNX/pgfW52bdP+5ux2VkQVnmJeriZLiUjdXVA6lTQ96TYrNo/V4GGrIV27XdKMo5trx7JpRBg5rPOPSieEmwk6JhOLkpcjftXKesU8jlfSvyVwhcktLGIHMr6MBw/ZuB9q2lPLQ8CiZlKj/jEwIPTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252782; c=relaxed/simple;
	bh=VUVL+pBOlRNFKLCasXumlwcrM2yjLIkQwO1jaUjoHHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyNfMxp4Na4zFNSDc3SIbd4Eg0WtAaLNYl6M0cK0hgxFJpQy/wsBwAfTuoOQ7yNKRTv3/nFWX91LMWN+OYxcxyCy5l9vBiacoRZUmbsnN63KNVaqOkLFi5GqoigrVzhsQE6zqXm0eiTQ6VEgQOAL0Qtu19HornfOagipnmTpNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E7wEyMcF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWgpu061615;
	Mon, 29 Jul 2024 06:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252762;
	bh=l7rSCrodg7i8FJV7a52lEBrfKfZ7Sdg41Z9KHQmW7Vc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E7wEyMcFSmeVCXA02NYftRnR9xuwSrsTvjiGaqRl01ADL7IGILFTR+ndQ4JElb+Ad
	 F15GoZAk/R/hhjXNFPzOf45mPRn29oooy4etudhVJBOvXPwinnYruZJRxcKzZlyD04
	 /Tme65K33lYqGphNDSFj9fFHt0tvVpGeHosXkoUY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWg61007642
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:42 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWg5H013024;
	Mon, 29 Jul 2024 06:32:42 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWfjY032500;
	Mon, 29 Jul 2024 06:32:42 -0500
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
Subject: [DO NOT MERGE][PATCH v4 6/6] arm64: dts: ti: k3-am64: Add ti,pa-stats property
Date: Mon, 29 Jul 2024 17:02:26 +0530
Message-ID: <20240729113226.2905928-7-danishanwar@ti.com>
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

Add ti,pa-stats phandles to k3-am64x-evm.dts. This is a phandle to
PA_STATS syscon regmap and will be used to dump IET related statistics
for ICSSG Driver

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6bb1ad2e56ec..dcb28d3e7379 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -253,6 +253,7 @@ icssg1_eth: icssg1-eth {
 		ti,mii-g-rt = <&icssg1_mii_g_rt>;
 		ti,mii-rt = <&icssg1_mii_rt>;
 		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
+		ti,pa-stats = <&icssg1_pa_stats>;
 		interrupt-parent = <&icssg1_intc>;
 		interrupts = <24 0 2>, <25 1 3>;
 		interrupt-names = "tx_ts0", "tx_ts1";
-- 
2.34.1


