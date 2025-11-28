Return-Path: <netdev+bounces-242559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5EC9215A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66DA04E3902
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570332ED4C;
	Fri, 28 Nov 2025 13:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB0302140
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335519; cv=none; b=AchV6Zqi9GyTrK61O2KPBIsZDhQBxVgAspSIFhOT2ZXbkFH/ab0RZx8dFGBwvkdhSMKzh08V5F6a1h7wlINaAkTZ91gCQ+FAgn9U9B84t9jACl8ZCVm5bfMna9LGIDQMBoEO/zdMQJcAmw37xPUqeHqwgniGtVM27AnSMu7oBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335519; c=relaxed/simple;
	bh=2lBBGtbpdV5DXN7KxOXjZ1azz9sLuN4ZCOjMsuSwRi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmFBVEYmWpZACW9U+0VhbDWZBrJ5QiIrL2hcLL2gwSP7xPT6dCvWRIKBz+6qdDxoY8VMpxoKjkqX9Bj5ZmjjNpYhWWSPL311qiHeaXt6iIENx+oNsZpfB8hdz32l0CTYQ6evdKtlA5DCacblX6cPT8eXNGb/GV01CvKhmd5P+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c75dd36b1bso1125550a34.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335517; x=1764940317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKWeKuaV2cQ3YWbYkDtqBuXi57iQyEyQduoVGOATIxE=;
        b=nC/MBahsYOdlFSVFDJHjgoo8roVsbpR4tv5eF9Xk+uoUrRqJkVGPXMfzHn5S8qbUC/
         OEfppYlpYBTLO3sivdzHSWr58ZEhDp6D7Y+NJlTxnvt4BEVUyS1yINyU7WV9UzpJkNJg
         MdzKsmPJMtLD2uB0auOY4PEsiBvYhrrvt8CJD/ydYIcZoYbjVKKSigzIOorduca7scIV
         h7K2PvwGwELolMwOzEVcnXo+lO0lGZroo5ynPmw78YsZAxud5m9uehdBZPP9jJY+CFcJ
         DflE6dcQDe8BLDUlNOVkg0GYv5rr6uOY//pQ1Xb7bzwJ6Z8bVdd+7T9JsiGfslUSCCMf
         IZ3w==
X-Gm-Message-State: AOJu0Yw2kHTFV/QWjCkk+Xav7zvnpzYSx7Jvy9Knf/aDZQvBkx85SJ1s
	FSZFZyfAtSoBNay3PsOS2TkkXtZabCp5sy66bjvP1robIZQrpDux9AeE
X-Gm-Gg: ASbGncvTPBU2dE4Ml6kKbOYr+vv7iS+SAgwezF5L2D5xxLw4j9r+N/5uz+JKC8UMYrY
	zac2LwAJcxrcrLUv5+ioijOXvNeTZqTL+quXrusHyOLSQ4PSkeIiLyY1duYdmw/8AiZMtEuYkgU
	57QZ7F1BInFCAWTH23A2GV7n+Zs3oRYhpI48wNvNw6PkxG/3zPpjMYWSSz4yg6N0sdC4P9T53/X
	NIRNxbSXZm/HHsSJCZw3AUU6JmOkv2nGNp4vQe5C1ROa04pAX4KtfogdDJ0qM08+Y0rcf8724Nn
	D38Nrkrm/KZw5XlVqM9N0fa4K2UvBacRbM7EgzpwMztWzJEFJYlWttWc3XfB/ClS2gNXTm8zQOX
	JH+3I1sLH0uaLNKpe3ChjyYVoo6n5pKLYUo3Wb7CldgbKCBJueUP6LaY7x4h33lrf+X08+usFQh
	Ak1xRZK53gU4lu
X-Google-Smtp-Source: AGHT+IHDt9muzXLpJ08dmr9nRH8MkfCKvdJMJZIyqcjd0o7V9rE0bBdangKbYLhxGraSt3y37BIhuw==
X-Received: by 2002:a05:6830:6d4d:b0:7c5:2dbf:4a7d with SMTP id 46e09a7af769-7c7c4417c31mr6805059a34.31.1764335517098;
        Fri, 28 Nov 2025 05:11:57 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0be23sm1511333a34.21.2025.11.28.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:11:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 05:11:47 -0800
