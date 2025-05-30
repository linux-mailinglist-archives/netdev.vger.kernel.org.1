Return-Path: <netdev+bounces-194381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914EAC91D8
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985F27A453E
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05823507A;
	Fri, 30 May 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnZhhDdk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0C23504B
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616631; cv=none; b=aV/L5RvDBrxk3HZ/VG//iARrTLdhrbDNpPGr+/3ISZZI18uF8fvK4bbiwE6g4E8xX2dyT0XbQm5jgymSAHC7JIVe7pv5PMGctxJ3ERaLGZKbDrC0yv6e1qYIM/QS0AeNm19weGSXp0FAg1aT1xqGnqZzjsL2eL9ZwvvPqL5NWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616631; c=relaxed/simple;
	bh=0zEPVtaF4ACesDNqKFaKWEbWIOS4fFZ+ldbZ3gr2EF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJTSd6yv/drGDTKt6fdTnDDecWTYQazK21Jcxbsmk3POgteHzUI5ZkwXKKPAtvnolc6zJGu+Iq2ptDxqWWFI9j7xJHBfA3yCBO3THvIgpqTpz4fSa5gyh/gdDcDDkU/zSywCVuRhvKa9Lfd34q8X/QSl4Pt4TIat0cvhqUnXN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnZhhDdk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748616628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnQfLjMDMTxDHhZ/DWnEV8hDSLract/Zxy+ns48smS0=;
	b=UnZhhDdkFFCMfgG0s4aDnLe95vYs7W9shVZ06kR9kYgC04LlHo6X1TuL+wZu3zqYXztyzz
	9AQeSX01wIwCiB7k8D48q9Sbp8aR0CiAq6DXnY826OqL+VlpVDNPgPqUXXjria/m6wlvlz
	IE9Tu8BbWdaKhZS4strjLOX5ejtk7y0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-GLA9sdRnO5mlXrXRwwjOug-1; Fri,
 30 May 2025 10:50:25 -0400
X-MC-Unique: GLA9sdRnO5mlXrXRwwjOug-1
X-Mimecast-MFC-AGG-ID: GLA9sdRnO5mlXrXRwwjOug_1748616624
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC61C1800DA1;
	Fri, 30 May 2025 14:50:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3B4719560B7;
	Fri, 30 May 2025 14:50:19 +0000 (UTC)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 8/8] vhost/net: enable gso over UDP tunnel support.
Date: Fri, 30 May 2025 16:49:24 +0200
Message-ID: <7c0273eb8bd78765c47c989e43e898ce9e5ee166.1748614223.git.pabeni@redhat.com>
In-Reply-To: <cover.1748614223.git.pabeni@redhat.com>
References: <cover.1748614223.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Vhost net need to know the exact virtio net hdr size to be able
to copy such header correctly. Teach it about the newly defined
UDP tunnel-related option and update the hdr size computation
accordingly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/vhost/net.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f53294440695..fa88f021e9b1 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -77,7 +77,13 @@ enum {
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
 
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+#define VHOST_NET_ALL_FEATURES (VHOST_NET_FEATURES | \
+			(VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO)) | \
+			(VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)))
+#else
 #define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
+#endif
 
 enum {
 	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
@@ -1619,12 +1625,16 @@ static long vhost_net_reset_owner(struct vhost_net *n)
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


