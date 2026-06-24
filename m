Return-Path: <netdev+bounces-301593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AqT4CNSlO2o0awgAu9opvQ
	(envelope-from <netdev+bounces-301593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:39:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC286BD00F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:39:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IB3Ezxp4;
	dkim=pass header.d=redhat.com header.s=google header.b=AzhYsAwN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301593-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301593-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B32E310BC63
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE5F2F7EE3;
	Wed, 24 Jun 2026 09:33:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DE3B8959
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:33:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293600; cv=none; b=RLfZuT93jfdrU5AFOQ31jecUApnBIAU2tde3pT6/aa4q1XZqMy2QqfK1/HPRgs5DufCzN/qF7SdRludagYU4/HwtFv8UUQ4FHuW4D8I2AzGOiQnFeEQ01mI2DCU8KWC2qA5Q7EqaVCBUdspaNoSSCsK9+14cVue5WieGwtKN/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293600; c=relaxed/simple;
	bh=zVTzcAhu2sh1noRCqYQ5+3ri+BgXa4QWy0Rkq9VVdAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3jpbH2cS9dz56Dazmsb5an/p2VEilUHLmPQaax7fykX7cYZKeF08uvuZCUljHqWVB3CBKzqQnJx+rEr/HXAyRmdar7id6BT6IDSqDzNd1UyyBP7RH2lcjPAAzTEjx2jjQSRzOWrO5XKsWN/+PmrO4CV5DGUwLjYtdpC3zXz7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB3Ezxp4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzhYsAwN; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782293589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oScmgVBAZdYqdklOiG9pSCq/MuJ7qIw0aEjZWIJM3Ks=;
	b=IB3Ezxp497OV0SOxfh+33MwswDQoRgitVx0RixvPp4nPgmb2azyAlBJhSifhUQeqWFcSvH
	2W5swbAMlIWzGnLhRVepYGeFreGZQQI6norbZ7parII3aInv24PykbcXSkxt019Na/z0vW
	rr8LRWf/f03ElcNcb+IZ48581/wZYVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-8-2KBdOuM6mbNL5rdqn57Q-1; Wed, 24 Jun 2026 05:33:08 -0400
X-MC-Unique: 8-2KBdOuM6mbNL5rdqn57Q-1
X-Mimecast-MFC-AGG-ID: 8-2KBdOuM6mbNL5rdqn57Q_1782293587
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef616db45so667142f8f.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782293587; x=1782898387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oScmgVBAZdYqdklOiG9pSCq/MuJ7qIw0aEjZWIJM3Ks=;
        b=AzhYsAwNr4C/fkY66dsoT2NUSL7zKlX9cXwHIWgOsiaBQPNybQ6R5nUSVR3LRk7vQa
         haW8mhIYq4ZBMR3voaLUosC1g3+LZ/NUd3RIsKEzexF0YeOvgsjr8t75DQFxpUflhHk0
         6XdqHGbu0BlgzY2+lFOJ4RE1GA/fz2jQNmxyPYUzVAegOemrytq0y+4R/Z6diV3+WRPc
         qFCIGv7k9G6OqLo0cjX/Fhaq/iXpemM4V8dQibKyH3QT8HBBCVFJb80uVAQVGn3rlBKi
         h5ab7TURLmAc2fYp0bC4l9KMDynhHVLaX5MbgWt2wUNbVH7hru35pe3uW70r8d3myQqV
         AT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293587; x=1782898387;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oScmgVBAZdYqdklOiG9pSCq/MuJ7qIw0aEjZWIJM3Ks=;
        b=UmidTvLinAioYM6hyRo2feXzqpgblVzdbISnrvYA+6ve1/ogF8e2hbe8Wdx9dEsbqC
         5SvQv+e3XSabHZMwb6bDyGP63SCmE/xidIBJIcyOjmOk+1iuWyus6AmE7jtdHqp0sRMh
         g9ktYygBB8fhOSYJXmLRwkLwwd600OjMgBmXPtm6Hvj5pVY4CFD5uyeuR7IERqSgrv46
         VrvCctl1J9VF2iplacMEaveSTP/RiY3GFeTIMU0TnEBttie76lNeZRsB0EHiSphwnJYZ
         Tk88+Q+oaPBdrtQdHYdioSAJQKZTu7Cc/dGOcdXsHeOlLmmIFrB5yJdo5h9dd1XjMFYL
         wUxg==
X-Forwarded-Encrypted: i=1; AFNElJ9LBk5P5sRL5FJDeFYB0fNt/KkeC2b+OKs0eLWEQEuVoFHVb5uP5KS/W5d9EP54qLtL5apAun8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW02YPqEFRg2B/2cIR2MqhZzEDo/Gqlgk2JlrftrvNWujRFaXL
	niLxxWHvxHj/EqAQ5/hEBAr2TpjRo4msFUQHrUr6MsiKXn0f8jOdT14feMZ4gFCzXBcSbCjDnHT
	NQKHMfMZIQMoYIOkFfjhdLZxrOdQqXBd9ccHVDsYQbbxBMLm0PPXN2hEPrA==
X-Gm-Gg: AfdE7cnneE2x0/rt5plzOqUKWwdslYIRjSQ74w/Omrc34/0Pqhsk+l7J5qe28q3vg69
	P4Z+q2uGgWSa8NSHi5K8Sfz/p7aTvTNxeVeIZ9QDd0mbTbk7OXNBDBw0odxM8e+YtIEjgjT4vQt
	c1af5TLYLSuyZYKigv8zBkNJgnSYWBjCqGdubPI5AlBcfu7OWSy4PHvGnOsvfA1uP5mk9ZM5rst
	vw49sKbV/BWHKV3W+QsbiPWKy8NIrbCnd+V15KGQSdgqnYOaak9OWx+xXAvrzwzHqQtmObNwzdT
	5sRBu33WI8K+Ka2MidhejrnkQ7nMHS/5DspeGTxwQaJO6POXvXdrtwP8wvfKro0RYWUShuKlPz+
	9fEArsjMQJJEVpv9ibb7go+soptdm0B6O/fc=
X-Received: by 2002:a05:600c:a012:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49260875bbamr34892555e9.31.1782293586941;
        Wed, 24 Jun 2026 02:33:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49260875bbamr34892125e9.31.1782293586482;
        Wed, 24 Jun 2026 02:33:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49261063d6esm26451795e9.2.2026.06.24.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:33:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 42FAF808FBD; Wed, 24 Jun 2026 11:33:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260624030530.3342884-2-avinash.duduskar@gmail.com>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 24 Jun 2026 11:33:04 +0200
Message-ID: <87pl1gcmgf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301593-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dsahern@kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,toke.dk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBC286BD00F

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
> from the fib result. When the egress is a VLAN device, the returned
> ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
> programs that want to forward the frame (e.g. xdp-forward) must
> instead target the underlying physical device and push the VLAN tag
> themselves. Today the program has no way to learn either the
> underlying ifindex or the VLAN tag without maintaining its own
> VLAN-to-ifindex map in userspace and refreshing it on netlink
> events.
>
> Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
> result is a VLAN device whose immediate parent is a real (non-VLAN)
> device in the same network namespace, populate the existing output
> fields params->h_vlan_proto and params->h_vlan_TCI from the VLAN
> device and replace params->ifindex with the parent's ifindex.
> params->h_vlan_TCI carries the VID only, with PCP and DEI bits zero; a
> consumer wanting to set egress priority writes PCP itself.
> params->smac is the VLAN device's own address, which can differ from
> the parent's.
>
> Only the immediate parent is resolved, via vlan_dev_priv(dev)->real_dev
> and not vlan_dev_real_dev(), which walks to the bottom of a stack. When
> the immediate parent is not a real device in the same namespace, the
> lookup returns BPF_FIB_LKUP_RET_VLAN_FAILURE and leaves params->ifindex
> at the input. This covers a stacked VLAN (QinQ), where the immediate
> parent is itself a VLAN device and one h_vlan_proto/h_vlan_TCI pair
> cannot describe two tags, and a parent in another network namespace (a
> VLAN device can be moved while its parent stays), whose ifindex would
> be meaningless in the caller's namespace. A program that wants the VLAN
> device's own ifindex re-issues the lookup without BPF_FIB_LOOKUP_VLAN,
> so the unreducible case stays distinct from a physical egress. That
> distinction matters for XDP: a program cannot xmit on a VLAN device, so
> a success carrying the VLAN ifindex would make it redirect to a device
> with no ndo_xdp_xmit and drop the frame at xdp_do_flush(). The swap and
> the vlan fields are written only on the reduce path; other output
> fields keep their existing behaviour, so a frag-needed result still
> reports the route mtu in params->mtu_result.
>
> BPF_FIB_LOOKUP_VLAN is only useful to XDP, which cannot redirect to a
> VLAN device. A tc program can redirect to the VLAN device directly, so
> bpf_skb_fib_lookup() rejects the flag with -EINVAL; bpf_xdp_fib_lookup()
> accepts it. When the flag is not set, behaviour is unchanged:
> h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the FIB
> result.
>
> The new block is compiled only under CONFIG_VLAN_8021Q since
> vlan_dev_priv() is not defined otherwise; without that config
> is_vlan_dev() is constant false and the flag is accepted but never
> acts. That is safe because no VLAN device can exist there, so every
> egress is already physical.
>
> This lets an XDP redirect target the physical device and learn the
> tag to push in a single lookup, which xdp-forward's optional VLAN
> mode (xdp-project/xdp-tools#504) wants from the kernel side.
>
> The helper's input semantics are unchanged; the reverse direction
> (supplying a tag as lookup input) is added in the following patch.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Yes, this is way nicer - thanks! One nit below, otherwise LGTM:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[..]

> +	if (flags & BPF_FIB_LOOKUP_VLAN)
> +		return -EINVAL;
> +

This is fine, but we should probably reject the input flag as well in
the next patch (for symmetry).

-Toke


