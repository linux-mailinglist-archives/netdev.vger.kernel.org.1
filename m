Return-Path: <netdev+bounces-247642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4CCFCB3F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F83302653B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B0C2F5A0D;
	Wed,  7 Jan 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="fmd378yv"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7CC2F12BA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776477; cv=none; b=DCQ19/1GBIWR9peJN5Lxrl/G2gyfX2WN70dnMvXPTxnA98HHrpmjtEpwBhXIpDBgsCZT/Iwuw0lcyIVeMYt+U4Fksk31qWXNzlfn+EtYUNf7qynNS9ylQfgEekCv8PpEkLyMCVaAt0QVAFTTCXQonokF0E/OkYC/2+7Hw3e/fOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776477; c=relaxed/simple;
	bh=p8++y6MQ0PibTNjwnihWjjoGZPpoq9Q8KvsYsZkU4eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpCUPiS9eAN/U1sXrxDEJC/WbQfrqG13QIqcdc6fc0zuqgR5w0oZ9kVNbeAWfyyeifUwCxQcmKjiQi88Kmc3AvSPCq+gAoxFbGYDRVbgs+n8cUYFeqspZhSwhXDOXe8jZ6A+ydjSMZ1NQPi3C3+YN95WelSWNez3gKnw61dR81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=fmd378yv; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202601070900228f3f84000d0002077e
        for <netdev@vger.kernel.org>;
        Wed, 07 Jan 2026 10:01:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Rda0U2M+d4Z48hBPk6RZ/t3g/zhmVTZTN9fsWTD29HQ=;
 b=fmd378yvk3cEw7Fbj8Ga9Y+ANicWlNwXCj5yajl8CzWi8MyRZ7Ogo6nfJ/gDRx5Wc7Pnrb
 Fo2/1xFiIQKUSSEiiKDRnt1iB2fBk9AeGT65Oeud/cB+US0DKA7dYBH21ygv4psxN1rgvZTx
 RCaXW0wg9bqyFA4XgZPY0p18dGUCGn4etOVjNeu5Ajw1o2xk1FGio68MVx3k0hRISXLVOZb9
 qwhyrQ9Fze9GIqd1/UY/QNfHYaevurk9TEDuZwKHAkGP4K3xgeachmIJqrbOYMdYu8A+MIf1
 9PHSnxVynXZuSo+vSk7wHJ1NBYaYQyGG1gC7qqqtKuPu1Zk5cu6pPIxw==;
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
Subject: [PATCH net-next v4 1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
Date: Wed,  7 Jan 2026 10:00:16 +0100
Message-ID: <20260107090019.2257867-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
References: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
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
v4:
- separate properties for TXD and TXC pads ("maxlinear," prefix re-appears)
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
v2:
- unchanged

 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..747106810cc17 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -106,6 +106,20 @@ patternProperties:
         unevaluatedProperties: false
 
         properties:
+          maxlinear,slew-rate-txc:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1]
+            description: |
+              RMII/RGMII TX Clock Slew Rate:
+              0: "Normal"
+              1: "Slow"
+          maxlinear,slew-rate-txd:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1]
+            description: |
+              RMII/RGMII TX Non-Clock PAD Slew Rate:
+              0: "Normal"
+              1: "Slow"
           maxlinear,rmii-refclk-out:
             type: boolean
             description:
-- 
2.52.0


