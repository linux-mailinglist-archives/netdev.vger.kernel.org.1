Return-Path: <netdev+bounces-233063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBAC0BB37
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2649E189669A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5D2D4801;
	Mon, 27 Oct 2025 02:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-05.21cn.com [182.42.157.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07372D29CE
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533043; cv=none; b=R1QKeEze5HWpzOUd7OqWHdOlkWJyQCIUu6woAij4BPR0VUXPZyEiR9sJhof7ykgXYjAdAmUjFXcEW6iEkRiqzfE9dw7JWaIPKt91jYQsRa2ad3yAd6stqN41j64MCqhSRv1LGQfFPRvApZ8vEanSUzb8LVdTWXNKWPU72Cpo6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533043; c=relaxed/simple;
	bh=rj3aTS4Oen6WEWJ0O8qKqFRYAXj9GoZPJW2b/ucq1Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFyYmTDoM5ZRpSVykvfPvUis9qhAxMjNtvyWc/huXyL378/T6TQpEHD5FMnhdPDEKsfAG9lFpYjD16o/d5P7BEd0anDIx5CrlOMbT0bWyCCx9UTSpi2y/hpBv4qCjltNSA5sGDFG7xW/yuHH4XpCn0woTdFAmrJgVGGPKiV3ZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1314971392
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id A1E928F77D;
	Mon, 27 Oct 2025 10:32:57 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-z742x with ESMTP id 96e1e902f6fb4a2db97ede64e65d41f1 for netdev@vger.kernel.org;
	Mon, 27 Oct 2025 10:32:59 CST
X-Transaction-ID: 96e1e902f6fb4a2db97ede64e65d41f1
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 36.111.140.5
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	horms@kernel.org,
	liyonglong@chinatelecom.cn
Subject: [PATCH net v2 2/2] net: ipv6: use drop reasons in ip6_fragment
Date: Mon, 27 Oct 2025 10:32:45 +0800
Message-Id: <1761532365-10202-3-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1761532365-10202-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1761532365-10202-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

use drop reasons in ip6_output like ip_fragment/ip_do_fragment

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/ipv6/ip6_output.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e..31dea51 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -879,6 +879,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
 	u8 tstamp_type = skb->tstamp_type;
+	SKB_DR_INIT(reason, FRAG_FAILED);
 	struct ip6_frag_state state;
 	unsigned int mtu, hlen, nexthdr_offset;
 	ktime_t tstamp = skb->tstamp;
@@ -925,8 +926,10 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				    &ipv6_hdr(skb)->saddr);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
+	    (err = skb_checksum_help(skb))) {
+		SKB_DR_SET(reason, SKB_CSUM);
 		goto fail;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
@@ -979,6 +982,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			if (!err)
 				IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
 					      IPSTATS_MIB_FRAGCREATES);
+			else
+				SKB_DR_SET(reason, FRAG_OUTPUT_FAILED);
 
 			if (err || !iter.frag)
 				break;
@@ -995,7 +1000,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			return 0;
 		}
 
-		kfree_skb_list(iter.frag);
+		kfree_skb_list_reason(iter.frag, reason);
 
 		IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
 			      IPSTATS_MIB_FRAGFAILS);
@@ -1037,8 +1042,10 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 */
 		skb_set_delivery_time(frag, tstamp, tstamp_type);
 		err = output(net, sk, frag);
-		if (err)
+		if (err) {
+			SKB_DR_SET(reason, FRAG_OUTPUT_FAILED);
 			goto fail;
+		}
 
 		IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 			      IPSTATS_MIB_FRAGCREATES);
@@ -1050,12 +1057,13 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 
 fail_toobig:
 	icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
+	SKB_DR_SET(reason, PKT_TOO_BIG);
 	err = -EMSGSIZE;
 
 fail:
 	IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 		      IPSTATS_MIB_FRAGFAILS);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return err;
 }
 
-- 
1.8.3.1


