Return-Path: <netdev+bounces-129578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C8984975
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265FC1F24206
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B141AB6DE;
	Tue, 24 Sep 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BZYbLwpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925821AB519
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194883; cv=none; b=AjhFFtHSmtuxxuLaKg82WAAXoXX6FNdvLDK2irVOvca7fk3wo4WYNsP4Oz2nV/LvVmDJdq/9lJWgnKyYuu0VYNg9CypFDFjmoL0uY79RC8d6Pz8mRyJE5DkGJNX3v3Jilql5WX2kbKXLJYdqtO41MKklJbcY44xFtqmizwxYVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194883; c=relaxed/simple;
	bh=E/gaXjcWfQoJb1wQcf4GOby1GTNe9l3MYSenfHyrMSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+XA57OXpy0y7ubf4rRWVgqU+73yzbV99HXJazxrDzIzeiKgLnI7ZNdpV4DG3TMJx3Hq835TsJDgOmWrPFqxPXdBxDl/Xy8FoIBEd6vIWxhYEUiin7TFEhWfHzaf86Q+r9uy0rL3THtYwL6OwC4NWBCOI7VRTB9IxclryHaBSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BZYbLwpp; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 831DC3F231
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727194872;
	bh=EQCi9fW2dWTk233xr7e2blQ3sARsO2oDdWlfuFkrMuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BZYbLwpphZO0/eqPj3wlcrdym7BaUAvKHe5auWyjIQZVfLxRn+MqNzNzEdA1+KvSF
	 rDpskDMSGF5E9VEwwankh2240+juHnAVBXekUtIBhjhWkCUybjvAZ/yuUty7U9NHk6
	 4JK82nNijwx5n1c9BFjfC2m/IOhUa6JJ6m9mVhkZZqaKQBk5ikAMm8Ms4IK3c0CFQh
	 dsUrfl6xLzi0Iavz9hLAce2VTc198iBfwH2yX/1SaWV1GKdky5VKr505ly4NuYQiMC
	 BtQ39QzvCyqL2OPes7njYWxakTH7KzmdGqmuU7kN78A700iZVsH+i7w6ONkpQ+xtnO
	 JpPSB3RDlUYLQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a8d9a2a12so411276166b.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194872; x=1727799672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQCi9fW2dWTk233xr7e2blQ3sARsO2oDdWlfuFkrMuM=;
        b=azKs8uFRBiglLZahA9T+UTbuXigTndI0btwQ98WNpwcPwmpzJDbUWV/YuHcbCQdbw0
         53+jCXPnM1JexKrlgxCaOmkyCWTVmC0NmCc3k+cX1Team8ujArkNFDCQvWicGMNvQv8N
         MYCTYAWotxawbTCa1j7C/Pins7++qzQwqqvrkY0jjC/eD3CD7RYmeX8MEtp+SOZA27f7
         jIb16GpdTa3l+uDn1HSsvZP7IjO6/7gZNFXK32v9uoC3CyuW/BEz9ZMw8c+Kr0Bep3I1
         jDEcp6xGN5IRE6zXRmlQMZ5e1QjesUCULvMYiYRlAPsrYc8tdsJpqX+q69c0FDFVBFTB
         HPgg==
X-Forwarded-Encrypted: i=1; AJvYcCXcBDlz044MfSzZCJILfnagcNtaQfV/srlaqcARb4MBxBc3HosYRj1ZaalKx6Arr4H/bLTsLaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EYT0Anbo37sNdebZKuIsCm3ndxQAlngVVEgeqpH+otN3ENRy
	V1ZVikK1D56vB0kjeMtNUCvXQoPOe1Kfwisz2OkcC8FKGihHYOJXLoi9uXOjS2bgVBePT8/VWln
	0zB2v+1vT2DLhjLBit1SlC/eEdSN3f0Wp4QM/dT+TpK3xhb2z7gKZI9GKO4YgONFhu9PnUPME12
	mQswhIrHWhH/m8AIvS6YFWUigtfhcloMtOoHEsnISgMlfK
X-Received: by 2002:a50:858b:0:b0:5c4:6307:d971 with SMTP id 4fb4d7f45d1cf-5c464a43b24mr12209516a12.18.1727194871978;
        Tue, 24 Sep 2024 09:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAvsosFo/e8/9HuFV/tCMLWiEdNBe7QIHix3xfxwiz0r4TlGqYFEicCdSj5wBrYx+tp52hWqYAxR0OoTX1d0Q=
X-Received: by 2002:a50:858b:0:b0:5c4:6307:d971 with SMTP id
 4fb4d7f45d1cf-5c464a43b24mr12209499a12.18.1727194871583; Tue, 24 Sep 2024
 09:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org> <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
 <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com>
 <CAHTA-uarCi84OTPNJKG2M6daWi=YsWFgf_wd0gKMULeeOvBwXQ@mail.gmail.com> <CANn89i+bZY8vseiWQb6gye=YayDzgrMeyrk1k5Ex_ux-NcMRnw@mail.gmail.com>
In-Reply-To: <CANn89i+bZY8vseiWQb6gye=YayDzgrMeyrk1k5Ex_ux-NcMRnw@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 24 Sep 2024 11:21:00 -0500
Message-ID: <CAHTA-uZK_U8_0t85Z3xdJJ-mih7WovgXzXkT1k2VygaXP48AaQ@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> As I said before, we were aware of this issue, well before your report.

Yes, sorry - to clarify, I wasn't commenting on the state of the bug
itself, just asking whether my reproducer is helpful in exposing it
more easily/reliably and on more systems than other known methods, per
Jakub's original request.

In any case, thank you for the additional context on the bug itself though.

-Mitchell Augustin

On Mon, Sep 23, 2024 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 23, 2024 at 10:01=E2=80=AFPM Mitchell Augustin
> <mitchell.augustin@canonical.com> wrote:
> >
> > Hi!
> >
> > I'm wondering if anyone has taken a look at my reproducer yet. I'd
> > love to know if it has helped any of you reproduce the bug more
> > easily.
> >
> > Patch w/ reproducer:
> > https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@=
canonical.com/
> >
>
> As I said before, we were aware of this issue, well before your report.
>
> We have no efficient fix yet.
> https://lore.kernel.org/netdev/202405311808.vqBTwxEf-lkp@intel.com/T/
>
> You can disable dst_cache, this should remove the issue.
>
> diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
> index 70c634b9e7b02300188582a1634d5977838db132..53351ff58b35dbee37ff587f7=
ef8f72580d9e116
> 100644
> --- a/net/core/dst_cache.c
> +++ b/net/core/dst_cache.c
> @@ -142,12 +142,7 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
>
>  int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
>  {
> -       dst_cache->cache =3D alloc_percpu_gfp(struct dst_cache_pcpu,
> -                                           gfp | __GFP_ZERO);
> -       if (!dst_cache->cache)
> -               return -ENOMEM;
> -
> -       dst_cache_reset(dst_cache);
> +       dst_cache->cache =3D NULL;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(dst_cache_init);



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

