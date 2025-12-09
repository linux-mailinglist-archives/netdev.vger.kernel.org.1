Return-Path: <netdev+bounces-244138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A58CB03E9
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99293014AEB
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B12C0263;
	Tue,  9 Dec 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZxB+4Mn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10129ACFC
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290029; cv=none; b=LTz4IQLtVgvZWJ+l3uES35c1GnTndc2ZeslsNeE58Aqil7gW2tpTbX5Fsr8I6+50rYI5u/0tz31pNBfsndicRa0AQRvKjOdv69hTSh/wf6cZ2Nx/jnKmV0O4MorIjJwMM/DfCCFl9bQK+Ee1CqD+CzOh39fOsh3VcKlWVcnvHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290029; c=relaxed/simple;
	bh=yD1piTTKkLTY5r8SbmErzOY/XWJulI5Pp9NE5eyw3mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A19B1VJoC1JpNjehQb3fhGXJMcXrFXTEPAhPyTz+kAPKt+u36TNFF87UUURg8LvIom5CPJzwKTXDpB8lJmehTdTbUNI3bgu/ReY8UlvMNbP+96lrB4FdypSPiQVFcDKEyYxNZJUJ+UBGoyJWZNUu7ZF1WtsktiD3h79k+Geapxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZxB+4Mn; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e3dac349easo4640854fac.2
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765290026; x=1765894826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBJfE2hGb6P9n37NYpV4LGZCWsJx5hal4Ysxh0cWioo=;
        b=OZxB+4MnpyGbLsuYk3YUjiRM0lBBpMF+zvvZ/TWNlOGBACfUEz8nfEYBE92ywQN41d
         P524cHrQzfE62HI3BL1UWjCglAwwUZR7QbsV9rqjjf9HItqeSJBZgJKNwsXGOwXlw2zP
         kJxrzcN9/t+523GiztaKuGcQlw4hsJj+a7kN2LtAHpwCiujK4F9z6GDXh6nVZ9ekx0hE
         yYYCaK50ofJJDiZOa6xG/ygp5xEZla/H1kBnWSVisWDbhaJpPx+nfUyOv8QIAVaA5Qfg
         xoFu82W4KZC6tRrwTTXJtXUtm1RIxDHkv7PiXstUzLgR6XUKR/6+CeqEX7a+I8NpKhcr
         abhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765290026; x=1765894826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBJfE2hGb6P9n37NYpV4LGZCWsJx5hal4Ysxh0cWioo=;
        b=R/Esw6Z0Nwc/yoeTTh366FBLMW/fvSSUAITlycQ73Pt7kmpW6tcYM6EPr7LCVoM3Dw
         uZxJH9bnzxPqajJgRRGj1370SHgyK23Ixh7VebuGLsJ0QN3Ssp1nxgfEu9JLWntVO0yL
         7765cxFwqg1y/39p/+3rDyVU1zdTuWLAk+0xci0nF6NUF8yV3Y3oxh2IofjrM3FIScG6
         kFHA1/V2sGgBM5o+d1GqPb+zxZ/pJ/bZtIcwKTzWxNTyDhXUCLDEljzi/JTlPCGFpBrj
         AvmXPoGquEZG7yWwBLDIfeyZXW/cnq2BwymWhNb6oKIPFh4J7ilOJY3oAIphAnWIfdN4
         Zcjg==
X-Forwarded-Encrypted: i=1; AJvYcCULFAtg5D++/hj/PGYBahax6OeavFL1bKy0OxcWy65YN8wtRDf/bbzvQIM2xPV7RflYFJnmjoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEo1zgKyi1vvSOhUs5mDnRI8ZvFqjSzkwkfgroitJlkeBSQDAZ
	CJuoGP9vHTIQEsecRJikUsHw8w0pHzfryip+AXes5T6X/gTJRMBgs/gti64anIBVPhRGdpZ04nu
	PmyqbhDIi5PztvKIor+giRBiZLUn6qEw=
X-Gm-Gg: ASbGnct6MSBlKTa6pEN/aNeRUgo/BYPbwsvagnjmCRDC32h3KwzQ92qMrVZKaCb4eqz
	y+lQ6m39CE+IAmMPY8aXuTaIa8CJ5EJ6ML7oWRoA/3zikr8GDiwmW2Dew3Jr2dbxQGdmo6gqFu4
	+0BKO7ADdcN8IpoZREr9GwY77gDOzKavpgJUJDjjPq6tw1fsTRfIPrCe98xIh5k0Xj4bH5FoBau
	f3t60zaKySMSB3eM/PyvaaR2KQS4m7HPiLRFVA+nlySLUsr5Qz7rrT65b+6BmPGjF2aUA==
