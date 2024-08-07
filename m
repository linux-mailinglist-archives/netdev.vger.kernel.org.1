Return-Path: <netdev+bounces-116633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E594B38D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF32BB20E89
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85222156257;
	Wed,  7 Aug 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tQaCeS04"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166A155C83;
	Wed,  7 Aug 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072844; cv=none; b=bo+aTYvuNncFlJudMNtvil14qE/Mp/QRCirz5uPeA4GI0C2I1PRE8lRPNYqMxvsR9wuQ60rRaUoyFO8Xqkhc7dAktEJFtb+rbY4sujsAfAxaVAvz4faI7uW2F03f4AH/HCTd2s06qBbhB4272pH8F/MtOHirKNBKEcuO1LEGX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072844; c=relaxed/simple;
	bh=Mgs1lNnhWggFlDV9vg7amh0jKUngzBpu0PzJAxQ4z4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9h9Sg3P2kgZZaGut8Yly8fa4dZF6ChOklRf4Z0ja5i6NBeZefB40vrQmxp+doFHtWtwKhEvvtJKONOsBCFB82AjdVZvY55yp0GN36EZmaG8OkXfQJUgnmswF0jrzqnxoL13nBAzfMCXgUe/hCLq/Dh2oKkc68jR7kPbHyB/Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tQaCeS04; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723072842; x=1754608842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mgs1lNnhWggFlDV9vg7amh0jKUngzBpu0PzJAxQ4z4E=;
  b=tQaCeS042ZHXh7yoq4Th/RWfulFBp6AU3RA1sPfv78KwH2FKKehnJpmm
   IA6l8B0i3zRM96nKooCE0aIUTJ3R5v9lgH2wZ5An5TBhTWjHJOiPBOUw3
   RJ+GqZ19fdmhkrRUr2ZbxdUOtj+LCNS1dHTFXn86F+XOeKgj4b5CXFlWd
   qUmO4oazrEc18hVBmRJpIBqga8lw25TY6GJIp35tBkIM/okHSvydMYT4S
   bQ99giF9FQozIfZnWekDVPOBIrlSfaFnbqvj+AAeCRrRdR9jcNn8fXjBa
   t0IsHGKczeHaJcVhuSMIOu1TI+qvXtMGyMIFseX5fN0DQNf6bM0cvVrei
   g==;
X-CSE-ConnectionGUID: 6+Ttp1hWQ4GNKoiN1h/CJw==
X-CSE-MsgGUID: 66uWv37cQVKWofNfPVtKLA==
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="197649399"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2024 16:20:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Aug 2024 16:20:16 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 7 Aug 2024 16:20:16 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 2/2] dt-bindings: net: dsa: Add KSZ8895/KSZ8864 switch support
Date: Wed, 7 Aug 2024 16:20:23 -0700
Message-ID: <20240807232023.1373779-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807232023.1373779-1-Tristram.Ha@microchip.com>
References: <20240807232023.1373779-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
KSZ8863, so it shares some registers and functions in those switches.
KSZ8895 has 5 ports and so is more similar to KSZ8795.

KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
while port 5 remains as a host port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..bbd6fd9e6894 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -21,6 +21,8 @@ properties:
       - microchip,ksz8765
       - microchip,ksz8794
       - microchip,ksz8795
+      - microchip,ksz8895	# 5-port version of KSZ8895 family switch
+      - microchip,ksz8864	# 4-port version of KSZ8895 family switch
       - microchip,ksz8863
       - microchip,ksz8873
       - microchip,ksz9477
-- 
2.34.1


