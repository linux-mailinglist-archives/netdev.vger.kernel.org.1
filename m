Return-Path: <netdev+bounces-285731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IHTNiWs/WlOhgAAu9opvQ
	(envelope-from <netdev+bounces-285731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:25:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0474F438C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6AFF301B92F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A23A5E72;
	Fri,  8 May 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA9MgCT/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAqbmb3N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAB330B0B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232219; cv=none; b=nRaKWkTYS9DSVGzeGIZBF8y8RRgWtsjQGjSZjw6LcHvLgrR/LmSgVQ1vwAdB1bCCe6mKxWrlSZiIF4pRmte+MC+oKoh3HYEchrrxv9rHflnKuIr3q8Ns2c16o0gMOABriA5iwasvA8z+7Y5Li0Z3AzvPSFn1anlL00TTf4pokD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232219; c=relaxed/simple;
	bh=8LRSStW2VoNApjyq7vcaSmNuz5Qon/i9zONda+7Hib4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezmzcjh75s81nZsBo3jRKyItFm0uphNaDyVIGZqY3rUX1+EDSc3qU7Dgkz8lDpAU+bj2Euv+qWAwWWup+dr162DZMRkLoQZQ8sUQqK0Dv9nM5oTjaPoAuA+0Ujzr91UJ/6w3roep53LDjf0g/CdUtKFTvSGIaAwRVSUMbLF1DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VA9MgCT/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAqbmb3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778232217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
	b=VA9MgCT/MddZWIkTdUWEFXfJh77UHKGTd3W27skke4mHzQ2K+eFEsauFrjQRWz7rq1EN3K
	rwDw953SWdmLldrNiiXkeqf5JL0dojkzf3KCr3pIG0MlrKyFvIPC6de8hM9/d+WHWxJf98
	6HBsxnlUfkCXNZZrBND1nzx6+4MS/cs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-hrJAna32PW6mGQF__ifq5w-1; Fri, 08 May 2026 05:23:35 -0400
X-MC-Unique: hrJAna32PW6mGQF__ifq5w-1
X-Mimecast-MFC-AGG-ID: hrJAna32PW6mGQF__ifq5w_1778232214
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so8899515e9.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778232214; x=1778837014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
        b=UAqbmb3NgLhlHhVv3Z0Df0HK4c9rBMSAhrI9whilxC3PoVFNLGV3tSX8ZrvsQ7vJfV
         eZywgp6eEEczuTSwHicHvJOzAADY1qpFZi8NWd0UJMmSwG163YEnWvqYRjjP1O1BwNiG
         JCc/4BbtHCuWTzYXpmYGq4/wx2dKDG9+3fZOdJtQeO3iYPEDK5YC5g9Sl3qWp12HBmwk
         wZMbPe3brllIh96BGPz+0ePNdhgQQQNzjKGHZTHpXf+Inl/LLoKsBLiFaEyAUeu0+L+k
         UZvdcuTzb9EI+V2tCOP8lwNB1ulMe6TLeJAp+pnLQM5dimSU55VuBYZ/fQT/tgd5HnLV
         z68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232214; x=1778837014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yASdWjRr9O1Fv1pSyMZ8vcPjBnLsiRkgqyUNKE6lF10=;
        b=fo6ZS5Prtj+LVl/d27XX81wii4bSiQ6zr1o+GuCFlSPR++pm/cK1VbWmLF6tBSYZhl
         eMnN6xuWwnd0Sd4l/3LrbME71nnR3yALP8Ov/buIs5qZooGcLtO3KLK0QjiwnibtSlqc
         7nCI9HmuOvushDhPJ2m27Ednyo6Yay5OF2liRTswNWPyDa5Yms5ZEJ3t5avpARGy6xmj
         0NHjabhe9sqPKkmMLxqx8p1BloVFnFCL7YfoI4eT1TBaNyy8U+u3Xl/aSIqKFq9Dyhlc
         Ifa5dYJZ2W5MkOSSAPLdMopFiy38XPVVbcisLh9ftPOpWXmygJ1HfGqelTlvLfhU8axw
         odhg==
X-Gm-Message-State: AOJu0YzrZrGdoRsJGP4gBMvZMdqtGAvUgjjXm/Yz5eUDTt66HTBprTs5
	akNzV4ga6WUdaADxl2nOT0K2/NOp7xq0fupbAydtruu5UUUvCpvlMRu3G+XOKxSqtKwZsvSZUFx
	Htig4aYST7YWM1sUu1wit3vhK0cP4HFITP+Cva8MYpWAHmDuvzi2BAwxAdEemsxiR/Kz4WZ66CB
	x19sK6sGvqbdJgNBMuBU/w5qWVZW5E2VNHJeW+RRkVRw==
X-Gm-Gg: AeBDieuXAbROzBEOqItlNYpPzwKhBCuB8bHjFohl6E+o/ewOAxmgWMD+NUNfMo48Tlg
	e7OCBsqDqAstYWUoIUgRKEJCwn4Abm2g1QtSB5vUYur5g9+E5NHXwF35q9lLlSx9TMrirMV1lrD
	LtP3D60SEiGeSUrGba+AkuKmbvMM0dypZag+kf8hDzaQSU5IEa0umVEQOthTSAR2j95t3T2e1He
	DtDhmKmupzj52yZ8lTo9L9Xe13ECP39uSTzp9sSbJlx+YbeFu1jAKY6WVa+jIsHCjMm3cLlidAp
	68Q/X9EWuhj5dK2IDtX2lz3AIZ/iprZewXmW7TDccO1tY6wkLufGPUl7duXnaaRVNcNOJrjJDRt
	qtjvS4hV9onYLYrhv3p6RRK2c7efrdr5G8sa5Oozz89s+Ip3uRs5A0B1q4tQApwUG+A==
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr92547005e9.9.1778232213924;
        Fri, 08 May 2026 02:23:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e5dffabcamr92546285e9.9.1778232213361;
        Fri, 08 May 2026 02:23:33 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642e5805sm15776295e9.7.2026.05.08.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:23:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Fri,  8 May 2026 11:23:30 +0200
Message-ID: <20260508092330.69690-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D0474F438C
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
	TAGGED_FROM(0.00)[bounces-285731-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
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

This also causes failures in tools/testing/vsock/vsock_test.c.
Test 18 sometimes fails, while test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by introducing virtio_transport_rx_buf_size() to calculate the
size of the RX buffer based on the overhead. Using it in the acceptance
check, the advertised buf_alloc, and the credit update decision.
Use buf_alloc * 2 as total budget (payload + overhead), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
The function returns buf_alloc as long as overhead fits within the
reservation, then gradually reduces toward 0 as overhead exceeds
buf_alloc (e.g. under small-packet flooding), informing the peer to
slow down.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..94a4beb8fd61 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	return ret;
 }
 
+/* vvs->rx_lock held by the caller */
+static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
+{
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	u64 total_budget = (u64)vvs->buf_alloc * 2;
+
+	/* Overhead within buf_alloc: full buf_alloc available for payload */
+	if (skb_overhead < vvs->buf_alloc)
+		return vvs->buf_alloc;
+
+	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
+	if (skb_overhead < total_budget)
+		return total_budget - skb_overhead;
+
+	return 0;
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
 		return false;
 
 	vvs->rx_bytes += len;
@@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
 	spin_lock_bh(&vvs->rx_lock);
 	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
-	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
+	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
 	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
@@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	bool low_rx_bytes;
 	int err = -EFAULT;
 	size_t total = 0;
+	u32 rx_buf_size;
 	u32 free_space;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
-	free_space = vvs->buf_alloc - fwd_cnt_delta;
+	rx_buf_size = virtio_transport_rx_buf_size(vvs);
+	free_space = rx_buf_size > fwd_cnt_delta ?
+		     rx_buf_size - fwd_cnt_delta : 0;
 	low_rx_bytes = (vvs->rx_bytes <
 			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
 
-- 
2.54.0


