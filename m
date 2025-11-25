Return-Path: <netdev+bounces-241567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4AC85E54
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63D29351239
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4890242D7D;
	Tue, 25 Nov 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbB9VtQy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD423D7D4
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087123; cv=none; b=ozLDQCHlORWH/kE/j7e6cvqR23pWSmNRU8euaG+QhvH0vRpIZMdbLYBLbSzHpEkLfWaCO1U+14ybmP6hYHUvNSgPdLabshwQ6K1NBVjN4QcBTwG4gJMZw68+I9DRaVixZ+VTaMaUQApkpmoeoOgIlihvmAInLbEfkO72dGAz/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087123; c=relaxed/simple;
	bh=s0JEaZMc65yE7lmYKd+Vq3jX08G2rGhuFLX4naT9aKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6o73sO565nMoJ59t19rlf2qiqp9/VJOGpR9arOvofQ/ygm42AtMhrcKLMwQTpByv7kheQj0fw5orntKjGijr1HoMlQI+R6LtgaDF3HazyPLx2cxM0oKQxIAR6+BBCHvlS8x9PNOVlz06oJCl621P0hQE95gZjaxvAHOdehkIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbB9VtQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764087120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/cT+SHxUbCOQSUfoG801LNQ9DTt3usOSSxPnztDYjY=;
	b=AbB9VtQyVGgzfVBY//4KCcHMOPeTzkY+V0MnQRloq5hcWv7mD0AxFBjZRbhbF+qhWDyWnW
	DfpwYQ5gFLq3cqJNUEvelP51wswNpfHb43x7Grhm06n0vhA/Lpe/bRq2Yd+VdMkyJj6rPl
	UjFV0V0yaQ+PYcQ2M5HIhC3Ya/mCh4I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-1a-a1WkgOWmN4mQTVtZKEw-1; Tue,
 25 Nov 2025 11:11:56 -0500
X-MC-Unique: 1a-a1WkgOWmN4mQTVtZKEw-1
X-Mimecast-MFC-AGG-ID: 1a-a1WkgOWmN4mQTVtZKEw_1764087114
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A720C1954B06;
	Tue, 25 Nov 2025 16:11:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.183])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9AAA1800451;
	Tue, 25 Nov 2025 16:11:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 08/10] geneve: extract hint option at GRO stage
Date: Tue, 25 Nov 2025 17:11:13 +0100
Message-ID: <45d2320dac5b39b56cfdfb28d6f59208ab7110b8.1764056123.git.pabeni@redhat.com>
In-Reply-To: <cover.1764056123.git.pabeni@redhat.com>
References: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add helpers for finding a GRO hint option in the geneve header, performing
basic sanitization of the option offsets vs the actual packet layout,
validate the option for GRO aggregation and check the nested header
checksum.

The validation helper closely mirrors similar check performed by the ipv4
and ipv6 gro callbacks, with the additional twist of accessing the
relevant network header via the GRO hint offset.

To validate the nested UDP checksum, leverage the csum completed of the
outer header, similarly to LCO, with the main difference that in this case
we have the outer checksum available.

Use the helpers to extract the hint info at the GRO stage.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 172 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 6571035c8129..5030ad0db3fc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -405,6 +405,159 @@ static int geneve_hlen(const struct genevehdr *gh)
 	return sizeof(*gh) + gh->opt_len * 4;
 }
 
