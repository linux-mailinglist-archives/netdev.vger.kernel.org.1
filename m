Return-Path: <netdev+bounces-282069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yICvNG0e8WlmdgEAu9opvQ
	(envelope-from <netdev+bounces-282069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:54:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6222E48C13E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FBCB3067760
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA860379EE6;
	Tue, 28 Apr 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+LLoKfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E23644A4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409637; cv=none; b=ZKNiuHiDdLuf0Ax6H+IXrdEvEMEyjSKdYvAk8vKsPGA0S6yaNNfdEMApt8iwPALoXBAfWgUX+pmAVaXNlgpARBYrdCeEA/2U3SOBbKK5Qzs00zjQEB2S1H22w0bz81RG6YWqJWvVRCJDjMsVj1Cf65TMrmRA1GmZ02dpQxoD8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409637; c=relaxed/simple;
	bh=IB6CLdot/1t2KBAZHoMsvVQS75ShQpHfi3cvDKVXg8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5APh2xgX4WVXOws41abvlKzpqCQ0Vfb8pjA5czYhp4o/nkcLr5+ZfJZFCk5njLzSZjmb6M5EipAWQOQfmme0Ww3xQZH76cI/A5JoiMULAw6C5S9NUa+rDBv0x+deQJ53DVH5Pd7tfXgTF529kNXT4OpY8BLOvAtzbAC3DTvaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+LLoKfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D251C2BCB7;
	Tue, 28 Apr 2026 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777409637;
	bh=IB6CLdot/1t2KBAZHoMsvVQS75ShQpHfi3cvDKVXg8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+LLoKfj0uIPQlYKXzTGuFfklaVN0PRo/5UCSAVaLOc0UHd0y/vHS9oQC01VFuTJT
	 Xxm9TVGBX/gasSt+NnPaHlDzYAukcyQKdqTdRfHiOhkyoNA6eD2d3H6fobWfzQ1C8p
	 2PW6OIfFKaSwFiNQPLA/Ya4k1vrShK3cjhtWEmLK7obXG9jdWHiJZHFP8+caFGmPla
	 vPN8Uh/cOwZky8UjviAC8wttlF/nK3S/xrSCYiSnozfDp/U1GH9Iyebw9CRL0VO+Ru
	 LqtzxDwRpusm8RXkSxFhX/CPTn6W57TA/R7YVCXVqUVCmAv9kCO3ifcwZbEafTlN9b
	 n32xNpXVe0B9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] psp: validate protocol before mutating skb in psp_dev_encapsulate()
Date: Tue, 28 Apr 2026 13:53:50 -0700
Message-ID: <20260428205352.1247325-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428205352.1247325-1-kuba@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6222E48C13E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282069-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.926];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Code checkers / AI scans will complain that we have already modified
the packet by the time we realize that protocol is not IP.

Move the skb->protocol check to before skb_push()/memmove() so that
the skb is not left in a corrupted state when the function returns
false for an unsupported protocol. psp_dev_rcv() follows similar
pattern.

Today this path is unreachable because both in-tree callers (mlx5 and
netdevsim) only reach psp_dev_encapsulate() from TCP socket TX paths
where skb->protocol is always ETH_P_IP or ETH_P_IPV6, and both drop
the skb on a false return, anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/psp/psp_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..652ec8a9c8a4 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -228,6 +228,10 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
 	u32 ethr_len = skb_mac_header_len(skb);
 	u32 bufflen = ethr_len + network_len;
 
+	if (skb->protocol != htons(ETH_P_IP) &&
+	    skb->protocol != htons(ETH_P_IPV6))
+		return false;
+
 	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
 		return false;
 
@@ -243,11 +247,9 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
 		ip_hdr(skb)->check = 0;
 		ip_hdr(skb)->check =
 			ip_fast_csum((u8 *)ip_hdr(skb), ip_hdr(skb)->ihl);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	} else {
 		ipv6_hdr(skb)->nexthdr = IPPROTO_UDP;
 		be16_add_cpu(&ipv6_hdr(skb)->payload_len, PSP_ENCAP_HLEN);
-	} else {
-		return false;
 	}
 
 	skb_set_inner_ipproto(skb, IPPROTO_TCP);
-- 
2.54.0


