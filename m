Return-Path: <netdev+bounces-204310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95605AFA0AE
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D18A1C24834
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED71CAA65;
	Sat,  5 Jul 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZMaa7l88"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44C156237;
	Sat,  5 Jul 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751729451; cv=none; b=odZid3SMbxTMfqEl1AWC+h5WjPEzG40+ARotk4O/gL8SMtsrPhBi/piqIanLGiH/JAGmll6EQ+PW48ilQqtcDTK/ukLOUSyebFt8BqZ45pw2dNu+GJH27kTkxpafYzp0L8fN/V7qPRGjJDVrDgR+ZL6apdzdqcaDBezZEAelIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751729451; c=relaxed/simple;
	bh=unEW3sIR36aqxELmlsnVGBv/VJuyM2kDUpVdW1JPxuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEdg61t4aoLVNqZUUhb7bioNXxIQCb1O++8hZRYOKCUytuaRs/OYjYBMSTHCEZ/ZoKJPlSxLwRglu3XntAFqWki5XJqUSt53VAkw7eeEkEoiu48aqUCzcAro6ghsptlVC7n9EuV7yOTLtO8RmA39e8cIyVQjTQKleioCUqx9c8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ZMaa7l88; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vgrTPih2H6eHiBahUOSiZIhD8AXwhEH/xFNSJMqsRLI=; b=ZMaa7l88kjR7QQnunEOVUYNrEv
	112ze6wWFaHDmDwuctN7/jFvnx4SZqfTcJmMmdYxNNoSH2/wEiy+kh+IpOjmxAhP4zvnF6E/h3VFm
	tpZfkoYEu9DrxQKGf4jzqDmpHPLGE4OMUIntEbM/I26bUsmOxS9sfv93cV5HiMDzNWDQ=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=MacBookPro.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uY4T9-007Yuf-0R;
	Sat, 05 Jul 2025 17:06:23 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Richard Gobert <richardbgobert@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
Date: Sat,  5 Jul 2025 17:06:21 +0200
Message-ID: <20250705150622.10699-1-nbd@nbd.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since "net: gro: use cb instead of skb->network_header", the skb network
header is no longer set in the GRO path.
This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
to check for address/port changes.
Fix this regression by selectively setting the network header for merged
segment skbs.

Fixes: 186b1ea73ad8 ("net: gro: use cb instead of skb->network_header")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c | 1 +
 net/ipv4/udp_offload.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index d293087b426d..be5c2294610e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -359,6 +359,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		flush |= skb->ip_summed != p->ip_summed;
 		flush |= skb->csum_level != p->csum_level;
 		flush |= NAPI_GRO_CB(p)->count >= 64;
+		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
 
 		if (flush || skb_gro_receive_list(p, skb))
 			mss = 1;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 85b5aa82d7d7..e0a6bfa95118 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -767,6 +767,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 					NAPI_GRO_CB(skb)->flush = 1;
 					return NULL;
 				}
+				skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
 				ret = skb_gro_receive_list(p, skb);
 			} else {
 				skb_gro_postpull_rcsum(skb, uh,
-- 
2.49.0


