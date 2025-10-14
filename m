Return-Path: <netdev+bounces-229297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA9BDA64F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67A250427E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF23016E8;
	Tue, 14 Oct 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vln4QgwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D63009FA;
	Tue, 14 Oct 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455551; cv=none; b=B2Wgn4binaNo91y2BYaXdkFL0m041yF4wXOg2vahTPZoe0emU/RAuEN0Aw6gxMaG73132XoK83HPjr0gR2UKx4VW92JwtldjcQdftIzFQa9RF/UMdMPOm0YhChBtVHlTeHgYldTcbge6Lk0mmSNJZq8mTieb2caJRsDCXE2FP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455551; c=relaxed/simple;
	bh=+BmgP1cwOI6VJAkhu18VNjfPGCwfgpuV7lA+QJYNabk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/bqIAzIIHZ+DcHXP45xm/3rHVylHEVBq3ld9rupJCH89jjOAUNHQE3Tpxhs9obSQjcPvRM8cSbjcmwtUtdMhPrhKcIQqfY0ca1kAwVL0bXU3zHWrpttafnbW+vCFwIhTIQHVG/070wpDoTaWtsMmyLZXgDx6wWNwN0oQsSpAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vln4QgwU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB8EF1A1382;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEFA2606EC;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86829102F22A4;
	Tue, 14 Oct 2025 17:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BDLjVHEfWE+OX2EBzF2dDXKhMxIya0aonkUpZfjwFpc=;
	b=vln4QgwUJ3MGIz+BpttXJ1iUA6zRlssetcE0sHykllYoICGqYZ76acIeYhnJcNaM9NSh2X
	vjrIrErW91LO3QJZTJMLHvVh8dJGksfpL+qAOrl5JyIdBZCZyXD+rj9q4nXK+7pPlZvMFL
	Uu8ZBVZ5tTG3wn+emjJxzyZV4u7HrZwDl6QxjFNO9NH2UkHy1nTDAzL+tMaE547TFNfrbr
	YRYtGQuiILsE6AKhGB69QvAvFBzRcTEbi3rGBKKC4E0y0+OE5IohNM6Yj0R7z0CIvT5b20
	1uHXmtFntMUQgrqokSotoYOFA+UNTsJ7QvksKCCd+7NiIY/MkxQyB39FexykBg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:02 +0200
Subject: [PATCH net-next 01/15] dt-bindings: net: cdns,macb: sort
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-1-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Compatibles inside this enum are sorted-ish. Make it sorted.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 1029786a855c569f32171cd3484b0043622e9fc4..02f14a0b72f9c5c489c2e9a605d7f020c124fe31 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -47,18 +47,18 @@ properties:
           - const: cdns,macb          # Generic
 
       - enum:
-          - atmel,sama5d29-gem        # GEM XL IP (10/100) on Atmel sama5d29 SoCs
           - atmel,sama5d2-gem         # GEM IP (10/100) on Atmel sama5d2 SoCs
+          - atmel,sama5d29-gem        # GEM XL IP (10/100) on Atmel sama5d29 SoCs
           - atmel,sama5d3-gem         # Gigabit IP on Atmel sama5d3 SoCs
           - atmel,sama5d4-gem         # GEM IP (10/100) on Atmel sama5d4 SoCs
+          - cdns,emac                 # Generic
+          - cdns,gem                  # Generic
+          - cdns,macb                 # Generic
           - cdns,np4-macb             # NP4 SoC devices
           - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
           - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
           - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
-          - cdns,emac                 # Generic
-          - cdns,gem                  # Generic
-          - cdns,macb                 # Generic
 
       - items:
           - enum:

-- 
2.51.0


