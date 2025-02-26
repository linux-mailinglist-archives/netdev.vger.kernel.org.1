Return-Path: <netdev+bounces-169763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21EA45A2A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A453A95B6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8B226D19;
	Wed, 26 Feb 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="T6VqyoQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB81A08A4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562358; cv=none; b=RQ6oRdRdHD1mob7dCzlDm7f4cd/qjvMqjnw4Ux+uBqUbB7qHOh076Q29ODB4+5ZpvFiRszAuTRTBMg426gZUdGfxZ1QKUOWcmhbCfe/vtk6Z8SKLRx9TwgVe+OiXEFL2AodN9nBbspIsvNsaSomKeHY4ZWjfUgypjqw1RwY47N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562358; c=relaxed/simple;
	bh=gC6j9sQTyF3vuRUm2sG7vHK6MbYyI3Z1UGO6Tly2Ph0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0sWRMBCEboWUvA1BZLU7snG9y2cz2Aug1WkIRBWEwYquEpt7omjur6JjYHG2tpJ/KdovbUWNQjXClqI+Emo3sDxLjrXdgm3+vJ2UXqp9q3Rj53s9BqtcN+8T+tfRxApjId+1MJ6SMN9aB4dvd78LurkFtzA35OGUu+xWYLvMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=T6VqyoQr; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-abad214f9c9so118083366b.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740562354; x=1741167154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUJ2GwcWAheVNd/oBoGBH6me71LR73LiZDzvy9yos6g=;
        b=T6VqyoQrUQw8Y4i2FBkt8ppP43Ts8Td6WwLRVzD9bb6qj4iYpTMGqfQnOjqGS4gF9H
         ozoxQhkI/6gHDfwSSmiRfIMSE7BrRbo/02/MvtC8KYshpzg/pdJGylLx8n90C6uqNG0W
         Yae6jgx80fLKGGsQzhHI3TAGG7ZyywsZRmkl55o+5ItyCJeIGeYwGs1IjAV7tkoAfL7H
         QBiZ02dwEMzWMa0873dWPrtIciIDKtbuHOj38I1VEQwHnn8+cu4rp8HUAHSQN2rlcztF
         eVzjQ1lG2RaexgFV7pi1NbHu84uI0ejgIo0CtiLYtTkmHW53PR+xSemph5QIJIvHC2E6
         gKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562354; x=1741167154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUJ2GwcWAheVNd/oBoGBH6me71LR73LiZDzvy9yos6g=;
        b=I3DUgo9YKNzECfPRByJNerwGq1BWFWW4hKvV3MHJn7Yoi+AqoRZTFw1OrFjFc4w396
         hz2GeB3/k7CJKYoyoYkWM16zHVc08Zr/lJmtuQYiIdzAjIRo8MPxPoHWhgfhYPVIxlef
         kR7BkLMcd0w7BUiTVDnexNghnZTFa+Q+6pSIQpzlqDc60fwkLnioLuway+fKrXAWj3DN
         ScONsbMdksStQM0u75AqKz9kV2s20rHiwrSzkmqzAPH+39zt3xk3SNr4z2bFtyBeEUtv
         ONn64bO0DRitcsX2GEOUDjpDbO4am06j2OLtQp60vva5qw3w1aTGwNs+ma60TR0TuPSJ
         uTdw==
X-Forwarded-Encrypted: i=1; AJvYcCXLhSJD5qn3TPbwBytKTIbaBGgYTXqBu53MEDxHbpEQkic/ogrS6zdCwkyCVV58UOONycFR6o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMNXa6cHT4j15G0AsuSJiI3Tfl66qnILs19mPWooH0SwnicDR
	En6iQ3pMpStMfu0JZJ9mTnBgjCETlSaO0XKC+EgJ7J8uwDDtouUumhzW5zY9olgKA7TDXrPEQY+
	xkgKjWvrJqecmELGc/lT4LJxCvA1zNSiS
