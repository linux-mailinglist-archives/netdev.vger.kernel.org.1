Return-Path: <netdev+bounces-304311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yvZNKWn+RmpKgQsAu9opvQ
	(envelope-from <netdev+bounces-304311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B26FD8FD
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rr2eIAud;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304311-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB5E4306C5A1
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F84F1DE4E0;
	Fri,  3 Jul 2026 00:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7861B4257
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037421; cv=none; b=gkdBt8UOJgNqTIKqBQpkFKujPG6FU4d1Xi81FFDSWOccQU2+QiB2FWJA8w52hxzSA/Z7HA4TRr9RAnfBui8mObclepcJbPIMAF4MlYvau7YbxmVd6OG8LGO833sL2PKGhHzmZfjYmcoAt64BMNht3ZdymBp8jadtAozaLg+Q+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037421; c=relaxed/simple;
	bh=6Qnfrgbv7KXh2HMHAidWKSwAyG8o5pgznPDiRKEHaFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=doK4FLkXmD4iiW7F4CSECGqR6me8q8zwp2290oGXSmGxm4loTP6xM6KjG4gdEC9bYEy+IjR29gbmW6tU4BnI0ueYDqAJGlkjCpSMb5zHTUSySTqg9s7wZWcWefmthDWqRA+rgMKCcu7uVEnGEYRP1a0sSiAWRGKrfKYARgnKsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rr2eIAud; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca3b3141a6so36834065ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037419; x=1783642219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bbCoiH200ImqTG2L/RaaQA1CUH2TH1q+G0QxahDnEo=;
        b=rr2eIAudh5izDxwBEEIw2YUB/MC5PLBtH+L8aadpf3MbnMLaz9/suWFOYC7YJwJbXa
         C6Oh/56mdWDxpxVO7dbhi9KM1qk8wNM48V55x56mKblT3esQrUCXY2mMzkD5On41z5cf
         UWQjimOSueC7U9Hkpoo1szrCdT/PD7lDfA+pt3CYumiN9jhw03pKreU8DvdawYoCVG0H
         sS3JI7mmqURDi7RSmBr+xy94H49Mj2YllgOcppnn0ckDXj05UiWF7q/ZynX2MesAwtZU
         sFcGkiAhfWOeYzfHKJC/DQqrq+q2+y0SZgOlPh3u6ipj8HnepOiwKQaLbfrSb8t7IA7n
         UNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037419; x=1783642219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bbCoiH200ImqTG2L/RaaQA1CUH2TH1q+G0QxahDnEo=;
        b=NKF6dutAtCaIFMgOj0NW6PfyuFBOSaDBGBlEUFm3j+VL+AaIxSBfEF6kX2gLcsUIvU
         l6HyXnofM4YAJkTcj18WFXVkKtZlwlWlEyCyEcScaDAsWZeXQx/xPXnIB1xtS5U7xRbQ
         AXo82P9qDGjuwS6WZ0wMcn7ef3/Wz7BBYdutfQlS7k/+eRncvbZfaCrqN8N/QXpcep8q
         I5zRVDTJXcxH1Akb84B9vmZV2uQjkJrkyGOWsW6MnclMMb9052J0oNBo+T8tMTrDHMj+
         pnL5qWKsA7f16/NmHM9h8oe+7yp9Gg33LJsQ6n/vwj2DMulR8eBuL0FaLQBAd206XS+h
         27CA==
X-Forwarded-Encrypted: i=1; AHgh+RqvxRzldff4V0urlROQv+Vv0AKY2sBculoKZguRwLsiiQTQZzxJqoUFqFORWjB7vQUQSa1K66U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7lg+F4LwK1KE3JLsPXQtQucTESiAajnfO9fZTOC06fN/bsvs
	L1SxGkfbtr20KAdS8GAc6cw1Pb3bF0PEJd4GdEE/t3lqwOMSv23a2OwJ1LCfahU7OEXDIlhiDaU
	MWiWJ0g==
X-Received: from plez8.prod.google.com ([2002:a17:902:ccc8:b0:2c8:2489:8bfb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e746:b0:2c9:ed4a:c3a1
 with SMTP id d9443c01a7336-2ca7e6ff0b0mr93245375ad.19.1783037419288; Thu, 02
 Jul 2026 17:10:19 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:21 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/14] bareudp: Support per-netns netdev unregistration.
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
	TAGGED_FROM(0.00)[bounces-304311-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 149B26FD8FD

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
avoid WARN_ON_ONCE(!list_empty(&bn->bareudp_list)) there.

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


