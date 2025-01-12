Return-Path: <netdev+bounces-157525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B90A0A8E5
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45033A8B71
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106581B0F04;
	Sun, 12 Jan 2025 12:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CC4C9A
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683411; cv=none; b=ZhjroRGrpEfk6113kTCaYV3ddbf4e0ZK/sRwOdnnGmt4jFs4Z/PJUJYbYD/J8hFPHl6DiHg2tqMvNMadmPKvU/9eptPrgShspKskm3Q1c2+wCQmjF1rqDYJGifY7u09sTmSmzabC3mlQiOdAhDYkCRf+TJg3UfwaORuVYtLQhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683411; c=relaxed/simple;
	bh=X2vllrUPWyE4qJGq6kL3ctHerw59PCqTWLtpwbJy6GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GpsS/htUviArBpnxC5q60OixxpNeAuOX6vPoQE020Ht+rv5xAZt5ypqFxYVsORZQ+k+A5OxanI8qCghpOeHLxuJH+DtCSCJcwpLjMV/AbOeGWyswnpSILB5gnVUMtkcuTZ+h0yAWoyksfuj+CquoxydcFE1jfl4C7L4OkY7+LaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:f7a6:44d1:35dc:44f6])
	by michel.telenet-ops.be with cmsmtp
	id 0C3J2E00123R5sA06C3JXL; Sun, 12 Jan 2025 13:03:18 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tWwgT-0000000Ayx9-3ZHY;
	Sun, 12 Jan 2025 13:03:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tWtuB-0000000AirA-0I5D;
	Sun, 12 Jan 2025 10:05:11 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ipv4: ip_gre: Fix set but not used warning in ipgre_err() if IPv4-only
Date: Sun, 12 Jan 2025 10:05:10 +0100
Message-ID: <3dc917cf6244ef123aa955b2fbbf02473d13cdb5.1736672666.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

if CONFIG_NET_IPGRE is enabled, but CONFIG_IPV6 is disabled:

    net/ipv4/ip_gre.c: In function ‘ipgre_err’:
    net/ipv4/ip_gre.c:144:22: error: variable ‘data_len’ set but not used [-Werror=unused-but-set-variable]
      144 |         unsigned int data_len = 0;
	  |                      ^~~~~~~~

Fix this by moving all data_len processing inside the IPV6-only section
that uses its result.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501121007.2GofXmh5-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/ipv4/ip_gre.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc7934467..6f871af7bb5772b7 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -141,7 +141,6 @@ static int ipgre_err(struct sk_buff *skb, u32 info,
 	const struct iphdr *iph;
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
-	unsigned int data_len = 0;
 	struct ip_tunnel *t;
 
 	if (tpi->proto == htons(ETH_P_TEB))
@@ -182,7 +181,6 @@ static int ipgre_err(struct sk_buff *skb, u32 info,
 	case ICMP_TIME_EXCEEDED:
 		if (code != ICMP_EXC_TTL)
 			return 0;
-		data_len = icmp_hdr(skb)->un.reserved[1] * 4; /* RFC 4884 4.1 */
 		break;
 
 	case ICMP_REDIRECT:
@@ -191,8 +189,9 @@ static int ipgre_err(struct sk_buff *skb, u32 info,
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tpi->proto == htons(ETH_P_IPV6) &&
-	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
-					type, data_len))
+	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len, type,
+		type == ICMP_TIME_EXCEEDED ?
+		icmp_hdr(skb)->un.reserved[1] * 4 /* RFC 4884 4.1 */ : 0))
 		return 0;
 #endif
 
-- 
2.43.0


