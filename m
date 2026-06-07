Return-Path: <netdev+bounces-296309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OJ8zHILIJWpYLwIAu9opvQ
	(envelope-from <netdev+bounces-296309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 21:37:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A778651658
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 21:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PV0yGyrp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296309-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80AD630022D4
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681F31E820;
	Sun,  7 Jun 2026 19:37:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8842DB798
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 19:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861056; cv=none; b=T1cG5jBmoWQ4j/kA5KLvB/FVcNLHGqcKRvDlAGznpyKIv74CeKj/q/RdGZlAHLy17JNntyop2f43D5fsUJBPG/+dvPxoHyPC3wyEcW3u7XhpdnX+Kyv7IJeGsrEeJPm7vfrb4orkXNZzrTFMiOBUs78uAhHvHN1n4lfwiwyRTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861056; c=relaxed/simple;
	bh=TzvQakJ1S+Nsey6Vt7ynoW4v8ZmbADwjeVvQIRX45Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYocfoVvoalZaXT0TsEM/CESR7cvto+/omUG+LUiNPA4eo54RVS2cQ/7YgW9+3tIPJ5C4hSlJHlALVdqg4Djx8yOcQ2/OjnvvumQg17qxaQat/NmQ+4ahofy8EvKhZyJD84NNa2u90X8hkyau3ZYRmFp3BxMKjg9OHE/dUHL6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV0yGyrp; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842307473b5so2444369b3a.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780861054; x=1781465854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kewoD/JaIrVG2iWe454sEs6y3jw5rtHEnURmpvnmVNo=;
        b=PV0yGyrpIRRgZpF/C70DQA8rz8caUKzHVIpLeIMhltfxKUTlICTRqp5JwcfHc15Z31
         EkBaGji9UUXohJyMn+OmOb2jPhuhrgE30xbq5uBM8h641M1UmYz9RqtyaKJIPgOyn+XV
         vpBZgd3AUQltCeKsAUVoXELlRbP0Qm6hvAXbwvGodUuj7qlZT7WldqAC3rzCJTmGPmOA
         vEL3lrlCmRIdxs1Q+VHpzzSIyQzEuQK4piJu40kELE0hrd/mXskPIyIXpycX5TG0gLA5
         V06IauUZBcIj5HDeSvl47JXz4UpcVvd9IaFNqYvPnzVYgmeYiFE2T1DTBu2D6IGLhF+3
         3sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780861054; x=1781465854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kewoD/JaIrVG2iWe454sEs6y3jw5rtHEnURmpvnmVNo=;
        b=dUV/eyuNXrHHWr3y0HId7pedMG+8BK/u3el0FCCwpG0OvqRGJgSnGMFLlUbTr3b5UK
         3mKL73Wg7DyCL9zGaWbezlAgn+4NGp5GZHI9j21ldQMHZFFweSHQV4U0y/i9Ghj5jLGz
         1LLOjOXHGsIm0zm1ey3AGSnkPXOlIVJD+ETBijZtm5PvIGMmuSLvqo17P64Bd4Z5qsvc
         rGyv0UOTnwDem4udDDYlNt41WvaQAo6pp0QfLEhoQLcwzKbQ/bkkYj4Ebu2OreShSewu
         eMmOHClKxYB51KhiB9eD/Xy4vM4iD3lxiBO02G7pc89jOnR7LPEvN0ALjOBpx188x+Nb
         wmxg==
X-Forwarded-Encrypted: i=1; AFNElJ9Or1+FNFDhwOEZO8xVvoDNygqwJnxd9amISDwYeW3mHBih83O/KU3XxOxgQpSkP7FuQsmmpkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbYopWBx5iU2wIbHc04FCRfu8vwsHuIYPnj5M6jSxJh6rgWHN
	hAQUEoaYK7YNsJgSnsCyiTlkSveIErpmVpp9V1PdB5DJt8xu5emv6nnn
X-Gm-Gg: Acq92OFfXfD3QMK217Ok0CMUUCn1r6IW0/H1c8qrZeKTJUnoLu9qr6CG2FeA5TsSj/X
	Gffzj8WKKloq1wAuO1jZ3cUIYpzYeoLLVtZiqxXJeNu6e/AtlOmEhL8b/QTp11/99DA9aUEasuM
	9sO0TurS14LWfzXWfd1TFzfrBLQjlonlJodxTS2xxrUpSkIx3Dc5baB5xkmsYR2TQlz9kI1Ei4q
	6aiSAjAc5XM3OoPTCN+xcHBk5sY+XGke/Z2UCSJGj8TcTsAQI9UmsbhssxbSTh11MJK6BnwSQNz
	BkuB0gWtCJ87WSNskydYeCQc4gNUMZ7bNRR4MzdJF145CDHc593qw1JjzRRYTiO0f8KTds8nTFX
	4+O+2/P5PRmsrNYvwa02dWkynXRFsVKOaGZiNzfz0pCncV2Y/fkKgmSJ8AsE7/Beg5jaBJYLrxC
	WwSP4mqtV28q2rN/6UNOYTHFsvRKi1uC6iqDqJIOACWhv/AMnRvNwk/RXfyCULT923Ek33bVDy
X-Received: by 2002:a05:6a00:1da3:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-842b0dafd4bmr12422704b3a.22.1780861054230;
        Sun, 07 Jun 2026 12:37:34 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm15429233b3a.28.2026.06.07.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 12:37:33 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in probe
Date: Mon,  8 Jun 2026 01:07:11 +0530
Message-Id: <20260607193711.601544-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296309-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,cambiumnetworks.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A778651658

spl2sw_probe() acquires three of_node references that are never properly
released in all paths:

  - eth_ports_np from of_get_child_by_name() leaks on every probe.
  - port_np returned from spl2sw_get_eth_child_node() (which exits a
    for_each_child_of_node() loop mid-iteration) leaks per loop pass.
  - phy_np from of_parse_phandle() leaks on the -EPROBE_DEFER and
    spl2sw_init_netdev() failure goto paths, and the registered netdev's
    mac->phy_node is not released on the out_unregister_dev cleanup path.

Convert eth_ports_np and port_np to scoped __free(device_node), add
explicit of_node_put(phy_np) on the two early-error gotos where
ownership has not yet been transferred to mac->phy_node, and release
each registered ndev's mac->phy_node in the out_unregister_dev loop
before unregister_netdev().

The mac->phy_node release in the normal driver-remove path is handled
by the preceding fix to spl2sw_phy_remove().

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 5e0e4c9ecbb0..d78bda050ee4 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -319,10 +319,8 @@ static struct device_node *spl2sw_get_eth_child_node(struct device_node *ether_n
 
 static int spl2sw_probe(struct platform_device *pdev)
 {
-	struct device_node *eth_ports_np;
-	struct device_node *port_np;
+	struct device_node *eth_ports_np __free(device_node) = NULL;
 	struct spl2sw_common *comm;
-	struct device_node *phy_np;
 	phy_interface_t phy_mode;
 	struct net_device *ndev;
 	struct spl2sw_mac *mac;
@@ -418,8 +416,10 @@ static int spl2sw_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++) {
-		/* Get port@i of node ethernet-ports. */
-		port_np = spl2sw_get_eth_child_node(eth_ports_np, i);
+		struct device_node *port_np __free(device_node) =
+			spl2sw_get_eth_child_node(eth_ports_np, i);
+		struct device_node *phy_np;
+
 		if (!port_np)
 			continue;
 
@@ -441,6 +441,7 @@ static int spl2sw_probe(struct platform_device *pdev)
 		/* Get mac-address from nvmem. */
 		ret = spl2sw_nvmem_get_mac_address(&pdev->dev, port_np, mac_addr);
 		if (ret == -EPROBE_DEFER) {
+			of_node_put(phy_np);
 			goto out_unregister_dev;
 		} else if (ret) {
 			dev_info(&pdev->dev, "Generate a random mac address!\n");
@@ -449,8 +450,10 @@ static int spl2sw_probe(struct platform_device *pdev)
 
 		/* Initialize the net device. */
 		ret = spl2sw_init_netdev(pdev, mac_addr, &ndev);
-		if (ret)
+		if (ret) {
+			of_node_put(phy_np);
 			goto out_unregister_dev;
+		}
 
 		ndev->irq = irq;
 		comm->ndev[i] = ndev;
@@ -500,8 +503,11 @@ static int spl2sw_probe(struct platform_device *pdev)
 
 out_unregister_dev:
 	for (i = 0; i < MAX_NETDEV_NUM; i++)
-		if (comm->ndev[i])
+		if (comm->ndev[i]) {
+			mac = netdev_priv(comm->ndev[i]);
+			of_node_put(mac->phy_node);
 			unregister_netdev(comm->ndev[i]);
+		}
 
 out_free_mdio:
 	spl2sw_mdio_remove(comm);
-- 
2.25.1


