Return-Path: <netdev+bounces-224290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFBB83869
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8F31C001AF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803912F531B;
	Thu, 18 Sep 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLVva5i9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64636B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184305; cv=none; b=tQwM3IjOpFg0DjH6/UBtblswzqYCXE3Z3OBKeXUE29bjYA5eDpD4Q9gzQ9YufNhRxtnYlLm3yvVs1rTDDrvhTXnOgqOxJinqxvbgLzVrehALqa2UxWU79TRG1iee5Xlh1+57pCXGgdylBDAjDunDaVWYZFYWCCRuCcbWIjurfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184305; c=relaxed/simple;
	bh=Yq40Xm7+5TxxgXxFR97G2Vj7lo3I0QcOqe0KzIMqPuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjWom0cmwHf9j/XnCVvAgYH/5Fh7v97EpYZcR7XX2eVcmwua3k3VeURthUo2YYP6jzjOJATJ90GVD/ZRhA3TmJxiof96/cdGyqmfwcinIbahTprCLhzuPgNwQtkw/bluAd7Quy+7HioFEVO7ZlCMX7Lt0E3hJStsCUp5OpPb+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLVva5i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0F5C4CEE7;
	Thu, 18 Sep 2025 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184305;
	bh=Yq40Xm7+5TxxgXxFR97G2Vj7lo3I0QcOqe0KzIMqPuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLVva5i9nZ7pM21C2mQacikSInYxRrFitXDNdk/CftS+Xutbh1sZvwQFOlcRubZ21
	 TW5XKHkBk4sWJUgZTQdWPG1nNhNB2WGYWE/VTuV2zw5xTml6alwHoF8AORWRVKHOB7
	 VAM+WitNC98iwC1kDiZwTqTW1db+FerndowiW75WJeMq9mbEFWn++i6XSofN6y5zrW
	 c9YEjtBxljyRh4FDXsBE/jttpzhVnEdUIvTdTfyhhnbb/Gk2KUTebNUmKtth+JL+qc
	 T/54TG7Gfn1jNvObiDsXU9td/wpgfDW53xjnT8H/r2L6ezFhfPyTTSQbd0cxX1grgb
	 A+Im+vBv2TW4w==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: ipv4: convert ip_rcv_options to drop reasons
Date: Thu, 18 Sep 2025 10:31:17 +0200
Message-ID: <20250918083127.41147-5-atenart@kernel.org>
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

This converts the only path not returning drop reasons in
ip_rcv_finish_core.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_input.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 229c7e6b7e4c..f95765f315da 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -263,10 +263,11 @@ int ip_local_deliver(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(ip_local_deliver);
 
-static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
+static inline enum skb_drop_reason
+ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 {
-	struct ip_options *opt;
 	const struct iphdr *iph;
+	struct ip_options *opt;
 
 	/* It looks as overkill, because not all
 	   IP options require packet mangling.
@@ -277,7 +278,7 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 	*/
 	if (skb_cow(skb, skb_headroom(skb))) {
 		__IP_INC_STATS(dev_net(dev), IPSTATS_MIB_INDISCARDS);
-		goto drop;
+		return SKB_DROP_REASON_NOMEM;
 	}
 
 	iph = ip_hdr(skb);
@@ -286,7 +287,7 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 
 	if (ip_options_compile(dev_net(dev), opt, skb)) {
 		__IP_INC_STATS(dev_net(dev), IPSTATS_MIB_INHDRERRORS);
-		goto drop;
+		return SKB_DROP_REASON_IP_INHDR;
 	}
 
 	if (unlikely(opt->srr)) {
@@ -298,17 +299,15 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 					net_info_ratelimited("source route option %pI4 -> %pI4\n",
 							     &iph->saddr,
 							     &iph->daddr);
-				goto drop;
+				return SKB_DROP_REASON_NOT_SPECIFIED;
 			}
 		}
 
 		if (ip_options_rcv_srr(skb, dev))
-			goto drop;
+			return SKB_DROP_REASON_NOT_SPECIFIED;
 	}
 
-	return false;
-drop:
-	return true;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
@@ -388,9 +387,10 @@ static int ip_rcv_finish_core(struct net *net,
 	}
 #endif
 
-	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
-		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-		goto drop;
+	if (iph->ihl > 5) {
+		drop_reason = ip_rcv_options(skb, dev);
+		if (drop_reason != SKB_NOT_DROPPED_YET)
+			goto drop;
 	}
 
 	rt = skb_rtable(skb);
-- 
2.51.0


