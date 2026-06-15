Return-Path: <netdev+bounces-299596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sU9xANFYMGrMRwUAu9opvQ
	(envelope-from <netdev+bounces-299596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:56:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696176899F5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:56:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="at/lbAfn";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299596-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9E623090324
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6703B6BF0;
	Mon, 15 Jun 2026 19:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E53B71AD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:51:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553084; cv=none; b=D/UVrQ2pXAavJ9qXvAMB0uPO8IlsmjMa41yvZKle56EhhuVmOeMyVvCdSn6B0aVJLyREV6Kx634vf6DjbkemyUFlFGaZAR9OA4hWO+ovG4xLZZEy87rp2lkuKSVdOh7HaVJ0ILCQ+TPfD0v91p+kwAD6Yt4hPjxpjHyKxsXrwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553084; c=relaxed/simple;
	bh=KbP4RVRuIq8IM2ov3LcL1hAKduUYeTZWxx8e+I1X7dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WayR3SJadElC3CG/nae0AJXY/unj5HdXJNunTsHvshewYkdBFd3r/KGvzebUQbC030YAoAcXp7Qq/t+MoU9H38qvomM8GtwPNXW1cJUUVjLpLpmeiOI0+K7q7TD+rtIct1FJaiJ6FRIK+r3srcxB+VzbYBFRdB1nscd2XIbEdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at/lbAfn; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so2543705a91.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553081; x=1782157881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTdSwXEuVnwMxN8BQmzAzyzW7HYywm64JQJ3uxoxgUc=;
        b=at/lbAfn/cHbLtS5J7Sucs/sjjer9rTQttOXOq4kyxGI9aY66Jx1qoG28NJaIkKfxP
         LMd8aN3m4fHHppDssRcJeC5t8Ne0XP95YqMrEh2ug8aw5peoNh6m78hTSPhNCmq+rq0e
         BxoX2DZ7D+dmJgJMJ5P+IgglaXuMrulfNdeF9/upmqrwx598k57eN7JxHLZR5picWj7k
         st/2kVwZvX83fecUPuIsjBU1Q5zShoH/tIW5XbuhX1DmaYX0CxN7TsnuT94aQL+ifJci
         o7T6DToJUsbUrgv45Y4QFPrJIrVLDjUrz4enJ4XaaHW0Iz3hui7N7Je2LPEtjZ+SVBzS
         GSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553081; x=1782157881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GTdSwXEuVnwMxN8BQmzAzyzW7HYywm64JQJ3uxoxgUc=;
        b=olPT2HkDCuYDNgK6JClMQMPhgco17TfALpDhdGNbni8iXW1u3m3iXnq6E36s1PpoH5
         YAa6EuOvGBWTPx6h5nf4hgx14IreTfh3bKmf7SbDrJU4btacV+leqyJMat3FDd/QqvJi
         kiOEdoZYDRXoy6WkoWVQD/QYEBiztsYdrF3cQhj2WIh5DJ7RJ0XLDBb6jSu7fhuq7dvm
         mcpwT1DMt06dprKLHqVKu+nIeECf8rDCePifpMaFBIcDRRp9zU/gC8Opcb0QzVGrllXk
         uGEAA54wN1rZsJ9vOzoB+8BNlt8YuhcB9NmpEI/Pb27WMPLmsG1Rs1eLc0s7kmZAVYK2
         xl4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+3W3qGVRXcp66ObRgNaijBUwrWMIAz148bVF7YUC1hoNcR1iGy5OCgcJ4pfO/AIzqQhBcYv6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkA1JtHLRdnNxgJdIpxx4gvTYE+nl9Ow5PIolgkP5EyJ2ax8A1
	JfDAtRbcHC4+jgssUFb7decksJXkmxMwF/mhE+ydKzN3RzMf6eYarn4C
X-Gm-Gg: Acq92OEGbMAWV00yODhJrF6sU8e5AvgNHC543bi0zYHXWU6cMdEgDU9fwzaKkhax/tF
	Pm9o9om1GqTwW4A3aCISzJxaolKlDTei1HfTQ570XY4un6q8AZmdOyF9o4McnYMgS/Aq978J0Ck
	jO6gq7dT8IagigqmTNtMv777/7vmJIEmrwAdB1kpK9dq3I7fM2H3Q0mieDTlF5kozSRimuQGEh2
	qtxfwWA3Yx/AI4kCRxaD+NcIs5Rd1tvKwg9EfA3+XaBHFWfq4TIGU97mqHJAKYzrK/GIutSpbfd
	UM2BG6riXbT0X2Fgz9pZf5z13/7zVbkCwUhyeORKohBc20uw8pbOViEPziPBKxfhvc/Hzgw/gH1
	5BY80NiPjFYxlfwrWFrlF3IvgRT4QecxGPmJQ+wcu/NhLR3ta4Bwbd/+qcyE8z8+iCAqDm1E3BS
	bFJiuTlMJRYo7Cw2BXxLlAJBOOQ9ORn7HoM8ZPDv1PQ1Di6KvPPwGjin0UOmc8Jw==
X-Received: by 2002:a17:903:3d06:b0:2c6:9758:9db2 with SMTP id d9443c01a7336-2c69a0e031cmr6432085ad.3.1781553081442;
        Mon, 15 Jun 2026 12:51:21 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5644sm113307285ad.4.2026.06.15.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:51:21 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v2 2/2] net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in probe
Date: Tue, 16 Jun 2026 01:20:32 +0530
Message-Id: <fe9cbe90adf4bb6fe5f2f7b7f267075e603d84cb.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299596-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,cambiumnetworks.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 696176899F5

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
by patch 1/2.

Compile-tested only; no SP7021 hardware available.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
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


