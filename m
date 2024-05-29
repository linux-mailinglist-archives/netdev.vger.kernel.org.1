Return-Path: <netdev+bounces-99013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A137B8D35CF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CACC285CC3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EC1802CD;
	Wed, 29 May 2024 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t6Aj1vaX"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193521BC57;
	Wed, 29 May 2024 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983566; cv=none; b=YhbCBklFGDuigWuEcOETlrC6IHmmRAY6YnXAw4VP7JPSqskD7WKIcTU+379wBxoQ+iMBmLwns5oXR7299qwlvrPucXJGGWIv9akpNgZbPC88eeNM0MoVT8oILEfhzMrrlFq2Ia5CsVsP6aquEv+ss7f2LCN6DF0SFMo+ldC8d0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983566; c=relaxed/simple;
	bh=5eDLRBYhIVQ3QQ2O7mX5QXA9X7E9suKrVldiDYkkjzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XF/bsCmG4a1kltW33mGHHhQZm929bLIGRMWfYdUGRnJp+Jw4hL7Nz48E9v1FEvO4c8GeNi07LMCpw0dlp7XEM3JJsme9oJH6tN5VMrBEnn2DKXkqUXUZS6jKm7q+HLRXzSd9SiVYsbotO5FvtNoHw2o3jndGlkLqjOs5v580c5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t6Aj1vaX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TBqTNh017656;
	Wed, 29 May 2024 06:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716983549;
	bh=492u3+4ciexuks2Qycy2dXeM3XfJAK8wkoTvSffRL7o=;
	h=From:To:CC:Subject:Date;
	b=t6Aj1vaXLBKlZdCQKJKjT/rTPXlzI+dMgt75wjX7ktJwOpS9LPUyplkiLxuK5PKoK
	 SeNjOHfDe+oTT+EANGLoxYyTGx84Qn2ggGJEiaEy0pj4yCSv6EXnLQU/RDs0sCdTT6
	 VIaXSg3NKttLuKM81O64YjfZ9Qts3c1GDzlBi4To=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TBqTxZ002382
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 06:52:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 06:52:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 06:52:28 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TBqSbN098486;
	Wed, 29 May 2024 06:52:28 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44TBqRvI009008;
	Wed, 29 May 2024 06:52:28 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v2] dt-bindings: net: ti: icssg_prueth: Add documentation for PA_STATS support
Date: Wed, 29 May 2024 17:22:25 +0530
Message-ID: <20240529115225.630535-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add documentation for ti,pa-stats property which is syscon regmap for
PA_STATS registers. This will be used to dump statistics maintained by
ICSSG firmware.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes from v1 to v2:
*) Updated description of ti,pa-stats to explain the purpose of PA_STATS
   module in context of ICSSG.

v1 https://lore.kernel.org/all/20240430122403.1562769-1-danishanwar@ti.com/

 .../devicetree/bindings/net/ti,icssg-prueth.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index e253fa786092..c296e5711848 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -55,6 +55,14 @@ properties:
     description:
       phandle to MII_RT module's syscon regmap
 
+  ti,pa-stats:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to PA_STATS module's syscon regmap. PA_STATS is a set of
+      registers where different statistics related to ICSSG, are dumped by
+      ICSSG firmware. PA_STATS module's syscon regmap will help the device to
+      access/read/write those statistics.
+
   ti,iep:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 2
@@ -194,6 +202,7 @@ examples:
                     "tx1-0", "tx1-1", "tx1-2", "tx1-3",
                     "rx0", "rx1";
         ti,mii-g-rt = <&icssg2_mii_g_rt>;
+        ti,pa-stats = <&icssg2_pa_stats>;
         ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
         interrupt-parent = <&icssg2_intc>;
         interrupts = <24 0 2>, <25 1 3>;
-- 
2.34.1