X-Google-Smtp-Source: AGHT+IFc+EscoKLJ8xfpNpKZHnmvmIcf/SbHosp8AgCNsBwkh+gXjMCCcCW0C1l5LFpiu2DddXXV4UXr4RB8zSOlpXE=
X-Received: by 2002:a05:6820:f008:b0:659:9a49:8e07 with SMTP id
 006d021491bc7-6599a98ad19mr4876672eaf.73.1765290026448; Tue, 09 Dec 2025
 06:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209085950.96231-2-kerneljasonxing@gmail.com> <3b8d7e918263a668f37e7c991de87d9473d01604ae5e61c5a40310ef00ffc017@mail.kernel.org>
In-Reply-To: <3b8d7e918263a668f37e7c991de87d9473d01604ae5e61c5a40310ef00ffc017@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 9 Dec 2025 22:19:50 +0800
X-Gm-Features: AQt7F2oTRB5KgJ9LNJop9gl58v6h2U3JtCaT7Su-biNwoyYvy7ZmbcVaHLEdlgA
Message-ID: <CAL+tcoB5Y1YiQjbdzN4FdxGBf4=1neLMUvyZRPL55752GHyKPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] xsk: introduce local_cq for each af_xdp socket
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernelxing@tencent.com, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 5:29=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 23e8861e8b25..c53ab2609d8c 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -45,6 +45,12 @@ struct xsk_map {
> >       struct xdp_sock __rcu *xsk_map[];
> >  };
> >
> > +struct local_cq {
> > +     u32 prod ____cacheline_aligned_in_smp;
> > +     u32 ring_mask ____cacheline_aligned_in_smp;
> > +     u64 desc[] ____cacheline_aligned_in_smp;
> > +};
>
> The prod field is not initialized in xsk_init_local_cq(). Since vmalloc()
> does not zero memory, prod will contain garbage values when first used.
> The next commit in this series (722af5ef5295 "xsk: introduce a dedicated
> local completion queue for each xsk") uses prod with lcq->prod++ before
> any initialization occurs.
>
> Should prod be initialized to 0 in xsk_init_local_cq()?

Yes, it can be done here. Will fix it. Thanks.


>
> > +
> >  struct xdp_sock {
> >       /* struct sock must be the first member of struct xdp_sock */
> >       struct sock sk;
>
> [ ... ]
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f093c3453f64..ce165d093105 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > +static int xsk_init_local_cq(struct xdp_sock *xs)
> > +{
> > +     u32 nentries =3D xs->pool->cq->nentries;
> > +     size_t size =3D struct_size_t(struct local_cq, desc, nentries);
> > +
> > +     xs->lcq =3D vmalloc(size);
> > +     if (!xs->lcq)
> > +             return -ENOMEM;
> > +     xs->lcq->ring_mask =3D nentries - 1;
> > +
> > +     return 0;
> > +}
>
> Can xs->pool->cq be NULL here? In the XDP_SHARED_UMEM path with
> different queue_id or device (xsk_bind()->xp_create_and_assign_umem()->
> xsk_init_local_cq()), xp_create_and_assign_umem() sets pool->cq =3D
> xs->cq_tmp, but there's no validation that xs->cq_tmp is non-NULL
> before calling xsk_init_local_cq().

Yes, it can happen here. But it should not happen in theory. I did a
quick analysis at the following link:
https://lore.kernel.org/all/CAL+tcoDQ6MyuGRE8mJi_cafqyO0wfgOw5WTqnCvKGbQBhK=
OGpA@mail.gmail.com/.
I felt tired and sleepy right now and will dig deeper into this
tomorrow. Hopefully I'm right.

My take is this NULL pointer of cq case should be avoided.

Thanks,
Jason

>
> For comparison, the non-shared umem path validates cq_tmp via
> xsk_validate_queues() before reaching xsk_init_local_cq(). Should the
> XDP_SHARED_UMEM path with different qid/dev also validate that cq_tmp
> is set before calling xp_create_and_assign_umem()?
>
> > +
> > +static void xsk_clear_local_cq(struct xdp_sock *xs)
> > +{
> > +     vfree(xs->lcq);
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/200580=
64407

