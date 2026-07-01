Return-Path: <netdev+bounces-303842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aeEPLRmKRWrRBgsAu9opvQ
	(envelope-from <netdev+bounces-303842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7C6F1E92
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XXW3jWgb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303842-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5727F30027EB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6B3B7753;
	Wed,  1 Jul 2026 21:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B93B47DD
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942226; cv=none; b=plMlcT+bz3jNuBbQjvo7ZDKLcKa0ce+BXq0w6b8dRuZ62yiBzwpObGgkjIZBbXZUvuWzmS1InWs/Or/5E2ktA47pD9pUnF9gNQhl9cmzajbsnrs9COe8cW4DX7xWxVCdy5OnKwu3W2CXFSNPaJmX98wpW0SPUCSOD3fmCrxB3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942226; c=relaxed/simple;
	bh=rXdKas2qFAGabXxz+upauTJMdBqVTTCwB4bLVS7dhyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnCC5wfe6u5riSvDU901Rxf6toYWn3tcuoC2pZvNOnM+fq+bTwfYcrZXo+gVOb+hs614v5232iOaGZDOwg9o88bB/c7qeEWsi7irJqmAhPru59NgcTSpvVshgLrwxWx2hIPqSvs3eXjG3UqcIYXyg7A/CRMecNGHvaYAygIWn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXW3jWgb; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84696ed3b24so1181782b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942225; x=1783547025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1D44iiuED1WFtnyZpajMPXSIx3JxJag8mmpE+v2bc=;
        b=XXW3jWgbRmFHQoC0dTnedgJfp2JmjP2iWJnoDuhUQ3UlZ1mB4SIJ6NMw524OiRz8Ez
         ymTZ0npqH+5C3Wet+CMkm/5Vuvz2Sh90anEzjS66X/sdnHQ5jY+4pmuUv9/5lhQv7sIB
         DO2Zi+3qzV7lv9sesUh9Q6GZqZmiad3Jv/afheONQxuVF2qyIKMVOXIH4S5Koy+PL+1Y
         xpw6PPbx5ApAu/+BJwpuu6EDE70BCh/Uxgv4sKNTiTOClcHNAU03LUSNXdfkQp2NxPVo
         9NSHF1R1bnAP4/Wmjw/KUE7jilxxaGhzTGloC65dC+PdZhcw9913xrJD9haVftzFgfDG
         vo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942225; x=1783547025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1D44iiuED1WFtnyZpajMPXSIx3JxJag8mmpE+v2bc=;
        b=XG7MKv3oIznrbe7ABHLFN2pqGy7669sXifPsz+A3R34pscjMPQgNxTNE9nZKeYXf8W
         EZNVs+4ESkO5ollpVsFIzFFIEC3ZOgUj94euyX4ue37Qx1Mq4KMfsfBaIdU4l9n770H3
         asU2zD06nesLGlBg08sZOevtik1dZz3FPgz/TAybszEylUgRuWNBn0qCfsykJKk9feo3
         G4bUsuJjeLH+6aklfzlGJBRitj096BJewUNjXHjjBlt3SUr7mSj/4I5RhKk8OLig6b4e
         g5zP5lWZArF0ngRoa5CaRRRD/3u9g3DLxgn6rjdfr8GZfXAp11Eg7VooryUA1jXaumgO
         2Suw==
X-Forwarded-Encrypted: i=1; AFNElJ95ZWaRAnyT+bDay6KEgyBVF8q2Jj/RzgKmvi6jMXHw/aklbmdTJws0sW7dQbYWm/3bqb2f6qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9AtfXjzx7Eea6CRxS/f7GqBv8+j7rBidoQId2yy5vzbv2UT+x
	6pwm4nnrFH2LLdoYhwzjpznHAUPxly+4VQV4xcEX1YojnsOqh0xcMOHE6G3EKbWciT95Rss9/9E
	T+INZhQ==
X-Received: from pfbcj11.prod.google.com ([2002:a05:6a00:298b:b0:847:b387:96e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c84:b0:847:8be6:2177
 with SMTP id d2e1a72fcca58-847c0855039mr2951054b3a.34.1782942224309; Wed, 01
 Jul 2026 14:43:44 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:40 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/14] rtnetlink: Call unregister_netdevice_many()
 only once in rtnl_link_unregister().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303842-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DB7C6F1E92

When rtnl_link_unregister() is called during module unload, it
calls __rtnl_kill_links() for every netns.

__rtnl_kill_links() collects all devices of the unloaded module
and passes them to unregister_netdevice_many().

Let's move unregister_netdevice_many() to rtnl_link_unregister()
to unregister all devices across netns in a single batch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/rtnetlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f39c93e80e20..7207da002fb5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -637,16 +637,15 @@ int rtnl_link_register(struct rtnl_link_ops *ops)
 }
 EXPORT_SYMBOL_GPL(rtnl_link_register);
 
-static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
+static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops,
+			      struct list_head *dev_kill_list)
 {
 	struct net_device *dev;
-	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
 		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+			ops->dellink(dev, dev_kill_list);
 	}
-	unregister_netdevice_many(&list_kill);
 }
 
 /* Return with the rtnl_lock held when there are no network
@@ -677,6 +676,7 @@ static void rtnl_lock_unregistering_all(void)
  */
 void rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
+	LIST_HEAD(dev_kill_list);
 	struct net *net;
 
 	mutex_lock(&link_ops_mutex);
@@ -691,7 +691,9 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	rtnl_lock_unregistering_all();
 
 	for_each_net(net)
-		__rtnl_kill_links(net, ops);
+		__rtnl_kill_links(net, ops, &dev_kill_list);
+
+	unregister_netdevice_many(&dev_kill_list);
 
 	rtnl_unlock();
 	up_write(&pernet_ops_rwsem);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


