Return-Path: <netdev+bounces-279909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOk/J3J/5mklxQEAu9opvQ
	(envelope-from <netdev+bounces-279909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:33:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10143357D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E5E302C371
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0533C5529;
	Mon, 20 Apr 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNphstmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B43C552C;
	Mon, 20 Apr 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713549; cv=none; b=n6zlzjowC5C/4Mkmha4wMrKxQXmvdwOHdbVb5ncXJ53LWT+pk3f5E+yLUvtpe9hBnh6fRFcNJbSU0EK+XxqlS/hVip3xry1EnMk+MslKNqBni7nCtcJwjksJmpIl4tGP5OGKD7rqMhUAfipMW2363S2rt+BA8YAgAzZZADBUFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713549; c=relaxed/simple;
	bh=1OzBD3xQ60jnS1Gm5QB1Bf0BFGPMALZx9q04vcI4dns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fkh1d2olLjIIK8nXxL3C+Dc9jpcUYG46CwPCte2+P5q2hbrL6FCjlAHb9EbhmOD6bvzl8EYuh3ceINwBWsF+lxuL6x9qx9gagh44AEDYZND6F5Z1eBFlTGl2E/aJvWc79f3+YPMa+diwWsfB+17opfOeFxlpeR96thF6jUDlIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNphstmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6887BC19425;
	Mon, 20 Apr 2026 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776713548;
	bh=1OzBD3xQ60jnS1Gm5QB1Bf0BFGPMALZx9q04vcI4dns=;
	h=From:To:Cc:Subject:Date:From;
	b=KNphstmMsOchik8bsAPQYlZJe/3axADP8LagP1WJw9NAylsbHGzrKrzqc+amgAB+I
	 e9f6T2Ev8OLn+4XGL8+xKGj7mxDFFihJAtTUKx33nIspT3dTPu6ZKpAOsOy+d0+hEz
	 dh1qTSCQYWqxjCOLgTbD08KBozaCJ8ZwwF0wduYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH net] ipv6: rpl: expand skb head when recompressed SRH grows, not only on last segment
Date: Mon, 20 Apr 2026 21:32:25 +0200
Message-ID: <2026042024-cabbie-gills-9371@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 53
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=1OzBD3xQ60jnS1Gm5QB1Bf0BFGPMALZx9q04vcI4dns=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnP6j1yP/93MZB422Ro/+1Uzk4nL0abJ1azMvnVD7D4r /7J93xNRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExE4wLDgrm885JD9cPO8J9M YOdYUfihWO3lR4YFSzVvfnjss7ZNaKf2Thftj7ZbZ85dCgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279909-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: 2A10143357D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_rpl_srh_rcv() processes a Routing Protocol for LLNs Source Routing
Header by decompressing it, swapping the next segment address into
ipv6_hdr->daddr, recompressing, and pushing the new header back. The
recompressed header can be larger than the original when the
address-elision opportunities are worse after the swap.

The function pulls (hdr->hdrlen + 1) << 3 bytes (the old header) and
pushes (chdr->hdrlen + 1) << 3 + sizeof(ipv6hdr) bytes (the new header
plus the IPv6 header).  pskb_expand_head() is called to guarantee
headroom only when segments_left == 0.

A crafted SRH that loops back to the local host (each segment is a local
address, so ip6_route_input() delivers it back to ipv6_rpl_srh_rcv())
with chdr growing on each pass exhausts headroom over several
iterations.  When skb_push() lands skb->data exactly at skb->head,
skb_reset_network_header() stores 0, and skb_mac_header_rebuild()'s
skb_set_mac_header(skb, -skb->mac_len) computes 0 + (u16)(-14) = 65522.
The subsequent memmove writes 14 bytes at skb->head + 65522.

Expand the head whenever there is insufficient room for the push, not
only on the final segment.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Reported-by: Anthropic
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/exthdrs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 95558fd6f447..d866ab011e0a 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -592,7 +592,9 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
 	skb_postpull_rcsum(skb, oldhdr,
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
-	if (unlikely(!hdr->segments_left)) {
+	if (unlikely(!hdr->segments_left ||
+		     skb_headroom(skb) < sizeof(struct ipv6hdr) +
+					 ((chdr->hdrlen + 1) << 3))) {
 		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
 				     GFP_ATOMIC)) {
 			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
-- 
2.53.0


