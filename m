Return-Path: <netdev+bounces-257175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JtCLTWehGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:42:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC4FF3708
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1535302810E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB723EAB8;
	Thu,  5 Feb 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="tRsnWZqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDT6LxWf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B84271A9A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298795; cv=none; b=d3QQ1XUQtR37ISANEDcVJSb581wbAM/IbMimF2aDiAwtV3u1uQ0/+c7F23Y31+sDCduzfZf2TQKcpBpabdHKKtfCGbMv5eJAv7eDVQyPCbM9GPAMqY4pwIYHHEEDNvvi4+CwrfYk09oQJRwnS3YtCKG6CEvb/Wqn6ro6hTA1wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298795; c=relaxed/simple;
	bh=zOpyP7mUSLwvpHJtj0HlfiaW81CNyPsRe3AkjKgsjzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI0qLTf7nkj0yuqNGcXKV2us22S5RGKP62N0sALYQ4HHCyvXXyDCaOc1qvypBCTVscL1UX2eTZDVZ+kMQFu+fwX+FKA/BKRKOOfL43oetxIvRUMCaE65TnIbLG9UwHXwRkid8VDMGuwyT1RgCuFO1Q7+AgKVw07Uj2rZ6n5uIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=tRsnWZqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDT6LxWf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 49D191D0012F;
	Thu,  5 Feb 2026 08:39:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 05 Feb 2026 08:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770298794; x=
	1770385194; bh=iMk8pjlIIiFJchM1kM/uXVvxs8WdGneAcRKeg8Hm+IA=; b=t
	RsnWZqTQXxJpEUwCxTeWeEJJjb2FIdNFaYD18UhJn7FQzfvt89FO4BGWaeepkuec
	ryCRVU0MQRLZ3cutouW7alUThI3rGareidsTJ3vweUiS1n5jN9UvUvb6ROml16B6
	wRdfHlz8JSinagSDH6bfcp3xz37h+ftLAVjykQ7jDfcvd7luqUopczWJJBUGDLwO
	R5iI73RgfGmhkpBYotJ8UBJkJlFEZenhLhugnMsguWWWd2C2ojwNZw21pS47trRD
	Y6CIr2WSfzipUhwKVZSXYyaflmMdgHg7++10WYNRiWiMFp2olyPfknRG79aoBfiM
	8TmWsZGP7SwyjdBEbJWUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770298794; x=1770385194; bh=i
	Mk8pjlIIiFJchM1kM/uXVvxs8WdGneAcRKeg8Hm+IA=; b=bDT6LxWfB5BL2cQGT
	smaB1hK5Xj4V+KXfWkuowQ+qeIXSwp1qChD/lEwifAqAtzz0fL3MmG6G4OtqSH9Q
	iigxb2ZNyGb+9fwSnL9jDg58tsgZi4UiYbuCo+tn54ZrjMkCxspo+LdH+TkHiCnh
	rBfLQrRD53D56OQs6mwW2bJJBxfUw60XhriYJKtBBhsAhBN9Jduo5Gld8ehIAmQ+
	FPzf3Cq4cFmeAxjpOzMmcxNwgoyFf3OMGXoP55XLlik+IIuITJZpUWteuh94Bykg
	ZHtjS3LQiGAMwPbL/uXrPhegf/AqTmSmcjH7aB3PATVPiQKJu26H5At+c3y8aE8s
	PLECQ==
X-ME-Sender: <xms:qZ2EaZfHPAOxBHr_qonNVsDAd_xgoi3Q9uGJvNVRMaNaf_lKKbEr8g>
    <xme:qZ2Eadkj0T81R0uYQHyi6mVNi98iQIvbim5KCLm_JO6Y6pJ85THlWm-W9BEFfm-LC
    tdZKqUgXZh8VNyHbnCAkBfOIvIdu614Uqs4V6EUsOVS5PAHnm4moHGo>
X-ME-Received: <xmr:qZ2EaexaPcne7xmoeYKFvuMUhcbUsgoY64B5OKcQNbl0Y61EfQrDZOVcKbL0mjFaC36HTg>
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
X-ME-Proxy: <xmx:qZ2EaQxeza2rS2_tLaZneWc3M1ltJRT3COJpXNia728ALm2vfP5qwQ>
    <xmx:qZ2EaeXd6TYFn8gVhPZyKZ6cNURFVZDX64rHx7hFtbrw-kUbNGXfDQ>
    <xmx:qZ2EaXSEtbG5Bl6SZI4Z1GCA4a6iSq28eeBd-fMBdNfeecnGBmC2Zw>
    <xmx:qZ2EaWSAJ-yalP24aOaLEpjUfNG3uVE9CczQWjtLu-wmTkgAaGB9Jg>
    <xmx:qp2EaYqCjbMXRN-_9t43_KXTfUDNzE6G1ukTUVQXzNRtp_CpIZgPurqS>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:39:53 -0500 (EST)
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
Subject: [PATCH net-next v5 06/12] net/mlx4: Remove jumbo_remove step from TX path
Date: Thu,  5 Feb 2026 15:39:19 +0200
Message-ID: <20260205133925.526371-7-alice.kernel@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257175-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 2DC4FF3708
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


