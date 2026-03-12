Return-Path: <netdev+bounces-267057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ07Ey+7smmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:10:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF32724DE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D75930151D3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2523C660A;
	Thu, 12 Mar 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="cZDixCV2"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61C3C4576;
	Thu, 12 Mar 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320825; cv=none; b=cjC7itUZLY7S6xHE5INzNFdDtdHLZVDGiBqYTW1VkRCHqzvCoAO2kdijTSHYdZsgx9yDW8PaQzND5CsMMgy8iTWNBXhrpxC6N/6Whk4KkmzCM8MJgpnxABoSQUKO8f3AmrDNuYRTIyEakBZ+Olxt/MDfoEH57KsNKyB6bpM5gXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320825; c=relaxed/simple;
	bh=4HehsY8l5R7T57W9CPx8ozXdCfAAZac4RFP3cRM7vt8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzt5BeNWem3zxUv8lCgfxbt7TKy4lAbIr2RPXITODj1AoEsc5VP//yHp4LC75tbbe0sHXhW9RC808sHUw2UMr3AYSJvNaxAA477utm7o9xQmjdB4Fgu8b44FxOMyKEdskRmySs/RvnPvNz6yRQbf1lrQBm+VBjzIcbO0JBrw/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=cZDixCV2; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1773320811;
	bh=4HehsY8l5R7T57W9CPx8ozXdCfAAZac4RFP3cRM7vt8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=cZDixCV2TYkAFMMcNpHa2jbnbm8MATQ67xu5FTTVlt7dfxmQBNgMq2RWyohitk9Pj
	 73HV+SNUU2UGUi9LwVuQ4IbPR/3U3uPwYNz3GgtOzzBu7gafucjj/IeI6+puzzOXcH
	 92/mnTHNZmrNy/f7km9RMkaZWCJIcdJA8CxdpKBw=
Received: from simon-Latitude-5450.fritz.box ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62CD6mqj014094
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 14:06:51 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v8 2/4] vhost-net: wake queue of tun/tap after ptr_ring consume
Date: Thu, 12 Mar 2026 14:06:37 +0100
Message-ID: <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-267057-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:dkim,tu-dortmund.de:email,tu-dortmund.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EAF32724DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
function validates that the file belongs to a tun/tap device,
dereferences the tun_struct under RCU, and delegates to
__tun_wake_queue().

vhost_net_buf_produce() now calls tun_wake_queue() after a successful
batched consume of the ring to allow the netdev subqueue to be woken up.

Without the corresponding queue stopping (introduced in a subsequent
commit), this patch alone causes a slight throughput regression for a
tap+vhost-net setup sending to a qemu VM:
3.948 Mpps to 3.888 Mpps (-1.5%).

Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
threads, XDP drop program active in VM, pktgen sender; Avg over
20 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c      | 21 +++++++++++++++++++++
 drivers/vhost/net.c    | 15 +++++++++++----
 include/linux/if_tun.h |  3 +++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a82d665dab5f..b86582cc6cb6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3760,6 +3760,27 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
 }
 EXPORT_SYMBOL_GPL(tun_get_tx_ring);
 
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
index 80965181920c..c8ef804ef28c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -176,13 +176,19 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
 	return ret;
 }
 
-static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_produce(struct sock *sk,
+				 struct vhost_net_virtqueue *nvq)
 {
+	struct file *file = sk->sk_socket->file;
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	rxq->head = 0;
 	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
 					      VHOST_NET_BATCH);
+
+	if (rxq->tail)
+		tun_wake_queue(file);
+
 	return rxq->tail;
 }
 
@@ -209,14 +215,15 @@ static int vhost_net_buf_peek_len(void *ptr)
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
@@ -995,7 +1002,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
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


