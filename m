Return-Path: <netdev+bounces-194377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA15AC91D2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F864E30D1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D83234973;
	Fri, 30 May 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6Kuk6HU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46042219A70
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616613; cv=none; b=u8CQtUl/CAoPVspp+W1i2+LdR4eIqTLJhpya0RgSAGsuAWdSD1FI8NLNh1jsajFfBvvmwBectBjeCJuD1d0Ks61BGBtkS4F4/vDeMugd/b8e2LsqUsp/xTcnFkr4v+jfuy9jzMO8XM8Cl7jAPZln7EnKTJ4TaHABZJIo2iXM0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616613; c=relaxed/simple;
	bh=+8fbCw35qXeNXUW4JhBnkbH4vZb+J0NH8fBJcNmlUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjMcYz7qwPDMQXRUpaGHzfTUHwbGyQ8X4LQgp1VvhSnf3uPCqe4kNqPT+RRgH7nJ5YXv6trU2ix/7te7CF88nP1cbDI4Nw7aEGINehok+tnAN4d272Z1Nj4DJV5NRyGWo2+8Ngw3ORw2VhCjG0dmPn1GAO/lSlxil3DLyPHFjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6Kuk6HU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748616611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxaSagyHXj1USHSGw+kwRWtXw961DhXx2KCiqky+VWA=;
	b=d6Kuk6HURNat4vZo3T8bRPF4MuFjVcMa41hLTjyAVA/Mt22nCHJCikAUaX+IjyYV3wctes
	UcVvL6ag04ORN6ApaHf7wCKbMPzjy9+rtNltPbeIohfi0zGjMn33njZP/iaQw+ihYWhlzT
	9a6QgnPcvvUkRtHBStuenE7m/BTGMwA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-bLBqzundNiaDJk2a46FXJw-1; Fri,
 30 May 2025 10:50:07 -0400
X-MC-Unique: bLBqzundNiaDJk2a46FXJw-1
X-Mimecast-MFC-AGG-ID: bLBqzundNiaDJk2a46FXJw_1748616606
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 099E6195608E;
	Fri, 30 May 2025 14:50:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 993951956066;
	Fri, 30 May 2025 14:50:01 +0000 (UTC)
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
Subject: [RFC PATCH v2 4/8] virtio_net: add supports for extended offloads
Date: Fri, 30 May 2025 16:49:20 +0200
Message-ID: <bfac8c3cc2a36ca419ca583e3a43da0ed5185b8a.1748614223.git.pabeni@redhat.com>
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

The virtio_net driver needs it to implement GSO over UDP tunnel
offload.

The only missing piece is mapping them to/from the extended
features.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - drop unused macro
 - restrict the offload remap range as per latest spec update
---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..ec638b4aa1c1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -35,6 +35,24 @@ module_param(csum, bool, 0444);
 module_param(gso, bool, 0444);
 module_param(napi_tx, bool, 0644);
 
+#define VIRTIO_OFFLOAD_MAP_MIN	46
+#define VIRTIO_OFFLOAD_MAP_MAX	47
+#define VIRTIO_FEATURES_MAP_MIN	65
+#define VIRTIO_O2F_DELTA	(VIRTIO_FEATURES_MAP_MIN - VIRTIO_OFFLOAD_MAP_MIN)
+
+static bool virtio_is_mapped_offload(unsigned int obit)
+{
+	return obit >= VIRTIO_OFFLOAD_MAP_MIN &&
+	       obit <= VIRTIO_OFFLOAD_MAP_MAX;
+}
+
+#define VIRTIO_OFFLOAD_TO_FEATURE(obit)	\
+	({								\
+		unsigned int __o = obit;				\
+		virtio_is_mapped_offload(__o) ? __o + VIRTIO_O2F_DELTA :\
+						__o;			\
+	})
+
 /* FIXME: MTU in config. */
 #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
 #define GOOD_COPY_LEN	128
@@ -7037,9 +7055,13 @@ static int virtnet_probe(struct virtio_device *vdev)
 		netif_carrier_on(dev);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
-		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
+	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
+		unsigned int fbit;
+
+		fbit = VIRTIO_OFFLOAD_TO_FEATURE(guest_offloads[i]);
+		if (virtio_has_feature(vi->vdev, fbit))
 			set_bit(guest_offloads[i], &vi->guest_offloads);
+	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
 	rtnl_unlock();
-- 
2.49.0


