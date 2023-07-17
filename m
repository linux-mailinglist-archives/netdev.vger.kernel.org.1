Return-Path: <netdev+bounces-18239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83762755F4C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DE7281435
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98797A92D;
	Mon, 17 Jul 2023 09:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E39474
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:33:29 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF911BE
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:33:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668709767b1so2999115b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689586407; x=1692178407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/u80+EdvVEefTiJRJQTQb1DBYM+msReiCOPys+1qsOY=;
        b=EIDnh0qDUX3I/uyeHQT+yigdei0v/HVnUlmxKbX3+x64043MEW1NvYStijVW+GuPdd
         JZBz7kj7e02v+omH7qT9Vp6gbcWgsvEXzRkgnSEMEozYyB7yI4wWDojjlcOcNRKYyeJT
         D7Dbr6+fVwHUh3LB5VTdSgIMJYlfkhBPDsMbXno/FbY8z/XKy+8cE5nIDwXdAy5ixqK0
         i5iytPQkZ1qbp1+k+0Ncawjw7bkWheR1jOEeC0Ct1Wf/7l+UYmhIgyVUukqXizEEQXgU
         b85Xi9RLXHxMSRHBVAHuQbsh0SGgPBU5RkgybY6PVBmF+WoxYsPjCTYZ8QYkBuqTBrZN
         G8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586407; x=1692178407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/u80+EdvVEefTiJRJQTQb1DBYM+msReiCOPys+1qsOY=;
        b=UuIhvwbq0M/JoChnU5P2b16F2nKmEO384YWPGFBRf0USMdSZ0Xs13jselhHuuqudoS
         JSwd9VD/7fkNhSD/S4CsmC5jcBwMjsS2LKiL5HajYCS4WadCB43Fvt67BdHCES8XqZeW
         LZ/glIOj+22O3VC4zVxWZmYcspBjMymmJZAdcdCjk/YRyk2MKab8V6hXUwwFzxo+Kgjl
         oZ0aP0XNIY16O1X/+6YdHKEnIRSd7jJimkyUye6VomSiz59WNH7o9LmcmPx4JHWysesr
         hC1UkPHG49QTHy84vRHhJbs9D4FRvRckFkYLn83o+0Vbmp3QIPlvvICXdPP+sAYiUPjj
         Qh7A==
X-Gm-Message-State: ABy/qLZeDKMPTH8JewJUksFV5bN8++2KwakGb70qCbcIIzDe9v7NKTdl
	zXCkiTYyncdeNm4eV8ohFhjPbw1awVdV2Q==
X-Google-Smtp-Source: APBJJlHg/iwioXRoQ2fg/uKyqxFjepg2eCxWGpZmp7Tgmu9Oft7RT6c9gnI+rhGtVX/PPim58qBoew==
X-Received: by 2002:a05:6a20:3ca0:b0:134:80b3:896 with SMTP id b32-20020a056a203ca000b0013480b30896mr4823548pzj.17.1689586406616;
        Mon, 17 Jul 2023 02:33:26 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a10-20020a62bd0a000000b00682ad3613eesm11569890pff.51.2023.07.17.02.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:33:25 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: [PATCH net-next] IPv6: add extack info for inet6_addr_add/del
Date: Mon, 17 Jul 2023 17:33:16 +0800
Message-Id: <20230717093316.2428813-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add extack info for inet6_addr_add(), ipv6_add_addr() and
inet6_addr_del(), which would be useful for users to understand the
problem without having to read kernel code.

Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/addrconf.c | 66 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5213e598a04..199de4b37f24 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1066,15 +1066,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
 	    (!(idev->dev->flags & IFF_LOOPBACK) &&
 	     !netif_is_l3_master(idev->dev) &&
-	     addr_type & IPV6_ADDR_LOOPBACK))
+	     addr_type & IPV6_ADDR_LOOPBACK)) {
+		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
 		return ERR_PTR(-EADDRNOTAVAIL);
+	}
 
 	if (idev->dead) {
-		err = -ENODEV;			/*XXX*/
+		NL_SET_ERR_MSG(extack, "No such device");
+		err = -ENODEV;
 		goto out;
 	}
 
 	if (idev->cnf.disable_ipv6) {
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		err = -EACCES;
 		goto out;
 	}
