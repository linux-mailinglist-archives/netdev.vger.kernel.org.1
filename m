Return-Path: <netdev+bounces-94101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3F8BE1E7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E811F25FB3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061C3156F5D;
	Tue,  7 May 2024 12:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CE156C6D;
	Tue,  7 May 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084468; cv=none; b=QsrYbP1m+V7jNjO0/Iim7M6GVS4MD+MDy8SeugUW+/pMgeXI/6eCW1f/1nQHj9BQ/JNohchWtfgmxWX3DzZcC9BTiuUf6gvepVwcq/DvYe9RlCgI1SesbBXmn19avzlzO4Kqm3L5N+lGCm2n+eTJh0bRnxrnPtNU6b8lNvtdi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084468; c=relaxed/simple;
	bh=Y8fQUMzs7HZl5oQQnbJ+er0Rxfr51PVFMtxXioSay/U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uuEIM2NB/Y0apYmOcoWAkIdL99XZNax7FTNST+Tp6mvX09v79TZ0lDpIv81jO/pcm5y8SzksB87Tu809R+nYpGZDlDMNECsO1wFDppyQyNS33Ucpu0G2Sa66EchdVW46tTuLbvaU+gUabooQsZsrHHs5W+0mGA3rjKcf8pEmv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s4JoQ-0000000046z-17PQ;
	Tue, 07 May 2024 12:20:50 +0000
Date: Tue, 7 May 2024 13:20:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] dt-bindings: net: mediatek: remove wrongly added clocks
 and SerDes
Message-ID: <1569290b21cc787a424469ed74456a7e976b102d.1715084326.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Several clocks as well as both sgmiisys phandles were added by mistake
to the Ethernet bindings for MT7988. Also, the total number of clocks
didn't match with the actual number of items listed.

This happened because the vendor driver which served as a reference uses
a high number of syscon phandles to access various parts of the SoC
which wasn't acceptable upstream. Hence several parts which have never
previously been supported (such SerDes PHY and USXGMII PCS) are going to
be implemented by separate drivers. As a result the device tree will
look much more sane.

Quickly align the bindings with the upcoming reality of the drivers
actually adding support for the remaining Ethernet-related features of
the MT7988 SoC.

Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth binding")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: don't make changes to the order of clocks

 .../devicetree/bindings/net/mediatek,net.yaml | 22 ++-----------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index e74502a0afe8..3202dc7967c5 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -337,8 +337,8 @@ allOf:
           minItems: 4
 
         clocks:
-          minItems: 34
-          maxItems: 34
+          minItems: 24
+          maxItems: 24
 
         clock-names:
           items:
@@ -351,18 +351,6 @@ allOf:
             - const: ethwarp_wocpu1
             - const: ethwarp_wocpu0
             - const: esw
-            - const: netsys0
-            - const: netsys1
-            - const: sgmii_tx250m
-            - const: sgmii_rx250m
-            - const: sgmii2_tx250m
-            - const: sgmii2_rx250m
-            - const: top_usxgmii0_sel
-            - const: top_usxgmii1_sel
-            - const: top_sgm0_sel
-            - const: top_sgm1_sel
-            - const: top_xfi_phy0_xtal_sel
-            - const: top_xfi_phy1_xtal_sel
             - const: top_eth_gmii_sel
             - const: top_eth_refck_50m_sel
             - const: top_eth_sys_200m_sel
@@ -375,16 +363,10 @@ allOf:
             - const: top_netsys_sync_250m_sel
             - const: top_netsys_ppefb_250m_sel
             - const: top_netsys_warp_sel
-            - const: wocpu1
-            - const: wocpu0
             - const: xgp1
             - const: xgp2
             - const: xgp3
 
-        mediatek,sgmiisys:
-          minItems: 2
-          maxItems: 2
-
 patternProperties:
   "^mac@[0-1]$":
     type: object
-- 
2.45.0