X-Gm-Gg: ASbGncvyvKd2SW3f1rH2DTQU2ixfGyKS58+uxEQr8TQO/f+6qrKIzxXRctiarG1PPd0
	JFr2DIUbN4nJXQC5t/5/wdqF76iqvpTRCJckdp7Am354yQITMqnciEcsG0Lrt/dznoSyGWz0F3U
	mWCmluqonlyAnk9mJDILxN+Eh5jmMoRMJJ61C0CBM0RL32DGX3ZPYfBPzgCUA+nRmhfXdp4UhLH
	e2mJ4qUvOkqSpGhgJ4nCuHYIKp5uDIkh35lcT3DZE0VzKoNsM1LIaiwSpiF6tLkK6MjCRntdrPF
	5zOIPt9eFzOKorbZ3kLWRBkdJhKQJCg6Gw4ACT/Bw6EIk3Z0sYD3A5QkM9peEBqKoV7u0kk=
X-Google-Smtp-Source: AGHT+IFvwWLsRjpPI3cf47lwHJShJNXmhjmq5/aHyQMQffFQyQOYBZ95tHR7dghM6NW2TqTMkAhR0yjmkBEX
X-Received: by 2002:a17:907:9713:b0:ab7:f92c:8ff9 with SMTP id a640c23a62f3a-abc099c6f28mr869282366b.1.1740562354095;
        Wed, 26 Feb 2025 01:32:34 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-abed1b137f3sm20417566b.64.2025.02.26.01.32.33;
        Wed, 26 Feb 2025 01:32:34 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D05341669C;
	Wed, 26 Feb 2025 10:32:33 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnDmL-002hmc-Ht; Wed, 26 Feb 2025 10:32:33 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v5 1/3] net: rename netns_local to netns_immutable
Date: Wed, 26 Feb 2025 10:31:56 +0100
Message-ID: <20250226093232.644814-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
References: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name 'netns_local' is confusing. A following commit will export it via
netlink, so let's use a more explicit name.

Reported-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/networking/net_cachelines/net_device.rst |  2 +-
 Documentation/networking/switchdev.rst                 |  2 +-
 drivers/net/amt.c                                      |  2 +-
 drivers/net/bonding/bond_main.c                        |  2 +-
 drivers/net/ethernet/adi/adin1110.c                    |  2 +-
 drivers/net/ethernet/marvell/prestera/prestera_main.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c       |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c         |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c              |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c                     |  2 +-
 drivers/net/loopback.c                                 |  2 +-
 drivers/net/net_failover.c                             |  2 +-
 drivers/net/team/team_core.c                           |  2 +-
 drivers/net/vrf.c                                      |  2 +-
 include/linux/netdevice.h                              |  4 ++--
 net/batman-adv/soft-interface.c                        |  2 +-
 net/bridge/br_device.c                                 |  2 +-
 net/core/dev.c                                         |  4 ++--
 net/hsr/hsr_device.c                                   |  2 +-
 net/ieee802154/6lowpan/core.c                          |  2 +-
 net/ieee802154/core.c                                  | 10 +++++-----
 net/ipv4/ip_tunnel.c                                   |  2 +-
 net/ipv4/ipmr.c                                        |  2 +-
 net/ipv6/ip6_gre.c                                     |  2 +-
 net/ipv6/ip6_tunnel.c                                  |  2 +-
 net/ipv6/ip6mr.c                                       |  2 +-
 net/ipv6/sit.c                                         |  2 +-
 net/openvswitch/vport-internal_dev.c                   |  2 +-
 net/wireless/core.c                                    | 10 +++++-----
 tools/testing/selftests/net/forwarding/README          |  2 +-
 31 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 15e31ece675f..6327e689e8a8 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -167,7 +167,7 @@ unsigned:1                          wol_enabled
 unsigned:1                          threaded                                                            napi_poll(napi_enable,dev_set_threaded)
 unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
-unsigned_long:1                     netns_local
+unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index f355f0166f1b..2966b7122f05 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -137,7 +137,7 @@ would be sub-port 0 on port 1 on switch 1.
 Port Features
 ^^^^^^^^^^^^^
 
-dev->netns_local
+dev->netns_immutable
 
 If the switchdev driver (and device) only supports offloading of the default
 network namespace (netns), the driver should set this private flag to prevent
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 53899b70fae1..734a0b3242a9 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3099,7 +3099,7 @@ static void amt_link_setup(struct net_device *dev)
 	dev->addr_len		= 0;
 	dev->priv_flags		|= IFF_NO_QUEUE;
 	dev->lltx		= true;
