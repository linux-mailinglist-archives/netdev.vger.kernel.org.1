Return-Path: <netdev+bounces-229596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B302EBDECF0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E15D4EDF8F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395123AE87;
	Wed, 15 Oct 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Zdn1N0Fg"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D521885A;
	Wed, 15 Oct 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535912; cv=none; b=JxoKSsqA34Bxe7qwkxaB8UP62wDw4lgFRQ/Rf/CTOJTWRBRDxZviXZVR6DZKVkmxDNHF+qP8Xcd+C0+e/SKMnj2+qjJnI8MkmvZMRsn4bDRTOzJlrwETxQ3fCSKBe4qytPENiXUzlDAaws7nDZGWahbSwKaCYJHx0Rc/vJGd+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535912; c=relaxed/simple;
	bh=wabD2tCx93Y//cKIcPnfBMeAREojooeHwyAaPTUtvAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KL/Ouss9qD4PTMfyMBWms4GOscL8+WHz3IlCAh1vjQ1QYHPeHx9sOnxowXNourd+O94MYzrzmkdyrayVAdYRvr3RUKscTd9QCNLl4ydDZJxmlxKABx/9mK1lakXdN1AMjOXoybIbtbBUAiboTBTbMDoyMc566tzijFQPUAXb33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Zdn1N0Fg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1581BA1AB9;
	Wed, 15 Oct 2025 15:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=DVDtSrEChC60JEyjbBqZ
	65Ri8MQJBtrYLoWGqnR905U=; b=Zdn1N0Fg1AXU85WlqDrC3FSabeN+njQmuRyB
	1fRVSxtx6Mv0pRtC4nutmqe7k0NaBOUr4X2Ks20fdorb/V8X+lURozEx6y5Aurr3
	DskO7w168AnDyaX2t7r3mp+E2Ab/QZ3Exxvr8h8912XbmParG+qgvFUR1mSorxWy
	O/M+I2Bp9MiKmRgyT2Wng/AKDRP3ImzhFWG/0P8a+xdx66cyqY45ts63fBN8BJ4p
	PTo80VS66h1hTyBYt7epkJH6Siq9wDqCpfTIMIjSTi8rbl44KXiK1YUeI/IJ8aib
	MotKievhXtUsF5mAXMgxYGsH8QvGVRq8pPbbNuIl7+VCSYchTuFRZuYoXWgVrXRm
	+i3S2BPebFFhdkpMFEdzYGqmH5R85YPintCPRABYcC0a6WSpEA/lZGp6vJzutKYR
	z4iqDR7++MAWuGwCVTNvmFc0Z+27biwrVo29mCwU6vXhw1cQxVgfpkPzP/nWcInu
	xL4AUyZI46fEDdBlcs+31WMTc0be0BR9l9iycMK0XjBwhArlLdrCQwY7jgTx86X2
	Hua05JdBrLAgu0yAfoDAtojZJnLLOkvtMIf41YwHvNt4L7rfV+CC8ZSrZrFeFwSe
	gym93h6M6sgNzAjdTJWQPzA9gIBRS6uaS/RwCcWtKFHvOzYrrGRVrjQk9YZk5tSi
	oMtyX58=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH v2 3/4] dt-bindings: net: mdio: add phy-id-read-needs-reset property
Date: Wed, 15 Oct 2025 15:45:02 +0200
Message-ID: <20251015134503.107925-3-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015134503.107925-1-buday.csaba@prolan.hu>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760535907;VERSION=8000;MC=2303761733;ID=558034;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F64756A

Some Ethernet PHYs require a hard reset before accessing their MDIO
registers. When the ID is not provided by a compatible string,
reading the PHY ID may fail on such devices.

This patch introduces a new device tree property called
`phy-id-read-needs-reset`, which can be used to hard reset the
PHY before attempting to read its ID via MDIO.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
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



