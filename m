Return-Path: <netdev+bounces-298317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8pMrORkNK2qL1wMAu9opvQ
	(envelope-from <netdev+bounces-298317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668D674C1A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="i EgpnDj";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=ilT7z2VL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298317-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169CB322CFAE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB6E2D73A6;
	Thu, 11 Jun 2026 19:30:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3829DB9A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:30:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206256; cv=none; b=YUP46owC77sXJ653508aRh9k0CzjEMKYMJzPENpefmBDqPUCVo7KTU4TeEEfxh9O9yUVOIKnZl5/d9246LXAfCMeKiloGgBP4NBTOI1JbinYahtxQqPZTJsTR2NLj2mYUS4dwBpVzH13NiHcYS2wf5KN8WTF2zXaHpuUKVI1uPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206256; c=relaxed/simple;
	bh=gFAFzYvCaVTEsxAy6p2q351RenuQWebNQQ4JS36f8Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EChFuYyraMTrfTF/bR0pnRqxdQFSGB80wtGown6SB8esUfXpZtA1yu9YlW/lDqozMbaRUs8fIM876rqTElZW363ov0P7+H+axEBG08wvyGCxUyr1TTc/7BOQdLxOwTD7SbAqfC67kEFgpsZ9rXFeeqFvQ9ItOx98k7uqA7yMBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=iEgpnDjn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ilT7z2VL; arc=none smtp.client-ip=202.12.124.147
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D000B1D00105;
	Thu, 11 Jun 2026 15:30:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 15:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206253; x=
	1781292653; bh=hY/jevllQjO+c3DLoaRQ0lQlfwC6hnj/afvU4L5+TX0=; b=i
	EgpnDjn9CKR9Odh3uiPX6vBORn6JZT00dE9xKKwMz+Y/WQrdCc86MINloTYekri+
	GQ2vfgScxaafPH3f4H0X8QRNQ1cRTiGDt2YPTx+asvo0KCxAPLgt851hSgWxtCT3
	TvXOnfgoJHbIWrtbuTGqXPSG5tV9mVPnza1wu/SaJJ42M6tl/klt/OdFmsy0tIRP
	pYri5C8DEFwXWUjDtkvOOunTP89Pd3wB/ik+VV67BENeCEjnNP+qV/kUbaFut+Xy
	xtp7xgobDH+KRRToTLGFuTrtrIMn7RcM3vnvFxT63FNtEwCMk3dXc0dneKz+40Sk
	Wc2b0VWYttzy69tysHnvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206253; x=1781292653; bh=h
	Y/jevllQjO+c3DLoaRQ0lQlfwC6hnj/afvU4L5+TX0=; b=ilT7z2VLq8HkAdnnX
	QKxS94SDzwj+J+JZxAx1yLde4pFUZ/Hms4ujUGN7zGTf8YVhZKxezzXM3zWjALns
	Y4EvhGwjacLeAjjRN6dWbLlLBNyUlziZQHYa6y0ljPAk3WFejjaqhbN/3SjEfQBN
	p551KBL3CbnzrKBg3ZlYC4elQ8WFH1FiPeNO5IwcnDr/DX6Z60zAgT1oK55iAPSz
	XmxwczaXPzQg5/4RfQJ0ltxQCN5v3jAWt69k4JOOJhyit7MhfmqmxTyVdOM3y0Ae
	/yo+7raingCD/glwKdxDOYEsfOhTJmRhaq097EQ7VZUNwkuvtxDjX71QtdI9CRD3
	nUO6w==
X-ME-Sender: <xms:7QwrarDMYQt9s7On_ZeTwP2eSrMnJ7zU0ErG1YI8xQNf8Qd8BE9E9w>
    <xme:7QwragCFUOjZdJKugHIf-J5-hWDeRPE35GFXJ062rPXDh94zj4hIJ2Qe2jQ2bSRnS
    spJCQB6jnwXckJ3vTGaDPkFgaAGn10rMbZa_0NV0QGzjzSnpBwT69k>
X-ME-Received: <xmr:7Qwrata8wlPlUmgSuazzQrjZHrzTTKbePjyIyQxnOI_ofBlZXGUEkZMo4_iicsZhHdq0wiGfSY2I-RNS94N3uAs>
X-ME-Proxy-Cause: dmFkZTFq1Wcw3/M2CBYaD2/qBgLYlFPqODgL3cuIg6+q1V9W12tQSNSIrk79vPv5Qe2GVj
    Vy43eGLOhWkrdq0SboSppJwe9mLjyW1B1VgP6DS3VNYUa4pSe2xJ5YjWIjx4HUdfALivQX
    /7WjktZEG3lcRUp0bcxpI4RSr8oWng16AWaHiAMK4voCtH3legFRQ07cc4ipEeFCjv1Ymc
    XvCwbPLBc1zYanOAc564s7qzW6ipvpsUt+4c3GBzCndJaQFi7iOOcZ6uz+4dSzg3JM/ub8
    vNQR1+Sg8mwQhDRy6Zk9/n7JmOPQh0pX8df5q7MAV+PDC5kr1IZws5oauC+99+9l+XUfsv
    GTtFJbB3R0Q4yTBQy5oIIJXKWguaqFfiQSY/T16G04vpEgCnLkQo1sBy1Sl7l3DWpTUpkg
    uSpdNU0nkds9+JDYwfaVWp4/Clp7Ui56k6MgSlUrFaj1W7jAhX4CJWz8DGdG2E4I6NRpxt
    1uQYTzMGIHb7h374nWUDuU82j8TbbivoVO1el1bukuTcNZKuGJ8ZhhDT69J2pBu67CZ9B+
    5QPOiRZV3BB+cs+L4ZrakRBUTsGlZX+Ns+f4xVM0eb0j0XWsTQp+NJIpsPnXp5rFWJhMiy
    tKqvtuyWm2rXyJQaz9R4nI0mxCOJu7SEG2hVrX2MPxK7EmqvZS3bsFxB8MMA
X-ME-Proxy: <xmx:7Qwratz2QBrPLOLWGMXsVS3hx4uE2oYVJ6CeNs_hhYJMJk6U6uNCKQ>
    <xmx:7QwraocBQrafblVp_aqIvqaHt-oE9dLSlHorTnpCLi5wGA8OuPqUaA>
    <xmx:7QwrarJuJp7FzC2cqqBBnU4j9Bx9pnL3pylu_zMB4ixmfahgmXLUFA>
    <xmx:7Qwrap0TliQU6bNBRsztibA4ICdRDooFRN_eqU8_S_pm_hX9nMmIrw>
    <xmx:7Qwrau8hXp2CydKLyZi1Bnzu9Lwxam2T2hNgPz4smTxO8DAlxKikbWPX>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:52 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v7 06/11] udp: Support gro_ipv4_max_size > 65536
