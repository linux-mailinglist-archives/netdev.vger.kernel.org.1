Return-Path: <netdev+bounces-304310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z967Cln+RmpHgQsAu9opvQ
	(envelope-from <netdev+bounces-304310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A11766FD8F9
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HD0uw4Y4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304310-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DDEC3063CC0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0D2E65D;
	Fri,  3 Jul 2026 00:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D571A6830
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037420; cv=none; b=hpxZCF1P9V9ipVcf03FLYAqrcdQknMpnqOapC88/2gBLyqLuKQCgHEm3SBVI+cLnk5mD7GLyxNaCrVYo6O7aQUmwRPv1oi9gzAInDoYd40tsUYt7l83K0oX7BFnjgVRVdLJXipTHWI7aLJYSWK7+PwD+/VqWZJa3xsO1nt60Nk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037420; c=relaxed/simple;
	bh=4uTkc7k97CZs97+qGbVtl/1aogXbXB06CBgdXrlFYD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jWI8Gciq6z5HSF0CZHbdbqvHoMgiiNaSxHSiyIgLXt+d0ldpFJonB4yg61yyNNC6oSKqZOYIh5fPYuc7pXKekn6OzSGKS9aiFNn8jQfWgdRxCe4rAMePeuS7IeqDdoVSTTj2BlbdZfioNvtK/iACPDWT09CS7oworYaO3Ssn0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HD0uw4Y4; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca5d2474c7so58743695ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037419; x=1783642219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ig1BR26daNo1u4uKaEn2C7EaSBhFiboef3RAuM9CEk4=;
        b=HD0uw4Y4D24vgXmFUdl+pnXl3LSg5v//NPJOlgDlRwDw34dDSzu6inVbcU10K/C34Q
         IuL8jocvzZNccyK6zJE3q1u0Hk1G96KWWP4HTUGBxMfK6WDYsT577IKZCR5ufjFt/dTu
         Y3/teIIu8YuGqG7RqX5GrynNNPkhfN1vs65OvMG3e+jpZQadKlB2Ol/yKMhRnGHIliKs
         8TmOE1rrk3rVLFKKkwi748T/+LK6eJtzUMYqA0rs242IuhpysDeMUqY17RZBiYaAbo2+
         2FQRlBHev4A8f7U2tdOVk3yBWakOsHg9/oWiRCMe9OYNUE/7DMHcdBVUUKLl2BRbkDiv
         NeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037419; x=1783642219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ig1BR26daNo1u4uKaEn2C7EaSBhFiboef3RAuM9CEk4=;
        b=ea8OuhJlrmEuQzouMYmDkXassaKG5D9etHUht0TxzEbqgzAADTLo4zkQaSQc+zCrKE
         ZEiYflwP7GKZ+NfpA3XVmBk/bvboeGYrXK07e+3Ze+01QO2fU9x05VWdxTiftHiz5wT1
         oeUFuTVUcpW9V/vtAD7w8aDspvX01n7ay9Lq2QYPgdHrAr8n0MqgTSXuLxWs2r3+CCVq
         rKipyOB6nKMbwjJ+PYGykbdWItieb5C600SRng+mzfta/i4JOYk5e4Cffyeqd8AOA13E
         7NRJyFSWcropeIM24waNAPJZCw4eoaiY4/6GPRDfvUH4JMBDJGzarjqCvh+abLDi4dRr
         K0Xg==
X-Forwarded-Encrypted: i=1; AHgh+Rpa8pwvTpsNZpTvH+9H03+u4bXCYwZ8BW3Qg7ep7X2x4CAuiuE+iSFaAUUZYHClQPlEHu6hvT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykx2yR/dqAU0x/BKLHK3bahNgO91CjE97nbHXqY0Xz3sVjjSzR
	3yaS2l21sD5PojR79GN3W1pAQFAHpLNXQfNVtJi8Z+/YlvXslIB/Xszvj3wPCDAZqKntgI8OD57
	qym1DNg==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:2c9:b128:a017])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64b:b0:2c6:f3ae:2386
 with SMTP id d9443c01a7336-2ca91114c0dmr78094045ad.7.1783037418506; Thu, 02
 Jul 2026 17:10:18 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:20 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/14] bareudp: Protect bareudp_list with mutex.
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
	TAGGED_FROM(0.00)[bounces-304310-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A11766FD8F9

struct bareudp_dev.net is the netns where the backend bareudp
socket resides.

struct bareudp_dev is linked to the bareudp_net.bareudp_list of
the socket's netns.

During netns dismantle or module unload, bareudp_exit_rtnl_net()
iterates the list and queues devices for destruction regardless
of the devices' netns.

Thus, once RTNL is removed, the list can be modified concurrently
from different netns due to device removal.

Let's protect it with per-netns mutex.

bareudp_newlink() is still protected by rtnl_net_lock()s, so
acquiring bn->lock twice in bareudp_find_dev() and
bareudp_configure() is not a problem.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bareudp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 5ef841c85526..7dedf4867e7b 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -36,6 +36,7 @@ static unsigned int bareudp_net_id;
 
 struct bareudp_net {
 	struct list_head        bareudp_list;
+	struct mutex		lock;
 };
 
 struct bareudp_conf {
@@ -636,10 +637,15 @@ static struct bareudp_dev *bareudp_find_dev(struct bareudp_net *bn,
 {
 	struct bareudp_dev *bareudp, *t = NULL;
 
+	mutex_lock(&bn->lock);
+
 	list_for_each_entry(bareudp, &bn->bareudp_list, next) {
 		if (conf->port == bareudp->port)
 			t = bareudp;
 	}
+
+	mutex_unlock(&bn->lock);
+
 	return t;
 }
 
@@ -675,7 +681,10 @@ static int bareudp_configure(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
+	mutex_lock(&bn->lock);
 	list_add(&bareudp->next, &bn->bareudp_list);
+	mutex_unlock(&bn->lock);
+
 	return 0;
 }
 
@@ -692,7 +701,7 @@ static int bareudp_link_config(struct net_device *dev,
 	return 0;
 }
 
-static void bareudp_dellink(struct net_device *dev, struct list_head *head)
+static void __bareudp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 
@@ -700,6 +709,18 @@ static void bareudp_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
+static void bareudp_dellink(struct net_device *dev, struct list_head *head)
+{
+	struct bareudp_dev *bareudp = netdev_priv(dev);
+	struct bareudp_net *bn;
+
+	bn = net_generic(bareudp->net, bareudp_net_id);
+
+	mutex_lock(&bn->lock);
+	__bareudp_dellink(dev, head);
+	mutex_unlock(&bn->lock);
+}
+
 static int bareudp_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
@@ -776,6 +797,8 @@ static __net_init int bareudp_init_net(struct net *net)
 	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
 
 	INIT_LIST_HEAD(&bn->bareudp_list);
+	mutex_init(&bn->lock);
+
 	return 0;
 }
 
@@ -785,8 +808,12 @@ static void __net_exit bareudp_exit_rtnl_net(struct net *net,
 	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
 	struct bareudp_dev *bareudp, *next;
 
+	mutex_lock(&bn->lock);
+
 	list_for_each_entry_safe(bareudp, next, &bn->bareudp_list, next)
-		bareudp_dellink(bareudp->dev, dev_kill_list);
+		__bareudp_dellink(bareudp->dev, dev_kill_list);
+
+	mutex_unlock(&bn->lock);
 }
 
 static struct pernet_operations bareudp_net_ops = {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


