Return-Path: <netdev+bounces-73301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC585BCEA
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA1B1F2427D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A342B6A00B;
	Tue, 20 Feb 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djPvcnSl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4A5A7A8
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434848; cv=none; b=ANTSN7ryrvPZOEHtGoMa3S6F6hMPsTpFBiH+g+zZCyqQMkdzk9pP680e78xDL/ED2at4jWs1V0fXP491WnjmGHKyNi39IngJpEwjVRmAhjxnxN7Yr+oY6uRurLjrJfV0btUYazcZw72uMiLaZLl5/QywvygkePmOAPHL25tDOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434848; c=relaxed/simple;
	bh=9P+qGZ09vKP1bVu9xDA/zAFHdQr1RJe/fY/2APMl9sI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kb8UG2yy7kOgkJgF8pQUqeDYq+HmKlqbQQHO3iFlJzqfABOapXuBMSZXuFQddo+8omkBJnWXEC38s+uJoeA8mdpQqXra7hZgv3ss2FJIPuaUaFvcMs5Z1T01l+nf49kjqt7+SrtKjK5c5YAatEiY4nihLCbfuJwGc1uLFN6PBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djPvcnSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708434845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpefqOp0oZS0+OYDrex40+aBinTmwsqS3fR+A5/fHEk=;
	b=djPvcnSl77Z5CHjIavLO0frOklYYLtJgfX8kV2MJUtvXhr/E+f0JzKxxw1OIT6xH9fyCCk
	ShCtCWcPmhVPDJRuL/HL06KlEBI69LLf2UeMAOhaHTi6vKB8ainGmB1GVGJjsZZOQ/Uw8Z
	w5wY7KR8EESjZeYdZcuygYJjWCd8JLM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-5hkP352eMh2_IvOmDQpa8A-1; Tue, 20 Feb 2024 08:14:04 -0500
X-MC-Unique: 5hkP352eMh2_IvOmDQpa8A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-512bad7d985so1880481e87.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 05:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708434843; x=1709039643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpefqOp0oZS0+OYDrex40+aBinTmwsqS3fR+A5/fHEk=;
        b=fCurRe9+mprQLCm029tGIMR2XXB/hqZzhUZBTwCa9pxZlQ7bazALtQ7bA0OqLGo0XW
         w3SmYgPiDBP8p80e/jCdgkcWfdHMpYMRK6TDNhDioABAryqQO5nhIdKXqI1XVr+oE8o3
         lmfQGHDzkaBFK4kO2kId2TpJoCoxzRxOtmxpkt/rEk7kFNBXRQ4uh63O1zavLxU5Syy8
         /gxSxiceLaMLj+vFUpIPHqb0SzrXiy2XytFVwf49yn6U87EcgE+lzbI9EPTnHgP97V8C
         ZfsvniIQ/AKUEh1ClGLy7X5YXACL71otVRJ/AmEmIUvTWHn+k4qb+zjlAzBkKh3cLhze
         O/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUFQ8IoPizrRLkVxcfC0ZGFAzG0YcHVXJ3oJSKndHt3ueHs5uruFJJlrs3h/wEtR2MXJQvaGkOG7EcG1k22vF2wzUf/mK80
X-Gm-Message-State: AOJu0Yx8rNGzulFawpfPkA4uPl2PPHhHj0GyRalN9iOL+ZzSQSryygvq
	n+tBLBAjdeEWcuyKMkg+K/Zdclsg7SIPp5QjxW+D2LXA0QOg3oPiF7RF0ndGo6q1kk3VrUkZhc0
	JGK0UGkgKD19b6Ur9D3yIKWs+Qal2Gf7/Zki/hvNSaVm455flGkMmFw==
X-Received: by 2002:a05:6512:1244:b0:512:bf7e:ca25 with SMTP id fb4-20020a056512124400b00512bf7eca25mr2175364lfb.20.1708434842763;
        Tue, 20 Feb 2024 05:14:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8GOsb9PCUAoG+xTokA/O/bJ8lqnvFxihET48bAH7rH5bSJopZDtx4usFA3e5/XmG7h0DGbQ==
