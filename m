Return-Path: <netdev+bounces-285931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEOULKET/mnZmgAAu9opvQ
	(envelope-from <netdev+bounces-285931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:47:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0C4F9912
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E1630916D9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5F413254;
	Fri,  8 May 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsFujt20";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDjXC8Xv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D441322B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258674; cv=none; b=gtUNQ3GM27I32/JpFTNH9rJXAZk1pmdPIObNlZ8TYZ/gDA0xT2PstHVIOrQJSSLXhJ6hwOn18mQP6tDwh3tJieBtuo4GPbmvX6P8eUuPZlxZeYU+DX5ISdfWPmDjzw5XbFp/KQtoqgc2BRpAuAV72RbselyqWthVTu4LOn7efYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258674; c=relaxed/simple;
	bh=nI6jWfcws3jDGKtVHmRZ+UhUUSG86pLokLto4S1xK2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvoAd6GWpi9xwBCkLCkAwfOm5Dbr7O/OcLn5ML6IYqNYMiA2GAz12CQC90xYNrtlrW7YzxPj0wWoJ2h/a1/EJ4qMqus+43m88VmFRoJUfT5h509XTqju/PEm4FjNZU4YIVGnm4IZsZLScZpqJOMzEUsb+62RlOubRKefe84MKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsFujt20; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDjXC8Xv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
	b=RsFujt20wp+kqPUoUZjtsgtLOQND+2+clsC1kFkY5lY7QgdZx1zR2n98PoDn191koypZK/
	VYxgj//VPe4YgodGG+vvU07+6ocuWxSGgcpbdJdFfxFIqktUV1XFULhYps5XAuMAN/i3kG
	EYojnnFvrfe9lhCbg+IcepUXiZvwuSA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-_GmVr_xYMXiwUnnOw4unVw-1; Fri, 08 May 2026 12:44:29 -0400
X-MC-Unique: _GmVr_xYMXiwUnnOw4unVw-1
X-Mimecast-MFC-AGG-ID: _GmVr_xYMXiwUnnOw4unVw_1778258668
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso1905558f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258667; x=1778863467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
        b=dDjXC8XvBEQGULjH6G0MmkOHxxPvLx+3PBfZt2Sk56dvFsJLb8v9GCgEmLK/1JrkCz
         F56nVsyU9+FZ+L1WcUyZz9VksSZ1itXkXo56DrcBnKNxDQUtTZJzAAo6RJb7f+iaq0Kj
         bWT9/J852PhyXVkL4jqFYlltcU4fCMGGRb2qfxxm73iOTHhGRNlKTZ2pogFIV7tIUsXB
         NKZxHh3qxUQar9DCIKPc8HC2k4Gb/69fb8MvNx96FNp5c8J0O5aNramQgtqBko4iaOJG
         lWJ1LtuB7IXW+jnBfXCZssmZ01NZXn1nVNzRQWN/8x4sf2y1D1sshzwNXno60a/nIMVG
         c7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258667; x=1778863467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SGD4ybYlVxcQvNSSgCT46FZDKdy4y6czHmnn+pucYo=;
        b=SznhT8W5GD90qcmaE9L9XlFtXuRBHThMTaacUy6dNUx2jPOGy7LnWuRDmfYrDe1YqU
         GqTt/9GQQ8em+F9xmQTao/JE5qrdOorVZtyM+/GU5x2hf3/Gl6g9TorzVc1kT3Vl735e
         +jVIKkei9Oydbo0EEeNTpGIxKHaoxgVdU0loUekKPAHcYszWZBus4zcSSwLOYiSqQEa8
         0tQvZPEu9AQYirbH7+v90KApKoiaPiL4W7z22kmnW4nhYrTUVw53PUxSqzUNzAi65sDW
         eYrLz4IICRYekhCy288vAk4cTciHo7FnzLcEFtXQaYjX7EsspYURjYDTNEisC4fwLhsc
         P2EQ==
X-Gm-Message-State: AOJu0YxTshIYr7DL1EinAW4NdNGMJAJA5Kr0+ogrAauPrH41zpbVrux7
	ylTWUWixfnm/Gfh9ZhSCoWM2ZlY9cZ8pVMsrfLLIAGYwDE6g5B6CDJAbLRfK+Fg9mImUTWhIzuh
	p8Z8yVnr9rGMN+bmuSnQzFVp1gAmjKfcuXPCYTMjIb9yUo5nzR3gQ9qAOJ1LYa5xWn4JYYfdrcF
	yChmpMrVFF+DzOD5Njt22GEPjimwB522xsMXIeCWS1eQ==
X-Gm-Gg: Acq92OH70VjQMfmVZf2Bhe66QdrFeCMkyW7H30TOA12p6nzyM6UsGSlYdndLZs9nXor
	/UPUaQujLR/Iuj3yAXpa7Nk16/e7uvMiJlNnXkd2XZLJQpDPL4WmmhoLjA/DXAIhMHx2RcfkKEM
	CZDiu806624uEwb+4qdS88M2vwL2Gk5uD6aUlBXt5sjvnpPDhVs3io8FgVrYqR+s06Nx+BH+CCB
	wm+VhI1ko5LCzU7vNXJBoXJpJkmH/vAXCkuz7/w11wMWlV/2yqpdcfpLoWAqsouULdKvEUv3XYL
	Cjfslyrz9Mq86MdE+oqrKt9fGkdoO2fmsP3bIShxqjn7k0Yng0FpOwrtaFF5GhzxMcSNrCaxdTX
	8h8eD0+PsOgvby5sEbTQLQKv6M306CuUPIvURvBINFFzo8H8nNGKqlhb7S2nMU5BRQA==
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4515d3dc343mr20223813f8f.31.1778258666338;
        Fri, 08 May 2026 09:44:26 -0700 (PDT)
X-Received: by 2002:a5d:5d08:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4515d3dc343mr20223444f8f.31.1778258662937;
        Fri, 08 May 2026 09:44:22 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm5572801f8f.8.2026.05.08.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:22 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 2/2] vsock/virtio: fix empty payload in tap skb for non-linear buffers
