Return-Path: <netdev+bounces-256204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CBAK2a5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E6D684B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDF2B301FBE8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB052DB7AE;
	Tue,  3 Feb 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="OzbHS9z1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjBh/QhW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C32299A8A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109262; cv=none; b=efXlmD1dcIWwXbJ7JmDYV+GLGbYebo+iHZY+cLLNKugpqODcuNxQOx+IPbQFB6HkdCU2/ZhM4hMO6X3s9RKcMG9jdotLGKuMiYVyn1K1lLlFb665x2yxCyyAThNbHat7VWzLRzZi/vnsQHqCjMl+St8DP2gz43bBB5b6IdYr6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109262; c=relaxed/simple;
	bh=S1IpjsDQA+CRKQsl7hzKrpgUzjODiG67xclFnsKgBWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFTtmRIiW4rlroIN1CrknOJAgMeXjdyi7OiVPF0MKsyJO3IUzFVJ3UXUaBeHNZs6VVEbbcbQaIhmCOsJZRiv4F68KxRyJ2gg5MqCzLvYYgPcOurpxt+MAsSx/2t74rAuAm64Cihbm3HFYZl/RSESb7rUg3QSOu1SFpIyvPkP80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=OzbHS9z1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vjBh/QhW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A50C01D0010D;
	Tue,  3 Feb 2026 04:01:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 04:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109260; x=
	1770195660; bh=nptxjRVHlkEYO2dRr8+lZ6tO1As3zTIiLWdojpiEvl8=; b=O
	zbHS9z1q/ZyKdZrdlNez3k7iW3yiuKaPvGY+uUCrfRzZNq7MNqw3i1vmJt19Z011
	oW6LFZw+qjSkdjjoLCMSI83rvMz3raiN9QHS7HW044GZfIAY2AwEZtDCR+Y2oFdh
	duJ9XbQNXdQLoSRPvS5hB5vYBYat9MyXjQD06T9rFO6ppf/x3uPszqhQ73jsEsyr
	V7ZEyMTZ3OnMgVtFq0JMHs7lreSMIG44Te5fLxGDtn7b87jOlaDooFoLDsZqwASZ
	yutj23g6hxc4cdleyycAJt8aQ0ZYgTiG79Km+IPaZUDv93PTa9x/ZKY8lGmEAHKY
	s9dVTaV7iAZc5rW27S+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109260; x=1770195660; bh=n
	ptxjRVHlkEYO2dRr8+lZ6tO1As3zTIiLWdojpiEvl8=; b=vjBh/QhWlfiuHkTCL
	HoXhRvmguCOjuThFedi+7DVN6YKMWK4sRiI/HrUmzgU6Pk7t9rTicD/n+Hi1M8xl
	RC5/qhv6bJ8CzXZCLmMbdG3C7Fa7WDv9AmYjB4mHPtI/R61gW352AiQA3uDzIz2F
	mueMk2I23SaajYin4CB6akCFsYvJTfRxSQvyDoHabOD+d7m63BPchv7hwFCtLSGt
	JJSarhjHjrZTjKf/Q5eeyYRsi8pCNljE9BT+MFuwE0JoEGdN6vXuqa+hzJJoAPgQ
	9P/mS/U8wR8Ge5TiQULcbHvYBZOuns3t/lVpjXUaft91aKKd5frBfUtqlD2XZ4Mg
	z141Q==
X-ME-Sender: <xms:TLmBaZGRv8UWqC8jJ93OtWKraJC4sK5vdC_FFrBE1gjZHwZd5tvooQ>
    <xme:TLmBaSA0y9xQ4WxSuUtpbydawfWYRjPG8TVdB-GVjvtQBaq-cHQ7_z7-2TI-avfma
    EgVrOH2i7J6Z2tKwXFZ2yXuhGXn5jLaTegteDZv6_duQdmWlWyPfck>
X-ME-Received: <xmr:TLmBaTw_USgA5MomCjG8TAWfKj6qnnuIYirD9LubZJJQQ2L8hK23AiXBpEli>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:TLmBaQccOK0BuLE1jCrtrE2mHLpPTwPyvuuwW5PVeD26aBcJRuPjuw>
    <xmx:TLmBaQvB8DGQ8URKutcmTotuOyhqkIn2RPEkdV9Mz0-pBmS3V8QX-w>
    <xmx:TLmBadBSNK_pdUbv11lTmJIbJnA6LS5Hdct8pnCcvboGgEBwTWlW1A>
    <xmx:TLmBaQG26TXLAWQvv3hjzxT9hP2cjTk2g3LWUYtqx0DG30wfDxXQVw>
    <xmx:TLmBaWyy58QLHIyyowvSmdE4oUtXFbEWCGDh6hw8d73SZDqo47itUNY7>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:59 -0500 (EST)
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
	Alice Mikityanska <alice@isovalent.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v4 08/12] bnxt_en: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:38 +0200
Message-ID: <20260203085942.2477583-9-alice.projects@fastmail.im>
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
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_URIBL_FAIL(0.00)[broadcom.com:query timed out];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256204-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RSPAMD_EMAILBL_FAIL(0.00)[michael.chan.broadcom.com:query timed out,edumazet.google.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 8E7E6D684B
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the bnxt_en TX path, that used to check and
remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 466e0fc6141f..7d63d6b0d2c2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -517,9 +517,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -13881,7 +13878,6 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 			      u8 **nextp)
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + nw_off);
-	struct hop_jumbo_hdr *jhdr;
 	int hdr_count = 0;
 	u8 *nexthdr;
 	int start;
@@ -13910,24 +13906,7 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 		if (hdrlen > 64)
 			return false;
 
-		/* The ext header may be a hop-by-hop header inserted for
-		 * big TCP purposes. This will be removed before sending
-		 * from NIC, so do not count it.
-		 */
-		if (*nexthdr == NEXTHDR_HOP) {
-			if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-				goto increment_hdr;
-
-			jhdr = (struct hop_jumbo_hdr *)hp;
-			if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-			    jhdr->nexthdr != IPPROTO_TCP)
-				goto increment_hdr;
-
-			goto next_hdr;
-		}
-increment_hdr:
 		hdr_count++;
-next_hdr:
 		nexthdr = &hp->nexthdr;
 		start += hdrlen;
 	}
-- 
2.52.0


