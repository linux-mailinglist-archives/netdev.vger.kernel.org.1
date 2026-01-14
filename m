Return-Path: <netdev+bounces-249906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6320D20856
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7073C3016792
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59113002D8;
	Wed, 14 Jan 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThmLC2nz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EA302151
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411318; cv=none; b=iYKB/Cr3M6e76BqJC7n7PzanzZqKJpJ9YDHlPLH60Dh7ccdcVePgdVH/m+yF1ZaABZjZuY5O3K/kZB531rlYD5cVTn3036g/aCKrfMW7hosGgMtNAEPAbJt3ltClF1zsnEXOFJu57rXGdpmty5sARnzZBdMSXF1Bkx1+Fn/JHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411318; c=relaxed/simple;
	bh=yZsbVwRy2spuwvUdODnJI4TupXGW7CHS/JhPCUzjK/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfNorfDyAWDHVZDxyIGtbu5C7wuEMX9pT4cT0s8OlRh2zLkawTE27upfRc9RlM9RNckAja5+nNCWD9zxdQBczKnVyXBGGt9Xb0mggahCJ/6tU6DbDRXiv82k+1rzsKu9m0PMq57EGAtcoMz/qLmS4AwityOQTrZgc52+lUfbjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThmLC2nz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgPusNiSpXE3l5vzWBnNwxUOaNQs/OmX1VUEj+DC7LM=;
	b=ThmLC2nzP0H36uzqbdztIIUqlul8FwX9Vr3fpleC1hPa2gi1K9YYjKk9GDOVNpLX1tdN7U
	tMwewk7r1J/PhVA1Toms7OXj6csVe1hZusGZCX9xovfu3APF5QFgL/0NB1wwOgNOCqCGrH
	PNVtdkdHO8rpQ9uEsNP0C9L36SZ5LFs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-oKdvFHnLM6iQ30QdsTubKg-1; Wed,
 14 Jan 2026 12:21:49 -0500
X-MC-Unique: oKdvFHnLM6iQ30QdsTubKg-1
X-Mimecast-MFC-AGG-ID: oKdvFHnLM6iQ30QdsTubKg_1768411307
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 107BC1800357;
	Wed, 14 Jan 2026 17:21:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53AC119560A7;
	Wed, 14 Jan 2026 17:21:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v3 net-next 09/10] geneve: use GRO hint option in the RX path
Date: Wed, 14 Jan 2026 18:20:42 +0100
Message-ID: <797b5ba12efe60affac29174f138db18cde42ec1.1768410519.git.pabeni@redhat.com>
In-Reply-To: <cover.1768410519.git.pabeni@redhat.com>
References: <cover.1768410519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

At the GRO stage, when a valid hint option is found, try match the whole
nested headers and try to aggregate on the inner protocol; in case of hdr
mismatch extract the nested address and port to properly flush on a
per-inner flow basis.

On GRO completion, the (unmodified) nested headers will be considered part
of the (constant) outer geneve encap header so that plain UDP tunnel
segmentation will yield valid wire packets.

In the geneve RX path, when processing a GSO packet carrying a GRO hint
option, update the nested header length fields from the wire packet size to
the GSO-packet one. If the nested header additionally carries a checksum,
convert it to CSUM-partial.

Finally, when the RX path leverages the GRO hints, skip the additional GRO
stage done by GRO cells: otherwise the already set skb->encapsulation flag
will foul the GRO cells complete step to use touch the innermost IP header
when it should update the nested csum, corrupting the packet.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 v1 -> v2:
   - reload hdrs after possible pskb_may_pull()
   - skip GRO cells for double encap gro pkts
---
 drivers/net/geneve.c | 183 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 7 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2e1f85b8af4e..0949d4579171 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -259,9 +259,8 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
 
 /* geneve receive/decap routine */
 static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
-		      struct sk_buff *skb)
+		      struct sk_buff *skb, const struct genevehdr *gnvh)
 {
-	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
 	int nh, err = 0;
@@ -362,8 +361,12 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		}
 	}
 