X-Received: by 2002:a05:6512:1244:b0:512:bf7e:ca25 with SMTP id fb4-20020a056512124400b00512bf7eca25mr2175339lfb.20.1708434842396;
        Tue, 20 Feb 2024 05:14:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090624d000b00a3efce660c2sm561653ejb.198.2024.02.20.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:14:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 83DF410F6365; Tue, 20 Feb 2024 14:14:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] bpf: test_run: Use system page pool for
 XDP live frame mode
In-Reply-To: <e73b7562e4333d3295eaf6d08bc1c6219c2541e5.camel@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
 <20240215132634.474055-3-toke@redhat.com>
 <59c022bf-4cc4-850f-f8ab-3b8aab36f958@iogearbox.net>
 <e73b7562e4333d3295eaf6d08bc1c6219c2541e5.camel@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Feb 2024 14:14:01 +0100
Message-ID: <87frxn1dnq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On Tue, 2024-02-20 at 10:06 +0100, Daniel Borkmann wrote:
>> On 2/15/24 2:26 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
>> > each time it is called and uses that to allocate the frames used for t=
he
>> > XDP run. This works well if the syscall is used with a high repetitions
>> > number, as it allows for efficient page recycling. However, if used wi=
th
>> > a small number of repetitions, the overhead of creating and tearing do=
wn
>> > the page pool is significant, and can even lead to system stalls if the
>> > syscall is called in a tight loop.
>> >=20
>> > Now that we have a persistent system page pool instance, it becomes
>> > pretty straight forward to change the test_run code to use it. The only
>> > wrinkle is that we can no longer rely on a custom page init callback
>> > from page_pool itself; instead, we change the test_run code to write a
>> > random cookie value to the beginning of the page as an indicator that
>> > the page has been initialised and can be re-used without copying the
>> > initial data again.
>> >=20
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> [...]
>> > -
>> >   	/* We create a 'fake' RXQ referencing the original dev, but with an
>> >   	 * xdp_mem_info pointing to our page_pool
>> >   	 */
>> >   	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
>> > -	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL;
>> > -	xdp->rxq.mem.id =3D pp->xdp_mem_id;
>> > +	xdp->rxq.mem.type =3D MEM_TYPE_PAGE_POOL; /* mem id is set per-frame=
 below */
>> >   	xdp->dev =3D orig_ctx->rxq->dev;
>> >   	xdp->orig_ctx =3D orig_ctx;
>> >=20=20=20
>> > +	/* We need a random cookie for each run as pages can stick around
>> > +	 * between runs in the system page pool
>> > +	 */
>> > +	get_random_bytes(&xdp->cookie, sizeof(xdp->cookie));
>> > +
>>=20
>> So the assumption is that there is only a tiny chance of collisions with
>> users outside of xdp test_run. If they do collide however, you'd leak da=
ta.
>
> Good point. @Toke: what is the worst-case thing that could happen in
> case a page is recycled from another pool's user?
>
> could we possibly end-up matching the cookie for a page containing
> 'random' orig_ctx/ctx, so that bpf program later tries to access
> equally random ptrs?

Well, yes, if there's a collision in the cookie value we'll end up
basically dereferencing garbage pointer values, with all the badness
that ensues (most likely just a crash, but system compromise is probably
also possible in such a case).

A 64-bit value is probably too small to be resistant against random
collisions in a "protect global data across the internet" type scenario
(for instance, a 64-bit cryptographic key is considered weak). However,
in this case the collision domain is only for the lifetime of the
running system, and each cookie value only stays valid for the duration
of a single syscall (seconds, at most), so I figured it was acceptable.

We could exclude all-zeros as a valid cookie value (and also anything
that looks as a valid pointer), but that only removes a few of the
possible random collision values, so if we're really worried about
random collisions of 64-bit numbers, I think a better approach would be
to just make the cookie a 128-bit value instead. I can respin with that
if you prefer? :)

-Toke


