Return-Path: <netdev+bounces-233766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E020CC18055
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E3EE4FE010
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79A2E9EDA;
	Wed, 29 Oct 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYC2vaiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF782E975A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703814; cv=none; b=mAZh+0hu/D8w3yHqiCwL9qjwYAGxIi2ao2ZwKWWLtlVdPrPMDQ+at7O3u0UsFk+KpFTAxtsSTYlxcF4AgzqNSbiTKr/7a05ktCASAfJ2R8/QqAQNgzSaV4wPMpBc5TfbtbxYD/XvqYXpPj+52KfSdTFOXk/hIKeAQeU5eU89eSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703814; c=relaxed/simple;
	bh=ZLh0HlWnhacXMlrR5BhoWOl5kF7rDUf50gDtd1Bbnt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9oLEBukJv3sQcWsXRYnMFF/FpXwGUsgtRj87Utgz4RTtnH/h0cF3MKhrdOmlz0UDRV6TSbccpQmtgtgVGMBdSFYzJkEhd4QG7adPQYEhFrJdAAva1TAIQ35SWsFNatm5+c9E0JjuTGbXh7TZ/pauJOcGQG/0tSUTVOObwYthCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYC2vaiF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-58b027beea6so2536e87.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761703811; x=1762308611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9lWbIyuET21BV3jefDHD4hEs4Ep+M4AnO2qpSJ9Lmc=;
        b=zYC2vaiFyi3G/JZheJhNcPMZ7OtFo/SnYLy+stoD+AzUbyu18QRDaQq58EIH9aDXmW
         WKgZbPf8OafvtTcIjmTSBZjdlTb0sE7rCKcR0ENsi2lugY8M/c2Cfqzhuj9hHFmmZgn2
         yV4wijHhhXGAnioMYJxCpc+kkJ96QiXnVQDTG66Z9RxiCHa7DPqL0OrRnIKLnamaGkBj
         Q8jct3ZOPWkIvfPWZCk7JBK25gjBoJ+TfSOy2KOfyB8iTEWC+QnKWMalBJB2WmxD6ekZ
         5qRiiBGPL6NDqi56yG9yS4ZXyVlq0QnNW0k4TMi6AOCTtHbF1/FYAJN3/mD2x6jSp1F6
         1muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703811; x=1762308611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9lWbIyuET21BV3jefDHD4hEs4Ep+M4AnO2qpSJ9Lmc=;
        b=R5Av7vPhoBESOW8w7QiMKVnZZPpYYo2PFWwpceEea9H5PGL/jAq7BBcc5St+i+V71v
         I8m9lcghCK0W5UO2V+ZyDpQAfiv8Q9mr4KdQBQJ2T9DiCP7BO1Cgzn+uaLnEGGQirOn1
         Ec1JXd2lfDxdQ38bZ4DHs3pxZe4bHin4s4jK4U+LPiQ9oydvLkDIoo9KSdH+XD3QOsbT
         TuiJK5PzK3U6+x6eT69vxnLZ4tOEzdnJ03lrrtFy8rfcDez4ms1YMZn7RzUuY6/riBYs
         RYezUFvRAqPE5wCzaJ+S37cv3cd1UNWEjv3XYqlEQnNRAXs+SoARrX6BwVbrGdfb8j17
         krMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy58pLppvxIqLn2jvHTo9j1HUluA9+N19LeHNNwhbP8j+32zYeTj9t0QySNl1yFD8AMAaXlE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySvtyMpt98H2MUj9yjRj0jTTbjzjvTgCfdTdXYp1utpdSRQE2A
	SW1mh83eGEIJ6y5DipNfxi+IPWy9uglTjYmPshNt7zT/xcVqU14CEAmIVuVmkdU4sP+31gFdn09
	49NY+rY4y2j8Pow7QK4Js0XpdKq6NY2x5QhpqOxUX
X-Gm-Gg: ASbGnctymvsjU/KQChtdQheIMD4mWLgS2aBPydFLrcYHV4HarZoJD//Oq2SGiXDJOSG
	SinxzmpvNQaQmbCSa1kto0QsBBNc/yOPSQahYivvdufrOW8WbeBkRIwLkJyQGfM6UfkcybjmJp0
	ZEg2IytmcQ8rEl6Jwxpd5sVSkd4vWtI3vsb5+Vn6e+OnGwCiMpoXNJQLLqH1/7EmOGkI8IZlzyu
	h0cQPJCyPcjVnD4DxoX+Sbo2YQLfktaXeTFAueHlDbJupV/R7bOguQQd2t/yb6DuI0oQp0=
X-Google-Smtp-Source: AGHT+IGl9Y9GqxxvDKMo/6fF2Rx0aNzgG8K8zH4GCOKZlaSF98H334A80Kbn6ua00QewNRYJME87yOhYU0lYXUUWLs4=
X-Received: by 2002:a05:6512:4141:b0:57a:653d:ff94 with SMTP id
 2adb3069b0e04-594133eb3a3mr127371e87.1.1761703810319; Tue, 28 Oct 2025
 19:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
 <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com> <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
In-Reply-To: <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 28 Oct 2025 19:09:58 -0700
X-Gm-Features: AWmQ_blPOzhHIri3399hiWRunYMSkTopiADU8tgIF1xFYS1SKs5IrXz8b7aA-_c
Message-ID: <CAHS8izPB6Fn+_Kn-6PWU19rNYOn_0=EngvXyg9Qu48s32Zs9gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem autorelease
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:14=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Mon, Oct 27, 2025 at 06:22:16PM -0700, Mina Almasry wrote:
> > On Thu, Oct 23, 2025 at 2:00=E2=80=AFPM Bobby Eshleman <bobbyeshleman@g=
mail.com> wrote:
>
> [...]
>
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 8f3199fe0f7b..9cd6d93676f9 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > >                 goto err_free_chunks;
> > >
> > >         list_add(&binding->list, &priv->bindings);
> > > -       binding->autorelease =3D true;
> > > +       binding->autorelease =3D dev_net(dev)->core.sysctl_devmem_aut=
orelease;
> > >
> >
> > Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
> > that silly for a u8? Maybe better be safe.
>
> Probably worth it to be safe.
> >
> > Could we not make this an optional netlink argument? I thought that
> > was a bit nicer than a sysctl.
> >
> > Needs a doc update.
> >
> >
> > -- Thanks, Mina
>
> Sounds good, I'll change to nl for the next rev. Thanks for the review!
>

Sorry to pile the requests, but any chance we can have the kselftest
improved to cover the default case and the autorelease=3Don case?

I'm thinking out loud here: if we make autorelease a property of the
socket like I say in the other thread, does changing the value at
runtime blow everything up. My thinking is that no, what's important
is that the sk->devmem_info.autorelease **never** gets toggled for any
active sockets, but as long as the value is constant, everything
should work fine, yes?

--=20
Thanks,
Mina

