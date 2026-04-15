Return-Path: <netdev+bounces-278818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPTDF0qq32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55D405B4A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 254D93023EFB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E973D9055;
	Wed, 15 Apr 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp1m1OPd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuT5V+ZD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758D3D5656
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265787; cv=none; b=UxoY+wmOAdZJ3x41x9Jz4FnIwrnUztc1ZFpQ//fV2jsh0WUwPubAZ0oRhvmFzvKlrY5TRlTDZomGipRdfLl0qKBrZyO2xnIqZb/wpksXRWuA1wXP/t2Q3e6WFJFI5fnwF4svHeF5lefCakDGV+k5u4Ecetvy0T/WgOJ9c2DiLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265787; c=relaxed/simple;
	bh=8KxSLwY587LR57aGsCLpqgDw1kJidOt4vFYe6TGecyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0Ix/E1CrGOefZ9Wv9h7J009OHeDgw9+DW9Sx2sDueqSIcopfJ/tzG6EUqxH9NEzJe+SaydxjLa8TdbFyBcZQmpuVApWKGY0x8i7jFuELM6Hvy+y9uBPpzF63tgsljybo67csxdtcdy1fp7/hjJV1Hkj/yJL9ydYQiZFgLkBVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gp1m1OPd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuT5V+ZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
	b=gp1m1OPdUDigY/CMmj4O6ciV11Z48b4NojX73ouVQqdZmo1XSrehjXYG+TIEfuyEdukX+Z
	0uLh0TUCRyaQxIIJUIOPDQGqnH6IEoEuTJNngzwU0Om6hyYGkbQ9V6Ad3wTWUN11iY/qDr
	G2N0pbZzF00jyBiMOkT9U7ZOLraJADk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-LgqkATBDPSO6u2rIIqlc4Q-1; Wed, 15 Apr 2026 11:09:43 -0400
X-MC-Unique: LgqkATBDPSO6u2rIIqlc4Q-1
X-Mimecast-MFC-AGG-ID: LgqkATBDPSO6u2rIIqlc4Q_1776265782
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cff5ef652so4375557f8f.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265782; x=1776870582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=KuT5V+ZDxxwtul6OrsVNM8Sat89SsEhCBRx0bHYl/l5KUpaBA85cIRvWe1WrY24gjB
         ex453lm0Z0SJq+kD5nvTjO/giQ6Lj+QyV1tsL2syuK2TfEQRqrjARtYQJNYocaoq3ncq
         YD6aTD7DWoj9f0vgCFxodyhbONRIt5a78QOu1QDj6k0bxDJ7xxuF+K8NVueubrPf5Q//
         d77bZUus/+i+/EoYOjjWsCHP8rmnbYcpMXvx8HX6aeybJZGDafr2tPAHV7/f0B23B6R3
         KKgDG4BNpzg9Vi2PsZvnuCaJYP8rDlQ3Ofv3eeQoe/6xLXSm11Fcz5XHwppwPMxrDf2p
         ZRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265782; x=1776870582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=U3sThYLaXVFUOuqE8rI7Yvo0B0UIwtDx+Tvdl2eQc5WTOP2qCq4WHwfN/tvN8kPzD0
         JM+DLD0X1ZGPZka5G4st+Rkd9o3fbfbvlnvfX26VD8nXHiomBl+fdvPFG/5LFZoHA0yL
         hcr0X0glwUpp4PWI6yTIHYI8PTaMTDjRPHCCFwEKsO4Z7JHcbSIrQy7CTh61ooYGr6+r
         QESWxSKrszYJ7oYuA3HKSdBbOKLOhTYR7xgW0Vcq1mHD2P/F9nNKDYlx0qsx6JYIDNj0
         xAhIqzl5SwZh3iF67Qe8Kai4R07b4odgBueI8YSnAZwkVF9xAxj5HSRAdS9L0G+bWwqH
         wiuA==
X-Forwarded-Encrypted: i=1; AFNElJ+pACa4Z/T7Itacj6bFtVYYPAu1lpQNQPCvEMl5quVKbyyJMrXT0I8LGMoUNELnrw0rBuiDxzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwI/m+X1U6xe9sZWgiZIdMAbUoerXsHAoCoc/9N4kbc6eeWFC
	yIOH1aqkgcHrn3I1wW0gbQb2AUK9domXiblP161xMxEHRTGHo34fOjhoLvUct2BNtNXJJYbFu8c
	JLWiEsjW2CN0/KV4B7XnLzJCj6zgw2Y7eM2E+qPQhSDTD32F8u7DQIwOCYg==
X-Gm-Gg: AeBDieuoxPGmTHskCmPvA/hksfmX1h2NRucqDORRdKM3XSkg1lvMIKjCNX+8bZXW3ra
	E8eYx4CHojMGLfFV1mIQYkGoERUwF5XI3GPN3e0DccoMGUB0fEe4S1oTUyHY+0JkUhust8AKxGn
	RQdxfb6S8FPwtYPJKsKC7VIk3OZaCVX+aAJuq5U6NUpG4qZfwaJdZFhb9Jsn8PGPscBy9GqDgKN
	gAriq/lau8UnRD3nhsUdk0Y0Mjb3VUqeQSTg6USGmIy6xR+LOXAiU3TpJ7mZGhWFkQE/Ds7sE4x
	hKUGj7LB+9p2P8mEy6vdHS3TeSsWD+tBaX9Z4LNyLZHbeFVXxqEneuBckzXBKKm8mplhFBJRvx4
	E4/Mfeaf08J376w5IcmfH+0rbbgCaCAi2zN9eeASlZmua2eTYPBEMM2K+cKk1
X-Received: by 2002:a5d:64c4:0:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43d64259b42mr30842191f8f.8.1776265781758;
        Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43d64259b42mr30842115f8f.8.1776265781194;
        Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:40 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:28 +0200
Subject: [PATCH net v4 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-fix_peek-v4-1-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278818-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF55D405B4A
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a152a9e208d0..b5015ab2ee1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -545,9 +545,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
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


