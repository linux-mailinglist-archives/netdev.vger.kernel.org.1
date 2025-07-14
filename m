Return-Path: <netdev+bounces-206860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB4B049F5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71261A67C1E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0226A095;
	Mon, 14 Jul 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SpnayBjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9E279DA9
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530808; cv=none; b=LlYbeSgV2uFAkjg0Ja5dG5KaDO1SXu2ROsMPZG8iLKIVQ8ssR/dLYukFzWFUGsBm7c2UMrUwgT1O1xF0K4wXL5Zl03dDg4/5f6gi6LKAIeOs8nh6KPW/JjKt9yzDd7pya+tJY7Lo/av+In8qYkUVHbPGbucMM/ZqukEWDFYfGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530808; c=relaxed/simple;
	bh=3E7/ceIrb2wIav9wz6oNi5RLi1BRqb8ESjjZ3wYQrNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2VKJQXB5R6Yb0+nA7bwo9J3GGcq5qLc5fmcxAok1w7Bko4LfMuihG7aUWNHDlGnBasyUGBVIv0CqIMUIywP5DSPI65aMx7X/GVdE91dRoA/iIjrfYJgk8+KmKNts1dmR8K+JhDciSACojwhNHbdRbFyzNuQV9005AZRZsdPW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SpnayBjr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5561d41fc96so5093533e87.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1752530804; x=1753135604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p8ysMEaR/dVPVjVoBDU5Z1MCNdYa0IQlcbHvU12KrE=;
        b=SpnayBjr7xltkm5h306HHBRQ/N0RnB33hGgQJzgEb9EZRGgSIJT3m+rAU0JJdcSYkR
         Ht+QhmBz8LapjtLCrpHNl1dIbYtbvUGblv8RMiSTg1P2hDyk0J5i70k3CzA+l9sSH+mh
         flNt35F9rzlHAAn7NmoX7hoTa47GOYxvD3S3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530804; x=1753135604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p8ysMEaR/dVPVjVoBDU5Z1MCNdYa0IQlcbHvU12KrE=;
        b=a2GMwZbMGNYPSbit5M2BW40w9WyKAIlznnIb4JEUy5tEuefqdrGjS0jdC5+RDqxPdg
         BqZPU15Qa1HWdcXJyAZ6pqSnjQFPuIf+MK0kqgnbUi7+olZpa9zLvTyJWKnxIoZmporw
         h1QVx5sFHyCyXHoo3gTNHi5Kozh8hD/1TGay7ve9uATl23mcut3oi69Iac3gY9qmayhg
         yb47fBA/Av1TlP4iImX4KdwApb8Ri/etvkLU4ihubjdLawq79kev4SXua6qBZlEGP40W
         cDYR28noiaZY8WBUszqrNEj5QytGZf6oi8f0DDNrccS+TZUkYKVz6KRv8B1n3anL8IuW
         7GKw==
X-Forwarded-Encrypted: i=1; AJvYcCU908XSZQ3YjsVsHNaGIbzWwAF5x4f3C527QzL/Ke1t/kViw7Z0lyPJBpqOzRbby+oKw1fyIag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9MZeJLyDe5kBhfl9o/WzMWZGNms9qUC4ZfRSBsnFOnFVBrUC
	of2Vhixv12K31f3Tp+m6NJagDr4zU8xsajArzvdt/DdiU/qJppel33SdMKE4WE0SGNdfNUzKWkX
	qFc9Aoc5B8re/vzR9MPHjWahw7Ol5W2BJNzef4ODnQA==
X-Gm-Gg: ASbGncu6cLpcBgM1bzrkcTBWTUVwLLFlmktlpmLMGa4PVht/UT/+BClQByEC/Un8Tjn
	OM6sbfBxU+LxXIhEd+bixBQpjtpELZB5GI5zCCSWK/JHHmqEZIJl9KdL/XglqpQnhFxw0kRAeCy
	LuO5vXxVF+LWMQRwlEmKN32GNdh2iWEDtZ2Z5WWUaXrEsI9TIqruTwUv8uC27wQHGVC0a8NHFMG
	rnUsTPf
X-Google-Smtp-Source: AGHT+IETszyUrTsBjKZ6NV63c+Lut2TsNH5OA7XQOyiZ5Fr+Mc4MxPiOmzESfTtv2hhALJWr6P+E8mkoTAaFDQZPnBc=
X-Received: by 2002:a05:6512:1381:b0:553:2421:f5e3 with SMTP id
 2adb3069b0e04-55a045ed5acmr3965582e87.19.1752530803762; Mon, 14 Jul 2025
 15:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
 <aad6feb4-f0b2-46b8-bf40-35d54807572d@nvidia.com>
In-Reply-To: <aad6feb4-f0b2-46b8-bf40-35d54807572d@nvidia.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 14 Jul 2025 15:06:32 -0700
X-Gm-Features: Ac12FXwd7tLmA232c_0TDSF1NCq4cOlS8DU84AZlXqwdmIaiM1xTkcfBaQZjY_k
Message-ID: <CADg4-L-J2k3Aj5vyAD2+mnTtcvkwt4J9JX4JSbbHyhuARno+Bg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:59=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 14/07/2025 2:33, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > include part of the payload.
> >
> > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > (and skb->head_frag is not set), we end up aggregating packets in the
> > frag_list.
> >
> > This is of course not good when we are CPU-limited. Also causes a worse
> > skb->len/truesize ratio,...
> >
> > So, let's avoid copying parts of the payload to the linear part. The
> > goal here is to err on the side of caution and prefer to copy too littl=
e
> > instead of copying too much (because once it has been copied over, we
> > trigger the above described behavior in skb_gro_receive).
> >
> > So, we can do a rough estimate of the header-space by looking at
> > cqe_l3/l4_hdr_type and kind of do a lower-bound estimate. This is now
> > done in mlx5e_cqe_get_min_hdr_len(). We always assume that TCP timestam=
ps
> > are present, as that's the most common use-case.
> >
> > That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> > the headlen (which defines what is being copied over). We still
> > allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> > needs to call pskb_may_pull() later on, we don't need to reallocate
> > memory.
> >
> > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC an=
d
> > LRO enabled):
> >
> > BEFORE:
> > =3D=3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.01    32547.82
> >
> > (netserver pinned to adjacent core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    52531.67
> >
> > AFTER:
> > =3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    52896.06
> >
> > (netserver pinned to adjacent core receiving interrupts)
> >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    85094.90
> >
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
>
> Cool change, thanks!
>
> This patch doesn't take encapsulated packets into account, where the
> l3/l4 indications apply for the inner packet, while you assume outer.

Yes - my goal really is to avoid copying the inner packet's payload as
that is what will "break" GRO.

Alternatively, if I can extract all the necessary info out of the cqe,
to know the real header-size, I can use that as well.

> Also, for encapsulated packets we will *always* have to pull data into
> the linear part, which might overshadow the improvement you're trying to
> achieve?

Yes, the mlx-driver will end up copying less but later on in the stack
we may have to do the slow-path in pskb_may_pull(). I would hope that
is less of an impact (given the malloc'ed size does not change and
thus we end up just copying bytes we anyways would have copied
previously).
But, let me set up some tunnelling and measure the impact.

Thanks,
Christoph

