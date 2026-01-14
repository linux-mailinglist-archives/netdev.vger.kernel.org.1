Return-Path: <netdev+bounces-249797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C99D1E307
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A513018312
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D2393DDE;
	Wed, 14 Jan 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="QD71lyG7"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E13939DE
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387573; cv=none; b=oCjfAH7kisrB0I309FRvmF4AN5wn2jkPLPDh+WzarMyHtVi5CtkdRD3B2xhG3YfNd1ycPfviFNPQyfjfC7YbVuxcnIapGeJGEQjJcnjXiL5+TzOZdENpTQTHM20t25ePpPjmF0uDfxQUHuv6pmXy8IeWAkVgdWzI520FVm0lUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387573; c=relaxed/simple;
	bh=/RT9Fjy6zwrQxV53Khrs84p41GKb2duCHm00MjtpaeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnb0yFeTZMP+7m1y2Gu+HdWEKuQNFMXpsuLcoXH3RPHC8Kt+ARyMNz/NogafzSPbVmIMq8MklDJpo2gt5iWIXsfhcXX/lJA9CExtIzmybGVDGovzgxP1+qakl0mPjCiFqRDqAejC5NCbTY+ctqTVUzW8mQw0TvT9V2gYEcOpcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=QD71lyG7; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260114104603a646974726000207f5
        for <netdev@vger.kernel.org>;
        Wed, 14 Jan 2026 11:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Purx6iWjqLjZ2AucD6/DoIPyiS2j5aju+XohBp+HL+o=;
 b=QD71lyG7kEwvMwjHakvLgAEUUgxrubLU2LRsiUtMl2rWZd1/5HtWDk+6MMMFf7fVvpBuq4
 E2FlaNX6PhQrpu1yqV9Wu1EYIk3Mqrpz7+a0L3vMBK76dQXeasmpqvW1PC5yanQb9RKvFHoH
 6Qcgzwv9nhq4DwSdNQ0/jpQ43kuzXjf85I+/WEvyE/NNSCm412pvTNSspf5oTxRaD4t04gxI
 BASqIQWVWevyrOP1BL2J/mtSZE3OXoU+RztrR4qpJ06FmPZSGglCUkvo6xMrE7qNt9lvpPGV
 PSwqzIB+ul446V/05ICZmSv2Wd6r00dNynSQkOhT2Alaq+Y4hHmn9Icg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next v5 1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
Date: Wed, 14 Jan 2026 11:45:03 +0100
Message-ID: <20260114104509.618984-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
References: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Add new maxlinear,slew-rate-txc and maxlinear,slew-rate-txd uint32
properties. The properties are only applicable for ports in R(G)MII mode
and allow for slew rate reduction in comparison to "normal" default
configuration with the purpose to reduce radiated emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v5:
- improved options' descriptions on Rob's suggestions
v4:
- separate properties for TXD and TXC pads ("maxlinear," prefix re-appears)
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
v2:
- unchanged

 .../bindings/net/dsa/lantiq,gswip.yaml        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..37d64b8a76ac7 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -106,6 +106,28 @@ patternProperties:
         unevaluatedProperties: false
 
         properties:
+          maxlinear,slew-rate-txc:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1]
+            description: |
+              RMII/RGMII TX Clock Slew Rate:
+
+                0: Normal
+                1: Slow
+
+              If not present, the configuration made by the switch bootloader is
+              preserved.
+          maxlinear,slew-rate-txd:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1]
+            description: |
+              RMII/RGMII TX Non-Clock PAD Slew Rate:
+
+                0: Normal
+                1: Slow
+
+              If not present, the configuration made by the switch bootloader is
+              preserved.
           maxlinear,rmii-refclk-out:
             type: boolean
             description:
-- 
2.52.0


