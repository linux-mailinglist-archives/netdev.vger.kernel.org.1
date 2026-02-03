Return-Path: <netdev+bounces-256202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLb4EF25gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2FDD6837
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80216301FECD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653626ED46;
	Tue,  3 Feb 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="JHnFI+w/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uia87oD2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF530CD89
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109256; cv=none; b=h6Fkj14OQq+VJtvdV5cBiGXvwCmpTen3B0CTfDA8lzKnucOuCxbGV867ZqBNvTSV09JOwjWYIGKfNNwpt+SvrUt/g9pbiWFEI/oUhZBjGs/2nUTNn+ni43U7KfOrSW8UnASpW5VRwXW/Ik6nbpN2UWRy/GQWx2xdmy+nH5wrrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109256; c=relaxed/simple;
	bh=zOpyP7mUSLwvpHJtj0HlfiaW81CNyPsRe3AkjKgsjzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEyPRRM8ZfzR+sYPbuSfgw/kRnW+EOlH1Uh43WLQn0Nj8Im/wbxGuQYhh3DQBZ4K5t5Na0VQcKA0bmJi79oWFVAIGZ06igTrQNgECp1IEsxL1dBKPfx19FIaNGRocJ3ZWYxtR2jgIaM0l3LWhDY+4zy/7tVpmV/VcRpgt/6pIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=JHnFI+w/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uia87oD2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 020557A0137;
	Tue,  3 Feb 2026 04:00:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 04:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109253; x=
	1770195653; bh=iMk8pjlIIiFJchM1kM/uXVvxs8WdGneAcRKeg8Hm+IA=; b=J
	HnFI+w/iMUMHShwRvWVNlUJvNGHxmHHkdIR01jI8bQ7U7VcSHtcAgEnQPMrmswx5
	MllHhzkohEL+VoIDfKptmaRBNpX07Uqfm9/Lm0ReMJdDVt8juJk3tCOsx7zfStSJ
	UIDNkz64TDCKrj6AIhUJhfEj1eKSIh0im4G8QsVwH9E38rdZIu5LN0kdoUD13JTT
	1AdqO0eUjurEu3A+S0iz1vruKR6qdUGi5Hoc2CP9SKulOphK+WJ1PhxAACHJivgo
	HMczQDcvfv6RkQoaZeHB7Ev/dKV0CvDuMA0yTqasIZ1wx7sKAiPdr9VD/wZBMJqS
	/u+B9w6xkinpBtVnhbJoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109253; x=1770195653; bh=i
	Mk8pjlIIiFJchM1kM/uXVvxs8WdGneAcRKeg8Hm+IA=; b=uia87oD2eyQ49ghD7
	4CNXDBcjCYB648Gy/hlhsy2LyGc452ZzfjDZvfDrLF1pKVwO/MtO/6BmbaJDVgPY
	WWpyFF/D8YlXjaTnJUdYXMnB2thLkqUsqwQP2R5g5MifBWJ3hhI6C1PzJbCfdZp8
	yTDoXVmPoEYj/Y6ebFg69BkJCuE+VuTju4vOC8EVBQg7bhsv1ETrWQErT/LXBv4n
	C6tW0KVbvSvZovhVLOS5EZCEw6guT4wtXjXGqqdcfzWTJXH+KYaQJWdrJOg9boDq
	RnkysQ8O6fqH6xK+GqpJUttEJfZKGjSDs6BF786eMJ5/cdjSXjAUP3L6raQ3e+5f
	V5pTA==
X-ME-Sender: <xms:RbmBaU0wb-KknL9Mqvd55UTOD0EL06dYljq47GYrTEuZSOGy5a_uUA>
    <xme:RbmBaVc9I-6z2VFG6DT-H2ZmPkgFB-RVm2jjuC-icFRkqHNjBDspzFFTMGTY7zz9j
    9s84mdfpGrWhLRZ9vGWPoExjjQ7sMB1cVNUaXju17kdiv270IHPdqk>
