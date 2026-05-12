Return-Path: <netdev+bounces-286994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA8vJPzgAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-286994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:12:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32D51C800
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A546303E4ED
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0648B369;
	Tue, 12 May 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6U/aOwq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s/8bvbAi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD847DFAA
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573268; cv=none; b=Q1i+pUYLDyIQjF1XO3dOIJiKUwOupt3RrH9Kft79o8Kw9gdFhFf6E2BYO83tYj0xfIyH/7IgTqsqmV48U46pVAhnVAYg6zrewd7OodGFmFralj5ngjuoRtXmky/HFoysJLizNtkh/ULtd7nniIVBZ4YNChwu0D3q30bRWnU4EUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573268; c=relaxed/simple;
	bh=sDobT2Y3suLHnIc3YUUU79mcvRr9manOsYeGpx1/XLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZbaRKeeLntHPIayVDjqCp+FP2Go80g0bslcoQwaTIelwW6hqYaSG24jrNxjugZh3pNXfrPEHR5mWLX9kbhiPPP3KzQQnwN3byl4XLkDRilFgkynfTPMiUBzBQHnE+FemF1t1raRTR3sssDgofHticVAbjJl5Y4UapRQte5UDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6U/aOwq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s/8bvbAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778573265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
	b=F6U/aOwq/o5UBrtbCcjZgZPeIftRpsiAmvgH9QFlYrTiq4o7Z+sA27LoxHg7pSFbEPvzim
	o2Y2pNPhEWlhuX2uX+uKqSUmDe1XjsPhUylqiKRQ64lQHVPcN4IhOsvfwvYk44PPtqI/By
	BzsvP/jbfcxaJAN2UfyVb8Fg3S6vHOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-591_zXLDPbassgfm4WyXWw-1; Tue, 12 May 2026 04:07:44 -0400
X-MC-Unique: 591_zXLDPbassgfm4WyXWw-1
X-Mimecast-MFC-AGG-ID: 591_zXLDPbassgfm4WyXWw_1778573262
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e79219704so15096785e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778573261; x=1779178061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
        b=s/8bvbAiTgWHzqMFzO5LCTsm4ttElr/944xDpNhCjj+PW1zi31G2o6J/esr5RcvYH7
         rJVR9yEHwd5cukHjZe97Xykb8aw9UPIAjB68EjhGH0H8+lxZHG4ZfPIZM6ZGG9ZRE0+d
         /f5DOzcR9xFFWHeCoMJM4Pi4Td95ezD7uE6QRahUaZQhpIZxouTZQG6z9DTAVsl7Mihz
         qDOs7kOBUvRAsk8sS8mIYOsuSzGCVcDM7fGVJXjfgWtA7bbySdkID9zXRo8jOv5vRhGB
         rqZQ78AjVCjAZBOhJeY6CZsswQmg5g7P/RN/aD3KGFt7kXd1gD2B35NqAfnT0TvP5/At
         JjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573261; x=1779178061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAlloYEZDF1UlqHHhoebVA5d4jsXxGoTRkEIcdVVNEs=;
        b=EUakMjfAH3BP+i2U3wLJs6tdglxtAtl5HWU6zsFIy9NBveTPP0D6rvgYmYin3zmwcJ
         KF4CD5WQIo9TKjo6S6jL3DQoJFH6zUYATu9C0PWDfVKi6d8bO6oIRRqcOffiD8n1y4gr
         OfjWQ5Ovh3lCuyStwvc/Vrgw7usjU7hLBDWBn+uvKY10nyli8B1nszwyphZmNKdAUeHZ
         C1IitK5qfOUKX+0T25GZISb6BjZQZ6gFQ0pk6gNBPRSQtYV51aS5XZIgqHybhjw32upK
         sJQb2KyhDDtmdmZyRUHbQMk+K2rKZ+pbxsQqkM48MSFMDIXlXwf93hknIkpKfWYG6Y9y
         sZCQ==
X-Gm-Message-State: AOJu0YxHK6t61Dh1+JYr8OfGZnt1djFp0O4X62gNTE2p7jA8joODJKLp
	/bOKHN44XI6u9HKVLNe7m5jXqc3ghOXRmaqk3KzAFs51gyHisamiEEn7DeHrGl5s/oKpDPxJpF9
	IhF1V8ZuSNyCcLJIrPruC2Se999AK4kKfdYa5vlmkSBcZQCc8pd/L5szP0Z+9e0L46dUocuIo1E
	E/C0c3y9GctR4kyQu9nI4q5rMiSqJJVYlmxzGGJoOAqg==
X-Gm-Gg: Acq92OHrjw+D237RSkhobekgPfgdd/9UBMLO5uI0OT+VNw3P2PKrl1ujMThvqcsmEDs
	B8/nTFybLM4I8Z/i6X1NDkXsSENaOtUqY8VSINuB3oihgzX8hiTJXpLtqM6yK8WI1qGuDlmD9tQ
	TEJEtoTXEcfkW1Ig/TWKqdTRApAKHALUwbaDZfC61kyU27LiSEK/h0dnETrCJ+fibegBwmmKoC6
	JvEIuUEX2Z3QlxkoME2ISo9z+t8gLSLBMBIV3L3FNCYqoT37yXMlmnaLKf0U5ZPP9dUQt6FaFEp
	VtfQynlXx4n91bgyr3PYmBDEzgppkd2Y2d011hvgtsYAahWDtazOc2q4uSa6da/+r17YebqbPOB
	7k0jBQoORKRQ3z/DLACPFky8H/3cNEy3qURdnBbbayXFBCmgdi1OH1RLKY8xe
X-Received: by 2002:a05:600c:83c5:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e8fe834f0mr28134035e9.28.1778573260850;
        Tue, 12 May 2026 01:07:40 -0700 (PDT)
X-Received: by 2002:a05:600c:83c5:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-48e8fe834f0mr28133145e9.28.1778573260301;
        Tue, 12 May 2026 01:07:40 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90677b04sm26948005e9.11.2026.05.12.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:07:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net v2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Tue, 12 May 2026 10:07:37 +0200
Message-ID: <20260512080737.36787-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA32D51C800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by using `buf_alloc * 2` as the total budget for payload plus
skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
is doubled to reserve space for sk_buff metadata. This preserves the
full buf_alloc for payload under normal operation, while still bounding
the skb queue growth.

When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
flooding where overhead dominates), the connection is reset and local
socket error set to ENOBUFS, so both peers are explicitly notified of
the failure rather than silently losing data.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

A solution to handle small-packet overhead efficiently also for
SEQPACKET (we already do that for STREAM) is planned as follow-up work.
This patch is needed in any case to prevent silent data loss, because
even if we reduce the overhead, we can't eliminate it entirely.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
---
 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..f23bf8a11319 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -449,7 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
 		return false;
 
 	vvs->rx_bytes += len;
@@ -1365,7 +1368,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1380,10 +1383,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1423,6 +1424,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1435,7 +1438,16 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0


