Return-Path: <netdev+bounces-281844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPURIRGr8GnOWwEAu9opvQ
	(envelope-from <netdev+bounces-281844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FE3484FE4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B33B83004D2A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF443D4E3;
	Tue, 28 Apr 2026 12:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48143C065;
	Tue, 28 Apr 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380089; cv=none; b=uerUCRVF22tq1p0//59U0L+8Tjf4KOivrEJe8OtdoJU1NuGg8+o/p+WBXxVRf/OAGANk+HvSPTyRxRJQM8WI/OhYhDu+ysD806rWE9Gh6pYXc8Wg2gKHJ6gwYuV1COOG6JzQSyD2mZ8Yw2y+079is8bNodjIBvxrX8GkLEhuZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380089; c=relaxed/simple;
	bh=wWwcAX52K+9LZxkXR5J5Jxga0UfSYQEUweUXrWXOpEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5Ad1pOUkd2mphs4qNCQLZ6u/9J/DVEdZItcZx94xMocy7DNlrgDuUccChLmifISe+X4fZA1grPzwaYHGw6b2FrC/IVdLgrXkfDGJt1CmZbTO55KK0ESf74P3lQrqDr+sUZp+5Snf14xaFOzkKNRSd7H4jpYjJcDQRm82ky2os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.62])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 63SCewwi012433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 14:41:00 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v9 2/4] vhost-net: wake queue of tun/tap after ptr_ring consume
Date: Tue, 28 Apr 2026 14:38:57 +0200
Message-ID: <20260428123859.19578-3-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50FE3484FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[tu-dortmund.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281844-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.761];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tu-dortmund.de:mid,tu-dortmund.de:email]

Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
function validates that the file belongs to a tun/tap device,
dereferences the tun_struct under RCU, and delegates to
__tun_wake_queue().

vhost_net_buf_produce() now calls tun_wake_queue() after a successful
batched consume of the ring to allow the netdev subqueue to be woken up.
The point is to allow the queue to be stopped when it gets full, which
is required for traffic shaping - implemented by the following
"avoid ptr_ring tail-drop when a qdisc is present".

Without the corresponding queue stopping, this patch alone causes no
throughput regression for a tap+vhost-net setup sending to a qemu VM:
3.858 Mpps to 3.898 Mpps.

Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
threads, XDP drop program active in VM, pktgen sender; Avg over
50 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c      | 22 ++++++++++++++++++++++
 drivers/vhost/net.c    | 21 +++++++++++++++------
 include/linux/if_tun.h |  3 +++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e6ee2271732f..efe809597622 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3765,6 +3765,28 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
 }
 EXPORT_SYMBOL_GPL(tun_get_tx_ring);
 
+/* Callers must hold ring.consumer_lock */
+void tun_wake_queue(struct file *file)
+{
+	struct tun_file *tfile;
+	struct tun_struct *tun;
+
+	if (file->f_op != &tun_fops)
+		return;
+	tfile = file->private_data;
+	if (!tfile)
+		return;
+
+	rcu_read_lock();
+
+	tun = rcu_dereference(tfile->tun);
+	if (tun)
+		__tun_wake_queue(tun, tfile);
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(tun_wake_queue);
+
 module_init(tun_init);
 module_exit(tun_cleanup);
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 80965181920c..7fba518ac3cd 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -176,13 +176,21 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
 	return ret;
 }
 
-static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_produce(struct sock *sk,
+				 struct vhost_net_virtqueue *nvq)
 {
+	struct file *file = sk->sk_socket->file;
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	rxq->head = 0;
-	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
-					      VHOST_NET_BATCH);
+	spin_lock(&nvq->rx_ring->consumer_lock);
+	rxq->tail = __ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
+					       VHOST_NET_BATCH);
+
+	if (rxq->tail)
+		tun_wake_queue(file);
+
+	spin_unlock(&nvq->rx_ring->consumer_lock);
 	return rxq->tail;
 }
 
@@ -209,14 +217,15 @@ static int vhost_net_buf_peek_len(void *ptr)
 	return __skb_array_len_with_tag(ptr);
 }
 
-static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_peek(struct sock *sk,
+			      struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	if (!vhost_net_buf_is_empty(rxq))
 		goto out;
 
-	if (!vhost_net_buf_produce(nvq))
+	if (!vhost_net_buf_produce(sk, nvq))
 		return 0;
 
 out:
@@ -995,7 +1004,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 	unsigned long flags;
 
 	if (rvq->rx_ring)
-		return vhost_net_buf_peek(rvq);
+		return vhost_net_buf_peek(sk, rvq);
 
 	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
 	head = skb_peek(&sk->sk_receive_queue);
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 80166eb62f41..ab3b4ebca059 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -22,6 +22,7 @@ struct tun_msg_ctl {
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
+void tun_wake_queue(struct file *file);
 
 static inline bool tun_is_xdp_frame(void *ptr)
 {
@@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
 	return ERR_PTR(-EINVAL);
 }
 
+static inline void tun_wake_queue(struct file *f) {}
+
 static inline bool tun_is_xdp_frame(void *ptr)
 {
 	return false;
-- 
2.43.0


