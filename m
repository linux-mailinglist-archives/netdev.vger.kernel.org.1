Return-Path: <netdev+bounces-72013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C508562EB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD51B2D06E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C312C528;
	Thu, 15 Feb 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qcp3WdT6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473312C52E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999074; cv=none; b=QRHSkBhZlHr2oDQiAom/R6ZFfENU7Vh1KpNT9sC18fljCU2NfL2zP7tuNvphrgwAgv6TZg5l9Dsn3Pty5F8ZjijrzUvZJ5z0m5xyLGfVFdWeOz+GhOKgxSG4X9Oaw7OWssbFbeUM3AY3nh10rJH0C0dHSwnOk3WikGx/qT8qkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999074; c=relaxed/simple;
	bh=L3m1v7dm2KWKLtFqWNe3XL/Vkr0NCf8pS7Xhm41647o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTFJTASyu9XwGvJez62xUVEsk45MRGPPpgB0NIUpWfK22ymCgtrXRbgeujNEiVAtQj7CK0OHDScGPE3RWYL1vf/15x/2m7isnf4d8a/om7kAIxMWce+A/0SvkYxreYTQLJbPrfiVwF0+e3gIb9CLm0r0g+E1UKNX/nC69wR4iuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qcp3WdT6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707999071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9bwFQNaFcBiYz0Xnc/Zyrw1wJaON0pmUhTftxdM5l5k=;
	b=Qcp3WdT6zj1xkfvvsgZVdJGdzKkl5a8dctjYtGRKBnBnqvkxQ4AdZi0DwpesqzGHcE2Am0
	5i7bcZu2y2+oeXxXb9x8mVy5ptL4smgj/dlZVap0hUKXoFfcKhsf3juiu1vo8/Lbp4jizP
	pg2aj9+Lj8stZP5/spnF1OFb+717cBo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-ePqmaJzMMMGsfSWzRebskQ-1; Thu, 15 Feb 2024 07:11:10 -0500
X-MC-Unique: ePqmaJzMMMGsfSWzRebskQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55d71ec6ef3so524663a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707999069; x=1708603869;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bwFQNaFcBiYz0Xnc/Zyrw1wJaON0pmUhTftxdM5l5k=;
        b=OlieE5n6LpOgQRLJYlUEVFFopsrRsZu5/6Spv+jJrm3cV8SoJSDbhECYb7bG5TjZEk
         hfwlCMw6qjGrTRGAJq/0UhP3kUNtEk9gSJNej+///24Ca7kWs5pxGvoMRltNf2khPMEI
         lIYdX4h5g3UFEn9OJF3OmhjCNIrmRyLFAz8lyYYrAm/q5gxL7tmxNxFpJTjqFcfnCmSi
         UHybD7BxnwW1bogE7IMmz006i63vZlJtRCtRXw1+TIcI3eXnMQz1kFgZmSoR5tshZfTO
         3Wa1nsmcCf2xCvM0QOZH1liKrHZE/v1hf3p7ToAoUUtei7DMZ+FlGSphoUe5cQkiPOVT
         Vu1g==
X-Forwarded-Encrypted: i=1; AJvYcCWv3GUXmSpAwLBU+kc+E7QS5BxR4Rbo1+8Ut/eX1t/cidafeWyVLK/r9A1mIh0xW6Ye4F0CCFZT08+x15G1SPD3FuRWTdyR
X-Gm-Message-State: AOJu0YzkhHAqn3hNHLimpL/bNyAD1kW0ZotrhJnIDvxviIHKifAEnGv/
	RW6VWHS0Jb8qoKDiI73COAvXg6LJCX/JsltjSJ7dk2e/xMAe9NPn5QDB1fbR8ldQkdQTDg6XFcC
	05FxPa6XVu9khO1yZCiggVu6ehmEzdpupmGpsh7xr0yteNRFWSYmhmw==
X-Received: by 2002:aa7:d8d2:0:b0:563:8df4:1b19 with SMTP id k18-20020aa7d8d2000000b005638df41b19mr1247832eds.22.1707999068931;
        Thu, 15 Feb 2024 04:11:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa+wpQFm8gKml7wpXhzm1nTwdQeDKKKzBP6IxI/rAxz8aMa9kpeOrOY9BTBiktE3oinSRRNA==
X-Received: by 2002:aa7:d8d2:0:b0:563:8df4:1b19 with SMTP id k18-20020aa7d8d2000000b005638df41b19mr1247814eds.22.1707999068528;
        Thu, 15 Feb 2024 04:11:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h32-20020a0564020ea000b00561e675a3casm473017eda.68.2024.02.15.04.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:11:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9D41210F59A2; Thu, 15 Feb 2024 13:11:07 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, =?utf-8?B?QmrDtnJuIFQ=?=
 =?utf-8?B?w7ZwZWw=?=
 <bjorn@kernel.org>, "David S. Miller" <davem@davemloft.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Hao
 Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240215090428.3OW_j0S8@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de> <87il2rdnxs.fsf@toke.dk>
 <20240215090428.3OW_j0S8@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 13:11:07 +0100
Message-ID: <87sf1uc4h0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-02-14 17:13:03 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index de362d5f26559..c3f7d2a6b6134 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -4044,12 +4048,16 @@ static __always_inline struct sk_buff *
>> >  sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *d=
ev)
>> >  {
>> >  	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egress=
);
>> > +	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
>> >  	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_EGRESS;
>> > +	struct bpf_xdp_storage __xdp_store;
>> >  	int sch_ret;
>> >=20=20
>> >  	if (!entry)
>> >  		return skb;
>> >=20=20
>> > +	xdp_store =3D xdp_storage_set(&__xdp_store);
>> > +
>> >  	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
>> >  	 * already set by the caller.
>> >  	 */
>>=20
>>=20
>> These, and the LWT code, don't actually have anything to do with XDP,
>> which indicates that the 'xdp_storage' name misleading. Maybe
>> 'bpf_net_context' or something along those lines? Or maybe we could just
>> move the flush lists into bpf_redirect_info itself and just keep that as
>> the top-level name?
>
> I'm going to rename it for now as suggested for now. If it is a better
> fit to include the lists into bpf_redirect_info then I will update
> accordingly.

OK, SGTM.

-Toke


