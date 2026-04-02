Return-Path: <netdev+bounces-274419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMnzNOUnzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:25:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2A385F8E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3537530B2C15
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09443325726;
	Thu,  2 Apr 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W40Bhi3r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTS0A9DG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F3730276A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117890; cv=none; b=Kg+Dax4BpdMKFntP5LHgcIkY2sBrqaIL4hdEmG1E7xZjykATtTzsrCpmSQB1DnWJ4Eq/mHzQ8yHvMDIdzlxPdmB4tnXdrU066D7zSK3IMgaX1vu4SbDCj0i4p3Ed7Y5Tj8oUny+fKu/9KBtH08I/tZPZpmnW0bL5Qv2xIDqZg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117890; c=relaxed/simple;
	bh=7RbGQyRVtd3iDjWPPVgXBB7W0hDbsWzu7x3oEX7DOMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiwVoMzXJIjO2T3Of46h6EmiQJt4hEHAewacPROJVEss5pB0M3iWRhYL+p4aJXTVYPRpZGE2z2YH1O1ZOja7UTejtJdgEIp1ioJubXmF0+E0blJsc3vJzUF18Ara5e9TOJ6WinZObwfpqAN7yuzyoLPVaF5QwJXtQKAtFODoFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W40Bhi3r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTS0A9DG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
	b=W40Bhi3rj7bMrDiFrLHTLVAbpuf2PYbvD2osHxLdzzrHptBZdX3kP59cvoExesCsh9PXs2
	MewNmxxf2OrjEA4RbndneuC5wD4tByseu9JyfEuBD3/Qj8xEXXN7iEgXnKKdbQHT1Mx+BQ
	S/ane+xD5hejyqMDNNJ63Aoj4jhvtpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-_SKL01pSMoSX3ndOiSKxng-1; Thu, 02 Apr 2026 04:18:07 -0400
X-MC-Unique: _SKL01pSMoSX3ndOiSKxng-1
X-Mimecast-MFC-AGG-ID: _SKL01pSMoSX3ndOiSKxng_1775117886
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4887d32788bso4267545e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775117886; x=1775722686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
        b=UTS0A9DGW907JuebnvjMxotZsSld/elA95ZOox/vCYf26T+cRrVSubzNVAyE34Yw8B
         VxeKB/ki/u2+Dp1h+93G2AnqTrxroiHu4Dd+dIzVj/4p2aI0x71adTm3ztADn6gZ0xoA
         Njr62I3MV6xhHDkE1Ou6z53SbIy6FpQykb4PZ3XJFGJURA2AOvgFu1YlJrbEBsCvENK6
         7yHjlhxoLxI/gN1AlUitoSIbt7DzQeBkqNtUTPpGxLerTL4G1ZF045aPPvw5GTI8esGY
         WatySjBFNjyNbklu2vEuv15saSodFtftSQacDpaYmOpsPT1hwIh2tXM/JrFUase8WTRK
         g1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117886; x=1775722686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
        b=I/J+xS6Oa4WXsS0xd6G7elLxpsKtuel1bXSDfCmlfbBpGGCBiy8MAVHEdN0k+dd0kQ
         vPVLiWPrJ1ZuhihhmanUJvtwxR+xNWE1aCK0Wz2rw6SOEQ9X7fnAjgcY6yt5Oi1vz4Z7
         nRAc94fS/KzytYlU9EL46L0mGmChtcuXw4BcuGH52gnQcUlaZ+BsYoc7hsY8zlsdB8ls
         Ue6030nL8RwtobcEdGu+VBeNnRy7HThvmv3xAMLMHN2ahw0zA4fnGcFxaoY63ieS4kLq
         krRpcvnc67h/4MJZNwbgN7Bc8NZRDQP4ygaCHquxqRgnUlr1NpBmeQWV8UQ3INpsqrt5
         rsmA==
X-Forwarded-Encrypted: i=1; AJvYcCWcshcnKQMBwEgvu3gahkEzl+9K/eFU90IonST2yn5tforslh+ttOzxNmInWJXd36sYhQwvmOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+QqU4rj5WTUyhPcMN0Qz2syTI17G0iz80oZe21E96RVYOeSg
	hvUcoYzx/ycm5fafooHCMfzz9zi5FYwC9Z9VnPw3XTBajZ6NK98oo3vyxKIaccmrWa0DLQZ5nNJ
	2R5/uphHKsSwIT2uqYkN5+me6WmIcx0B0/etTkYWsZCMR8hcLL5QWjBFudA==
X-Gm-Gg: ATEYQzySiFwHbsWTJwG2iS+UumnshfdisAaygNaQl6h9j0gu8aqP/2dq9X7TIYrGaez
	za1KK0vIDjG2ju7+hcmruWyMI3rSnJW5yJoPVxEwgn01+YhLjieAVtUY2Q7XRnUZrAM+ndlZtiS
	8PkPbslGzZIDF5YN9gpoT/k7HStAkZpygvWSEkCqYKBooonwQWRb+XjAQHY2YjIrSb84eOwcTIf
	N4pvLSrW1Vk+T2MglC4JkIz0mcoDM+71q07xsSH7B1nMBMBW01sAihbKh5oalL3ZyjuhQwogPKh
	iwGuMbvCb5T8OlSS/u/4Z32H2P6g2PjR8JjmkmOaUGxUAo2RK2M0wcMjIQy1/MKp80rN/LcXWsC
	Br3QgMFKv/ziCecPpPaGSA/fYBFwga4uygcBur8TgZ8MRfCKRgwFRItVG8rwL
X-Received: by 2002:a05:600c:b99:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4888b70fbdemr38341185e9.9.1775117886272;
        Thu, 02 Apr 2026 01:18:06 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4888b70fbdemr38340675e9.9.1775117885762;
        Thu, 02 Apr 2026 01:18:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 02 Apr 2026 10:18:01 +0200
Subject: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-274419-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56A2A385F8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0


