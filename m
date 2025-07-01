Return-Path: <netdev+bounces-202927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF298AEFBA3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FE916400E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66D278761;
	Tue,  1 Jul 2025 14:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71C278162;
	Tue,  1 Jul 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378682; cv=none; b=giRx6QUvJTOLtp7KVPPZZyMPDiRANg8RVBK9UeODp0tU2tDE0q3xD67++kma2arztodndNVePtMl7l6qb3L2MeTDKKJV9SZ0xviL5+7TT6VX/q7P6TVS0MlEvLi1zYgqtTI1QTmW9RchBMfQdJwmlRPWPg+NwpJM5FF+2AQYLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378682; c=relaxed/simple;
	bh=i6JjswteP7s2FdGHnJoUjsHsu4jCrxOmegCrVAuC/M4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOHueS36B5ggfbRuDOPxrMdE0StwIOU5lEPIyCu/+x8WG56ubCIYyiulZm23SWpvXUmeO4oPWNn1acNvAeMGLnHyY8Tw9O8l0KI8cR+B3qClM5CXWq3oX/Yq/W0Ujkpsjxd8tYE7ZFHkyf+H+qvknRbi+DUsIXzATRYuARVgmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2976B46C75;
	Tue,  1 Jul 2025 16:04:31 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ipv6: add `force_forwarding` sysctl to enable per-interface forwarding
Date: Tue,  1 Jul 2025 16:04:22 +0200
Message-Id: <20250701140423.487411-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is currently impossible to enable ipv6 forwarding on a per-interface
basis like in ipv4. To enable forwarding on an ipv6 interface we need to
enable it on all interfaces and disable it on the other interfaces using
a netfilter rule. This is especially cumbersome if you have lots of
interface and only want to enable forwarding on a few. According to the
sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
for all interfaces, while the interface-specific
`net.ipv6.conf.<interface>.forwarding` configures the interface
Host/Router configuration.

Introduce a new sysctl flag `force_forwarding`, which can be set on every
interface. The ip6_forwarding function will then check if the global
forwarding flag OR the force_forwarding flag is active and forward the
packet.

To preserver backwards-compatibility reset the flag (global and on all
interfaces) to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.

[0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

Changelog:
v1 -> v2:
    * rename from `do_forwarding` to `force_forwarding`.
    * add global `force_forwarding` flag which will enable
      `force_forwarding` on every interface like the
      `ipv4.all.forwarding` flag.
    * `forwarding`=0 will disable global and per-interface
      `force_forwarding`.
    * export option as NETCONFA_FORCE_FORWARDING.

 Documentation/networking/ip-sysctl.rst |  5 ++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  1 +
 include/uapi/linux/netconf.h           |  1 +
 include/uapi/linux/sysctl.h            |  1 +
 net/ipv6/addrconf.c                    | 93 ++++++++++++++++++++++++++
 net/ipv6/ip6_output.c                  |  3 +-
 7 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 0f1251cce314..f709aed44cde 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2292,6 +2292,11 @@ conf/all/forwarding - BOOLEAN
 proxy_ndp - BOOLEAN
 	Do proxy ndp.
 
+force_forwarding - BOOLEAN
+	Enable forwarding on this interface only -- regardless of the setting on
+	``conf/all/forwarding``. When setting ``conf.all.forwarding`` to 0,
+	the `force_forwarding` flag will be reset on all interfaces.
+
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv6 reply packets that are not
 	associated with a socket for example, TCP RSTs or ICMPv6 echo replies).
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5aeeed22f35b..5380107e466c 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -19,6 +19,7 @@ struct ipv6_devconf {
 	__s32		forwarding;
 	__s32		disable_policy;
 	__s32		proxy_ndp;
+	__s32		force_forwarding;
 	__cacheline_group_end(ipv6_devconf_read_txrx);
 
 	__s32		accept_ra;
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index cf592d7b630f..d4d3ae774b26 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -199,6 +199,7 @@ enum {
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
 	DEVCONF_ACCEPT_RA_MIN_LFT,
+	DEVCONF_FORCE_FORWARDING,
 	DEVCONF_MAX
 };
 
diff --git a/include/uapi/linux/netconf.h b/include/uapi/linux/netconf.h
index fac4edd55379..1c8c84d65ae3 100644
--- a/include/uapi/linux/netconf.h
+++ b/include/uapi/linux/netconf.h
@@ -19,6 +19,7 @@ enum {
 	NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 	NETCONFA_INPUT,
 	NETCONFA_BC_FORWARDING,
+	NETCONFA_FORCE_FORWARDING,
 	__NETCONFA_MAX
 };
 #define NETCONFA_MAX	(__NETCONFA_MAX - 1)
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 8981f00204db..63d1464cb71c 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -573,6 +573,7 @@ enum {
 	NET_IPV6_ACCEPT_RA_FROM_LOCAL=26,
 	NET_IPV6_ACCEPT_RA_RT_INFO_MIN_PLEN=27,
 	NET_IPV6_RA_DEFRTR_METRIC=28,
+	NET_IPV6_FORCE_FORWARDING=29,
 	__NET_IPV6_MAX
 };
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..eda63b92b616 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.ndisc_evict_nocarrier	= 1,
 	.ra_honor_pio_life	= 0,
 	.ra_honor_pio_pflag	= 0,
+	.force_forwarding	= 0,
 };
 
 static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
