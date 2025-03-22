Return-Path: <netdev+bounces-176880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD15A6CAB1
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF193B7444
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075F22D4F1;
	Sat, 22 Mar 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="GHuugKYW"
X-Original-To: netdev@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA462233144;
	Sat, 22 Mar 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654372; cv=none; b=oyLht9xHVjRhQhfNIEzMUqc80wFGS/THFrCD5M56P0lNIWcWMrseMSjOXJS0D2zP4ursSGL9H8vhxbPBpNwD72Gb7stXxF6Lyjyp3x+uVA21b1XUEVyX/M8IA8q+WuvEwXxY03nid+TEWGgpHlU/JQYdzGiX5rxGKnN8tCwEkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654372; c=relaxed/simple;
	bh=9uImEbgQwxWfgppDTBKE/AaSq1iwqQnV3BoWQjIzWOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZUwCWhLjlVFb0Wv30kPIrbISXjuYXFDDfq2p/SDJD9Oucd0mzVK/EEmWl/l3I8dlYrCW1pXtEUHHG7P+cmxH2oDPwsptAJgWRRZT0G9cmawj+hQ0Ss9rQizHW8VGXpBmQ3BvcYV0P2y0aUGdyOJCscd7MZ9mNeYgdM71JFmMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=GHuugKYW; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e2ca:0:640:d17d:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id BE2A06001D;
	Sat, 22 Mar 2025 17:39:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PdN5lYULgqM0-sbFBvSrT;
	Sat, 22 Mar 2025 17:39:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654367; bh=VdrDm51h5uG0i+89CUahUxA6jXq9E4uKJajjzGobwuE=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=GHuugKYWb+ji25WFoBVgNlnIOVtFQGYJOzR1RZ4xHs+jKT/GPxhQKZE6LjxHL1Exz
	 wqIkSAPK6VVLwzl1SI5Q7zIwcswqIoa3evlOPNmPVA5JroB5c7Zh+cV+fKMpuqPYUA
	 3A7VWi7MeqF796SQczZcZdealP6lDNTXXzVlLujc=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 12/51] net: Use __register_netdevice in trivial .newlink cases
Date: Sat, 22 Mar 2025 17:39:25 +0300
Message-ID: <174265436565.356712.2751590357689476152.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replace register_netdevice() in drivers calling it only
from .newlink methods.

The objective is to conform .newlink with its callers,
which already assign nd_lock (and matches master nd_lock
if there is one).

