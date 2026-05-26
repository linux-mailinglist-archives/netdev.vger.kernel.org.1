Return-Path: <netdev+bounces-291730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFmfF4a3FWqwYgcAu9opvQ
	(envelope-from <netdev+bounces-291730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:08:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B34835D858F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1546430DBC3C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCE405C56;
	Tue, 26 May 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYDZyXRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18881401494
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807339; cv=none; b=gRpFtahH1JUJWhYNp7po3EqSksiMqXShi95CcbO3r9kuHcIhzahBzze8+XMXvHh86Ylye9laKOgWrDDOxCEz6pOL3t3J5pBhNCsfXiAdBEphuZ6s7afVoGMo0FE8eQ3VP8ZYWkhapRig4U1BBwvpPXerBu4uQPBmR/WXUH6Afpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807339; c=relaxed/simple;
	bh=W2+Lyer4OU5tVqf37I5oImfRqg+BImRn3Ce+2j9HbwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/3na3qsOV/rdj06cR+/bopXKPIWPfe8GtS7Qu+JDYQC9f9/HO1xqM68ecgMafa9ogVODKAOq7WKkFsBYkpUvJp5PaaDvljnYznR20q0VX2XM/RNoVled8SCwCV7C8MWtaOduzaNaV5SZplK8Lzzt8YMyYzySMGpxr1/r0ueUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYDZyXRU; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8b7a1ea06bfso47104166d6.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779807334; x=1780412134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GG03MF/hfF8zIzGePES1/SXPErAoirzYUZ8TGgoSw0w=;
        b=VYDZyXRUi5I4SRbXmFciIF+WuJQTDQ7Ztxt9cq/S8UgQlBhBSXXVdDlm2L/yomMGcV
         66pFoK7F5e/oX1a/fNBoR4bEnE909X9wkigqA2ywifmcG3RuJz0Z693uaSE+7bmS3ypr
         XS5ZrgFw1DUInJiKQAux8lUs4XGsXKzzcgAr/M5wjalS7cHbhOYQoU+YlukopStVheCH
         I7/ZGk86zg0dYT/vJ+zB/onB6nESMHLLaN9nMjs1TzdkHEr62H/Hbb1P/FYVZgiOZrPc
         I2HcvrYJ1CZ+Q8/QkN/oJFmKRv1H01DuvENCnXYxpyV4Ph5kPpbkWAzN247RAy3/bHVG
         DCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807334; x=1780412134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG03MF/hfF8zIzGePES1/SXPErAoirzYUZ8TGgoSw0w=;
        b=MhsOhGiZ82pjmRFM68Wj8bc2375SO7OwD7/06vcRup76Qnfo8lMi73Y6az28IFOGoD
         uDZo9ja83/VNwvgvavF+6O4MJpEvKW8XzZBUl/d+nopA0dtdZ8XJ8Zk7KentvPfBMBEE
         wlMZVQnNbFCMheefwkr2JTVLIhct+MU2Q8SOwmvDQHKvdGnOIHFwhw+WXRGOvuWoX9bG
         epZ3oejwjLyPADvT3iKe8EeNq2Pjlna0Fs6LmQiEvodNbEeEca9aLH9JVP2ttjCDlNiL
         irY1ifyfBRhkhErgBiJa4YJHboa6nu6tWDwhw4FRwIslwtwxSj9T1q9skQkj+Snoi2nr
         EI0g==
X-Forwarded-Encrypted: i=1; AFNElJ8BO5R62u/kRP8tO8zXPQzDMJFyHwS9ZzU7n1mIwYGoxDnMYweH4EvPaJkmXzRavUMlP/VAOoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALzRun2PtVbfnm0irYOmU3e2Z/5Ow2zaCJaSNr01ocZNdUQJ9
	Hv92qNPZQ+1MAZENA3l23CrUvjJyIc64AU6ZYOCnZhUvnCDcMdYV7pJJcHwA08VZwN7KNA0j13l
	QcBKGSrlBwOQt3Q==
X-Received: from qknvw8.prod.google.com ([2002:a05:620a:5648:b0:913:40cd:8975])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:280c:b0:90f:c88d:ebce with SMTP id af79cd13be357-914b46ca1d7mr2698344985a.1.1779807334157;
 Tue, 26 May 2026 07:55:34 -0700 (PDT)
Date: Tue, 26 May 2026 14:55:29 +0000
In-Reply-To: <20260526145529.3587126-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526145529.3587126-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526145529.3587126-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/2] ipv6: frags: cleanup __IP6_INC_STATS() confusion
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291730-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B34835D858F
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
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-145 (-145)
Function                                     old     new   delta
ipv6_frag_rcv                               2399    2362     -37
ip6_frag_reasm                               705     597    -108
Total: Before=31455552, After=31455407, chg -0.00%

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


