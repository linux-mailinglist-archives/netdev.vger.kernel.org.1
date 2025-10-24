Return-Path: <netdev+bounces-232352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A52C047F1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC719A8454
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9772627;
	Fri, 24 Oct 2025 06:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-04.21cn.com [182.42.158.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC2154425
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.158.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287469; cv=none; b=QtWljFjjyUDSdMB1NMqQ0AN5h+GRt11s0sbcNYaQn/JgBaX9yMZCzKhOcUssQlBvdqqJS2TA/wbKt+WQqQa98Lp3pgeCBv+TuMJ6s3wp34rlSb6DeQWdrsgJQnXk9J2S93OVIztxU5l+OuUKkN6K1aiTkkF2BJuxLzyvMYov4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287469; c=relaxed/simple;
	bh=4/ozPTC0PkeTsvJ4b8ouwNy/sk7MDEeFEe9UX6elrO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSa0zn9NV/Zpk5Nb0jdDpkmQw/mK/fy0yMuicwSmBTu2VsC6s+HGFkxn2bLdSJth/9yN7mjCR9HgXUziKtmij8cvLJEhP1wwsERRT9I2R3DyfaNjS8ykWVQevIhXDzUBZOmjG2NZ2dTBE8dyEiw01wf3YmFCzbbdHg/ZOHTULoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.158.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1801105929
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.5 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id F0B869C2608;
	Fri, 24 Oct 2025 14:23:37 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.5])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 2bc719922f474e67910142104d1008df for netdev@vger.kernel.org;
	Fri, 24 Oct 2025 14:23:38 CST
X-Transaction-ID: 2bc719922f474e67910142104d1008df
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
Subject: [PATH net 2/2] net: ipv6: use drop reasons in ip6_fragment
Date: Fri, 24 Oct 2025 14:23:16 +0800
Message-Id: <1761286996-39440-3-git-send-email-liyonglong@chinatelecom.cn>
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

use drop reasons in ip6_output like ip_fragment/ip_do_fragment

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/ipv6/ip6_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e..575c7d1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -875,6 +875,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *))
 {
 	struct sk_buff *frag;
+	enum skb_drop_reason reason = SKB_DROP_REASON_FRAG_FAILED;
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
@@ -995,7 +996,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			return 0;
 		}
 
-		kfree_skb_list(iter.frag);
+		kfree_skb_list_reason(iter.frag, reason);
 
 		IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
 			      IPSTATS_MIB_FRAGFAILS);
@@ -1050,12 +1051,13 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 
 fail_toobig:
 	icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
+	reason = SKB_DROP_REASON_PKT_TOO_BIG;
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


