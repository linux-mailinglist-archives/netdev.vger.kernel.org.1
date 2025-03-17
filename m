Return-Path: <netdev+bounces-175167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E5BA63C9E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 04:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D6A188D0B2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B11A0BCD;
	Mon, 17 Mar 2025 02:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89B19DF4F;
	Mon, 17 Mar 2025 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180380; cv=none; b=XJ0D5RevuUIp63MV2SA9i6ARh+iKcbVA3bjy39zpSmhIFumZOGkIXO3wHVm/x5vh9uF4VQRE1E/jQdXVlo83xhatOKxjXGNKXcDVGX/u7IXACRudvoK6hTQvJu/RZm0YfYbRpnCqM/HJbw28kyNaok8VKex8BQW/8W/9GaLrsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180380; c=relaxed/simple;
	bh=GD1LW0vXw+i8B82pbsRQhzGQDzuNi7BRqQCRXF/tsfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEmXYqVZKq4LBdp9tNmiyjER8bK3bBQ5a/7lkVc62XdXBSt4RUARIh+i37LmUCGroH0jjtIJOVSGtWxmv4FZ0PTr+Usr/nqUAXoBT3ID96OoW/Mu5PkOiFCPqtlQAMNABrRy8RcUDdUQ31//lz1WrAAns75CkByV0M7ZahjW2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay properties
Date: Mon, 17 Mar 2025 10:59:21 +0800
Message-ID: <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add tx-internal-delay-ps and rx-internal-delay-ps to
configure the RGMII delay for MAC. According to
ethernet-controller.yaml, they use for RGMII TX and RX delay.

In Aspeed desgin, the RGMII delay is a number of ps as unit to
set delay, do not use one ps as unit. The values are different
from each MAC. So, here describes the property values
as index to configure corresponding scu register.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/net/faraday,ftgmac100.yaml          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..c5904aa84e05 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -66,6 +66,20 @@ properties:
     type: boolean
     deprecated: true
 
+  rx-internal-delay-ps:
+    description:
+       Setting this property to a non-zero number sets the RX internal delay
+       for the MAC. Use this property value as a index not a ps unit to
+       configure the corresponding delay register field. And the index range is
+       0 to 63.
+
+  tx-internal-delay-ps:
+    description:
+       Setting this property to a non-zero number sets the TX internal delay
+       for the MAC. Use this property value as a index not a ps unit to
+       configure the corresponding delay register field. And the index range is
+       0 to 63.
+
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
@@ -102,4 +116,4 @@ examples:
                 reg = <1>;
             };
         };
-    };
+    };
\ No newline at end of file
-- 
2.34.1