+	/* Skip the additional GRO stage when hints are in use. */
 	len = skb->len;
-	err = gro_cells_receive(&geneve->gro_cells, skb);
+	if (skb->encapsulation)
+		err = netif_rx(skb);
+	else
+		err = gro_cells_receive(&geneve->gro_cells, skb);
 	if (likely(err == NET_RX_SUCCESS))
 		dev_dstats_rx_add(geneve->dev, len);
 
@@ -564,6 +567,86 @@ geneve_opt_gro_hint_validate_csum(const struct sk_buff *skb,
 	return !csum_fold(csum_add(psum, csum));
 }
 
+static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
+				  unsigned int gh_len,
+				  struct genevehdr **geneveh)
+{
+	const struct geneve_opt_gro_hint *gro_hint;
+	unsigned int len, total_len, hint_off;
+	struct ipv6hdr *ipv6h;
+	struct iphdr *iph;
+	struct udphdr *uh;
+	__be16 p;
+
+	hint_off = geneve_sk_gro_hint_off(sk, *geneveh, &p, &len);
+	if (!hint_off)
+		return 0;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
+	if (unlikely(!pskb_may_pull(skb, gro_hint->nested_hdr_len)))
+		return -ENOMEM;
+
+	*geneveh = geneve_hdr(skb);
+	gro_hint = geneve_opt_gro_hint(*geneveh, hint_off);
+
+	/*
+	 * Validate hints from untrusted source before accessing
+	 * the headers; csum will be checked later by the nested
+	 * protocol rx path.
+	 */
+	if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY &&
+		     !geneve_opt_gro_hint_validate(skb->data, gro_hint)))
+		return -EINVAL;
+
+	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
+	iph = (struct iphdr *)ipv6h;
+	total_len = skb->len - gro_hint->nested_nh_offset;
+	if (total_len > GRO_LEGACY_MAX_SIZE)
+		return -E2BIG;
+
+	/*
+	 * After stripping the outer encap, the packet still carries a
+	 * tunnel encapsulation: the nested one.
+	 */
+	skb->encapsulation = 1;
+
+	/* GSO expect a valid transpor header, move it to the current one. */
+	skb_set_transport_header(skb, gro_hint->nested_tp_offset);
+
+	/* Adjust the nested IP{6} hdr to actual GSO len. */
+	if (gro_hint->nested_is_v6) {
+		ipv6h->payload_len = htons(total_len - sizeof(*ipv6h));
+	} else {
+		__be16 old_len = iph->tot_len;
+
+		iph->tot_len = htons(total_len);
+
+		/* For IPv4 additionally adjust the nested csum. */
+		csum_replace2(&iph->check, old_len, iph->tot_len);
+		ip_send_check(iph);
+	}
+
+	/* Adjust the nested UDP header len and checksum. */
+	uh = udp_hdr(skb);
+	uh->len = htons(skb->len - gro_hint->nested_tp_offset);
+	if (uh->check) {
+		len = skb->len - gro_hint->nested_nh_offset;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		if (gro_hint->nested_is_v6)
+			uh->check = ~udp_v6_check(len, &ipv6h->saddr,
+						  &ipv6h->daddr, 0);
+		else
+			uh->check = ~udp_v4_check(len, iph->saddr,
+						  iph->daddr, 0);
+	} else {
+		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+	return 0;
+}
+
 /* Callback from net/ipv4/udp.c to receive packets */
 static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
@@ -605,7 +688,18 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	geneve_rx(geneve, gs, skb);
+	/*
+	 * After hint processing, the transport header points to the inner one
+	 * and we can't use anymore on geneve_hdr().
+	 */
+	geneveh = geneve_hdr(skb);
+	if (geneve_post_decap_hint(sk, skb, sizeof(struct genevehdr) +
+				   opts_len, &geneveh)) {
+		DEV_STATS_INC(geneve->dev, rx_errors);
+		goto drop;
+	}
+
+	geneve_rx(geneve, gs, skb, geneveh);
 	return 0;
 
 drop:
@@ -696,11 +790,87 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 	return sock;
 }
 
