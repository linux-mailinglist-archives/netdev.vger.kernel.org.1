Return-Path: <netdev+bounces-163129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C062FA295DE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC56168239
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409E1946B1;
	Wed,  5 Feb 2025 16:10:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8322193436
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771804; cv=none; b=tXzkVfSDZgnvq9chRxpagfvWKIHzWDtf8/Ifnm17EFL79bWaWpSRlSZyAlBgn3wMxtKj/WYcgY0r7z2ISLv8SLaFelYif5MXymSxF3iupXbwYacMNF8iE9EiMU8cEmj/NM3y/hzuVr0ch8HVLcrqg6aL30stBwGlICvgvpiEMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771804; c=relaxed/simple;
	bh=gP5Jx/RTaGVadp6ITV3o7rEpXX0n34qFkAHj15QpqYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwjZFd3NEOYQvovRhLI7NkEZX+p7RfbrmMcjdWGEyrjXvPzO/KjwjQVdOrF6/iCIYYq8VtRyh1/CIZQHMA+LNva8yIjH6Yi9FmaauzlxW+hktY6OMYvHpXleu3wi4Fk/8RxKYsAW7xs6te6AL3ZFPrXvogFvuhQheiW9a3ZIHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fa11:c14e:2df5:5273])
	by baptiste.telenet-ops.be with cmsmtp
	id 9s9r2E00V3f221S01s9rqQ; Wed, 05 Feb 2025 17:09:54 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tfhy7-0000000FwpE-1tNH;
	Wed, 05 Feb 2025 17:09:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tfhyJ-00000006dgE-25U5;
	Wed, 05 Feb 2025 17:09:51 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] net: pcs: rzn1-miic: Convert to for_each_available_child_of_node() helper
Date: Wed,  5 Feb 2025 17:09:47 +0100
Message-ID: <3e394d4cf8204bcf17b184bfda474085aa8ed0dd.1738771631.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify miic_parse_dt() by using the for_each_available_child_of_node()
helper instead of manually skipping unavailable child nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 74a1c28ffc014796..991f05a40c758ccd 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -472,13 +472,10 @@ static int miic_parse_dt(struct device *dev, u32 *mode_cfg)
 	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
 		dt_val[0] = conf;
 
-	for_each_child_of_node(np, conv) {
+	for_each_available_child_of_node(np, conv) {
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
-		if (!of_device_is_available(conv))
-			continue;
-
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf) == 0)
 			dt_val[port] = conf;
 	}
-- 
2.43.0


