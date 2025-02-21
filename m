Return-Path: <netdev+bounces-168577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E924DA3F613
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEB4226B0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B6F20F063;
	Fri, 21 Feb 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IbFuV8KT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2B20ADF0
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144708; cv=none; b=VCuVctv2817UUpWTYAqa+D97EBgw2/4dmokd5TBn+UqfrkRh6vH63iJNbK77D5P5aOKPTyODJ04ippLBirCiIcKetcVMBqgjWW/XYJ1PVycujtrk8eqGRBcjbh0hud9xG7bv4Ndh4DFSqvGgJJL1sNYPTUYGzHcpcMMIsN5jEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144708; c=relaxed/simple;
	bh=xPzEsAFBpVCZVkcLRmmlangB3uowcAiaKfWlXhRpHXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8FLjdzbZmEUzU1cewjwSV5ZKRvgDt2b3Yp6GlSauR00DCxRZVkJdeQvFTtjYHOkDtEHW+FBj3uzSgQogS1Fs7UqZo1JFlmP7nMAiVMzZCaLa3hTqoPaByYGTE0c5lm7VGIABpXBp2ealNUiMep3NurgFDgRcYeq4yvDKru4QxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IbFuV8KT; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-54529583c39so294984e87.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740144704; x=1740749504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDVjrSrRMYhP2obRGPFZKBCimje40qzh9Xf7kwORYGA=;
        b=IbFuV8KTJfcwtOMOdbY1LKxAP35sgYeIXz8c0QACEFL+5P43Sy4Kdjg6wIR6mLRlpY
         fINcteIx2QfXJjluQsAqprpkdirakjxzOahktXZ1fdyf3iWBH9twjwvvT3CbJ1gJvCrd
         DZ8DoychSgN2jzWR07yJk2dE+FG0RZa/z63NhfNBKVJ81M+naZslzIg4DN/+5kw5oEfO
         1vovHjWZk6ajF5aY1CAYAFOynFMCJerSRHOdP5AL2fg8t62kogShRfrzQDsMQi//MdWI
         DSZ0bP8rUMzwQlUgYAq2IzOHpa63pT6CxK4i9OWJrmq3tG/0QZ5IXinlIVKZwr7XEEFx
         TDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144704; x=1740749504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDVjrSrRMYhP2obRGPFZKBCimje40qzh9Xf7kwORYGA=;
        b=hBPzO29uR5SZyB/ej63Ooj5V/ejWVce6/eMuPmCpCSGDWqScy1WBevJCTCr61nTOP5
         74IZamHehqN6wImOgmA6y/NmPcM53EgZkp1ZSt0DfyfC3vPCenOqyizdK50ViGgISJ6n
         a3x8hmgi/XR52X05A+JntoU6fAqFYGj1y6Y48Oxy0rD2DnBMY6Y0qLPam57TiQLIrcm5
         qN3KmcH8mc2ub4al6gYbfeFR8VqpK17c85y9u/2WQ9N2J8bwfKKHLTf5rENQnPn8mSoD
         a/8QJzczbqDXee89fEd0pYg/2kO1MJcRAJxzmiqB4FKoPdG4yeXOtIHmhF7ub1gYQsCo
         pzQw==
X-Forwarded-Encrypted: i=1; AJvYcCXzz0RXQtgmM4qmwVpY4oZihZW3pZtQDgxFgIFp2NOXDkU+hdtzJ9GB3J9KbgLP8if8mC/bH74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJMdAdLZU715BsSNTM7cHcFl6EacU86TNyK/Ytktwxj9524QZu
	Br5F21FDO8FSC9UX9lp6MEQ3G48dZpd8sWwdLvwXcBxvrOXU2AhPTG0wrqkeMub0oJUipoJf/lJ
	JYmaLMWoSo6mn9tL//wEy2issI/cuEN9L
X-Gm-Gg: ASbGncvLKFkg7H/Zu0ZCytlzMbotvGrHPHPoTuh8iLNFwIwThXeiRXrT6Fr+oPXTvHd
	uZsFkvFFnVN7OHoZVnSexDcIWepHR8vl7KEOx/TauETVj9lmaLjXDFYti9tW7b+uGbqMbVZ7yxx
	H1m4eSgOz1a8yC+zuWl8mYZ4DXWl+959rX0L153abOjM+cbqwiVQ1s79X250jVM0UK1iRADF2wq
	ytb2Rmto6dW1emva54K5wUDNzqyYu1MIkJB+xezglk5cck3MTsD8l4ozoP4zXKKb/NlyQ/JrsBt
	J0QXmkKF3a/WQlwwp62HE+jFOEpkrZa8ypvCorwvrv+kd57WvbVCWZ3i3gXQS9UxwiT5p9Q=
X-Google-Smtp-Source: AGHT+IHzSxaDGt/FPhFtadKEAdi0VFcO0OrQ34aRB8EvWFa7tK/NYToAxmq379C7huYJmiVSOwTAnkMwmL4w
X-Received: by 2002:a05:6512:1305:b0:545:888:2a14 with SMTP id 2adb3069b0e04-54838f796a3mr430699e87.11.1740144703543;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5462ef21df2sm204950e87.74.2025.02.21.05.31.43;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 3EF7313E99;
	Fri, 21 Feb 2025 14:31:43 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlT82-008b6d-WE; Fri, 21 Feb 2025 14:31:43 +0100
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
Subject: [PATCH net-next v4 1/3] net: rename netns_local to netns_immutable
Date: Fri, 21 Feb 2025 14:30:26 +0100
Message-ID: <20250221133136.2049165-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
References: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
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
index 98c6205ed19f..47cd72acdad1 100644
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
index f4019815f473..c2773e1cbe67 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2203,7 +2203,7 @@ static void team_setup(struct net_device *dev)
 	dev->lltx = true;
 
 	/* Don't allow team devices to change network namespaces. */
-	dev->netns_local = true;
+	dev->netns_immutable = true;
 
 	dev->features |= NETIF_F_GRO;
 
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 5f21ce1013c4..a34f2a2ab7d5 100644
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
index 822d788a5f86..54f6d041abfd 100644
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
index 18064be6cf3e..91b07fd1c86d 100644
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
index 175efd860f7b..d7c2c6d482ab 100644
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
index 09b73acf037a..52a48787e6b9 100644
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
index 235808cfec70..594381d467b7 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1621,7 +1621,7 @@ static int __net_init ip6gre_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	ign->fb_tunnel_dev->netns_local = true;
+	ign->fb_tunnel_dev->netns_immutable = true;
 
 	ip6gre_fb_tunnel_init(ign->fb_tunnel_dev);
 	ign->fb_tunnel_dev->rtnl_link_ops = &ip6gre_link_ops;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..072f5d06385e 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2261,7 +2261,7 @@ static int __net_init ip6_tnl_init_net(struct net *net)
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
index 39bd8951bfca..959f93ab5ac8 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1856,7 +1856,7 @@ static int __net_init sit_init_net(struct net *net)
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
 	 */
-	sitn->fb_tunnel_dev->netns_local = true;
+	sitn->fb_tunnel_dev->netns_immutable = true;
 
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
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


