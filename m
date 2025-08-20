Return-Path: <netdev+bounces-215101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C4B2D1B3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA651711CE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504892777E1;
	Wed, 20 Aug 2025 01:55:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA062777F2;
	Wed, 20 Aug 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654959; cv=none; b=DrFDCzpEVK0wfy1guKpv6UpsaZVGNuS9aoKMRD7BuqZN5P7takRDPmtJiyEo3s7etyPgQ0+9BJAaZBUYxNS7+YOdiFWQEQ4sOlCEz0yDmFD9kOQTx/kGmjDtah2Dfnvi6tUnk/00DTWxri0fFTnpu9wRvZ42xRjBKAf3ByhMMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654959; c=relaxed/simple;
	bh=glFPegpKflaTMd3f1B6r40/dcLUpXl7JFQ4ydtzWQ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgjccFFsjPyC7utB9HtNs48S/hY4OsI+O+3OjwLMvZlMG9z2nazQLIsP8HUNSYCsi2R6sje+5QBv8/KOhRUS2o5j+OyB+hCHL2A5bjT1palHP9k9NQTbqUNfTRmCRsCTlTGHfa2pFciPyJECscrMaMgQWsWl/+iyOZrlwKkSIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoY3N-000000006EQ-0mK8;
	Wed, 20 Aug 2025 01:55:53 +0000
Date: Wed, 20 Aug 2025 02:55:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH net-next v3 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <88e9ca073e31cdd54ef093053731b32947e8bc67.1755654392.git.daniel@makrotopia.org>
References: <cover.1755654392.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755654392.git.daniel@makrotopia.org>

Store the switch API version in struct gswip_priv (in host endian) to
prepare supporting newer features such as 4096 VLANs and per-port
configurable learning.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: use __force for version field endian exception (__le16 __force) to
    fix sparse warning.
v2: no changes

 drivers/net/dsa/lantiq_gswip.c | 3 +++
 drivers/net/dsa/lantiq_gswip.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index f8a43c351649..8999c3f2d290 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -28,6 +28,7 @@
 #include "lantiq_gswip.h"
 #include "lantiq_pce.h"
 
+#include <linux/byteorder/generic.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware.h>
@@ -1936,6 +1937,8 @@ static int gswip_probe(struct platform_device *pdev)
 					     "gphy fw probe failed\n");
 	}
 
+	priv->version = le16_to_cpu((__le16 __force)version);
+
 	/* bring up the mdio bus */
 	err = gswip_mdio(priv);
 	if (err) {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 0b7b6db4eab9..077d1928149b 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -258,6 +258,7 @@ struct gswip_priv {
 	struct gswip_gphy_fw *gphy_fw;
 	u32 port_vlan_filter;
 	struct mutex pce_table_lock;
+	u16 version;
 };
 
 #endif /* __LANTIQ_GSWIP_H */
-- 
2.50.1

