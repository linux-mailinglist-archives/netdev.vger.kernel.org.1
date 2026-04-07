Return-Path: <netdev+bounces-276172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHdaK0d11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EE3B4F94
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BC053053BCE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B5137C909;
	Tue,  7 Apr 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoxvJI76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2337CD3B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596821; cv=none; b=JkmbSybbyJqR4bKI3ZM0N03LnaU2yHohzq/7pUh57VJv8VOuArLmIo0YjnxLTM6WWMiiOWo3VaEVh6TEM/ZHXO9nejKq27QrQGlQoLbTBxmO1nrh16aUpWiXQ/qs1A2FILNLvaisHjiyWvKwIJKlE7cBfHkX7yqbVyUi8pbbvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596821; c=relaxed/simple;
	bh=FqW7WbjUzt8Bitgcnw8xgy7PTqCk0T9gQdCrl+dyq8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u3lczN9jO3eOj4O8K9azAd3qVDbo0nVmAdMxtNzKJYDud3ZJde8lGE5ATexecqiodzbYTbPxSaYkQMnt5KixPIClgBEdtHRPpff7nE/Zfz588e7cJeXX228wWgqKSnTGQUbBUP2/YtH33JOomsLOoRpYZmYUnNhssKQmWYy+rRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoxvJI76; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c741b950511so2965184a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596818; x=1776201618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0/FwN7++nQ+Y50oJC2c9Kg9wu9mS867qrsghsmaF60=;
        b=hoxvJI76UjsXiRGtAgUCUs6cuhiFtcNifYqu71qIg/Lq/r+veH7DNdh4mZne6tV1nm
         CthEGCW+ErW4f5Uf1IkAD6na6ln9bfIWP3pz61+vb+/bq2mOOWL9LIGt6dtTji+8nyYj
         I5/0fTck7WVan9SU0uEIpZnw5ClbCAZSTEwhf7L7EjlhtGn7GKhENRl42d9ji+xCInhI
         YRePML53V8CBtswJvl02IWCS1fzdx1Xg3NkIH9h6LT1Qi4qCaFa0T+oS6GWUT08CrmtF
         KOgJw0ecEoFDtdM/ulOFcc7LeWHHfqIfhSXZInQcOXwSYVI2GW4U11M08+ECi+DiaRC+
         i4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596818; x=1776201618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0/FwN7++nQ+Y50oJC2c9Kg9wu9mS867qrsghsmaF60=;
        b=qDnurIQ3VHtAqIPFLGJavJ9sJ2PJ2ka6kmjW24+EE+/PENSeWaTghkq4wdUGLdFkJ1
         2FpjOwPVslpcpVKKwP41/k9AW8EjxlJXxpll2zbkqfpxp6bEWpntHhZdPDSCvneHbcXU
         MaCffpCU2em5lWHJQVdsIRlrkvvSw1xa+WWOUhfQQbtYEAVYeiAEDjPgO5JBmnbf623P
         tWqTQkkkffFB1KzrHQ+2v2VSl0w5JRkrPimTtVxlCGoAkKG2mgGfs9ReOMUZekYHmVA+
         GABLU8Jg/5LHienCbyIAP9glVLCnl6OJKJ7is4jcFcOsPEuzUCUNA6j2dDppAomroXfw
         uayg==
X-Forwarded-Encrypted: i=1; AJvYcCVv+YE8atLjz8VGohtA/YLKdjLQO8t6YH0AOZTE5vJdSwb969Thx1WC0zJzUgcXVkdrLWX5K5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0t8NUmWn0Vya0Pnv29+Kz3mQ+pk9+OePuDPGM0hSwr7Q9UlNu
	McV3uXNJijqJbr3F1hdvIDzBMHgQzSCIjAxGq/QprEQPx+CnRID0mQXd2Chu73TSr36MXf8JtOn
	IT9mLCg==
X-Received: from pga28.prod.google.com ([2002:a05:6a02:4f9c:b0:c76:68c0:63fd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2448:b0:39f:2c96:e0cf
 with SMTP id adf61e73a8af0-39f2f0b2d05mr19185231637.18.1775596818098; Tue, 07
 Apr 2026 14:20:18 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:42 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-10-kuniyu@google.com>
Subject: [PATCH v3 net-next 09/15] ip6mr: Move unregister_netdevice_many() out
 of mroute_clean_tables().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276172-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 504EE3B4F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a prep commit to convert ip6mr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in mroute_clean_tables()
to its callers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b9c048b6f1ca..c46f6a430d26 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -99,7 +99,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			      struct netlink_ext_ack *extack);
 static int ip6mr_rtm_dumproute(struct sk_buff *skb,
 			       struct netlink_callback *cb);
-static void mroute_clean_tables(struct mr_table *mrt, int flags);
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list);
 static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
@@ -405,12 +406,15 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
-				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
+			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
+			    &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 }
@@ -1537,10 +1541,10 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
  *	Close the multicast socket, and clear the vif tables etc
  */
 
-static void mroute_clean_tables(struct mr_table *mrt, int flags)
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list)
 {
 	struct mr_mfc *c, *tmp;
-	LIST_HEAD(list);
 	int i;
 
 	/* Shut down all active vif entries */
@@ -1550,9 +1554,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 			     !(flags & MRT6_FLUSH_MIFS_STATIC)) ||
 			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT6_FLUSH_MIFS)))
 				continue;
-			mif6_delete(mrt, i, 0, &list);
+			mif6_delete(mrt, i, 0, dev_kill_list);
 		}
-		unregister_netdevice_many(&list);
 	}
 
 	/* Wipe the cache */
@@ -1615,6 +1618,7 @@ int ip6mr_sk_done(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 	struct ipv6_devconf *devconf;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err = -EACCES;
 
@@ -1642,11 +1646,13 @@ int ip6mr_sk_done(struct sock *sk)
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
 
-			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC);
+			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC,
+					    &dev_kill_list);
 			err = 0;
 			break;
 		}
 	}
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
 	return err;
@@ -1761,14 +1767,17 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	case MRT6_FLUSH:
 	{
+		LIST_HEAD(dev_kill_list);
 		int flags;
 
 		if (optlen != sizeof(flags))
 			return -EINVAL;
 		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
 			return -EFAULT;
+
 		rtnl_lock();
-		mroute_clean_tables(mrt, flags);
+		mroute_clean_tables(mrt, flags, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
 		rtnl_unlock();
 		return 0;
 	}
-- 
2.53.0.1213.gd9a14994de-goog


