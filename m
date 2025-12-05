Return-Path: <netdev+bounces-243815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70ECA7E39
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41218302EA1B
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8C32F749;
	Fri,  5 Dec 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T27nJw5H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B62BE043
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943477; cv=none; b=HKl9d8+Kf2kxkaSpOcy/c8KdPaHVSUv4y+WSbxrDUGmzQVUGSNyGt0hjEHiBEc3Ldq3p6hSfMeFTRX5W3g+aLS2xNNQMTtnLnVRd4xdxeZu7IdwazGB2xxo3LZUBiwmdsR7WXP1O/OHSvAF7/Jxr9mjPTW3trIrfMAnlKTZaJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943477; c=relaxed/simple;
	bh=/ljQ92TLHpsZQfBNisebIAoTdj+4EzYaHQ9rzh9u1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljhyVDDWP1sfOPfOiLuFOGZaTTftbUt29sAC1GuV5zwhTM0EQhsv7a5YUOVhqXAILQuCs2lI6Ddl/xpubOd9O6RN9lbpuhfh7jCf+IIOxAhOsbWEMoEJoo46JtScjaL2A0uPvzOiOIOq9CoSMCp8Jv4KoRBrrxUbaR8YbeGRuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T27nJw5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764943473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTfx7M0Cqvpio+BwrKPWXWxCd+SC8G4PfJtHCL4mML4=;
	b=T27nJw5H7c9ejApC9FkkAJrtQjLW00AhoRPp6dymCxbWFuORlnIqzAMMRiUb7aYPmWmclb
	1UxPsTpxPcJvjx8CZU2aFEN247fGPAgb4j55dwJC4YAOKkG0YEBTAH4xIh9FIE9smpGUTH
	c71/V+eeSUWdd7oFZ+DkfrFhVbTBF3w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-Q9oXp5wnNSubtDJpI9Kwuw-1; Fri,
 05 Dec 2025 09:04:32 -0500
X-MC-Unique: Q9oXp5wnNSubtDJpI9Kwuw-1
X-Mimecast-MFC-AGG-ID: Q9oXp5wnNSubtDJpI9Kwuw_1764943470
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC5A18005A4;
	Fri,  5 Dec 2025 14:04:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B84319560B4;
	Fri,  5 Dec 2025 14:04:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 2/2] net: gro: set the transport header later
Date: Fri,  5 Dec 2025 15:03:31 +0100
Message-ID: <27e2c981fb7ac08d9e9dd000a0e284a073571bde.1764943231.git.pabeni@redhat.com>
In-Reply-To: <cover.1764943231.git.pabeni@redhat.com>
References: <cover.1764943231.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

After the previous patch, the GRO engine receive callbacks don't relay
anymore on the skb transport header being set.

Move such operation at GRO complete time, with one notable exception:
SKB_GSO_FRAGLIST offload need the headers to be set on each skb in
the list prior to segmentation.

This prevents the NAPI gro_cell instance on top of a geneve tunnel
with GRO hints enabled from corrupting the GRO-hint-aggregated packet
setting the (innermost) transport header to the middle-one before
stopping the GRO process due to the encap mark.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/af_inet.c     | 2 +-
 net/ipv4/tcp_offload.c | 1 +
 net/ipv4/udp_offload.c | 4 ++++
 net/ipv6/ip6_offload.c | 3 +--
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 08d811f11896..f954ab78481a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1527,7 +1527,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	 * as we already checked checksum over ipv4 header was 0
 	 */
 	skb_gro_pull(skb, sizeof(*iph));
-	skb_set_transport_header(skb, skb_gro_offset(skb));
 
 	pp = indirect_call_gro_receive(tcp4_gro_receive, udp4_gro_receive,
 				       ops->callbacks.gro_receive, head, skb);
@@ -1611,6 +1610,7 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
+	skb_set_transport_header(skb, nhoff + sizeof(*iph));
 	/* Only need to add sizeof(*iph) to get to the next hdr below
 	 * because any hdr with option will have been flushed in
 	 * inet_gro_receive().
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fa36686df6d7..a78d9b15de06 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -334,6 +334,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		flush |= skb->csum_level != p->csum_level;
 		flush |= NAPI_GRO_CB(p)->count >= 64;
 		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
+		skb_set_transport_header(skb, (unsigned char *)th - skb->data);
 
 		if (flush || skb_gro_receive_list(p, skb))
 			mss = 1;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 7048cb2a28a2..73edbc154cfa 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -751,6 +751,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
+				int offset;
+
 				if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 					NAPI_GRO_CB(skb)->flush = 1;
 					return NULL;
@@ -761,6 +763,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 					return NULL;
 				}
 				skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
+				offset = (unsigned char *)uh - skb->data;
+				skb_set_transport_header(skb, offset);
 				ret = skb_gro_receive_list(p, skb);
 			} else {
 				skb_gro_postpull_rcsum(skb, uh,
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a..ed71cbd45690 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -256,8 +256,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 		skb_gro_pull(skb, sizeof(*iph));
 	}
 
-	skb_set_transport_header(skb, skb_gro_offset(skb));
-
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
@@ -382,6 +380,7 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
+	skb_set_transport_header(skb, nhoff);
 	err = INDIRECT_CALL_L4(ops->callbacks.gro_complete, tcp6_gro_complete,
 			       udp6_gro_complete, skb, nhoff);
 
-- 
2.52.0


