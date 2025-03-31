Return-Path: <netdev+bounces-178339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE2FA76B06
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A8A3B7402
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA1721C18C;
	Mon, 31 Mar 2025 15:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64CEEAA
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433572; cv=none; b=hhbjgxawnsOupjcAu+e9qhH8lgpEdfVOXQ+g0hD2fLmQZnW8qbBenSyJLiDCqZ0aawS0bFRfkW0vnIe/mVmbn0MYwKixXK9rM9RUv7g6dYNIEuWw7o603ddp+/RM4Rh+JX9M25wArjpEMvTvv+0rEfUqLlBNdCrgWQS+qqdGskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433572; c=relaxed/simple;
	bh=PUDFvO2TDnkW7uD9u6/ySNuFohxkZio2Ts3ESQWNvyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhrFf8exZ5AHB/ocrTdU8SYx+2pw0Y2mrwY8X0vFT+Extw6p0VSedU4XYXb98wF45bE6hy3aTYJNbEzcSXFfMnSVSMNYTk5FXc46BV/q0SWcFfcETCi2jKJeUMgdQXdIUXFMr1x/G/rULtUfQ04toYV9/T1KG/OpeHkPsgTCl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso61168535ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433570; x=1744038370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgqTnfYSYprKLWkrSOtNcWuBgAHtTnXeKE0pF1k7IRA=;
        b=HDvmZmhPzWGmixBVCEdU4GoKbi2GzBS52X/usV/CAEFm7xCX5xT307yEcnminJZyO7
         fJqiBdEOXrYU5nJFJmJ7Yau6C3P/JY/wAiyLRFBmqdGUv3XmoWTOYMklJJycScFDZBfW
         IPM1Kvh+Wa28dhvPUAppLHhQ2AnhicyoY4tUEEpXJFeIWe3afmDCmJltY065Y3mhFBjP
         54U6e3hUlhpS4I6MozOImw47ZmWVgYIlAFHPQfcx9T1MAJSAxd9GG3XXCLvajlli/otk
         O0LzyYyPBWuaBvjKWy/5fIXixACMiFxNYxH+InN0V6gMs0KoG7ZHFz7N2yzp4J7bfxll
         GlNQ==
X-Gm-Message-State: AOJu0YwduURbQ+4ux5roec5GO7STueBbm5loeeRudCZA6eOFa4WbRu31
	J6EzOl6TlG5yXOz/212s8i+m7SyYRUEd8zuEbDnyBj57V5ciDN8vxFB7
X-Gm-Gg: ASbGnct5ruZKVVbA44jcE4eOG5wLaieXU4/kz68c9e2Ub31e4PapcgLbbIaScSa0PRJ
	O2QxjGGaTv/cBUqwH9t3e7zPdeGi/1gA1/Nz5hVxB0YHy1qUMhFC3TUyni0CUqe76GGdsYgObuo
	8B1PMuBR9Ork3uES29AzVplCBglDpUuVYIZ8wPF1rUaL+G7MoVDZr3zzVqRSBRcsuesxTbKO6jj
	6E7ndUXzIyC59pzYgG6QkU/i/XPuX+pu1Ss+re59Fb8XrEsJ3tpvS0zN5C8sFYv2yNGn3x27IZI
	O3urkymXBkkQwaO0Q02+6/QbxR9KLQSTefrtU3xRTuwG4owgc4MaBiw=
X-Google-Smtp-Source: AGHT+IHyWcHa/+FMladYFRnlo0vn2JlvmpjBqcFRLoLcn+p/5kMrIlyGicuZH///kOWrJk/chxXoWw==
X-Received: by 2002:a17:902:da83:b0:21f:f3d:d533 with SMTP id d9443c01a7336-2292f94240fmr144041025ad.2.1743433569596;
        Mon, 31 Mar 2025 08:06:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-229362f09casm44112645ad.93.2025.03.31.08.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v4 03/11] net: use netif_disable_lro in ipv6_add_dev
Date: Mon, 31 Mar 2025 08:05:55 -0700
Message-ID: <20250331150603.1906635-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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


