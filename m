Return-Path: <netdev+bounces-174036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E1A5D1B4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3906C3B4D84
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8CA263F21;
	Tue, 11 Mar 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="NG79b0uv"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C2229B18;
	Tue, 11 Mar 2025 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728346; cv=none; b=VrxtEWmnFScK5vYcQESMmKsXusfQg4dlmh7gobxgqLY5VIMbyFX9K/FUfgiF2YuwQEHhFDa0W1Eab7xqfzp5dvGpgQX9hA0TXS/qpjfO8gd6dgOHCL8R5RG17jWmd/Krp0Ew6o+JES39tBR4znqgjk6l+hDPXcE+/sSy9GzOyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728346; c=relaxed/simple;
	bh=OcjTRdDfTy9z/5Ut/8Y7X1Cm6KzGic8f8bEjZ7yCPKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Irsxj891t6WA0p21ngAge6eR0TKFh9eZr3yTB8rQP0Uvp/zRV7qQbSEn6/L7a9DEux5HqYfjk+/ql1dslYCYc2+NChDZSAUDiNDVrYFVAYHfSYDvYbEo9gAC/iYibNo81Hof1/di6SdZ7eALZrdPuvHuxg+P8EifN6ZB/1FZWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=NG79b0uv; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dYfijsKRkDi3VDGlOSu79wAwgSd8W8dIZLzw9V1UFSk=; b=NG79b0uvn/YcMp+J7vQ0p2IF2N
	P3rAfd6sCvZblvzFzouD39ah5/WMRmRIakmPrgtpioJcX6bL6iMpGk8C+zntYLo6aS5fm4ynhh4pR
	T2I2rTEHVDGqr+oT/KWZzsjPPS91KxXAkMSCcAdbvhIEJn6li8Ka1RiHsoLX6+uArets=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ts76R-00G2NA-2A;
	Tue, 11 Mar 2025 22:25:31 +0100
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: ipv6: fix TCP GSO segmentation with NAT
Date: Tue, 11 Mar 2025 22:25:30 +0100
Message-ID: <20250311212530.91519-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating the source/destination address, the TCP/UDP checksum needs to
be updated as well.

Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: move code to make it similar to __tcpv4_gso_segment_list_csum
v3: fix uninitialized variable

 net/ipv6/tcpv6_offload.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a45bf17cb2a1..ae2da28f9dfb 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -94,14 +94,23 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 }
 
 static void __tcpv6_gso_segment_csum(struct sk_buff *seg,
+				     struct in6_addr *oldip,
+				     const struct in6_addr *newip,
 				     __be16 *oldport, __be16 newport)
 {
-	struct tcphdr *th;
+	struct tcphdr *th = tcp_hdr(seg);
+
+	if (!ipv6_addr_equal(oldip, newip)) {
+		inet_proto_csum_replace16(&th->check, seg,
+					  oldip->s6_addr32,
+					  newip->s6_addr32,
+					  true);
+		*oldip = *newip;
+	}
 
 	if (*oldport == newport)
 		return;
 
-	th = tcp_hdr(seg);
 	inet_proto_csum_replace2(&th->check, seg, *oldport, newport, false);
 	*oldport = newport;
 }
@@ -129,10 +138,10 @@ static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
 		th2 = tcp_hdr(seg);
 		iph2 = ipv6_hdr(seg);
 
-		iph2->saddr = iph->saddr;
-		iph2->daddr = iph->daddr;
-		__tcpv6_gso_segment_csum(seg, &th2->source, th->source);
-		__tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);
+		__tcpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
+					 &th2->source, th->source);
+		__tcpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
+					 &th2->dest, th->dest);
 	}
 
 	return segs;
-- 
2.47.1


