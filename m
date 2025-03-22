Return-Path: <netdev+bounces-176879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C0A6CAAC
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079C23B51DF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B422F160;
	Sat, 22 Mar 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="CaFysX04"
X-Original-To: netdev@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA32868B;
	Sat, 22 Mar 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654366; cv=none; b=tB/RV3rCjTkmlQxTfo0Nt0BILmu+5mRQ7h3XtLfG21PONprDB9dod8LGlchQgPpdaqzt5mH8nIUxQVPmddGG6xtcbzz1eMGam0aduLWkfNsasgHjjjo5CKWdmkeObCCzISIEb9Rxou00mygXDsqrAcQmhoLmyihG2KRal9RReEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654366; c=relaxed/simple;
	bh=g9BIqxzwaopa/pvI/HZYkmbJ1CLhHDGU5Gba7sGHnKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5TkG2BEErZBPKA7lsTkiLgNu5EsA75oViFP26GYmFSq7YfZ6Na53FowZ6m8oA1txH5yBi1BN79TrJQD7C6oqQa5Bv63iQYfyekmaZtnEJHwkl8cCHx72mkccWGc6zi0eCvluze1PR3AC388W2NSfDcYGdtDEVedXQeUk1oNZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=CaFysX04; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id 160EE65927;
	Sat, 22 Mar 2025 17:39:21 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3d4b:0:640:d84f:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 2068960B09;
	Sat, 22 Mar 2025 17:39:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AdNnSbULfW20-8NcQlCwI;
	Sat, 22 Mar 2025 17:39:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654352; bh=zYFYjiUn3WF2uf11+Z9TVeIOQzvx+bZYUWTg/GLymdg=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=CaFysX04pnqM9ABDZhVmt1iWliUuO/5clOjYwP/lvvZhLZe5sXRy8debLZxvNIaIX
	 rNqdWnv2CCpr+8w4SpkzBnAFOnJvfZyQwT+gZwc8m5pIDIxyH461CRQvM3ctWUDnsI
	 x2n168/7PdGHlY5bipTVPAcE/mn93e1KpK8/FT5M=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 10/51] net: Underline newlink and changelink dependencies
Date: Sat, 22 Mar 2025 17:39:10 +0300
Message-ID: <174265435050.356712.1842575186842459886.stgit@pro.pro>
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

