Return-Path: <netdev+bounces-295250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8kxADOmDIWpHHwEAu9opvQ
	(envelope-from <netdev+bounces-295250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:55:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4FE64094D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:55:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GSGCo7IO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295250-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9438A30EFB4A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547B47DD60;
	Thu,  4 Jun 2026 13:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920B42DFE1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:39:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580390; cv=none; b=kBM60MLMCruPPofJkqNxhdNjZcleYPG6s6Lut/YXpTPUVGdcn2UftuJtxdM3cY3CqZI7VyXU3jTkZHfKR5ITIvNnd53XxZ7I9d+3yjbA3/tvKVfz/f6eXHAO72PUgVq7+EDiK+bfsxzp4tqgY07KReivOn9fOC87RjD8D84x8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580390; c=relaxed/simple;
	bh=PuiSfB+WWfQz7daTjBKFBNcRktJZ7+As3yZ6A7uLbLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSKPDhuFKHLVeWfStwPN2NnXNfAudFwG39Hx+krLjuFM0r5/me98bd9KIxMuLo67LxdlcY7XhzGS+Yrc8ITRSHFzJLxCd0EVNgQgfsLq6yQJ3XWvbn2P3hZ7rZUmB7SXG+1LFbnZi/yC5xcnNqWzG+f50LSod/3Dhj2Ok98OvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSGCo7IO; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4xCPaErfSPl/FhuiLk2OH2ArqCMXjkbm8he/8C5wbw=;
	b=GSGCo7IObybd+Bv991WlbdczLdhLXTTxONBbg8HcFxFaxk64H7Z8/h25Crgd3a48hQr4Ad
	CoDL2tEIgNbPjgm4l6YXn76CguBzaa1WmyTbR7Vbn2ot34kXGmh3QBtl/zpYypq/K7YQ8f
	2mtkPJkvLGGUQPJc5VGw+0uvVI0D7nE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-rDmLFS-eMs6UCiV-dGrKrg-1; Thu,
 04 Jun 2026 09:39:44 -0400
X-MC-Unique: rDmLFS-eMs6UCiV-dGrKrg-1
X-Mimecast-MFC-AGG-ID: rDmLFS-eMs6UCiV-dGrKrg_1780580382
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 427CB195608C;
	Thu,  4 Jun 2026 13:39:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E98530001A1;
	Thu,  4 Jun 2026 13:39:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: m.lobanov@rosa.ru
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mail@david-bauer.net,
	jchapman@katalix.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next v9] l2tp: fix double dst_release() on sk_dst_cache race
Date: Thu,  4 Jun 2026 15:39:31 +0200
Message-ID: <20260604133931.211224-1-pabeni@redhat.com>
In-Reply-To: <20260601213302.18761-1-m.lobanov@rosa.ru>
References: <20260601213302.18761-1-m.lobanov@rosa.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295250-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m.lobanov@rosa.ru,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:mail@david-bauer.net,m:jchapman@katalix.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE4FE64094D

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
l2tp: fix double dst_release() on sk_dst_cache race

This commit reworks the L2TP transmit path to stop using
inet6_csk_xmit() for IPv6 and to pre-route IPv4 packets via a new
helper, with the goal of avoiding a double dst_release() race between
sk_dst_check() and __sk_dst_check() on sk->sk_dst_cache observed under
pppol2tp traffic. New helpers l2tp_xmit_ipv6() and l2tp_xmit_ipv4()
replace the former inet6_csk_xmit() / ip_queue_xmit() calls in
l2tp_xmit_queue().

A few questions on the new helpers below.

> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index f940914959b1..54e837fec201 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1205,19 +1205,114 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
>  	return bufp - optr;
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +static int l2tp_xmit_ipv6(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ipv6_pinfo *np = inet6_sk(sk);
> +	struct inet_sock *inet = inet_sk(sk);
> +	struct in6_addr *final_p, final;
> +	struct ipv6_txoptions *opt;
> +	struct dst_entry *dst;
> +	struct flowi6 fl6;
> +	int err;

[ ... ]

> +	dst = ip6_sk_dst_lookup_flow(sk, &fl6, final_p, true);
> +	if (IS_ERR(dst)) {
> +		rcu_read_unlock();
> +		kfree_skb(skb);
> +		return NET_XMIT_DROP;
> +	}

[Medium]
Should this error path return a negative errno rather than
NET_XMIT_DROP?

l2tp_xmit_queue() converts the result of this function with:

	return err >= 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;

NET_XMIT_DROP is 0x01 (a positive value), so the wrapper takes the
err >= 0 branch and returns NET_XMIT_SUCCESS even though the skb has
already been freed via kfree_skb(). l2tp_xmit_skb() then bumps
session/tunnel tx_packets and tx_bytes (rather than tx_errors) for a
packet that never went out.

The IPv4 sibling l2tp_xmit_ipv4() returns -EHOSTUNREACH on the
analogous failure, and the inet6_csk_xmit() being replaced returned
PTR_ERR(dst) (negative) here. Returning PTR_ERR(dst) or -EHOSTUNREACH
would let the wrapper map this to NET_XMIT_DROP and have
l2tp_xmit_skb() count it as an error.

> +
> +	skb_dst_set(skb, dst);
> +	fl6.daddr = sk->sk_v6_daddr;
> +
> +	err = ip6_xmit(sk, skb, &fl6, READ_ONCE(sk->sk_mark),
> +		       opt, np->tclass,
> +		       READ_ONCE(sk->sk_priority));
> +	rcu_read_unlock();
> +	return err;
> +}
> +#endif
> +
> +static int l2tp_xmit_ipv4(struct sock *sk, struct sk_buff *skb, struct flowi *fl)
> +{
> +	struct inet_sock *inet = inet_sk(sk);
> +	struct net *net = sock_net(sk);
> +	struct ip_options_rcu *inet_opt;
> +	struct flowi4 *fl4;
> +	struct rtable *rt;
> +	__u8 tos;
> +	int err;
> +
> +	rcu_read_lock();
> +	inet_opt = rcu_dereference(inet->inet_opt);
> +	fl4 = &fl->u.ip4;
> +	tos = READ_ONCE(inet->tos);
> +
> +	rt = dst_rtable(sk_dst_check(sk, 0));

[High]
Does the cache-hit path leak a reference on the cached dst?

sk_dst_check() ultimately calls sk_dst_get(), which does
rcuref_get(&dst->__rcuref) and returns a dst with a caller-owned +1
reference.

> +	if (!rt) {
> +		__be32 daddr = inet->inet_daddr;
> +
> +		if (inet_opt && inet_opt->opt.srr)
> +			daddr = inet_opt->opt.faddr;
> +
> +		rt = ip_route_output_ports(net, fl4, sk,
> +					   daddr, inet->inet_saddr,
> +					   inet->inet_dport,
> +					   inet->inet_sport,
> +					   sk->sk_protocol,
> +					   tos & INET_DSCP_MASK,
> +					   READ_ONCE(sk->sk_bound_dev_if));
> +		if (IS_ERR(rt)) {
> +			rcu_read_unlock();
> +			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_OUTNOROUTES);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		sk_setup_caps(sk, &rt->dst);
> +	}
> +
> +	skb_dst_set_noref(skb, &rt->dst);
> +	rcu_read_unlock();
> +
> +	err = ip_queue_xmit(sk, skb, fl);
> +	return err;
> +}

[High]
Continuing on the cache-hit path: skb_dst_set_noref() stores the
pointer with SKB_DST_NOREF and explicitly does not consume a
reference, and ip_queue_xmit()/__ip_queue_xmit() only drop noref-
flagged dsts via skb_dst_drop()/refdst_drop without releasing a
reference. The +1 reference returned by sk_dst_check() is never put.

For comparison, net/ipv4/udp.c:udp_sendmsg() uses the same idiom and
explicitly calls ip_rt_put(rt) at its out: label to release this
reference. The previous behaviour relied on __ip_queue_xmit() using
__sk_dst_check() (the no-ref variant), which avoids this issue. Should
this helper also call ip_rt_put(rt) (or equivalent) on its way out?

Note that sk_dst_reset() drops only the cache's own ref, so the
leaked refs persist past socket close and the cached dst is never
freed, which appears to make this an unbounded leak under user-driven
sendmsg loops.

[Critical]
On the cache-miss path, can the rtable be freed before
__ip_queue_xmit() dereferences it?

ip_route_output_ports() returns rt with a +1 reference. sk_setup_caps()
calls sk_dst_set(), which xchg's sk_dst_cache and dst_releases the old
entry but does not take a new reference on the new rt; the caller's +1
ref is consumed by being installed into the cache slot.

After sk_setup_caps(), rt's only liveness anchor is sk->sk_dst_cache.
The function then does:

	skb_dst_set_noref(skb, &rt->dst);
	rcu_read_unlock();

	err = ip_queue_xmit(sk, skb, fl);

__ip_queue_xmit() takes its own rcu_read_lock(), starting a new
critical section. In the gap between rcu_read_unlock() here and the
new rcu_read_lock() inside __ip_queue_xmit(), an RCU grace period can
complete on this CPU.

A concurrent sk_dst_reset() (from a route update, sockopt, or another
lockless caller observing the dst as obsolete, similar to the
udpv6_sendmsg pattern described in the commit message) can xchg
sk_dst_cache to NULL and dst_release(rt), dropping the refcount 1->0
and queueing the rtable for free via call_rcu_hurry / dst_destroy_rcu.
If the grace period elapses in the rcu_read_unlock window, the rtable
is freed before __ip_queue_xmit() dereferences skb_rtable(skb)
(rt_uses_gateway, rt->dst, ...) at the packet_routed label.

skb_dst_set_noref() requires an unbroken RCU read-side critical
section spanning the entire skb consumption, which is the invariant
__ip_queue_xmit() itself maintains (its rcu_read_lock() spans
skb_dst_set_noref through ip_local_out). Should this helper either
hold rcu_read_lock() across the ip_queue_xmit() call, or take a real
reference (skb_dst_set() with dst_hold(), or skip the noref path) so
that rt cannot be freed during the handoff?
-- 
This is an AI-generated review.


