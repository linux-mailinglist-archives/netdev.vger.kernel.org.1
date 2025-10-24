Return-Path: <netdev+bounces-232412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651CCC0598E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB1B3B6D5D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D030F943;
	Fri, 24 Oct 2025 10:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-12.21cn.com [182.42.119.59])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468DE30F93E
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.119.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301624; cv=none; b=uhDyxoFNkFWGzHsHvFzfh2FXIZZP7XuCWdva0nzA4Wo+t/zESt/3past3zbeo0aBstATAmRa4uxDcznA1ilI6hQNZJmcrrisztjQpD05ykAA6q59dX0G/+Cu92y+8D1BAgsBMzfDj1Y9Ws6kP36LPS24QV2c5cFwaUovI0PMYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301624; c=relaxed/simple;
	bh=DqHOxjUgzToaGX3gcvk3tXzB6imW9WrGz2Y6US+lwgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFzcJ446xWKes78E2e+HOY9iieWgi9tOV00bsd2hXccQJ63ZfX+JGQSzTMs3KkAceN3AJnGgevJLETuyOjCmpNQx/bxVszGLsvnLfS3/VdX0+vII6OiG93usJhb/ULu+6KRXj8y13z1gZ7UOKjbcZTDBg+HZavnQAQehq31Y/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.119.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1620297662
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id B960311024D25;
	Fri, 24 Oct 2025 18:20:23 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 14c2775439184244b63aa8888c34a9fe for netdev@vger.kernel.org;
	Fri, 24 Oct 2025 18:20:25 CST
X-Transaction-ID: 14c2775439184244b63aa8888c34a9fe
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
Date: Fri, 24 Oct 2025 18:20:12 +0800
Message-Id: <1761301212-34487-3-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1761301212-34487-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1761301212-34487-1-git-send-email-liyonglong@chinatelecom.cn>
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
index f904739e..69a39f6 100644
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
+		SKB_DR_SET(reason, IP_CSUM);
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


