Return-Path: <netdev+bounces-280124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sABPHvZ552ml9QEAu9opvQ
	(envelope-from <netdev+bounces-280124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8C43B404
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B979630584AF
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE135AC2C;
	Tue, 21 Apr 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/mS8NzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7111332601;
	Tue, 21 Apr 2026 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777399; cv=none; b=a7oxn6SHq8AKYrDgB78dfLlR/un4OAObMkbwphji9Q+pGflxFfxMqESupsL5wWKF/eSVdsX6s1eDCCuP8lHjA4cp7u04vxU/rM9oXP8+u+sleBn9Q4ghscZrpETUScJqmRPGuaHOnPcFyI6ubgCzWfMHI39gvYN7td2tuuWpU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777399; c=relaxed/simple;
	bh=ekt9fYtNIVi9m3EuA4i7Ty2Mqhgg/HkpSTdKUOnAZVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+F1RvcTTs0OujF03ZObOGqG3S+AFbIg0klyl+3lA7atN/b9Ql7+1FIni9JS3kDffdY2kWC4wMGElDok0yReg8668F31aKEU0UCu0jF4Xq311Q3SJdKgtZeDByekjbndzLy28XD1tCl9K86A89D0bWNwnV4W2P2KjWnJRyDZvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/mS8NzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F289C2BCB3;
	Tue, 21 Apr 2026 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776777398;
	bh=ekt9fYtNIVi9m3EuA4i7Ty2Mqhgg/HkpSTdKUOnAZVE=;
	h=From:To:Cc:Subject:Date:From;
	b=Z/mS8NzXF7NuPFTLb/MO4Jhdoh3onaJfpkcg8C5t/tHUO609ul4CJR989EmoFqKZS
	 54x9DUnXkXPOwBPq5VrNeasCPQtac1CDjxApcjhxXJGuVVfpOk+a+fCc0SBY5mHiv2
	 Zj1yg2s23AgwbWP2oarpqcAEpOGJBgnsdXmsriuY=
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
Subject: [PATCH net v3] ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
Date: Tue, 21 Apr 2026 15:16:33 +0200
Message-ID: <2026042133-gout-unvented-1bd9@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 85
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=ekt9fYtNIVi9m3EuA4i7Ty2Mqhgg/HkpSTdKUOnAZVE=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnPKzbmf0gSYaqZwbvM7PfxisSw15PTbVZen7okLWBlx u6GomPKHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAR0ysMC1bPst+0o+X7ihdt V1mc8jOK/jEqr2KYp17O8SRXks3lIY9V78/Nytn/xdwnAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280124-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7B8C43B404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
header and pushes the new one plus the IPv6 header back.  The
recompressed header can be larger than the received one when the swap
reduces the common-prefix length the segments share with daddr (CmprI=0,
CmprE>0, seg[0][0] != daddr[0] gives the maximum +8 bytes).

pskb_expand_head() was gated on segments_left == 0, so on earlier
segments the push consumed unchecked headroom.  Once skb_push() leaves
fewer than skb->mac_len bytes in front of data,
skb_mac_header_rebuild()'s call to:

	skb_set_mac_header(skb, -skb->mac_len);

will store (data - head) - mac_len into the u16 mac_header field, which
wraps to ~65530, and the following memmove() writes mac_len bytes ~64KiB
past skb->head.

A single AF_INET6/SOCK_RAW/IPV6_HDRINCL packet over lo with a two
segment type-3 SRH (CmprI=0, CmprE=15) reaches headroom 8 after one
pass; KASAN reports a 14-byte OOB write in ipv6_rthdr_rcv.

Fix this by expanding the head whenever the remaining room is less than
the push size plus mac_len, and request that much extra so the rebuilt
MAC header fits afterwards.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: stable <stable@kernel.org>
Reported-by: Anthropic
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: - skb_postpull_rcsum() should not be changed, it's chdr NOT hdr, ugh
      Link to v2: https://lore.kernel.org/r/2026042158-sediment-elliptic-a954@gregkh

v2: - fixed up if statement to actually work properly, and test it
      against a working poc (poc will be sent separately)
      Reworded the changelog and the subject to make more sense
      Link to v1: https://lore.kernel.org/r/2026042024-cabbie-gills-9371@gregkh

 net/ipv6/exthdrs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 95558fd6f447..03cbce842c1a 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -491,6 +491,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *idev;
 	struct ipv6hdr *oldhdr;
+	unsigned int chdr_len;
 	unsigned char *buf;
 	int accept_rpl_seg;
 	int i, err;
@@ -592,8 +593,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
 	skb_postpull_rcsum(skb, oldhdr,
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
-	if (unlikely(!hdr->segments_left)) {
-		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
+	chdr_len = sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
+	if (unlikely(!hdr->segments_left ||
+		     skb_headroom(skb) < chdr_len + skb->mac_len)) {
+		if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0,
 				     GFP_ATOMIC)) {
 			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
 			kfree_skb(skb);
@@ -603,7 +606,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 		oldhdr = ipv6_hdr(skb);
 	}
-	skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));
+	skb_push(skb, chdr_len);
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
-- 
2.53.0


