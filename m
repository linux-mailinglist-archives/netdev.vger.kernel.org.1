Return-Path: <netdev+bounces-147951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB49DF4EE
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 08:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6CAB20EEC
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCB24502B;
	Sun,  1 Dec 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="oRlemten"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA208BEE
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733038497; cv=none; b=J9EaD+bpinbSUE85EQvEhqjePcNhca94kLfMm8rkmZP8LdJ6Z04aJeI3v5v7LV8X3YXd7KzPW9uYEq8xD3UZr/Waasz/z2pqLXaMyGGhIN2/Uzk10Zg24xOla2zJyRMgEj4i6ReWu2PUYz8ANdq3TiwU6cW5KiHU0/4NMGuK9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733038497; c=relaxed/simple;
	bh=49Fgk/LPxVwDzp+3Lc/yxuGv7df3m4UXVA2SyzN0inQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eq5707B4gANILGEsIAn0hiZ+tw8c1H17enLHSKFf6wxckOTYBvTyjJ9uxIE7AO4C0sDohDLeFFgApo3HqIh8sfT1M+WXu1BFK4fYCCJ3/Fn8vKONB33IZoea+gNzGeo1i/kNwvKYN304XKz3t5z5diZsxlXuuF5GESFj5clbAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=oRlemten; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251ce598adso2095993b3a.0
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733038495; x=1733643295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeHqr8jmlOUaofAqiZhYBj3XDWjrqtNKIAYnibCbezQ=;
        b=oRlemtenogwAfojGu0d4q574v451J741tzMSjHE71rww0OuvMiXlZO8SKmrYWQHkgb
         StVJ/ct6osuGWx9E0Pt+QJrWWJ2wVJRvSSXGAfX5ts9j/hSb103v1YzMdUMSQXYpURy0
         a92lSiaWgNFspoZwlqY7UiF1zWTdoojvhlKT/UNVNXkXrlJC+dSp/b6ZsjxCY6UTBT8L
         y1qc2DjBB3hUczQV/a3feGkp+NgOHgMC5ddNJmsxEcCRZOCmt77dgyoKxklfeAZfPc0u
         k9c7PdaJVe8DdcWW2B1Qepn2By1hFg/EQVKa79e4mUyx+YcKw9r7GH32RWWen+im6tps
         mstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733038495; x=1733643295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeHqr8jmlOUaofAqiZhYBj3XDWjrqtNKIAYnibCbezQ=;
        b=i/wCldUDfzQxpWGTb3ahEvP5OuoA/AVbwjS7hL8qiuj0SmAE5e3WGGRbAMBY6hDWZo
         SICdG2T45lzgx1GfNw2ck25U65cYyp31NjAM85qzrV2QAJ0JxkMopVH1KuCb4pblj+Qw
         g1ut3LoXstQsKYeSEX0SRG2yAk5n1PjdUqVtlh55BuVK+eE5/9TI51D+5nXS/Fzs1LiP
         E7BKVTS57uwh0ijADVaHON0SAYHJIYieNIYEoFFGIcDZZuDq2tndpFyvmHclAigy860O
         jYVOLyTpAzp+dsyYEZOxN/WU8sueB8lO0TNDy2GdzttqghsyjiR8VrwQd7LJZrC6FGMC
         V0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmTVljBXgY/s2txOsQmincq2J4RDw7qYlEI7y8UC2wUqPXRAb8IlAkw1JJHUxx/bzfGblnokY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRQoyY8r/aBZwTljbRCkoaJEvTVxyx0NwAiJWEZVKS3VaUCDa
	mmzeiCwgqpPJ3GYEBODSEbl9uouwO6NCzQtpKxLrewxVFaGsPIi81niWA+VCp6s=
X-Gm-Gg: ASbGncsOjCL+UDAx1STER6gQOG08BBLYR0CNCZoBTU2713ru888sSmEKgG50ziOGsaR
	yr0x7I7+y4qHU5tZqEoM0zEEQaw7Ip5SP5gAcrorhZOvJ3ALTAhui1z7NCgLpvP1AkWq82HO14S
	saSYXYyo/pBL4yXNmVAEjlfH0DbrWZHjT7x3NaFbFyu+OjwsvUOVUWQ9GM4q8ZvoHBlCfgeEg43
	s6WvV/Ih4R7YPzUhXWpwtEaKRYlkCQg0hhPLSDvPTxl3WaCoFmS7YS75/Dt/fHoFs50ZNHoY+Rw
	t4PVJ7nPvrP2BYepA5X9VcFhtcTjbg8w
X-Google-Smtp-Source: AGHT+IHA9QuhI3MpeCBeLdV0LQQNmGydAr84DTYftwbmoUdNO3COOY8xpoeFqaBwcub2nE+icCE9jA==
X-Received: by 2002:a05:6a00:995:b0:724:60bd:e861 with SMTP id d2e1a72fcca58-72530133976mr24897493b3a.18.1733038494760;
        Sat, 30 Nov 2024 23:34:54 -0800 (PST)
Received: from localhost.localdomain (c-71-197-149-76.hsd1.wa.comcast.net. [71.197.149.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848277sm6229007b3a.177.2024.11.30.23.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 23:34:54 -0800 (PST)
From: Andy Strohman <andrew@andrewstrohman.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Andy Strohman <andrew@andrewstrohman.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dsa: Make offloading optional on per port basis
Date: Sun,  1 Dec 2024 07:42:11 +0000
Message-Id: <20241201074212.2833277-1-andrew@andrewstrohman.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The author has a couple use cases for this:

1) Creating a sniffer, or ethernet tap, by bridging two or more
non-offloaded ports to the bridge, and tcpdump'ing the member
ports. Along the same lines, it would be nice to have the ability
to temporarily disable offloading to sniff all traffic for debugging.

2) Work around bugs in the hardware switch or use features
that are only available in software.

