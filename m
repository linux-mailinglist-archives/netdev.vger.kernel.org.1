Return-Path: <netdev+bounces-178200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A6A75786
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625593AAB6A
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DAD1DF259;
	Sat, 29 Mar 2025 18:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B821B3927
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274633; cv=none; b=Ofgrz+6ETZHquc1yDR+QBzGVyfYSUbN2ByucOsXNZenDI6ddm0qAgo+W0TcIu1HnNKZSdfrZ5czPll3r4IuN05tdi3u/ZbcQIbQ/UgHos5ngKn4sxKEDBCtiGbsvsDGzGA934VtPsiFG0tD7r76aiVIzU805lbJl02M7+TUqr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274633; c=relaxed/simple;
	bh=PUDFvO2TDnkW7uD9u6/ySNuFohxkZio2Ts3ESQWNvyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASS2gzgmLmxXZ5J/JRd0DfrJL6W5Li9F5sTkxywSg9E3CwnQ68kFzFhRhbh4QbzyA/6JtJ4Jm8ieudAux6llXBNPcrARiN702j19U5KX+xLI3NHrvS0AjnE1SfgkUZE0L6jodYv6Mb8E0dKMzHTRhpLv55EFTV7TNba3KZqbry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30362ee1312so5813566a91.0
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274631; x=1743879431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgqTnfYSYprKLWkrSOtNcWuBgAHtTnXeKE0pF1k7IRA=;
        b=MeAneeWLK210Jk2D/zj+GemYQEW7M6PeUV706GbDbwN5S5SzJTs7nlXWOMmSYb+Df6
         Eq4dSnoYY2sSfdNiiL10etOez5zk+l8jlySMnhk1t/9FB7mpn1ZskIatIX6xzlwUyqyG
         QCqFo9aH4pDhAO217kkYQOE30BAI7Ddl5XYXuxwtr5DtAp+zqKBR5RqoVhG8EOr+/NA+
         GCAI6VpzqINgxQCqV2146UwGc368ZSxW4xiFxzTrxBu4pscrdI5/ru9FkQPmhV6k1RI+
         Q69Z2WzrY83RL4jl8o+shK4SChmMxjhKD+BFZLRDOIThGxHCfr8f/d2xp/TX30oF3iBT
         2W+w==
X-Gm-Message-State: AOJu0Yx349V4Ae+b/ka9/JBRD1StNQO6kMugANLzwpeNnXyq0BBz1aX8
	yajlcYoCHMAL1sSBdvhQmce2OwWyh+0UW9HibpZ9Uzg/JwNzUw4hlEOq6Bo=
X-Gm-Gg: ASbGncu+mkmNYMJBRr+PByRgn1SOTro/uzEbLbVHW7ZVJIBu2h1j3878kuGZ3GCYsgX
	TrosF58y+zTdkPsU6WtahBxg9xfserEFEKWosF3YfNYPooxy1v94TpketMh6dEWVgIjrEE+kdW5
	ZlZoYNoRll/iTIlfd65/FxBiS9tS1F+qTN6PKZhCMYt2secAp/9HQkjRwDgHhJv+CgYmpjld/VI
	7zQ80uYeh0zsEcLtB1Unldjgh3meWHjM2wFYVxzA/VDGDr3scMXfmx5c206ME+xsq6Rrt36+lhh
	nKbXjrsOX9aTE5GIDWpKOL+h+xKlWvkBS6RwcYxhlad+
X-Google-Smtp-Source: AGHT+IFdg78/UZ3eGa3AGKsKNu7HJq3iko+QuztIcaSebD4AfFQ8HO9FxsoS4817XSA1XcOtwf4mjQ==
X-Received: by 2002:a17:90b:3c07:b0:2ff:53ad:a0ec with SMTP id 98e67ed59e1d1-305320b1fcdmr5406509a91.21.1743274630667;
        Sat, 29 Mar 2025 11:57:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d3e640sm4112057a91.10.2025.03.29.11.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:10 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v3 03/11] net: use netif_disable_lro in ipv6_add_dev
Date: Sat, 29 Mar 2025 11:56:56 -0700
Message-ID: <20250329185704.676589-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_add_dev might call dev_disable_lro which unconditionally grabs
instance lock, so it will deadlock during NETDEV_REGISTER. Switch
to netif_disable_lro.

Make sure all callers hold the instance lock as well.

Cc: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv6/addrconf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc1076536..35477d494573 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -80,6 +80,7 @@
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/l3mdev.h>
+#include <net/netdev_lock.h>
 #include <linux/if_tunnel.h>
 #include <linux/rtnetlink.h>
 #include <linux/netconf.h>
@@ -377,6 +378,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	int err = -ENOMEM;
 
 	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	if (dev->mtu < IPV6_MIN_MTU && dev != blackhole_netdev)
 		return ERR_PTR(-EINVAL);
@@ -402,7 +404,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 		return ERR_PTR(err);
 	}
 	if (ndev->cnf.forwarding)
-		dev_disable_lro(dev);
+		netif_disable_lro(dev);
 	/* We refer to the device */
 	netdev_hold(dev, &ndev->dev_tracker, GFP_KERNEL);
 
@@ -3152,10 +3154,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
+	netdev_lock_ops(dev);
 	if (dev)
 		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
 	else
 		err = -ENODEV;
+	netdev_unlock_ops(dev);
 	rtnl_net_unlock(net);
 	return err;
 }
@@ -5026,9 +5030,10 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
 		err = -ENODEV;
-		goto unlock;
+		goto unlock_rtnl;
 	}
 
+	netdev_lock_ops(dev);
 	idev = ipv6_find_idev(dev);
 	if (IS_ERR(idev)) {
 		err = PTR_ERR(idev);
@@ -5065,6 +5070,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	in6_ifa_put(ifa);
 unlock:
+	netdev_unlock_ops(dev);
+unlock_rtnl:
 	rtnl_net_unlock(net);
 
 	return err;
@@ -6503,7 +6510,9 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 
 			if (idev->cnf.addr_gen_mode != new_val) {
 				WRITE_ONCE(idev->cnf.addr_gen_mode, new_val);
+				netdev_lock_ops(idev->dev);
 				addrconf_init_auto_addrs(idev->dev);
+				netdev_unlock_ops(idev->dev);
 			}
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
@@ -6515,7 +6524,9 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 				    idev->cnf.addr_gen_mode != new_val) {
 					WRITE_ONCE(idev->cnf.addr_gen_mode,
 						  new_val);
+					netdev_lock_ops(idev->dev);
 					addrconf_init_auto_addrs(idev->dev);
+					netdev_unlock_ops(idev->dev);
 				}
 			}
 		}
-- 
2.48.1


