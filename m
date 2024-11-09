Return-Path: <netdev+bounces-143483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C09C296B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7351F2239B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053864438B;
	Sat,  9 Nov 2024 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DxrgbW0D"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE85286A8;
	Sat,  9 Nov 2024 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117489; cv=none; b=eKs6JqWfEKStojSRNzzOoM2zBntqWJub2wFgW0/A007ClxDMG/7OJdh1MWlZS6ms9NhPzk/3CTK/LOdrUi0S7AXqfIefE+O+UD4wrx4YJoFgTYwf/VFS56vf5CMSWBOkcqLV2ZtQ9XvJajc9GBCy4Ocrl7w09I4MqHCXUmCAIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117489; c=relaxed/simple;
	bh=bZOmlMjKP7+1DfMV69BCjR8Sth8+h7dMnby4tGDo/6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krpfwFCK49ZPR1DnaTx0AC6T1HMF6I0xF3ul+7R2h0l51rXdqkFcwW2kT7tWwpT1HIDWpwC1Gj/Q0Ukw4Vyj9Jm3jm8BVWWZBYtu2tEOKulAwNo6+y4hoiuKcuN1tTN/We+9ctr3GST8gpvE71DF0DmzX8lFXEFVPIOX0yhsmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DxrgbW0D; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731117488; x=1762653488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZOmlMjKP7+1DfMV69BCjR8Sth8+h7dMnby4tGDo/6o=;
  b=DxrgbW0DCEtQcM/lrBwUdF+LgmmcGd9oMt4r8YSolmIpAgu2Wpo6id/o
   bRlszfEuyIGxE6EfIVKPqbt48j1zly4GZ4KTLpcoQPpPEQOvLIbaZaFJQ
   c34SzpdfFHkwtV/XWiVZ9xit9GzL4EOi4kGD/QfR4ULZt8cCqj0HFUlFo
   oUrGeS6d4PuQT/PFT0Qax7FhiTdcGotRbHDEizX4hHw1pHaeJ21KHffYF
   i+m9JCkmxIRt+1BmvYFqWtrxnBLRS4r3VFGbX8TayMd92czmVxkqYJFxl
   UfCZ33CtvZpCNznCHy7rMQdwziX51b9qQv6fP9CqPHUQeeTTJhUtPY3EO
   w==;
X-CSE-ConnectionGUID: iTjjvxg9S12uJG/WmNjJDA==
X-CSE-MsgGUID: tPl8DJvAQCm4DlFA+GFW/w==
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="37590998"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 18:58:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 18:57:06 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 18:57:06 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add LAN9646 switch support
Date: Fri, 8 Nov 2024 17:57:04 -0800
Message-ID: <20241109015705.82685-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109015705.82685-1-Tristram.Ha@microchip.com>
References: <20241109015705.82685-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

LAN9646 switch is a 6-port switch with functions like KSZ9897.  It has
4 internal PHYs and 1 SGMII port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 30c0c3e6f37a..c3502876276d 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -34,6 +34,7 @@ properties:
       - microchip,ksz9563
       - microchip,ksz8563
       - microchip,ksz8567
+      - microchip,lan9646
 
   reset-gpios:
     description:
-- 
2.34.1


