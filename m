Return-Path: <netdev+bounces-291256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGkoOmMIFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:29:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF95C7C44
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD0493045EDF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F843D413C;
	Mon, 25 May 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnqLbpZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEB3E16B0
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697520; cv=none; b=qlJze7s53Pg+v0OpY4Y1LsvBQ/B7evwsxum/s9psK+yKKFu3G1p2hSHEU+KaFZE2o7FImBmsS6I96pG3elMTLbdY7ICP/TvviyxludPQQNoLX9Pccm6JZ/T7kQcvZFX5XJm8A0Rp4r9X74UjEFy1oNIeHNun0g07AqDLzYy4T38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697520; c=relaxed/simple;
	bh=tXR5adZ+hiNuzu19P523m38I5BN212Afmab4/7CyniE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Iew4QXRHXPobO6UOech1TmBtptmxaBdYzIKdAOq4IJE1QlqQUS2smCscFp+0+NCElJlohysVuyk0z5TpL5zX9CHiWoChQ9xzy756LIkKdPC85xFxRq3KIuXp0Ze8Y910IgiRMyTRc5afMh8NuiPXUaGcUP4Ntce9gyiFaH24+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnqLbpZQ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-914a8522bd2so828664185a.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779697517; x=1780302317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+TBR5KfJd1HD1SwhtfgdP1LdbhTmYV08rwQMllL6LI4=;
        b=SnqLbpZQ8ZG7hwGBiRqOb+kVYOXRhek8oHvlN4i7kBJOeL55RSbh7E3FRWVOofg91G
         n06s1A/FgEjFfov8tAjqbo/ZXWVxyjvCOjNjtApQzf0ZmT8oDC2Ly9fJqirmV2N7oIVW
         0PQ899EpxlzZHTQIeMMpLOGXv60YANDSVkALpyscF4DTtBACFYL7Ekum4CPWFCkAyITI
         eolRdqnG/Uo/eQ+fwXfP5RV4+pyFRbWWXqJfEp3FY7l5J8gzVA7UR37Q1DJvEBojowEC
         ba8rDgLqj4+SHdOLwDKeNaSXhfpn3P2R72Q5mUUlfQk5Zsp+qg7Kcg5E6MqVybnmV5G1
         lb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697517; x=1780302317;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TBR5KfJd1HD1SwhtfgdP1LdbhTmYV08rwQMllL6LI4=;
        b=lnMpJxkPZdDCMZPZDT9ErOT4TYdvGmd9NzpgYaJv5NVB0KPaGKgvZ61Y01jMqt7bXw
         2ZlQl3iziOtNv0vUkpjMorJu53MU5mmX9lsB1v5wHsiS0nBl7CBnwO91P3B5pKicbeKw
         wup2vctB06F/H4gviIJM1doBePrgRsBT8jqC57ITvuNxKlxor5BdAIZom+ZOSOG3KUy8
         AJqaC0Za4fyDZqMbmiw3TaU2AGHSfVyroaaEEozRPL2Nn+w2y9kjWpnGd9SaMPBCF10B
         NjM/kzemWEXvtFFvW7c/s8dMqCR/p21f+qVQwnfNefbpGOz9xNICvzNDcxBHHjp/Zdtn
         HMCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Alo1kLpQ0gqL5Hh2+rgWDDRZXqwR7hEURMQpIfziw6ObLPHfFh/w//7gaczLjaE++v9RoL9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrODNidKO9iaPZjLofcnr4mlqmMjaCgTzeuzFwSvh1AEZvjoN
	0TS9IAQv7fYRpaJ8O0sKloPLp1HNxL/3SU6h3TjQt3ibrsHiuhsVhYzy7elOTNFy3G7Gk78au/u
	dWJMnsq0+HHTKMQ==
X-Received: from qtiz3.prod.google.com ([2002:ac8:1003:0:b0:50b:4963:99fa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:418b:b0:50e:635b:5562 with SMTP id d75a77b69052e-516d587d00fmr145303881cf.22.1779697517167;
 Mon, 25 May 2026 01:25:17 -0700 (PDT)
Date: Mon, 25 May 2026 08:25:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525082510.1554447-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: ifrags: cleanup __IP6_INC_STATS() confusion
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291256-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CFF95C7C44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After commits e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original
netdev") and bdb7cc643fc9 ("ipv6: Count interface receive statistics
on the ingress netdev") net/ipv6/reassembly.c uses three different
ways to reach idev in various __IP6_INC_STATS() calls.

- ip6_dst_idev(skb_dst(skb))
- __in6_dev_get_safely(skb->dev)
- __in6_dev_stats_get(skb->dev)

Lets centralize this from ipv6_frag_rcv() and use __in6_dev_stats_get().

Note that ipv6_frag_rcv() tests if skb->dev could be NULL already, so
I chose to also guard against NULL, but we probably can remove the
tests in a followup patch, because I do not think skb->dev could be NULL.

iif = skb->dev ? skb->dev->ifindex : 0;

idev can be NULL, __IP6_INC_STATS() deals with this possibility.

Small code size reduction as a bonus.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-116 (-116)
Function                                     old     new   delta
ipv6_frag_rcv                               2492    2474     -18
ip6_frag_reasm                               807     709     -98
Total: Before=24655281, After=24655165, chg -0.00%

Fixes: e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original netdev")
Fixes: bdb7cc643fc9 ("ipv6: Count interface receive statistics on the ingress netdev")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/reassembly.c | 46 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 11f9144bebbe2cf0152992c526fb6728f83f462d..05c51f669754a1a10e944bb7c4433565bcaacb40 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -69,7 +69,7 @@ static struct inet_frags ip6_frags;
 
 static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 			  struct sk_buff *prev_tail, struct net_device *dev,
-			  int *refs);
+			  struct inet6_dev *idev, int *refs);
 
 static void ip6_frag_expire(struct timer_list *t)
 {
@@ -107,7 +107,8 @@ fq_find(struct net *net, __be32 id, const struct ipv6hdr *hdr, int iif)
 static int ip6_frag_queue(struct net *net,
 			  struct frag_queue *fq, struct sk_buff *skb,
 			  struct frag_hdr *fhdr, int nhoff,
-			  u32 *prob_offset, int *refs)
+			  u32 *prob_offset, int *refs,
+			  struct inet6_dev *idev)
 {
 	int offset, end, fragsize;
 	struct sk_buff *prev_tail;
@@ -133,8 +134,7 @@ static int ip6_frag_queue(struct net *net,
 		 * we do not free it here.
 		 */
 		inet_frag_kill(&fq->q, refs);
-		__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-				IPSTATS_MIB_REASMFAILS);
+		__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
 		return -1;
 	}
 
