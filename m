Return-Path: <netdev+bounces-276025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA63IaAV1Wm30AcAu9opvQ
	(envelope-from <netdev+bounces-276025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:33:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5373B0193
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 577AB3042EAE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C9274B28;
	Tue,  7 Apr 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY9p1rGe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdMsowRO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26F27A92D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572326; cv=none; b=diHGZWFVOtJs72c+R05onTzc3s5MU1dbQHl39v+2HZjA8loLll2wOJBZGMhQ90pYoduxMj5aKlbvJiyKHKnQez2yhBqXRSsALqUwvbfZGOLUrUh4FDOdBdD4JNzb+bKnpH5V5+gZMvif43j6ox+7XZAtGqTxi2UKUa5s5I64cYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572326; c=relaxed/simple;
	bh=L/JCFvTPVv0HlOE0c8AmntduyQpe67fTxZL7BZ7I2Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyQNKsMUlVtdpgLrbbmgca3YzgotGqXebF8RDxjvGlG4PvYrNpmADggFJ7wrl5Nt+2YVADd3OnJOj4oZosqAczMZ2rjlificoKHFzCOD1DusvINnFfDXrXhQXcVHL0Fpwy1WhUIgHoIgxks+ijS++qwNAwztMZQaMONARq6+u/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RY9p1rGe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdMsowRO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775572324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
	b=RY9p1rGeo6R4Nng20Bgj5IEwILBDcUlz2h27QNmJbIYv94QVH1qfs7qXvVKzbB1KbyKJ9V
	eL+RSJiL95Zqmoz8bfNn+c1HtRmhtxdap8o6JIlPFIwGjgbXVSvdxERpnbZwxH4eDP2lCN
	rmVtsx4gEUqBp64dzb024fh0pecF7pw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Jx7nW7eMP7SlXVpMdyRtZw-1; Tue, 07 Apr 2026 10:32:02 -0400
X-MC-Unique: Jx7nW7eMP7SlXVpMdyRtZw-1
X-Mimecast-MFC-AGG-ID: Jx7nW7eMP7SlXVpMdyRtZw_1775572321
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so61720015e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775572321; x=1776177121; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
        b=QdMsowROYNoAk8Ar2eYrxwaau5weuVKtu7xQbxYxyhozlWgVxysgQi8NCegyd4NSl2
         3RQUt6TDUEf7me7f9qdiAVwF1UptmYG5fvxUwODi5xdF4P/kf1VLScKzpvRDrKCK/S6g
         2ZgFC1vqugfEdc5tLpQGwBY/1sokQkXxCXCpRGJzMi7xmq8Ag6rjmhCkzqwGT/1luFzd
         E+VveuDqF1g8iF9bLrB0qIoVlcij7SS5QvX3wGKEljv/YjZXzX8TMLFqu7YCO07U+DhG
         eTddPSeoicFgqRBSl67kwSqIGc/UifdAj1xXHMA+NIvDFPy8oETCgq15dR2MgM2omeyh
         LpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572321; x=1776177121;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
        b=TXYNxJ3iAeNaNnvdL5coqbBM+zWidh4z8xVoJObX2sH1OF1FrRZD9U2bzsQBDbBglM
         tibhUwDRiOFizkFaSsYtbqsa4bDVQljivBnogvapW+XCfl9+uNSat6e4wLUDZBjg0+kj
         Ck6d6w+va9LAhLnyMyLFGeMSY9f0KPOeWWMO1tseHTA+YVR7uYWLYmNOxi7rmiZiG21P
         dp5FQOjqTzWinIIZmE8db7QCVI0H2OrnqYPA/rbheiaUn2AkIyN05AKAwYIsqwpTAvtN
         ZCHlyWpu42QWzpgl7Gk9i28LB/TyPlMvNsKr3H0iPiUhk+8amgHbC8IXhFVXKffi6bbG
         mlEg==
X-Forwarded-Encrypted: i=1; AJvYcCVggzlVe3Yj2rgvhL+7QhkCvSUUGXsK7TlkMbTRk7K/o8vAlkGmEBlRrzNu0qIEETD7OnP1Q7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOo2PDGoti+a3CgriHTvUiPLvIYQG1yI9nRdKzm3kCqr8jDiJb
	baWQ4Djk98+WSSVt4azU+2xHS3h2M2GDeeKQgionBe0j9BI0bPEb4rRsVq1Mf0q4IW9PXE/hnQJ
	yL5uDTFtoQPAUerdLgMuNTgrmGc175rLAICzlFGvpnzvW9tvG2Pkbp5a7qA==
X-Gm-Gg: AeBDietQxxShn7j4rEuArKu/jIO1cRqNF1ZPzvJ2rfQnGo68pnHPuTyxogEDQslTj4e
	eixKCODRYmd2/pu7lJEO4SinjTKHZzw2lNaCFjvhX8sX3ZVUow04ZRVJyfv6MjqfQ0f7GSMJHW2
	Qec2dKcDK1VYKetc5BOB0GQubGQENbo6Os+rr11Db6HbeHJbEHwqif/pbq1smFxkUULyBi1N3eY
	dVB7ZRrqkLv0bSG/7ZCcje23LSmE+TgJRNEgGj/oC4KoLY7pVnjXj+j7TvXO86lVHk9mm/7725f
	aubDKU90YXzgIYQSvTLhsHBWgwV75pPuJnPfGpq1Et03yMGhxi9Yz5bdGnm63p+f0hAEQ7ksqF6
	Bl49PAuuxozyYZe0hYvaWTMJex6zxXq8WY1w/tVvDa1xvHiIa3ehX7m/YLTCi
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr203346735e9.3.1775572321427;
        Tue, 07 Apr 2026 07:32:01 -0700 (PDT)
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr203346525e9.3.1775572320964;
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fdd2cesm146677635e9.4.2026.04.07.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 16:31:56 +0200
Subject: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAxF0a1IxhbiB0W3IiJFXzUDq6RFBHHvF
 odncO9DASoI1GcPKS4JcviEIs9o3qxfYWRJppLLhmtujWI/LkynVbsjQo1rCluh5tl1TCk7FU7
 ufzmQRzQed6TxfT/F+e0xbAAAAA==
X-Change-ID: 20260407-remove_parameter-f61a3e40cf90
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-276025-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1C5373B0193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_send_pkt_info` gets all the transport information
from the parameter `t_ops`. There is no need to call
`virtio_transport_get_ops()`.

Remove it.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
I marked this as net-next material, but honsetly I'm not sure if I
should have targeted net. It's not a bug after all, it's just a cleanup.
---
 net/vmw_vsock/virtio_transport_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..a152a9e208d0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 		return false;
 
 	/* Check that transport can send data in zerocopy mode. */
-	t_ops = virtio_transport_get_ops(info->vsk);
-
 	if (t_ops->can_msgzerocopy) {
 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 

---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260407-remove_parameter-f61a3e40cf90

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


