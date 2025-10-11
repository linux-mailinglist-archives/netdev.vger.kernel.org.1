Return-Path: <netdev+bounces-228588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8986BCF340
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785E219A295C
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7022561A7;
	Sat, 11 Oct 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k7NRotCd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D524A078
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175685; cv=none; b=S1hj3jb0GacMId42KCXdTVVpV7N00tMUK3BzgbHbm7jKtc7HSLiY5Sixmb6yVM/BfUJPgjz/jlYDVXhf4ynLHpVHMeudNmQTisDXRvsCqCw96rpr+3XHLAw3xc8vNaQ23Y9+WwWIDohw0/BfuDVxHsBQVvlMN+eCXtvFjxpx8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175685; c=relaxed/simple;
	bh=yOC2W4AFAHNzbRkZyMvk/V8kIPUGlFo3ypCuZsKGecw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXwaAWl1gKDOp9OT1rSAtI1ij8/rE7Spt+qz3ppQoAh3Pk3MgO25EZYRX30RcIZEHOZrjlCv4+BjkKPZDfGXV9nNO6EWkWq090SvwlCPhbdF6Sy5fiLNxyOEMJLN7qR//UazLAZ3vdR6D/9xNLgl3tP13Ju/XxeLLqLlk2U98Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k7NRotCd; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760175670; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Jw5BqqpTvIzAnNPz6JCxpDFItwpfORs8DdZpnP0dnNE=;
	b=k7NRotCdPOPpIb9Vd7gli/lYsKyzWN2cNdiJ/+oZtgZlvCIk7MFG+CdkZ4V6Q/TfBIjB9rPzgWvr2g6MUy3H46jGCITRcharyHuowPOFpdsQGBErs6BtNXjQN2rWKDUwPFp2QbKY1OlJhSZEkLTxrm6nj3o0xhxmVUs7/fWhkok=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpwGqHK_1760175669 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 17:41:10 +0800
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
Subject: [PATCH net v1 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Sat, 11 Oct 2025 17:41:07 +0800
Message-Id: <20251011094107.16439-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251011094107.16439-1-xuanzhuo@linux.alibaba.com>
References: <20251011094107.16439-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 94b35d9b48af
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
index 10ca53b3a399..742cce34a24e 100644
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


