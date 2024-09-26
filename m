Return-Path: <netdev+bounces-129902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9E5986F57
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00DD280FE6
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239901A7252;
	Thu, 26 Sep 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iFc1+5vj"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D71A4E96
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340806; cv=none; b=YAzcchCyyPBssOdxU+uNv0DxlNxbZ0yOs8GiCZvfTMxj1eGbCNFofS+o6AymF57LYM/ABsqiYeMCt2cbf/Vj3KnKtVr62s7mQkuasiIhpASnXIA4CgqXqgjr90pFovrcUu25Zc76ECQwI7wK0/so8b0a3/co4Kwbx9UCW173Dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340806; c=relaxed/simple;
	bh=H8/ROFGp42PbT0N3ZEj8y/n8FuDJmeQ+HHSEfqXEnog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jgK8xECmen4Sahj9cFDduY8lzbDcL1bVCmdUJGN+6km5yFlsuzPEaOIkR/qihQ0flqFDv0R5H460aXFppyB1wD7+DilWxGEwIaZdGg/XUY7ZOJewfZoXOAlro2vFTs2cbZeca3/qgjWDa1DndulMwWAIEI174AAxkrpP4EUuYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iFc1+5vj; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KQsGogSOk0pSJST8JGvKUL08IAO6aHqOAq9wOhiSARs=; b=iFc1+5vjkBbb9hWCoiwHwpfrqr
	QBUuz5SvPqYwCEfYMjQQcQ8LMJiL2gwIjEtfDQMklOjhyTCHinIglHtBszxs6pmY7uMf8e/t0EKud
	sux90054DoM+Z34Eodit5tt9S5ncPUp0pUMQtVf0lUykRaKuEHUnEtF+fb8o7zrGNZgQ=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1stkFU-001JXH-03;
	Thu, 26 Sep 2024 10:53:20 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] net: gso: fix tcp fraglist segmentation after pull from frag_list
Date: Thu, 26 Sep 2024 10:53:14 +0200
Message-ID: <20240926085315.51524-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect tcp gso fraglist skbs with corrupted geometry (see below) and
pass these to skb_segment instead of skb_segment_list, as the first
can segment them correctly.

Valid SKB_GSO_FRAGLIST skbs
- consist of two or more segments
- the head_skb holds the protocol headers plus first gso_size
- one or more frag_list skbs hold exactly one segment
- all but the last must be gso_size

Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
modify these skbs, breaking these invariants.

In extreme cases they pull all data into skb linear. For TCP, this
causes a NULL ptr deref in __tcpv4_gso_segment_list_csum at
tcp_hdr(seg->next).

Detect invalid geometry due to pull, by checking head_skb size.
Don't just drop, as this may blackhole a destination. Convert to be
able to pass to regular skb_segment.

Approach and description based on a patch by Willem de Bruijn.

Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
Link: https://lore.kernel.org/netdev/20240922150450.3873767-1-willemdebruijn.kernel@gmail.com/
Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 10 ++++++++--
 net/ipv6/tcpv6_offload.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e4ad3311e148..2308665b51c5 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -101,8 +101,14 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		return ERR_PTR(-EINVAL);
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __tcp4_gso_segment_list(skb, features);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+		struct tcphdr *th = tcp_hdr(skb);
+
+		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+			return __tcp4_gso_segment_list(skb, features);
+
+		skb->ip_summed = CHECKSUM_NONE;
+	}
 
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct iphdr *iph = ip_hdr(skb);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 23971903e66d..a45bf17cb2a1 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -159,8 +159,14 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(*th)))
 		return ERR_PTR(-EINVAL);
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __tcp6_gso_segment_list(skb, features);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+		struct tcphdr *th = tcp_hdr(skb);
+
+		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+			return __tcp6_gso_segment_list(skb, features);
+
+		skb->ip_summed = CHECKSUM_NONE;
+	}
 
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-- 
2.46.0


