Return-Path: <netdev+bounces-201196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A12AE867B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8797BA8FF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ECD26658F;
	Wed, 25 Jun 2025 14:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603D266562;
	Wed, 25 Jun 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861587; cv=none; b=CcTudH51m9v575RaZ96YUCSJg9LEV9MMdCZMwHjKnZqz5pGsJayogAA3xr2PECSVry+MldgKmUtANEqqt9fAusetysfKAPD0B6gziTddSC85E4E3VF36l+fDSNRy7pqt2/nr0xvOnBIolZMRQEw2zFOjarO+xtm341wfX5K8dfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861587; c=relaxed/simple;
	bh=/9VFx4V/R12ObC+QTUIcUs4r3Yji2iXrxnaQH+uihB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePMwJ0m/MuyvrYatfeHUtMwYIlQiIzuMcDgEA0BDqPZA3eGcsL1cZtCh4sqH0v7WT2CGIGfS8cvRkEf7Th5croliUGVjruG2oQ+OnukXSliaG5+V5CbtnbnoiOE4rL+QdFc3ynyP/sFbycdMd0vbhcIiWoLiOVQvTB12RYNroxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8B9074685B;
	Wed, 25 Jun 2025 16:26:15 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Ahern <dsahern@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: add `do_forwarding` sysctl to enable per-interface forwarding
Date: Wed, 25 Jun 2025 16:26:06 +0200
Message-Id: <20250625142607.828873-1-g.goller@proxmox.com>
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

Introduce a new sysctl flag `do_forwarding`, which can be set on every
interface. The ip6_forwarding function will then check if the global
forwarding flag OR the do_forwarding flag is active and forward the
packet. To preserver backwards-compatibility also reset the flag on all
interfaces when setting the global forwarding flag to 0.

[0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

* I don't have any hard feelings about the naming, Nicolas Dichtel
  proposed `fwd_per_iface` but I think `do_forwarding` is a better fit.
* I'm also not sure about the reset when setting the global forwarding
  flag; don't know if I did that right. Feedback is welcome!
* Thanks for the help!

 Documentation/networking/ip-sysctl.rst |  5 +++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  1 +
 include/uapi/linux/sysctl.h            |  1 +
 net/ipv6/addrconf.c                    | 21 +++++++++++++++++++++
 net/ipv6/ip6_output.c                  |  3 ++-
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 0f1251cce314..fa966a710e21 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2292,6 +2292,11 @@ conf/all/forwarding - BOOLEAN
 proxy_ndp - BOOLEAN
 	Do proxy ndp.
 
+do_forwarding - BOOLEAN
+	Enable forwarding on this interface only -- regardless of the setting on
+	``conf/all/forwarding``. When setting ``conf.all.forwarding`` to 0,
+	the `do_forwarding` flag will be reset on all interfaces.
+
 fwmark_reflect - BOOLEAN
 	Controls the fwmark of kernel-generated IPv6 reply packets that are not
 	associated with a socket for example, TCP RSTs or ICMPv6 echo replies).
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5aeeed22f35b..74d7cfbb8f83 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -19,6 +19,7 @@ struct ipv6_devconf {
 	__s32		forwarding;
 	__s32		disable_policy;
 	__s32		proxy_ndp;
+	__u8		do_forwarding;
 	__cacheline_group_end(ipv6_devconf_read_txrx);
 
 	__s32		accept_ra;
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index cf592d7b630f..66147838bb83 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -199,6 +199,7 @@ enum {
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
 	DEVCONF_ACCEPT_RA_MIN_LFT,
+	DEVCONF_DO_FORWARDING,
 	DEVCONF_MAX
 };
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 8981f00204db..d540689910ec 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -573,6 +573,7 @@ enum {
 	NET_IPV6_ACCEPT_RA_FROM_LOCAL=26,
 	NET_IPV6_ACCEPT_RA_RT_INFO_MIN_PLEN=27,
 	NET_IPV6_RA_DEFRTR_METRIC=28,
+	NET_IPV6_DO_FORWARDING=29,
 	__NET_IPV6_MAX
 };
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..2f0c68428f63 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.ndisc_evict_nocarrier	= 1,
 	.ra_honor_pio_life	= 0,
 	.ra_honor_pio_pflag	= 0,
+	.do_forwarding		= 0,
 };
 
 static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
@@ -303,6 +304,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.ndisc_evict_nocarrier	= 1,
 	.ra_honor_pio_life	= 0,
 	.ra_honor_pio_pflag	= 0,
+	.do_forwarding		= 0,
 };
 
 /* Check if link is ready: is it up and is a valid qdisc available */
@@ -857,6 +859,15 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get_rtnl_net(dev);
 		if (idev) {
 			int changed = (!idev->cnf.forwarding) ^ (!newf);
+			/*
+			 * With the introduction of do_forwarding, we need to be backwards
+			 * compatible, so that means we need to set the do_forwarding flag
+			 * on every interface to 0 if net.ipv6.conf.all.forwarding is set to 0.
+			 * This allows the global forwarding flag to disable forwarding for
+			 * all interfaces.
+			 */
+			if (newf == 0)
+				WRITE_ONCE(idev->cnf.do_forwarding, newf);
 
 			WRITE_ONCE(idev->cnf.forwarding, newf);
 			if (changed)
@@ -5719,6 +5730,7 @@ static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
 		READ_ONCE(cnf->accept_untracked_na);
 	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
+	array[DEVCONF_DO_FORWARDING] = READ_ONCE(cnf->do_forwarding);
 }
 
 static inline size_t inet6_ifla6_size(void)
@@ -7217,6 +7229,15 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "do_forwarding",
+		.data		= &ipv6_devconf.do_forwarding,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __addrconf_sysctl_register(struct net *net, char *dev_name,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db..a75bbf54157e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -509,7 +509,8 @@ int ip6_forward(struct sk_buff *skb)
 	u32 mtu;
 
 	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
-	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
+	if ((idev && READ_ONCE(idev->cnf.do_forwarding) == 0) &&
+	    READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
 		goto error;
 
 	if (skb->pkt_type != PACKET_HOST)
-- 
2.39.5