-	dev->netns_local	= true;
+	dev->netns_immutable	= true;
 	dev->features		|= NETIF_F_GSO_SOFTWARE;
 	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
 	dev->hw_features	|= NETIF_F_FRAGLIST | NETIF_F_RXCSUM;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7d716e90a84c..ee153f818c3b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6025,7 +6025,7 @@ void bond_setup(struct net_device *bond_dev)
 	bond_dev->lltx = true;
 
 	/* Don't allow bond devices to change network namespaces. */
-	bond_dev->netns_local = true;
+	bond_dev->netns_immutable = true;
 
 	/* By default, we declare the bond to be fully
 	 * VLAN hardware accelerated capable. Special
diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 68fad5575fd4..30f9d271e595 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1599,7 +1599,7 @@ static int adin1110_probe_netdevs(struct adin1110_priv *priv)
 		netdev->netdev_ops = &adin1110_netdev_ops;
 		netdev->ethtool_ops = &adin1110_ethtool_ops;
 		netdev->priv_flags |= IFF_UNICAST_FLT;
-		netdev->netns_local = true;
+		netdev->netns_immutable = true;
 
 		port_priv->phydev = get_phy_device(priv->mii_bus, i + 1, false);
 		if (IS_ERR(port_priv->phydev)) {
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 8cdecf61253c..71ffb55d1fc4 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -634,7 +634,7 @@ static int prestera_port_create(struct prestera_switch *sw, u32 id)
 		goto err_dl_port_register;
 
 	dev->features |= NETIF_F_HW_TC;
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 	dev->netdev_ops = &prestera_netdev_ops;
 	dev->ethtool_ops = &prestera_ethtool_ops;
 	SET_NETDEV_DEV(dev, sw->dev->dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5d5e7b19c396..42aa2c7d9ae0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4421,9 +4421,9 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 
 	if (mlx5e_is_uplink_rep(priv)) {
 		features = mlx5e_fix_uplink_rep_features(netdev, features);
-		netdev->netns_local = true;
+		netdev->netns_immutable = true;
 	} else {
-		netdev->netns_local = false;
+		netdev->netns_immutable = false;
 	}
 
 	mutex_unlock(&priv->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 07f38f472a27..2abab241f03b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -905,7 +905,7 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 
 	netdev->features |= netdev->hw_features;
 
-	netdev->netns_local = true;
+	netdev->netns_immutable = true;
 }
 
 static int mlx5e_init_rep(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 1f8362788c75..c7e6a3258244 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1579,7 +1579,7 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 			    NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	dev->vlan_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	dev->lltx = true;
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = MLXSW_PORT_MAX_MTU - MLXSW_PORT_ETH_FRAME_HDR;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index fe0bf1d3217a..36af94a2e062 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2576,7 +2576,7 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	rocker_carrier_init(rocker_port);
 
 	dev->features |= NETIF_F_SG;
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	/* MTU range: 68 - 9000 */
 	dev->min_mtu = ROCKER_PORT_MIN_MTU;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index cec0a90659d9..b01289d4726d 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1409,7 +1409,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
 				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_TC;
-		ndev->netns_local = true;
+		ndev->netns_immutable = true;
 
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index c8840c3b9a1b..034f71b020be 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -172,7 +172,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
 	dev->lltx		= true;
-	dev->netns_local	= true;
+	dev->netns_immutable	= true;
 	netif_keep_dst(dev);
 	dev->hw_features	= NETIF_F_GSO_SOFTWARE;
 	dev->features		= NETIF_F_SG | NETIF_F_FRAGLIST
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 54c8b9d5b5fc..5b50d9186f12 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -734,7 +734,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	failover_dev->lltx = true;
 
 	/* Don't allow failover devices to change network namespaces. */
