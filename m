Return-Path: <netdev+bounces-301620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cedQAazDO2oFcggAu9opvQ
	(envelope-from <netdev+bounces-301620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:46:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545216BDCAD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:46:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TLNIv8rC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301620-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301620-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6121C301A3A5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533923815B;
	Wed, 24 Jun 2026 11:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFF276028
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:45:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301513; cv=none; b=rrcEI4Hf1CPqqbIoNd+YIu9XAO60JE2/yDdMoYyAHiABFNw+OGeXICpXk6aRqwj1QrVVFqTdpqZpqfzSE8YMN/iv2c6C9UUX43jpz3QGhZ8tAaAThk9bpH/7e/L6LRpOcFmlEbSbvO3XMHZT9cj6MZwQM8B2ZrzGToRUdJdCy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301513; c=relaxed/simple;
	bh=H0MRJG2B1K/Bvnq9zsM3jp2THI6jTdOIvZbAQF4IfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdi/NJN6JS+SOa6rkCNtmQubYERZsu+zNnE2aH4GLr5ZICRVEn+bPhRgWw5Hmm40DvVbDn1mWuxs1U2hDLU45COD1DCkX6kefzGhtlHDHeFFVJzjTCIVPVThsJFinZEIWRxrWKL6hNHdgtgeIPr3LWCgDQZMRt+c9vgG+mUUSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLNIv8rC; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so9440975e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782301511; x=1782906311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDHdE2/Ft54Y11URM0gtdL1NQZS1frqRaxNwltOdGA0=;
        b=TLNIv8rCVLkYh+LyX0Ix7lUnkuVLsy1hJMyWWMgnbfdaig4Zc4iTEdlvN9fMDYc74y
         rC93pcEeh+ZwKCYTqrUR9tq8WDoNAHb47TJhHbeVi3nb8FHfJIvIjBGA4UGcAttZnhIL
         so9A0HPk16ttKoLS+t/i9BHdscAVBqT6/lB6kJhDXtnb4q+h9ISL+ma5yJOKbNSfA/VZ
         9dSZrieI8GcoZkEM89x7xIZWAdW0iiOgnAIxKcosB+tciKSGFZU1ufZA4q33LxbUlbio
         0nPj5eK6fFkfoRYDMP3WxJw9a1BlfRWtXwYuIvEpSuw0DxjNCFtYBnW5+o50bi8gocTz
         q33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782301511; x=1782906311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDHdE2/Ft54Y11URM0gtdL1NQZS1frqRaxNwltOdGA0=;
        b=htsI3LuQVtdnwwULxdYy9KXpfx5IiZFJCdeFkdlKV4+nfJqO9l87s/8u5Jz5EjAEhQ
         scuYv1M1Mq6cXUptlbFY8ZRtv0XyVs+jOfszZYTb2+dR1Nc8RNr6PApn+DBMeMxgiA7f
         l/7yAF+ctguGSNNsbOgvpMEKP3VCaouoBeirl89iC9vpLmTaBPr5UT7l7/DDy9NDqW6u
         8zlX/e3FTaG4A2grL4BQKnLMLkcSYrmmCMAVXs9Qbfp8pyduwZEbjl+bW9++A1uH1dq1
         FvCzQT6S0D0b5cXoGmU5iHpzfRBXBMouDv0EmL/MlBRPn6ze9QRWhR2f7e7owmQ76fvY
         pkGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6Lbqrdzv9l70VvpwOHxi1IDVBgd0i4rh+8WqpSX5PRZzJqQ1uBs5fS2lt5cwdI540WCv1XGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgyFODISAtgme/PgeurWgkA96MghV/MYF039sO8wdI7MDItLuC
	Rxf4P7ZIH8D6PBsbL4vR8BXiv/A8RbYe2HPPuoV5oVkxES5xyHxSCKpM
X-Gm-Gg: AfdE7cnt+Y73Fmf3kg9PNNlnWunSmG7vADZazx7ah+YimZ0JmBI69ntOoTT3dqPdTut
	Ri8lpm2oIYg4C/hcTB0KDv2uWAdQJtvqSnyqD0GdMCdG6sKOgHA4xqi3mKMnqip1A3L/Q71pxHt
	0/7Fczs8/N+4wxFfrflKBCU+VjKOvT5BdYQeFxOxuCkKL555lhCU9BSFfpV3wutaiQNerdKy6RR
	OLUDz7Lqt1dpWsIKqiY+3KrFZjvwrT4+uKy8kh9tHOQDcwohZsVYUvIA1mfGQMd8GSfuX7IOLla
	OttXHT2YraU2BhNwbPRxNyhEXhUzCbaWSKOxivnZF5C2UmPcm5bIL6Fcr5wHQqhBeQp1Ua/547B
	IuuhV9CB7cKg5YY/SpzyotpJ+BmoQsUxvFG4atn8OBZhZa4pAvvidJ3I6hBIXJYsvdvaPEUSInD
	vGHvTJxPRRcQIV4twAIKXWOyTbWy/Ftiko1frQgfTirGLu
X-Received: by 2002:a05:600c:1d0a:b0:492:409d:b7c3 with SMTP id 5b1f17b1804b1-4925b359fc2mr103143745e9.13.1782301510374;
        Wed, 24 Jun 2026 04:45:10 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c225b2988sm5854285f8f.25.2026.06.24.04.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:45:09 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:45:08 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, edumazet@google.com, john.fastabend@gmail.com,
	jordan@jrife.io, kuba@kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
Message-ID: <ajvDRCw8cPqXAqQq@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-4-mahe.tardy@gmail.com>
 <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>
 <ajuqZMzqACLOijoC@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajuqZMzqACLOijoC@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 545216BDCAD

On Wed, Jun 24, 2026 at 11:59:00AM +0200, Mahe Tardy wrote:
> On Tue, Jun 23, 2026 at 10:09:20PM -0400, Emil Tsalapatis wrote:
> > On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> 
> [...]
> 
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +	case htons(ETH_P_IPV6):
> > > +		if (type != ICMPV6_DEST_UNREACH)
> > > +			return -EOPNOTSUPP;
> > > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > > +			return -EINVAL;
> > > +
> > > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > > +		if (!nskb)
> > > +			return -ENOMEM;
> > > +
> > > +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
> > 
> > Minor nit, but this may also fail with SKB_DROP_REASON_NOMEM. Now this is only
> > possible if the IP header is not in the linear space which may well be
> > impossible (?), but do we want to differentiate with
> > pskb_network_may_pull_reason()?
> 
> Indeed, I think for the IP header is should be fine, but I replaced it
> with the reason variant. Thanks!
>  
> > > +			kfree_skb(nskb);
> > > +			return -EBADMSG;
> > > +		}
> > > +
> 
> [...]
> 
> > >  static int __init bpf_kfunc_init(void)
> > >  {
> > >  	int ret;
> > > @@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
> > >  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> > >  					       &bpf_kfunc_set_sock_addr);
> > >  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> > > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
> > > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);
> > > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);
> > 
> > Based on Sashiko's feedback, since we mostly care about cgroup_skb
> > should we just make it exclusive to them and drop CLS_ACT?
> 
> This would indeed simplify this patchset, I could drop most of the
> complication induced by tc ingress routing. But I think having both
> cgroup_skb and tc support would be nice as a first implem. I'll try
> again in a new version as I added a test for ingress tc and could
> actually fix the routing based on sashiko's feedback (this also drop the
> first two patches that were partially wrong).