X-ME-Received: <xmr:RbmBaZJpQYmBrt2z2DD3KTPO58r5XoQE-F2VGdQFsrncdxq4igZyNRYfOLzZ>
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
X-ME-Proxy: <xmx:RbmBabq-uInROlRgQFKATm_DmhHBYaY5WDr8Z6pgEt7S8XoAr20-ow>
    <xmx:RbmBaftbZlfz_P2J6M7QwHblTMOUI-McglolGRSbVPoGcH8wFv9Xig>
    <xmx:RbmBadL3RrD6iEuTFHkSmS5yGxUUMqitYi0JdQw7YciO30e0IbYS4g>
    <xmx:RbmBaWoTZNwqD4d2c9UuskRvjejeIAua2rjhAmxRHTe55CQXWcs-nQ>
    <xmx:RbmBaahGdqT-SoSitHIb2wDbvq6w8CY12CpywMjKGZmClzjyHGg5w5VF>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:53 -0500 (EST)
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
Subject: [PATCH net-next v4 06/12] net/mlx4: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:36 +0200
Message-ID: <20260203085942.2477583-7-alice.projects@fastmail.im>
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
	TAGGED_FROM(0.00)[bounces-256202-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2F2FDD6837
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mlx4 TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 42 +++++-----------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 87f35bcbeff8..c5d564e5a581 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -636,28 +636,20 @@ static int get_real_size(const struct sk_buff *skb,
 			 struct net_device *dev,
 			 int *lso_header_size,
 			 bool *inline_ok,
-			 void **pfrag,
-			 int *hopbyhop)
+			 void **pfrag)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	int real_size;
 
 	if (shinfo->gso_size) {
 		*inline_ok = false;
-		*hopbyhop = 0;
 		if (skb->encapsulation) {
 			*lso_header_size = skb_inner_tcp_all_headers(skb);
 		} else {
-			/* Detects large IPV6 TCP packets and prepares for removal of
-			 * HBH header that has been pushed by ip6_xmit(),
-			 * mainly so that tcpdump can dissect them.
-			 */
-			if (ipv6_has_hopopt_jumbo(skb))
-				*hopbyhop = sizeof(struct hop_jumbo_hdr);
 			*lso_header_size = skb_tcp_all_headers(skb);
 		}
 		real_size = CTRL_SIZE + shinfo->nr_frags * DS_SIZE +
-			ALIGN(*lso_header_size - *hopbyhop + 4, DS_SIZE);
+			ALIGN(*lso_header_size + 4, DS_SIZE);
 		if (unlikely(*lso_header_size != skb_headlen(skb))) {
 			/* We add a segment for the skb linear buffer only if
 			 * it contains data */
@@ -884,7 +876,6 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	int desc_size;
 	int real_size;
 	u32 index, bf_index;
-	struct ipv6hdr *h6;
 	__be32 op_own;
 	int lso_header_size;
 	void *fragptr = NULL;
@@ -893,7 +884,6 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool stop_queue;
 	bool inline_ok;
 	u8 data_offset;
-	int hopbyhop;
 	bool bf_ok;
 
 	tx_ind = skb_get_queue_mapping(skb);
@@ -903,7 +893,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_drop;
 
 	real_size = get_real_size(skb, shinfo, dev, &lso_header_size,
-				  &inline_ok, &fragptr, &hopbyhop);
+				  &inline_ok, &fragptr);
 	if (unlikely(!real_size))
 		goto tx_drop_count;
 
@@ -956,7 +946,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		data = &tx_desc->data;
 		data_offset = offsetof(struct mlx4_en_tx_desc, data);
 	} else {
-		int lso_align = ALIGN(lso_header_size - hopbyhop + 4, DS_SIZE);
+		int lso_align = ALIGN(lso_header_size + 4, DS_SIZE);
 
 		data = (void *)&tx_desc->lso + lso_align;
 		data_offset = offsetof(struct mlx4_en_tx_desc, lso) + lso_align;
@@ -1021,31 +1011,15 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 			((ring->prod & ring->size) ?
 				cpu_to_be32(MLX4_EN_BIT_DESC_OWN) : 0);
 
-		lso_header_size -= hopbyhop;
 		/* Fill in the LSO prefix */
 		tx_desc->lso.mss_hdr_size = cpu_to_be32(
 			shinfo->gso_size << 16 | lso_header_size);
 
+		/* Copy headers;
+		 * note that we already verified that it is linear
+		 */
+		memcpy(tx_desc->lso.header, skb->data, lso_header_size);
 
-		if (unlikely(hopbyhop)) {
-			/* remove the HBH header.
-			 * Layout: [Ethernet header][IPv6 header][HBH][TCP header]
-			 */
-			memcpy(tx_desc->lso.header, skb->data, ETH_HLEN + sizeof(*h6));
-			h6 = (struct ipv6hdr *)((char *)tx_desc->lso.header + ETH_HLEN);
-			h6->nexthdr = IPPROTO_TCP;
-			/* Copy the TCP header after the IPv6 one */
-			memcpy(h6 + 1,
-			       skb->data + ETH_HLEN + sizeof(*h6) +
-					sizeof(struct hop_jumbo_hdr),
-			       tcp_hdrlen(skb));
-			/* Leave ipv6 payload_len set to 0, as LSO v2 specs request. */
-		} else {
-			/* Copy headers;
-			 * note that we already verified that it is linear
-			 */
-			memcpy(tx_desc->lso.header, skb->data, lso_header_size);
-		}
 		ring->tso_packets++;
 
 		i = shinfo->gso_segs;
-- 
2.52.0


