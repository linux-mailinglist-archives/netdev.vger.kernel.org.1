Return-Path: <netdev+bounces-196639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF9AD59F9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE4F1E029D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4771DED6D;
	Wed, 11 Jun 2025 15:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396301AAA2C;
	Wed, 11 Jun 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654679; cv=none; b=rnouNpckt4AGQhdkYGYHhDUH6s4qbv3b3VpUhlMHf60C2YIu0XznSCFh0M/Wj+Ot0XiD59txEN0UFlVZggWtMwd5roe0D1t1okAyPy9fjo+Z4AsCDZnykPFFWlcWZys3jVhkbBLOqAtmbNxqOuyLct4WjCq4E6yE2Jq0pFStgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654679; c=relaxed/simple;
	bh=A1mou4igJDVMm9MXXhq0ZMdUzTHaV7ugbO9k+ECUps0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbU4IYBxNdt+9yUBEUroTKEVgje7VhK1AXkf/6/QTtHGx980u1/hzC0422H9IjMVZdlsISsPTI3jEgHdfolZ+8vhTWSzots+B6iCEI/+Xv7L9xOjDS8pOP3/UyTIIzfBpigGEQ6OtDcJw+ENTvljVytnSGKU2Ph6r05pLdKA3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-addda47ebeaso1300815566b.1;
        Wed, 11 Jun 2025 08:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654675; x=1750259475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atauMOX5FmrHP4FkHe4H+8rhDdCOC1ogq5Y36BfGZ5c=;
        b=ebrYq6ClbXQ+HuUAhIJ/qAJbjH9frCWz+KdpPVLpwbXgzU3/RS7yYyo2HQMZGkro1C
         Dl+ffIbH+3oDuZNN3JGzQU+52W9LXdDA2s1rv4yZwQ8kLtVyyZiaFFZHH1fGzZFnrYZh
         7QQZ0xjXd4M6IrcajsEUkE+NXTEnIZMzvLXnkUBcaulfaBnfO95gXAXPL73OoVyjMAfF
         B4zyERLigI4fEtACEm2kOPQy8Hc4ZHzgprywAMgILsJ8psHM6K4SAoQhrVwoCxI/jfVe
         BBVkoqFLEvYdOqa4ZJqIgosus3UnbPVUwVAgqkUmd0CFhHAyhOuaKawbKb2QWtlQOFof
         WfLA==
X-Forwarded-Encrypted: i=1; AJvYcCU9VNxiY8uABnOw3IBn5IOxnWLdx24JxB36O8Vh3KRzS/YtSa3cNs+h7HMrAFe32CalX8Xz7j9IQ3zhjkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGi6kd2l43OA9fZl5lAPFZRuppwuw+SOy1I4cAkV1Z2axzofI8
	8sN3/FpQ3FNM2zUJTcN2xyNcBxTSNSJFUWlgsNFx42IaavN6u52trSwP
X-Gm-Gg: ASbGncs36HUt8iddpgVcG8Id4h4JbtaY9OPsO5IIhKlm7dM1eOjZkRFFwTpfhfdfezj
	yAwSkFaPR8xZ+Vq526v/VpSfI9qgRg3UItU0sG8pMqagBCJXUr+B76Y5Nh/OUvP9HDAAmjBeXDh
	l1eTXZtrB+WYln/p2AbUvMeu0MbIS0LL54TWnx5DTfU0Lodh4CIK4eV071TUm+NkqzwOVyO6Sqx
	d7dP4uYu2WS4RidlJklqn+dNSYWjwxKqtke5EvKNshYQhPKZ52Ud1/mghVfPcvaRsJIGRMc8D42
	/b3iNU0Ms+QifuGoCbWjbg0uXqBeCbJm/Qj5q+UbWZ/hhcI6BA5w8A==
X-Google-Smtp-Source: AGHT+IHXH8owQy/RTUY4vtforzGTOIV0lRuxwMta7I/O/gDkxIdxrI6Vl5a8pzLMVyIXD+BBTWE+Wg==
X-Received: by 2002:a17:907:986:b0:ad8:9e80:6ba3 with SMTP id a640c23a62f3a-adea2e355damr2289466b.7.1749654675109;
        Wed, 11 Jun 2025 08:11:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c770sm893115466b.167.2025.06.11.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:11:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 08:06:19 -0700
