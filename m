Return-Path: <netdev+bounces-189543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D339AB2924
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44221899587
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86025A634;
	Sun, 11 May 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="a1ljSSE1"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE47256C8F;
	Sun, 11 May 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973769; cv=none; b=blyep/oVXpb1j56iTXtcRPcHRZEVkmiRAF4aa9W4OPrflcawgA8nPw6JCocsIX7dtBCTet3JA1SCa7ijc5sKDjPKk8wWb8IWj1kzFO8kxExnqBORoXiM3QWnzgYBOBSz/L3ELDXlqXjT5eDhgDHjTBxpOW3mjFHgKghLKm4BQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973769; c=relaxed/simple;
	bh=m4YmzQxM4Bbbpg+XrK1yrzjGS2maCkIgFU9nyPvfA6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL8Sq+34tL8zfsecAxKfO6NAAL0bUkm1fbGKdEDtrJYQ1neeUmyfNoIm0ddyWqUS0nYf9Olxa5PnlIIG9VhDGsa6ChLrImUrlNJB2LFcfgJWzWSfGMqEqIO5B8+lOiopjbgh0NUVMa5a/xv8aep5MZVZDj5Z0+qLb27a2hfaEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=a1ljSSE1; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout3.routing.net (Postfix) with ESMTP id C1A7060208;
	Sun, 11 May 2025 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1746973195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmymoOtnayYm+djs4rT1y9StT3GuYbOed9q3JI0dnYo=;
	b=a1ljSSE1eNYNAy4rA1cHI0DQA4mB/tq/0matKE/aI7ogzY6otz9Uqi5f9ifNDpB5+NxjAz
	qbKfrKDkn554j/qUh0GLuyJRFdtBQKmCItTC7SCARgI5Yg0dJei2alZ52VmNB6PBiOnh2M
	IcG1ME+25IP+tqndtWr74BZ6uEOglZw=
Received: from frank-u24.. (fttx-pool-194.15.84.99.bambit.de [194.15.84.99])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id A8BA8100500;
	Sun, 11 May 2025 14:19:53 +0000 (UTC)
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
Subject: [PATCH v1 02/14] dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for mt7988
Date: Sun, 11 May 2025 16:19:18 +0200
Message-ID: <20250511141942.10284-3-linux@fw-web.de>
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
X-Mail-ID: 8900cc97-8796-486b-b6d7-bfa5648f2213

From: Frank Wunderlich <frank-w@public-files.de>

Add own dsa-port binding for SoC with internal switch where only phy-mode
'internal' is valid.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index ea979bcae1d6..bb22c36749fc 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -186,6 +186,18 @@ required:
   - reg
 
 $defs:
+  builtin-dsa-port:
+    patternProperties:
+      "^(ethernet-)?ports$":
+        patternProperties:
+          "^(ethernet-)?port@[0-6]$":
+            if:
+              required: [ ethernet ]
+            then:
+              properties:
+                phy-mode:
+                  const: internal
+
   mt7530-dsa-port:
     patternProperties:
       "^(ethernet-)?ports$":
@@ -292,7 +304,7 @@ allOf:
             - mediatek,mt7988-switch
             - airoha,en7581-switch
     then:
-      $ref: "#/$defs/mt7530-dsa-port"
+      $ref: "#/$defs/builtin-dsa-port"
       properties:
         gpio-controller: false
         mediatek,mcm: false
-- 
2.43.0


