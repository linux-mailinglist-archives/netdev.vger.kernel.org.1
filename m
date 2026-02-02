Return-Path: <netdev+bounces-255986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLhlKJf6gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:27:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1BD0831
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97175301E3C6
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECD301016;
	Mon,  2 Feb 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="G7Ot6qVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tIGNj1dn"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74A301702
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060246; cv=none; b=tucYrvuHDPRGNV3KIng3LGkdavOwHzEQGkgf6dssqcut8vYH0NmpSDeFg8FmHy6vyf8cVOpgW3Z8mq3IfK8+M59ihfrcAZDHgvNM+dRwrMElJjUh1V/H3DJgy6BXFn+YKTzvaQ+hcyusfVW215X7KPQYr7f8t+NEKKJlGFKsUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060246; c=relaxed/simple;
	bh=aHdseTlKh3Na6zVBUh0AEiVzkK4t5o53LGHd6wgARR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh4WrLZAU27jjWbOw5atFoB+barnKbu2+421umWty2KK+MReSJGK9IZvYqiDKFKia8dKXgHjFfOZSrb6unVYfO5b52XGHFKgoZPFAmkMh9nps5yToL9de4MWS5VEiWH7RgvcFDTr/JBPDbkrpntCMOnIoq57X5TaWRON8l1vi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=G7Ot6qVQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tIGNj1dn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 826357A00AC;
	Mon,  2 Feb 2026 14:24:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 14:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060244; x=
	1770146644; bh=Rh1JZG8BMypNY1M+Be/nKC6qLAVvELquarTKh8ak9Og=; b=G
	7Ot6qVQm0jryAz31btvkm+dXKHiy55JEl5b5gpBaoz0lftpwP2A0TZxop14Vx8zN
	W2pTiPLKHxtL3Iyv6o9SqXtGGcCh79jIr0r64TSuIbWWVBV0S8ckPV/WO/K/2Trq
	sCYdE/3ug/dSSZYS6POkIwg9Pyt15qnN9YvkaHvkBLM4veiHf0/reQ/aCYbKMga/
	xKZ71HULrp6u5PFbW8Z4Xe7keuNkbZTty7gSkov48jGb96l4HjGL0KdNG68rX3HI
	pDbVn5BZRkndi63B0RpAbOZCFIBEa2D+bgeAKkNnpJdTuO47TcCRwq2m72qSdIc7
	7KuRy0LkWVnR+WGHv/Xvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060244; x=1770146644; bh=R
	h1JZG8BMypNY1M+Be/nKC6qLAVvELquarTKh8ak9Og=; b=tIGNj1dndy8myaNCE
	1Ey9Yr1GUAf2PTaq9is4Je+cYiOuFLb2tOB5g72qiNUq2M4ptXFIZKQHRjTx7AjV
	Y+PGLeXYEG4Tm2JcK+z3DTEV3rzP964IRInH3Q4pCue8WVsl0CLebZ9IgTr9waCp
	LHc02co1RviBwe/P3GGt55NhxX6DrLDZ58gNForwXZL5doXCVG75oDNgQifDq+Pa
	musCtZ6KGUSVw1eddlx91nEEYmh3F1vZMT6p9sorEI8CKNO39vgRiqjbxEQ/rVQ0
	7NbpZ3NXMDu+l+K7TKLyjRO33cUc8dYNMLT+qUEISbUIqxvd99rO4z+R9OzPWgJv
	PHoFA==
X-ME-Sender: <xms:1PmAaUZ6ofM3hFVAI6gx07q2mvSQ63I-PPrN2TCjkCghUonVBTuMsQ>
    <xme:1PmAaVxyjo5G-6JVDqcDqJS0XnX54y6MTSVD3sJKtVWqvTmbWqisT87UGXutyrdX8
    8R9GRqY6OO2JIY18gButtwOUZOkg_LptJfja0kA03QzNb4DDcbZfqqj>
X-ME-Received: <xmr:1PmAabN6JV9X4vlLDJ38cBFVsEOCrx6yuaXIol9EagR8hZOwmr1Icq6NS3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:1PmAacevo-tsbC3SKZb_bABmiOc9urHEfdJbhMmW7YiOzBV9Qg4ZqA>
    <xmx:1PmAaYSs_JoStPIEUBoU9kXXyPVLYVt4TQ6U4O5IzhqQB8kdWeZUDA>
    <xmx:1PmAaSdY7o8hHH5psD6rsij3MXlrj9vRKuBDGsVka-jTE0XkWxw3_Q>
    <xmx:1PmAaZt1kPvF6_tGTGzmmAFmad3pyHGk4ypjA_rr0RGysslbkLkVrg>
    <xmx:1PmAaR2VAzN18z0KWdVzVN_vUCQOyzXh6kbEljWRqcuJ1p9ztUbUtXVW>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:03 -0500 (EST)
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
Subject: [PATCH net-next v3 04/11] net/ipv6: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:31 +0200
Message-ID: <20260202192338.2373930-5-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
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
	TAGGED_FROM(0.00)[bounces-255986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 0EC1BD0831
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/dev.c         | 6 ++----
 net/ipv6/ip6_offload.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 43de5af0d6ec..ac6bcb2a0784 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3813,8 +3813,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
 	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
 	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3917,8 +3916,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index c44bb5812484..bd7f780e37a5 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -94,7 +94,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, err;
+	int proto;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -104,9 +104,6 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	err = ipv6_hopopt_jumbo_remove(skb);
-	if (err)
-		return ERR_PTR(err);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.52.0


