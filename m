Return-Path: <netdev+bounces-112981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C54F93C1B2
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05AE283860
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FE19A297;
	Thu, 25 Jul 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y9kms3c5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4D132492;
	Thu, 25 Jul 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909840; cv=none; b=Y/p2Ljbdlt1LzROdAKwq0cvgydYE9DEkPbb6BCpRUE9TN6nvbXPNPI1VA5q9V54YAGk5dN2WUlOdbYuzCaNCEaQTVsGGJWPdPh/ZsvcuAYGWLZGKg3gDDiqVtGs9G42D/cxqzgQv1to8JjHBidQaIU/fRSrwPDrX+7Miu05FTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909840; c=relaxed/simple;
	bh=PbDC+OU+YkMqHYYMEOkJQVzAl13ER65O2n0MP/mrDHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcpKQ72VSh4ByKLTuLIH6Ub+jMvoaCZcIXVNAuFVHiJDfSavS2ml1sMU87cdc960bturnrIDkW47mkUiyitqH7xJThehmsBLx1zK9o2+YBQ/Y9Lo7zQA6LRK0LWwbMAB12X6kpCJhDSjXxUXeHVXbKTYj73/PYXPPDYeO8hZxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y9kms3c5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909838; x=1753445838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbDC+OU+YkMqHYYMEOkJQVzAl13ER65O2n0MP/mrDHw=;
  b=Y9kms3c5Rm8q27T9wjtAYPBnwCAz4qpQaPxn7BXw0HjGdvderTVVp+Kz
   6RP6K4lbTjSrLiOEz7W8JBdbz6Du6YZUpNJnHn/9qybV1YurkZaxZlWcr
   1U6UgVJw95AuyXBEydY/I6MajGIUWLiK9UMhUXMlrCQUnx4v7r4MKl9Z8
   Eoe9wgHNJiUMUZK1EAkBTbC5pwEKUR/DtclCo5nhwxGEmFFLorHZQI/Bi
   QV6mCSZv20iOawF/HDc/wv6TvmJUk+CzqybFC51jj9Q5xfkBAs0iz9oMZ
   cLIqwF29HUAmBfpU6v8XVR7jb2ZSdROeoHUXOmU3xSgfJKPBQFOVVJdmH
   Q==;
X-CSE-ConnectionGUID: FjEJXt1iShuJypsmHj+1Bw==
X-CSE-MsgGUID: 4BBn66O+RLOcBqC4pXHshA==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29650436"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:17:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:49 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:46 -0700
From: <pierre-henry.moussay@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 12/17] dt-bindings: net: cdns,macb: Add PIC64GX compatibility
Date: Thu, 25 Jul 2024 13:16:04 +0100
Message-ID: <20240725121609.13101-13-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX uses  cdns,macb IP, without additional vendor features

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 2c71e2cf3a2f..1463353df241 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -38,7 +38,10 @@ properties:
               - cdns,sam9x60-macb     # Microchip sam9x60 SoC
               - microchip,mpfs-macb   # Microchip PolarFire SoC
           - const: cdns,macb          # Generic
-
+      - items:
+          - const: microchip,pic64gx-macb # Microchip PIC64GX SoC
+          - const: microchip,mpfs-macb    # Microchip PolarFire SoC
+          - const: cdns,macb              # Generic
       - items:
           - enum:
               - atmel,sama5d3-macb    # 10/100Mbit IP on Atmel sama5d3 SoCs
-- 
2.30.2


