Return-Path: <netdev+bounces-249175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF014D15552
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF4130C62C2
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD449350A02;
	Mon, 12 Jan 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRW5hBc+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B433F8CE
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251084; cv=none; b=rbJLy/ca3EB99JdzFC87b+gCIIWbUCGa1OSg3fK+erN3tVhkyd5uZD7RbERMfUd4x9/qY1lFs/N8yZrLgHW6K992g59OmxOPqenOnok3XhRbN5yr+CelQtNTqzpdaGcpaJa95w140/jxAXlWvtIiRAI/DetvRmAKrA6mowpASDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251084; c=relaxed/simple;
	bh=/SwOeWxL6ufC54VEEpAQTm/lP9Y9P+8NcUhznL+feKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMXbj2499LYQ1OI93+O8XVwdqnkrenMkYNoHgrJLC1jhUlt5h0j+VI44Ofhms+GKkIxJgD4dfICXNCFMyYHNqd2H4JfJurm9Zo0xPJhrCCZILKaLV+K7FS2AJT9wX9S/KoyuloG8p5GvNe87Zti/uDhFqAVUiNUIeG85CxQhBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRW5hBc+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5L3rtxb9k8oEGlJ6kGxgbnqAjeJXJXyrL9cAJkWe2o=;
	b=bRW5hBc+1w8UsVEV8RpvoOWjFqhBGM87F6jl5+rO3NyvxfvXIb0TteOXeOiXCQ3sehSTwC
	ii+vtJyQL79FV0hrAXzeHusEJ/gW2cSGumc+dDwa2JcYnvOhN14mIoUyO2H0gs29auLeS0
	fEeOpYgQnnicISfvcz3sp+S8Qk/QIdI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-eXEZD5iyMX-kNIvawaqiwA-1; Mon,
 12 Jan 2026 15:51:18 -0500
X-MC-Unique: eXEZD5iyMX-kNIvawaqiwA-1
X-Mimecast-MFC-AGG-ID: eXEZD5iyMX-kNIvawaqiwA_1768251077
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CC021954B24;
	Mon, 12 Jan 2026 20:51:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D16E1800577;
	Mon, 12 Jan 2026 20:51:14 +0000 (UTC)
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
Subject: [PATCH v2 net-next 09/10] geneve: use GRO hint option in the RX path
Date: Mon, 12 Jan 2026 21:50:25 +0100
Message-ID: <3436cdda1aca02737ce7b8985137093d2eed71bf.1768250796.git.pabeni@redhat.com>
In-Reply-To: <cover.1768250796.git.pabeni@redhat.com>
References: <cover.1768250796.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 drivers/net/geneve.c | 172 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 166 insertions(+), 6 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 98d8c31986f9..c83d0797547a 100644
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
 
@@ -558,6 +561,79 @@ geneve_opt_gro_hint_validate_csum(const struct sk_buff *skb,
 	return !csum_fold(csum_add(psum, csum));
 }
 
+static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
+				  unsigned int gh_len,
+				  struct genevehdr **geneveh)
+{
+	struct geneve_opt_gro_hint *gro_hint;
+	unsigned int len, total_len;
+	struct ipv6hdr *ipv6h;
+	struct iphdr *iph;
+	struct udphdr *uh;
+	__be16 p;
+
+	gro_hint = geneve_sk_gro_hint(sk, (void *)skb->data - gh_len, &p, &len);
+	if (!gro_hint)
+		return 0;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	if (unlikely(!pskb_may_pull(skb, gro_hint->nested_hdr_len)))
+		return -ENOMEM;
+
+	/* Keep the header reference updated for the caller's sake. */
+	*geneveh = geneve_hdr(skb);
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
@@ -599,7 +675,18 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
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
@@ -690,6 +777,79 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 	return sock;
 }
 
+static bool geneve_hdr_match(struct sk_buff *skb,
+			     const struct genevehdr *gh,
+			     const struct genevehdr *gh2,
+			     const struct geneve_opt_gro_hint *gro_hint)
+{
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
+	if (!gro_hint)
+		return true;
+
+	/*
+	 * When gro is present consider the nested headers as part
+	 * of the geneve options
+	 */
+	nested = (void *)gh + gh_len;
+	nested2 = (void *)gh2 + gh_len;
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
@@ -742,8 +902,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 			continue;
 
 		gh2 = (struct genevehdr *)(p->data + off_gnv);
-		if (gh->opt_len != gh2->opt_len ||
-		    memcmp(gh, gh2, gh_len)) {
+		if (!geneve_hdr_match(skb, gh, gh2, gro_hint)) {
 			NAPI_GRO_CB(p)->same_flow = 0;
 			continue;
 		}
@@ -779,6 +938,7 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	gh = (struct genevehdr *)(skb->data + nhoff);
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
+	geneve_opt_gro_hint(gh, &type, &gh_len);
 
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
-- 
2.52.0