+static bool geneve_hdr_match(struct sk_buff *skb,
+			     const struct genevehdr *gh,
+			     const struct genevehdr *gh2,
+			     unsigned int hint_off)
+{
+	const struct geneve_opt_gro_hint *gro_hint;
+	void *nested, *nested2, *nh, *nh2;
+	struct udphdr *udp, *udp2;
+	unsigned int gh_len;
+
+	/* Match the geneve hdr and options */
+	if (gh->opt_len != gh2->opt_len)
+		return false;
+
+	gh_len = geneve_hlen(gh);
+	if (memcmp(gh, gh2, gh_len))
+		return false;
+
+	if (!hint_off)
+		return true;
+
+	/*
+	 * When gro is present consider the nested headers as part
+	 * of the geneve options
+	 */
+	nested = (void *)gh + gh_len;
+	nested2 = (void *)gh2 + gh_len;
+	gro_hint = geneve_opt_gro_hint(gh, hint_off);
+	if (!memcmp(nested, nested2, gro_hint->nested_hdr_len))
+		return true;
+
+	/*
+	 * The nested headers differ; the packets can still belong to
+	 * the same flow when IPs/proto/ports match; if so flushing is
+	 * required.
+	 */
+	nh = nested + gro_hint->nested_nh_offset;
+	nh2 = nested2 + gro_hint->nested_nh_offset;
+	if (gro_hint->nested_is_v6) {
+		struct ipv6hdr *iph = nh, *iph2 = nh2;
+		unsigned int nested_nlen;
+		__be32 first_word;
+
+		first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
+		if ((first_word & htonl(0xF00FFFFF)) ||
+		    !ipv6_addr_equal(&iph->saddr, &iph2->saddr) ||
+		    !ipv6_addr_equal(&iph->daddr, &iph2->daddr) ||
+		    iph->nexthdr != iph2->nexthdr)
+			return false;
+
+		nested_nlen = gro_hint->nested_tp_offset -
+			      gro_hint->nested_nh_offset;
+		if (nested_nlen > sizeof(struct ipv6hdr) &&
+		    (memcmp(iph + 1, iph2 + 1,
+			    nested_nlen - sizeof(struct ipv6hdr))))
+			return false;
+	} else {
+		struct iphdr *iph = nh, *iph2 = nh2;
+
+		if ((iph->protocol ^ iph2->protocol) |
+		    ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
+		    ((__force u32)iph->daddr ^ (__force u32)iph2->daddr))
+			return false;
+	}
+
+	udp = nested + gro_hint->nested_tp_offset;
+	udp2 = nested2 + gro_hint->nested_tp_offset;
+	if (udp->source != udp2->source || udp->dest != udp2->dest ||
+	    udp->check != udp2->check)
+		return false;
+
+	NAPI_GRO_CB(skb)->flush = 1;
+	return true;
+}
+
 static struct sk_buff *geneve_gro_receive(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
 	unsigned int hlen, gh_len, off_gnv, hint_off;
+	const struct geneve_opt_gro_hint *gro_hint;
 	const struct packet_offload *ptype;
 	struct genevehdr *gh, *gh2;
 	struct sk_buff *pp = NULL;
@@ -729,7 +899,6 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 	/* The GRO hint/nested hdr could use a different ethernet type. */
 	hint_off = geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
 	if (hint_off) {
-		const struct geneve_opt_gro_hint *gro_hint;
 
 		/*
 		 * If the hint is present, and nested hdr validation fails, do
@@ -750,8 +919,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 			continue;
 
 		gh2 = (struct genevehdr *)(p->data + off_gnv);
-		if (gh->opt_len != gh2->opt_len ||
-		    memcmp(gh, gh2, gh_len)) {
+		if (!geneve_hdr_match(skb, gh, gh2, hint_off)) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
 		}
@@ -787,6 +955,7 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	gh = (struct genevehdr *)(skb->data + nhoff);
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
+	geneve_opt_gro_hint_off(gh, &type, &gh_len);
 
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
-- 
2.52.0


