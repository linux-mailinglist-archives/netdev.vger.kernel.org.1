Return-Path: <netdev+bounces-202783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C437AEF00A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DF317C68C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482A225D1E6;
	Tue,  1 Jul 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMY8rYI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DB25C6EE
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356180; cv=none; b=mlj/FncBkrJ6J7E/4FacpFXBk+fb8F2GeZf5PIa1ddb3IdG/O7iQbSFx7DM3wG0DGMdBXP+kfHUSInkOdNGhiEjK7Ck0nvpNeyzFLhz7dwFUJo+2dkSiRp5WRMQJ0NIaTpO6trbwuh66sSYrgAmwWa8xtFtoAXXVyFHn15TtspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356180; c=relaxed/simple;
	bh=bREfnTk+h1KufBQYiK3BPHwpgi5mIVuhqsenZd0n4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fO+BSf6aHlPkDQ8tqaxEeh9obfQ3BHs9txBJztqwAo3aFLDf8E9YB++j4lr1+jNO2/1X0P8MW123pTYWvvyax8GiPwRtNOfaXoFF+eLie+FJYSvA1Fj0W+pNlj+x+z2+5yTh8EWwWqbE/KDDe/IVrpJbcd90a/kPCMzisuetXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMY8rYI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED23FC4CEEB;
	Tue,  1 Jul 2025 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751356179;
	bh=bREfnTk+h1KufBQYiK3BPHwpgi5mIVuhqsenZd0n4bU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZMY8rYI6pjyHldSPGwuDIGgaoKrYK969x3mW9g1E4ZIobK8JIoHefO1uP358ZBspb
	 hgndg4yPKlr26VHLeLSssiGd7VoBoA5HIyaz/QZI0CIsCDy4cKL9Ve/gNIOakNBxtY
	 utHzbLNIvQsswFyW8UFiSdrsmgFBicfGITHoBXFb+S3dvqvuwo6UqdBcf3GiSmaJx0
	 C9NFz+ZxCVVLLHpLZEk8QKCie1C1VtkiPtehvJR1mal1BhhW6+XL0yzb6QABUsHkEF
	 EOQv7fR0uF5Qportc7fZgLbs0C4XJhWSFdyfk+gu1RyWF1O/Vc07Ziv194pCxuc8Ei
	 f89dRoxLCUneg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net v2] net: ipv4: fix stat increase when udp early demux drops the packet
Date: Tue,  1 Jul 2025 09:49:34 +0200
Message-ID: <20250701074935.144134-1-atenart@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_v4_early_demux now returns drop reasons as it either returns 0 or
ip_mc_validate_source, which returns itself a drop reason. However its
use was not converted in ip_rcv_finish_core and the drop reason is
ignored, leading to potentially skipping increasing LINUX_MIB_IPRPFILTER
if the drop reason is SKB_DROP_REASON_IP_RPFILTER.

This is a fix and we're not converting udp_v4_early_demux to explicitly
return a drop reason to ease backports; this can be done as a follow-up.

Fixes: d46f827016d8 ("net: ip: make ip_mc_validate_source() return drop reason")
Cc: Menglong Dong <menglong8.dong@gmail.com>
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
Changes in v2:
  - Reset the drop reason to NOT_SPECIFIED if not returning early. The
    diff remains small and this aligns with the rest of the function.
---
 net/ipv4/ip_input.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 30a5e9460d00..5a49eb99e5c4 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -319,8 +319,8 @@ static int ip_rcv_finish_core(struct net *net,
 			      const struct sk_buff *hint)
 {
 	const struct iphdr *iph = ip_hdr(skb);
-	int err, drop_reason;
 	struct rtable *rt;
+	int drop_reason;
 
 	if (ip_can_use_hint(skb, iph, hint)) {
 		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
@@ -345,9 +345,10 @@ static int ip_rcv_finish_core(struct net *net,
 			break;
 		case IPPROTO_UDP:
 			if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) {
-				err = udp_v4_early_demux(skb);
-				if (unlikely(err))
+				drop_reason = udp_v4_early_demux(skb);
+				if (unlikely(drop_reason))
 					goto drop_error;
+				drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 				/* must reload iph, skb->head might have changed */
 				iph = ip_hdr(skb);
-- 
2.50.0


