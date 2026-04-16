Return-Path: <netdev+bounces-278912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPYpKadb4GmsfQAAu9opvQ
	(envelope-from <netdev+bounces-278912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:46:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE640A0BF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 751F73018B6A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD21F94F;
	Thu, 16 Apr 2026 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CqOiWfFh"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD43093BB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311196; cv=none; b=bK3oE+jj9ermnDT7wdzlW8/ugPffzFeQwwmcwCNd1P/AAMZogArwOYcLGzNFUEbUHJCiYhQ/Lo5mWvFQsDCkKk9KovToaYBeV7s/YBx7FXeAajEWyay+Jdc8XqCcgyllZ/geHl5J2rDiuFzlMbKyOx/0fE3Byu8h8DFXE+8UbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311196; c=relaxed/simple;
	bh=ATB3acJJRcv7+vkNRw2cemvMEX8EAkhws6dD/5PhPYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViTw53R2LxF3xfW87qUzgiRpmdF2q2BeMUCuPo5bG5URtA8S/fYIBtwTkqyWJkbg9oOn+dUXoG9b3A9jjq06ZTIn2HEfFtPq5ydIo97BYyCt3RFp6nn0UkA0ZXHUBiPIYXVJKU59YrcWhMFhbzzCQ8fKoTUpw1Aki3kBXu9qaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CqOiWfFh; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776311192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=STy5fptl4kDA0hxRdge2uXtZILjqvQ9NCE82yGpau2k=;
	b=CqOiWfFhUGltgYgb/bc9YecNLk0MSWip6Rq+DGMCFgwsNMXym8r2n7UT8vWQl2erCtgGgG
	/qbPpLroimBemnX59n8k0s5/NHDgAtEQdX+g3XWDBMwlzs3WnChgDZ+F1CXKGxe2mHA/H4
	MST7Rpui1CGRKxl0cN6CAoKeb93zOLE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Pravin B Shelar <pshelar@nicira.com>,
	Tom Herbert <tom@herbertland.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1 1/2] net: tunnel: fix stale transport header after GRE/TEB decap
Date: Thu, 16 Apr 2026 11:46:06 +0800
Message-ID: <20260416034610.8873-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278912-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,83181a31faf9455499c5];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 4FBE640A0BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a BUG.

I found that after GRE decapsulation in gretap/ip6gretap paths, the
transport_header becomes stale with a negative offset. The sequence is:

1. Before decap, transport_header points to the outer L4 (GRE) header.
2. __iptunnel_pull_header() calls skb_pull_rcsum() to advance skb->data
   past the GRE header, but does not update transport_header.
3. For TEB (gretap/ip6gretap), eth_type_trans() in ip_tunnel_rcv() /
   __ip6_tnl_rcv() further pulls ETH_HLEN (14 bytes) from skb->data.

After these two pulls, skb->data has moved forward while transport_header
still points to the old (now behind skb->data) position, resulting in a
negative skb_transport_offset(): typically -4 after GRE pull alone, or
-18 after GRE + inner Ethernet pull.

In the normal case where the inner frame is a recognizable protocol
(e.g., IPv4/TCP), inet_gro_receive() in net/ipv4/af_inet.c corrects the
transport_header via skb_set_transport_header() during GRO processing.
However, if the inner frame cannot be parsed (e.g., eth_type_trans()
classifies it as ETH_P_802_2 due to a zero/invalid inner Ethernet
header), no GRO callback resets the transport_header, and the stale
offset persists into __netif_receive_skb_core().

When this stale offset is combined with contradictory GSO metadata (e.g.,
SKB_GSO_TCPV4 injected via virtio_net_hdr from a tun device),
qdisc_pkt_len_segs_init() trusts the negative offset: the unsigned
wraparound makes pskb_may_pull() effectively a no-op, and __tcp_hdrlen()
then reads from an invalid memory location, causing a use-after-free.

Fix this by introducing iptunnel_rebuild_transport_header() which resets
and re-probes the transport header after tunnel decapsulation. If the
transport header cannot be rebuilt and the skb carries GSO metadata, the
inconsistent GSO fields are cleared to prevent downstream consumers from
trusting stale offsets.

reproducer: https://gist.github.com/mrpre/5ba943fd86367af748b70de99263da4b

Link: https://syzkaller.appspot.com/bug?extid=83181a31faf9455499c5
Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Fixes: 0d3c703a9d17 ("ipv6: Cleanup IPv6 tunnel receive path")
Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/ip_tunnels.h | 14 ++++++++++++++
 net/ipv4/ip_tunnel.c     |  2 ++
 net/ipv6/ip6_tunnel.c    |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d708b66e55cd..f160d82e6196 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -662,6 +662,20 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 	return 0;
 }
 
+static inline void iptunnel_rebuild_transport_header(struct sk_buff *skb)
+{
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+	skb_probe_transport_header(skb);
+
+	if (!skb_transport_header_was_set(skb) && skb_is_gso(skb)) {
+		struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+		shinfo->gso_type = 0;
+		shinfo->gso_size = 0;
+		shinfo->gso_segs = 0;
+	}
+}
+
 static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 {
 	if (pkt_len > 0) {
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..c46be68cfafa 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -445,6 +445,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 	if (tun_dst)
 		skb_dst_set(skb, (struct dst_entry *)tun_dst);
 
+	iptunnel_rebuild_transport_header(skb);
+
 	gro_cells_receive(&tunnel->gro_cells, skb);
 	return 0;
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 46bc06506470..f95348cf3c77 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -879,6 +879,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 	if (tun_dst)
 		skb_dst_set(skb, (struct dst_entry *)tun_dst);
 
+	iptunnel_rebuild_transport_header(skb);
+
 	gro_cells_receive(&tunnel->gro_cells, skb);
 	return 0;
 
-- 
2.43.0


