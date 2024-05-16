Return-Path: <netdev+bounces-96676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87608C7168
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057741C21D0E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0681C6B9;
	Thu, 16 May 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L+sc/J4s"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB411CA0;
	Thu, 16 May 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715838587; cv=none; b=IQECyvAmGqjCZAUK8ui23obRt5q3+G0ZBhlSy64eU0+RXh878ltbpOpr4goPBvD2HnHb8Mg9d2+IiJNTEhuS6l9LB4qPzEglnUODKUa/WVah2LNHPtoirVvjkDDR+NfySlYGGphtIb5mRJWHoDzvS6x4+VY5AzG+fevc16hluxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715838587; c=relaxed/simple;
	bh=bGmNs+SnBvo+VTHcTY9kx8P0qU3j+ZTkpcXVaGATTEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1fLSWWAJJhDLTgIljXJxe0vlXbu91nk3uTyoDdTBE0CXomk6QiBJlarsJ8QkBHBIZnR7quBEgs1lsI+VpDtq7jWlsH94/8ZA4ejQFSt5e3OdZ1igpf+Xy/HPbSEK1oAkMh0WIsAFpwGkOzOYUNLW1dVjoAjp+y2lTnd74eDBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L+sc/J4s; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G5nbul109100;
	Thu, 16 May 2024 00:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715838577;
	bh=gGT8/7XGQYrvoEXxlVpAOGWP4Mm/PULFazbiHBo15Fs=;
	h=From:To:CC:Subject:Date;
	b=L+sc/J4s8vPaQX6TyDnfDawOhNk0dtvqptfZkc1kssGJ1ZxINt1uVYswRloC2OLVB
	 nycuIAckDZq6iPoyFLjacVwuEGjRpz9TKSeg1e1mJGGXdxlVEzL+kwnZMIStjGqbFv
	 Psze7UjMdie4attryPi0wgiKacuAiw7p+EFo72O8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G5nbds002363
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 00:49:37 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 00:49:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 00:49:37 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G5nW6j085976;
	Thu, 16 May 2024 00:49:33 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>,
        <rogerq@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
Date: Thu, 16 May 2024 11:19:32 +0530
Message-ID: <20240516054932.27597-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update the list with the current maintainers of TI's CPSW ethernet
peripheral.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml        | 1 -
 Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml | 1 -
 Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
index d5bd93ee4dbb..d14ca81f70e0 100644
--- a/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml
@@ -8,7 +8,6 @@ title: TI SoC Ethernet Switch Controller (CPSW)
 
 maintainers:
   - Siddharth Vadapalli <s-vadapalli@ti.com>
-  - Ravi Gunasekaran <r-gunasekaran@ti.com>
   - Roger Quadros <rogerq@kernel.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index 73ed5951d296..02b6d32003cc 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -8,7 +8,6 @@ title: The TI AM654x/J721E/AM642x SoC Gigabit Ethernet MAC (Media Access Control
 
 maintainers:
   - Siddharth Vadapalli <s-vadapalli@ti.com>
-  - Ravi Gunasekaran <r-gunasekaran@ti.com>
   - Roger Quadros <rogerq@kernel.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
index b1c875325776..3888692275ad 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
@@ -8,7 +8,6 @@ title: The TI AM654x/J721E Common Platform Time Sync (CPTS) module
 
 maintainers:
   - Siddharth Vadapalli <s-vadapalli@ti.com>
-  - Ravi Gunasekaran <r-gunasekaran@ti.com>
   - Roger Quadros <rogerq@kernel.org>
 
 description: |+
-- 
2.17.1