-	failover_dev->netns_local = true;
+	failover_dev->netns_immutable = true;
 
 	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
 				    NETIF_F_HW_VLAN_CTAG_TX |
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 78edb8186b6d..fb917560d0a2 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2203,7 +2203,7 @@ static void team_setup(struct net_device *dev)
 	dev->lltx = true;
 
 	/* Don't allow team devices to change network namespaces. */
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	dev->features |= NETIF_F_GRO;
 
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 849c3ced2690..36cf6191335e 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1617,7 +1617,7 @@ static void vrf_setup(struct net_device *dev)
 	dev->lltx = true;
 
 	/* don't allow vrf devices to change network namespaces. */
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	/* does not make sense for a VLAN to be added to a vrf device */
 	dev->features   |= NETIF_F_VLAN_CHALLENGED;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a387d456592..598acba04329 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1994,7 +1994,7 @@ enum netdev_reg_state {
  *			regardless of source, even if those aren't
  *			HWTSTAMP_SOURCE_NETDEV
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
- *	@netns_local: interface can't change network namespaces
+ *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -2400,7 +2400,7 @@ struct net_device {
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
 	unsigned long		change_proto_down:1;
-	unsigned long		netns_local:1;
+	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
 
 	struct list_head	net_notifier_list;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d893c8013261..e190fa954f22 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1037,7 +1037,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->lltx = true;
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 0ab4613aa07a..9d8c72ed01ab 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -488,7 +488,7 @@ void br_dev_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &br_type);
 	dev->priv_flags = IFF_EBRIDGE | IFF_NO_QUEUE;
 	dev->lltx = true;
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	dev->features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			NETIF_F_HW_VLAN_STAG_TX;
diff --git a/net/core/dev.c b/net/core/dev.c
index 3f525278a871..9f5024b0f36f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12023,7 +12023,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-	if (dev->netns_local)
+	if (dev->netns_immutable)
 		goto out;
 
 	/* Ensure the device has been registered */
@@ -12405,7 +12405,7 @@ static void __net_exit default_device_exit_net(struct net *net)
 		char fb_name[IFNAMSIZ];
 
 		/* Ignore unmoveable devices (i.e. loopback) */
-		if (dev->netns_local)
+		if (dev->netns_immutable)
 			continue;
 
 		/* Leave virtual devices for the generic cleanup */
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b6fb18469439..c6f8614e9ed1 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -643,7 +643,7 @@ void hsr_dev_setup(struct net_device *dev)
 	/* Not sure about this. Taken from bridge code. netdevice.h says
 	 * it means "Does not change network namespaces".
 	 */
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	dev->needs_free_netdev = true;
 
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index ee318d46817d..9a9da74b0a4f 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -116,7 +116,7 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->header_ops	= &lowpan_header_ops;
 	ldev->needs_free_netdev	= true;
-	ldev->netns_local	= true;
+	ldev->netns_immutable	= true;
 }
 
 static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[],
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 88adb04e4072..89b671b12600 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -226,11 +226,11 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 	list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
 		if (!wpan_dev->netdev)
 			continue;
-		wpan_dev->netdev->netns_local = false;
+		wpan_dev->netdev->netns_immutable = false;
 		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
 		if (err)
 			break;
-		wpan_dev->netdev->netns_local = true;
+		wpan_dev->netdev->netns_immutable = true;
 	}
 
 	if (err) {
@@ -242,11 +242,11 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 						     list) {
 			if (!wpan_dev->netdev)
 				continue;
-			wpan_dev->netdev->netns_local = false;
+			wpan_dev->netdev->netns_immutable = false;
 			err = dev_change_net_namespace(wpan_dev->netdev, net,
 						       "wpan%d");
 			WARN_ON(err);
-			wpan_dev->netdev->netns_local = true;
+			wpan_dev->netdev->netns_immutable = true;
 		}
 
 		return err;