Subject: [PATCH net-next 1/2] netdevsim: migrate to dstats stats collection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netdevsim_stat-v1-1-c11b657d96bf@debian.org>
References: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
In-Reply-To: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4918; i=leitao@debian.org;
 h=from:subject:message-id; bh=A1mou4igJDVMm9MXXhq0ZMdUzTHaV7ugbO9k+ECUps0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZyQsbGm5/ezwpfDMad4CIakxocWjaeuMJgxs
 y+Sk4Yals6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmckAAKCRA1o5Of/Hh3
 bdigD/9DuXb4Tu1dcQZL452NPLc3xQP1pJ6ALcQmRnnam+1AIk5AEW0Tn5rikdiH5SO5ZbfC4FU
 /FjUgwcNGSW9UXVC/r+ni9hSJztGteDrKeGV40k7BX54Bjg1w+Grq4818cadjoxIM/q4F+7KKpY
 P+NoQL4JzNKjWgIylo43uMYsaBdLM/XboMk6exXNzfbJlpl5nDm/Lolfc0UnXVMMyshOuL1rF/a
 eImKjJwpoZ0rGDReAjtLWFhN7iAle0I9j+M0vW2PpjTB8TQYMrxcRrkrwYSMJi5jbztYCiyKq96
 /tDtTEbz0xLDJ5DC09FB0pvkLyvS6UxEV7bW0hSgkmdDHQ7Jn5N5ZsRVAo0traaxEeIulRN3KaS
 Gvfl4CndkBvtzc0jDwPS6OP/I0YWpXzIy/tCcey0LiAVcM2xQTdz01OqxkJj/d4jo1H/VLn3qT+
 M7+YAdwJ1AqUhw8J57zBMyYAkVYw9m4yfAYKc79fncHqrLY2rDQvEfMXPXTMzbKSkZd6IHjxVx7
 pIpzhobI10+JeqPJYuqblrPwdXcp3rNozwb6jUDZQVGrf3YkdHNKJXB0A/IpQfxF2r8axJb1T/n
 sqRjpR1C5OOwMA1VqtkzMEqKA6WjklFBsy+OrjA65VMLNH77HwKvb1kAOQr4Dzr4JBatOYhU6gp
 6AvO2VYzyt0Z5yA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace custom statistics tracking with the kernel's dstats infrastructure
to simplify code and improve consistency with other network drivers.

This change:
- Sets dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS for automatic
  automatic allocation and deallocation.
- Removes manual stats fields and their update
- Replaces custom nsim_get_stats64() with dev_get_stats()
- Uses dev_dstats_tx_add() and dev_dstats_tx_dropped() helpers
- Eliminates the need for manual synchronization primitives

The dstats framework provides the same functionality with less code.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c    | 33 ++++++---------------------------
 drivers/net/netdevsim/netdevsim.h |  5 -----
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index af545d42961c3..67871d31252fe 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -93,19 +93,14 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
-	u64_stats_update_begin(&ns->syncp);
-	ns->tx_packets++;
-	ns->tx_bytes += len;
-	u64_stats_update_end(&ns->syncp);
+	dev_dstats_tx_add(dev, skb->len);
 	return NETDEV_TX_OK;
 
 out_drop_free:
 	dev_kfree_skb(skb);
 out_drop_cnt:
 	rcu_read_unlock();
-	u64_stats_update_begin(&ns->syncp);
-	ns->tx_dropped++;
-	u64_stats_update_end(&ns->syncp);
+	dev_dstats_tx_dropped(dev);
 	return NETDEV_TX_OK;
 }
 
@@ -126,20 +121,6 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void
-nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
-{
-	struct netdevsim *ns = netdev_priv(dev);
-	unsigned int start;
-
-	do {
-		start = u64_stats_fetch_begin(&ns->syncp);
-		stats->tx_bytes = ns->tx_bytes;
-		stats->tx_packets = ns->tx_packets;
-		stats->tx_dropped = ns->tx_dropped;
-	} while (u64_stats_fetch_retry(&ns->syncp, start));
-}
-
 static int
 nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
 {
@@ -555,7 +536,6 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-	.ndo_get_stats64	= nsim_get_stats64,
 	.ndo_set_vf_mac		= nsim_set_vf_mac,
 	.ndo_set_vf_vlan	= nsim_set_vf_vlan,
 	.ndo_set_vf_rate	= nsim_set_vf_rate,
@@ -579,7 +559,6 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-	.ndo_get_stats64	= nsim_get_stats64,
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 };
@@ -593,7 +572,7 @@ static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		nsim_get_stats64(dev, &rtstats);
+		dev_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;
 	stats->bytes = rtstats.rx_bytes;
@@ -605,7 +584,7 @@ static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		nsim_get_stats64(dev, &rtstats);
+		dev_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
 	stats->bytes = rtstats.tx_bytes;
@@ -617,7 +596,7 @@ static void nsim_get_base_stats(struct net_device *dev,
 {
 	struct rtnl_link_stats64 rtstats = {};
 
-	nsim_get_stats64(dev, &rtstats);
+	dev_get_stats(dev, &rtstats);
 
 	rx->packets = !!rtstats.rx_packets;
 	rx->bytes = 0;
@@ -889,6 +868,7 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
 			    NETIF_F_TSO;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
 }
@@ -1021,7 +1001,6 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	dev_net_set(dev, nsim_dev_net(nsim_dev));
 	ns = netdev_priv(dev);
 	ns->netdev = dev;
-	u64_stats_init(&ns->syncp);
 	ns->nsim_dev = nsim_dev;
 	ns->nsim_dev_port = nsim_dev_port;
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d04401f0bdf79..343b8f19dbed6 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -108,11 +108,6 @@ struct netdevsim {
 
 	int rq_reset_mode;
 
-	u64 tx_packets;
-	u64 tx_bytes;
-	u64 tx_dropped;
-	struct u64_stats_sync syncp;
-
 	struct nsim_bus_dev *nsim_bus_dev;
 
 	struct bpf_prog	*bpf_offloaded;

-- 
2.47.1


