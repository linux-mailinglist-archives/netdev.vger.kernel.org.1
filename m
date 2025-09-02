Return-Path: <netdev+bounces-219374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56943B410D9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89A51A82CF9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E2280309;
	Tue,  2 Sep 2025 23:36:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154F283FD8;
	Tue,  2 Sep 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856203; cv=none; b=plBFEvM9KP7nnkWoEyse5bdpIGf26s1Hp7r7URkEWLh8AwuQMfC/IaXf48ZLLjXa3YL0nXeEWECTPhrhuwi4bSNvQNLmj7o0Mpk3ZNDZEwUR70S38pEdpjaHIMhkDjsEi/5i1Q+qbkLSyKe6DTkQOBs3huCkwPnU3rQuOJue+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856203; c=relaxed/simple;
	bh=SqW5rL6tPt8FEZ6wHBs4qEYofN3IQ+erQHIFkyk6/O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmR621UCtZ+KuK4q4Q6X5NoBVk3C0lI2G0r3rrIKVPv37aMdcpkFTTLJIcAiVBpUPCDKQPlk/fNw+zyhs9l4nNIzQzPHtv1WzCBTfprATmMWKiTEWFdiF2LqKDy8MbTOKGoqKvAacUF1vbF9yYiIFiPudeAl/zPS7MLMrupdrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1utaYF-000000001J9-3i0s;
	Tue, 02 Sep 2025 23:36:35 +0000
Date: Wed, 3 Sep 2025 00:36:32 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Subject: [RFC PATCH net-next 5/6] net: dsa: lantiq_gswip: optimize
 regmap_write_bits() statements
Message-ID: <ae2183f4789db2ebac157dc1b99a90a55279bbea.1756855069.git.daniel@makrotopia.org>
References: <cover.1756855069.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756855069.git.daniel@makrotopia.org>

Further optimize the previous naive conversion of the *_mask() accessor
functions to regmap_write_bits by manually removing redundant mask
operands.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 1fd18b3899b7..b26daf39d3d2 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -278,7 +278,7 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
 			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS,
+			  GSWIP_PCE_TBL_CTRL_BAS,
 			  tbl->table | addr_mode | GSWIP_PCE_TBL_CTRL_BAS);
 
 	err = gswip_switch_r_timeout(priv, GSWIP_PCE_TBL_CTRL,
@@ -342,8 +342,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_ADDR, tbl->index);
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->key); i++)
@@ -354,8 +353,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 
 	regmap_write_bits(priv->gswip, GSWIP_PCE_TBL_CTRL,
 			  GSWIP_PCE_TBL_CTRL_ADDR_MASK |
-			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK |
-			  tbl->table | addr_mode,
+			  GSWIP_PCE_TBL_CTRL_OPMOD_MASK,
 			  tbl->table | addr_mode);
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, tbl->mask);
-- 
2.51.0