@@ -291,7 +291,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 	switch (state) {
 		/* TODO NETDEV_DEVTYPE */
 	case NETDEV_REGISTER:
-		dev->netns_local = true;
+		dev->netns_immutable = true;
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
 		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
 		rdev->devlist_generation++;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 011f2a5aab3b..4b06dc7e04f2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1162,7 +1162,7 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
 	if (!IS_ERR(itn->fb_tunnel_dev)) {
-		itn->fb_tunnel_dev->netns_local = true;
+		itn->fb_tunnel_dev->netns_immutable = true;
 		itn->fb_tunnel_dev->mtu = ip_tunnel_bind_dev(itn->fb_tunnel_dev);
 		ip_tunnel_add(itn, netdev_priv(itn->fb_tunnel_dev));
 		itn->type = itn->fb_tunnel_dev->type;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 21ae7594a852..b81c8131e23f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -563,7 +563,7 @@ static void reg_vif_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &reg_vif_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->netns_local	= true;
+	dev->netns_immutable	= true;
 }
 
 static struct net_device *ipmr_reg_vif(struct net *net, struct mr_table *mrt)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d31a4ce3b19f..c6ebb6a6d390 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1620,7 +1620,7 @@ static int __net_init ip6gre_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ign->fb_tunnel_dev->netns_local = true;
+	ign->fb_tunnel_dev->netns_immutable = true;
 
 	ip6gre_fb_tunnel_init(ign->fb_tunnel_dev);
 	ign->fb_tunnel_dev->rtnl_link_ops = &ip6gre_link_ops;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 89d206731af0..170a6ac30889 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2265,7 +2265,7 @@ static int __net_init ip6_tnl_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ip6n->fb_tnl_dev->netns_local = true;
+	ip6n->fb_tnl_dev->netns_immutable = true;
 
 	err = ip6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 535e9f72514c..e8ade93a0f0e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -668,7 +668,7 @@ static void reg_vif_setup(struct net_device *dev)
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &reg_vif_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->netns_local	= true;
+	dev->netns_immutable	= true;
 }
 
 static struct net_device *ip6mr_reg_vif(struct net *net, struct mr_table *mrt)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index f7b59bc957d3..6f04703fe638 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1859,7 +1859,7 @@ static int __net_init sit_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	sitn->fb_tunnel_dev->netns_local = true;
+	sitn->fb_tunnel_dev->netns_immutable = true;
 
 	t = netdev_priv(sitn->fb_tunnel_dev);
 	t->net = net;
diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 2412d7813d24..125d310871e9 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -149,7 +149,7 @@ static struct vport *internal_dev_create(const struct vport_parms *parms)
 
 	/* Restrict bridge port to current netns. */
 	if (vport->port_no == OVSP_LOCAL)
-		vport->dev->netns_local = true;
+		vport->dev->netns_immutable = true;
 
 	rtnl_lock();
 	err = register_netdevice(vport->dev);
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 12b780de8779..15bbc9d06c9e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -162,11 +162,11 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
 			continue;
-		wdev->netdev->netns_local = false;
+		wdev->netdev->netns_immutable = false;
 		err = dev_change_net_namespace(wdev->netdev, net, "wlan%d");
 		if (err)
 			break;
-		wdev->netdev->netns_local = true;
+		wdev->netdev->netns_immutable = true;
 	}
 
 	if (err) {
@@ -178,11 +178,11 @@ int cfg80211_switch_netns(struct cfg80211_registered_device *rdev,
 						     list) {
 			if (!wdev->netdev)
 				continue;
-			wdev->netdev->netns_local = false;
+			wdev->netdev->netns_immutable = false;
 			err = dev_change_net_namespace(wdev->netdev, net,
 							"wlan%d");
 			WARN_ON(err);
-			wdev->netdev->netns_local = true;
+			wdev->netdev->netns_immutable = true;
 		}
 
 		return err;
@@ -1513,7 +1513,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		SET_NETDEV_DEVTYPE(dev, &wiphy_type);
 		wdev->netdev = dev;
 		/* can only change netns with wiphy */
-		dev->netns_local = true;
+		dev->netns_immutable = true;
 
 		cfg80211_init_wdev(wdev);
 		break;
diff --git a/tools/testing/selftests/net/forwarding/README b/tools/testing/selftests/net/forwarding/README
index a652429bfd53..7b41cff993ad 100644
--- a/tools/testing/selftests/net/forwarding/README
+++ b/tools/testing/selftests/net/forwarding/README
@@ -6,7 +6,7 @@ to easily create and test complex environments.
 
 Unfortunately, these namespaces can not be used with actual switching
 ASICs, as their ports can not be migrated to other network namespaces
-(dev->netns_local) and most of them probably do not support the
+(dev->netns_immutable) and most of them probably do not support the
 L1-separation provided by namespaces.
 
 However, a similar kind of flexibility can be achieved by using VRFs and
-- 
2.47.1


