Return-Path: <netdev+bounces-137502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0B9A6B5B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F951C227A7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E891FBC89;
	Mon, 21 Oct 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bSU24jg8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F81F8F15;
	Mon, 21 Oct 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519216; cv=none; b=uCgZ2FdrxjdsAfO95gZvIDcEwX8kOBODfxHT/+BptdnIUSZsnygT8e5ziCerDmBLp8RtLufp9CIrffqa2l4P0va3bj5Ziy08eOs0giX9yiGUPAY4AK4rberqsWqWs2CEZCy3ISl7P6rweL4w2xN8OkJxDZ6L4qNFr/XuvNeiBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519216; c=relaxed/simple;
	bh=ngOehsscgKeABTUPd2zTYRgy1/B3PAnX7UqlfISLwO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UcxsOOKSqSc/xb4BaHuoF3QvhrGETotAL+cNVO7MnJzP1MYeyPrwNRH6+TFOZukXlpHKBH9Rg+27LfAC3pwy9hTrTn3g8EoRjbLMJRpg2Fm7cepMXgkkmcR3DYFzs3zrEg6jPtUsPwyOrU05G2jn8TBgiRG+zBtixQMn4JpF2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bSU24jg8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519214; x=1761055214;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ngOehsscgKeABTUPd2zTYRgy1/B3PAnX7UqlfISLwO4=;
  b=bSU24jg8IgeFZnDzsRPielGHt0rsyIvfNhk97OoCs4N9oBhGmXSQ0BSy
   y7bd2rdBnxZqEaw+k6YDFrMdvEuVAUEWFaGdWrrV6acoq+k4gaQpZC+lt
   OM367KTN/ZkPvqZ+1RJa7qr32aMeQpsuzQXViZnPdBW+mrbjCooHj/yK+
   AoPDXSatkTSj20T9oNyrnQgfjYFoShvfH52pAqIr2bC6O3caz6RWMxqY9
   gWSQKW9XovcNCf4wClgHyKYw3ecHO2OinaG5HYtyBzeHHQE82JSY9s6ZJ
   o/RRvzgLBVc/ovwee2kjnJH2zk7E8W/K+tHAebuHIFjyH/m4+ljezBCO/
   g==;
X-CSE-ConnectionGUID: wjlJ/ymcRaqntxTcHXMHhA==
X-CSE-MsgGUID: s/1xQN3ZTSGKfQvmRD5cyA==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="33285732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:00:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:47 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:44 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:50 +0200
Subject: [PATCH net-next 13/15] dt-bindings: net: add compatible strings
 for lan969x SKU's
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-13-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add compatible strings for the twelve different lan969x SKU's (Stock
Keeping Unit) that we need to support. We need to support all of them,
as we are going to use them in the driver, for deriving the devicetree
target in a subsequent patch.

Also, add myself as a maintainer.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../bindings/net/microchip,sparx5-switch.yaml           | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index fcafef8d5a33..c38f0bd9a481 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -9,6 +9,7 @@ title: Microchip Sparx5 Ethernet switch controller
 maintainers:
   - Steen Hegelund <steen.hegelund@microchip.com>
   - Lars Povlsen <lars.povlsen@microchip.com>
+  - Daniel Machon <daniel.machon@microchip.com>
 
 description: |
   The SparX-5 Enterprise Ethernet switch family provides a rich set of
@@ -34,7 +35,21 @@ properties:
     pattern: "^switch@[0-9a-f]+$"
 
   compatible:
-    const: microchip,sparx5-switch
+    items:
+      - enum:
+          - microchip,sparx5-switch
+          - microchip,lan9691-switch
+          - microchip,lan9692-switch
+          - microchip,lan9693-switch
+          - microchip,lan9694-switch
+          - microchip,lan9695-switch
+          - microchip,lan9696-switch
+          - microchip,lan9697-switch
+          - microchip,lan9698-switch
+          - microchip,lan9699-switch
+          - microchip,lan969a-switch
+          - microchip,lan969b-switch
+          - microchip,lan969c-switch
 
   reg:
     items:

-- 
2.34.1


