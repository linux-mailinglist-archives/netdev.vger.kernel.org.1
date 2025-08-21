Return-Path: <netdev+bounces-215843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38160B309B3
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F649AC8309
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C582E2EF7;
	Thu, 21 Aug 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="IgKfbTV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAA28E0F
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817184; cv=none; b=WZhhsgeHCl6WWPjYQAlGf97nEdP7553by7OfisZwiN35wOpDldrirkG5qwIUYVIvR4bNgFSGrwSxmoh5zV01/JgX/cwY77ay5JXeOwX+42NxYGyKT9ZlY+59tkdrcbgXm0bHocrsoE3CkHk0Aq0njPWYxHtaSG6Y376bS8QSOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817184; c=relaxed/simple;
	bh=yxDOO9UuJTgm7GnRUIkjV6RDjLlytWBOXaWxIMHzX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbyt6JemwASA7Z7fQuvjj/jrlVHDiE/kRyqy+F/8UEOWn5l1oyQaebw6V/VD/seNi4u9kIx3LdzuMXphrmWweMLj0BcXaycfqQvZUy56LBYgySmuY+A89XXLmdRuSntEoEmFuVFCNRzSoDL09c9hORjZUXMqDfT4/YJ8smbaspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=IgKfbTV+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3364f31784dso3443301fa.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1755817180; x=1756421980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS+hI7j6rloI0x5/njHW4ZZUbpoU+gH5BK6q7Ls9zmo=;
        b=IgKfbTV+eFWCjjtWb4ahABsGmnnwWXqgs87DvlBHI7zSLJpP3UFbegDE9Fc26vb6Ni
         xsPUxuIcpsz89N+xtgLetYhw+seiisJJifX3N2KzM/4/N/y3pPORrsf9MBDnvB2SmPq6
         wozsBd9ZHMW2wZf7CLq99aVcDa4REFIq4yW2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817180; x=1756421980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS+hI7j6rloI0x5/njHW4ZZUbpoU+gH5BK6q7Ls9zmo=;
        b=e+uvq5c2NmAsceF+dfGweYM0l8T68O9evu3yQ1tY0IH3Xc9QmGBEaoc7shGCEk1mcq
         Da3gLi2BGeFtblsUJdCWHFe7CT05fTL08xc1mhyPoDi12BYOQ+6bIsK1c/ZuzcVlpgZR
         xasIU5nk53gqGhqeVhwB6h+Jlh3asxLSMFIWnyOvrpTy63mP8YJjR02ZM3FXUXahK1Tz
         gU9Ci5gpiOjE4wHh5Bh7CF2BNeggoGHl6lPMVGb5EYGiIYXIcr9k3Ff4Rxfi6yMhPkZs
         3OLQwebsXcgLg2M3IFRQVcCGTcw6uEFEt5RY4oC0aGiHj00PYQuG7DjyvDsG/hT0B6Ys
         dufA==
X-Forwarded-Encrypted: i=1; AJvYcCX6y2Bfe9uEexeNKEBBrKexaUNmQrIqqUuEvusqDufXpUvAwNFMoGPPbqhXq4NbnuXN631CuLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pJNtvsIzuJU/3a4bUTbPe9U5q065106rDrMXZVZWZT2D/eqz
	NLmPvwkUZw84GYeOOQBAujkqPJNMZSfX3imQrzuE8MiXxEGpWnqTkC3EufpOULWrq1yXaewgQmB
	64DUG3DOiCBNE5oDuWRqzgXaO+EfjxlqdgLJW7gSaEw==
X-Gm-Gg: ASbGncsTVnhTJA4bKy85g0OpO7lpmVjA5IbWrZhMzQPQvzH0X4DH6X2QSWWtmt9F7aH
	KWdJsd6AswC3mdamGofrxtKD6kHqmn0fueb6e3//tyCWyWOgAUpxdp6RzsDSIWd/nsOpppyLUqo
	BNdyCMb4y1TdUyDTHrQ3cHAn5Ssflb5xQFAgPEMYJIzHfa2wsx0R6nXSFMKiLpfjCmxYn5MLAfl
	0Rro1TrgNptnoNNkyEFAYedlkEqiU83kQJoTPrRUFk07B06HwO3iY8HZefz0ng=
X-Google-Smtp-Source: AGHT+IFktp37fZovN1VW+3Y8td0N1JNBmuFdxFgOZgHKlsmmyWjIbeeNnFdC4BYyNz6sf0RIy5CALsax2Cu2eiA20HE=
X-Received: by 2002:a2e:9087:0:b0:32b:7ce4:be22 with SMTP id
 38308e7fff4ca-33650f3dcf8mr1973981fa.27.1755817180560; Thu, 21 Aug 2025
 15:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
 <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-2-b11b30bc2d10@openai.com>
 <6dguqontvbisoypbfxw5xyscyqhvskk5avf7gwqgwajc4ic75a@id3pume2f4hw> <20250819171505.4ebbac36@kernel.org>
In-Reply-To: <20250819171505.4ebbac36@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 21 Aug 2025 15:59:29 -0700
X-Gm-Features: Ac12FXyKesdKjuswg80zK_q7kZhV_1jNFCS4hNzofJVDACG1mUgrvsrJlrInegE
Message-ID: <CADg4-L__JBO8j4tVnG8-DxCdmbUWQQqXjgb1W3qb4=29F1c=HA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman <gal@nvidia.com>, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 19 Aug 2025 09:58:54 +0000 Dragos Tatulea wrote:
> > > @@ -2009,10 +2040,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx=
5e_rq *rq, struct mlx5e_mpw_info *w
> > >     u32 linear_frame_sz;
> > >     u16 linear_data_len;
> > >     u16 linear_hr;
> > > +   u16 headlen;
> > >     void *va;
> > >
> > >     prog =3D rcu_dereference(rq->xdp_prog);
> > >
> > > +   headlen =3D min3(mlx5e_cqe_estimate_hdr_len(cqe), cqe_bcnt,
> > > +                  (u16)MLX5E_RX_MAX_HEAD);
> > > +
> > How about keeping the old calculation for XDP and do this one for
> > non-xdp in the following if/else block?
> >
> > This way XDP perf will not be impacted by the extra call to
> > mlx5e_cqe_estimate_hdr_len().
>
> Perhaps move it further down for XDP?
> Ideally attaching a program which returns XDP_PASS shouldn't impact
> normal TCP perf.

Yes, makes sense!

Will do that and resubmit.


Thanks,
Christoph

