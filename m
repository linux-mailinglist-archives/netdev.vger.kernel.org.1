Return-Path: <netdev+bounces-247162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B974CCF525F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C584B3126E7F
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAD434403B;
	Mon,  5 Jan 2026 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="UxoLohP7"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC0340287
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635911; cv=none; b=VI9phjOiyP1BXSbAvKuA5KXYcmKu8bjeW+yoSnpjLTdms06LYqTqkZOkzv57pSxtgHOMFv956oauI5/+5IMYBiCA5EhSO7ryDyFlsMbxhw70Ecv9awGjj3uj17yXtKl4IFb58ujpy8AQhEdGQdLkTkE0BddlKJ+3wzrTAiPWwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635911; c=relaxed/simple;
	bh=id0P+PlRLOCJXARQw+fVfjaF5tscQKCQjiVv5D/ZYJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lllJ9fKT4tEGtE/uqehqb/nn9jJxt60znBxoUGtBMGGz+VzT/JLtdcIlceb8FnItuo8f5YyWpCESd5e1xghhlQh6nMoIn4qIayeYO5SlWFCgmYvSivQfduifnNIkjh7rz39mK9oOhzqTkLxCd8LwMQ0215sugIx/FbCpVqZrQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=UxoLohP7; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260105175827792b207ea90002074f
        for <netdev@vger.kernel.org>;
        Mon, 05 Jan 2026 18:58:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+VF9qf0lyx5JO6iRDcWE+HGKRWPB1+Q6ipi8K3G/DCc=;
 b=UxoLohP7UVCGVGa0/fyMOaE+gucgGrT+mbVhHMPc8H5Pj5RkfBtTsYdIPP/SH+VAS9YVEY
 xys0cCfmvCKuDXTXthKdSs3axeCq2SGK6aGJdLj24FvXuGGVbM2VGT+uG3jMa+CYUWrcMGsg
 pPHwtS1czkH/6EEObqJPRJrMqWoIotAk2rCGWEUEj9PhPvnbdBdKaRIfRtItOSvJrbeMDvZB
 QHNAVN+OQSu9pi2CABN4CC/3bMDREbhmof9aGmnudx/pnijrj9RYNvdR2yF/lQLZKeZJIqSN
 kccAUB4oT+ERXD94ghlVd4JaTxMDeENi71QF+FVv8P4BODtnrHvNEPmw==;
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
Subject: [PATCH net-next v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
Date: Mon,  5 Jan 2026 18:58:21 +0100
Message-ID: <20260105175825.2142205-1-alexander.sverdlin@siemens.com>
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

Add new slew-rate uint32 property. This property is only applicable for
ports in R(G)MII mode and allows for slew rate reduction in comparison to
"normal" default configuration with the purpose to reduce radiated
emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
v2:
- unchanged

 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..277b121b159d5 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -111,6 +111,13 @@ patternProperties:
             description:
               Configure the RMII reference clock to be a clock output
               rather than an input. Only applicable for RMII mode.
+          slew-rate:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1]
+            description: |
+              Configure R(G)MII TXD/TXC pads' slew rate:
+              0: "normal"
+              1: "slow"
           tx-internal-delay-ps:
             enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
             description:
-- 
2.52.0


