Return-Path: <netdev+bounces-233062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E7C0BB34
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750F94E5AC1
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D602D47FD;
	Mon, 27 Oct 2025 02:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-05.21cn.com [182.42.157.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BE2D24BC
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533043; cv=none; b=E2eNdUsbhlxtekwNXzi7/cGJiNvjJc86j7xz4/A5G+BRJ95JDy1MvPdJf7xkcUAyJ10enXwMiN3azQEPshVMs8cXIGZyJ5Y4hU/SdKH+UwCPHWx3paTGr+sluHOUa6tWI8TDyPM65DfruCIHJGB/itN28a3cPFcl6q8qs9C5XSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533043; c=relaxed/simple;
	bh=RsfNXtwq4Ako8GAoyAd7THB8q1URFVyoy6ocbUg1qZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9dikR5xkwJ2oXPKRJR+AotUjRkP1d8iUMhHv7IKM6LE/z1C+XGfEbaR0thHIQFaxnB+NZJnCPVZKBiUzUu3VX7uV/CiIVQGMpga0cHfYgtjnVSFAwARbx5QNTbUgWFuQ4tjsxcGNzRHX1Tk5FZ+Nr4llYy/CzIDYsaZQvUBX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1314971392
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id E976E8F77F;
	Mon, 27 Oct 2025 10:32:54 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-z742x with ESMTP id 43f0e618aefa4815a004e303635e9a58 for netdev@vger.kernel.org;
	Mon, 27 Oct 2025 10:32:56 CST
X-Transaction-ID: 43f0e618aefa4815a004e303635e9a58
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
Date: Mon, 27 Oct 2025 10:32:44 +0800
Message-Id: <1761532365-10202-2-git-send-email-liyonglong@chinatelecom.cn>
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
index ff11d3a..2eab175 100644
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
+		SKB_DR_SET(reason, SKB_CSUM);
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


