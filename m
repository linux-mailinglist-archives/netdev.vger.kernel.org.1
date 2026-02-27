Return-Path: <netdev+bounces-261989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKtzGb8Vomk0zAQAu9opvQ
	(envelope-from <netdev+bounces-261989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:07:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D250F1BE7D3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32CF8300EC97
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E847A0C4;
	Fri, 27 Feb 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="eM9ARlN3"
X-Original-To: netdev@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F8478E49
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230075; cv=none; b=aUt4T8gFzd30L1xVu0XUYFgmEfMDgCOr81QYZsEo/5eT88f+KldCAPbzdCmZ8xtsTzw1EbjZP2bcrPgaKeYT2aOm0AS3RVhAblrBqVbIHzQ0tiHKFwRL6DNtu3D1AnRExTLEx5/IfYJHCiZ7epVT0KcQ5IdFSNUqw9toHNpG1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230075; c=relaxed/simple;
	bh=cTvfo14QCrbH8Fd9QeN1Edjru3NpEnm8gD5cfG57zOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXmpZ8guGn7LkbYi4hmMhX71OquNZ7QbTdEG2VlIuvOd4d+ecBsAuETYz8IT5xuVnRCg9lPZghVpaaLFYXU4VA+bBGvzrgQU/LD4+LZtQOiJHSNnIR/1Rs8Z6ND15/XPSjeIB3pLz8Z/VM1K7hk2juzLavhIW3uDFm9AgWNxbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=eM9ARlN3; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id BE0BB17FF94
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:07:44 +0100 (CET)
Received: (qmail 4557 invoked by uid 988); 27 Feb 2026 22:07:44 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Fri, 27 Feb 2026 23:07:44 +0100
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] l2tp: unify headroom calculation
Date: Fri, 27 Feb 2026 23:07:38 +0100
Message-ID: <20260227220740.11928-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227220740.11928-1-mail@david-bauer.net>
References: <20260227220740.11928-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=cTvfo14QCrbH8Fd9QeN1Edjru3NpEnm8gD5cfG57zOo=;
	b=eM9ARlN36G+frQ+NKPkWxEC1LMUDh4d6tgNYrhFY3qM0BmFUTd4AbNWJP1VhVIjiCNTs1QIQbZ
	IFWlElfmOfvlIF8kRhkqYdKyoL/RUMvtteeMwtYieve5V+fo+VZm8P2PplbyjfR783MNmA+fI+kV
	rSU2RJjyjzahLF62nSqsaAy4yXQsljeh3Yn3kTYgZ+AbonhplTFAOPJZv4+yW+b1P9bbzsu571vp
	PquNN5uCBFMuch/GO8A+aUgSL1KfyyYtPtkKx/kpICbnvN0n4eU5Q+C5On3m7xJ8wEWoXynX4Eya
	qEh7+63biWz25TFIluneLApbtuQu5LtwrXbRNV4APYBX40fFalaZ7b9g3OYWXaGI/fPZgGmRhQiw
	wYOLPX5zGLAoG557PdHDWAelAPv5ZQ21geRxeAR7HrCUsoHOzqPEOzS+imy+HBxkKIJhmfyHWZYt
	lxCcSr7HbyEes3ItPVLCD1YTnTYeWFzZW0D5Rvca4rd6dUSqKV59E9/zEIr+Db1x6SGeyzA4lMYC
	uz+6rT/evDVVHH1jZDfUQfn95ANdqMJ0asM/ozeyP7sVtpcoKC9BP4WEObCEPeoG/lmIN8tCbEHN
	Q31Iy1T69Td0yjWZmluFtj3At5TnZLVTM0ybwcG7kJPgyZacHu8JrIhtitOg6aqzl816qCDXRLeT
	0=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[david-bauer.net:mid,david-bauer.net:dkim,david-bauer.net:email]
X-Rspamd-Queue-Id: D250F1BE7D3
X-Rspamd-Action: no action

Unify the calculation to determine the required headroom for each skb.
This was previously done inconsistently, resulting requesting more space
in the skb headroom when crafting the L2TP header than indicated with
needed_headroom.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_core.c |  8 +++-----
 net/l2tp/l2tp_core.h | 17 +++++++++++++++++
 net/l2tp/l2tp_eth.c  | 14 +++-----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index bb19c11b0af8e..a726bdc0d6204 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1226,18 +1226,16 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	struct l2tp_tunnel *tunnel = session->tunnel;
 	unsigned int data_len = skb->len;
 	struct sock *sk = tunnel->sock;
-	int headroom, uhlen, udp_len;
 	int ret = NET_XMIT_SUCCESS;
 	struct inet_sock *inet;
 	struct udphdr *uh;
+	int udp_len;
 
 	/* Check that there's enough headroom in the skb to insert IP,
 	 * UDP and L2TP headers. If not enough, expand it to
 	 * make room. Adjust truesize.
 	 */
-	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
-	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
-	if (skb_cow_head(skb, headroom)) {
+	if (skb_cow_head(skb, l2tp_session_skb_headroom(session))) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
 	}
@@ -1289,7 +1287,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 		uh = udp_hdr(skb);
 		uh->source = inet->inet_sport;
 		uh->dest = inet->inet_dport;
-		udp_len = uhlen + session->hdr_len + data_len;
+		udp_len = l2tp_session_udp_hdrlen(session) + session->hdr_len + data_len;
 		uh->len = htons(udp_len);
 
 		/* Calculate UDP checksum if configured to do so */
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index aab574376d95f..635a6e01f417a 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -335,6 +335,23 @@ static inline int l2tp_v3_ensure_opt_in_linear(struct l2tp_session *session, str
 	return 0;
 }
 
+static inline int l2tp_session_udp_hdrlen(struct l2tp_session *session)
+{
+	return session->tunnel->encap == L2TP_ENCAPTYPE_UDP ?
+		sizeof(struct udphdr) : 0;
+}
+
+static inline int l2tp_session_overhead(struct l2tp_session *session)
+{
+	return l2tp_session_udp_hdrlen(session) + session->hdr_len +
+		session->tunnel->l3_overhead;
+}
+
+static inline int l2tp_session_skb_headroom(struct l2tp_session *session)
+{
+	return NET_SKB_PAD + l2tp_session_overhead(session);
+}
+
 #define MODULE_ALIAS_L2TP_PWTYPE(type) \
 	MODULE_ALIAS("net-l2tp-type-" __stringify(type))
 
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 9e5f9deac08cf..29380fae02475 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -190,12 +190,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	unsigned int overhead = 0;
 	u32 mtu;
 
-	/* if the encap is UDP, account for UDP header size */
-	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
-		overhead += sizeof(struct udphdr);
-		dev->needed_headroom += sizeof(struct udphdr);
-	}
-
 	if (tunnel->l3_overhead == 0) {
 		/* L3 Overhead couldn't be identified, this could be
 		 * because tunnel->sock was NULL or the socket's
@@ -204,10 +198,8 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 		 */
 		return;
 	}
-	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
-	 * UDP overhead, if any, was already factored in above.
-	 */
-	overhead += session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
+	/* Calculate required overhead */
+	overhead = ETH_HLEN + l2tp_session_overhead(session);
 
 	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
 	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
@@ -215,7 +207,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	else
 		dev->mtu = mtu;
 
-	dev->needed_headroom += session->hdr_len;
+	dev->needed_headroom = l2tp_session_skb_headroom(session);
 }
 
 static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
-- 
2.51.0


