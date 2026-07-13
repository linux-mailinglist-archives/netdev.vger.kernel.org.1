Return-Path: <netdev+bounces-306993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pvqGIr86VGqCjgMAu9opvQ
	(envelope-from <netdev+bounces-306993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1857466BB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=G9XtzI6U;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306993-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306993-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D6D301FA66
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16652236F7;
	Mon, 13 Jul 2026 01:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9613B5B3
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904698; cv=none; b=qO0QruNlwOpDbmkpin5qKkc/P2OZs6cgptigVIwv3Umw5ncmTMiA/1doFIJhLAz/SHWTb0ZET0BmXkixyBXDw1CDcCs8YwQx83gUpFWyEoM+vMiAGR9wmCfEaYdC/3ASGIq1BUop5FkD1fsUr3lOBoLy9cBbqWtHeMP21j+1V3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904698; c=relaxed/simple;
	bh=iTHPamSiBY3jBfllXEs1sRn9a3ckxdyAZjH3R5RxF54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oko6NdsHl7IilYmz8lYKbV5hWC62icVyAleijHnA1pRi+vywUeSfauH17uKdKdQZeehZStWVlrfsfJqPpnItvEtnOlWWH9inMyx+IOLFFvANZVnmjAyoJMdMexksKP00oexVer5lf0Q5nBt4vpdaie4W6DO9AJfiA4tp6HzuuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G9XtzI6U; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/y
	vSVbotkRNh7nSkXJ+AsJ+r2WlT4jFGUJdUnZnNlqY=; b=G9XtzI6U1z1PlT2L7v
	ARaWvEXrLn2lViwJIIfNFUfXqdi2WS1TDMt0yHLQDajj6B3F7nDlfw5k55zLk7Kv
	xWgaKO0v8qTMUbMpgnMgFJ7HNzNFvPd/cAFl1to72IFdeWLxn/KPMQCYtMpHIvn7
	dmxo+GzsHmSgkx9RqthdbQ85E=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3FRWnOVRqoJfOGw--.61648S2;
	Mon, 13 Jul 2026 09:04:39 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	virtualization@vger.kernel.org,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost/net: Fill virtio_net_hdr GSO/csum metadata on RX
Date: Mon, 13 Jul 2026 09:04:42 +0800
Message-ID: <20260713010442.331109-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3FRWnOVRqoJfOGw--.61648S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1xXw43Wr1DGw4xWF1xKrg_yoW5Kr4fpF
	WYkFy8ur40gF4xtr18Ca93WFy5G3WkGFn3u39agFySkr98ury7XFW8Ka40gFZrtFWxCF1I
	vr1vq3W8Krn8urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9L0OUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QgosGpUOah3ogAA37
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:virtualization@vger.kernel.org,m:netdev@vger.kernel.org,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306993-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F1857466BB

From: xiongweimin <xiongweimin@kylinos.cn>

When VHOST_NET_F_VIRTIO_NET_HDR is set, vhost supplies virtio_net_hdr to
the guest but previously always wrote a zeroed header (GSO_NONE). Guests
that rely on GUEST_TSO*/GUEST_CSUM therefore never saw offload metadata.

Peek the socket skb before recvmsg and populate the header with
virtio_net_hdr_from_skb(). Also advertise the corresponding guest offload
feature bits from VHOST_GET_FEATURES.

TX TSO toward backends without IFF_VNET_HDR is intentionally left for a
follow-up series.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@vger.kernel.org
Cc: netdev@vger.kernel.org
---

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,10 @@
 	VHOST_FEATURES,
 	VHOST_NET_F_VIRTIO_NET_HDR,
 	VIRTIO_NET_F_MRG_RXBUF,
+	VIRTIO_NET_F_GUEST_CSUM,
+	VIRTIO_NET_F_GUEST_TSO4,
+	VIRTIO_NET_F_GUEST_TSO6,
+	VIRTIO_NET_F_GUEST_ECN,
 	VIRTIO_F_ACCESS_PLATFORM,
 	VIRTIO_F_RING_RESET,
 	VIRTIO_F_IN_ORDER,
@@ -644,7 +648,7 @@
 static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 			    size_t hdr_size, int out)
 {
-	/* Skip header. TODO: support TSO. */
+	/* Skip guest virtio_net_hdr; TX TSO handled in a follow-up. */
 	size_t len = iov_length(vq->iov, out);
 
 	iov_iter_init(iter, ITER_SOURCE, vq->iov, out, len);
@@ -1025,6 +1029,35 @@
 	return len;
 }
 
+/*
+ * When VHOST_NET_F_VIRTIO_NET_HDR is set, vhost supplies virtio_net_hdr.
+ * Populate GSO/checksum metadata from the socket skb so guests that
+ * negotiated GUEST_TSO*/GUEST_CSUM receive correct offload information.
+ */
+static int vhost_net_hdr_from_sock(struct vhost_virtqueue *vq, struct sock *sk,
+				   struct virtio_net_hdr *hdr)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+	int vlan_hlen = 0;
+	int ret;
+
+	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (!skb) {
+		spin_unlock_irqrestore(&sk->sk_receive_queue.lock, flags);
+		memset(hdr, 0, sizeof(*hdr));
+		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
+		return 0;
+	}
+	if (skb_vlan_tag_present(skb))
+		vlan_hlen = VLAN_HLEN;
+	ret = virtio_net_hdr_from_skb(skb, hdr, vhost_is_little_endian(vq),
+				      true, vlan_hlen);
+	spin_unlock_irqrestore(&sk->sk_receive_queue.lock, flags);
+	return ret;
+}
+
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 				      bool *busyloop_intr, unsigned int *count)
 {
@@ -1239,10 +1272,18 @@
 		/* We don't need to be notified again. */
 		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
-		if (unlikely((vhost_hlen))) {
-			/* We will supply the header ourselves
-			 * TODO: support TSO.
+		if (unlikely(vhost_hlen)) {
+			/*
+			 * Build virtio_net_hdr from the socket skb before
+			 * recvmsg consumes it. Skip for ptr_ring backends
+			 * where the skb is not on sk_receive_queue.
 			 */
+			if (!nvq->rx_ring &&
+			    vhost_net_hdr_from_sock(vq, sock->sk, &hdr)) {
+				vq_err(vq, "Failed to build vnet_hdr from skb\n");
+				vhost_discard_vq_desc(vq, headcount, ndesc);
+				continue;
+			}
 			iov_iter_advance(&msg.msg_iter, vhost_hlen);
 		}
 		err = sock->ops->recvmsg(sock, &msg,
@@ -1270,7 +1311,6 @@
 			 */
 			iov_iter_advance(&fixup, sizeof(hdr));
 		}
-		/* TODO: Should check and handle checksum. */
 
 		num_buffers = cpu_to_vhost16(vq, headcount);
 		if (likely(set_num_buffers) &&


