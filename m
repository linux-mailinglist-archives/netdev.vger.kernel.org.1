Return-Path: <netdev+bounces-271651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFi5GLQRxGkXwAQAu9opvQ
	(envelope-from <netdev+bounces-271651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:47:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B532959F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9908E31A5295
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31933FEB2D;
	Wed, 25 Mar 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNUDHwPv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2B3FD156;
	Wed, 25 Mar 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456189; cv=none; b=B8K4UbNAQkimPwiWkahZ+8OMkIDpDYYaU/5o5kLh3aCmJ2L94B38WqhFKXyd3XNGaItrOHfX1iLcJ50s0kinPj2I6k8G1EbMkUTCwSg/adhPjr3PuP6CuMPS+shCGlEk9nI21yY8to5SXQ2uHvYE9ygMQbgENopJfO6i485A9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456189; c=relaxed/simple;
	bh=djigdiiWtg5Ve5KXosHk2GFYWy4trdHi+BpBld8PyFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbztoOINacbybJy7aOOQnBWfI7Z9tSG4/1g38JgLQTtQ00lTVMv3zNdvCCaVj0mng641rdDKhEG4WVn0/V5W4+CR64/T+wEtjmwpHXH6evMEt/AA3yjHjSJpghIQUrm7PAoZn0zGVmKeLzbwjas4M3A3AW3Jfh2AY2JxmxP7W40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNUDHwPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74340C4CEF7;
	Wed, 25 Mar 2026 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456189;
	bh=djigdiiWtg5Ve5KXosHk2GFYWy4trdHi+BpBld8PyFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNUDHwPvLt7vwM1JGqjK0eft5SREZLSN3w90el4jsWOtsVnpv99o+6aN9KM+iDu9/
	 1b3TIaXgNyCQ6Ji7yJRPyoGrslQJBxztTPGYs2oezcnbk1u7Q14odTn7IlI3RtdB5i
	 CCvi7dGKL1tmoJBeKCcmEI3KhUbGHgFyEkR2x7TZyibYoWuCrdHxUQjmQMTd2bH0x8
	 /FUpUGkZLa9HG/1xTC1WCKEJIEBM7HmRUd4enMB/hn5X/ZD582f6DRwlniMxFz9R/6
	 Mpeye4BBtDogFUZSdty6wit+T96xoVljx1t7DSMu8mVmRJNr6ZV9vXgHtsmz9fh024
	 fFsKx4dJW+vNw==
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
	Kevin Hao <haokexin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v5 10/14] dt-bindings: net: macb: add property indicating timer adjust mode
Date: Wed, 25 Mar 2026 16:28:14 +0000
Message-ID: <20260325-daily-entitle-3640f7254da4@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PRhIJTmaVKMM0MQHK+yqnhr39wQYhs54BbhF9Smsdok=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM2Xz190RHr6nlUFK5/P8vOq3avWVaUrntvhv7JpO q9f0j6pjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExk/1VGhot8a1tPrf902l8z 9xmrXIXI+fU3trmvdap/suTo/3930xMZ/td8sPAM29q9KcmTY/nGmrb96ov0zm46/CrpB5vakfp rfnwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271651-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com,oss.qualcomm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: E93B532959F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

The GEM IP has two methods for modifying the ptp timer. The first of
these, named "increment mode", relies on software controlling the timer
by setting tsu_timer_incr and tsu_timer_incr_sub_nsec and performing
once-off adjustments via the tsu_timer_adjust register. This is what the
macb driver uses. The second mechanism, "timer adjust mode" uses the
gem_tsu_inc_ctrl and gem_tsu_ms signals to control the timer. These
modes are not intended to be used in parallel, but both can be possible
on the same device and which mode is used cannot be determined from the
compatible on all devices, because some users of the GEM IP are SoC
FPGAs that permit configuring how the IP is wired up.

Add a property to indicate that gem_tsu_inc_ctrl and gem_tsu_ms are wired
up for timer adjust mode.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/cdns,macb.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 50490acbb6fc4..2c8c080a3d881 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -158,6 +158,12 @@ properties:
       that need to be filled, before the forwarding process is activated.
       Width of the SRAM is platform dependent, and can be 4, 8 or 16 bytes.
 
+  cdns,timer-adjust:
+    type: boolean
+    description:
+      Set when the hardware is operating in timer-adjust mode, where the timer
+      is controlled by the gem_tsu_inc_ctrl and gem_tsu_ms inputs.
+
   '#address-cells':
     const: 1
 
@@ -207,6 +213,15 @@ allOf:
       properties:
         reg:
           maxItems: 1
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: microchip,mpfs-macb
+    then:
+      properties:
+        cdns,timer-adjust: false
 
   - if:
       properties:
-- 
2.53.0


