Return-Path: <netdev+bounces-189539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED84EAB290C
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B03AFD3A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E825B1DD;
	Sun, 11 May 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="t6W+bX+z"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EC25A33E;
	Sun, 11 May 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973636; cv=none; b=ib7XkTb9DpM6t7F8RqWiMZ+JsLR2SdcsClTm9ysLDjdiMSnv9ZTPRLu13qkbk0OnVO6IxawQ+tVFa6auq8umCFCDhzsGNmxBeChE52GEgoYSxTNfsOAodCvK/ipa+tCcHnDfaCzCsL30RSY0/+mSzg7yK8eYk8oeG+dM0WkaemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973636; c=relaxed/simple;
	bh=MXoHdJdXDAaIgTdoPAI3IjgNKGscDJ3hK37VxvEd/pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LO8vpqLOdxdqX/zrHwfO5seNAM5W6P3vQUgCxbBRQ8+cM25HQDD9+5vOl6f429dRNRyB25M5Xc6bJBmq+Of3FficQvc/APgncYgROoUxi4PiH1dKWPFIgEojNEJGvVDTGYWbsybk44w6H2UUKKJEMJmRIZgYzRzJrWEowL7d5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=t6W+bX+z; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id B2A6440094;
	Sun, 11 May 2025 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1746973199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zletv3U5pRRedodS7LIwp9KMfAgSeQxiaCAd7v3PwI0=;
	b=t6W+bX+z/KRWh9jA/wLcR8rgxTTS4oMSkzhc6kOa6+8CCchz6xVQORutqkVWCSVtNFi7cQ
	z/7aDNcaKk7HvAAjGho2aXcBXVk02wclJ/eoIdr67suJwISesnfTaRMKfy/OfyF3tFWABH
	h4K52HiAXDv3KU2v4e+UITQHa+tzdHc=
Received: from frank-u24.. (fttx-pool-194.15.84.99.bambit.de [194.15.84.99])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 98311100787;
	Sun, 11 May 2025 14:19:58 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 07/14] arm64: dts: mediatek: mt7988: add phy calibration efuse subnodes
Date: Sun, 11 May 2025 16:19:23 +0200
Message-ID: <20250511141942.10284-8-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141942.10284-1-linux@fw-web.de>
References: <20250511141942.10284-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b7327c0d-db13-43b6-8ec5-709b71d19c3b

From: Frank Wunderlich <frank-w@public-files.de>

MT7988 contains buildin mt753x switch which needs calibration data from
efuse.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 64466acb0e71..029699e4eb02 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -696,6 +696,22 @@ efuse@11f50000 {
 			lvts_calibration: calib@918 {
 				reg = <0x918 0x28>;
 			};
+
+			phy_calibration_p0: calib@940 {
+				reg = <0x940 0x10>;
+			};
+
+			phy_calibration_p1: calib@954 {
+				reg = <0x954 0x10>;
+			};
+
+			phy_calibration_p2: calib@968 {
+				reg = <0x968 0x10>;
+			};
+
+			phy_calibration_p3: calib@97c {
+				reg = <0x97c 0x10>;
+			};
 		};
 
 		clock-controller@15000000 {
-- 
2.43.0


