Return-Path: <netdev+bounces-65060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78A83906E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA05A1F213EC
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DE5F860;
	Tue, 23 Jan 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="LsdP6EjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265345EE92
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017830; cv=none; b=t8gM2RUS3zrHNv54Twg0K+ukUKVYmkXKNmQdHAAyueWo+irQK3YYGaImhQIc5nwgeImDh+tvn2vw04lAxUJoRtrJksnrm3jVNylnrLs4nLFCoLnI6ksS1kPG351OylMYkn/l3N8vN9E4xpw/Su+7jN31FU1RZJ3kdHefch4SUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017830; c=relaxed/simple;
	bh=LjhC1jDaXjp11zwHWnmEkccOYnM+1J/uiTXo3eT0lfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iNJn/9NNiFZvUJe5DvE7ua3TujIPY/9AAs/pB4s5J3iRekn39FCnIW2Nprgrp06+h2cjxyv7WL/IJDlRED2XLEHhdDbWijhST5JU6r4W2E4ziHmerepVEismWzfricuRP3R5447ZC6ouQW+u0s3JzYd1b3Zjsg1jUyYkwKB2lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=LsdP6EjA; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK7kz23cLzMpvZR;
	Tue, 23 Jan 2024 14:50:19 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TK7ky1Ds2zMppBZ;
	Tue, 23 Jan 2024 14:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706017819;
	bh=LjhC1jDaXjp11zwHWnmEkccOYnM+1J/uiTXo3eT0lfI=;
	h=From:To:Cc:Subject:Date:From;
	b=LsdP6EjAqB46MQ8ZQkcFvTTgfsAgYFPC3amz7zJRhFaGiicuvD/a3YCx/Qqx+yVeK
	 5T0XYHSPS/EJaJujI1wpp1nLx5laTQn5VoK+2AXEnyqGjWfJo+nKo2QHJqfTOaFIL7
	 HwL5Wzc7etOlm+vnsh6zrM1yl7OyornibrS5itWs=
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>
Subject: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567 switch support
Date: Tue, 23 Jan 2024 14:50:13 +0100
Message-Id: <20240123135014.614858-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Philippe Schenker <philippe.schenker@impulsing.ch>

This commit adds the dt-binding for KSZ8567, a robust 7-port
Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
each capable of gigabit speeds, complemented by five 10/100 Mbps
MAC/PHYs.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
---

 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index c963dc09e8e1..52acc15ebcbf 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -31,6 +31,7 @@ properties:
       - microchip,ksz9893
       - microchip,ksz9563
       - microchip,ksz8563
+      - microchip,ksz8567
 
   reset-gpios:
     description:
-- 
2.34.1


