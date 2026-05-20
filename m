Return-Path: <netdev+bounces-289882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFScBNqNDWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C958BCD8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C986D3003729
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781D3D6CB9;
	Wed, 20 May 2026 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDFM35Dh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A039B970
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273159; cv=none; b=bppg5w26XYc5bp75Fe3xRLM451+c5oxCqnJDVKng7ZphOq5nHNczjzTJOoUbbSG4PqPHfJEte8rJgsjD9lFcjd2Fq+lr51EkOXVsvW9dSus5K+Mi8MOCk3V1pQqdrZXBNk1xDAzWovMF9PmqEqahzGugo64dKZemqCFFTyH66ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273159; c=relaxed/simple;
	bh=mFwnmUroHa1k5ObQjQhOVzNw9tL6WAFZ5XNMTU8Kisg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aEP2uRIB+DvBegtQQ1XMV495eY2cjhnpKl15lojEDwgVxCcyV8iDmWrYRAIsKmgBPyeZAOAIOSMxcbZk4+Y+//DAaxk0EcwLxrMIxyt/kyvnTg5Q2thJ2GaajPi9YkU02RM54n9DnjQgsL8ZdPPF4+gH9knopDzkIUHJeKJdZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDFM35Dh; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca29dcd69so135669326d6.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779273154; x=1779877954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q8SSp1rgFav41E733ke+1I1FDmpeIXtHuohDdvlSS0=;
        b=DDFM35DhwitSF6QtgAubYO4iaS1/wiibPL+O7t+BuVdGSR/JDy0iDCirkaBqwXXmnL
         ecAh/ihrbNRK7PkHYVo2eau1j4Y25tkoy8UwBaJxdGfmSxkCqkFXY10B5ywtc8+t2MNj
         WSXTILG9lmSJkn/oYRs45LAQtUShlOpln+onXqwuD5PT2FS8CbSEotX6HyOunmvSYy64
         EdfF+g3U29cf2HN3HaCUi7rtJ6ltyq5YGeARkXUV8S+v4K0J0229w1OrXSoQXhPeXcN3
         L4aAyKYMm/0KPBNsIhERmS/UmUTFveSEwwn5zTF7NkpVsm7hJWP6m4wdxP8twncljMLu
         dX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273154; x=1779877954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q8SSp1rgFav41E733ke+1I1FDmpeIXtHuohDdvlSS0=;
        b=l36/oDpYZIx2Akc9EYypuav7KsmwI5i09j7Nj3tbwRX5UJk3xOLQi6aVBKU/p2kHDg
         D7pfjwBxxA6H1TR2OQfVJ6Ct+3KhlFZcu3l/DdTgLs3Ax+WbWHWqhXgWlYReEqI34sHe
         E4/rwXwQpk9at8rdAhQZecbKjW2W/+4wGiz5cbnZh6xjdDDtJo2sf6JJVn6lSYpFNX4U
         HScMnR3/0UeY7kJAFs8cweqr+B15/JpBYh3HjZQGRACFGlZy9LLaZIQ9MAQhH6CYORUf
         eKLuQf5+1+8x8nrPz64cr8V84JNBcMlfwGCqAwRevGSY10AvhzbTqGw25Jk7a1zZh1Ou
         PPrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+utm7wfLMjfctUlK9CnrdQuPsLisSIVqHSGDq20N7axuFsIiF2seaPGp/79UoHaiB66M2LVmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yZ9IyR5oi+Q4/vLP0jSzGjLDIfTIY8LVEHVA9/e5WuyPk7GZ
	djy/7+junPjGcMdirpn1K8oPDGAY9sb8M4ThcUK+O05ESELWrn/vz3I4rrsM4nHc1fJma5N00DX
	EKrGpf0Jq0cytsQ==
X-Received: from qvbfh1.prod.google.com ([2002:a05:6214:1a01:b0:8bb:bac0:7868])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:f109:0:b0:8ac:801d:c3dc with SMTP id 6a1803df08f44-8ca0f5c456amr296238486d6.9.1779273153276;
 Wed, 20 May 2026 03:32:33 -0700 (PDT)
Date: Wed, 20 May 2026 10:32:27 +0000
In-Reply-To: <20260520103227.1133277-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520103227.1133277-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/3] rtnetlink: do not acquire RTNL for
 RTM_GETLINK with RTEXT_FILTER_NAME_ONLY
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 143C958BCD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When RTEXT_FILTER_NAME_ONLY is requested, rtnl_fill_ifinfo()
is dumping device attributes which do not need RTNL protection.

Many shell scripts invoke iproute2 commands specifying a device by
its name. After this patch, they will no longer add RTNL pressure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 82 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ae0254f19178735b2805a8189e81a960a49b2858..587bb8bbc73d0b2075ca508a5537200f65f74594 100644
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
@@ -4214,43 +4230,56 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
+	if (!(ext_filter_mask & RTEXT_FILTER_NAME_ONLY))
+		rtnl_unlock();
 
-	err = rtnl_fill_ifinfo(nskb, dev, net,
-			       RTM_NEWLINK, NETLINK_CB(skb).portid,
-			       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
-			       0, NULL, 0, netnsid, GFP_KERNEL);
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
 
@@ -7116,7 +7145,8 @@ static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst =
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
2.54.0.631.ge1b05301d1-goog