+/*
+ * Look for GRO hint in the genenve options; return the extracted
+ * data only if they pass basic sanitization.
+ */
+static struct geneve_opt_gro_hint *
+geneve_opt_gro_hint(const struct genevehdr *gh, __be16 *type,
+		    unsigned int *gh_len)
+{
+	struct geneve_opt *opt = (void *)(gh + 1);
+	struct geneve_opt_gro_hint *gro_hint;
+	int id, opt_len = gh->opt_len;
+
+	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
+		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
+		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
+		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
+			goto found;
+
+		/* check for bad opt len */
+		if (opt->length + 1 >= opt_len)
+			return NULL;
+
+		/* next opt */
+		opt_len -= opt->length + 1;
+		opt = ((void *)opt) + ((opt->length + 1) << 2);
+	}
+	return NULL;
+
+found:
+	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
+
+	/*
+	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
+	 * the overall hinted hdr size.
+	 */
+	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
+	    gro_hint->nested_hdr_len)
+		return NULL;
+
+	if (gro_hint->nested_nh_offset +
+	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
+				      sizeof(struct iphdr)) >
+	    gro_hint->nested_tp_offset)
+		return NULL;
+
+	/* Allow only supported L2. */
+	id = gro_hint->inner_proto_id;
+	if (id >= ARRAY_SIZE(proto_id_map))
+		return NULL;
+
+	*type = proto_id_map[id];
+	*gh_len += gro_hint->nested_hdr_len;
+
+	return gro_hint;
+}
+
+static struct geneve_opt_gro_hint *
+geneve_sk_gro_hint(const struct sock *sk, const struct genevehdr *gh,
+		   __be16 *type, unsigned int *gh_len)
+{
+	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
+
+	if (!gs || !gs->gro_hint)
+		return NULL;
+	return geneve_opt_gro_hint(gh, type, gh_len);
+}
+
+/* Validate the packet headers pointed by data WRT the provided hint */
+static bool
+geneve_opt_gro_hint_validate(void *data,
+			     const struct geneve_opt_gro_hint *gro_hint)
+{
+	void *nested_nh = data + gro_hint->nested_nh_offset;
+	struct iphdr *iph;
+
+	if (gro_hint->nested_is_v6) {
+		struct ipv6hdr *ipv6h = nested_nh;
+		struct ipv6_opt_hdr *opth;
+		int offset, len;
+
+		if (ipv6h->nexthdr == IPPROTO_UDP)
+			return true;
+
+		offset = sizeof(*ipv6h) + gro_hint->nested_nh_offset;
+		while (offset + sizeof(*opth) <= gro_hint->nested_tp_offset) {
+			opth = data + offset;
+
+			len = ipv6_optlen(opth);
+			if (len + offset > gro_hint->nested_tp_offset)
+				return false;
+			if (opth->nexthdr == IPPROTO_UDP)
+				return true;
+
+			offset += len;
+		}
+		return false;
+	}
+
+	iph = nested_nh;
+	if (*(u8 *)iph != 0x45 || ip_is_fragment(iph) ||
+	    iph->protocol != IPPROTO_UDP || ip_fast_csum((u8 *)iph, 5))
+		return false;
+
+	return true;
+}
+
+/*
+ * Validate the skb headers following the specified geneve hdr vs the
+ * provided hint, including nested L4 checksum.
+ * The caller already ensured that the relevant amount of data is available
+ * in the linear part.
+ */
+static bool
+geneve_opt_gro_hint_validate_csum(const struct sk_buff *skb,
+				  const struct genevehdr *gh,
+				  const struct geneve_opt_gro_hint *gro_hint)
+{
+	unsigned int plen, gh_len = geneve_hlen(gh);
+	void *nested = (void *)gh + gh_len;
+	struct udphdr *nested_uh;
+	unsigned int nested_len;
+	struct ipv6hdr *ipv6h;
+	struct iphdr *iph;
+	__wsum csum, psum;
+
+	if (!geneve_opt_gro_hint_validate(nested, gro_hint))
+		return false;
+
+	/* Use GRO hints with nested csum only if the outer header has csum. */
+	nested_uh = nested + gro_hint->nested_tp_offset;
+	if (!nested_uh->check || skb->ip_summed == CHECKSUM_PARTIAL)
+		return true;
+
+	if (!NAPI_GRO_CB(skb)->csum_valid)
+		return false;
+
+	/* Compute the complete checksum up to the nested transport. */
+	plen = gh_len + gro_hint->nested_tp_offset;
+	csum = csum_sub(NAPI_GRO_CB(skb)->csum, csum_partial(gh, plen, 0));
+	nested_len = skb_gro_len(skb) - plen;
+
+	/* Compute the nested pseudo header csum. */
+	ipv6h = nested + gro_hint->nested_nh_offset;
+	iph = (struct iphdr *)ipv6h;
+	psum = gro_hint->nested_is_v6 ?
+	       ~csum_unfold(csum_ipv6_magic(&ipv6h->saddr, &ipv6h->daddr,
+					    nested_len, IPPROTO_UDP, 0)) :
+	       csum_tcpudp_nofold(iph->saddr, iph->daddr,
+				  nested_len, IPPROTO_UDP, 0);
+
+	return !csum_fold(csum_add(psum, csum));
+}
+
 /* Callback from net/ipv4/udp.c to receive packets */
 static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
@@ -541,6 +694,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
+	struct geneve_opt_gro_hint *gro_hint;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
 	struct genevehdr *gh, *gh2;
@@ -558,6 +712,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 	if (gh->ver != GENEVE_VER || gh->oam)
 		goto out;
 	gh_len = geneve_hlen(gh);
+	type = gh->proto_type;
 
 	hlen = off_gnv + gh_len;
 	if (!skb_gro_may_pull(skb, hlen)) {
@@ -566,6 +721,22 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 			goto out;
 	}
 
+	/* The GRO hint/nested hdr could use a different ethernet type. */
+	gro_hint = geneve_sk_gro_hint(sk, gh, &type, &gh_len);
+	if (gro_hint) {
+		/*
+		 * If the hint is present, and nested hdr validation fails, do
+		 * not attempt plain GRO: it will ignore inner hdrs and cause
+		 * OoO.
+		 */
+		gh = skb_gro_header(skb, off_gnv + gh_len, off_gnv);
+		if (unlikely(!gh))
+			goto out;
+
+		if (!geneve_opt_gro_hint_validate_csum(skb, gh, gro_hint))
+			goto out;
+	}
+
 	list_for_each_entry(p, head, list) {
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -580,7 +751,6 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 
 	skb_gro_pull(skb, gh_len);
 	skb_gro_postpull_rcsum(skb, gh, gh_len);
-	type = gh->proto_type;
 	if (likely(type == htons(ETH_P_TEB)))
 		return call_gro_receive(eth_gro_receive, head, skb);
 
-- 
2.52.0


