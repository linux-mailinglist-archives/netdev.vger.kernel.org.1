Return-Path: <netdev+bounces-20264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E7875ECC2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9CA28145F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 07:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368481863;
	Mon, 24 Jul 2023 07:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745915C6
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 07:51:01 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A61A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 00:50:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66767d628e2so2131843b3a.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690185058; x=1690789858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96g2JSCirMbJA/+oNaxtCM0yePpJ3cdzIwt24xckPZY=;
        b=RgpaRuj6XjMznYXNPa9TQl0XRFA0s9FgMDZ68veAt6G7QYLdt/V4xRr/zYrIQJ1dv5
         HgwbbZ/cKaeQlT4MBByCxOUaUKf1JOJt1DSoMy9yHo9bWPBel7r+szzN9M3brmEQWO/L
         oByR3VMdF1lJlwP1BEdi+E7wh1Cu/B3bN9iyDaMuXIZun732uhmTvsBpkfEEpv28fLm2
         0s1R5yXlyw3FKeo0QptAcddPxl9F4S5+Q7YMoBx71+oqvxvJZFQVdMXRUR6ETs/XR7ES
         9JuQZfofvpB9kotckLXeTWiAJe/v5Cuq4Y0s7dxvLccVMRaVnpjOVe8rqTePmdES/Vio
         UWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185058; x=1690789858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96g2JSCirMbJA/+oNaxtCM0yePpJ3cdzIwt24xckPZY=;
        b=YgEB08PiTCtuV8VArtnfgfM+Vj4DiIs6fyze4aaNxvTxVXc9AOhoPDHGabp57moZtB
         hbUY//ho1HiSM+ErXRi4zw36oMPBku+ggctVBrFZphGre2+kevA4UTMOtpgmYDZeNNky
         tH6GZ01WvdmiHECjFO6y0HnsN1QyIZD6Ssgh2K/6vTRcUyijPaAGOzwUxZJ3CvSdx1nE
         tiH9AARTPFv5e61TMIf/APaLLoLlP2l4YWNEEwTqsKJmQcrdZqLmPcj4+GmGdJajqnXT
         NrZL10QNkXiCv/LYIoVgaboL4SIStaEXzq6q+QSs1MQa1koE75tq3Q27vB/Ej/CtJmvq
         HERw==
X-Gm-Message-State: ABy/qLbe6SvjYGtezwBVF6l7gjA/mKIyFdOvOh3FRCaWQBDxRGMuI6OO
	/eB6OWbzmSDmeaTokp6b/u8/pfFxPDqcIVNR
X-Google-Smtp-Source: APBJJlFblnUHvPiJD67l26AN1OcipdftfYb6JxIEYRZizAoTtDFPk7XuRcMFgCAThYXx/uwYJnrXog==
X-Received: by 2002:a05:6a20:9388:b0:137:c811:3510 with SMTP id x8-20020a056a20938800b00137c8113510mr7679594pzh.44.1690185058277;
        Mon, 24 Jul 2023 00:50:58 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006702c433741sm7131712pfd.3.2023.07.24.00.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 00:50:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: [PATCHv3 net-next] IPv6: add extack info for IPv6 address add/delete
Date: Mon, 24 Jul 2023 15:50:51 +0800
Message-Id: <20230724075051.20081-1-liuhangbin@gmail.com>
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

Add extack info for IPv6 address add/delete, which would be useful for
users to understand the problem without having to read kernel code.

Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: * Update extack message. Pass extack to addrconf_f6i_alloc().
    * Return "IPv6 is disabled" for addrconf_add_dev(), as the same
      with ndisc_allow_add() does.
    * Set dup addr extack message in inet6_rtm_newaddr() instead of
      ipv6_add_addr_hash().
v2: Update extack msg for dead dev. Remove msg for NOBUFS error.
    Add extack for ipv6_add_addr_hash()
---
 include/net/ip6_route.h |  2 +-
 net/ipv6/addrconf.c     | 63 +++++++++++++++++++++++++++++------------
 net/ipv6/anycast.c      |  2 +-
 net/ipv6/route.c        |  5 ++--
 4 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 3556595ce59a..b32539bb0fb0 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -156,7 +156,7 @@ void fib6_force_start_gc(struct net *net);
 
 struct fib6_info *addrconf_f6i_alloc(struct net *net, struct inet6_dev *idev,
 				     const struct in6_addr *addr, bool anycast,
-				     gfp_t gfp_flags);
+				     gfp_t gfp_flags, struct netlink_ext_ack *extack);
 
 struct rt6_info *ip6_dst_alloc(struct net *net, struct net_device *dev,
 			       int flags);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 19eb4b3d26ea..53dea18a4a07 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1068,15 +1068,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
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
+		NL_SET_ERR_MSG(extack, "IPv6 device is going away");
+		err = -ENODEV;
 		goto out;
 	}
 
 	if (idev->cnf.disable_ipv6) {
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		err = -EACCES;
 		goto out;
 	}
