Return-Path: <netdev+bounces-298413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x45hGGFQK2or6gMAu9opvQ
	(envelope-from <netdev+bounces-298413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9885675E7B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pP7F9e3k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298413-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298413-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F183345228
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442B28F948;
	Fri, 12 Jun 2026 00:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3F267B89
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:18:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223489; cv=none; b=UV7FzqZeIPm/F28M7Ekg7G/P0yxPPiJrIwkS0hizFNR6S4+y7mH/y2JSXWVKhPf0W0ninn5Y/MEBWiHxFuKILdZqR/NhiQvozMLPsB6p6wERFadlzSR1iIJ+gKy9uGzAWc49mPtOEczbZwlglaWSYcxGPy0j5qsgVe3rnXwi4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223489; c=relaxed/simple;
	bh=Xz9ugSwa5YYvOkL9xuL4i1virtPc584E70TW0j5vRds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKvBImvX6v99iE6ADE8oQw/hbxw6wXq0OtAYQj7SGax6w40APt4PYUQYCZDld+xfwMkX6tUEqJ7hu82OwbntyWInstsAgYh+68J4s6NRzRbp8BIrz4qa6zbYtvCcRbSs3U6+g3bKkDpJ9PRj600gVrarsw0FLyvOmccHalu0meg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pP7F9e3k; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bbcd40642so339558a91.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223487; x=1781828287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAcnRlHHRnFVlL90bCS1oK0Jvgsedr7+AkI7b5EfYXQ=;
        b=pP7F9e3kBsZ1F7eZqk4JNpN8ed+Be1bFJpzz6tzEG7RWnkDKRdsuNqYM75ghr8o6t4
         ZMNPxFaXIvmS/sP7rg+S2guTAjcEsSQbFXkAjY8nPij0OyNeRUYA65nZhCR3zptUS/43
         u0w8/f+hgq077G8f4ttmHlbvcjxF/RKJpIWV12efkU+4G60aYYSPyWX1IMuHZFJje4Am
         X0DA9cV5fWfRRt+lGPDAJbDYMzeyhQw4FJHMCGfqjkitMM7BgYNjMmW6t9mLRNRePT0C
         hrmATO3qZ1PGFI75mU92T+BBXA78/0Z0/rHUvcARycZJ6+bYzWACgzTomSiR6UpmaPsB
         HJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223487; x=1781828287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAcnRlHHRnFVlL90bCS1oK0Jvgsedr7+AkI7b5EfYXQ=;
        b=cInHAeMTe74GnpIycit76+cS4/xuPRcc3liagWHzWAezpY+4jUAYP6W5Hcj7gOfhl1
         EVi6sxxamZBte5o5FYpf2U+10pyLUbWIuIVRVIU/ZxqerskYmqAGpBiG/iNEJoagFRsM
         FYPGo/O4cWDGDZK2VZGZWT01AQF54N/MqzWIQi11vUu7XxcaghwxqIH1gf4dRuS0zhT/
         QtKlgLYImyHumJWSh6mGVaUiPVtMESbUTwmPo9FOT2JTF1gq0x93KHazGKZVuxXh3m2R
         uyL+ALLwnJbAcnNDTSgbXuwIYUrC1J7TjQyWKHvf8/UcnkJJPrAsNP7gnmh9R8eLo7m3
         773w==
X-Forwarded-Encrypted: i=1; AFNElJ9T3I/AnppAkTrTMSZDcdVGZF/p1ZUP4fOwDY2MDvOesG0KHbumjppGUlOdvlgkviKvFQDDJCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19yF8mF0bMT4yb2VUQm6AzYfNc9etRhwUBkAghg8ag5sLMY72
	bAkDX6/UnCVkZT7/77vC1f2WKVO+DiEayhZvdabXSHpgVrvWQY7UWPZUgUs/9YvQCYeqrGU4OzK
	C3soGXA==
X-Received: from pgkd4.prod.google.com ([2002:a63:f244:0:b0:c85:8227:a92d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a05:b0:368:ed92:6f6
 with SMTP id 98e67ed59e1d1-37a01845f4amr636586a91.1.1781223486549; Thu, 11
 Jun 2026 17:18:06 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:32 +0000
In-Reply-To: <20260612001803.23341-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-2-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 1/5] ethtool: Introduce ETHTOOL_MSG_TSINFO_SET
 for virtual interfaces.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuniyu@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298413-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9885675E7B

Before enabling SO_TIMESTAMPING, applications typically try to
enable hardware timestamping on network interfaces via SIOCSHWTSTAMP
(or ETHTOOL_MSG_TSCONFIG_SET).

The timestamping capability on an interface can be checked via
ETHTOOL_MSG_TSINFO_GET:

  # ethtool -T eth0
  Time stamping parameters for eth0:
  Capabilities:
  	hardware-transmit
  	software-transmit
  	hardware-receive
  	software-receive
  	software-system-clock
  	hardware-raw-clock
  PTP Hardware Clock: none
  Hardware Transmit Timestamp Modes:
  	off
  	on
  Hardware Receive Filter Modes:
  	none
  	all

These operations rely on the driver implementing two callbacks,
dev->netdev_ops->ndo_hwtstamp_{get,set}().

However, among all virtual network interfaces, only bond and
macvlan currently implement them.

As a result, most virtual interfaces cannot advertise the
capabilities of their underlying devices:

  # ip link add ipvl0 link eth0 type ipvlan mode l2 bridge
  # ethtool -T ipvl0
  Time stamping parameters for ipvl0:
  Capabilities:
  	software-receive
  	software-system-clock
  PTP Hardware Clock: none
  Hardware Transmit Timestamp Modes: none
  Hardware Receive Filter Modes: none

While these callbacks could be implemented in each virtual
interface, this approach is limited to those directly linked
to a physical device.

Not all virtual interfaces are tied to real hardware; for
instance, packets from UDP tunnel devices eventually pass
through physical devices and can be hardware-timestamped there.

Let's allow configuring the hardware timestamping capability on
virtual interfaces via ETHTOOL_MSG_TSINFO_SET.

Note that SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE
are automatically added since __ethtool_get_ts_info() and
ethnl_tsinfo_end_dump() report them for all devices.

By configuring this capability, ioctl(SIOCSHWTSTAMP) (hwstamp_ctl
below) can enable TX/RX hardware timestamping successfully:

  # ./tools/net/ynl/pyynl/cli.py \
      --spec Documentation/netlink/specs/ethtool.yaml \
      --do tsinfo-set \
      --json '{"header": {"dev-index": 6},
               "timestamping": {"nomask": true, "bits": {
                   "bit": [{"name": "hardware-transmit"},
                           {"name": "software-transmit"},
                           {"name": "hardware-receive"}]
               }},
               "tx-types": {"nomask": true, "bits": {
                   "bit": [{"name": "off"}, {"name": "on"}]
               }},
               "rx-filters": {"nomask": true, "bits": {
                   "bit" : [{"name": "none"}, {"name": "all"}]
               }}}'

  # ethtool -T ipvl0
  Time stamping parameters for ipvl0:
  Capabilities:
  	hardware-transmit
  	software-transmit
  	hardware-receive
  	software-receive
  	software-system-clock
  PTP Hardware Clock: none
  Hardware Transmit Timestamp Modes:
  	off
  	on
  Hardware Receive Filter Modes:
  	none
  	all

  # hwstamp_ctl -i ipvl0 -t 1 -r 1
  current settings:
  tx_type 0
  rx_filter 0
  new settings:
  tx_type 1
  rx_filter 1

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/netlink/specs/ethtool.yaml      |  13 ++
 include/linux/netdevice.h                     |  11 ++
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/core/dev_ioctl.c                          |  31 ++++-
 net/ethtool/common.c                          |   4 +
 net/ethtool/netlink.c                         |   8 ++
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/tsconfig.c                        |   7 +-
 net/ethtool/tsinfo.c                          | 123 +++++++++++++++++-
 9 files changed, 188 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..2dace12c8b4d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2859,6 +2859,19 @@ operations:
             - worst-channel
             - link
       dump: *mse-get-op
+    -
+      name: tsinfo-set
+      doc: Set tsinfo params.
+
+      attribute-set: tsinfo
+
+      do: &tsinfo-set-op
+        request:
+          attributes:
+            - header
+            - timestamping
+            - tx-types
+            - rx-filters
 
 mcast-groups:
   list:
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 74507c006490..2693161d4168 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2087,6 +2087,7 @@ enum netdev_reg_state {
  *				offload capabilities of the device
  *	@udp_tunnel_nic:	UDP tunnel offload state
  *	@ethtool:	ethtool related state
+ *	@tsinfo:	HW timestamping capability for virtual devices
  *	@xdp_state:		stores info on attached XDP BPF programs
  *
  *	@nested_level:	Used as a parameter of spin_lock_nested() of
@@ -2509,6 +2510,16 @@ struct net_device {
 	 */
 	struct netdev_config	*cfg_pending;
 	struct ethtool_netdev_state *ethtool;
+	struct {
+		struct {
+			u32	tx_type;
+			u32	rx_filter;
+		} cfg;
+		u32		so_timestamping;
+		u32		tx_types;
+		u32		rx_filters;
+		bool		enabled;
+	} tsinfo;
 
 	/* protected by rtnl_lock */
 	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..5aaa3bf9a073 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -893,6 +893,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_TSINFO_SET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index f3979b276090..3ecc57fd75c9 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -260,6 +260,15 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 {
 	struct hwtstamp_provider *hwprov;
 
+	if (!dev->netdev_ops->ndo_hwtstamp_get) {
+		if (!dev->tsinfo.enabled)
+			return -EOPNOTSUPP;
+
+		cfg->rx_filter = dev->tsinfo.cfg.rx_filter;
+		cfg->tx_type = dev->tsinfo.cfg.tx_type;
+		return 0;
+	}
+
 	hwprov = rtnl_dereference(dev->hwprov);
 	if (hwprov) {
 		cfg->qualifier = hwprov->desc.qualifier;
@@ -286,7 +295,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	struct hwtstamp_config cfg;
 	int err;
 
-	if (!ops->ndo_hwtstamp_get)
+	if (!ops->ndo_hwtstamp_get && !dev->tsinfo.enabled)
 		return -EOPNOTSUPP;
 
 	if (!netif_device_present(dev))
@@ -337,6 +346,20 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 	bool phy_ts;
 	int err;
 
+	if (!ops->ndo_hwtstamp_set) {
+		if (!dev->tsinfo.enabled ||
+		    !(dev->tsinfo.tx_types & BIT(cfg->tx_type)) ||
+		    !(dev->tsinfo.rx_filters & BIT(cfg->rx_filter)))
+			return -EOPNOTSUPP;
+
+		if (cfg->flags)
+			return -EINVAL;
+
+		dev->tsinfo.cfg.tx_type = cfg->tx_type;
+		dev->tsinfo.cfg.rx_filter = cfg->rx_filter;
+		return 0;
+	}
+
 	hwprov = rtnl_dereference(dev->hwprov);
 	if (hwprov) {
 		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
@@ -413,7 +436,7 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return err;
 	}
 
-	if (!ops->ndo_hwtstamp_set)
+	if (!ops->ndo_hwtstamp_set && !dev->tsinfo.enabled)
 		return -EOPNOTSUPP;
 
 	if (!netif_device_present(dev))
@@ -447,7 +470,7 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (!ops->ndo_hwtstamp_get)
+	if (!ops->ndo_hwtstamp_get && !dev->tsinfo.enabled)
 		return -EOPNOTSUPP;
 
 	netdev_lock_ops(dev);
@@ -468,7 +491,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (!ops->ndo_hwtstamp_set)
+	if (!ops->ndo_hwtstamp_set && !dev->tsinfo.enabled)
 		return -EOPNOTSUPP;
 
 	netdev_lock_ops(dev);
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 84ec88dee05c..bb0c02d92a9b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1090,6 +1090,10 @@ int __ethtool_get_ts_info(struct net_device *dev,
 			err = ops->get_ts_info(dev, info);
 			if (!err && info->phc_index >= 0)
 				info->phc_source = HWTSTAMP_SOURCE_NETDEV;
+		} else if (dev->tsinfo.enabled) {
+			info->so_timestamping = dev->tsinfo.so_timestamping;
+			info->tx_types = dev->tsinfo.tx_types;
+			info->rx_filters = dev->tsinfo.rx_filters;
 		}
 
 		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 25e22c48060a..07d1a010b1cc 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -422,6 +422,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
+	[ETHTOOL_MSG_TSINFO_SET]	= &ethnl_tsinfo_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1548,6 +1549,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_TSINFO_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_default_set_doit,
+		.policy = ethnl_tsinfo_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_tsinfo_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 674c9c19529b..7c2a350f8ba4 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -502,6 +502,7 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
+extern const struct nla_policy ethnl_tsinfo_set_policy[ETHTOOL_A_TSINFO_MAX + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 664c3fe49b5b..9f387339fc8e 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -41,7 +41,7 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	struct kernel_hwtstamp_config cfg = {};
 	int ret;
 
-	if (!dev->netdev_ops->ndo_hwtstamp_get)
+	if (!dev->netdev_ops->ndo_hwtstamp_get && !dev->tsinfo.enabled)
 		return -EOPNOTSUPP;
 
 	ret = ethnl_ops_begin(dev);
@@ -61,7 +61,7 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	if (hwprov) {
 		data->hwprov_desc.index = hwprov->desc.index;
 		data->hwprov_desc.qualifier = hwprov->desc.qualifier;
-	} else {
+	} else if (!dev->tsinfo.enabled) {
 		struct kernel_ethtool_ts_info ts_info = {};
 
 		ts_info.phc_index = -1;
@@ -252,7 +252,8 @@ static int ethnl_set_tsconfig_validate(struct ethnl_req_info *req_base,
 {
 	const struct net_device_ops *ops = req_base->dev->netdev_ops;
 
-	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
+	if ((!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get) &&
+	    !READ_ONCE(req_base->dev->tsinfo.enabled))
 		return -EOPNOTSUPP;
 
 	return 1;
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 14bf01e3b55c..c9078aa4a897 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -38,6 +38,14 @@ const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
 		NLA_POLICY_NESTED(ethnl_ts_hwtst_prov_policy),
 };
 
+const struct nla_policy ethnl_tsinfo_set_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
+	[ETHTOOL_A_TSINFO_HEADER]		=
+		NLA_POLICY_NESTED(ethnl_header_policy_stats),
+	[ETHTOOL_A_TSINFO_TIMESTAMPING]		= { .type = NLA_NESTED },
+	[ETHTOOL_A_TSINFO_TX_TYPES]		= { .type = NLA_NESTED },
+	[ETHTOOL_A_TSINFO_RX_FILTERS]		= { .type = NLA_NESTED },
+};
+
 int ts_parse_hwtst_provider(const struct nlattr *nest,
 			    struct hwtstamp_provider_desc *hwprov_desc,
 			    struct netlink_ext_ack *extack,
@@ -390,15 +398,17 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 {
 	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct kernel_ethtool_ts_info *ts_info;
 	struct tsinfo_reply_data *reply_data;
 	struct tsinfo_req_info *req_info;
 	void *ehdr = NULL;
 	int ret = 0;
 
-	if (!ops->get_ts_info)
+	if (!ops->get_ts_info && !dev->tsinfo.enabled)
 		return -EOPNOTSUPP;
 
 	reply_data = ctx->reply_data;
+	ts_info = &reply_data->ts_info;
 	req_info = ctx->req_info;
 	for (; ctx->pos_phcqualifier < HWTSTAMP_PROVIDER_QUALIFIER_CNT;
 	     ctx->pos_phcqualifier++) {
@@ -411,9 +421,16 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 			return PTR_ERR(ehdr);
 
 		reply_data->ts_info.phc_qualifier = ctx->pos_phcqualifier;
-		ret = ops->get_ts_info(dev, &reply_data->ts_info);
-		if (ret < 0)
-			goto err;
+
+		if (dev->tsinfo.enabled) {
+			ts_info->so_timestamping |= dev->tsinfo.so_timestamping;
+			ts_info->tx_types |= dev->tsinfo.tx_types;
+			ts_info->rx_filters |= dev->tsinfo.rx_filters;
+		} else {
+			ret = ops->get_ts_info(dev, ts_info);
+			if (ret < 0)
+				goto err;
+		}
 
 		if (reply_data->ts_info.phc_index >= 0)
 			reply_data->ts_info.phc_source = HWTSTAMP_SOURCE_NETDEV;
@@ -563,6 +580,101 @@ int ethnl_tsinfo_done(struct netlink_callback *cb)
 	return 0;
 }
 
+static int ethnl_tsinfo_set_validate(struct ethnl_req_info *req_base,
+				     struct genl_info *info)
+{
+	const struct net_device *dev = req_base->dev;
+
+	if (!dev->rtnl_link_ops ||
+	    dev->ethtool_ops->get_ts_info ||
+	    dev->netdev_ops->ndo_hwtstamp_set ||
+	    dev->netdev_ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
+
+	return 1;
+}
+
+static int ethnl_tsinfo_set(struct ethnl_req_info *req_base,
+			    struct genl_info *info)
+{
+	struct net_device *dev = req_base->dev;
+	struct kernel_ethtool_ts_info ts_info;
+	struct nlattr **tb = info->attrs;
+	bool config_mod = false;
+	int ret;
+
+	ts_info.so_timestamping = dev->tsinfo.so_timestamping;
+	ts_info.tx_types = dev->tsinfo.tx_types;
+	ts_info.rx_filters = dev->tsinfo.rx_filters;
+
+	if (tb[ETHTOOL_A_TSINFO_TIMESTAMPING]) {
+		ret = ethnl_update_bitset32(&ts_info.so_timestamping,
+					    __SOF_TIMESTAMPING_CNT,
+					    tb[ETHTOOL_A_TSINFO_TIMESTAMPING],
+					    sof_timestamping_names, info->extack,
+					    &config_mod);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (tb[ETHTOOL_A_TSINFO_TX_TYPES]) {
+		ret = ethnl_update_bitset32(&ts_info.tx_types,
+					    __HWTSTAMP_TX_CNT,
+					    tb[ETHTOOL_A_TSINFO_TX_TYPES],
+					    ts_tx_type_names, info->extack,
+					    &config_mod);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (tb[ETHTOOL_A_TSINFO_RX_FILTERS]) {
+		ret = ethnl_update_bitset32(&ts_info.rx_filters,
+					    __HWTSTAMP_FILTER_CNT,
+					    tb[ETHTOOL_A_TSINFO_RX_FILTERS],
+					    ts_rx_filter_names, info->extack,
+					    &config_mod);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!config_mod)
+		goto out;
+
+	if (!ts_info.so_timestamping &&
+	    !ts_info.tx_types && !ts_info.rx_filters) {
+		WRITE_ONCE(dev->tsinfo.enabled, false);
+		memset(&dev->tsinfo, 0, offsetof(typeof(dev->tsinfo), enabled));
+		goto out;
+	}
+
+	/* __ethtool_get_ts_info() and ethnl_tsinfo_end_dump()
+	 * unconditionally report these flags.
+	 */
+	ts_info.so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
+				   SOF_TIMESTAMPING_SOFTWARE;
+
+	/* Fallback to HWTSTAMP_TX_OFF / HWTSTAMP_FILTER_NONE
+	 * if the current mode is not supported.
+	 */
+	if (!(ts_info.tx_types & BIT(dev->tsinfo.cfg.tx_type))) {
+		ts_info.tx_types |= BIT(HWTSTAMP_TX_OFF);
+		dev->tsinfo.cfg.tx_type = HWTSTAMP_TX_OFF;
+	}
+	if (!(ts_info.rx_filters & BIT(dev->tsinfo.cfg.rx_filter))) {
+		ts_info.rx_filters |= BIT(HWTSTAMP_FILTER_NONE);
+		dev->tsinfo.cfg.rx_filter = HWTSTAMP_FILTER_NONE;
+	}
+
+	dev->tsinfo.so_timestamping = ts_info.so_timestamping;
+	dev->tsinfo.tx_types = ts_info.tx_types;
+	dev->tsinfo.rx_filters = ts_info.rx_filters;
+
+	WRITE_ONCE(dev->tsinfo.enabled, true);
+out:
+	/* no notification. */
+	return 0;
+}
+
 const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.request_cmd		= ETHTOOL_MSG_TSINFO_GET,
 	.reply_cmd		= ETHTOOL_MSG_TSINFO_GET_REPLY,
@@ -574,4 +686,7 @@ const struct ethnl_request_ops ethnl_tsinfo_request_ops = {
 	.prepare_data		= tsinfo_prepare_data,
 	.reply_size		= tsinfo_reply_size,
 	.fill_reply		= tsinfo_fill_reply,
+
+	.set_validate		= ethnl_tsinfo_set_validate,
+	.set			= ethnl_tsinfo_set,
 };
-- 
2.54.0.1136.gdb2ca164c4-goog


