Return-Path: <netdev+bounces-155065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E800A00E2A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762B116424B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28B1FCF55;
	Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe0Ts7x8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6B1FCD16
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930801; cv=none; b=BLhpElNTUxacuW9sh42uvJl9qxkspErdHpSradHqUPpbnNKz+Jvj25hWD2VFZasvy24NjBLMiCvCsYPiY2Pu/FKFIbzaa+7SVARTv6HFZtAr8tRJ5HKCuePZPE4uhDn2lVdfG70tIWv4lQzudm74oO/qT0+GUHq2XAHO+fDX3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930801; c=relaxed/simple;
	bh=+QdaajbVH+JdcdBgna3omp4zm8NtLGUZk29mchUZBK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebpDqsSpzXZ8fB5KAbIq+a5jb7x9VebXU5ONM/1ZoXzi1Wmbo/8Qxa7KS8XRUVnhxRAzh6bMGuRfvcaOpOceV6iq+astDN8dtsPaOe7cuPC9MSsfFZQ70goZkZskTKNjWXEc/lTLMbTa0OwLhAVNHmuH4fErlrSBoF5m33BBumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe0Ts7x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C3C4CEDC;
	Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930801;
	bh=+QdaajbVH+JdcdBgna3omp4zm8NtLGUZk29mchUZBK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oe0Ts7x80G1j1O00E7OoH1YUDdJimoT0lMh5rZldDNWbuxI3/ogI7VgYjtQ77qoFn
	 qYbkciZ6xm5IU2TXs5I4OnjnMJEa7/6fseBIKOSjWubcIaO97nFOPiYpu2Ocauy0E6
	 niKI6Cfx6Ly8RaL0reWbrLZbjBx9gm/bwDti+HwoXqzqvRUQbc5cxb4HQXtRbO2p4I
	 1eF9y0Mfz0loE0M/DNDM7BrgUfHpo03x4Su2wJsSrl4smdqw2CjJSLsaSXmovdGJh8
	 BnbNONjlw0Cjh8doLFb3SIR4TOr1/gV7O/NQaQGtPJ0rrvdN7jzospvzFMkqkE7wP7
	 /CHRrL7AAISlg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/8] netdevsim: add queue alloc/free helpers
Date: Fri,  3 Jan 2025 10:59:50 -0800
Message-ID: <20250103185954.1236510-6-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need the code to allocate and free queues in the queue management
API, factor it out.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 35 +++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 7487697ac417..e1bd3c1563b7 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -595,6 +595,24 @@ static const struct netdev_stat_ops nsim_stat_ops = {
 	.get_base_stats		= nsim_get_base_stats,
 };
 
+static struct nsim_rq *nsim_queue_alloc(void)
+{
+	struct nsim_rq *rq;
+
+	rq = kzalloc(sizeof(*rq), GFP_KERNEL);
+	if (!rq)
+		return NULL;
+
+	skb_queue_head_init(&rq->skb_queue);
+	return rq;
+}
+
+static void nsim_queue_free(struct nsim_rq *rq)
+{
+	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
+	kfree(rq);
+}
+
 static ssize_t
 nsim_pp_hold_read(struct file *file, char __user *data,
 		  size_t count, loff_t *ppos)
@@ -683,11 +701,9 @@ static int nsim_queue_init(struct netdevsim *ns)
 		return -ENOMEM;
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-		ns->rq[i] = kzalloc(sizeof(**ns->rq), GFP_KERNEL);
+		ns->rq[i] = nsim_queue_alloc();
 		if (!ns->rq[i])
 			goto err_free_prev;
-
-		skb_queue_head_init(&ns->rq[i]->skb_queue);
 	}
 
 	return 0;
@@ -699,16 +715,13 @@ static int nsim_queue_init(struct netdevsim *ns)
 	return -ENOMEM;
 }
 
-static void nsim_queue_free(struct netdevsim *ns)
+static void nsim_queue_uninit(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
 	int i;
 
-	for (i = 0; i < dev->num_rx_queues; i++) {
-		skb_queue_purge_reason(&ns->rq[i]->skb_queue,
-				       SKB_DROP_REASON_QUEUE_PURGE);
-		kfree(ns->rq[i]);
-	}
+	for (i = 0; i < dev->num_rx_queues; i++)
+		nsim_queue_free(ns->rq[i]);
 
 	kvfree(ns->rq);
 	ns->rq = NULL;
@@ -754,7 +767,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	nsim_macsec_teardown(ns);
 	nsim_bpf_uninit(ns);
 err_rq_destroy:
-	nsim_queue_free(ns);
+	nsim_queue_uninit(ns);
 err_utn_destroy:
 	rtnl_unlock();
 	nsim_udp_tunnels_info_destroy(ns->netdev);
@@ -836,7 +849,7 @@ void nsim_destroy(struct netdevsim *ns)
 		nsim_macsec_teardown(ns);
 		nsim_ipsec_teardown(ns);
 		nsim_bpf_uninit(ns);
-		nsim_queue_free(ns);
+		nsim_queue_uninit(ns);
 	}
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
-- 
2.47.1