Date: Fri,  8 May 2026 18:44:11 +0200
Message-ID: <20260508164411.261440-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CC0C4F9912
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,linux.alibaba.com,kernel.org,meta.com,davemloft.net,lists.linux.dev,google.com,salutedevices.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-285931-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

For non-linear skbs, virtio_transport_build_skb() goes through
virtio_transport_copy_nonlinear_skb() to copy the original payload
in the new skb to be delivered to the vsockmon tap device.
This manually initializes an iov_iter but does not set iov_iter.count.
Since the iov_iter is zero-initialized, the copy length is zero and no
payload is actually copied to the monitor interface, leaving data
un-initialized.

Fix this by removing the linear vs non-linear split and using
skb_copy_datagram_iter() with iov_iter_kvec() for all cases, as
vhost-vsock already does. This handles both linear and non-linear skbs,
properly initializes the iov_iter, and removes the now unused
virtio_transport_copy_nonlinear_skb().

While touching this code, let's also check the return value of
skb_copy_datagram_iter(), even though it's unlikely to fail.

Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
Reported-by: Yiqi Sun <sunyiqixm@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 40 ++++++++-----------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a678d5d75704..989cc252d3d3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -136,27 +136,6 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
 	hdr->fwd_cnt	= cpu_to_le32(0);
 }
 
-static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
-						void *dst,
-						size_t len)
-{
-	struct iov_iter iov_iter = { 0 };
-	struct kvec kvec;
-	size_t to_copy;
-
-	kvec.iov_base = dst;
-	kvec.iov_len = len;
-
-	iov_iter.iter_type = ITER_KVEC;
-	iov_iter.kvec = &kvec;
-	iov_iter.nr_segs = 1;
-
-	to_copy = min_t(size_t, len, skb->len);
-
-	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
-			       &iov_iter, to_copy);
-}
-
 /* Packet capture */
 static struct sk_buff *virtio_transport_build_skb(void *opaque)
 {
@@ -214,13 +193,18 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
 
 	if (payload_len) {
-		if (skb_is_nonlinear(pkt)) {
-			void *data = skb_put(skb, payload_len);
-
-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
-		} else {
-			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
-				     payload_len);
+		struct iov_iter iov_iter;
+		struct kvec kvec;
+		void *data = skb_put(skb, payload_len);
+
+		kvec.iov_base = data;
+		kvec.iov_len = payload_len;
+		iov_iter_kvec(&iov_iter, ITER_DEST, &kvec, 1, payload_len);
+
+		if (skb_copy_datagram_iter(pkt, VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+					   &iov_iter, payload_len)) {
+			kfree_skb(skb);
+			return NULL;
 		}
 	}
 
-- 
2.54.0


