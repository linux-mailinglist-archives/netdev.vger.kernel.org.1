Return-Path: <netdev+bounces-177957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FCEA733AB
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D40B3B928E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EC216E30;
	Thu, 27 Mar 2025 13:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA712163B6
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083827; cv=none; b=R31BkYV3y9L0RxWpViilOHlBVfyUzj4dAWCXl8Rwb+bidnRyvosVlHolS5Za9ygp1kC4mSQQ3CGKNuWXFTsSnWeq/8/nrvi93XSeMdMGZL9qvhbHPjjAhZ4izZGe/usLjwG9hHzDdqxrRYK0kv32eeuKjKGOzFMjajVGzH6ruLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083827; c=relaxed/simple;
	bh=0B8gE5WxJ2eK5JUTJQLSFNicfC7EMq7CXfO9wLvrYqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abC33ix6TGnV9X+1B8i1rvAGkXmJRO+t4D2AI9di63VaASabXTZfX6uPO+Dax+R6YFk2NqnwBpbli4mSBSMvSSnhykUAzh0w4FuepCMA29OtEuskuBwrqXQ60BifINLnYBiMi7Xu2QhFYKhzi9MH9DiDyMYwj6fxsIWFUtIrDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so19876435ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083825; x=1743688625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHS6fZkp/GtrmnJnMfY3SsVjRf/F72aaiS8iWCsHSUA=;
        b=ezkQtAsHZLrHAUrmvRrzuNt+jjyxVncR70TNy69q1tLVDwYi+F+GuXRwjEX1BJ1iaF
         nlcMIXlwvE0ORnxpB3VVVmPG5I51AuYpQlkb/6WUsfhyqf8n6vZKZOp67dK6HCRnGZpf
         K1eSn+d3F4f4RXLQThS82IAKSinkKBqK6EIGoVbDoay/kyl1UY/aE+PYu68PeoxNeyLU
         hkhe8GdZOPSlORewa/pwu1XK6GCfxanHVIvqL3oFiKkxL9lUiMBvoE3knKAERAQKjmK3
         ZMtiI9N3zr8SuDVJS/oj/KPPwCW60jP3M8XSPNrOPW4GXwiDlAuoqbESRcnrlZRw/Xls
         tncQ==
X-Gm-Message-State: AOJu0YyGR/5gFh6mJTszG4W1PMYUESHV85NppnHKenz8gWejmygddedC
	0X4sCOiVOQueq2HUKbk01GcvVIaEBz/WT8V5saAN2nUfYx3B1mYjkIiTBsX+gQ==
X-Gm-Gg: ASbGnctNuEkMaY7gEt1XW3gD+cERSMhDczC2KgfaoQIi5O6SpSdiwQwGHvOdThnFYMh
	T0+6XsLQwqt6JEBNIj9CAKeTacJCeEktrn4r0NoQVrtgYyx60lAXqOISP5A9DUrMYXZFVX2j2yR
	Ay033T0/qWuaZBbpwB59Oe5arAr3MJkWBqBNYs7PNLpVeSCqYTvcV30FMAWloh+Q04ZDFjJCXL5
	fvO6O4WiH8tBmILFbmDkS8wCMia+jepJdgHjqHA+ycSz6cB/vhLJJqr4HO13tzYKVy9wu7TKdc6
	UQXrNNaJMsbybaJcXhAhM3ok9+VyNXqXfGsVjvXaqNri
X-Google-Smtp-Source: AGHT+IEI+KhOkmMLJDfTKu6L7nu19EgXloYBTTqCAplhEmNsvWTRxFN7xLYxYzmp1vbYxqEp6clt4A==
X-Received: by 2002:a17:903:2f85:b0:220:d601:a704 with SMTP id d9443c01a7336-22804858faamr36300475ad.18.1743083824798;
        Thu, 27 Mar 2025 06:57:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f45e9esm128666965ad.88.2025.03.27.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:04 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v2 03/11] net: use netif_disable_lro in ipv6_add_dev
Date: Thu, 27 Mar 2025 06:56:51 -0700
Message-ID: <20250327135659.2057487-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
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
 include/linux/netdevice.h |  1 +
 net/core/dev.c            |  1 +
 net/core/dev.h            |  1 -
 net/ipv6/addrconf.c       | 17 +++++++++++++----
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fa79145518d1..b2b4e31806d5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3386,6 +3386,7 @@ struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
 				       netdevice_tracker *tracker, gfp_t gfp);
+struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index 019f838f94d8..bb4a135b1569 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1072,6 +1072,7 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 
 	return __netdev_put_lock(dev);
 }
+EXPORT_SYMBOL(netdev_get_by_index_lock);
 
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
diff --git a/net/core/dev.h b/net/core/dev.h
index 7ee203395d8e..8d35860f2e89 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -28,7 +28,6 @@ struct napi_struct *
 netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
-struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *__netdev_put_lock(struct net_device *dev);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc1076536..665184d2adce 100644
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
 
@@ -3151,11 +3153,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 	cfg.plen = ireq.ifr6_prefixlen;
 
 	rtnl_net_lock(net);
-	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
+	dev = netdev_get_by_index_lock(net, ireq.ifr6_ifindex);
 	if (dev)
 		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
 	else
 		err = -ENODEV;
+	netdev_unlock(dev);
 	rtnl_net_unlock(net);
 	return err;
 }
@@ -5022,11 +5025,11 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	rtnl_net_lock(net);
 
-	dev =  __dev_get_by_index(net, ifm->ifa_index);
+	dev = netdev_get_by_index_lock(net, ifm->ifa_index);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
 		err = -ENODEV;
-		goto unlock;
+		goto unlock_rtnl;
 	}
 
 	idev = ipv6_find_idev(dev);
@@ -5065,6 +5068,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	in6_ifa_put(ifa);
 unlock:
+	netdev_unlock(dev);
+unlock_rtnl:
 	rtnl_net_unlock(net);
 
 	return err;
@@ -6503,7 +6508,9 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 
 			if (idev->cnf.addr_gen_mode != new_val) {
 				WRITE_ONCE(idev->cnf.addr_gen_mode, new_val);
+				netdev_lock_ops(idev->dev);
 				addrconf_init_auto_addrs(idev->dev);
+				netdev_unlock_ops(idev->dev);
 			}
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
@@ -6515,7 +6522,9 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
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


