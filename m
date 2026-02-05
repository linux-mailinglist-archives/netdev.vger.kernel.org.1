Return-Path: <netdev+bounces-257172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gvEmKLmehGkL4AMAu9opvQ
	(envelope-from <netdev+bounces-257172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:44:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE8F378E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05253071209
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4F2367D5;
	Thu,  5 Feb 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="W2sKXUfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxZWCxRl"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35623ABB9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298787; cv=none; b=fjPod5E8sksgwdCji5KVvgb2NJfF62+3R6Xt9uS8f9YuR6RTFTNuHe36c6X3LpEfQH8sOysJ67JZ3NbGjp9Ca1NUfAGqWVLVAu9DZmkoX1eX7XzdHmX0Eou8K+mEFloW/PZDPoTt7qrnlkDjtdJLZTK2NOetTycbEQSkB9ioX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298787; c=relaxed/simple;
	bh=XfBbUtdeCOggmzFbfGPly0dwGJZ1OAJ7o89hXKkLigQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4DrE8EGpxqNn5RWfHYYxPRrhQSAl+FjOcNSZCi51s4CA8IYIp3AUAVP+O3zebCUEZ4MPQSAoG/Oq8qsT22BmxZ1t+yxln3bVtKWxhjN1iPkkMUJHcIjex8y93ZC0HsRdFLdVq5dSA2ky7OKRzJe2Z7ovbdnaCdk45iMNbhmK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=W2sKXUfh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxZWCxRl; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FCA37A00AF;
	Thu,  5 Feb 2026 08:39:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Feb 2026 08:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298785; x=
	1770385185; bh=rGfOmO6KX34ilrrYaNc0cDucv8I4Mz/2rVVgkjb+kdw=; b=W
	2sKXUfhsHkjOyK4CvHJ06ASM1V9MBotFEfRGn6rJPuGh6gf1zXDp3NO9tJYm/3KL
	00bunFuQd7sT8P21IKMWtC2x827alVU37U9s5k/zMx1tMQnt06XxUu6yPiVbETo/
	q28MPRmPve9twb2IFjTu/SJz+Bb2SIPJt93jq6IYlP4Pjf3oGGX3fv8ZLaP9mp0C
	1IsWiQiy9EPUWS4fujUDCyZu7Sc69/V1I636Hd7iDQ2hcUvRPqfKjZasU0Dr5yaj
	77uIErcZW7DH2vFBNIp+/i4ARXc2mWC41zXiz+/CmA80dBcc8qM+1uhVhW1izHU3
	7UwsKJskDtZmcA64iIQpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298785; x=1770385185; bh=r
	GfOmO6KX34ilrrYaNc0cDucv8I4Mz/2rVVgkjb+kdw=; b=mxZWCxRljGnjjSDJG
	UIweHbYHKht+dLyHBJ3kevkvRiQIW3ntm8Uu9OvJmxh9h4jD6wWGYLM+NrSvQXqr
	UXYdtmzObx54lDATxM6Ao4Lkc3L5g9gMhKnRcTP9ul5+pPF1wq88MrM2qt7g/aFH
	TvokPt3j25KpJokxTz06ANnoEzEQSMXKoNOSV4bMfHyg0Purz8hDLoKfrm1qqoRJ
	Yz4f9Jx1OO6pE9bY/jv6157JcVAN/twXyS81gsnlCX/JL2ChX+MFgILiBYs0AbGQ
	Ur7cV3yITR2PpTwk6LkN7vmFj3cVusKAiitGEb0JhN+ozYsAZ7fqxiVubY+CA0tI
	3ksHg==
X-ME-Sender: <xms:oZ2EadGFCfRVxcSJWuCMnir8mAWlyJ5w_L66PGDzExfvPVk5Lu6_Sw>
    <xme:oZ2EaYs-XmMMRtzyjByCyd1GisMtiJAb0bJHPER4IZz45a7teh-2M0-9PWjbg5sne
    fhFu1IH2L28t0o5zbqgEiTFsvSam98WOgJDW-VS7NRyElLIc0bcZmM>
X-ME-Received: <xmr:oZ2EabakZapvbSP0bfW-b21CZpVFOzx0DF42A7ARIjxZ8MLKEqeZhXz2E1CD-iHpoYNkow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:oZ2EaQ5FePDKWkVS8UFItoUPFVCr-ZqRhDIvBkCCbmgTT1pbgNQdlQ>
    <xmx:oZ2Eab8FEtdJXu-nPrtrhBJcMelkufGlN3sViBsRT47DX8-khRMl0w>
    <xmx:oZ2EaUZYlL9mUlgf--uxW7qn8p6Il_ryjVwQlvWAMoiUzPCnByojbA>
    <xmx:oZ2Eac5c7meH7zf2IdkGun1uYqlizEFN__kb3_M7IUkviz5A-Q13vQ>
    <xmx:oZ2EaZxzzG1o_rv8IqVkTaVbCO_AV-DkloqEV8aW0voOofqrSBGJqc_s>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:39:45 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
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
Subject: [PATCH net-next v5 03/12] net/ipv6: Drop HBH for BIG TCP on RX side
Date: Thu,  5 Feb 2026 15:39:16 +0200
Message-ID: <20260205133925.526371-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
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
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: E4EE8F378E
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Complementary to the previous commit, stop inserting HBH when building
BIG TCP GRO SKBs.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/gro.c         |  2 --
 net/ipv6/ip6_offload.c | 28 +---------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index ad326c7cdc0a..2241d9c2c140 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -115,8 +115,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
 		if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
-		    (p->protocol == htons(ETH_P_IPV6) &&
-		     skb_headroom(p) < sizeof(struct hop_jumbo_hdr)) ||
 		    p->encapsulation)
 			return -E2BIG;
 	}
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index ceb4752a5358..c44bb5812484 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -336,40 +336,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	const struct net_offload *ops;
 	struct ipv6hdr *iph;
 	int err = -ENOSYS;
-	u32 payload_len;
 
 	if (skb->encapsulation) {
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
 		skb_set_inner_network_header(skb, nhoff);
 	}
 
-	payload_len = skb->len - nhoff - sizeof(*iph);
-	if (unlikely(payload_len > IPV6_MAXPLEN)) {
-		struct hop_jumbo_hdr *hop_jumbo;
-		int hoplen = sizeof(*hop_jumbo);
-
-		/* Move network header left */
-		memmove(skb_mac_header(skb) - hoplen, skb_mac_header(skb),
-			skb->transport_header - skb->mac_header);
-		skb->data -= hoplen;
-		skb->len += hoplen;
-		skb->mac_header -= hoplen;
-		skb->network_header -= hoplen;
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		hop_jumbo = (struct hop_jumbo_hdr *)(iph + 1);
-
-		/* Build hop-by-hop options */
-		hop_jumbo->nexthdr = iph->nexthdr;
-		hop_jumbo->hdrlen = 0;
-		hop_jumbo->tlv_type = IPV6_TLV_JUMBO;
-		hop_jumbo->tlv_len = 4;
-		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
-
-		iph->nexthdr = NEXTHDR_HOP;
-	}
-
 	iph = (struct ipv6hdr *)(skb->data + nhoff);
-	ipv6_set_payload_len(iph, payload_len);
+	ipv6_set_payload_len(iph, skb->len - nhoff - sizeof(*iph));
 
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 
-- 
2.52.0


