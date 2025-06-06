Return-Path: <netdev+bounces-195425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB9BAD016C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99A6162D3E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9E288521;
	Fri,  6 Jun 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw9IBg4/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1452874E1
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210427; cv=none; b=c9Hyogm90PqrWKFptVrP2V+D22bxbLNwgmoz78sc/HLPeHJtb9pbBHqa2zzOZTsf1xfFcnweQlSGORLp9CysJ1wtQ37D0OkXaRm2IswU2/DhbxEc/tIW2vKLp0doTDG27Jj32BFN9qluA/0yPYL/oPxQMMHXD0Vcq3X3REgl6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210427; c=relaxed/simple;
	bh=bqcFKMScasaMIwII4ZBE5/XHBffYPwfwdSe8Dv8Vbrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXMoh1TgXl+c78TYDvwMdbyvBz55RhFkoNY9qHtEkv3InEACEBmQGAnuIb8VqCjkiXj8ncLkhl+exBrtCMqYwbcv/oNOPqoyYNOMnX1E/RwIgl1iFbvaXlZp/XMkvtByYJ/2HqaXt4j4VheR/mIuE0Z9Jzphw1clOJsyE7Lto9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qw9IBg4/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGxcq9bgsxmnSlfSlFwEhHYP5qBGhNty9GXFSxPoLJw=;
	b=Qw9IBg4/wjIRQBJs+K9W6jgsg+zsAeugYHRxsb0wr+cbjACWCDf0Kn9q/xtPLX4UjJbQA0
	OxFUGfHd3yDwV2ISOVhuqfXHgW/vEuRk+m2uB4qWsVLK1PfXSyDuzFBTBRh5SmRmpYuO4b
	p4pBxpmJ+KCmV5DY9nxiuUuEIZmGItU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-rID8FmYlPgu6tzDT0T2jGQ-1; Fri,
 06 Jun 2025 07:46:59 -0400
X-MC-Unique: rID8FmYlPgu6tzDT0T2jGQ-1
X-Mimecast-MFC-AGG-ID: rID8FmYlPgu6tzDT0T2jGQ_1749210418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C6BE18002BE;
	Fri,  6 Jun 2025 11:46:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.1])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F8B918003FD;
	Fri,  6 Jun 2025 11:46:54 +0000 (UTC)
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
Subject: [PATCH RFC v3 8/8] vhost/net: enable gso over UDP tunnel support.
Date: Fri,  6 Jun 2025 13:45:45 +0200
Message-ID: <7ba299662a78432b7e6c58ab195d87fb70eb7ddd.1749210083.git.pabeni@redhat.com>
In-Reply-To: <cover.1749210083.git.pabeni@redhat.com>
References: <cover.1749210083.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Vhost net need to know the exact virtio net hdr size to be able
to copy such header correctly. Teach it about the newly defined
UDP tunnel-related option and update the hdr size computation
accordingly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/vhost/net.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 0291fce24bbf..53491c67e89c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -77,7 +77,9 @@ enum {
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
 
-const u64 VHOST_NET_ALL_FEATURES[VIRTIO_FEATURES_DWORDS] = { VHOST_NET_FEATURES };
+const u64 VHOST_NET_ALL_FEATURES[VIRTIO_FEATURES_DWORDS] = { VHOST_NET_FEATURES,
+	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) };
 
 enum {
 	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
@@ -1626,6 +1628,12 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 		  sizeof(struct virtio_net_hdr);
 
+	if (virtio_features_test_bit(features,
+				     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
+	    virtio_features_test_bit(features,
+				     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO))
+		hdr_len += sizeof(struct virtio_net_hdr_tunnel);
+
 	if (virtio_features_test_bit(features, VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
-- 
2.49.0


