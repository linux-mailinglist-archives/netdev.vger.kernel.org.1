Return-Path: <netdev+bounces-302046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ET4aBR1cPWpR1wgAu9opvQ
	(envelope-from <netdev+bounces-302046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:49:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88C6C78DD
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GLC0HV0b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302046-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302046-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0612301B939
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1036492C;
	Thu, 25 Jun 2026 16:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53B3B47E6
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:49:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406149; cv=none; b=Yxp9ucK4eJc5f1vj/j+TQJwMKn3UjlBwlCMgjB/SsP7fff2QrXr1cyJXvVnnY3rSA6ivW5x1xiWibZj1H7pnONxjhBSUJsO4CphTSlQw1LzY4mmcWC750pV1ExH58Cfp9uSPAJVm0TNHQ4+v+tdOhETM8mJDwXdbp6sB8yj3hSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406149; c=relaxed/simple;
	bh=dyMR9SXh8cqYMnjrQ4eOds7TKTpvnKMwfk3jRymNJ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox5ORL+FeFGKs5c6CdlOhvtQ9x3PMh+94AmL5/djxin+rHcw30FkccAFi6Wf0daCHkBlQcVijac6a7qt72PAtVhqxBNaESLoz4PYU6EU02Oa4svUiMW1ZSBwDO+TJ/ra5wTwYDwuzIyQQlqX6Uzl1j/aP0g1HBnMENrRK1YwVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLC0HV0b; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1694243f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406146; x=1783010946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tO5LmLOW4bHmMm0NAxA5lcAnMw8WVq7U30lmG+IEp00=;
        b=GLC0HV0bgCuwFgdvSJOAHTdqvHtrp1mXQVUMtR/d9Q+8MZgqs017LVQCx23JPhFKrK
         ATFwnW+yzT7sl7jcsI7HnN+GVux7GhMCHwt5L0eo8dQiWzU7TIRiPwVg8Agoyn0si6jx
         n5wTo22Saxgox2zBs/brZn1LTIo/o9dkYVIaMGPhwMAi8C7zBrd8c7bmBV229v3ZfSQr
         M+Rs/lt0PF/hTxTI4foRGdJbvn1KF06lYtMrIJQUzsjAg0PioscBAAPHCZpiqvtrsKUw
         /nKKfFNNd1JHWcy07T+wUvQiyt4S/K/E8PNby8L/AIEetXbJlENo9pQS5uifxx4Oi097
         B0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406146; x=1783010946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO5LmLOW4bHmMm0NAxA5lcAnMw8WVq7U30lmG+IEp00=;
        b=O6m3Q/NRqEtXbarpakUZdJvc1NgH15GRrOD9YKhAZBwv4FkfKZ4Qr34m+d0xwrxKYv
         Lraycx0mY/PLDayIcNAitD6r64W4kXJiXTf7IDQDmwREdVDeWgwasf/Z7JcMEj0gNkjm
         gaGSIDF+kxdW4tzHxo/GaW8ZP4VO07xpDU2RG9vyUPOzRgVeq3u0BxA6sWAOw/Yk7UxQ
         2o5HuFhqfgTVKEv7PaXDnSK4BtFoMZ8A81vP9ukVXIEluyahdt+NOK6DqXvkLocs+hrH
         MRHmK7AMgcv6n76io+4vT1rgjRIVBwW2orkVyLV7WER+jq55wDfykdGSNygQHmE7giFc
         S4iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3BFlcVh/FXeGAMdEomuZPBFv4ATTVqOjNeo92f8k3BGs4J730qGO0I3VDTFAOGp5yB692Egg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFlvYWGOzhW5c3FxvUHUH5E4DW9/45d9DQIqwfvvLQRfEz+/4
	WW12xkcN5q9/z4E5GjR0MI1TCXu1Y92MXtgPz/XPzzFN8lEpqXaPGBR5
X-Gm-Gg: AfdE7ckcFyseJqYdO8IHoKKDQTe8yAmsanHsWn+NoufM4FLZ/RAJ5YsG1ItP6Yd5KbZ
	OOAsyipv0UfAZbKV4tZNkKWweDnCp5gsAS/y2KMm2nYJeR1xq+f3/Z1JNm30uWgXescIcqAqQrL
	4rc9OkPY8kCtEngvuRHOODFDscnKEYmfNZW4HgTvM0F3cf99tKRWc8DmnqKbA3M2K8I5hOzxe0Y
	pIDnYkQNzf/jP9m/LFyRfj4URJMfm/OZwDeIxVH6/0lAcYoe+Uo5T8IW3iDZ/UCF1qtJzSgg0zg
	TybcgjmQi0OcCnKj+c06d7g5CRSrdHElGU3MFKk3nD1Azm/Ind8G063h600e0KYnHwNLCyM02sN
	10pWVBpcgdD+spldMJkmV/oEe2aZzMPs5KwlbJ2wBRKh9D5vYKp3l5frJC6JvIDwkt6Ye0663AQ
	ErxXmyADo7tLxKH3/OTyl3FQ4hr/u7jY09K2N8wb/BX/Pj
X-Received: by 2002:a05:6000:400b:b0:45e:d6b2:e6a5 with SMTP id ffacd0b85a97d-46dc15c3c69mr5544430f8f.34.1782406145896;
        Thu, 25 Jun 2026 09:49:05 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee018e8sm19245455f8f.11.2026.06.25.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:49:05 -0700 (PDT)
Date: Thu, 25 Jun 2026 18:49:03 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io,
	martin.lau@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, horms@kernel.org
Subject: Re: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <aj1b_z6h5xn42Hxe@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
 <20260625110321.28236-2-mahe.tardy@gmail.com>
 <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E88C6C78DD

On Thu, Jun 25, 2026 at 09:24:59AM -0700, Stanislav Fomichev wrote:
> On 06/25, Mahe Tardy wrote:

[...]

> > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > +	struct sk_buff *nskb;
> > +	struct sock *sk;
> > +
> > +	sk = skb_to_full_sk(skb);
> > +	if (sk && sk->sk_kern_sock &&
> > +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> > +		return -EBUSY;
> > +
> > +	switch (skb->protocol) {
> > +#if IS_ENABLED(CONFIG_INET)
> > +	case htons(ETH_P_IP): {
> > +		if (type != ICMP_DEST_UNREACH)
> > +			return -EOPNOTSUPP;
> > +		if (code < 0 || code > NR_ICMP_UNREACH ||
> > +		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> > +			return -EINVAL;
> > +
> > +		/* icmp_send expects skb_dst to be a real rtable. */
> > +		if (!skb_valid_dst(skb))
> > +			return -ENETUNREACH;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
> > +		icmp_send(nskb, type, code, 0);
> > +		consume_skb(nskb);
> > +		break;
> > +	}
> > +#endif
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	case htons(ETH_P_IPV6):
> > +		if (type != ICMPV6_DEST_UNREACH)
> > +			return -EOPNOTSUPP;
> > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > +			return -EINVAL;
> 
> [..]
> 
> > +		/* icmpv6_send may treat skb_dst as rt6_info. */
> > +		if (skb_metadata_dst(skb))
> > +			return -ENETUNREACH;
> 
> A bit confused about this. Which part of icmpv6_send treats skb_dst as rt6_info?
> (I see the original sashiko report about dst, but icmp6 seems to be not
> requiring it)

Yeah I was also a bit confused because this came out of nowhere as soon
as I put the skb_valid_dst only on the IPv4 path (for different
reasons), but there is actually a potential trace in which we have type
confusion indeed:

- icmp6_send() checks scoped source addresses and calls icmp6_iif() at net/ipv6/icmp.c:702
- icmp6_iif() calls icmp6_dev() at net/ipv6/icmp.c:441
- icmp6_dev() does skb_rt6_info(skb) for loopback/L3 master devices at net/ipv6/icmp.c:428
- skb_rt6_info() casts any non-NULL dst to struct rt6_info at include/net/ip6_route.h:233
- rt6->rt6i_idev is then dereferenced at net/ipv6/icmp.c:434

When checking with pahole, we can find this on my local kernel:

struct rt6_info {
	struct dst_entry           dst;                  /*     0   136 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	struct fib6_info *         from;                 /*   136     8 */
	int                        sernum;               /*   144     4 */
	struct rt6key              rt6i_dst;             /*   148    20 */
	struct rt6key              rt6i_src;             /*   168    20 */
	struct in6_addr            rt6i_gateway;         /*   188    16 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 3 boundary (192 bytes) was 16 bytes ago --- */
	struct inet6_dev *         rt6i_idev;            /*   208     8 */  <--- we dereference this
	u32                        rt6i_flags;           /*   216     4 */
	short unsigned int         rt6i_nfheader_len;    /*   220     2 */

	/* size: 224, cachelines: 4, members: 9 */
	/* sum members: 218, holes: 1, sum holes: 4 */
	/* padding: 2 */
	/* last cacheline: 32 bytes */
};

And the metadata_dst would look like this:

struct metadata_dst {
	struct dst_entry           dst;                  /*     0   136 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	enum metadata_type         type;                 /*   136     4 */

	/* XXX 4 bytes hole, try to pack */

	union {
		struct ip_tunnel_info tun_info;          /*   144    96 */
		struct hw_port_info port_info;           /*   144    16 */
		struct macsec_info macsec_info;          /*   144     8 */
		struct xfrm_md_info xfrm_info;           /*   144    16 */
	} u;                                             /*   144    96 */  <--- we land on this union

	/* size: 240, cachelines: 4, members: 3 */
	/* sum members: 236, holes: 1, sum holes: 4 */
	/* last cacheline: 48 bytes */
};

Let's say it's a struct ip_tunnel_info:

struct ip_tunnel_info {
	struct ip_tunnel_key       key;                  /*     0    64 */

	/* XXX last struct has 7 bytes of padding */

	/* --- cacheline 1 boundary (64 bytes) --- */
	struct ip_tunnel_encap     encap;                /*    64     8 */  <--- 144 + 64 = 208 we land here
	struct dst_cache           dst_cache;            /*    72    16 */
	u8                         options_len;          /*    88     1 */
	u8                         mode;                 /*    89     1 */

	/* size: 96, cachelines: 2, members: 5 */
	/* padding: 6 */
	/* paddings: 1, sum paddings: 7 */
	/* last cacheline: 32 bytes */
};

So I imagine this is fairly tricky to trigger but still a case of type
confusion. I have actually no idea how likely this can happen from my
call but the trace makes sense at least.

