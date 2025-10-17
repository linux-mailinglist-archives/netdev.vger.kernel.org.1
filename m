Return-Path: <netdev+bounces-230536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A7BEAD31
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29617C3AB0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00D283124;
	Fri, 17 Oct 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="svkbTNq+"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3C27991E;
	Fri, 17 Oct 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717425; cv=none; b=WMxKZD9LqU0azCNlKUJZPfRyxr7cmeHI+4gvwfRHnnX/QZksy6NiaQkuxAiwLow0WGeBlTjL5UaU0jKWYuFKcmduYHd8GFrLzFYClaaqWjnUGOtHQDNydLK0AfXnmu6YRE4KxA1KsBxYd0H4KWHiLSECnn83aeJfe+Bb/OdryOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717425; c=relaxed/simple;
	bh=WVFG1HB0OoVx50SdIrecnXIPPRMeTYjaW9uCQsgV6MU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFl2f7q4Jc76GV0aE6DYZ795ka/NlJZaVneGloaqsv9Z7V11T1rXyMcAXzALNqYlbqvD0TNlF590e3cev54U5nGjQItXP8bKv9cpNsRSFBuHjFEMktXGNo3d5LXdc2DR2jwwAI+kt19ycLneY6LOg96ZNLNGfCku710hte9wHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=svkbTNq+; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 09B0CA1BFE;
	Fri, 17 Oct 2025 18:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=X7n7lgHq7CaDRpNdI4PF
	ag9rzyzV0sMHG3RoqhvXd1U=; b=svkbTNq+nUmQb4Ut5QR8k5/97q5xrh3PFG0B
	+UPizkvlMAAFqYusAmUFq94zht9CztiBEmnebt/0mzEhqGlBy5yzlAAAHxBaWmOu
	mZvCDc+j4yKfN2KEMiUugIlNJczk3wfCh7scoD9ZWIi47vCkH6LuvtMRmuEDhxIF
	bCzGabY+q0TMHrDvdXCT5alV1MEdPc6+uWlOJ7+RzYKFkSphzOpWWezMIMDokSTy
	Z2FhwpyKirNgXbHmtWoYxYRNQ0obA3lobNAxqq0dRB2BXuWQ6a3C2y+Uav7CyzI/
	fNkBHwZPFnkQNnXc0xseyC26fEKnaxXs7HlD0fnbFPe7SypGH14BqSo0FMH/e39w
	sxkM596jCbJ+73FQgqIvFjHN/nf530fPpCc1nLv2xIM2E1yFOTZRzK786IEZkpEh
	D6ILwVkBg9rWQxxUO+Bufkkw/1t4LXZA7sm5LVBdVwu+l83I20SFGV9YpRwzAthI
	QxTBK6QrxYGQIamM9Blav2dpX6QTO9za0nMEZxDTT9WGECzNL2NsFgCElnTNwU6x
	rKhNHxl0yP49Bj3rq3NlxP78872t4osWvwQPNp2FzeCX2e42410MuCCERGA2dD0M
	WLaaviTsagEzORki8cv1TOSONDL66PH2r5C4OowsTHAYf7JJxx4+SFULzIHGPWWx
	vFIiKjs=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Florian
 Fainelli" <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 3/4] dt-bindings: net: mdio: add phy-id-read-needs-reset property
Date: Fri, 17 Oct 2025 18:10:10 +0200
Message-ID: <3a93b87f2bf7ea87c1251d2360e11e710772dd92.1760620093.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1760620093.git.buday.csaba@prolan.hu>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760717418;VERSION=8000;MC=329064332;ID=38909;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647660

Some Ethernet PHYs require a hard reset before accessing their MDIO
registers. When the ID is not provided by a compatible string,
reading the PHY ID may fail on such devices.

This patch introduces a new device tree property called
`phy-id-read-needs-reset`, which can be used to hard reset the
PHY before attempting to read its ID via MDIO.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V2 -> V3: unchanged
V1 -> V2: added this DT binding
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2ec2d9fda..b570f8038 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -215,6 +215,14 @@ properties:
       Delay after the reset was deasserted in microseconds. If
       this property is missing the delay will be skipped.
 
+  phy-id-read-needs-reset:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Some PHYs require a hard reset before accessing MDIO registers.
+      This workaround allows auto-detection of the PHY ID in such cases.
+      When the PHY ID is provided with the 'compatible' string, setting
+      this property has no effect.
+
   sfp:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.39.5



