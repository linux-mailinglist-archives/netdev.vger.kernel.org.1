Return-Path: <netdev+bounces-289421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOH3IG9NDGrjdQUAu9opvQ
	(envelope-from <netdev+bounces-289421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BC57DEFD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9768F303CD6F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F74A340B;
	Tue, 19 May 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJkXRWCi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF9331A6E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191042; cv=none; b=TZtBz45gy2v6vwZrR4Qqhba1iQPofEodzd+je6mHluei6Yg+YVukeSlBcPGS2YSQybw51VzzyK4cXruckwcqBhQkTcAxrCDpPtWKLDQrhI0CIFW8h730vuXSKRGCW6vYij5ZqAV1/TA4FUxtB6/XXElKj6M6J4Y+0MpZ9qBr39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191042; c=relaxed/simple;
	bh=FBz9tT367NOveFkgTXJIp3fcfL4+cF9VuG0RohZV40s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTlb0YhX9eiW9jxckphN1fhWasrLKlCy8ZzXPr/9ErMJciL0QKfbPHjVnu4mk9BH2PMSnL1z3tLsDoK2KkRR9U4i8ZOGJomKG78+H0w8at5NGczAX23JS6O8VRpBxmdCIAYTiW3keImwHAJUgm3DuUAe0PTqoKZDYLVNmic1GFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJkXRWCi; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca172588cso100576536d6.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779191040; x=1779795840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nthh0wOYkbgoOXenxGs1OlmA1njW0yrnzAWO8T7rE7o=;
        b=FJkXRWCiJBDPDU0YAxQ3lkoNNIiqGruSlgdnAF0H3RVbIQeJJYshWnYh3+3oOSJCMm
         4P2xVKrlcq9iqLICYycG6mDRtq+2cbeCnObmIVwa03m0zJEA+7fUXDRN5ms8kZN948V0
         hvk09yOo5tbtu9gktUeoqbJVuwTdGZ4CU10SxBCc0PPECbbwbLihVt9Ln8tGUNNtiubs
         kjufUIWgAtUxCvjKMke2XdJOdSJElPz/UIiCO7FmlfukowkZ2Qr65AU1emc8d9H2QRUP
         9ikYGO/RDtOSifX5RB3akUjL24lVhVl88ZyQEGweY5MR6WW/hitG7kgL1N+tLAc6x2EB
         b3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191040; x=1779795840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nthh0wOYkbgoOXenxGs1OlmA1njW0yrnzAWO8T7rE7o=;
        b=bsW9FeM6nVJrZ3J8nnDirYXkbReuOXmzjx8ny1JBrgf5qUtQKsAGCUADEoQgjgwwL/
         MrZP3heChscnEQm6DGnZtpVi1AQMmG4OpYMsqjdtzteyqy+3g0qK1RKd0fcovhCnNkKs
         eGAe5nn7GZOPKZmMKo+2Bpr86kQ6dcdQZl+YTdCjypmt27JtbmpUZkgogmX7l2LrzLLw
         aqE05dVYhodAwbDxDlLKk9sxnYTk8uO2xlVCkHgzaOCxwT0Z6+u2kTd39pWAgre0Kjem
         MD9LMkv0HIykmTBUhxW+1MswkFOV39atYK0eRfpNcnZutMzDjHdMoGe4LtOskj4mdwne
         g4vQ==
X-Forwarded-Encrypted: i=1; AFNElJ93ES1hwvinRVPbFPfQOs/VK9mRauEGk/spsdylZ7jUJrng3vfxBMtL/XrJsQMeCrkorOFbgig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGr62L+/dCSonj534MziMiGJvgRTHgkpvLbtcSiT9/+ifcgBjQ
	82t5Ze4Lz0K/KLPVTlDXubrlfZD5UJ70tOMutYVWYgBqG4id+iLFwnXmXdOkwgoM13PvTYYsR/U
	BaxKRqBmP2UEWiw==
X-Received: from qvcc10.prod.google.com ([2002:a05:6214:224a:b0:8b7:a795:d3f4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4b04:b0:8be:3da0:bba7 with SMTP id 6a1803df08f44-8ca0f671f23mr341421916d6.16.1779191039958;
 Tue, 19 May 2026 04:43:59 -0700 (PDT)
Date: Tue, 19 May 2026 11:43:55 +0000
In-Reply-To: <20260519114355.2769474-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519114355.2769474-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519114355.2769474-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/2] rtnetlink: do not acquire RTNL for
 RTM_GETLINK with RTEXT_FILTER_NAME_ONLY
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 652BC57DEFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When RTEXT_FILTER_NAME_ONLY is requested, rtnl_fill_ifinfo()
is dumping device attributes which do not need RTNL protection.

Many shell scripts invoke iproute2 commands specifying a device by
its name. After this patch, they will no longer add RTNL pressure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: move the ASSERT_RTNL() in rtnl_fill_ifinfo()

 net/core/rtnetlink.c | 72 ++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ae0254f19178735b2805a8189e81a960a49b2858..68cd2238ee170f44841caf47c86ef48303a3d15e 100644
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
@@ -4187,14 +4202,15 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 	int err;
-	u32 ext_filter_mask = 0;
 
 	err = rtnl_valid_getlink_req(skb, nlh, tb, extack);
 	if (err < 0)
@@ -4214,14 +4230,19 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -4232,25 +4253,35 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (nskb == NULL)
 		goto out;
 
-	/* Synchronize the carrier state so we don't report a state
-	 * that we're not actually going to honour immediately; if
-	 * the driver just did a carrier off->on transition, we can
-	 * only TX if link watch work has run, but without this we'd
-	 * already report carrier on, even if it doesn't work yet.
-	 */
-	linkwatch_sync_dev(dev);
+	if (!(ext_filter_mask & RTEXT_FILTER_NAME_ONLY)) {
+		rtnl_lock();
+		/* Synchronize the carrier state so we don't report a state
+		 * that we're not actually going to honour immediately; if
+		 * the driver just did a carrier off->on transition, we can
+		 * only TX if link watch work has run, but without this we'd
+		 * already report carrier on, even if it doesn't work yet.
+		 */
+		linkwatch_sync_dev(dev);
+	}
 
 	err = rtnl_fill_ifinfo(nskb, dev, net,
 			       RTM_NEWLINK, NETLINK_CB(skb).portid,
 			       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
 			       0, NULL, 0, netnsid, GFP_KERNEL);
+
+	if (!(ext_filter_mask & RTEXT_FILTER_NAME_ONLY))
+		rtnl_unlock();
+
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in if_nlmsg_size */
-		WARN_ON(err == -EMSGSIZE);
+		WARN_ON_ONCE(err == -EMSGSIZE &&
+			     !(ext_filter_mask & RTEXT_FILTER_NAME_ONLY));
 		kfree_skb(nskb);
-	} else
+	} else {
 		err = rtnl_unicast(nskb, net, NETLINK_CB(skb).portid);
+	}
 out:
+	netdev_put(dev, &dev_tracker);
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
@@ -7116,7 +7147,8 @@ static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst =
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
2.54.0.563.g4f69b47b94-goog