Subject: [PATCH net-next 3/3] net: enetc: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-gxring_freescale-v1-3-22a978abf29e@debian.org>
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
In-Reply-To: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4346; i=leitao@debian.org;
 h=from:subject:message-id; bh=2lBBGtbpdV5DXN7KxOXjZ1azz9sLuN4ZCOjMsuSwRi0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKZ+XG8PkTM2KXwRPs2dFLtodOxmqdrpX27ZJY
 taWCXZxoGWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmflwAKCRA1o5Of/Hh3
 bSndEAClw2hjYW556ZDCm2/Y9wBZPq0WKjWqpPllMXBmXd1CtlaBezODOYDokvmipIJgGBCS8qT
 GW10XgdAPneR5lCwYhPhg2YRNY5ngl3kthjWLtafM6eIFm+mPSuj2N3KeRUDS9aoG+fEapuGvQ4
 oq8OGBVVsYMRDCGFNrVuPcMUA7QaBnmmWtMwy/8ErhsoFecZ//jUw17o8eEuGLDEbMLcgqGBk+w
 ZXaJ5wwDIPUvGQL2gdbbjkvlTSnNHJg3wypPpl902wpl7xMJPk4/dS5VDtXDX3v4RlkOwRYDosp
 DCpizVVUXN9gvEB7z7qTrAn/aATrmuueyxmTR7h2ZqEax/RPYlMgCzB5lnyiJVUTi/ehvwtWand
 IAwArJZUFka2UtVpQ9YDsA4JIDrjz835URE3xktqkPjI6mYVapccVvaKfl4H5O72Be5rn3HQ25/
 BfvShnuXVlWyBjzFx89EgSpgUf0YjGZpm+t7WZ22XZQ3KXvnyGcKCF2tf2BUbo+tzS22AtlY7hS
 moVzHLG5Hx1mc35XOZNGrlStlyzkusaVGJpwVYHkrRDhseAl8PqJpHJt6GIqYCXscTh/2vrRmPH
 rYLeDMOppmyKKcKGhldDx365OSb46X2ykc5mWmyhhnmE0KELQXj2gGlOYCHWWos1lhoFJYNPR12
 8Rw6ShiqDaujgcg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the enetc driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc for handling
ETHTOOL_GRXRINGS command. This simplifies the code in two ways:

1. For enetc_get_rxnfc(): Remove the ETHTOOL_GRXRINGS case from the
   switch statement while keeping other cases for classifier rules.

2. For enetc4_get_rxnfc(): Remove it completely and use
   enetc_get_rxnfc() instead.

Now on, enetc_get_rx_ring_count() is the callback that returns the
number of RX rings for enetc driver.

Also, remove the documentation around enetc4_get_rxnfc(), which was not
matching what the function did(?!).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   | 37 +++++++---------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 3e222321b937..fed89d4f1e1d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -633,6 +633,13 @@ static int enetc_set_cls_entry(struct enetc_si *si,
 	return enetc_set_fs_entry(si, &rfse, fs->location);
 }
 
+static u32 enetc_get_rx_ring_count(struct net_device *ndev)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	return priv->num_rx_rings;
+}
+
 static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 			   u32 *rule_locs)
 {
@@ -640,9 +647,6 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	int i, j;
 
 	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = priv->num_rx_rings;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		/* total number of entries */
 		rxnfc->data = priv->si->num_fs_entries;
@@ -681,27 +685,6 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	return 0;
 }
 
-/* i.MX95 ENETC does not support RFS table, but we can use ingress port
- * filter table to implement Wake-on-LAN filter or drop the matched flow,
- * so the implementation will be different from enetc_get_rxnfc() and
- * enetc_set_rxnfc(). Therefore, add enetc4_get_rxnfc() for ENETC v4 PF.
- */
-static int enetc4_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
-			    u32 *rule_locs)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-
-	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = priv->num_rx_rings;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int enetc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -1335,6 +1318,7 @@ const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_rmon_stats = enetc_get_rmon_stats,
 	.get_eth_ctrl_stats = enetc_get_eth_ctrl_stats,
 	.get_eth_mac_stats = enetc_get_eth_mac_stats,
+	.get_rx_ring_count = enetc_get_rx_ring_count,
 	.get_rxnfc = enetc_get_rxnfc,
 	.set_rxnfc = enetc_set_rxnfc,
 	.get_rxfh_key_size = enetc_get_rxfh_key_size,
@@ -1363,7 +1347,7 @@ const struct ethtool_ops enetc4_ppm_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_eth_mac_stats = enetc_ppm_get_eth_mac_stats,
-	.get_rxnfc = enetc4_get_rxnfc,
+	.get_rx_ring_count = enetc_get_rx_ring_count,
 	.get_rxfh_key_size = enetc_get_rxfh_key_size,
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,
@@ -1386,6 +1370,7 @@ const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.get_sset_count = enetc_get_sset_count,
 	.get_strings = enetc_get_strings,
 	.get_ethtool_stats = enetc_get_ethtool_stats,
+	.get_rx_ring_count = enetc_get_rx_ring_count,
 	.get_rxnfc = enetc_get_rxnfc,
 	.set_rxnfc = enetc_set_rxnfc,
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
@@ -1413,7 +1398,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.set_wol = enetc_set_wol,
 	.get_pauseparam = enetc_get_pauseparam,
 	.set_pauseparam = enetc_set_pauseparam,
-	.get_rxnfc = enetc4_get_rxnfc,
+	.get_rx_ring_count = enetc_get_rx_ring_count,
 	.get_rxfh_key_size = enetc_get_rxfh_key_size,
 	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
 	.get_rxfh = enetc_get_rxfh,

-- 
2.47.3


