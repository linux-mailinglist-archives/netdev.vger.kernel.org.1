Return-Path: <netdev+bounces-232413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C4C0598B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536C23BC1E3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0B30F95F;
	Fri, 24 Oct 2025 10:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-12.21cn.com [182.42.119.59])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679830F92A
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.119.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301624; cv=none; b=YBi11HMrtFm9HUuoN9nSdcqVkujoQ29rzxFrOd8LT0u/FinigYp7D5AocPwSTRD2kFNHkFhK1VVvswCnA7rpMrWgmymbCoGTtyBQuJKohL/fe2aVUjYP6aK3njEs9ZNsJsAsufZzujL53bWSnCMrnS9S6gAEMpLsxPFxi6YkzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301624; c=relaxed/simple;
	bh=va+VNDhAVJG0TwfAoFhp0DaU6ss6OcDsfR5SGnA6K4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bia6aj4jlz09yF5zMxT46DicsjLz7j7955U3ZRtczFljLzC5C9W7LgUJaMNQ5AC1pi2jb5iZ83L6BPP2Ncorw8u46hBXpKMOMuQrEEb4YqeIfo0iYAfx+PiYq93NRTL8KyQ52FghAG0ouKELIy3FcTZhISAwxOB4gkT/Wz3Zwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.119.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1620297662
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id EEFD011024D21;
	Fri, 24 Oct 2025 18:20:21 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 19ccec2fb69042adb59bf7ed052f4203 for netdev@vger.kernel.org;
	Fri, 24 Oct 2025 18:20:22 CST
X-Transaction-ID: 19ccec2fb69042adb59bf7ed052f4203
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
Subject: [PATCH net v2 1/2] net: ip: add drop reasons when handling ip fragments
Date: Fri, 24 Oct 2025 18:20:11 +0800
Message-Id: <1761301212-34487-2-git-send-email-liyonglong@chinatelecom.cn>
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

1, add new drop reason FRAG_FAILED/FRAG_OUTPUT_FAILED
2, use drop reasons in ip_fragment

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 include/net/dropreason-core.h |  6 ++++++
 net/ipv4/ip_output.c          | 17 ++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 58d91cc..4ae042e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -99,6 +99,8 @@
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
 	FN(FRAG_TOO_FAR)		\
+	FN(FRAG_FAILED)			\
+	FN(FRAG_OUTPUT_FAILED)		\
 	FN(TCP_MINTTL)			\
 	FN(IPV6_BAD_EXTHDR)		\
 	FN(IPV6_NDISC_FRAG)		\
@@ -500,6 +502,10 @@ enum skb_drop_reason {
 	 * (/proc/sys/net/ipv4/ipfrag_max_dist)
 	 */
 	SKB_DROP_REASON_FRAG_TOO_FAR,
+	/* do ip/ip6 fragment failed */
+	SKB_DROP_REASON_FRAG_FAILED,
+	/* ip/ip6 fragment output failed */
+	SKB_DROP_REASON_FRAG_OUTPUT_FAILED,
 	/**
 	 * @SKB_DROP_REASON_TCP_MINTTL: ipv4 ttl or ipv6 hoplimit below
 	 * the threshold (IP_MINTTL or IPV6_MINHOPCOUNT).
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ff11d3a..3e0d21c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -588,7 +588,7 @@ static int ip_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			  htonl(mtu));
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 		return -EMSGSIZE;
 	}
 
@@ -765,6 +765,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct sk_buff *skb2;
 	u8 tstamp_type = skb->tstamp_type;
 	struct rtable *rt = skb_rtable(skb);
+	SKB_DR_INIT(reason, FRAG_FAILED);
 	unsigned int mtu, hlen, ll_rs;
 	struct ip_fraglist_iter iter;
 	ktime_t tstamp = skb->tstamp;
@@ -773,8 +774,10 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 
 	/* for offloaded checksums cleanup checksum before fragmentation */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
+	    (err = skb_checksum_help(skb))) {
+		SKB_DR_SET(reason, IP_CSUM);
 		goto fail;
+	}
 
 	/*
 	 *	Point into the IP datagram header.
@@ -860,6 +863,8 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 
 			if (!err)
 				IP_INC_STATS(net, IPSTATS_MIB_FRAGCREATES);
+			else
+				SKB_DR_SET(reason, FRAG_OUTPUT_FAILED);
 			if (err || !iter.frag)
 				break;
 
@@ -871,7 +876,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			return 0;
 		}
 
-		kfree_skb_list(iter.frag);
+		kfree_skb_list_reason(iter.frag, reason);
 
 		IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 		return err;
@@ -913,8 +918,10 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 */
 		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, skb2);
-		if (err)
+		if (err) {
+			SKB_DR_SET(reason, FRAG_OUTPUT_FAILED);
 			goto fail;
+		}
 
 		IP_INC_STATS(net, IPSTATS_MIB_FRAGCREATES);
 	}
@@ -923,7 +930,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	return err;
 
 fail:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 	return err;
 }
-- 
1.8.3.1


