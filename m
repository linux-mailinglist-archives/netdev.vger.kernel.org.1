Return-Path: <netdev+bounces-177623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5CA70C0A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7515C7A7071
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5A2698BE;
	Tue, 25 Mar 2025 21:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BF267B9D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938264; cv=none; b=dps3DXMuDfzXFY3vJw/uZnxU+7YVkkeGqVaF08yuOaYyzUVbnmsUKtTBLEbjZRvmYr/0ek196XJudE4qgEy0IcHDI74PqwEaT9M0zDjVhTkfN/P3MEXUJWpNLm9a8STd+d8QWfaYYUjUzvA7xZTQ6zBDifWo7aWAy7CLmPdjptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938264; c=relaxed/simple;
	bh=1i0zmyNtMUhAKyD1bOggzZ5GfnWc/xFKCOrXOfl2ao0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzQ0AVr+SRicQHZKSyYqe2WFmaQAQJNHy5cIl+4BdVLAcVp7pbp5kLqMKHWHhkWdDjhAo0L6YfEM3dgLpv/Xs5iT3B7apqLqLVTVSwve18HzU20HqQOCHiDmKrRNucvjR0N3aP/0vHjNokMO1vWslHGALcdyFEyCeT5DIal3NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22438c356c8so126233045ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938262; x=1743543062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1FwfdhYfIumAe5mcpaiBwsps/nbgCpH3Gm/8KLhBBc=;
        b=oMdgp2slZMjxuNCTH+HfPObrldfBohAdjydTLY/XCBEwNikrC+gLybIICoIMxKMe1a
         ArRIkCv2JVVMMjXtS9Yx5ZhJNdbREc7LFj7OrcuNJ72jvdVW6CWwBJk/AruBDSCMOLxl
         v3KjTskx28Lj8TMY5Cbrs8TOSAIHGX1OMMMuPZMssyzZrSmpQVVJvb9cFS3xp49TmePS
         hkIhw739yZHoAr+pwtVInMpUVNn6PnNlHqCy5axd9kt96VczRKzyUOkxPBS1CpeSU4+i
         rypkPLgJrfFNb0NTjlk443D0qeDonFwaaI5eTg6k7U2ICl8kN82FR1w8gQ1Tx9EamUqA
         KOvg==
X-Gm-Message-State: AOJu0YyQnVrzS7czaEovSm6qOvZOKLyV5WILKwhuqqiVAaQmpQgIhBc1
	EE+gfoDly6lI34vYEinm/iFeJBAaSFc5yEsIc3pj+S7MK5Fe8m493LtR+pr1nA==
X-Gm-Gg: ASbGncuzIGrsywuLbYyp44G5YBe38oHm8u47F3jxHLEBXbX6yzptLEi9GVqgoqxaPmS
	8+Rbu7UQrBWtLsLDrodnQuuuiCNeQM162kMBML3TpsaUT18kW9RTTAzJHaFQe8tjIa+IyeuFVtJ
	BTA5Mq72/u9SziTmATW2559iCrtS0NPsA2tUEa9AU2KfO/pq9LWtXZx0HV/IKXtEi+mzJy6kofw
	k/kv4ZuOTfLxOqgGx/uWku22DRHd4wL2VmWrj8rde++dmbWlrDMUqeZqx87/2bQbyrwP9iqV+Xr
	RPPNibcfOQD7FXSftUTne4mlKAqacCdjpHu28wWplUjk
X-Google-Smtp-Source: AGHT+IEt7+vGxDfOI1I34fPHYDHi7JB84IYxolT3rUnfX1XV8SxCrkuV3A8VgZhYTbZKWaP9S3mmCQ==
X-Received: by 2002:a17:90a:e70d:b0:2ff:5ed8:83d0 with SMTP id 98e67ed59e1d1-3030fe94191mr33755400a91.16.1742938261920;
        Tue, 25 Mar 2025 14:31:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301bf576d1csm14904123a91.8.2025.03.25.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:01 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 3/9] net: use netif_disable_lro in ipv6_add_dev
Date: Tue, 25 Mar 2025 14:30:50 -0700
Message-ID: <20250325213056.332902-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
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
 net/core/dev.h            |  1 -
 net/ipv6/addrconf.c       | 17 +++++++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

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


