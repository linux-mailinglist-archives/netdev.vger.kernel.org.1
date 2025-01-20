Return-Path: <netdev+bounces-159774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B01A16D3E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778467A5781
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723D1E1C3B;
	Mon, 20 Jan 2025 13:12:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313D1E25E8
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378769; cv=none; b=dLb1KW4Z1NQMkmUtVQaIPE4BvnrxXuoLso7NMYB8afPAX63veDiQzoVc0/EC+w3uK7YDiNmcG1KFZ7nAr3/ZjnQAhfRpZu8jO2LcAmC3XrMrRYDAPdRcyly1Cj4W40D/KJagCWRhRS8CIoWJh9odWdGeurNec/fytqF/L5B5/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378769; c=relaxed/simple;
	bh=g4CyU6ZOj9pGr49WagN9aklDDZmo22OobWfW802LV+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRM0m7hzUHLPB6nkXYF19FHVZ0Ww1dmgikS4YfsTc5Gx184IjG9eHAkLDebZIld+LsupSicKYTfG6xCsJSnu3cIuSbF0wCIOpXpiRtnsz1qOxLDDSLLCuZ2UYfRacZzlzTyV80XZdK6F9WSPRqEs3P/Gal0jPLGGhYjK4Mx7orU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:30c9:4dcf:fe21:4b10])
	by baptiste.telenet-ops.be with cmsmtp
	id 3RCe2E0010raqVW01RCe2P; Mon, 20 Jan 2025 14:12:39 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tZrZv-0000000Dh1u-1PH1;
	Mon, 20 Jan 2025 14:12:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tZra1-0000000DSIp-3YH9;
	Mon, 20 Jan 2025 14:12:37 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v2] ipv4: ip_gre: Fix set but not used warning in ipgre_err() if IPv4-only
Date: Mon, 20 Jan 2025 14:12:36 +0100
Message-ID: <67956320a8ee663f2582cc75f0e8047d69da5f6a.1737371364.git.geert@linux-m68k.org>
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
v2:
  - Do not use the ternary operator,
  - Target net-next.
---
 net/ipv4/ip_gre.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc7934467..9667f27740258efb 100644
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
@@ -190,10 +188,16 @@ static int ipgre_err(struct sk_buff *skb, u32 info,
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (tpi->proto == htons(ETH_P_IPV6) &&
-	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
-					type, data_len))
-		return 0;
+	if (tpi->proto == htons(ETH_P_IPV6)) {
+		unsigned int data_len = 0;
+
+		if (type == ICMP_TIME_EXCEEDED)
+			data_len = icmp_hdr(skb)->un.reserved[1] * 4; /* RFC 4884 4.1 */
+
+		if (!ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4 + tpi->hdr_len,
+						type, data_len))
+			return 0;
+	}
 #endif
 
 	if (t->parms.iph.daddr == 0 ||
-- 
2.43.0


