Return-Path: <netdev+bounces-228659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF67BD12B2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 04:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C068B1890735
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 02:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE827FD4B;
	Mon, 13 Oct 2025 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cb25h4tN"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED0271A9A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321204; cv=none; b=WVcwezmefhK2GprrEx5VVvvpuhZNRjJoScULpY+fzW/o2EoHujEQCbzRgxtsT9uTKj0p3eTz7nTKpwwGFbUA+hrEDU30hk8ygv8iDmsJl+Yq4Tmj00rxexsuoT/gBBQOgf3qzB4Sf9vsalGThfyfF+1s4w5Sl64ZAixDGbOfBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321204; c=relaxed/simple;
	bh=copfItzbQRl+LB1/PUbOAcdAvk1CS5I9MQeqTNbKqXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQCKJoAORhxnE2CBqTyxYiNzyXByTUYHfAEh1Yed0V1uL9q+mvJeL14f9exi86iKuKUOeEqCjU63idds56biVTV/xDUYgm8hXD168tKM71JnvSqrCjZ7b0M6zvxuNE11XI8A/ZR2SB2LeXEAdsGHbIgK58XE9i3GKuXYweewsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cb25h4tN; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760321193; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TKKlad8ZOJRTk7a95rnaDVFwiiHJsm1/cvNbYBEJQyU=;
	b=cb25h4tN2+cbDbN6xo5ac4AxoxmYtcocuerEBOrmnevy0/038KuoQIyMA2+2GgEaLyTQ1yGw8JQJtx9XsyHdlGBcLfapcjY+dNTTD3n1KOP78ekuqB6ZdBx7N45hpcSfLMnv1jzN1+56J3pNw6l40Ckw3OWvSx9p9kxUTrAjhWk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpztGSc_1760321192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:06:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v2 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Mon, 13 Oct 2025 10:06:29 +0800
Message-Id: <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 06377f1ca66f
Content-Transfer-Encoding: 8bit

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index e059e9c57937..765fd5f471a4 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -403,6 +403,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
 	int tnl_gso_type;
+	u16 hdr_len;
 	int ret;
 
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
@@ -434,6 +435,23 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	outer_th = skb->transport_header - skb_headroom(skb);
 	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
 	vhdr->outer_th_offset = cpu_to_le16(outer_th);
+
+	switch (skb->inner_ipproto) {
+	case IPPROTO_TCP:
+		hdr_len = inner_tcp_hdrlen(skb);
+		break;
+
+	case IPPROTO_UDP:
+		hdr_len = sizeof(struct udphdr);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	hdr_len += skb_inner_transport_offset(skb);
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+
 	return 0;
 }
 
-- 
2.32.0.3.g01195cf9f