@@ -167,8 +167,7 @@ static int ip6_frag_queue(struct net *net,
 			 */
 			*prob_offset = offsetof(struct ipv6hdr, payload_len);
 			inet_frag_kill(&fq->q, refs);
-			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-					IPSTATS_MIB_REASMFAILS);
+			__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
 			return -1;
 		}
 		if (end > fq->q.len) {
@@ -227,7 +226,7 @@ static int ip6_frag_queue(struct net *net,
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		err = ip6_frag_reasm(fq, skb, prev_tail, dev, refs);
+		err = ip6_frag_reasm(fq, skb, prev_tail, dev, idev, refs);
 		skb->_skb_refdst = orefdst;
 		return err;
 	}
@@ -242,12 +241,10 @@ static int ip6_frag_queue(struct net *net,
 		goto err;
 	}
 	err = -EINVAL;
-	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-			IPSTATS_MIB_REASM_OVERLAPS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASM_OVERLAPS);
 discard_fq:
 	inet_frag_kill(&fq->q, refs);
-	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-			IPSTATS_MIB_REASMFAILS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
 err:
 	kfree_skb_reason(skb, reason);
 	return err;
@@ -262,7 +259,7 @@ static int ip6_frag_queue(struct net *net,
  */
 static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 			  struct sk_buff *prev_tail, struct net_device *dev,
-			  int *refs)
+			  struct inet6_dev *idev, int *refs)
 {
 	struct net *net = fq->q.fqdir->net;
 	unsigned int nhoff;
@@ -311,7 +308,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	skb_postpush_rcsum(skb, skb_network_header(skb),
 			   skb_network_header_len(skb));
 
-	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMOKS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMOKS);
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
 	fq->q.last_run_head = NULL;
@@ -323,7 +320,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 out_oom:
 	net_dbg_ratelimited("ip6_frag_reasm: no memory for reassembly\n");
 out_fail:
-	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
 	inet_frag_kill(&fq->q, refs);
 	return -1;
 }
@@ -332,15 +329,18 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 {
 	const struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct net *net = skb_dst_dev_net(skb);
+	struct inet6_dev *idev;
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	u8 nexthdr;
 	int iif;
 
+	idev = skb->dev ? __in6_dev_stats_get(skb->dev, skb) : NULL;
+
 	if (IP6CB(skb)->flags & IP6SKB_FRAGMENTED)
 		goto fail_hdr;
 
-	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_REASMREQDS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMREQDS);
 
 	/* Jumbo payload inhibits frag. header */
 	if (hdr->payload_len == 0)
@@ -356,8 +356,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	if (!(fhdr->frag_off & htons(IP6_OFFSET | IP6_MF))) {
 		/* It is not a fragmented frame */
 		skb->transport_header += sizeof(struct frag_hdr);
-		__IP6_INC_STATS(net,
-				ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_REASMOKS);
+		__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMOKS);
 
 		IP6CB(skb)->nhoff = (u8 *)fhdr - skb_network_header(skb);
 		IP6CB(skb)->flags |= IP6SKB_FRAGMENTED;
@@ -374,8 +373,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	 */
 	nexthdr = hdr->nexthdr;
 	if (ipv6frag_thdr_truncated(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr), &nexthdr)) {
-		__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
-				IPSTATS_MIB_INHDRERRORS);
+		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 		icmpv6_param_prob(skb, ICMPV6_HDR_INCOMP, 0);
 		return -1;
 	}
@@ -391,14 +389,13 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 
 		fq->iif = iif;
 		ret = ip6_frag_queue(net, fq, skb, fhdr, IP6CB(skb)->nhoff,
-				     &prob_offset, &refs);
+				     &prob_offset, &refs, idev);
 
 		spin_unlock(&fq->q.lock);
 		rcu_read_unlock();
 		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
-			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
-					IPSTATS_MIB_INHDRERRORS);
+			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			/* icmpv6_param_prob() calls kfree_skb(skb) */
 			icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, prob_offset);
 		}
@@ -406,13 +403,12 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	}
 	rcu_read_unlock();
 
-	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_REASMFAILS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_REASMFAILS);
 	kfree_skb(skb);
 	return -1;
 
 fail_hdr:
-	__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
-			IPSTATS_MIB_INHDRERRORS);
+	__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 	icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, skb_network_header_len(skb));
 	return -1;
 }
-- 
2.54.0.746.g67dd491aae-goog


