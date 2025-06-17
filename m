Return-Path: <netdev+bounces-198741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398EADD5F3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52BC19E16E6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3062F94A0;
	Tue, 17 Jun 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AILP2do5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508C2F9499
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176812; cv=none; b=qXIe3yuKvP233FhS3u3Tn4VMboPs5AELPY9inBzVBPec+W+w4QGL5PCt+TqOjP8XM81NEWvpafFMCEfBMJROUQcLD/f+rvlPDpb1uhuy6KvVJdvz6ClQWmfAISkLdMtE6HG2Vivu2co1tn+q4jGCG+WoK0+lHxO5W3gYo/+X8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176812; c=relaxed/simple;
	bh=SijBLum/KVShhHH+To4tPt4zcsod8W2Y4iWiYPL9G+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRwFELny3UghV7AXexKX/muCUo4GYeQ19dsQaWfs+1uCh7DSX9L6jrg3MyCbQQ+AVw0lBeDJiWP3/AJE06A9UQy73KJQ8dMk3iVu4ZX+ktWAyL8GKuB7aevrr9OtQh8+1+X+KYX3rCvWGDFC8K9p+h2v59A7rABkZDOfLuC52Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AILP2do5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750176809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OyoyH607iWRbkiN87oMnYtjspLu1i5nx2ruq0PZN9Y=;
	b=AILP2do5PIpiJd5fhmHQksIOOSPgRgrsFKwvXmf7e0dNeq5bCZLUtp6bGAq8X1V0uXBxaB
	fRC4AvZobsRlJs03hF6De0tHKuuxQ447I6nK3bs0zb74aHwcvCFxmKsphl+iY/pCh90+g+
	7Thz7qI86mJuevzTLVSU5b5yUuqGvGw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-Fd8Kuvh2MgewmiLC9ObIdA-1; Tue,
 17 Jun 2025 12:13:26 -0400
X-MC-Unique: Fd8Kuvh2MgewmiLC9ObIdA-1
X-Mimecast-MFC-AGG-ID: Fd8Kuvh2MgewmiLC9ObIdA_1750176801
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 627681956096;
	Tue, 17 Jun 2025 16:13:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF250195E342;
	Tue, 17 Jun 2025 16:13:16 +0000 (UTC)
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
Subject: [PATCH v4 net-next 8/8] vhost/net: enable gso over UDP tunnel support.
Date: Tue, 17 Jun 2025 18:12:15 +0200
Message-ID: <1e9154a001fda22f358ebc0cbf4edaf9e05d9417.1750176076.git.pabeni@redhat.com>
In-Reply-To: <cover.1750176076.git.pabeni@redhat.com>
References: <cover.1750176076.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Vhost net need to know the exact virtio net hdr size to be able
to copy such header correctly. Teach it about the newly defined
UDP tunnel-related option and update the hdr size computation
accordingly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - rebased
---
 drivers/vhost/net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 126aa4ee26a8..c36ff30bf14f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -75,6 +75,8 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
 	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
 	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 	(1ULL << VIRTIO_F_RING_RESET),
+	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
 };
 
 enum {
@@ -1624,6 +1626,12 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 		  sizeof(struct virtio_net_hdr);
 
+	if (virtio_features_test_bit(features,
+				     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
+	    virtio_features_test_bit(features,
+				     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
+
 	if (virtio_features_test_bit(features, VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
-- 
2.49.0