@@ -1097,12 +1101,14 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	ifa = kzalloc(sizeof(*ifa), gfp_flags | __GFP_ACCOUNT);
 	if (!ifa) {
+		NL_SET_ERR_MSG(extack, "No buffer space available");
 		err = -ENOBUFS;
 		goto out;
 	}
 
 	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
 	if (IS_ERR(f6i)) {
+		NL_SET_ERR_MSG(extack, "Dest allocate failed");
 		err = PTR_ERR(f6i);
 		f6i = NULL;
 		goto out;
@@ -1142,6 +1148,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	err = ipv6_add_addr_hash(idev->dev, ifa);
 	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "IPv6 address add failed");
 		rcu_read_unlock();
 		goto out;
 	}
@@ -2488,18 +2495,22 @@ static void addrconf_add_mroute(struct net_device *dev)
 	ip6_route_add(&cfg, GFP_KERNEL, NULL);
 }
 
-static struct inet6_dev *addrconf_add_dev(struct net_device *dev)
+static struct inet6_dev *addrconf_add_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	struct inet6_dev *idev;
 
 	ASSERT_RTNL();
 
 	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev))
+	if (IS_ERR(idev)) {
+		NL_SET_ERR_MSG(extack, "No such device");
 		return idev;
+	}
 
-	if (idev->cnf.disable_ipv6)
+	if (idev->cnf.disable_ipv6) {
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		return ERR_PTR(-EACCES);
+	}
 
 	/* Add default multicast route */
 	if (!(dev->flags & IFF_LOOPBACK) && !netif_is_l3_master(dev))
@@ -2919,21 +2930,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
 
 	ASSERT_RTNL();
 
-	if (cfg->plen > 128)
+	if (cfg->plen > 128) {
+		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");
 		return -EINVAL;
+	}
 
 	/* check the lifetime */
-	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft)
+	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft) {
+		NL_SET_ERR_MSG(extack, "IPv6 address lifetime invalid");
 		return -EINVAL;
+	}
 
-	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64)
+	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64) {
+		NL_SET_ERR_MSG(extack, "IPv6 address with mngtmpaddr flag must have prefix length 64");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
-	idev = addrconf_add_dev(dev);
+	idev = addrconf_add_dev(dev, extack);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
@@ -2941,8 +2960,10 @@ static int inet6_addr_add(struct net *net, int ifindex,
 		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
 					 true, cfg->pfx, ifindex);
 
-		if (ret < 0)
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Multicast auto join failed");
 			return ret;
+		}
 	}
 
 	cfg->scope = ipv6_addr_scope(cfg->pfx);
@@ -2999,22 +3020,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
 }
 
 static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
-			  const struct in6_addr *pfx, unsigned int plen)
+			  const struct in6_addr *pfx, unsigned int plen,
+			  struct netlink_ext_ack *extack)
 {
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
 	struct net_device *dev;
 
-	if (plen > 128)
+	if (plen > 128) {
+		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
 	idev = __in6_dev_get(dev);
-	if (!idev)
+	if (!idev) {
+		NL_SET_ERR_MSG(extack, "No such address on the device");
 		return -ENXIO;
+	}
 
 	read_lock_bh(&idev->lock);
 	list_for_each_entry(ifp, &idev->addr_list, if_list) {
@@ -3037,6 +3065,8 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 		}
 	}
 	read_unlock_bh(&idev->lock);
+
+	NL_SET_ERR_MSG(extack, "IPv6 address not found");
 	return -EADDRNOTAVAIL;
 }
 
@@ -3079,7 +3109,7 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_lock();
 	err = inet6_addr_del(net, ireq.ifr6_ifindex, 0, &ireq.ifr6_addr,
-			     ireq.ifr6_prefixlen);
+			     ireq.ifr6_prefixlen, NULL);
 	rtnl_unlock();
 	return err;
 }
@@ -3378,7 +3408,7 @@ static void addrconf_dev_config(struct net_device *dev)
 		return;
 	}
 
-	idev = addrconf_add_dev(dev);
+	idev = addrconf_add_dev(dev, NULL);
 	if (IS_ERR(idev))
 		return;
 
@@ -4692,7 +4722,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifa_flags &= IFA_F_MANAGETEMPADDR;
 
 	return inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
-			      ifm->ifa_prefixlen);
+			      ifm->ifa_prefixlen, extack);
 }
 
 static int modify_prefix_route(struct inet6_ifaddr *ifp,
-- 
2.38.1


