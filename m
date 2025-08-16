Return-Path: <netdev+bounces-214334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F5B2905C
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2867B4708
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27E217F53;
	Sat, 16 Aug 2025 19:52:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904005BAF0;
	Sat, 16 Aug 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373974; cv=none; b=n3dnTBZnZY+jedaBZsgghlug/vFwvyZD+QvAAmIR2xlFNIZQTGrhJJgx4WIg3wGfnj8dGgqgcPcNlj8DbatfMN9zixt/GlYECogPqEnjk0SB1D9XP4kphdyyKO+jYe1SGq+1Q7zrtTMajO//Cm3WkeDTK3T3U6Q+HqjX8PyMo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373974; c=relaxed/simple;
	bh=X756wWPSeXBnHzG7ptugmnntFJLSjtR517BwG5i9y1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p4Z3E7JjdjCdZ2OS+KJYmuYrEea/S0q1SzdIF8kOfPyupD6uu3qOACTfJbHABZ4BWB3di9ci2sg4cP2HPprIh9bzrqVmbTeHIM9ccDV1oFtmeUXJzHS6pEQOFNNz0cigQcGEUNC+SIOZx6aC9hJZ1rmM113xv1CWBKqYQSp0/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMxK-000000006zW-0QQ5;
	Sat, 16 Aug 2025 19:52:46 +0000
Date: Sat, 16 Aug 2025 20:52:42 +0100
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
Subject: [PATCH RFC net-next 09/23] net: dsa: lantiq_gswip: add support for
 SWAPI version 2.3
Message-ID: <aKDhigwyg2v5mtIG@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add definition for switch API version 2.3 and a macro to make comparing
the version more conveniant.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 433b65b047dd..fd0c01edb914 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/swab.h>
 #include <net/dsa.h>
 
 /* GSWIP MDIO Registers */
@@ -93,6 +94,8 @@
 #define   GSWIP_VERSION_2_1		0x021
 #define   GSWIP_VERSION_2_2		0x122
 #define   GSWIP_VERSION_2_2_ETC		0x022
+#define   GSWIP_VERSION_2_3		0x023
+#define GSWIP_VERSION_GE(priv, ver)	(swab16(priv->version) >= swab16(ver))
 
 #define GSWIP_BM_RAM_VAL(x)		(0x043 - (x))
 #define GSWIP_BM_RAM_ADDR		0x044
-- 
2.50.1