DSA drivers can be modified to remove their port_bridge_join()
dsa_switch_ops member to accomplish this. But, it would be better
to make it this runtime configurable, and configurable on a per port
basis.

The key to signaling that a port is not offloading is by
ensuring dp->bridge == NULL. With this, the VLAN and FDB
operations that affect hardware (ie port_fdb_add, port_vlan_del, etc)
will not run. dsa_user_fdb_event() will bail if !dp->bridge.
dsa_user_port_obj_add() checks dsa_port_offloads_bridge_port(),
and dsa_user_host_vlan_add() checks !dp->bridge.

By being configurable on a per port basis (as opposed to switch-wide),
we can have some subset of a switch's ports offloading and others not.

While this approach is generic, and therefore will be available for all
dsa switches, I have only tested this on a mt7530 switch. It may not be
possible or feasible to disable offloading on other switches.

A flags member was added to the dsa user port netdev private data structure
in order to facilitate adding future dsa specific flags more easily.
IFLA_VLAN_FLAGS was used as an example when implementing the flags member.

Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
---
 include/uapi/linux/if_link.h       | 10 ++++++++
 net/dsa/netlink.c                  | 38 ++++++++++++++++++++++++++++++
 net/dsa/switch.c                   |  3 ++-
 net/dsa/user.h                     |  2 ++
 tools/include/uapi/linux/if_link.h |  1 +
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index f7f638f25020..c5e89064d48c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1972,9 +1972,19 @@ enum {
 	IFLA_DSA_CONDUIT,
 	/* Deprecated, use IFLA_DSA_CONDUIT instead */
 	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
+	IFLA_DSA_FLAGS,
 	__IFLA_DSA_MAX,
 };
 
 #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
 
+struct ifla_dsa_flags {
+	__u32   flags;
+	__u32   mask;
+};
+
+enum dsa_flags {
+	DSA_FLAG_OFFLOADING_DISABLED    = 0x1,
+};
+
 #endif /* _UAPI_LINUX_IF_LINK_H */
diff --git a/net/dsa/netlink.c b/net/dsa/netlink.c
index 1332e56349e5..376ba00957fe 100644
--- a/net/dsa/netlink.c
+++ b/net/dsa/netlink.c
@@ -9,13 +9,35 @@
 
 static const struct nla_policy dsa_policy[IFLA_DSA_MAX + 1] = {
 	[IFLA_DSA_CONDUIT]	= { .type = NLA_U32 },
+	[IFLA_DSA_FLAGS]	= { .len = sizeof(struct ifla_dsa_flags) },
 };
 
+static int dsa_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+	u32 old_flags = p->flags;
+
+	/* For now, we only support make these changes when the port is not a member
+	 * of a bridge (ie in standalone mode). If the user wants to alter these flags
+	 * for ports that are currently members of a bridge need to first remove the
+	 * interface from the bridge. Then they can add interface back
+	 * after making their desired flag changes.
+	 */
+
+	if (netif_is_bridge_port(dev))
+		return -EBUSY;
+
+	p->flags = (old_flags & ~mask) | (flags & mask);
+
+	return 0;
+}
+
 static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
 	int err;
+	struct ifla_dsa_flags *flags;
 
 	if (!data)
 		return 0;
@@ -32,6 +54,12 @@ static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 		if (err)
 			return err;
 	}
+	if (data[IFLA_DSA_FLAGS]) {
+		flags = nla_data(data[IFLA_DSA_FLAGS]);
+		err = dsa_dev_change_flags(dev, flags->flags, flags->mask);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
@@ -45,10 +73,20 @@ static size_t dsa_get_size(const struct net_device *dev)
 static int dsa_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_user_priv *dsa = netdev_priv(dev);
+	struct ifla_dsa_flags f;
+
 
 	if (nla_put_u32(skb, IFLA_DSA_CONDUIT, conduit->ifindex))
 		return -EMSGSIZE;
 
+	if (dsa->flags) {
+		f.flags = dsa->flags;
+		f.mask = ~0;
+		if (nla_put(skb, IFLA_DSA_FLAGS, sizeof(f), &f))
+			return -EMSGSIZE;
+	}
+
 	return 0;
 }
 
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 3d2feeea897b..f0bb354c3961 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -83,9 +83,10 @@ static int dsa_switch_bridge_join(struct dsa_switch *ds,
 				  struct dsa_notifier_bridge_info *info)
 {
 	int err;
+	struct dsa_user_priv *priv = netdev_priv(info->dp->user);
 
 	if (info->dp->ds == ds) {
-		if (!ds->ops->port_bridge_join)
+		if (!ds->ops->port_bridge_join || priv->flags & DSA_FLAG_OFFLOADING_DISABLED)
 			return -EOPNOTSUPP;
 
 		err = ds->ops->port_bridge_join(ds, info->dp->index,
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 016884bead3c..846af7ed819b 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -33,6 +33,8 @@ struct dsa_user_priv {
 
 	/* TC context */
 	struct list_head	mall_tc_list;
+
+	u32			flags;
 };
 
 void dsa_user_mii_bus_init(struct dsa_switch *ds);
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 8516c1ccd57a..0982b309b09c 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1970,6 +1970,7 @@ enum {
 	IFLA_DSA_CONDUIT,
 	/* Deprecated, use IFLA_DSA_CONDUIT instead */
 	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
+	IFLA_DSA_FLAGS,
 	__IFLA_DSA_MAX,
 };
 
-- 
2.34.1