Date: Thu, 11 Jun 2026 21:29:50 +0200
Message-ID: <20260611192955.604661-7-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime,isovalent.com:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4668D674C1A

From: Alice Mikityanska <alice@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in udp_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in udp_rcv.

Additionally, restrict handling uh->len=0 in udpv6_rcv to BIG TCP and
jumbograms only by using the udp_get_len helper.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c         | 4 ++--
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp.c         | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 240a1adab278..3713ae77606f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2591,8 +2591,8 @@ int udp_rcv(struct sk_buff *skb)
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	unsigned short ulen;
 	__be32 saddr, daddr;
+	unsigned int ulen;
 	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
@@ -2606,7 +2606,7 @@ int udp_rcv(struct sk_buff *skb)
 		goto drop;		/* No space for header. */
 
 	uh   = udp_hdr(skb);
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len(skb, uh, 0);
 	saddr = ip_hdr(skb)->saddr;
 	daddr = ip_hdr(skb)->daddr;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 493e2b9e16fb..4f9a3922937c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	struct sock *sk;
 	int err;
 
-	udp_set_len_short(uh, newlen);
+	udp_set_len(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -956,7 +956,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 913a19edfc7c..e434d52cc049 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1081,12 +1081,12 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 	daddr = &ipv6_hdr(skb)->daddr;
 	uh = udp_hdr(skb);
 
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len(skb, uh, 0);
 	if (ulen > skb->len)
 		goto short_packet;
 
 	/* Check for jumbo payload */
-	if (ulen == 0)
+	if (ulen == 0 && inet6_is_jumbogram(skb))
 		ulen = skb->len;
 
 	if (ulen < sizeof(*uh))
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index c92cf5ee3e6a..7370bcb80332 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -171,7 +171,7 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
-- 
2.54.0


