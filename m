Return-Path: <netdev+bounces-266256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGm6GcVSsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:20:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D32556C8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE159309B537
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE83CFF55;
	Tue, 10 Mar 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMixdcVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1743C9ED0;
	Tue, 10 Mar 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163142; cv=none; b=PjpKhuoDrP/HeHFnTC06NB760QBxamAI2eSoMYVE6vjq//WCR+D7t+PBbaksLRBFL1PWvb9HPv0mwJNBAC79r1F5We8cQpRBV7GERj0EzGKZImXYf52Xs5bYEvOvAPlKSoyBXADUpsjBa/7w7Zk0MmSTYvmh7RJMadlbJ+ZSx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163142; c=relaxed/simple;
	bh=YUjxJF2Qr9YfAZ+BooBI432WLTxTi2gxDGv7r0zGnd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bknCagSJ2Fotw9NA67NsK9iYVVhQe0kIUz9is5LkT4ccIXbqOmtyrhy4z8hnVCWiYtLqGTatANJHGycH8J6vSxF9IZVgvqg0etp9TZbp2om8JBropGDFInfhZ8o7cFaX6fePEcP4vgycTIKDEe+mAM1VJHPrwL1WK52E8hwxZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMixdcVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EABC2BC87;
	Tue, 10 Mar 2026 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163142;
	bh=YUjxJF2Qr9YfAZ+BooBI432WLTxTi2gxDGv7r0zGnd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMixdcVOistAJIq0ewUNe/ndKJ1oHMibR0pp3XXNQDTt1fxyohpnf5g4uhm8EfY97
	 QCg00srsD8QpOqRzRmoXz8aS6KInGP+9ehToJM8MhcSSV/qrOq89GU1M+17vvLF3ua
	 5ElntDk1/MadosHcumGKS200q3w5yVaBYTD9WozG/Wqd87KZn1JE07OM2TKeneTzsc
	 tpF+Urb8fWvpNk5DyRAUas1xYXj4W5n81aUDTR6aei9heA07Mp0ItB4wa6XnDOc7+B
	 gp872qEWIQOH/PDyiZzjQYi1zzlrTTfzmfQCTzzJ7IlM1t88CEm7gzTLh565gExOGq
	 HE6JFgKfUgWhA==
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
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v3 03/10] dt-bindings: net: cdns,macb: replace cdns,refclk-ext with cdns,refclk-source
Date: Tue, 10 Mar 2026 17:17:10 +0000
Message-ID: <20260310-sneak-handclap-c150d8f1236b@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1c/eg0vschSSxuR+95KDlkVYxNRVuIpwZ6UtMicQR0k=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgnTn+lTXsKy4fSz0TqzRjT/Jrdpf3j2enNJxInRbc 6XV0i9PO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRQFlGht/C0kdSP2osvqmn oHKSs3Z35503ojqhq5x6z1jatpX++cTIcMea5fZi5wvTTKsP+xnYfUvK2DJtYiNzU5/Haz8zgQn r+AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 193D32556C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266256-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/cdns,macb.yaml    | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index cb14c35ba9969..a492357570edd 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -120,12 +120,14 @@ properties:
   power-domains:
     maxItems: 1
 
-  cdns,refclk-ext:
-    type: boolean
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
@@ -196,6 +198,33 @@ allOf:
       required:
         - phys
 
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
2.51.0


