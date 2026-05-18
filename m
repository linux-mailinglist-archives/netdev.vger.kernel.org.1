Return-Path: <netdev+bounces-288981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPISNMflCmrO9AQAu9opvQ
	(envelope-from <netdev+bounces-288981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:11:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F243156A718
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9410A303B386
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD332936C;
	Mon, 18 May 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lj4U2Gk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4031E82A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098503; cv=none; b=Ul7RvBHxUHZ99z9357t5aFkSMdyQfxtMvwO412pWO0aNoEuvWxzQRRIfC6OI186IbMxu7b1i8xGTZVGrCmzGwzrDxNy6KIJCFoM1aOItn3H4n1cmTGSQqnsTZaXPh2b9roWXzPlesnjg1lRbOEKm8Z5G+UdA40766DCB6+WhtU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098503; c=relaxed/simple;
	bh=+4IEKH4TXYQOE9RkQ8CPBajL8OlptaIodiMwMJEfS04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sHhotynqWWFL7SqzBGMZRU0vvO1vRjK0NOeYJncHnLX5NoT9MHRKOcH/SNnZxbvZT2asp2JEdWT4YRi56ujNuPuqmJmvQQp5xXmbpVoX8mocUizZashhe/5VfP+idlCV7yy6zOMPeAd8Mkuun8qWynnVH5VhYndFhx3tfJWfm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lj4U2Gk0; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-5752402f55aso1073194e0c.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779098499; x=1779703299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZKjj/nIpnkj9FtvcO0L8vwOF8zvejZPfy7qESYcgRw=;
        b=lj4U2Gk0StW6ebDUHSeUiFDu54OiaVfl/joPpo5ULKfu6hwbQ987KA/6EnaXp0h3rF
         XjlM6rz5bJZWXktGfH/Cghg9uuoiVOfpU9DYGvb9PAmRCkHOd+qwtbiNmgocU3BqqNDv
         Dxniu3DnKbEM9nA+6IQlGTS4966y+/STF5BMYL+GadgDEIeimSotn9QNdiNlWAVLwPme
         dW6nFBzyVUcN/IO8b1WVjfvQ1uFuna6WiHa5ZwQgrqCQh+LcL1wvgXTcY5wHkntcylRf
         FrWxvf1rYOeat6gRc+pqxaen+5juOkLHgOvvfNfoRYLjEFcfEtWsc8XWisy5bKaOLbWb
         n+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098499; x=1779703299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZKjj/nIpnkj9FtvcO0L8vwOF8zvejZPfy7qESYcgRw=;
        b=XCs3EGW5XdRoU0Z7NgFJwsJwanvU0MrmNyr45mCGE85VCEvNSHxpXBOX1UbUwfTsOQ
         TnjBirENsnz+AvEPs26x7EWGk431GkfsVbs3w+zDBDDJvH7yoaaUH5q79dG/dlhZmIuI
         tRvVeRuc4WuLOIboJmSO5jPXupyVFCc8i4cbA+JB0LQesKFXUfziCzPy3/iqBpC5L6as
         DZRoOitHdYyGfqBM537OyiD0WDlpd1UAVaTYC/SWDvb282qOqZshRRxW3ETsVkJlRx9u
         9dA3ihIRfitIM3OXxIt0q2dUqU9No3J22rxrU+9t0KyghdZY7tVgJ74GIq4FgCDMgTLa
         khOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bS6mJHH8C32N4Tdu0CymjKCEQm0SawWvlDqZ275T/BS6cJX0fZYR2eMAwEW2SANN7+GaLkEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMmQcbBHlxiYkr5cQUG4c8JSs96ScXlWNR5h7H8OP4tH61BkG
	xyj9HOA1hv7t0HDpzgq9UXuyTsKf8a3ZPD43JMftLfqSEIMAquALpQjH6m9h/63zTNLvYYHed5a
	wrHA03AizZxK9Bg==
X-Received: from qknqk5.prod.google.com ([2002:a05:620a:8885:b0:910:c453:28])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:8f8c:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5760c1f3533mr6643161e0c.13.1779098499194;
 Mon, 18 May 2026 03:01:39 -0700 (PDT)
Date: Mon, 18 May 2026 10:01:34 +0000
In-Reply-To: <20260518100134.809042-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518100134.809042-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518100134.809042-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] rtnetlink: do not acquire RTNL for RTM_GETLINK
 with RTEXT_FILTER_NAME_ONLY
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F243156A718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288981-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When RTEXT_FILTER_NAME_ONLY is requested, rtnl_fill_ifinfo()
is dumping device attributes which do not need RTNL protection.

Many shell scripts invoke iproute2 commands specifying a device by
its name. After this patch, they will no longer add RTNL pressure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 70 ++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ae0254f19178735b2805a8189e81a960a49b2858..8fe6260a0feaeea7ba35ddca3c1942f1420aecae 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
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