@@ -1103,7 +1107,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 		goto out;
 	}
 
-	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
+	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags, extack);
 	if (IS_ERR(f6i)) {
 		err = PTR_ERR(f6i);
 		f6i = NULL;
@@ -2921,30 +2925,40 @@ static int inet6_addr_add(struct net *net, int ifindex,
 
 	ASSERT_RTNL();
 
-	if (cfg->plen > 128)
+	if (cfg->plen > 128) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
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
+		NL_SET_ERR_MSG(extack, "IPv6 address with \"mngtmpaddr\" flag must have a prefix length of 64");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
 	if (!dev)
 		return -ENODEV;
 
 	idev = addrconf_add_dev(dev);
-	if (IS_ERR(idev))
+	if (IS_ERR(idev)) {
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		return PTR_ERR(idev);
+	}
 
 	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
 		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
 					 true, cfg->pfx, ifindex);
 
-		if (ret < 0)
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Multicast auto join failed");
 			return ret;
+		}
 	}
 
 	cfg->scope = ipv6_addr_scope(cfg->pfx);
@@ -3001,22 +3015,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
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
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
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
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		return -ENXIO;
+	}
 
 	read_lock_bh(&idev->lock);
 	list_for_each_entry(ifp, &idev->addr_list, if_list) {
@@ -3039,6 +3060,8 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 		}
 	}
 	read_unlock_bh(&idev->lock);
+
+	NL_SET_ERR_MSG(extack, "IPv6 address not found");
 	return -EADDRNOTAVAIL;
 }
 
@@ -3081,7 +3104,7 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_lock();
 	err = inet6_addr_del(net, ireq.ifr6_ifindex, 0, &ireq.ifr6_addr,
-			     ireq.ifr6_prefixlen);
+			     ireq.ifr6_prefixlen, NULL);
 	rtnl_unlock();
 	return err;
 }
@@ -3484,7 +3507,7 @@ static int fixup_permanent_addr(struct net *net,
 		struct fib6_info *f6i, *prev;
 
 		f6i = addrconf_f6i_alloc(net, idev, &ifp->addr, false,
-					 GFP_ATOMIC);
+					 GFP_ATOMIC, NULL);
 		if (IS_ERR(f6i))
 			return PTR_ERR(f6i);
 
@@ -4694,7 +4717,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifa_flags &= IFA_F_MANAGETEMPADDR;
 
 	return inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
-			      ifm->ifa_prefixlen);
+			      ifm->ifa_prefixlen, extack);
 }
 
 static int modify_prefix_route(struct inet6_ifaddr *ifp,
@@ -4899,8 +4922,10 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	dev =  __dev_get_by_index(net, ifm->ifa_index);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
 	if (tb[IFA_FLAGS])
 		cfg.ifa_flags = nla_get_u32(tb[IFA_FLAGS]);
@@ -4935,10 +4960,12 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL ||
-	    !(nlh->nlmsg_flags & NLM_F_REPLACE))
+	    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
+		NL_SET_ERR_MSG(extack, "IPv6 address already assigned");
 		err = -EEXIST;
-	else
+	} else {
 		err = inet6_addr_modify(net, ifa, &cfg);
+	}
 
 	in6_ifa_put(ifa);
 
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index dacdea7fcb62..bb17f484ee2c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -305,7 +305,7 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 	}
 
 	net = dev_net(idev->dev);
-	f6i = addrconf_f6i_alloc(net, idev, addr, true, GFP_ATOMIC);
+	f6i = addrconf_f6i_alloc(net, idev, addr, true, GFP_ATOMIC, NULL);
 	if (IS_ERR(f6i)) {
 		err = PTR_ERR(f6i);
 		goto out;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..c90700aed3a1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4543,7 +4543,8 @@ static int ip6_pkt_prohibit_out(struct net *net, struct sock *sk, struct sk_buff
 struct fib6_info *addrconf_f6i_alloc(struct net *net,
 				     struct inet6_dev *idev,
 				     const struct in6_addr *addr,
-				     bool anycast, gfp_t gfp_flags)
+				     bool anycast, gfp_t gfp_flags,
+				     struct netlink_ext_ack *extack)
 {
 	struct fib6_config cfg = {
 		.fc_table = l3mdev_fib_table(idev->dev) ? : RT6_TABLE_LOCAL,
@@ -4565,7 +4566,7 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 		cfg.fc_flags |= RTF_LOCAL;
 	}
 
-	f6i = ip6_route_info_create(&cfg, gfp_flags, NULL);
+	f6i = ip6_route_info_create(&cfg, gfp_flags, extack);
 	if (!IS_ERR(f6i)) {
 		f6i->dst_nocount = true;
 
-- 
2.38.1


