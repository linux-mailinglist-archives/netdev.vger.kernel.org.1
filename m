Return-Path: <netdev+bounces-291261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLmIKCkKFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:36:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A75C7DB2
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 700863024282
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26A3E3D98;
	Mon, 25 May 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFz4obwT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA63E3C64
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698151; cv=none; b=PDHDKxvagsETZtL989dqKGESUvAFS2HMgz9/PALWSBsHB/sCX+fVWWksu44GqZYIOzU8Yz1kzOU/rfP1EYfePvFh56cS9WHpQ4lKZZNshPfB4KwIWC32IAx4qKHUR6l+/l9boJB1TsUNvFR5pTQ98YcGwfF/AwSZ1+rX93CVGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698151; c=relaxed/simple;
	bh=HrpRRuUNOKG395GZ1bXz9G4gyGJJoIAo4cRAQq2alo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lHmQGejRvEvntGRaCG1k+I8780dqQ7ao8h58sIHXVbSLKeGOSATKn3y3vcuL2xEpGIGGdwI3RBzzyjBdeuSfMYjOeMx+NKI3hjaVNF86CvYeVEMtT6NKT+1Upis105pRPGF/azCHEMtT5VMfiT5keHLyf2ZCQnFb7vhEPRBBiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFz4obwT; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-914bd251f5cso290837285a.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698149; x=1780302949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMW84vp6jg6JksFl4YEauByqN2EXeNQbS6wyZqYujRs=;
        b=YFz4obwTyMWK4o6KqTUsKYbu2qN61/z2j4K45IDKu8In6LtUThXONo26MCTeJG6/rC
         hLfMvcWiDvuZp2ojM8rk7mLzF2K6eo+T9eFgvGnCBzWHAcXpPEXgEJVoyhB68ClyybhJ
         RVo3Y4VJZ/Xq66sxwu5PPsFVz7SrCs73MGJZQ2c+AauAz+OdplJ5Mb19MMFUa/UsiYuy
         Ejc7UFcDrFu+Y8CfGrUBoED8emnVFmpq3XNoYu8ZFYthLUH53ev0q38R0yPnu4tyPMv2
         JWjvQBE/V84rKkRzPyaIyfeoLQYnFrpQi2F9bu9wJBa20oaoXTm22WVqBR1fXOnAgtva
         +juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698149; x=1780302949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMW84vp6jg6JksFl4YEauByqN2EXeNQbS6wyZqYujRs=;
        b=mdX7SP7OlPQ2qiUQXeD7U4g6AbkogEwhZcvSld+EPtITdFEdf+UO0SJIFEqRUYPJ3J
         ltdid5TBHES2v8Ehj+EiJJZbOjQhIfLiDuuEcrRaXv9W8pg0ssFVulJ2SzN9bF95ouEs
         GTtH88gKbT0tTgwmsOEP7Hz2flrtPIduehJ4G8rW8zure+aiDEWSSMPiBVxJMhY0VyXm
         ywYoZTLp/CgJLRSlfpYi7bO5hCM8q3BIuLphzKTm5Px2YIlVDn7xQECDlXJSXJKmZtUK
         57Y6NrizTxeWYhf9Si6tMShhxyCsEih1kI3Ch+mNPI4bh1JAygtqpzqS26wIl/qcfQf0
         qjqg==
X-Forwarded-Encrypted: i=1; AFNElJ+vfr/TbGhXuqNuLb9ePTv9NnFXmZa2HR3evFEdGlTzWpnaUHnwR0Iq3lZOxMSYdtQ5zQ9XFh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18D1UpaTLgZ6Hb64iUGRkY199UwWA11C/FYU6c4fAdGqyKxZl
	L04R8jaCV4xOvVeDL0l3VEjf22elUn+JWFw10xyEUjaHW8GA9jZzRSoneDIL9ArlH5emv794cqY
	hWaHDdjHBbyd0+A==
X-Received: from qknpf2.prod.google.com ([2002:a05:620a:8582:b0:913:40cd:8975])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2794:b0:8cd:b617:6522 with SMTP id af79cd13be357-914b496b748mr2128901085a.29.1779698149072;
 Mon, 25 May 2026 01:35:49 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:40 +0000
In-Reply-To: <20260525083542.1565964-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525083542.1565964-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525083542.1565964-4-edumazet@google.com>
Subject: [PATCH v5 net-next 3/5] rtnetlink: do not acquire RTNL in
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291261-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F9A75C7DB2
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
index cd1004410dd7f5c45ebfdc329b461dde7b1d9411..6041e008b22dbfd164ede6d50a77d2db5d7e2e23 100644
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


