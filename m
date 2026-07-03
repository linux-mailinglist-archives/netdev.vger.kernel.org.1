Return-Path: <netdev+bounces-304308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id deY2FkH+RmpEgQsAu9opvQ
	(envelope-from <netdev+bounces-304308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81886FD8EE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=CsLXMQI9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304308-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64C87305762D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CD199EAD;
	Fri,  3 Jul 2026 00:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B41C2AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037419; cv=none; b=Twb60EtYJder+Ft3FQbAOl+tNzdUkNqOpoVsZa/IC3hxBmHj+P83umC7pCvaxuhUqostrddatWszUPTN55tjS1UIr+9CwGuGXNaVfp0P5C8pc/qMsXwpsT4ResPVlwLvN15byVvJJnYNATv927TLnZF2a+eIhOR6FbkOgqxECng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037419; c=relaxed/simple;
	bh=wPgmU+DYmGgio+QVJkLKjeQjGHWEtEOTiX+n3sk+/8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFnRevr+32rbxE1imTPgC2vaXiuTas+dCdhy7hbsX97shQ7bFPgqFPn9M49uRxeygME7yl17Beh9tPoSfWxSz2wTy3UuoapcLYU2CNWThI24ybedaBxGzswfq0b1RcC8Ll2Jm2CSRaKJJuguSX6ZruU7s71b30e7gfSM4VwoYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsLXMQI9; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca0d4fb061so40656215ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037417; x=1783642217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMaDBNPVmJ659WJyyApictBnkP15ctG4XLUC2wrqRxQ=;
        b=CsLXMQI9GTQYFIQamAreZ4GAplwyl85bRkErQqLaxS7cqnDXXT3TLswSvWq55UpaT/
         ycP2kwPJ53UzdQb7/3t/SGLaPx4MUqFf62PzkBxRF2lRCF9QIdLExVIXGcq9eHQ1jyHN
         HgcwQcI1m7Qc/nNs5st7KyV9ZYWvXY/aznvoa1YFhH/5BzLVm1f1g8w5Hkq85bIzb9pu
         kxjPK8vfXh7W7O8E/1koTWbIA1yrYD/ciXN23rq100iOeyXanJ8jxyt6sDYrilIKlWcq
         OCNoyvCCzZWvWko8ZTn4TVbnLfpCDDtxk5zeumnO4fZpLFrohFf/aO0zVeuXOHZtF4Vi
         a4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037417; x=1783642217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMaDBNPVmJ659WJyyApictBnkP15ctG4XLUC2wrqRxQ=;
        b=cFT2MD01eetGMLEcT+AuMmw93g6GXc/+EzBK9BONJGmpN98uQXGwFk881iw4trKx2O
         p9IsBZ4mC6jCS0fNIaKVW/q3OxtFElocFH1Sa9tJRb7fEHjIEwypnEO8MdHvGmsfPIDR
         EX/o9h5FEAYkBQ61pjEVCGjGTHTztciMO4jY4td6oHDHBG5HTtlfyiEkzS1E9Es42Dc1
         XVwMqcp0GhAqwtjGcKuZDRrjaS08BGQXOdCIMzbGOs0gBmuhnHV/wbwwomCHevPimmZU
         BGKjqhz/L2eJV3EEGgM4nrT7qcMioXpuwvzGvdPYpIO2y+nccVIFGUJNv/xA/Jkms4Aw
         lV8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq4xPz9vHxWPkmAOyteH95crbCNKPcoP/W2kgE/VXXza5OXTI4k1GNChPNPqWP+zBmisx2XLlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2DkLbfL/2UkBINxX6WchG/7qWc9m9Oe9178MrBU422pH10wk
	bopK60PuJqZKIKKZXC8BWch167ff2ae2FQpDaUsbvyXuYjyDYOU5lO1Wg5HOsMd9BM00rkbWufw
	cLNGAag==
X-Received: from plq6.prod.google.com ([2002:a17:903:2f86:b0:2bd:c5f9:e27b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22d1:b0:2c0:f807:9bf3
 with SMTP id d9443c01a7336-2ca7e654734mr83533015ad.10.1783037416903; Thu, 02
 Jul 2026 17:10:16 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:18 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/14] net: Call unregister_netdevice_many() per netns.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304308-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B81886FD8EE

For per-netns device unregistration, the list passed to
unregister_netdevice_many() must contain devices from a single
netns only (once all callers are converted).

Let's move collected devices in the following functions to
net->dev_unreg_head and let __rtnl_net_unlock() pass them to
unregister_netdevice_many().

  * default_device_exit_batch()
  * ops_exit_rtnl_list()
  * __rtnl_kill_links()

This allows incremental conversion of each driver to support
per-netns device unregistration without affecting the normal
kernel where CONFIG_DEBUG_NET_SMALL_RTNL is disabled.

Note that this change unbatches synchronize_rcu() etc in
unregister_netdevice_many(), but we can later split it into
multiple stages to batch them again.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.c            | 27 +++++++++++++++++++++++++++
 net/core/net_namespace.c  |  1 +
 net/core/rtnetlink.c      |  6 +++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 108d8d7ea75b..8db25b79573e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3481,6 +3481,7 @@ static inline void unregister_netdevice(struct net_device *dev)
 void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
 				    struct list_head *head);
 void unregister_netdevice_many_net(struct net *net);
+void unregister_netdevice_queue_many_net(struct net *net, struct list_head *head);
 #else
 static inline void unregister_netdevice_queue_net(struct net *net,
 						  struct net_device *dev,
@@ -3488,6 +3489,11 @@ static inline void unregister_netdevice_queue_net(struct net *net,
 {
 	unregister_netdevice_queue(dev, head);
 }
+
+static inline void unregister_netdevice_queue_many_net(struct net *net,
+						       struct list_head *head)
+{
+}
 #endif
 
 int netdev_refcnt_read(const struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index ed41c704c941..c43a44fb649f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12552,6 +12552,28 @@ void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
 }
 EXPORT_SYMBOL(unregister_netdevice_queue_net);
 
+void unregister_netdevice_queue_many_net(struct net *net, struct list_head *head)
+{
+	struct net_device *dev, *tmp;
+
+	spin_lock(&net->dev_unreg_lock);
+	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
+		/* Once all cross-netns unregister_netdevice_queue() is
+		 * converted to _net() (or for debugging), remove this check.
+		 */
+		if (!net_eq(dev_net(dev), net))
+			continue;
+
+		DEBUG_NET_WARN_ONCE(!net_eq(dev_net(dev), net),
+				    "%s was unregistered from a different netns.\n",
+				    dev->name);
+
+		list_del_init(&dev->unreg_list);
+		list_move_tail(&dev->unreg_list_net, &net->dev_unreg_head);
+	}
+	spin_unlock(&net->dev_unreg_lock);
+}
+
 static void unregister_netdevice_move_net(struct net *net_old,
 					  struct net *net,
 					  struct net_device *dev)
@@ -13185,12 +13207,17 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	__rtnl_net_unlock(&init_net);
 
 	list_for_each_entry(net, net_list, exit_list) {
+		__rtnl_net_lock(net);
+
 		for_each_netdev_reverse(net, dev) {
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
 				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
 			else
 				unregister_netdevice_queue(dev, &dev_kill_list);
 		}
+
+		unregister_netdevice_queue_many_net(net, &dev_kill_list);
+		__rtnl_net_unlock(net);
 	}
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 578b48cf5318..a91d2b58aadd 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -181,6 +181,7 @@ static void ops_exit_rtnl_list(const struct list_head *ops_list,
 				ops->exit_rtnl(net, &dev_kill_list);
 		}
 
+		unregister_netdevice_queue_many_net(net, &dev_kill_list);
 		__rtnl_net_unlock(net);
 	}
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 544498d3c325..b129f793d851 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -714,8 +714,12 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	down_write(&pernet_ops_rwsem);
 	rtnl_lock_unregistering_all();
 
-	for_each_net(net)
+	for_each_net(net) {
+		__rtnl_net_lock(net);
 		__rtnl_kill_links(net, ops, &dev_kill_list);
+		unregister_netdevice_queue_many_net(net, &dev_kill_list);
+		__rtnl_net_unlock(net);
+	}
 
 	unregister_netdevice_many(&dev_kill_list);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