Also, use __unregister_netdevice() since we know
there is held lock in that path.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/amt.c                                  |    4 ++--
 drivers/net/bareudp.c                              |    2 +-
 drivers/net/bonding/bond_netlink.c                 |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |    2 +-
 drivers/net/gtp.c                                  |    2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    4 ++--
 drivers/net/macsec.c                               |    4 ++--
 drivers/net/macvlan.c                              |    4 ++--
 drivers/net/pfcp.c                                 |    2 +-
 drivers/net/team/team_core.c                       |    2 +-
 drivers/net/vrf.c                                  |    6 +++---
 drivers/net/wireguard/device.c                     |    2 +-
 drivers/net/wireless/virtual/virt_wifi.c           |    4 ++--
 net/batman-adv/soft-interface.c                    |    2 +-
 net/bridge/br_netlink.c                            |    2 +-
 net/caif/chnl_net.c                                |    2 +-
 net/hsr/hsr_device.c                               |    4 ++--
 net/ipv4/ip_tunnel.c                               |    4 ++--
 net/ipv6/ip6_gre.c                                 |    2 +-
 net/xfrm/xfrm_interface_core.c                     |    2 +-
 21 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 2288f4bf649c..d39cde2be85e 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3258,7 +3258,7 @@ static int amt_newlink(struct net *net, struct net_device *dev,
 	}
 	amt->qi = AMT_INIT_QUERY_INTERVAL;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0) {
 		netdev_dbg(dev, "failed to register new netdev %d\n", err);
 		goto err;
@@ -3266,7 +3266,7 @@ static int amt_newlink(struct net *net, struct net_device *dev,
 
 	err = netdev_upper_dev_link(amt->stream_dev, dev, extack);
 	if (err < 0) {
-		unregister_netdevice(dev);
+		__unregister_netdevice(dev);
 		goto err;
 	}
 
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index d5c56ca91b77..ee54fec65e2e 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -647,7 +647,7 @@ static int bareudp_configure(struct net *net, struct net_device *dev,
 	bareudp->sport_min = conf->sport_min;
 	bareudp->multi_proto_mode = conf->multi_proto_mode;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		return err;
 
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 5fcab77d616f..70e3c93df0ba 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -574,7 +574,7 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
 	if (err < 0)
 		return err;
 
-	err = register_netdevice(bond_dev);
+	err = __register_netdevice(bond_dev);
 	if (!err) {
 		struct bonding *bond = netdev_priv(bond_dev);
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 495368cbef34..526e4b7dd27b 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -178,7 +178,7 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
 	return 0;
 
 err2:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 	rmnet_vnd_dellink(mux_id, port, ep);
 err1:
 	rmnet_unregister_real_device(real_dev);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index f1e40aade127..1c36ef3c1c7c 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -324,7 +324,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 		return -EINVAL;
 	}
 
-	rc = register_netdevice(rmnet_dev);
+	rc = __register_netdevice(rmnet_dev);
 	if (!rc) {
 		ep->egress_dev = rmnet_dev;
 		ep->mux_id = id;
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 0696faf60013..eef7c7a6edb2 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1520,7 +1520,7 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		dev->needed_headroom = LL_MAX_HEADER + GTP_IPV6_MAXLEN;
 	}
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0) {
 		netdev_dbg(dev, "failed to register new netdev %d\n", err);
 		goto out_encap;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index aafaf9d1d822..0887a7640cc0 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -585,7 +585,7 @@ int ipvlan_link_new(struct net *src_net, struct net_device *dev,
 
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		return err;
 
@@ -643,7 +643,7 @@ int ipvlan_link_new(struct net *src_net, struct net_device *dev,
 remove_ida:
 	ida_free(&port->ida, dev->dev_id);
 unregister_netdev:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_new);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 246cf09a0ebc..43ccba5a787d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4187,7 +4187,7 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 	if (rx_handler && rx_handler != macsec_handle_frame)
 		return -EBUSY;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		return err;
 
@@ -4257,7 +4257,7 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
 unregister:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 	return err;
 }
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index b51e2e21dead..1bf9bb435ef4 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1531,7 +1531,7 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 		update_port_bc_cutoff(
 			vlan, nla_get_s32(data[IFLA_MACVLAN_BC_CUTOFF]));
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto destroy_macvlan_port;
 
@@ -1549,7 +1549,7 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 
 unregister_netdev:
 	/* macvlan_uninit would free the macvlan port */
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 	return err;
 destroy_macvlan_port:
 	/* the macvlan port may be freed by macvlan_uninit when fail to register.
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..a28a9aed14eb 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -200,7 +200,7 @@ static int pfcp_newlink(struct net *net, struct net_device *dev,
 		goto exit_err;
 	}
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err) {
 		netdev_dbg(dev, "failed to register pfcp netdev %d\n", err);
 		goto exit_del_pfcp_sock;
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..3e98771bcced 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2214,7 +2214,7 @@ static int team_newlink(struct net *src_net, struct net_device *dev,
 	if (tb[IFLA_ADDRESS] == NULL)
 		eth_hw_addr_random(dev);
 
-	return register_netdevice(dev);
+	return __register_netdevice(dev);
 }
 
 static int team_validate(struct nlattr *tb[], struct nlattr *data[],
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 040f0bb36c0e..85c0903d1ef0 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1719,7 +1719,7 @@ static int vrf_newlink(struct net *src_net, struct net_device *dev,
 
 	dev->priv_flags |= IFF_L3MDEV_MASTER;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		goto out;
 
@@ -1731,7 +1731,7 @@ static int vrf_newlink(struct net *src_net, struct net_device *dev,
 
 	err = vrf_map_register_dev(dev, extack);
 	if (err) {
-		unregister_netdevice(dev);
+		__unregister_netdevice(dev);
 		goto out;
 	}
 
@@ -1743,7 +1743,7 @@ static int vrf_newlink(struct net *src_net, struct net_device *dev,
 		err = vrf_add_fib_rules(dev);
 		if (err) {
 			vrf_map_unregister_dev(dev);
-			unregister_netdevice(dev);
+			__unregister_netdevice(dev);
 			goto out;
 		}
 		*add_fib_rules = false;
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 3feb36ee5bfb..b2a3d5260d42 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -364,7 +364,7 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	ret = register_netdevice(dev);
+	ret = __register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
 
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index c80ae0e0df53..877c3deeef5b 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -564,7 +564,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	dev->ieee80211_ptr->iftype = NL80211_IFTYPE_STATION;
 	dev->ieee80211_ptr->wiphy = common_wiphy;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err) {
 		dev_err(&priv->lowerdev->dev, "can't register_netdevice: %d\n",
 			err);
@@ -587,7 +587,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 
 	return 0;
 unregister_netdev:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 free_wireless_dev:
 	kfree(dev->ieee80211_ptr);
 	dev->ieee80211_ptr = NULL;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 30ecbc2ef1fd..c1a9ae252a1c 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1085,7 +1085,7 @@ static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
 			return -EINVAL;
 	}
 
-	return register_netdevice(dev);
+	return __register_netdevice(dev);
 }
 
 /**
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f17dbac7d828..4298c14d4295 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1560,7 +1560,7 @@ static int br_dev_newlink(struct net *src_net, struct net_device *dev,
 	struct net_bridge *br = netdev_priv(dev);
 	int err;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		return err;
 
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 47901bd4def1..69dc15baaab6 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -450,7 +450,7 @@ static int ipcaif_newlink(struct net *src_net, struct net_device *dev,
 	caifdev = netdev_priv(dev);
 	caif_netlink_parms(data, &caifdev->conn_req);
 
-	ret = register_netdevice(dev);
+	ret = __register_netdevice(dev);
 	if (ret)
 		pr_warn("device rtml registration failed\n");
 	else
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e4cc6b78dcfc..e2fa0130a66c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -649,7 +649,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
 		hsr->fwd_offloaded = true;
 
-	res = register_netdevice(hsr_dev);
+	res = __register_netdevice(hsr_dev);
 	if (res)
 		goto err_unregister;
 
@@ -685,6 +685,6 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	hsr_del_self_node(hsr);
 
 	if (unregister)
-		unregister_netdevice(hsr_dev);
+		__unregister_netdevice(hsr_dev);
 	return res;
 }
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 5cffad42fe8c..065b51dde995 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1235,7 +1235,7 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 	nt->net = net;
 	nt->parms = *p;
 	nt->fwmark = fwmark;
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		goto err_register_netdevice;
 
@@ -1260,7 +1260,7 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 
 err_dev_set_mtu:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 err_register_netdevice:
 	return err;
 }
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 3942bd2ade78..57cbf7942dc8 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1993,7 +1993,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 	nt->dev = dev;
 	nt->net = dev_net(dev);
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		goto out;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index e50e4bf993fa..18bd60efd2cc 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -250,7 +250,7 @@ static int xfrmi_create(struct net_device *dev)
 	int err;
 
 	dev->rtnl_link_ops = &xfrmi_link_ops;
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto out;
 


