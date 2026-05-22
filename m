Return-Path: <netdev+bounces-290898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bo1LX+VEGqBZwYAu9opvQ
	(envelope-from <netdev+bounces-290898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:42:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A45B86FF
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55CDD3091B04
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD483655F1;
	Fri, 22 May 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maCgFLOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382173624D7
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471011; cv=none; b=SSRebin6mDb6BCAj3AGT/psnE61qwqbVDNCyvocjxN6XC6JzNyyVFpCx2hPv4muUZWrxeybERSszIUdTgUwuM6Qw9mXySVkWKhq9LP713z+pM0gec2e6buZCpQSJPy/868F2lF1zTg6z2JiGhtO3mn7Nwvv2iKfQm3b6ueArgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471011; c=relaxed/simple;
	bh=BxF9v5+ffFqoUpnieZXSb+2HdA1RPnoIhVyTsHQsmNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEG9gp1ocj8ucvrNHJnNRPcx8D5gh8W4M++Rve9eu7yfI8ZpTQZsiJRHf4C9lneKdTvptRjaETIhvC1E1E/UisPPaFgRiWxKZ+2S3xoyV8pQiU0N9+PyHykEl8CUZy/xPhyJk5p0tINYy3QeUIgZL3nvPQwfmfTID+712F0rKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maCgFLOj; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-516458449d4so120950131cf.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471009; x=1780075809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgYbFHQVjVdfgkcjxtpt6q/JNpqCA1bsfuWHSIx92OA=;
        b=maCgFLOjiPXQP0b7/n/KrZlr5CAuH2ubsLZ/98k9e7aM7f2fqcjKLX8hYqlgTTvnB4
         7vdsVt44QDuLBgBFg1hB8PhFg1f3EupnB133lbxl/eGUiM21Boe7jeMU+OlTT/kXIOj5
         2bZzV7gAvfbLE3H+YW09PIFwJbhojGBbXIcPmAc+pcnavp8QwuheSBVJvvle/7oHI/jX
         AhwQQbHoPNyDzhfVtm+1nJKcWrPXkSEggZh8sVAyEYFVywrPCwvEb1q0qWK5E0QwFc9B
         HTjfZ/LLqD20KIR8Z6l8Q65a9mJshCFgJhwd/KR+Z2Sd209MnSEB4Hu/GcjuCCwUEjGx
         4VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471009; x=1780075809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgYbFHQVjVdfgkcjxtpt6q/JNpqCA1bsfuWHSIx92OA=;
        b=kqoBnyPtK6fjjw3NlOBQGZI4oIrUPUANZY09OzScCOVTbxmtKY7FaE1SURVNPJyLlF
         mQrH0VHQNNS7iP8oD4P59VomoiRnlxsGRjhZaxNrYcLnZ5GAo6dImLbqZpVo/SQXL/LU
         ZySJeUQIxYvwF7tbZdfPQHgKrt+CQ6+ayfoF2aw61SPjv5ptdziwC44Xde0cg68hdSbl
         uEKuNBUkNU2ueElJ96gh8LwHWyexR/kVLPdGiTc93u9hns9B0Z/3I64O5XXf/mi2a25t
         PxUljRyTqfsZHMzqrFff82KximjL3Cs+sKp+tysoMRQbdROQ0OoqsczgURGRM1ZsX47A
         f/0g==
X-Forwarded-Encrypted: i=1; AFNElJ9S8ZfGAMAGb2LHZO45eKuuTujdyAc9lSvSdcsyPVCYaW4Ou/k8DmEASKS9Gg6vXkPUwF07opM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPxVKWFZdnps/Mn66YncGdxgkNXX42C0DhhEwm5NRRobRXDzB
	O94492zYHyG9d53Rtws1giwvcpIMOKcAivGnR15eRpYtKSs6fYeF8yCAhTOMZlRV3aZKwUbUMYJ
	3FVVzrQew2wCJmw==
X-Received: from qtaw16.prod.google.com ([2002:ac8:57d0:0:b0:50d:e722:4fa7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7152:0:b0:50f:c2f8:4075 with SMTP id d75a77b69052e-516d4428a0emr46944051cf.1.1779471009014;
 Fri, 22 May 2026 10:30:09 -0700 (PDT)
Date: Fri, 22 May 2026 17:30:00 +0000
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173002.2181677-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522173002.2181677-4-edumazet@google.com>
Subject: [PATCH v4 net-next 3/5] rtnetlink: do not acquire RTNL in
 rtnl_getlink() with RTEXT_FILTER_NAME_ONLY
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C8A45B86FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When RTEXT_FILTER_NAME_ONLY is requested, rtnl_fill_ifinfo()
is dumping device attributes which do not need RTNL protection.

Many shell scripts invoke iproute2 commands specifying a device by
its name. After this patch, they will no longer add RTNL pressure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 94 +++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3dfa28927c7f92f906a0d89b7a1812b975d13854..c342b22528e4478a61f22e204a3934ba1a48cb3c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2068,7 +2068,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	struct nlmsghdr *nlh;
 	struct Qdisc *qdisc;
 
-	ASSERT_RTNL();
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*ifm), flags);
 	if (nlh == NULL)
 		return -EMSGSIZE;
@@ -2091,6 +2090,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (ext_filter_mask & RTEXT_FILTER_NAME_ONLY)
 		goto end;
 
+	ASSERT_RTNL();
 	if (tgt_netnsid >= 0 &&
 	    nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
 		goto nla_put_failure;
@@ -3468,6 +3468,21 @@ static struct net_device *rtnl_dev_get(struct net *net,
 	return __dev_get_by_name(net, ifname);
 }
 
+static struct net_device *rtnl_dev_get_rcu(struct net *net,
+					   struct nlattr *tb[])
+{
+	char ifname[ALTIFNAMSIZ];
+
+	if (tb[IFLA_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	else if (tb[IFLA_ALT_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_ALT_IFNAME], ALTIFNAMSIZ);
+	else
+		return NULL;
+
+	return dev_get_by_name_rcu(net, ifname);
+}
+
 static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
@@ -4187,14 +4202,16 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[IFLA_MAX + 1];
+	netdevice_tracker dev_tracker;
+	struct net_device *dev = NULL;
 	struct net *tgt_net = net;
+	u32 ext_filter_mask = 0;
 	struct ifinfomsg *ifm;
-	struct nlattr *tb[IFLA_MAX+1];
-	struct net_device *dev = NULL;
 	struct sk_buff *nskb;
 	int netnsid = -1;
+	bool need_rtnl;
 	int err;
-	u32 ext_filter_mask = 0;
 
 	err = rtnl_valid_getlink_req(skb, nlh, tb, extack);
 	if (err < 0)
@@ -4214,43 +4231,65 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[IFLA_EXT_MASK])
 		ext_filter_mask = nla_get_u32(tb[IFLA_EXT_MASK]);
 
-	err = -EINVAL;
 	ifm = nlmsg_data(nlh);
-	if (ifm->ifi_index > 0)
-		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
-	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(tgt_net, tb);
-	else
+	rcu_read_lock();
+	if (ifm->ifi_index > 0) {
+		dev = dev_get_by_index_rcu(tgt_net, ifm->ifi_index);
+	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
+		dev = rtnl_dev_get_rcu(tgt_net, tb);
+	} else {
+		rcu_read_unlock();
+		err = -EINVAL;
 		goto out;
+	}
+	netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
+	rcu_read_unlock();
 
 	err = -ENODEV;
 	if (dev == NULL)
 		goto out;
 
+	need_rtnl = !(ext_filter_mask & RTEXT_FILTER_NAME_ONLY);
+
+retry:
+	if (need_rtnl) {
+		rtnl_lock();
+		/* Synchronize the carrier state so we don't report a state
+		 * that we're not actually going to honour immediately; if
+		 * the driver just did a carrier off->on transition, we can
+		 * only TX if link watch work has run, but without this we'd
+		 * already report carrier on, even if it doesn't work yet.
+		 */
+		linkwatch_sync_dev(dev);
+	}
+
 	err = -ENOBUFS;
 	nskb = nlmsg_new_large(if_nlmsg_size(dev, ext_filter_mask));
-	if (nskb == NULL)
-		goto out;
+	if (nskb)
+		err = rtnl_fill_ifinfo(nskb, dev, net,
+				       RTM_NEWLINK, NETLINK_CB(skb).portid,
+				       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
+				       0, NULL, 0, netnsid, GFP_KERNEL);
 
-	/* Synchronize the carrier state so we don't report a state
-	 * that we're not actually going to honour immediately; if
-	 * the driver just did a carrier off->on transition, we can
-	 * only TX if link watch work has run, but without this we'd
-	 * already report carrier on, even if it doesn't work yet.
-	 */
-	linkwatch_sync_dev(dev);
+	if (need_rtnl)
+		rtnl_unlock();
 
-	err = rtnl_fill_ifinfo(nskb, dev, net,
-			       RTM_NEWLINK, NETLINK_CB(skb).portid,
-			       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
-			       0, NULL, 0, netnsid, GFP_KERNEL);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in if_nlmsg_size */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(nskb);
-	} else
+		if (err == -EMSGSIZE) {
+			if (!need_rtnl) {
+				/* Some altnames were added, retry with RTNL. */
+				need_rtnl = true;
+				goto retry;
+			}
+			/* -EMSGSIZE implies BUG in if_nlmsg_size */
+			WARN_ON_ONCE(1);
+		}
+	} else {
 		err = rtnl_unicast(nskb, net, NETLINK_CB(skb).portid);
+	}
 out:
+	netdev_put(dev, &dev_tracker);
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
@@ -7117,7 +7156,8 @@ static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst =
 	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink,
 	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
-	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+	 .dumpit = rtnl_dump_ifinfo,
+	 .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE | RTNL_FLAG_DOIT_UNLOCKED},
 	{.msgtype = RTM_SETLINK, .doit = rtnl_setlink,
 	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETADDR, .dumpit = rtnl_dump_all},
-- 
2.54.0.746.g67dd491aae-goog


