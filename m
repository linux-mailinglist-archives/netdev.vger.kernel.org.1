Return-Path: <netdev+bounces-214341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD9B29072
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B71BC2570
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCA22539E;
	Sat, 16 Aug 2025 19:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB37224B05;
	Sat, 16 Aug 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374137; cv=none; b=Vvv/oZsKBXmLTJ6Otqkzbm2tC+HUUmtbCbh+caGBQPrAUnDFqUWL7EpXaTvHJUld9pCLe3U6skQjfG6FPG2hSMgE0tGcvcy4fku7yo2VwIOVsOhWoCoGhnyDl5AUjLlZk20JDU5mqNhZfQDzTzDzd8iJhfxkjlTTj0AOmcot2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374137; c=relaxed/simple;
	bh=C2hi06NHKWZv4QV/rUzcooeb5Gf8dnGCCTK0sPLTOfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ccNoe3wEsBBr23ympTv0XajaxrWi3Oyhs24Nv1f6LiBbFxXfoeJK0O3b4mK3UtfLHkNig9NQCuBC97GQYwMiOJ3iDzX2GH6ZbftGpPq2DJPVnfjpY26hSLRPGr8b3Scvgkr2Mxmr6XgBtQkIg0g+I32CVRA0riZqDtfBkrvbeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMzz-0000000075g-1owe;
	Sat, 16 Aug 2025 19:55:31 +0000
Date: Sat, 16 Aug 2025 20:55:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH RFC net-next 16/23] net: dsa: lantiq_gswip: support standard
 MDIO node name
Message-ID: <aKDiL76zC3ZiwQHk@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Instead of matching against the child node's compatible string also
support locating the node of the device tree node of the MDIO bus
in the standard way by referencing the node name ("mdio").

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eae4fcb99e6..4641068d711b 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -288,6 +288,9 @@ static int gswip_mdio(struct gswip_priv *priv)
 	int err = 0;
 
 	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
+	if (!mdio_np)
+		mdio_np = of_get_child_by_name(switch_np, "mdio");
+
 	if (!of_device_is_available(mdio_np))
 		goto out_put_node;
 
-- 
2.50.1

