Return-Path: <netdev+bounces-90222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C608AD2E1
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA1E1F2170B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F5154BF1;
	Mon, 22 Apr 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3gEzs5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AA154440
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805137; cv=none; b=E9ouBsIAeG1W4Q0c6VCqGpgf98gUAVG56Dz8LlOZGlCoNUPLi7t3KGYi6gCiF1eGkQkZuqRptZGeFjK8AfWz+pk3d5548tJ2CESo64IPccf2lxA5vxqrZkM/V060RtsSbMSvyReSkDBkXOXFxGRBQPP00KwRO830N7ko5ojHCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805137; c=relaxed/simple;
	bh=42EMrMvFh2ZV66zX6eNpZFgHHLKM9doa/59H98DurJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHn44sWhuqrj6EOUjGlzR/G7iGwHjw0FK8g4dZ5QSHcTqzcGUemrKAZH/+/7wIWz3pZgBg6QCkaGfVF3EPa0i/vis5PPSBLyFjah9jvJcxUZrlGwaMEKAAWCzzW/v4s4vyBTlH05qSfQL65LfCS+XU2cmyl+q7rvp/l9yAJKlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3gEzs5B; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so4399569e87.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713805133; x=1714409933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/GHqxJH3jaz8y1htWNLtBU/umNHY1Pspc/g52t/wus=;
        b=w3gEzs5BjHfChpSnzRlsFXINHL47QMoOWiFHY/fDGJCZZWAZCakeaHz+rDdGLkvval
         WFs+v6Wk/DsgM8XgKovBQq+NxOnB0XOXi1DTilkoLZVDGTkIZRhi1zYe59scUJsNUNIi
         s2RN51LhUPWUrO3mhD072LYXUL6XU677aQG4PoOatzQI1qkuoS9+K2lgo8G48yDHxSBN
         ZIA7A5YIlfkAQealeIa+TufbkzoGC6l5c5kM9GqoMZIPDf/JrR0fCYTaVwVL67HdE4rj
         5VVL8f+o2PmREwebpbJNhPFUJQqJhjMxNEwzJr5SdaUCOc9W0ul5wQil6MKFr8Ooz5Ma
         cs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805133; x=1714409933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/GHqxJH3jaz8y1htWNLtBU/umNHY1Pspc/g52t/wus=;
        b=ki1UX9ibICLah58Ois93+DmTwXYv4oPplA7qoTM9UW/QSEUteSopDmBME2t9RLnYLq
         EKDYN1sMR5SBiRvu/T78g3xrZ6wiwCSoZwiiNAAOf78MR/NuUYqqXm+P3j9VapZcZ3Sn
         v3y8TbF1UORmmWE2mpMXXfpLpoTxBaUqD9q57MkVHOQ3JvV2CuHRsqLNKm6vBXh0VjIo
         nD098esO7AopOHtJK2IjYucO3Sn6kN4JSRjD1tkGC2ZiAGmNQaw4khXoeJebI0gAjVwb
         ttCw3MU065qjOVEPrtPCCOW9NCcajqlW+kgDEuyq/jvXg93nPrDDQ1pwfhcFAe5LEEsG
         7a1g==
X-Forwarded-Encrypted: i=1; AJvYcCUBFaymtiBO3WFkweyVHkDo9dHCZ3lI2SW7lCIs/ET5CgNYA7jRysRmp5JadYK8FuWF4iXhWvqq/+VRl3DTAyNo2gBaalz6
X-Gm-Message-State: AOJu0Ywm8mf5/zTYbYXvVzuKvYPp+vWfY+VJg0NUozDEcBcNWvrlo4dw
	j1MENLeYY2QNCAii/V//irisBoStMoF4ixcAWFm6VHsfcCSbpJIXr6qOGhCgZeWwoHI4gY54DqA
	GLn8JPeT2hpN7ZLku5nN4qUjMeNI54gq5Plku
X-Google-Smtp-Source: AGHT+IGQs6EYS26GO07gglIJCpPi+nxAzSr30qdzDEDGdL78TtOqrG3x1lwMSg9IktjYezwLd4U6fVyKCAI4XtZeibc=
X-Received: by 2002:ac2:5627:0:b0:516:c763:b4f5 with SMTP id
 b7-20020ac25627000000b00516c763b4f5mr6640305lff.3.1713805133247; Mon, 22 Apr
 2024 09:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com> <20240418195159.3461151-10-shailend@google.com>
 <20240418184851.5cc11647@kernel.org> <CAHS8izO=Vc6Kxx620_y6v-3PtRL3_UFP6zDRfgLf85SXpP0+dQ@mail.gmail.com>
 <20240419202535.5c5097fe@kernel.org>
In-Reply-To: <20240419202535.5c5097fe@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 22 Apr 2024 09:58:38 -0700
Message-ID: <CAHS8izOEbZ6wdw2=pPt_P1F81qQxjw83foeQ9baZk0XwYEmmpg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 19 Apr 2024 09:10:42 -0700 Mina Almasry wrote:
> > Currently the ndos don't include an interface for the driver to
> > declare the size, right? In theory we could add it to the ndos like
> > so, if I understood you correctly (untested yet, just to illustrate
> > what I'm thinking point):
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c
> > b/drivers/net/ethernet/google/gve/gve_main.c
> > index 7c38dc06a392..efe3944b529a 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -2579,11 +2579,16 @@ static void gve_write_version(u8 __iomem
> > *driver_version_register)
> >   writeb('\n', driver_version_register);
> >  }
> >
> > +static size_t gve_rx_queue_mem_get_size(void)
> > +{
> > + return sizeof(struct gve_rx_ring);
> > +}
>
> > @@ -2709,6 +2709,7 @@ static const struct netdev_queue_mgmt_ops
> > gve_queue_mgmt_ops =3D {
> >   .ndo_queue_mem_free =3D gve_rx_queue_mem_free,
> >   .ndo_queue_start =3D gve_rx_queue_start,
> >   .ndo_queue_stop =3D gve_rx_queue_stop,
> > + .ndo_queue_mem_get_size =3D gve_rx_queue_mem_get_size,
> >  };
>
> I don't think we need to make it a callback, even, directly:
>
> const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops =3D {
> +       .queue_mem_size         =3D sizeof(struct gve_rx_ring),
>         .ndo_queue_mem_free     =3D gve_rx_queue_mem_free,
>         .ndo_queue_start        =3D gve_rx_queue_start,
>         .ndo_queue_stop         =3D gve_rx_queue_stop,
>
> > I think maybe if we want to apply this change to mem_stop, then we
> > should probably also apply this change to queue_mem_alloc as well,
> > right? I.e. core will allocate the pointer, and ndo_queue_mem_alloc
> > would allocate the actual resources and would fill in the entries of
> > the pointer? Is this what you're looking for here?
>
> Yup. But thinking about it again, this may be more natural once we also
> have the open/close path use the queue API. IIUC for now the driver
> allocates the queue resources on open, without going via .ndo_queue_*
> If that's the case we can keep the code as you have it here.

Yes, as currently written the queue API funcs & gve_open/close use the
same internal gve helpers, but they do not go via .ndo_queue_*.

OK, sounds like you would like us to keep this bit of the code as we
have it here. Let us know if you have any other feedback. I think
we're working through final testing/polishing/code reviewing
internally and will be submitting something very similar to this as
non-RFC for review, with whatever feedback we receive in the meantime.

--=20
Thanks,
Mina

