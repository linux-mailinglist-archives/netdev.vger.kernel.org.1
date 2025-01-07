Return-Path: <netdev+bounces-155919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32EAA0459B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A4B3A5459
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394801F7082;
	Tue,  7 Jan 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnG+5x15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA41F707D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266137; cv=none; b=n69qDeRI0PuGLQ7xm3drAEpRxVCo6uysMec6kGKVROoemssighX4VnITElG0Ur+Ir2dot/IzbVaF+Q+bPL/sco1K2f0TDL4ZGA+WPfzS6a8f3YXl0GHoZpq0xfbRJcf6Fk5YB14mRnjRYcyWo7fHuMnGAURi8h3gQecZqsdmcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266137; c=relaxed/simple;
	bh=qGx0aw/odZyN/b9xh6MzszQDSlMt4TjTsIQxNXgaTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC6rDswmj9f81wccIRuDpRUZcpA5CvhDfvJu/fQRnS0urMUSMV8thCouxWQcH8vt3JbxD2HHETglvEZFPTAh/gG1IRp9800Esmat+aNuPTN6e10SihZwqParDDYMFVrDgQzyAeQVpjzjYIFU5O0TNIIwSA6gnJx9yPwJX+OxWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnG+5x15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47193C4CEDD;
	Tue,  7 Jan 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266136;
	bh=qGx0aw/odZyN/b9xh6MzszQDSlMt4TjTsIQxNXgaTjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnG+5x15XGSwWEqiBBMJebcBCdNUmtEGD+Zf9G1fLW2U9QUmDIjbsFSvzWYe7hc5O
	 Q/6/vPQUW2UjnW7HQDcp7VV86l89IjWA0Rz4qvE0wOXVte6304ev4nhQQDznGjEUoG
	 wJTvltNKnHwlMbI//7c/jjSzstKlcddg5ZE5VmJzxXOgdpHAiW1Vk3Ywd+Bv0BmSvV
	 5G9z3bo7U3JMw0g5QA0L5tvIXIaHo0Z1CR0htm1p1xTrgY9oAD3c1fpngLxWrxvWCd
	 UKlFQ4cxThGg0xvFV7GW0VwT3KEOfRM4IC3LeE76G1cCc26ljXWq86F4BZCFwD7BdI
	 riO622OCQawMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 5/8] netdevsim: add queue alloc/free helpers
Date: Tue,  7 Jan 2025 08:08:43 -0800
Message-ID: <20250107160846.2223263-6-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
References: <20250107160846.2223263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need the code to allocate and free queues in the queue management
API, factor it out.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 35 +++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 7fa75f37ec49..7b80796dbe26 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -595,6 +595,24 @@ static const struct netdev_stat_ops nsim_stat_ops = {
 	.get_base_stats		= nsim_get_base_stats,
 };
 
+static struct nsim_rq *nsim_queue_alloc(void)
+{
+	struct nsim_rq *rq;
+
+	rq = kzalloc(sizeof(*rq), GFP_KERNEL_ACCOUNT);
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
-		ns->rq[i] = kzalloc(sizeof(**ns->rq), GFP_KERNEL_ACCOUNT);
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
 
 	kfree(ns->rq);
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


