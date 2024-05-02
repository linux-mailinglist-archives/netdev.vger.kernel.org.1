Return-Path: <netdev+bounces-92955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35318B96CF
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10761C21E7E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627A5476B;
	Thu,  2 May 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mAYxuOZg"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8F46525
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639732; cv=none; b=IWeKl0Z9k+xwRM9Ev6Su4Gh4Mxz1ACG17bNurzn90mIaMY/R3vqbktgjdBRN1xClwoxjBYXsjHptzwp25yCtqPHHIi2q0K93XGlNG4ZRD2dxVizSRGiGUuvfDvUzBU2Y3YD9S4Rvk07JbO3QmFgBrrNp/9D8RrZKI+XEWwdpHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639732; c=relaxed/simple;
	bh=jLMgWd78ttWvKJ8B2yUqqM+XLdp7XRgmjVYclZ291Fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DglplDwyYjT2OZqD5p9wtcZ2t9SRtQjPSE7kvmSFWiSB4/sFCiWa99cYHsyParVPEUVd/bznsM7zvjCKUEvkalQq3CNaWklRdTbCikvq6TziJHJhZ4SGG1WtDqRa0YC7ee6gSBnO+ZcSl1uIbK20S4JQm3Llk/DztqElOjf8OQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mAYxuOZg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3DF4D207B2;
	Thu,  2 May 2024 10:48:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YMWfw3y6zTGL; Thu,  2 May 2024 10:48:47 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E22B7201A0;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E22B7201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714639726;
	bh=gEmn+Uj37V0l0dx2LygzQK53RLMfNKGTL8RsQU6NhIY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=mAYxuOZggS6LGa3/b0Yqj3jCly6SwX9E8TbkOD74/9GfL0LQ9KIqo9GOqwZpwhi/l
	 +SP5tvo99L/tgVOIOMYwC6lC4r9Uu7+C/LdzTa6LQb+DnmiuhrHucMSborrMKtG0Bw
	 u4PwUZdvwe9B903d4E0liWEBw1MV/xNKbuUnGpzwHIbmuHrJapspfoTnqtaLj6IzF5
	 KDGC9/gUj2VCcj0AlG9hHYv5qpoiiILApMkzl/TBwPHkaxewjdj227mz2ai+yVmGmD
	 irweqkPi/nzjUR0b+GzHYxOCC68DEG3mOiRSbohMaPtQSrOU2KAcRP/XKJ/pOqZvAx
	 WIu/ysjsTuAVQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id D670480004A;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 10:48:46 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 10:48:46 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A99823182E2E; Thu,  2 May 2024 10:48:45 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/3] xfrm: Preserve vlan tags for transport mode software GRO
Date: Thu, 2 May 2024 10:48:37 +0200
Message-ID: <20240502084838.2269355-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502084838.2269355-1-steffen.klassert@secunet.com>
References: <20240502084838.2269355-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Paul Davey <paul.davey@alliedtelesis.co.nz>

The software GRO path for esp transport mode uses skb_mac_header_rebuild
prior to re-injecting the packet via the xfrm_napi_dev.  This only
copies skb->mac_len bytes of header which may not be sufficient if the
packet contains 802.1Q tags or other VLAN tags.  Worse copying only the
initial header will leave a packet marked as being VLAN tagged but
without the corresponding tag leading to mangling when it is later
untagged.

The VLAN tags are important when receiving the decrypted esp transport
mode packet after GRO processing to ensure it is received on the correct
interface.

Therefore record the full mac header length in xfrm*_transport_input for
later use in corresponding xfrm*_transport_finish to copy the entire mac
header when rebuilding the mac header for GRO.  The skb->data pointer is
left pointing skb->mac_header bytes after the start of the mac header as
is expected by the network stack and network and transport header
offsets reset to this location.

Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/linux/skbuff.h | 15 +++++++++++++++
 include/net/xfrm.h     |  3 +++
 net/ipv4/xfrm4_input.c |  6 +++++-
 net/ipv6/xfrm6_input.c |  6 +++++-
 net/xfrm/xfrm_input.c  |  8 ++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9d24aec064e8..4ff48eda3f64 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3031,6 +3031,21 @@ static inline void skb_mac_header_rebuild(struct sk_buff *skb)
 	}
 }
 
+/* Move the full mac header up to current network_header.
+ * Leaves skb->data pointing at offset skb->mac_len into the mac_header.
+ * Must be provided the complete mac header length.
+ */
+static inline void skb_mac_header_rebuild_full(struct sk_buff *skb, u32 full_mac_len)
+{
+	if (skb_mac_header_was_set(skb)) {
+		const unsigned char *old_mac = skb_mac_header(skb);
+
+		skb_set_mac_header(skb, -full_mac_len);
+		memmove(skb_mac_header(skb), old_mac, full_mac_len);
+		__skb_push(skb, full_mac_len - skb->mac_len);
+	}
+}
+
 static inline int skb_checksum_start_offset(const struct sk_buff *skb)
 {
 	return skb->csum_start - skb_headroom(skb);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 57c743b7e4fe..cb4841a9fffd 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1049,6 +1049,9 @@ struct xfrm_offload {
 #define CRYPTO_INVALID_PACKET_SYNTAX		64
 #define CRYPTO_INVALID_PROTOCOL			128
 
+	/* Used to keep whole l2 header for transport mode GRO */
+	__u32			orig_mac_len;
+
 	__u8			proto;
 	__u8			inner_ipproto;
 };
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index dae35101d189..86382e08140e 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -63,7 +63,11 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	ip_send_check(iph);
 
 	if (xo && (xo->flags & XFRM_GRO)) {
-		skb_mac_header_rebuild(skb);
+		/* The full l2 header needs to be preserved so that re-injecting the packet at l2
+		 * works correctly in the presence of vlan tags.
+		 */
+		skb_mac_header_rebuild_full(skb, xo->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index a17d783dc7c0..c6b8e132e10a 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -58,7 +58,11 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	skb_postpush_rcsum(skb, skb_network_header(skb), nhlen);
 
 	if (xo && (xo->flags & XFRM_GRO)) {
-		skb_mac_header_rebuild(skb);
+		/* The full l2 header needs to be preserved so that re-injecting the packet at l2
+		 * works correctly in the presence of vlan tags.
+		 */
+		skb_mac_header_rebuild_full(skb, xo->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..3a2982a72a6b 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -389,11 +389,15 @@ static int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb)
  */
 static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 {
+	struct xfrm_offload *xo = xfrm_offload(skb);
 	int ihl = skb->data - skb_transport_header(skb);
 
 	if (skb->transport_header != skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		if (xo)
+			xo->orig_mac_len =
+				skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header = skb->transport_header;
 	}
 	ip_hdr(skb)->tot_len = htons(skb->len + ihl);
@@ -404,11 +408,15 @@ static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 static int xfrm6_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	struct xfrm_offload *xo = xfrm_offload(skb);
 	int ihl = skb->data - skb_transport_header(skb);
 
 	if (skb->transport_header != skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		if (xo)
+			xo->orig_mac_len =
+				skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header = skb->transport_header;
 	}
 	ipv6_hdr(skb)->payload_len = htons(skb->len + ihl -
-- 
2.34.1


