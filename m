Return-Path: <netdev+bounces-168970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B837A41D6F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744DD176895
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059F24EF78;
	Mon, 24 Feb 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="SNDUq7au"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F36248892;
	Mon, 24 Feb 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396073; cv=none; b=gjyGV6aZjRldGC4HUA1H14H3zR+zzLcYWP16BAmbC3ixJGheA4Zq3P4Svnjm0ueQRl+l0dMjNybPBGWjIiECbtx3pbylhRqRYyfD2H3iT7TbfdZDyWZo1tegZi47lJ0pPsBQ8JUJ0u5ONsADbg8BnjrC0TNDWRge3Lj3ZGepIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396073; c=relaxed/simple;
	bh=GQsmgS6wI8+vhA5Ld4i1QcY89vYEHOJlDqEZT3H9dYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyHAYdbS2MDETgeI8GnswF4IJgK1pqA29ljmjvW0Pq3tQKbxtXGu1BdQpR+BJKJf+X/5FlxuOr//E5e/KYsLrAdnwFS/H02hXgbGAcEuZl0E8SWbZZ+La5vjTpaN1lzVDMak/vk5d7m3t22wQ6ojd3svw9pdLlu2Vj/0A6FbwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=SNDUq7au; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eKuLqhP8V5boAL2DNzEE0Tml8upt+wPZ4tmCowYlIos=; b=SNDUq7auBvI4w2q4RwJsWBf3rT
	eZ3ZpqeJZibdwG7OOwC3ELXQLW9uRhWn8La68qLSbJQcyx5Ssif2A+YWSLfV68VvEgJj9xEG7Yhxa
	yynI9hvGWNTKj44FN3FHVUqpRJIB+bAXC1l6ugY9mfHGos4NtRvRBvNZWUvDwhZkjFOA=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tmWW3-009cZt-2M;
	Mon, 24 Feb 2025 12:20:51 +0100
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
Subject: [PATCH net] net: ipv6: fix TCP GSO segmentation with NAT
Date: Mon, 24 Feb 2025 12:20:46 +0100
Message-ID: <20250224112046.52304-1-nbd@nbd.name>
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
 net/ipv6/tcpv6_offload.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a45bf17cb2a1..5d0fcdbf57a1 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -113,24 +113,36 @@ static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
 	struct sk_buff *seg;
 	struct tcphdr *th2;
 	struct ipv6hdr *iph2;
+	bool addr_equal;
 
 	seg = segs;
 	th = tcp_hdr(seg);
 	iph = ipv6_hdr(seg);
 	th2 = tcp_hdr(seg->next);
 	iph2 = ipv6_hdr(seg->next);
+	addr_equal = ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
+		     ipv6_addr_equal(&iph->daddr, &iph2->daddr);
 
 	if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
-	    ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
-	    ipv6_addr_equal(&iph->daddr, &iph2->daddr))
+	    addr_equal)
 		return segs;
 
 	while ((seg = seg->next)) {
 		th2 = tcp_hdr(seg);
 		iph2 = ipv6_hdr(seg);
 
-		iph2->saddr = iph->saddr;
-		iph2->daddr = iph->daddr;
+		if (!addr_equal) {
+			inet_proto_csum_replace16(&th2->check, seg,
+						  iph2->saddr.s6_addr32,
+						  iph->saddr.s6_addr32,
+						  true);
+			inet_proto_csum_replace16(&th2->check, seg,
+						  iph2->daddr.s6_addr32,
+						  iph->daddr.s6_addr32,
+						  true);
+			iph2->saddr = iph->saddr;
+			iph2->daddr = iph->daddr;
+		}
 		__tcpv6_gso_segment_csum(seg, &th2->source, th->source);
 		__tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);
 	}
-- 
2.47.1