This is to get rtnetlink code knowledge about devices
touching by newlink and changelink to bring them to the same
lock group.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |    1 +
 drivers/net/amt.c                                  |    5 +++++
 drivers/net/bonding/bond_netlink.c                 |    5 +++++
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    1 +
 drivers/net/ipvlan/ipvlan_main.c                   |    1 +
 drivers/net/ipvlan/ipvtap.c                        |    1 +
 drivers/net/macsec.c                               |    1 +
 drivers/net/macvlan.c                              |    1 +
 drivers/net/macvtap.c                              |    1 +
 drivers/net/vxlan/vxlan_core.c                     |    6 ++++++
 drivers/net/wireless/virtual/virt_wifi.c           |    1 +
 include/net/rtnetlink.h                            |   16 ++++++++++++++++
 net/8021q/vlan_netlink.c                           |    1 +
 net/core/rtnetlink.c                               |    5 +++++
 net/dsa/netlink.c                                  |    5 +++++
 net/hsr/hsr_netlink.c                              |    6 ++++++
 net/ieee802154/6lowpan/core.c                      |    1 +
 17 files changed, 58 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 9ad8d9856275..2dd3231df36c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -172,6 +172,7 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
 	.policy		= ipoib_policy,
 	.priv_size	= sizeof(struct ipoib_dev_priv),
 	.setup		= ipoib_setup_common,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= ipoib_new_child_link,
 	.dellink	= ipoib_del_child_link,
 	.changelink	= ipoib_changelink,
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 6d15ab3bfbbc..2288f4bf649c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3330,6 +3330,10 @@ static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
+struct link_deps amt_newlink_deps = {
+	.mandatory.data = { IFLA_AMT_LINK, },
+};
+
 static struct rtnl_link_ops amt_link_ops __read_mostly = {
 	.kind		= "amt",
 	.maxtype	= IFLA_AMT_MAX,
@@ -3337,6 +3341,7 @@ static struct rtnl_link_ops amt_link_ops __read_mostly = {
 	.priv_size	= sizeof(struct amt_dev),
 	.setup		= amt_link_setup,
 	.validate	= amt_validate,
+	.newlink_deps	= &amt_newlink_deps,
 	.newlink	= amt_newlink,
 	.dellink	= amt_dellink,
 	.get_size       = amt_get_size,
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..5fcab77d616f 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -906,6 +906,10 @@ static int bond_fill_linkxstats(struct sk_buff *skb,
 	return 0;
 }
 
+struct link_deps bond_changelink_deps = {
+	.optional.data = { IFLA_BOND_ACTIVE_SLAVE, IFLA_BOND_PRIMARY, },
+};
+
 struct rtnl_link_ops bond_link_ops __read_mostly = {
 	.kind			= "bond",
 	.priv_size		= sizeof(struct bonding),
@@ -914,6 +918,7 @@ struct rtnl_link_ops bond_link_ops __read_mostly = {
 	.policy			= bond_policy,
 	.validate		= bond_validate,
 	.newlink		= bond_newlink,
+	.changelink_deps	= &bond_changelink_deps,
 	.changelink		= bond_changelink,
 	.get_size		= bond_get_size,
 	.fill_info		= bond_fill_info,
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index f3bea196a8f9..495368cbef34 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -400,6 +400,7 @@ struct rtnl_link_ops rmnet_link_ops __read_mostly = {
 	.priv_size	= sizeof(struct rmnet_priv),
 	.setup		= rmnet_vnd_setup,
 	.validate	= rmnet_rtnl_validate,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= rmnet_newlink,
 	.dellink	= rmnet_dellink,
 	.get_size	= rmnet_get_size,
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 094f44dac5c8..aafaf9d1d822 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -700,6 +700,7 @@ static struct rtnl_link_ops ipvlan_link_ops = {
 	.priv_size	= sizeof(struct ipvl_dev),
 
 	.setup		= ipvlan_link_setup,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= ipvlan_link_new,
 	.dellink	= ipvlan_link_delete,
 	.get_link_net   = ipvlan_get_link_net,
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 1afc4c47be73..df1d22092b21 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -128,6 +128,7 @@ static void ipvtap_setup(struct net_device *dev)
 static struct rtnl_link_ops ipvtap_link_ops __read_mostly = {
 	.kind		= "ipvtap",
 	.setup		= ipvtap_setup,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= ipvtap_newlink,
 	.dellink	= ipvtap_dellink,
 	.priv_size	= sizeof(struct ipvtap_dev),
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2da70bc3dd86..246cf09a0ebc 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4430,6 +4430,7 @@ static struct rtnl_link_ops macsec_link_ops __read_mostly = {
 	.policy		= macsec_rtnl_policy,
 	.setup		= macsec_setup,
 	.validate	= macsec_validate_attr,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= macsec_newlink,
 	.changelink	= macsec_changelink,
 	.dellink	= macsec_dellink,
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 24298a33e0e9..b51e2e21dead 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1754,6 +1754,7 @@ static struct net *macvlan_get_link_net(const struct net_device *dev)
 static struct rtnl_link_ops macvlan_link_ops = {
 	.kind		= "macvlan",
 	.setup		= macvlan_setup,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= macvlan_newlink,
 	.dellink	= macvlan_dellink,
 	.get_link_net	= macvlan_get_link_net,
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 29a5929d48e5..f24168080e04 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -140,6 +140,7 @@ static struct net *macvtap_link_net(const struct net_device *dev)
 static struct rtnl_link_ops macvtap_link_ops __read_mostly = {
 	.kind		= "macvtap",
 	.setup		= macvtap_setup,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= macvtap_newlink,
 	.dellink	= macvtap_dellink,
 	.get_link_net	= macvtap_link_net,
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8983e75e9881..b041ddc2ab34 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4579,6 +4579,10 @@ static struct net *vxlan_get_link_net(const struct net_device *dev)
 	return READ_ONCE(vxlan->net);
 }
 
+struct link_deps vxlan_newlink_deps = {
+	.mandatory.data = { IFLA_VXLAN_LINK, },
+};
+
 static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
 	.kind		= "vxlan",
 	.maxtype	= IFLA_VXLAN_MAX,
@@ -4586,7 +4590,9 @@ static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
 	.priv_size	= sizeof(struct vxlan_dev),
 	.setup		= vxlan_setup,
 	.validate	= vxlan_validate,
+	.newlink_deps	= &vxlan_newlink_deps,
 	.newlink	= vxlan_newlink,
+	.changelink_deps= &vxlan_newlink_deps,
 	.changelink	= vxlan_changelink,
 	.dellink	= vxlan_dellink,
 	.get_size	= vxlan_get_size,
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..c80ae0e0df53 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -622,6 +622,7 @@ static void virt_wifi_dellink(struct net_device *dev,
 static struct rtnl_link_ops virt_wifi_link_ops = {
 	.kind		= "virt_wifi",
 	.setup		= virt_wifi_setup,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= virt_wifi_newlink,
 	.dellink	= virt_wifi_dellink,
 	.priv_size	= sizeof(struct virt_wifi_netdev_priv),
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b45d57b5968a..f1702e8872cf 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -29,6 +29,18 @@ static inline enum rtnl_kinds rtnl_msgtype_kind(int msgtype)
 	return msgtype & RTNL_KIND_MASK;
 }
 
+#define MAX_LINK_DEPS 5
+struct link_deps_table {
+	int	tb[MAX_LINK_DEPS + 1];
+	int	data[MAX_LINK_DEPS + 1];
+};
+
+struct link_deps {
+	struct link_deps_table mandatory;
+	struct link_deps_table optional;
+};
+extern struct link_deps generic_newlink_deps;
+
 void rtnl_register(int protocol, int msgtype,
 		   rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
 int rtnl_register_module(struct module *owner, int protocol, int msgtype,
@@ -58,7 +70,9 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *		and @setup are unused. Returns a netdev or ERR_PTR().
  *	@priv_size: sizeof net_device private space
  *	@setup: net_device setup function
+ *	@newlink_deps: Indexes of real devices that newlink depends on.
  *	@newlink: Function for configuring and registering a new device
+ *	@changelink_deps: Indexes of real devices that changelink depends on.
  *	@changelink: Function for changing parameters of an existing device
  *	@dellink: Function to remove a device
  *	@get_size: Function to calculate required room for dumping device
@@ -96,11 +110,13 @@ struct rtnl_link_ops {
 					    struct nlattr *data[],
 					    struct netlink_ext_ack *extack);
 
+	struct link_deps	*newlink_deps;
 	int			(*newlink)(struct net *src_net,
 					   struct net_device *dev,
 					   struct nlattr *tb[],
 					   struct nlattr *data[],
 					   struct netlink_ext_ack *extack);
+	struct link_deps	*changelink_deps;
 	int			(*changelink)(struct net_device *dev,
 					      struct nlattr *tb[],
 					      struct nlattr *data[],
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index cf5219df7903..c71180ba0746 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -293,6 +293,7 @@ struct rtnl_link_ops vlan_link_ops __read_mostly = {
 	.priv_size	= sizeof(struct vlan_dev_priv),
 	.setup		= vlan_setup,
 	.validate	= vlan_validate,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= vlan_newlink,
 	.changelink	= vlan_changelink,
 	.dellink	= unregister_vlan_dev,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 046736091b4f..cf060ba4cd1d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3490,6 +3490,11 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 	return err;
 }
 
+struct link_deps generic_newlink_deps = {
+	.mandatory.tb = { IFLA_LINK, }
+};
+EXPORT_SYMBOL_GPL(generic_newlink_deps);
+
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
 			       const struct nlmsghdr *nlh,
diff --git a/net/dsa/netlink.c b/net/dsa/netlink.c
index 1332e56349e5..835d935814fb 100644
--- a/net/dsa/netlink.c
+++ b/net/dsa/netlink.c
@@ -11,6 +11,10 @@ static const struct nla_policy dsa_policy[IFLA_DSA_MAX + 1] = {
 	[IFLA_DSA_CONDUIT]	= { .type = NLA_U32 },
 };
 
+struct link_deps dsa_changelink_deps = {
+	.optional.data = { IFLA_DSA_CONDUIT, },
+};
+
 static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
@@ -57,6 +61,7 @@ struct rtnl_link_ops dsa_link_ops __read_mostly = {
 	.priv_size		= sizeof(struct dsa_port),
 	.maxtype		= IFLA_DSA_MAX,
 	.policy			= dsa_policy,
+	.changelink_deps	= &dsa_changelink_deps,
 	.changelink		= dsa_changelink,
 	.get_size		= dsa_get_size,
 	.fill_info		= dsa_fill_info,
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f6ff0b61e08a..6ec883739415 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -176,12 +176,18 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
+static struct link_deps hsr_newlink_deps = {
+	.mandatory.data = { IFLA_HSR_SLAVE1, IFLA_HSR_SLAVE2, },
+	.optional.data = { IFLA_HSR_INTERLINK, },
+};
+
 static struct rtnl_link_ops hsr_link_ops __read_mostly = {
 	.kind		= "hsr",
 	.maxtype	= IFLA_HSR_MAX,
 	.policy		= hsr_policy,
 	.priv_size	= sizeof(struct hsr_priv),
 	.setup		= hsr_dev_setup,
+	.newlink_deps	= &hsr_newlink_deps,
 	.newlink	= hsr_newlink,
 	.dellink	= hsr_dellink,
 	.fill_info	= hsr_fill_info,
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 77b4e92027c5..4236aafd448f 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -196,6 +196,7 @@ static struct rtnl_link_ops lowpan_link_ops __read_mostly = {
 	.kind		= "lowpan",
 	.priv_size	= LOWPAN_PRIV_SIZE(sizeof(struct lowpan_802154_dev)),
 	.setup		= lowpan_setup,
+	.newlink_deps	= &generic_newlink_deps,
 	.newlink	= lowpan_newlink,
 	.dellink	= lowpan_dellink,
 	.validate	= lowpan_validate,


