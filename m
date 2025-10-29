Return-Path: <netdev+bounces-233779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C668C1820B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327741C64F5A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D12F0C7E;
	Wed, 29 Oct 2025 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e2mw4WRM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8042ED870
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707363; cv=none; b=c9Ezw/892YEBLp2A2MVevkkgiisALDG3snuBK+9lHUXDkDRFflto85Djf9dM3DtNwHYl2PfNXl0apnp1ksbhKw45dNLp/22V7DVLmn78J72wX0EFc5B4t5SyOsEEK519BmlQdUctHlPh+r4+Vs1NGuL+AMcyJr8iq4bIlSudHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707363; c=relaxed/simple;
	bh=aP9qakPpaiVOSdB+uHYjLY9V9RVOWJVKdskFxOy1jHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFwb4mFTv2ZETlyZyOBqp3da3eloiEAR6juo3TPlz0s8JHwvZa3GMs+IZsHlp44a9w853PFefATpb3Em+9Od04B4BBRkZ1XCut5ESeHN/vYc2w5Bd2+pMlepTyg82gN9kWMul4XgjMHQHncRunV1/Ms6Iy93kCzEPyWqG8jlBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e2mw4WRM; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761707356; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MxotkOrTHpJZdolHx2dEGWPUrZYdrvHR3vVjWbi4U7Q=;
	b=e2mw4WRMvv0Tyo3vZ5phYtI04UupAzWbOdkLmWRqm8ogXR/3DTxAZpHdpJ/y5YI8XGZxSGeZMb6JG+t8FG73razqaRCCDDByNRtnWDQUFlHWkSkCSVvUhwfEJZlp4btcHwIFPRoaJUBzLfQbJ0HiM/oICDIHKZYYVs9IgA72H8w=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrEEDN2_1761707355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 11:09:16 +0800
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
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 29 Oct 2025 11:09:12 +0800
Message-Id: <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: eb1fbe1c38ee
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
 include/linux/virtio_net.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 710ae0d2d336..6ef0b737d548 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u16 hdr_len = 0;
 
 		/* In certain code paths (such as the af_packet.c receive path),
 		 * this function may be called without a transport header.
 		 * In this case, we do not need to set the hdr_len.
 		 */
 		if (skb_transport_header_was_set(skb))
-			hdr->hdr_len = __cpu_to_virtio16(little_endian,
-							 skb_headlen(skb));
+			hdr_len = skb_transport_offset(skb);
 
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
-		if (sinfo->gso_type & SKB_GSO_TCPV4)
+		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
-		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			if (hdr_len)
+				hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
-		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			if (hdr_len)
+				hdr_len += tcp_hdrlen(skb);
+		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
-		else
+			if (hdr_len)
+				hdr_len += sizeof(struct udphdr);
+		} else {
 			return -EINVAL;
+		}
+
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
-- 
2.32.0.3.g01195cf9f


