Return-Path: <netdev+bounces-303848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cH8YCSCKRWrSBgsAu9opvQ
	(envelope-from <netdev+bounces-303848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1946F1E99
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=sY5cApmm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303848-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303848-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 947D13030E93
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011473BED38;
	Wed,  1 Jul 2026 21:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4D3B5854
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942233; cv=none; b=p4sf/IoC3bGMdUybpU1gWmEVp0ZFeoaXlxWjenaSE6RzQl+e2AFRGrtIeC3hD5NThsjuSASXB5aiqrhmBVsQ6E8NQdQkDDZ9b8KiJsKTZ92U1y3OWIgtaGEbKTMvrvTsH2YzXwuwdkFnPPw1tdDe0LXb9Uex5VIpvCwdj2IVIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942233; c=relaxed/simple;
	bh=nv/k+xLrZ+J99caVonP7y5vrNLctECzZPSVB6oubxVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3OHDMbfHP3pSRzAywVAbZJm41DDFoFrSqOLR89h9RW2MjAmeYhaTLVKNTgTxGDqZMQqInHWrYugl0R031xDeJSOTbXb99SFq/5mLuTHOvjHAw2Ec62DRrXXD3aeALyyqGI2XkmTgpCO2QTCLwvxCV8QKnswKoC5P4kxWqw0UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sY5cApmm; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c804e38c65so21297285ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942231; x=1783547031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9ie3bzKgeyYiuFvUKcNeHB0MegGvZ6/Yth4SJ9PFQc=;
        b=sY5cApmmqVdV9mbuF/1bZNmsr8ofUSyO5nxcQWGGINu6FeGb4w8kvFLxazIW0wplYG
         6EBvkddlEH3WIgZkDfRCyAgkzMQdJbb9P7k1jevsaoEymkflvtrTC9Rbdx293/DFG6eo
         YMPFy0Dwf/EZnLnExDDDzirPKj8qkcqWCfyWMTQMQ8M4+dKoLzsQMw2ZRt3tW2Uw3OEm
         KBWv5XzMlppB/jhmkqi7ZcNtRQmj23Zkqm68CbfLICPDG8eyY88wphTASvDVYmvBtUYT
         67SNW5S5ixBqPViYj3uMYueSm2pB+QTkqVWrneHmZoTNceKGLw8SJ0X1MduJG0k9FotZ
         GZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942231; x=1783547031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9ie3bzKgeyYiuFvUKcNeHB0MegGvZ6/Yth4SJ9PFQc=;
        b=RbK/d/1AG6DXnG7sxI9wG+H43BNcgGKiZUmIajIHHGqlE7L4oOcpIyB64AbkTB9XM5
         TUarkHhUxtBF22nPNp3LKH8DWi8jtXRmSnphUOlXP6TWKvQJ+Wd/MUntKE1YTfaPDcEH
         wY6Jlj5acP9IdkKFUwkW2wpZ5Ot72qL7IeQJkBxFB1XI1WE2oHj5Ahbp7fIwCpXhp6q6
         L5T6Nbf76XfpHVdaX8UZq1F5t58273rWIidDxbz+KMlWdZ4wUWWyBZYTBzzpsJNS7vvz
         RCL8HIU5CoRmQgh1ilIdm4/RU3ojSZtN6tP7wl5+1XlpiWdifBSEsbXavyp2/I9Pucmu
         PRkA==
X-Forwarded-Encrypted: i=1; AHgh+RodnpfoU0jdgmLSalR7ECeiG6zsTSEbACQryBiCZ3IGsUGoP8y1j8KFAIR3zVsGHd5aGdtkVAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkJ71qOsSIOpvyzlq/ACL65WyK8BetuQ9FtpqDRvAMm6yOIFO
	E9inQZBlXfxtoOyds3VtGKiIC+1x/OYHRs5Eq/krbcXXj3GFkwN5vkUVQ13+H0mOg1kx+GWBbB2
	V7rK9Fw==
X-Received: from plpl11.prod.google.com ([2002:a17:903:3dcb:b0:2b0:46bd:4fe5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240a:b0:2c6:c9de:cd0e
 with SMTP id d9443c01a7336-2ca7e75afccmr37696925ad.23.1782942231139; Wed, 01
 Jul 2026 14:43:51 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:48 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/14] bareudp: Support per-netns netdev unregistration.
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303848-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA1946F1E99

bareudp_exit_rtnl_net() iterates bareudp devices whose sockets
are in the dying netns and queues them for destruction.

So the devices may reside in different netns.

Let's use unregister_netdevice_queue_net() to support per-netns
device unregistration.

list_del() is changed to list_del_init() to avoid queueing the
same device twice.

Even after bareudp_exit_rtnl_net() queues a cross-netns bareudp
device, bareudp_dellink() could be called concurrently for it
(once RTNL is removed).  In such a case, __rtnl_net_unlock() will
perform the unregistration.

Note that bareudp uses register_pernet_subsys() instead of _device(),
so default_device_exit_batch() guarantees that the async per-netns
works are flushed before ->exit().

Tested:

1. Create bareudp device across two netns.

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add bareudp0 link-netns ns2 type bareudp \
    dstport 9292 ethertype ipv4

2. Run bpftrace to check that bareudp_uninit() is called between
   ->exit_rtnl() and ->exit().

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:bareudp_uninit {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }
  kprobe:bareudp_exit_rtnl_net,
  kprobe:bareudp_exit_net {
      printf("PID: %d%s\n", pid, kstack());
  }'

3. Remove the netns where the bareudp socket resides

  # ip netns del ns2

Now, we can see bareudp0 is unregistered by per-netns work
instead of cleanup_net() and it finishes before ->exit() to
avoid WARN_ON_ONCE(!list_empty(&gn->sock_list)) there.

  PID: 576
          bareudp_exit_rtnl_net+5
          ops_undo_list+702
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 470 | DEV: bareudp0
          bareudp_uninit+5
          unregister_netdevice_many_notify+7129
          unregister_netdevice_many_net+1050
          rtnl_net_work_func+136
          process_scheduled_works+2538
  ...
  PID: 576
          bareudp_exit_net+5
          ops_undo_list+1064
          cleanup_net+1122
          process_scheduled_works+2538

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bareudp.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 7dedf4867e7b..c3b5ed52d877 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -701,12 +701,13 @@ static int bareudp_link_config(struct net_device *dev,
 	return 0;
 }
 
-static void __bareudp_dellink(struct net_device *dev, struct list_head *head)
+static void __bareudp_dellink(struct net *net, struct net_device *dev,
+			      struct list_head *head)
 {
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 
-	list_del(&bareudp->next);
-	unregister_netdevice_queue(dev, head);
+	list_del_init(&bareudp->next);
+	unregister_netdevice_queue_net(net, dev, head);
 }
 
 static void bareudp_dellink(struct net_device *dev, struct list_head *head)
@@ -717,7 +718,8 @@ static void bareudp_dellink(struct net_device *dev, struct list_head *head)
 	bn = net_generic(bareudp->net, bareudp_net_id);
 
 	mutex_lock(&bn->lock);
-	__bareudp_dellink(dev, head);
+	if (!list_empty(&bareudp->next))
+		__bareudp_dellink(dev_net(dev), dev, head);
 	mutex_unlock(&bn->lock);
 }
 
@@ -811,14 +813,22 @@ static void __net_exit bareudp_exit_rtnl_net(struct net *net,
 	mutex_lock(&bn->lock);
 
 	list_for_each_entry_safe(bareudp, next, &bn->bareudp_list, next)
-		__bareudp_dellink(bareudp->dev, dev_kill_list);
+		__bareudp_dellink(net, bareudp->dev, dev_kill_list);
 
 	mutex_unlock(&bn->lock);
 }
 
+static void __net_exit bareudp_exit_net(struct net *net)
+{
+	struct bareudp_net *bn = net_generic(net, bareudp_net_id);
+
+	WARN_ON_ONCE(!list_empty(&bn->bareudp_list));
+}
+
 static struct pernet_operations bareudp_net_ops = {
 	.init = bareudp_init_net,
 	.exit_rtnl = bareudp_exit_rtnl_net,
+	.exit = bareudp_exit_net,
 	.id   = &bareudp_net_id,
 	.size = sizeof(struct bareudp_net),
 };
-- 
2.55.0.rc0.799.gd6f94ed593-goog


