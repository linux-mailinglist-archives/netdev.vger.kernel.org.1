Return-Path: <netdev+bounces-218277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159BB3BBE6
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678F31CC2070
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD492D2497;
	Fri, 29 Aug 2025 13:02:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE439450F2;
	Fri, 29 Aug 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472557; cv=none; b=Ce9QeiFXHRCJadjTpF0tisFWGlC/P5suTXrOiwctD+M8KIpZCqVx3kq++RNbQHT1/68UZ8bVeDo6dvN1b4fpF8GLf+lTDZkrACzM+4tMJAGxtuvmaWdP2YJc/YjVMK8Tb9XoFlZRkC6qyeA/cCk2Flwm+bas9hBih02KdWFDNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472557; c=relaxed/simple;
	bh=n81J9wrGT1o9F6MqU36Lqqdm/p+E3AqEEoB0PrBc0iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu1GOoTH/AKTnVTtfeLV6eP9pZZcmuiHDM6SfW06JHhP+AnYD6dKABYFo/3+gxKE6XBP+G1ptEn4Wsh1Doz+3p1jt7uf/3/ku0UsuAkwzDWOl2smYAzWzIbq8tRSWGIGHuuq2YgTa3wPIx5QSeT96LR6nAmZ669YdLrvZAZ7CXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1urykR-000000002Ar-1Rhz;
	Fri, 29 Aug 2025 13:02:31 +0000
Date: Fri, 29 Aug 2025 14:02:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH v3 5/6] net: dsa: lantiq_gswip: support standard MDIO node
 name
Message-ID: <3c6ac3cc638a4ebfcefbeeb85f36e5c6f27f347a.1756472076.git.daniel@makrotopia.org>
References: <cover.1756472076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756472076.git.daniel@makrotopia.org>

Instead of matching against the child node's compatible string also
support locating the node of the device tree node of the MDIO bus
in the standard way by referencing the node name ("mdio").

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v3: no changes
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 57441afa12e4..2124ee061d05 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -286,6 +286,9 @@ static int gswip_mdio(struct gswip_priv *priv)
 	int err = 0;
 
 	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
+	if (!mdio_np)
+		mdio_np = of_get_child_by_name(switch_np, "mdio");
+
 	if (!of_device_is_available(mdio_np))
 		goto out_put_node;
 
-- 
2.51.0

