Return-Path: <netdev+bounces-192251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9278BABF1BD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8024A2D34
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5225FA3F;
	Wed, 21 May 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcDZ+3Oy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860325EFBD
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823655; cv=none; b=NBM+l1jhCZUqgfHsMsPC35K5i/zuVas0NQQlsj/VUfLmQ9rf/bfloZoRW7ILvB/rTyspVq6SSAUosArUAvRWLAZxpad+HVBQPckGzjBVEti7Di6Qy7/EYl3I1oL9lcI9JpMfHvYZVBG1Ql49eeqhZtD/zoJq73IQHhdMj8aa0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823655; c=relaxed/simple;
	bh=JtnspuaDpPD4pK+Op9bcXw+/XL2tna1nHrJW9r7Qdno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjWTX00g1HJgBeFYIH3K1pyGUl9wjPN1gJCHZ+KR/1IHrjx0o8fhOnUMtLkcUYD0hNhVmtctieFz7lgK5H55rdJxMXrATbQ1+1uN0EpJb/3kcdxG/ZnF2tk93TU9nwct5YsyqAkBqEeerr028zWQESealXSH3Dy+2gKerJyW7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcDZ+3Oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtyF/tSaVMV5l9zMHLmFyUKQJmYDVgVD2NK3t2gdqbE=;
	b=NcDZ+3Oy5GHVfwxF9hxMuO9EuWUtveCD8L/fi4XwW1RwdYW+HjzH9v1+we6EL8xBaNIfHw
	a87vqT/oxiO6UaVQ8JdQ14rNgtYfnpXeNv7FZbp2I0RRSscKnlXDEc8oGQW50b1jfpoiOy
	/R9eoJu7wxpi+pTWN4ZKs+sGnW4hP5o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-4Lg12ot4MxiVA3HVbomUEQ-1; Wed,
 21 May 2025 06:34:10 -0400
X-MC-Unique: 4Lg12ot4MxiVA3HVbomUEQ-1
X-Mimecast-MFC-AGG-ID: 4Lg12ot4MxiVA3HVbomUEQ_1747823649
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBD501955DB3;
	Wed, 21 May 2025 10:34:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CA86195608F;
	Wed, 21 May 2025 10:34:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net-next 8/8] vhost/net: enable gso over UDP tunnel support.
Date: Wed, 21 May 2025 12:32:42 +0200
Message-ID: <f95716aed2c65d079cdb10518431088f3e103899.1747822866.git.pabeni@redhat.com>
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Vhost net need to know the exact virtio net hdr size to be able
to copy such header correctly. Teach it about the newly defined
UDP tunnel-related option and update the hdr size computation
accordingly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/vhost/net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b894685dded3e..985f9662a9003 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -78,7 +78,9 @@ enum {
 };
 
 #ifdef VIRTIO_HAS_EXTENDED_FEATURES
-#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
+#define VHOST_NET_FEATURES_EX (VHOST_NET_FEATURES | \
+			(VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO)) | \
+			(VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)))
 #endif
 
 enum {
@@ -1621,12 +1623,16 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
+	bool has_tunnel;
 	int i;
 
 	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
 			       (1ULL << VIRTIO_F_VERSION_1))) ?
 			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 			sizeof(struct virtio_net_hdr);
+	has_tunnel = !!(features & (VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+				    VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)));
+	hdr_len += has_tunnel ? sizeof(struct virtio_net_hdr_tunnel) : 0;
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
-- 
2.49.0


