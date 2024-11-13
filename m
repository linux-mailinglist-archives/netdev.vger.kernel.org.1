Return-Path: <netdev+bounces-144594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22E9C7D76
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319B7B2A715
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29144213EF5;
	Wed, 13 Nov 2024 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D7N6qeg/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801312123F2;
	Wed, 13 Nov 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532352; cv=none; b=NPwheXp6yg1W39Il+CBiP0oj7FHglwEuDHDGn1DDDYXToJHVxoXp6AACnb6Jz8kwXZVy69RrEU1mAmZeRTGT5lbl0enFgzLTRm4lnKrTcGkIkjho/fjFCeLdGiOhjKlHf/ROqJ2Fy5BFXOiNgdBCeORz4no9HfHUUDM6FE2mp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532352; c=relaxed/simple;
	bh=Tpwk/cH/By/7DRbyPN6y3UDPzobNPdtOHRJ5VREhWow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tfA7R0u20hZcUbpzJt9iuSa2aE4PsaLiK/oFlEtERm04p9P3ZQWPBJNwLPdF54TU/e9O6aB66sxJcsmhII2f9TYwdSgc3mVsyWZBHzflh8aJG/R1/Gx6ZDu4N0XRic5g0NouETT9FieeS7u8NbR1rPD9TEQaA06YUCfKm94KEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D7N6qeg/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731532350; x=1763068350;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Tpwk/cH/By/7DRbyPN6y3UDPzobNPdtOHRJ5VREhWow=;
  b=D7N6qeg/8Fm7GSA1oxN5WlUSwj3MsrW4FPDVJWETDz9bCjW0cTJdBQUE
   9KYy8rV80YAwhzeXutG3n5s8HFZoHj8uB4bVh4VVqw89eQ7putVOpKKrx
   hqv5zSzEAX9kfWObrLI1FhTqlkAZ0VTWox+FDKwtFWZVjs5mExSgMOZtt
   A2FToJ0DPPmwlkfBPj40amyGDUqHXDZ24GcnfgOxc5Ibc6JiPVGG9RwQ2
   465v2EsDJniilQ+glMgetdhy2bB5nD2xHLtP5wBTUYkectFpXsBNOhuRn
   Snv/ynqsvOKIwS3VPqgCI+Hosde6djp/dreRupoE0xj0obVbcKf3lYmL4
   A==;
X-CSE-ConnectionGUID: vQdPcQJhS0S1px+vMo5fhw==
X-CSE-MsgGUID: +0GrCcvYR3aR7jveVUPVog==
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="37813511"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 14:12:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Nov 2024 14:12:00 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 13 Nov 2024 14:11:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 13 Nov 2024 22:11:16 +0100
Subject: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
In-Reply-To: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The lan969x switch device supports two RGMII port interfaces that can be
configured for MAC level rx and tx delays.

Document two new properties {rx,tx}-internal-delay-ps. Make them
required properties, if the phy-mode is one of: rgmii, rgmii_id,
rgmii-rxid or rgmii-txid. Also specify accepted values.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../bindings/net/microchip,sparx5-switch.yaml        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index dedfad526666..a3f2b70c5c77 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -129,6 +129,26 @@ properties:
             minimum: 0
             maximum: 383
 
+        allOf:
+          - if:
+              properties:
+                phy-mode:
+                  contains:
+                    enum:
+                      - rgmii
+                      - rgmii-rxid
+                      - rgmii-txid
+                      - rgmii-id
+            then:
+              properties:
+                rx-internal-delay-ps:
+                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+                tx-internal-delay-ps:
+                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
+              required:
+                - rx-internal-delay-ps
+                - tx-internal-delay-ps
+
         required:
           - reg
           - phys

-- 
2.34.1


