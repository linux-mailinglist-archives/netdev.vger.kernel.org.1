Return-Path: <netdev+bounces-198001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D07ADACAA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473F23B0E2A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB173277007;
	Mon, 16 Jun 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="C7SXOLfs"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8A274FDA;
	Mon, 16 Jun 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067929; cv=none; b=t8ATQhkCVloqE5UmOsXGRQBhIk+wxKOULnhfouHPP9hmRnyATOXLz2nsiu8n2GvfUcp9yo/A0ySRW0azKsFbQARuHUOC3EP8vLTQQNoA0AuOGlPlCj2CPe8jM8cKz4E6uGca4BBQK9/k8xAAT6OdNG3GvtQvxoYIx9qzI/DBYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067929; c=relaxed/simple;
	bh=rIzQgXvIc1jagNXrbYabNFxX6IODxdkK9ASrLqltX4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRZ9LBjawHyntgkbTPxkozqQDEGIivkM9INXXKf2Rq7LRF1kB2gCtdCeCMu1Xbl+4gNB8fvnqKlDa2mwIo7CXeu79bUEuGjIsolmGmfEFaDIS8C3TSHv0yaa/T9V1iPwxIHlVgwIJhzyzxxHBR+n53TilIi7c1B1//EaNQv/ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=C7SXOLfs; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 7417241ADE;
	Mon, 16 Jun 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750067921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1f4fkmPwrhUDTuJaJTH9o5ndndBg0Bz3rlvov4MAAmY=;
	b=C7SXOLfsYiy14t1lOxOAuAoeQYYv2yHWYJM2ayFf1Dm/4Oi87WWcLYA0CJAl3zZEkwcVgF
	B5700V4q+8SZLrcaz/eduB2o9FZ2c5HiFYzDpn9pfKc5FaVgJxVtd85u0/fzuExawbcZKJ
	IHUqsogfBRUR28VxJFwvGnDcPqcCZP4=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 1A5BB122677;
	Mon, 16 Jun 2025 09:58:41 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 04/13] dt-bindings: interconnect: add mt7988-cci compatible
Date: Mon, 16 Jun 2025 11:58:14 +0200
Message-ID: <20250616095828.160900-5-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616095828.160900-1-linux@fw-web.de>
References: <20250616095828.160900-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallback
which is taken by driver.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v2:
- no RFC
- drop "items" as sugested by conor
---
 .../bindings/interconnect/mediatek,cci.yaml           | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
index 58611ba2a0f4..4d72525f407e 100644
--- a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
+++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
@@ -17,9 +17,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8183-cci
-      - mediatek,mt8186-cci
+    oneOf:
+      - enum:
+          - mediatek,mt8183-cci
+          - mediatek,mt8186-cci
+      - items:
+          - enum:
+              - mediatek,mt7988-cci
+          - const: mediatek,mt8183-cci
 
   clocks:
     items:
-- 
2.43.0