@@ -303,6 +304,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.ndisc_evict_nocarrier	= 1,
 	.ra_honor_pio_life	= 0,
 	.ra_honor_pio_pflag	= 0,
+	.force_forwarding	= 0,
 };
 
 /* Check if link is ready: is it up and is a valid qdisc available */
@@ -857,6 +859,15 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get_rtnl_net(dev);
 		if (idev) {
 			int changed = (!idev->cnf.forwarding) ^ (!newf);
+			/*
+			 * With the introduction of force_forwarding, we need to be backwards
+			 * compatible, so that means we need to set the force_forwarding flag
+			 * on every interface to 0 if net.ipv6.conf.all.forwarding is set to 0.
+			 * This allows the global forwarding flag to disable forwarding for
+			 * all interfaces.
+			 */
+			if (newf == 0)
+				WRITE_ONCE(idev->cnf.force_forwarding, newf);
 
 			WRITE_ONCE(idev->cnf.forwarding, newf);
 			if (changed)
@@ -896,6 +907,16 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
 						     NETCONFA_IFINDEX_DEFAULT,
 						     net->ipv6.devconf_dflt);
 
+		/*
+		 * With the introduction of force_forwarding, we need to be backwards
+		 * compatible, so that means we need to set the force_forwarding global
+		 * flag to 0 if the global forwarding flag is set to 0. Below in
+		 * addrconf_forward_change(), we also set the force_forwarding flag on every
+		 * interface to 0 if the global forwarding flag is set to 0.
+		 */
+		if (newf == 0)
+			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, newf);
+
 		addrconf_forward_change(net, newf);
 		if ((!newf) ^ (!old))
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
@@ -5719,6 +5740,7 @@ static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
 		READ_ONCE(cnf->accept_untracked_na);
 	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
+	array[DEVCONF_FORCE_FORWARDING] = READ_ONCE(cnf->force_forwarding);
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -6747,6 +6769,70 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
 	return ret;
 }
 
+/* called with RTNL locked */
+static void addrconf_force_forward_change(struct net *net, __s32 newf)
+{
+	struct net_device *dev;
+	struct inet6_dev *idev;
+
+	for_each_netdev(net, dev) {
+		idev = __in6_dev_get_rtnl_net(dev);
+		if (idev) {
+			int changed = (!idev->cnf.force_forwarding) ^ (!newf);
+
+			WRITE_ONCE(idev->cnf.force_forwarding, newf);
+			if (changed) {
+				inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
+							     NETCONFA_FORCE_FORWARDING,
+							     dev->ifindex, &idev->cnf);
+			}
+		}
+	}
+}
+
+static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
+					    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int *valp = ctl->data;
+	int ret;
+	int old, new;
+
+	old = *valp;
+	ret = proc_douintvec(ctl, write, buffer, lenp, ppos);
+	new = *valp;
+
+	if (write && old != new) {
+		struct net *net = ctl->extra2;
+
+		if (!rtnl_net_trylock(net))
+			return restart_syscall();
+
+		if (valp == &net->ipv6.devconf_dflt->force_forwarding) {
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     NETCONFA_IFINDEX_DEFAULT,
+						     net->ipv6.devconf_dflt);
+		} else if (valp == &net->ipv6.devconf_all->force_forwarding) {
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     NETCONFA_IFINDEX_ALL,
+						     net->ipv6.devconf_all);
+
+			addrconf_force_forward_change(net, new);
+		} else {
+			struct inet6_dev *idev = ctl->extra1;
+
+			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
+						     NETCONFA_FORCE_FORWARDING,
+						     idev->dev->ifindex,
+						     &idev->cnf);
+		}
+		rtnl_net_unlock(net);
+	}
+
+	return ret;
+}
+
 static int minus_one = -1;
 static const int two_five_five = 255;
 static u32 ioam6_if_id_max = U16_MAX;
@@ -7217,6 +7303,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "force_forwarding",
+		.data		= &ipv6_devconf.force_forwarding,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= addrconf_sysctl_force_forwarding,
+	},
 };
 
 static int __addrconf_sysctl_register(struct net *net, char *dev_name,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db..c15ed4197416 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -509,7 +509,8 @@ int ip6_forward(struct sk_buff *skb)
 	u32 mtu;
 
 	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
-	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
+	if ((idev && READ_ONCE(idev->cnf.force_forwarding) == 0) &&
+	    READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
 		goto error;
 
 	if (skb->pkt_type != PACKET_HOST)
-- 
2.39.5



