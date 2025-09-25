Return-Path: <netdev+bounces-226166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B26B9D22E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 04:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CA6426E66
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6232E54A0;
	Thu, 25 Sep 2025 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EUciYcCY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F8219A71
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767150; cv=none; b=T0qzFul/7Gb/7+G4pMUizmURrGeNan112HpQGQiwubuJH+uTaMq3ZsJSedhRZlNKuQJmdbzE9lLuSAjTECTqun6lBSYAExgCEOA2jYpU/n6RDLNzO7/Wpd5Btbh1CwTfns428qBK6OMBv075gSOLqtRmcUBpexeFfh71S3Wb61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767150; c=relaxed/simple;
	bh=tgSEc1HWM2agW5biNxl6fL16hgInhogKEOYYFZfpNZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FyhpwaEA7inzCOhK0gje1SHjUJyQVcHCAPG3cNPNEZkq6Vedit/KZFI6m9XCCbj8YYAbhDWrUmNHFzRKUYYibVb173UbvCCoCyzCMJSBgs7Deu6jw7hFg3lasMvumabxapS4M1JLYerzB4AlDE/kg53aVXotxJlaolTHDgtyb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EUciYcCY; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758767140; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TvbEHsio3yyITRN8SE97bu3O15GrQXTz/5regTBpZEI=;
	b=EUciYcCY4btbAxKxqBz1sDcdbTOtW1arYsvb5lo6Asgzx03/cRDSCZ8hpQ5HJI7ozGWAlrD7LvRh5cmsXAVtRDgjiPrY27M4ZGjYqF/j4dz7V1Aky7Ws+kxAU7Pqy1z9FSCw072X0ZI1RUiEFKy+bruZ51cCsPD61Wrn0Qza5Gs=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WolqhBY_1758767138 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 10:25:39 +0800
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
Subject: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Thu, 25 Sep 2025 10:25:37 +0800
Message-Id: <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 833f31d30d57
Content-Transfer-Encoding: 8bit

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This commit fixes that issue.

Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..4273420a9ff9 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u16 hdr_len;
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
+		hdr_len = skb_transport_offset(skb);
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
-		if (sinfo->gso_type & SKB_GSO_TCPV4)
+		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
-		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
-		else
+			hdr_len += sizeof(struct udphdr);
+		} else {
 			return -EINVAL;
+		}
+
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
-- 
2.32.0.3.g01195cf9f


