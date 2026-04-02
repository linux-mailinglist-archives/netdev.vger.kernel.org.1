Return-Path: <netdev+bounces-274642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPLoIw2szml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C2838CC0E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707633031815
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F53C5DBE;
	Thu,  2 Apr 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+lmZaO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF035DA6A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151873; cv=none; b=S1ryosmRblTvTfsDPJn/4+hxutHo/wh/3kYS70U8jWw4u8aNQmEqvbAfK/eKofnWZ4jBgj9Vq4Y67LHmfj/6Go/v3KgnPWcxOMZuk+jhzYzurnNJGmjZ6BvlpCtWq0+MJ1sG8grGX9KqEyXLSJw13bbNTk6x1zbh/nHpQQ/B8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151873; c=relaxed/simple;
	bh=lf/PpzKFCibcl4h4xLmp5BkRheQl1OeL9XlcJ8QMfg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cdCSH0LUtTThDo+HlNjfAe7Of1ORSGIqJ1Mz3PsxMSVGJB6KL9s/8Bt9qXOK3uBP6RHHl/4ELqX3Ql7AJe5wPlmA6/N912pZGA/QnNDqeuGy/lKKuETops1gq3EZGTs99CGrYKlVB6Z/bnyPb2nBpRYByXC4TsCn9yDL+eiQ3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+lmZaO7; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b3544bc7bso16158551cf.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151871; x=1775756671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=og+1QrbZz526bye7PyWeHOCm/FjVJLrkTCnbvweDwo4=;
        b=p+lmZaO7vcarlehzeEbOBqLJraGKgUvcMllbL8NWRLTcfJ2jz9nbQ0Q/eAE4ZcLpaM
         YUsXRqm2xwkQsy6gF+FM2Sdu4PAJrOcxntAoKiDX3wpn5L9GLcz3ju7EF2yRiS6IKXtK
         BRfSjY77M6ouY2ZqecGp6SlcSmxpxLfNd6FZPTDvQZKtJePQ2Z3VCVvOCNgclbdSrRUZ
         jEqBYGLvgh66AFbC72jCifJENX87eCgB+7KMAPx+Y6OLGqq5JP2ODP4D3SPj7sD+kJKr
         Uyn3kM2ZRYOe2GksSpYcSz9c4OL7j+6tpmbe+St8AA69rn2fOp4u9lSej9P4F3BPljw+
         pBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151871; x=1775756671;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=og+1QrbZz526bye7PyWeHOCm/FjVJLrkTCnbvweDwo4=;
        b=siP9vwRDeLZy45kg2y7LrQqml5V5M/oCS/NfYD4ZC7ZKsncIIroRDdfTwO7TKlASA+
         brfxvzDuOEQUk7uZJwIfMpTKQ4evmCM0VFYKjt7kR65KzZ/FRf/QCK5h5RIwvEzY3Z25
         MgaWiD5tNfs4MAF8rv797WQ5suugSdOXaYcfxFKa1H8BXHqnyI3eeP0STbO0m68u5vsp
         gXOI/p0Jq46+Kj7XKD6tQC40KJM7jraniuAOC2v8C/Lko0mpxMYvZ2/d0hXGmqlzi4mP
         omRk7tF6PoIoTKFhPTxZZ0a8TVKI5LnoZEtji2zEJaim3k2rI+FYnv44z2Q4mS3RuWMU
         fSxg==
X-Forwarded-Encrypted: i=1; AJvYcCX6lIAVZfJqx4MfzMMWmMSf38paDUDq1hAT5ANQ2TMnzJ5T+jWJ5HxmJ8i1CWj9DFz8vFT86F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuGxrQDguQKYX4dGQ3yXgoQ5nzlU8rOSSfP0u77wPowMBnXs0
	/uu4k9et0Vn2G4eEMprvS7xVfpXFS/u62hdr7pZbpD3jfD9plw316o100aiD8zw4yFFh2kF+BGX
	iGYHVjsVV5FlIDg==
X-Received: from qvr2.prod.google.com ([2002:a05:6214:d42:b0:89c:56ed:47d1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:65ca:b0:50b:51a0:f752 with SMTP id d75a77b69052e-50d628ae407mr2306441cf.15.1775151871102;
 Thu, 02 Apr 2026 10:44:31 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:44:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402174430.2462800-1-edumazet@google.com>
Subject: [PATCH net-next] inet: remove leftover EXPORT_SYMBOL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274642-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38C2838CC0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IPv6 is no longer a module, we no longer need to export these symbols.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c        |  4 ----
 net/ipv4/ipmr_base.c   | 13 -------------
 net/ipv4/udp_offload.c |  4 ----
 3 files changed, 21 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index fb397fbb28fc67f012d39398de5e9fdd1dd216bd..2f4fac22d1aba3d100c57a56b51efd57283430a5 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -263,7 +263,6 @@ bool icmp_global_allow(struct net *net)
 	}
 	return true;
 }
-EXPORT_SYMBOL(icmp_global_allow);
 
 void icmp_global_consume(struct net *net)
 {
@@ -273,7 +272,6 @@ void icmp_global_consume(struct net *net)
 	if (credits)
 		atomic_sub(credits, &net->ipv4.icmp_global_credit);
 }
-EXPORT_SYMBOL(icmp_global_consume);
 
 static bool icmpv4_mask_allow(struct net *net, int type, int code)
 {
@@ -1378,7 +1376,6 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	icmphdr->code = ICMP_EXT_CODE_MAL_QUERY;
 	return true;
 }
