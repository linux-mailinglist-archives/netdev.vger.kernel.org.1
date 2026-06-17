Return-Path: <netdev+bounces-300094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F5ByNvBoMmpPzgUAu9opvQ
	(envelope-from <netdev+bounces-300094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 362BA697E9E
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:29:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="ZUcA/QOt";
	dkim=pass header.d=redhat.com header.s=google header.b=NwkSDYdE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300094-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB8930075E3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996A3947AE;
	Wed, 17 Jun 2026 09:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BF3A0E81
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:26:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688388; cv=none; b=Pg4dHZ3OnwvVyhaTGe6KzYo7A9R1moIUoz5emgRVCULCtHPo/uUb6oqrME0mgcT/B7WbglFXQA1X+8CWtERqDsXqPYCRHZoV82TcPs6mh0xZLh1m6ETttKoxIFC+bphtXnMpBiIS/ArHLMYc1OQnKdVaAJEw6ihDPbITYp5LOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688388; c=relaxed/simple;
	bh=s46IKH9C0KjfMj/YsGGN+zt62qBG1iCiNkueSfsY0H4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3BOy3exp7FrN7zYk9dz5ypSAf/afFz+EhgpUE7RNtfpsw4lvhQkbJMmEJd2FVPfTMh/30RDaEbUv542aL00nOqDAhcycTzl2nWqGCdS0oTF0Wh1dI1OQfxNcY8OtXw1QZhPpiLfWV7eD+H7OzmYt9q+YfgiMzYU0j0lFgmieIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUcA/QOt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwkSDYdE; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781688385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMj5B6MTpxWxEzSSjWsEODq1pCHEKl35Ibvz3lZhyLw=;
	b=ZUcA/QOthgylBCtumC2GHKtXfkrp0Bq8RHnevrQqtuaEZOCRNDbH45DAmhlUGjjgZh/j3m
	x1/8MGs6YdBg0FKpurFrAAXgGbC3I8FQ1hLtrWgu2msUgI6nDmoEHVBVI27c07PhkG9A4u
	d+OEMKA+PtppcKxjWj8mLF5sBJjiU2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-UweqD9hiNOaGyNNEhG5j5Q-1; Wed, 17 Jun 2026 05:26:24 -0400
X-MC-Unique: UweqD9hiNOaGyNNEhG5j5Q-1
X-Mimecast-MFC-AGG-ID: UweqD9hiNOaGyNNEhG5j5Q_1781688383
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490d3f03883so46182075e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781688383; x=1782293183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMj5B6MTpxWxEzSSjWsEODq1pCHEKl35Ibvz3lZhyLw=;
        b=NwkSDYdEMY4EiNCHkRbJE9gcnujqY+rlINR///nMmUNJxhswGCObI9BtbSZq77Z+wx
         H8t2xrT3YEpCbesR2zRrxNOrEkb10jeqqaziQNvITUG+AJVtq9f++I4eAxWmk+I8n0Uw
         NPYNRPsAigNSDm44vCXbJbggNtLRNrYcP3rFgnltSOpZFs0Yj6MgiTwMs7NC5hMc8jO6
         zyUecBfG+U9GQWzCRopS1K62Z3dMVgElvjgoBYpR6u2HZpVa7OmHPGtNVn8SfiRjmFQX
         kvfrP6poYKLLoOnMYfxrpFOi+F+Z9mx3M9taARhAgTWmO0eoMooMbEdDEzEJ9wJarPFd
         TqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688383; x=1782293183;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMj5B6MTpxWxEzSSjWsEODq1pCHEKl35Ibvz3lZhyLw=;
        b=gbxpHEfEVt4m3fVn5bD4kY5z0spEBRPp7RXYKfG0L/qze35CVDBHhx9dpORdnmQXz+
         z0cb8d9XqXhiwClCvNh67A5QH/2qjrA/y4bNk4p76FU1yjvzHsL3SCSF/gURungu5r+h
         3xlbPGmqX19fOWjcd6FwwOndrPJPpyaa/AT4/Jd1UtU6SNvMQDdmVpG0w8ibCRIM66yi
         BVFnC81+EKnAGjB6Tygk/ICm4v3thaPXQjc89VOav4tgS39MkU756Cb77CXDeqWsbcGk
         RZsuwVQ/6ROb0Vm6aPapKqEDIYqqF7wApbIYFMhhS3voRilHQ4PtuzQxDn5p+A0tztnl
         EYnw==
X-Forwarded-Encrypted: i=1; AFNElJ9K89hiB8M6/LgZZSQ6yHy3TH0X0pIP3MPygixKzi1HKOsYn3mLgN4MfbIwRRWgdV2Blw0qBOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2LQYIBp3yIzuPEpkD3RKlnSs4ueQAadKFSsFJPCbKXELz67z
	4XSCr7qZ2YKI5LOH7fj+I+C9tABROu+/jtQ6SZsmTw/63QRJgMrQuW4Da3EB5mCVAFYSun70l4T
	bNN3OpK46Zaz7PFgTp8KDbF07Y/Mo9G9Oa52bCLdBNw1BKsO6ziJy9AHlog==
X-Gm-Gg: Acq92OGH9YGN3NoOqhCdWy5fblQ9MJ/dG9UGPrjJOCJNuvG8RIYrva5ojIfTKRcfTxS
	7scZeKCtPsczC/5YVTjYWfoOV2tI78YIe9BHWi3bHolAuYzM2ntbE3jZ3p1MdPra9xTq0RZK0ZC
	cv8gotBs8LZzRkcCqQvMTcAN5nc9EGppvTOji+em2dtFiV2AcO7sdcWKDdoKjJdqW96ww63iHWY
	H2/BIDnzravs+OhS8UZZSTpYaqA8G8rPmJ4SPyMA8ykDIBmgDemguugFIJn3U12VqNGfA52pWpv
	W7FcjoB8DAiqBqDT/CgnY1ng8Lz9WMcl0Qe2QUlYqc+0aH3AKlbbtpUKIbk/eJnzDeqPzK7cVYw
	nGz/ftVR1+lmEXsGjUAGHcI7wlQ9c297tfRQ=
X-Received: by 2002:a05:600c:818f:b0:490:daca:5019 with SMTP id 5b1f17b1804b1-492333ba222mr52032295e9.6.1781688382909;
        Wed, 17 Jun 2026 02:26:22 -0700 (PDT)
X-Received: by 2002:a05:600c:818f:b0:490:daca:5019 with SMTP id 5b1f17b1804b1-492333ba222mr52031525e9.6.1781688382286;
        Wed, 17 Jun 2026 02:26:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm128331425e9.9.2026.06.17.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:26:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 04B888074BF; Wed, 17 Jun 2026 11:26:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Mykyta
 Yatsenko <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, Amery
 Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>, Rong Tao
 <rongtao@cestc.cn>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260616223426.3568080-3-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
 <20260616223426.3568080-3-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jun 2026 11:26:20 +0200
Message-ID: <878q8dh60z.fsf@toke.dk>
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
	TAGGED_FROM(0.00)[bounces-300094-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,toke.dk:mid];
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
X-Rspamd-Queue-Id: 362BA697E9E

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
> and not vlan_dev_real_dev(), which walks to the bottom of a stack. For a
> stacked VLAN (QinQ) the immediate parent is itself a VLAN device; since
> one h_vlan_proto/h_vlan_TCI pair cannot describe two tags, ifindex is
> left unchanged and the vlan fields remain zero in that case. The swap
> is also skipped when the parent lives in another network namespace (a
> VLAN device can be moved while its parent stays), since its ifindex
> would be meaningless or match an unrelated device in the caller's
> namespace. The swap and the vlan fields are written only on success;
> other output fields keep their existing behaviour, so a frag-needed
> result still reports the route mtu in params->mtu_result. When the
> flag is not set, behaviour is unchanged: h_vlan_proto and h_vlan_TCI
> are zeroed and ifindex is left at the FIB result.
>
> The new block is compiled only under CONFIG_VLAN_8021Q since
> vlan_dev_priv() is not defined otherwise; without that config
> is_vlan_dev() is constant false and the flag is accepted but never
> acts.
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
> ---
>  include/uapi/linux/bpf.h       | 31 ++++++++++++++++++++++++++-
>  net/core/filter.c              | 39 ++++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h | 31 ++++++++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 11dd610fa5fa..f77aa9472bf1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3527,6 +3527,31 @@ union bpf_attr {
>   *			Use the mark present in *params*->mark for the fib lookup.
>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>   *			as it only has meaning for full lookups.
> + *		**BPF_FIB_LOOKUP_VLAN**
> + *			If the fib lookup resolves to a VLAN device whose
> + *			parent is a real (non-VLAN) device, set
> + *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
> + *			the VLAN device and replace *params*->ifindex with the
> + *			parent's ifindex. This lets XDP programs that target
> + *			the underlying physical device (VLAN devices have no
> + *			XDP xmit) discover both the real egress ifindex and
> + *			the VLAN tag to push in one call. *params*->h_vlan_TCI
> + *			carries the VID only, with PCP and DEI bits zero; a
> + *			consumer wanting to set egress priority writes PCP
> + *			itself. *params*->smac is the VLAN device's own
> + *			address, which can differ from the parent's. Only the
> + *			immediate parent is resolved: for a stacked VLAN (QinQ)
> + *			the parent is itself a VLAN device, and since one tag
> + *			pair cannot describe two tags, *params*->ifindex is
> + *			left unchanged and the vlan fields remain zero. The
> + *			same applies when the parent is in another network
> + *			namespace, where its ifindex would be meaningless.
> + *			The swap and the vlan fields are written only on
> + *			success; other output fields keep the helper's
> + *			existing behaviour, so a frag-needed result still
> + *			reports the route mtu in *params*->mtu_result, and on
> + *			the tc path without tot_len the mtu check runs after
> + *			the swap, against the parent device.

This comment is quite long, please trim. At the very least drop:

"This lets XDP programs that target the underlying physical device (VLAN
devices have no XDP xmit) discover both the real egress ifindex and the
VLAN tag to push in one call."

and shorten:

"Only the immediate parent is resolved: for a stacked VLAN
(QinQ) the parent is itself a VLAN device, and since one tag pair cannot
describe two tags, *params*->ifindex is left unchanged and the vlan
fields remain zero. The same applies when the parent is in another
network namespace, where its ifindex would be meaningless."

to:

"The lookup only resolves the immediate parent (QinQ is not supported),
and fails if the parent is in a different namespace."

>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7322,6 +7347,7 @@ enum {
>  	BPF_FIB_LOOKUP_TBID    =3D (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
> +	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
>  };
>=20=20
>  enum {
> @@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
>=20=20
>  	union {
>  		struct {
> -			/* output */
> +			/* output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 6fa172cb1348..b37a12321fba 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6119,10 +6119,40 @@ static const struct bpf_func_proto bpf_skb_get_xf=
rm_state_proto =3D {
>  #endif
>=20=20
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> -static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
> +static int bpf_fib_set_fwd_params(struct net_device *dev,
> +				  struct bpf_fib_lookup *params,
> +				  u32 flags, u32 mtu)
>  {
>  	params->h_vlan_TCI =3D 0;
>  	params->h_vlan_proto =3D 0;
> +
> +#if IS_ENABLED(CONFIG_VLAN_8021Q)
> +	/* vlan_dev_priv() is only defined when 8021q is built in or as a
> +	 * module; under !CONFIG_VLAN_8021Q is_vlan_dev() is constant false
> +	 * so this would be dead, but it still has to compile.
> +	 */

Superfluous comment - please drop.

> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
> +		struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> +
> +		/* Resolve the immediate parent only. For a stacked VLAN
> +		 * (QinQ) the parent is itself a VLAN device, and a single
> +		 * h_vlan_proto/h_vlan_TCI pair cannot describe both tags;
> +		 * leave ifindex and the vlan fields untouched in that case
> +		 * rather than report the lower device with only one tag.
> +		 * The same applies when the parent lives in another netns
> +		 * (a VLAN device can be moved while its parent stays):
> +		 * its ifindex would be meaningless, or match an unrelated
> +		 * device, in the caller's namespace.
> +		 */

And this one - it's redundant with the flag description (and commit message=
).

-Toke


