Return-Path: <netdev+bounces-275917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKkCGlXL1GmtxgcAu9opvQ
	(envelope-from <netdev+bounces-275917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3F03ABCF7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2065D303C603
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED33A382C;
	Tue,  7 Apr 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H05eHFns";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsH2L7bX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22273A1D1C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553249; cv=none; b=kdelj4CcP+CdHb3iuIbDu+2EZ91xG+rBZ3BXqpyMBNdesOYZkyUwprUCRix4QC7B+1CAAzC6KW1SIgu0Ha72h7otbLqWn0STvmGoOI4g/JiyFDhjK31c3gEM7YbImfEQfVw8/BcPBJuV4MK7M4c27y60w9dL1LZ9G9rC0Kdexrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553249; c=relaxed/simple;
	bh=gb7Ruua+gJ5a6hrcK6PHPahbGnBvVqCiLHNSA4MS8gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4YOFC7RA5WxbHS7IVeMlVWUyjFZiZhBRLGC2zIh0dz0ndl9Pk55qEqSMHJlYNUogTHaKzuy6HNAipVNS5FCBrvUwI4fgbw8ReScgXX9IjFPmChLgsKcObfVfOyBicHiuxjCY94h5q4vKAWp8a1vZ+w7rgvPv2wPoMzYI7P3wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H05eHFns; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsH2L7bX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
	b=H05eHFns/1u+5NE7pmAf1gWjhnJg/nIrQMl4mEQ4BxlUAQ2pbCuEshM6QwUWDfuQdwuLzN
	oRqlyyuKPxTIec8jEzrPP+PQhdyvljRgg5d1VyE/26zaAb7T39/2NBlsromGBKzIl+ZgMv
	4ZZHlJms/DY8qXGU26RQ3jccZLHQ3QQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-PB_OFWpdPzKfdKw8GGxc8Q-1; Tue, 07 Apr 2026 05:14:04 -0400
X-MC-Unique: PB_OFWpdPzKfdKw8GGxc8Q-1
X-Mimecast-MFC-AGG-ID: PB_OFWpdPzKfdKw8GGxc8Q_1775553243
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d177fb157so4229245f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553243; x=1776158043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
        b=GsH2L7bXkM6pI34lvmuFuLM7tSOXqGUQ12Q/qt/E8EKv8SQ0OzvOpHZgNV7g9Byk3G
         k+P/xWGGaalrwZfA2firuxNlGHG1N7MA1vS/y9L2+Gj9RjPHuxYN6J66QmjpClS1Vn0g
         oKR5qCZVIuFYag9p3O0CThtALRQtgOjdGf781IPI8oE/C762GBvdoECZS1l/v1TQ9Zn0
         Q78a6utaxjE4CUXQxiwDriFUBdXUY4SQFyAmJNnrDABZCJNyYWqAXRm+frGtkvwL8N87
         QNEsL98sPTWAiosVriPlaSl0dkICMZvmoNPYxST1q7LiDGnWpMppoXfmqoHA1FTeSi7M
         EVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553243; x=1776158043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
        b=RE0sfedqRuKqzbB4AWdeUdDSsHfxbbTOroQZ6Ms6s69XyrM5DPoW5R0+X5st/nwYSk
         lvdlJBq/03spoSKb6ZH8/CjkO9Rbq7MNdOKd9ozbYhoGIjp4+P7ZAyYxUlsMdq/YPV2t
         RANM3I5mQ7jIKJFrn3j0cpATTw7rUTd1ulVgJWYkywSlHQkwp8Ly4dHz5JY71DpmW1VY
         iNL6mR1+Lb39uzhDTmIkfxNnYrUmKFqjR1PlqNhaAnHEsorA1RxgYeJiFjyC67fU3cM4
         HriGZ6mCN0xDCnBsENZZXadFXxFbmTiVvAPyxNCPFqXxJ99x2peZzZ5LPtgJQbCUJhlT
         1ZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyPtz/Lu65hx+qiwrnuxUIf8tjL0SU/9RlvvGllWqi64mrTrI0ndm1viioYm+MSCHg9Z5lgXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTN7oq6vK4Uv6RhWcQQSCYijhbbCCHPkmplfxBzmUUslTtUpDx
	/ahc5CDWgfHbY3Gsa8UcdduVKvALmqCFngwtGUsUzkQCxXaopLbSNXPeDILuk7fFpD/QMT1/dln
	VkRQuPa2IseB+17fFTxHtY9bGKigm1YpM0mcqSKGoBNGSDmbLhiWU8T1O0YXTetPWlGdxujChDu
	QSZ/ZaHvwkPoNR9RVR8mqh9Riqyi/QBmkBd83ApM5kXyCb
X-Gm-Gg: AeBDievRy/ZUo6MSbMKfYThHSxqR/LwVU+LQq7UcHz/Lcn3At/CsMzJ/dxAqbpo63uM
	RKDhSP3fnT4vhiRcoIpZA31RSJ3lLDkGsnqlMipzfh+JBHLQ+CZBpRFkf4s10O3dbaETdO3hmHa
	Q+3gpuVJuJdHktNpsdRve51idvmhuxMOLTiCTWl0CS339DfC6L+JOJe2kI33wFJ7MaV62hjL2Xk
	iVeJVxZdy2o6kFgqVV3WufJOX7vZ/+p9NhDyR8x2XfiehYbHGQd9NmZ0z4B/O2lAQh8bwVIraAa
	gOmwpgHb4wjEQHHE/gbE7Ae21ICJdCKtAXNvppdF+BYXp6CfQR4BQPa6v+eEIiEXrDeFWTJ7DH1
	8/jJPqibETodqGC23JeAijhE2beDv83GLNmfbcbtu0sqE7nMjLd1wG+r9NyrD
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr111080415e9.21.1775553242850;
        Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr111079805e9.21.1775553242317;
        Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:55 +0200
Subject: [PATCH net v2 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix_peek-v2-1-2e2581dc8b7c@redhat.com>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
In-Reply-To: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
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
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-275917-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE3F03ABCF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..4b65bfe5d875 100644
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