-EXPORT_SYMBOL_GPL(icmp_build_probe);
 
 /*
  *	Handle ICMP Timestamp requests.
@@ -1600,7 +1597,6 @@ void ip_icmp_error_rfc4884(const struct sk_buff *skb,
 	if (!ip_icmp_error_rfc4884_validate(skb, off))
 		out->flags |= SO_EE_RFC4884_FLAG_INVALID;
 }
-EXPORT_SYMBOL_GPL(ip_icmp_error_rfc4884);
 
 int icmp_err(struct sk_buff *skb, u32 info)
 {
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index fd27f2ca69783bc04e76a42c0382b87a64069a07..37a3c144276c75d56d5d295a2c852f5ffd262f65 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -27,7 +27,6 @@ void vif_device_init(struct vif_device *v,
 	else
 		v->link = dev->ifindex;
 }
-EXPORT_SYMBOL(vif_device_init);
 
 struct mr_table *
 mr_table_alloc(struct net *net, u32 id,
@@ -60,7 +59,6 @@ mr_table_alloc(struct net *net, u32 id,
 	table_set(mrt, net);
 	return mrt;
 }
-EXPORT_SYMBOL(mr_table_alloc);
 
 void *mr_mfc_find_parent(struct mr_table *mrt, void *hasharg, int parent)
 {
@@ -74,7 +72,6 @@ void *mr_mfc_find_parent(struct mr_table *mrt, void *hasharg, int parent)
 
 	return NULL;
 }
-EXPORT_SYMBOL(mr_mfc_find_parent);
 
 void *mr_mfc_find_any_parent(struct mr_table *mrt, int vifi)
 {
@@ -89,7 +86,6 @@ void *mr_mfc_find_any_parent(struct mr_table *mrt, int vifi)
 
 	return NULL;
 }
-EXPORT_SYMBOL(mr_mfc_find_any_parent);
 
 void *mr_mfc_find_any(struct mr_table *mrt, int vifi, void *hasharg)
 {
@@ -109,7 +105,6 @@ void *mr_mfc_find_any(struct mr_table *mrt, int vifi, void *hasharg)
 
 	return mr_mfc_find_any_parent(mrt, vifi);
 }
-EXPORT_SYMBOL(mr_mfc_find_any);
 
 #ifdef CONFIG_PROC_FS
 void *mr_vif_seq_idx(struct net *net, struct mr_vif_iter *iter, loff_t pos)
@@ -124,7 +119,6 @@ void *mr_vif_seq_idx(struct net *net, struct mr_vif_iter *iter, loff_t pos)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(mr_vif_seq_idx);
 
 void *mr_vif_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -143,7 +137,6 @@ void *mr_vif_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(mr_vif_seq_next);
 
 void *mr_mfc_seq_idx(struct net *net,
 		     struct mr_mfc_iter *it, loff_t pos)
@@ -168,7 +161,6 @@ void *mr_mfc_seq_idx(struct net *net,
 	it->cache = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(mr_mfc_seq_idx);
 
 void *mr_mfc_seq_next(struct seq_file *seq, void *v,
 		      loff_t *pos)
@@ -203,7 +195,6 @@ void *mr_mfc_seq_next(struct seq_file *seq, void *v,
 
 	return NULL;
 }
-EXPORT_SYMBOL(mr_mfc_seq_next);
 #endif
 
 int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
@@ -275,7 +266,6 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 	rtm->rtm_type = RTN_MULTICAST;
 	return 1;
 }
-EXPORT_SYMBOL(mr_fill_mroute);
 
 static bool mr_mfc_uses_dev(const struct mr_table *mrt,
 			    const struct mr_mfc *c,
@@ -347,7 +337,6 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 	cb->args[1] = e;
 	return err;
 }
-EXPORT_SYMBOL(mr_table_dump);
 
 int mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb,
 		     struct mr_table *(*iter)(struct net *net,
@@ -390,7 +379,6 @@ int mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb,
 
 	return skb->len;
 }
-EXPORT_SYMBOL(mr_rtm_dumproute);
 
 int mr_dump(struct net *net, struct notifier_block *nb, unsigned short family,
 	    int (*rules_dump)(struct net *net,
@@ -444,4 +432,3 @@ int mr_dump(struct net *net, struct notifier_block *nb, unsigned short family,
 
 	return 0;
 }
-EXPORT_SYMBOL(mr_dump);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 98e92da726b5ec1ce2d12f8de2642f9c11f056a4..a0813d425b7162367866786f1f5d862d1efdcbf5 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -343,7 +343,6 @@ struct sk_buff *skb_udp_tunnel_segment(struct sk_buff *skb,
 
 	return segs;
 }
-EXPORT_SYMBOL(skb_udp_tunnel_segment);
 
 static void __udpv4_gso_segment_csum(struct sk_buff *seg,
 				     __be32 *oldip, __be32 *newip,
@@ -635,7 +634,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	}
 	return segs;
 }
-EXPORT_SYMBOL_GPL(__udp_gso_segment);
 
 static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 					 netdev_features_t features)
@@ -852,7 +850,6 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	skb_gro_flush_final(skb, pp, flush);
 	return pp;
 }
-EXPORT_SYMBOL(udp_gro_receive);
 
 static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 					__be16 dport)
@@ -957,7 +954,6 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 
 	return err;
 }
-EXPORT_SYMBOL(udp_gro_complete);
 
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
-- 
2.53.0.1213.gd9a14994de-goog


