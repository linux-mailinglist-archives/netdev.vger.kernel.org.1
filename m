Return-Path: <netdev+bounces-232350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE959C047EB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793D83B7548
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A7319C553;
	Fri, 24 Oct 2025 06:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-04.21cn.com [182.42.158.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608B72627
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.158.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287466; cv=none; b=IzPVP4kDT21hFkws5eK3mYk2PQvBSrqB4Ir2IVQvqBfNid7kuiCDd/zmA19BbI4zrdyUkKw3VyRAVl0X2Ju+U1iAWgIhyEQsw7jeUaB7CjdGwVdpoo0PfsSXeClSDgjZ7pcYhL3f+gz7uB2K636Xm3kHCLmj5Z0FJJCaKU6i2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287466; c=relaxed/simple;
	bh=lb6TxgAKGMNvVKSNIH0RmaEhzCNBlCmWrBRtHZfOJow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyZvaPEeYbuab4rYwa2WSuFAb/vwgegNgvupn9KdkIYQXaPkT4HLNSdcS2YWbc0NRa7HCU8MHMLq7PvwQU8nxNfOHgYqWyl6Br/pB3rnqdOXVANzoYRnFo1iiOHqyEfKD/VsnboqOiymAYJHX2eS90WCkRGa5kCfVMPel8sr1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.158.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1801105929
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id CA1CE9C2603;
	Fri, 24 Oct 2025 14:23:33 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 25ee0811a1a34fc5a8eddc550e2169d7 for netdev@vger.kernel.org;
	Fri, 24 Oct 2025 14:23:35 CST
X-Transaction-ID: 25ee0811a1a34fc5a8eddc550e2169d7
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
Subject: [PATH net 1/2] net: ip: add drop reasons when handling ip fragments
Date: Fri, 24 Oct 2025 14:23:15 +0800
Message-Id: <1761286996-39440-2-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

1, add new drop reason FRAG_FAILED, and use it in ip_do_fragment
2, use drop reasons PKT_TOO_BIG in ip_fragment

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 include/net/dropreason-core.h | 3 +++
 net/ipv4/ip_output.c          | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 58d91cc..7da80f4 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -99,6 +99,7 @@
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
 	FN(FRAG_TOO_FAR)		\
+	FN(FRAG_FAILED)			\
 	FN(TCP_MINTTL)			\
 	FN(IPV6_BAD_EXTHDR)		\
 	FN(IPV6_NDISC_FRAG)		\
@@ -500,6 +501,8 @@ enum skb_drop_reason {
 	 * (/proc/sys/net/ipv4/ipfrag_max_dist)
 	 */
 	SKB_DROP_REASON_FRAG_TOO_FAR,
+	/* do ip/ip6 fragment failed */
+	SKB_DROP_REASON_FRAG_FAILED,
 	/**
 	 * @SKB_DROP_REASON_TCP_MINTTL: ipv4 ttl or ipv6 hoplimit below
 	 * the threshold (IP_MINTTL or IPV6_MINHOPCOUNT).
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ff11d3a..879fe49 100644
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
 
@@ -871,7 +871,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			return 0;
 		}
 
-		kfree_skb_list(iter.frag);
+		kfree_skb_list_reason(iter.frag, SKB_DROP_REASON_FRAG_FAILED);
 
 		IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 		return err;
@@ -923,7 +923,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	return err;
 
 fail:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_FAILED);
 	IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 	return err;
 }
-- 
1.8.3.1


