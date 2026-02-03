Return-Path: <netdev+bounces-256208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIMGE3y5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F84D6860
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E08E930294EA
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A6306B0A;
	Tue,  3 Feb 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ZjG/GwDV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dk33P6ai"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D33939DA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109274; cv=none; b=gu9uBMgEbaRqz09/xEbCnT5tHKkX9+P1jMynL5opB261hNTuSa6XwmFoAYoiHGG1yfIucOWJn6z2Ghe63Nw6OR3XZ+iT1kkTdXYIMv4r78ceWUm4fZghQyBLI2ItOPLa0Cqw4IEMhyTqsCXBK2cQl2irU83UNU+WehE8IQhOsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109274; c=relaxed/simple;
	bh=3JHe7FiTFUwQRy/4hYbmde7RFRcOY4jtJ5vnPehd/M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQO0FAsWm1k27sYNQW+rSpSOqQE5k7Fc9TTMOGQJOdOyVksqHKyZDVrD8F5euBha2j9sPUplkZr0NIzq/wY1V6ynq4SNQflM2PZ3KX7Cw+xe2uJA0gRuupMKvJV7+fZ8lWNgBsbjR9yU/BHDTfKTbyS3/JRKGqCBzp0Mz+kBGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ZjG/GwDV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dk33P6ai; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 412541D00163;
	Tue,  3 Feb 2026 04:01:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Feb 2026 04:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109272; x=
	1770195672; bh=FXZhrJByUwhIx1Z1FrXCSPXXAJY5byEL1vC4PHA4p6I=; b=Z
	jG/GwDVmJXlM1rVBVs8sMRwI94oWAcIg94xlnfY6iTPwTt9yABvYUqstdX2cvw1x
	RQ81hATs935/2AfdLOyEVl4XZZozD9ONl1g/tlV35hGFzo1TwSVrKY4ixYntCmVX
	FXVf9WeLripYQxl7yL8PkNAyq3o0DLXun7orQWbAFhUmDX5iRScjjXnVsJSuaxiN
	KCtlQj4UK7J2ItTDiaKM0kwC0juyXo+AY69gDS7qFLYCE3TH5hJIenOwcr9CQYEF
	D0+OAkcMLxYD9Reuhech5GmzGb7IkoYeAVqNK7QNaSmPCzH0X35c/BjZUbnKwGWz
	iaEYgvbJEvSfP/5d4pefA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109272; x=1770195672; bh=F
	XZhrJByUwhIx1Z1FrXCSPXXAJY5byEL1vC4PHA4p6I=; b=dk33P6aiRZTvntI+F
	OpWRiGYfP3gc+igJ/TX9TQgW9+WIIYFNGcoF9WhJJJsNMWctNmrrT3/i4QV8B6yZ
	Du/8NnZxmhX89JYi7mVsa8Csj3z3UL00/wQpk32upWehWl5lw13GoPbDMWdMqhs1
	1il/Md1eJ0MdvtCFYnGli42FMLPGBknARd1wvmi/35mrgk10ZVxTvi+ye/wbXVSK
	3lYb9yLYlpeOA7/tgbO/F2QEMoW0wViaGcZ8VM7A/LsA0lOblsYiQHnDOXb6fzZv
	bwtIqrkG/vzDzBL8V/58k8zlo6CYaLcV7HLZxWeonASYHhwTKI/Ig9wJeHNQm+8v
	x/4SA==
X-ME-Sender: <xms:V7mBaagUCVUeq6zf9oifut-toCS4MtALpzOdk1MSzF9vOzUw3X8w4A>
    <xme:V7mBaRY6t2rIgk4ysK7oJClWAt7KC9LbOV9ZUUFT4hHQXLkNWemmiObRJjUDfGM_y
    m56rVxzHDM9ZCO_3VoS3e65Wae_wLbiu0J26k-C24JXT3XYuIQs4U0>
