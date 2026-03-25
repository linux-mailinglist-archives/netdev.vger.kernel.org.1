Return-Path: <netdev+bounces-271645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Iw0BagNxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:30:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1B32907B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93E5C303B2B7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC03F99FE;
	Wed, 25 Mar 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9/qQCEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E53F99FA;
	Wed, 25 Mar 2026 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456154; cv=none; b=tCye8tUx85rOyiSwRz14bLdGYDHACqmNvdSMVDdv8MfL3exS1mvxXZS30YIUl9TICt8ED6PUJtiAY2mYmvcXU7vJ2cJ2gSF0Nj1VtVtq/mTRkT5Oqk29u0RzvsgpW447zpIrmMhfXtn0vnvMp+jIHZzt6mY/CNAHYTK4f+Bz5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456154; c=relaxed/simple;
	bh=tPzeJ8v456m2d30UqE73B+UaLtNZYD7FTrsxSwqJZFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9NqRlZZTywNM9vj1bo6IqI6anbtbSKBw2mU1thI1GtLReu0812m/UY6VFuPBEkJXA8+AN2in8J+Seykoo3MQtmqK1l0QF6Hj1VTqa2MECjST667nIFgw/7LRK6fmlG/B5zB9ilzJaJahwgMJnwl0D5FQ2xqRzqgkNd4/yne38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9/qQCEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3B0C19423;
	Wed, 25 Mar 2026 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456153;
	bh=tPzeJ8v456m2d30UqE73B+UaLtNZYD7FTrsxSwqJZFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9/qQCEVLFbmPvNpERJrwz34LiGRHyf+wBv5b4IFmOPsydwwoYAIkT+n+qT9W/idh
	 38nIKQbaKClV4Hq4ngTp0RSLqSrxxr+VaCPhsvaVkkATzYP9uKOYpfsN/36iAJjwoT
	 eSDiL71bYElvrdyRduA/Nq7UMzop1RMmPqyS+eWtwBEqNIziofKcuJ54geUWJ6toAv
	 TrENIsMFkgY7N9Kwu4Pk6FaxhAOfugGJycF6DQYuBTxMCw3VMcpUR5UcdXVYbXZmIc
	 Kusm0RE44pvfTnjpjzudhB5jnV059ZfAYrJJZBHIejFsB4/h2+n2Ta13ecSVaumXpw
	 b3UwBh8aGGmAA==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 04/14] dt-bindings: net: cdns,macb: replace cdns,refclk-ext with cdns,refclk-source
Date: Wed, 25 Mar 2026 16:28:08 +0000
Message-ID: <20260325-savior-untainted-03057ee0a917@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YuZA+9uk1ysSY/NdJLuuoPLcf0q4cp5LYDFkeULhb80=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeE07fxsurH4u2hT09IVDXFnKih7xKc6PzIV+PbyhY /3c6IJhRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbiEcTwV/jll+PbTz2tOfLt dtKd/fm6WXIdP57Z5ucaBHlfVeDc+p/hD0+Hp9gz83c50mtjHlTevO7y9umR3IZ304QWeTytaF+ RxQYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271645-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: C1C1B32907B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

Ryan added cdns,refclk-ext with the intent of decoupling the source of
the reference clock on sama7g5 (and related platforms) from the
compatible. Unfortunately, the default for sama7g5-emac is an external
reference clock, so this property had no effect there, so that
compatibility with older devicetrees is preserved.
Replace cdns,refclk-ext with one that supports both default states and
therefore is usable for sama7g5-emac.

For now, limit it to only the platforms that have USRIO controlled
reference clock selection, but this could be generalised in the future.

The existing property only works on devices that are compatible with
sama7g5-gem, so mark it deprecated, and limit its use to that specific
scenario.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/cdns,macb.yaml    | 56 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index feb1683858374..50490acbb6fc4 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -130,10 +130,23 @@ properties:
 
   cdns,refclk-ext:
     type: boolean
+    deprecated: true
+    description: |
+     This selects if the REFCLK for RMII is provided by an external source.
+     For RGMII mode this selects if the 125MHz REF clock is provided by an external
+     source.
+
+     This property has been replaced by cdns,refclk-source, as it only works
+     for devices that use an internal reference clock by default.
+
+  cdns,refclk-source:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - internal
+      - external
     description:
-      This selects if the REFCLK for RMII is provided by an external source.
-      For RGMII mode this selects if the 125MHz REF clock is provided by an external
-      source.
+      Select whether or not the refclk for RGMII or RMII is provided by an
+      internal or external source. The default is device specific.
 
   cdns,rx-watermark:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -215,6 +228,43 @@ allOf:
       properties:
         mdio: false
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - microchip,sama7g5-gem
+                - microchip,sama7g5-emac
+    then:
+      properties:
+        cdns,refclk-source: false
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: microchip,sama7g5-gem
+    then:
+      properties:
+        cdns,refclk-ext: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sama7g5-emac
+    then:
+      properties:
+        cdns,refclk-source:
+          default: external
+    else:
+      properties:
+        cdns,refclk-source:
+          default: internal
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0


