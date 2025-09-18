Return-Path: <netdev+bounces-224289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3004B83866
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469574846BC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFBD2F2918;
	Thu, 18 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4359Ekr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADF2F0C48
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184302; cv=none; b=h/UOLP7aoncTYMwNwFusAWp2BDJ0jx/KgiHMbWSQzjmAPXNxe/Gmkp7K7PbfT5AxVim4OUvDJUpjkjpaz+5SBn+gOi8fu2ejZ10nV62fhR/NyzGzjQNayvifJ9GjnBjrW0HEqIEzx68XHcQEDoX+FasGtCPF9GnkIegS/61UKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184302; c=relaxed/simple;
	bh=6WYtx1po1n0tzlKeyfiljPSGvi7Wz/XS86uXyaejDY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkKklh8xZNZB7sn6ODmPNaHam2/75iELPCuyjNAqMIDJnSne8MQu3IsZh9pWd1phj1Kq/lQAOWQ1N0l1p2+RCyz23d0hCUqvPfas/YSYKddAnNNGT+axaN7/u77/AwI8xJ0KO3XBanF41UcuSbDWoVgWx+3UopJMGkTuvjmdoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4359Ekr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439C6C4CEF1;
	Thu, 18 Sep 2025 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184301;
	bh=6WYtx1po1n0tzlKeyfiljPSGvi7Wz/XS86uXyaejDY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4359Ekr6AmviPM7/ifqLMeOd8E57IpQDJQpnpA+kyfhMDDl2Gh24DylwEflZCmZV
	 TVMwds1ZcxHITf1uYI99g5XcUzakyyPjhEqccGeMU1z4E26bkp0AIrgZDoPfl1Yg+3
	 P9ifMJRa39RlFh+TzWyQqcb+VXXTbdzH18CkuCmLoGutOx7F09Kdf8mUEShU4XGXcU
	 12z1OFAB47zeuqHQTF8EPKnMTXX3Q9btfT4AO8/rmEeqV4ISrLOf3C1mKL1P6yQt5A
	 vH1H0vAcQ0vFdtBsYU1l8X6QgASaIsfYMx7aGHdD5J0ImE4KNKF33yrlduBPn9PTCX
	 7p74/gBr5revg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: ipv4: use the right type for drop reasons in ip_rcv_finish_core
Date: Thu, 18 Sep 2025 10:31:16 +0200
Message-ID: <20250918083127.41147-4-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918083127.41147-1-atenart@kernel.org>
References: <20250918083127.41147-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make drop reasons be `enum skb_drop_reason` instead of `int`. While at
it make the SKB_NOT_DROPPED_YET checks explicit.

Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 93b8286e526a..229c7e6b7e4c 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -325,13 +325,13 @@ static int ip_rcv_finish_core(struct net *net,
 			      const struct sk_buff *hint)
 {
 	const struct iphdr *iph = ip_hdr(skb);
+	enum skb_drop_reason drop_reason;
 	struct rtable *rt;
-	int drop_reason;
 
 	if (ip_can_use_hint(skb, iph, hint)) {
 		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
 						ip4h_dscp(iph), dev, hint);
-		if (unlikely(drop_reason))
+		if (unlikely(drop_reason != SKB_NOT_DROPPED_YET))
 			goto drop_error;
 	}
 
@@ -351,7 +351,7 @@ static int ip_rcv_finish_core(struct net *net,
 		case IPPROTO_UDP:
 			if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) {
 				drop_reason = udp_v4_early_demux(skb);
-				if (unlikely(drop_reason))
+				if (unlikely(drop_reason != SKB_NOT_DROPPED_YET))
 					goto drop_error;
 
 				/* must reload iph, skb->head might have changed */
@@ -368,7 +368,7 @@ static int ip_rcv_finish_core(struct net *net,
 	if (!skb_valid_dst(skb)) {
 		drop_reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
 						   ip4h_dscp(iph), dev);
-		if (unlikely(drop_reason))
+		if (unlikely(drop_reason != SKB_NOT_DROPPED_YET))
 			goto drop_error;
 	} else {
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
-- 
2.51.0