X-ME-Received: <xmr:V7mBaeWgayvcBdemgANvsi0gxUVl_imzNeV9KKge8i0vIKlIMljGyxJJwjEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:V7mBaRHf6n35pjRza4t3YH15hJmQufX-7NPjqJbhFiQfCiWNB30JbA>
    <xmx:V7mBaQZLAJwjMjToW2vZS9RJCSACd7rO5z7PNSavpciLzROplLmAkA>
    <xmx:V7mBaYGhuRqzJwpCPnzeZwxD2yhBniSMtNVmqFOzuvkhj6AXZyf8oA>
    <xmx:V7mBae2M_WKIZLFewuCvRYrfVwQ4qRykKYz_TD0jfHAl3e7MMZpKZQ>
    <xmx:WLmBabeY-nZWw3JAChqR2-W86TytQ8VF22K1NN0y3vmIz-fhQ3qvYdaH>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:01:11 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v4 12/12] net/ipv6: Remove HBH helpers
Date: Tue,  3 Feb 2026 10:59:42 +0200
Message-ID: <20260203085942.2477583-13-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203085942.2477583-1-alice.projects@fastmail.im>
References: <20260203085942.2477583-1-alice.projects@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-256208-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 39F84D6860
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the HBH jumbo helpers are not used by any driver or GSO, remove
them altogether.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 77 ----------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 024c2c2784cb..16bc7498c329 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -149,17 +149,6 @@ struct frag_hdr {
 	__be32	identification;
 };
 
-/*
- * Jumbo payload option, as described in RFC 2675 2.
- */
-struct hop_jumbo_hdr {
-	u8	nexthdr;
-	u8	hdrlen;
-	u8	tlv_type;	/* IPV6_TLV_JUMBO, 0xC2 */
-	u8	tlv_len;	/* 4 */
-	__be32	jumbo_payload_len;
-};
-
 #define	IP6_MF		0x0001
 #define	IP6_OFFSET	0xFFF8
 
@@ -462,72 +451,6 @@ bool ipv6_opt_accepted(const struct sock *sk, const struct sk_buff *skb,
 struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 					   struct ipv6_txoptions *opt);
 
-/* This helper is specialized for BIG TCP needs.
- * It assumes the hop_jumbo_hdr will immediately follow the IPV6 header.
- * It assumes headers are already in skb->head.
- * Returns: 0, or IPPROTO_TCP if a BIG TCP packet is there.
- */
-static inline int ipv6_has_hopopt_jumbo(const struct sk_buff *skb)
-{
-	const struct hop_jumbo_hdr *jhdr;
-	const struct ipv6hdr *nhdr;
-
-	if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-		return 0;
-
-	if (skb->protocol != htons(ETH_P_IPV6))
-		return 0;
-
-	if (skb_network_offset(skb) +
-	    sizeof(struct ipv6hdr) +
-	    sizeof(struct hop_jumbo_hdr) > skb_headlen(skb))
-		return 0;
-
-	nhdr = ipv6_hdr(skb);
-
-	if (nhdr->nexthdr != NEXTHDR_HOP)
-		return 0;
-
-	jhdr = (const struct hop_jumbo_hdr *) (nhdr + 1);
-	if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-	    jhdr->nexthdr != IPPROTO_TCP)
-		return 0;
-	return jhdr->nexthdr;
-}
-
-/* Return 0 if HBH header is successfully removed
- * Or if HBH removal is unnecessary (packet is not big TCP)
- * Return error to indicate dropping the packet
- */
-static inline int ipv6_hopopt_jumbo_remove(struct sk_buff *skb)
-{
-	const int hophdr_len = sizeof(struct hop_jumbo_hdr);
-	int nexthdr = ipv6_has_hopopt_jumbo(skb);
-	struct ipv6hdr *h6;
-
-	if (!nexthdr)
-		return 0;
-
-	if (skb_cow_head(skb, 0))
-		return -1;
-
-	/* Remove the HBH header.
-	 * Layout: [Ethernet header][IPv6 header][HBH][L4 Header]
-	 */
-	memmove(skb_mac_header(skb) + hophdr_len, skb_mac_header(skb),
-		skb_network_header(skb) - skb_mac_header(skb) +
-		sizeof(struct ipv6hdr));
-
-	__skb_pull(skb, hophdr_len);
-	skb->network_header += hophdr_len;
-	skb->mac_header += hophdr_len;
-
-	h6 = ipv6_hdr(skb);
-	h6->nexthdr = nexthdr;
-
-	return 0;
-}
-
 static inline bool ipv6_accept_ra(const struct inet6_dev *idev)
 {
 	s32 accept_ra = READ_ONCE(idev->cnf.accept_ra);
-- 
2.52.0


