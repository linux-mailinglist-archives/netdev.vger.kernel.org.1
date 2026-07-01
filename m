Return-Path: <netdev+bounces-303847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AJe4KjCKRWrZBgsAu9opvQ
	(envelope-from <netdev+bounces-303847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2395F6F1EB8
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uXz9zro5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303847-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA687300D17A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456023BBFC4;
	Wed,  1 Jul 2026 21:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CEF3BB11D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942233; cv=none; b=aAcDL7wHFLYCiok9rgJk2Q1Q8yyz2VfdMtO1PVsYlO1X60GBSKy1mS6/2VFp1pSroJzMi5qBons4qpn+HvxkwpK1jfN2JD6MCx2Jc7juO3ELB3urhLbDE+aoY1cyvaqsDMMFO66u76hSgBkOSAEW6AW1yzlxPvU0oVEVjEIBiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942233; c=relaxed/simple;
	bh=m+26+mhYbngzVvwljCrfF+totBfayLKfacbQ4yJyHyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmMzgFqwvN1Sz1136DeXAT3xx4fHUVgC5H+Jptb7QuKJ4fxST9VsnbVup22vGynZB9LMUo/euDklAN+t7vNQOwcVZwdOUtlOrxrRpIBWzC6cQqOsTJZ8pilv62wxymUzYYy2YYvTXoo8Uq/mo7GCEZmFIvjvVePnEBVlJs6PI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uXz9zro5; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c80be91ea3so22194545ad.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942230; x=1783547030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Am3hdWBm3fjQqJl/GcjuCawMjEOMQ9wJEeWwevCk0Yk=;
        b=uXz9zro5QamqqJXPgCDqgXQCr0VvrFsyHBIW6tx5nfT/+fpLNNnwb9hpRlutduJjAg
         RUSFf82fcSDTJ8eQFSoX06Ct2cSWmuQqnaaJnncv02WNb41VGFme5FLT6bpEbtIMPfLm
         IVj+L1eCxUXvpfr1qKIOes6LJUCR6FwFRzAlfD3ECQ6ogEbCXpLMEavLr8cFTmwddxGg
         kaYqTV8V7++qv0p2ckMAl7Z/YLWLH3YtXyGMht7tkvkJLFneuyWw+twiABmOMVgqoxjZ
         Ropjfp4dGB7YpShQobGBxdmRkL5z5zHC67gZO0aFmz0VBTJSLgLfOUhSL3lNoTwMFcVP
         k9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942230; x=1783547030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Am3hdWBm3fjQqJl/GcjuCawMjEOMQ9wJEeWwevCk0Yk=;
        b=SQhz5vwUz04Gko/5jx+kvD4ilZmWq235SY37vRELOVQzGbKTxUNmFAXT2HqKU97qCo
         ZiXku/uX3oLn45WV6V9dxvMNzIl2UhPwPNA4wNkaYU4xSJspMCK2+CrGCsp9ThTVjaMm
         AGO1o4ik0ajfE5MFt8jSlbEFuD9lKVmYm8DTQjAJRAeM20hF20tPq3/ckgXVI6m0ngC2
         /iOyzVu/wQ8RXTpjFYDK2IbuvsrfZOXMJyjuUPvw7fkuDzXaiF6A5ucEUHLzkmxbcQRu
         2KtgCrrN9n7txdWaNPLAzn1gntZarW25jkpgkNbnEPzIqDfWLOgP2ewEJenahqSsyGbq
         50tA==
X-Forwarded-Encrypted: i=1; AFNElJ8xXd1FPszAIdpsiJKxaNv97HRO3YMMBgNnfMOZV0HfROgKpssH4CbH73zjZqw380eMY8y+CBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8ZOPgEeKFE727oP++jRItZaa3Ce4CmouuZl2qfcRA4/KPBfQ
	8eT0dliyVPYUXU8mzq9wVjigQx4pJsz3o9LyMw+TRTKJtEVMa9Y/+zY4ThvJrHoDvpnGRav5an6
	jmhVCQQ==
X-Received: from pggh23.prod.google.com ([2002:a63:c017:0:b0:c8b:2f5f:81a4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2211:b0:3b4:65ac:e2e3
 with SMTP id adf61e73a8af0-3bfed11e0d6mr3946154637.5.1782942229507; Wed, 01
 Jul 2026 14:43:49 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:46 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/14] veth: Support per-netns device unregistration.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303847-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2395F6F1EB8

Currently, veth_dellink() unregisters both local and peer devices
synchronously under RTNL.

Once RTNL is removed, it can be called concurrently from different
netns.

Let's use xchg() and unregister_netdevice_queue_net() to support
per-netns device unregistration.

This way, each device is queued for destruction only once by
the winner of the race.

Note that the extra netdev_hold() ensures that @peer obtained by
the first xchg() is not freed during the subsequent access to
netdev_priv(peer).  The 2nd xchg() overwrites @dev to balance
the refcount.

Tested:

1. Create two veth pairs (veth1-2, veth3-4) between two netns
   (ns1 & ns2).

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add veth1 type veth peer veth2 netns ns2
  # ip -n ns1 link add veth3 type veth peer veth4 netns ns2

2. Run bpftrace to check if the same process does NOT
   unregister the paired veth devices

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

3. Remove veth2 in ns2 and check bpftrace output

  # ip -n ns2 link del veth2

  PID: 2194 | DEV: veth2
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
  ...
  PID: 448 | DEV: veth1
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...

4. Remove ns2 (thus veth4) and check bpftrace output

  # ip netns del ns2

  PID: 571 | DEV: veth4
          free_netdev+5
          netdev_run_todo+4798
          default_device_exit_batch+2271
          ops_undo_list+993
          cleanup_net+1122
          process_scheduled_works+2538
  ...
  PID: 441 | DEV: veth3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/veth.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..8170bf33ccf9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -77,6 +77,7 @@ struct veth_priv {
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
 	unsigned int		requested_headroom;
+	netdevice_tracker	peer_tracker;
 };
 
 struct veth_xdp_tx_bq {
@@ -1901,15 +1902,17 @@ static int veth_newlink(struct net_device *dev,
 
 	priv = netdev_priv(dev);
 	rcu_assign_pointer(priv->peer, peer);
+	netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);
 	err = veth_init_queues(dev, tb);
 	if (err)
 		goto err_queues;
 
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
+	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
 	err = veth_init_queues(peer, tb);
 	if (err)
-		goto err_queues;
+		goto err_peer_queues;
 
 	veth_disable_gro(dev);
 	/* update XDP supported features */
@@ -1918,7 +1921,11 @@ static int veth_newlink(struct net_device *dev,
 
 	return 0;
 
+err_peer_queues:
+	netdev_put(dev, &priv->peer_tracker);
+	priv = netdev_priv(dev);
 err_queues:
+	netdev_put(peer, &priv->peer_tracker);
 	unregister_netdevice(dev);
 err_register_dev:
 	/* nothing to do */
@@ -1933,24 +1940,25 @@ static int veth_newlink(struct net_device *dev,
 
 static void veth_dellink(struct net_device *dev, struct list_head *head)
 {
-	struct veth_priv *priv;
+	netdevice_tracker *peer_tracker;
 	struct net_device *peer;
+	struct veth_priv *priv;
 
 	priv = netdev_priv(dev);
-	peer = rtnl_dereference(priv->peer);
+	peer_tracker = &priv->peer_tracker;
+	peer = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (!peer)
+		return;
 
-	/* Note : dellink() is called from default_device_exit_batch(),
-	 * before a rcu_synchronize() point. The devices are guaranteed
-	 * not being freed before one RCU grace period.
-	 */
-	RCU_INIT_POINTER(priv->peer, NULL);
 	unregister_netdevice_queue(dev, head);
 
-	if (peer) {
-		priv = netdev_priv(peer);
-		RCU_INIT_POINTER(priv->peer, NULL);
-		unregister_netdevice_queue(peer, head);
-	}
+	priv = netdev_priv(peer);
+	dev = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (dev)
+		unregister_netdevice_queue_net(dev_net(dev), peer, head);
+
+	netdev_put(peer, peer_tracker);
+	netdev_put(dev, &priv->peer_tracker);
 }
 
 static const struct nla_policy veth_policy[VETH_INFO_MAX + 1] = {
-- 
2.55.0.rc0.799.gd6f94ed593-goog