tl;dr: I'll remove the tc support as it feels difficult (impossible
without major plumbing changes?) to get right.

Here are the details:

Initially I ended up removing the first two patch set as they were
technically wrong (see explanations after), I added this small helper:

	#if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
	static bool skb_dst_validate_and_hold(struct sk_buff *skb)
	{
	       bool ret;

	       rcu_read_lock();
	       ret = skb_valid_dst(skb) && skb_dst_force(skb);
	       rcu_read_unlock();

	       return ret;
	}
	#endif

And then the body of the kfunc would do something like this (instead of
calling the removed helpers):

	reason = pskb_network_may_pull_reason(nskb, sizeof(struct iphdr));
	if (reason) {
		kfree_skb_reason(nskb, reason);
		return -EBADMSG;
	}

	memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
	IPCB(nskb)->iif = nskb->skb_iif;

	if (!skb_dst_validate_and_hold(nskb)) {
		if (!nskb->dev) {
			kfree_skb(nskb);
			return -ENODEV;
		}

		iph = ip_hdr(nskb);
		reason = ip_route_input(nskb, iph->daddr, iph->saddr,
					ip4h_dscp(iph), nskb->dev);
		if (reason) {
			kfree_skb_reason(nskb, reason);
			return -EHOSTUNREACH;
		}
	}

	icmp_send(nskb, type, code, 0);

Then I added a tc ingress test to showcase the issue with the previous
helpers and trigger the routing in the kfunc, with this steup:

	  client ns:                    test ns:
	  icmp_peer                     ns_icmp_send_unreach_route_ingress
	+------------+                +-------------------------+
	| icmp_cli   |                | icmp_srv                |
	| 198.18.0.1 |--------------->| primary:   198.18.0.254 |
	+------------+ TCP SYN        | local dst: 198.18.0.2   |
		       dst=198.18.0.2 +-------------------------+
					  | tc ingress BPF
					  | calls bpf_icmp_send()
					  | -> icmp src=198.18.0.2
					  v

With the previous helpers, the icmp would route by reverting the daddr
immediately, and then asking for the route. Thus we would "forget" about
the actual source address, and in this case we would end up with the
icmp control message src IP being the primary address and not the one we
wanted: 198.18.9.2. Turns out route input was sufficient to give the
needed _correct_ information to icmp_send that would invert the address
for us and route the packet again.

Then I submitted that for more review by sashiko and it found this new
thing (which is orthogonal to the previous issue):

	> @@ -12639,6 +12788,9 @@ static int __init bpf_kfunc_init(void)
	>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
	>  					       &bpf_kfunc_set_sock_addr);
	>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
	> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
	> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);
	> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);

	Can exposing net/core/filter.c:bpf_icmp_send() to sched_cls and sched_act
	deadlock a non-lockless qdisc?

	A cls_bpf program can run from a qdisc enqueue classifier while the qdisc
	root lock is held.  If it calls bpf_icmp_send(), the kfunc synchronously
	goes through icmp_send()/icmpv6_send() and then normal transmit.  If the
	reply routes back through the same qdisc, the inner transmit can try to take
	the same root lock again.

	One possible path is:

	__dev_xmit_skb()
	  q->enqueue()
	  prio_enqueue()
	  tcf_classify()
	  cls_bpf_classify()
	  bpf_icmp_send()
	  icmp_send()/icmpv6_send()
	  dev_queue_xmit()
	  __dev_xmit_skb()

	Is this kfunc safe in enqueue classifier/action contexts, or should this
	registration be limited to contexts that cannot run under the qdisc root
	lock?

I managed to indeed reproduce this deadlock. So I think there's no way
to implement this safely, we would either need:
- make the kfunc only available to tcx only (and then prevent program
  verified as TCX from being reused as legacy qdisc classifiers...)
- do some crazy runtime guard, exposing the lock.

So I will give up on tc support for now as it's more difficult than
expected.

> 
> > >  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
> > >  }
> > >  late_initcall(bpf_kfunc_init);
> > > --
> > > 2.34.1
> > 

