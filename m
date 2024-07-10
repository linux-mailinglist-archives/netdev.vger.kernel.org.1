Return-Path: <netdev+bounces-110608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15492D706
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368AE1F21DBF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFD194C79;
	Wed, 10 Jul 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB1BeChD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F51FA5
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631098; cv=none; b=VYWrokwRigt4APb/lLN03+V5oizlVVVHKQED6Fto9KZB3k646s/w+sFUk2uvVt0togrf5aDuHlDP+QafN7a3YT+ZGGGzVO4MY+mwurNHAxtp5UA7P8SsdHMI1QeKFJoPVuZ0fw1x9uPzj3/9qMNW8bQpKphX4Uefqko2EVUNGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631098; c=relaxed/simple;
	bh=oq70z4/bCsrC1GoQvBoxOPOia/ExqElmdDJ/iZsXfL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjLoL1Jdq77eq047pJ8kTFh4ku35gwUogGGAMe23AcPSrIE81MIdnu5D7L2MFE3xPBkubXAxZs7K2O2iN3ib9IMjakrP9tkB9C1RfDWE/qLz4kuIwpFHOx5GtFcm2OF2XVfmlhaqxIVSGfOfNuiY6iAe/5YApawOu9pJWNIKqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TB1BeChD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so265a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631094; x=1721235894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HGeZAs5GCO0/ogUU/V9u51auuYtWzKSV+J+gDPs5AQ=;
        b=TB1BeChDHW6vSnVRI/5kHSoCHullabm7gJQ8B/sVA71vlWgHTfigpyqjJ8WGjR4bgC
         y+Y+SsWXzDiCivYqRr1IfKBImgLQsUc4ew+xQk+Xjw8X0SO5mHQA+5y1C940Dd8hFL25
         eqtNo0BlH/H58pmNwi2b6ffDA8GNUIGW8c5TLCgi5S3D6z1gloUiAAJh+tNo/dTulMIr
         nnf/tWDEfbaDIlTF9Uul5n5sGJSt1su5lO9xdISDIODoc0+Va3WOcwuQ/UK9iI8pLm7t
         k64K0XjuGXp2c1n5YWr5lKJ9QxJI3HM7kB61aNljVpcNUofckiKgKbprRd8kGUsnFMGg
         3+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631094; x=1721235894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HGeZAs5GCO0/ogUU/V9u51auuYtWzKSV+J+gDPs5AQ=;
        b=YLnFwUjZLSDJgv+CaHsFeRl5j9+ZzdsQ/gYeoxLowFqhfxfyF9xi0W9QtZbqPzoEDB
         mdX8cx2pGjNc4fF+ObovSmNvFE9z7PhRXQ4HcDpfaT0i7ESBvlsTGbfLinkxpFZYPNc1
         eFCmdu0NuIaJKuI59aezrLeniZqn6wQx/E6bmaGIB13JaXWUwWfZuVjaMbW/BeTwPjj7
         aAU0G1LwurqDnrOAC03AHYOK6aco7dzj8Whx/VrjQ8rmb9ZBGGcp8VkRoX5zH+6OctMO
         iYXzqtLre2EDfkceC1q1C7DIa0KCAFe3Keqcgd8wLGR317/XcbgaAJH4PLgp4Ko0W73e
         rLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9F0mFBx2yKUf3ZgSqABpcW7EFD09o/QMFOr905MSqA5X8NYsDrFkn54HDMavrw+Isqg4A36jetoJsheRhpKSqGQNTtWTb
X-Gm-Message-State: AOJu0YyMry2PltMuchIr4bBU42gvJUK3+KanDSS5BlJHihv9/ECelw1P
	Zv7HZh7Mfy35ifkUXCHaAJ/cjRithBn+Q/Cpfemjy10AHE7+KrG+txj2HIte4rxpQfXENjO8T27
	Fe69qGr2tYu/N1ricjxL11rDwa9loXV72VtJ8
X-Google-Smtp-Source: AGHT+IFY/CNV/3qrOH0Lh/APA9kMWu5yookxnY4Qhb2zRpXDPgqdWc1JKzZnJgXLhNnDQvH3c7i3SF5iReQ6xkV6bXo=
X-Received: by 2002:a50:8716:0:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-596f914a15amr216846a12.5.1720631093774; Wed, 10 Jul 2024
 10:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org> <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com>
In-Reply-To: <Zo5uRR8tOswuMhq0@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jul 2024 10:04:39 -0700
Message-ID: <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:19=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Eric,
>
> On Tue, Jul 09, 2024 at 08:27:45AM -0700, Eric Dumazet wrote:
> > On Tue, Jul 9, 2024 at 5:54=E2=80=AFAM Breno Leitao <leitao@debian.org>=
 wrote:
>
> > > @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct=
 net *net)
> > >   */
> > >  static inline void *netdev_priv(const struct net_device *dev)
> > >  {
> > > -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_=
ALIGN);
> > > +       return (void *)dev->priv;
> >
> > Minor remark : the cast is not needed, but this is fine.
>
> In fact, the compiler is not very happy if I remove the cast:
>
>         ./include/linux/netdevice.h:2603:9: error: returning 'const u8[]'=
 (aka 'const unsigned char[]') from a function with result type 'void *' di=
scards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers=
]
>          2603 |         return dev->priv;
>               |                ^~~~~~~~~

This is because of the =E2=80=98const=E2=80=99 qualifier of the parameter.

This could be solved with _Generic() later, if we want to keep the
const qualifier.

