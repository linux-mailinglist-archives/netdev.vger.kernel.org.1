Return-Path: <netdev+bounces-96097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932418C4519
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66591C2266D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDCD15535A;
	Mon, 13 May 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG+ULLTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9719155326;
	Mon, 13 May 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617760; cv=none; b=q99GKTut89ntaQso+gU/P2TjdPwF1MCZ1I5xf2NWr0dRYPc/sPu8ruDNNyYYK7dwVmmEp7f9F0tNn28kS6tFMC/M3d8XqosSLf0WCL228fXewtFHCI3GTCN/O5ztiHRFJ3+B9GRz6ZVLQBgpIbyPmDo3AeAaalyKXwbdpwq2fvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617760; c=relaxed/simple;
	bh=9oirvRjInAAK2WGeTpkg13GutqE/g028MxGLEUfVJ4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGiBihIVDYI56sdTPygqmM6bdFVMUrUCDBNU8zwrKmcSnRf60Jdk5E83j9JeFO7BBR9dqhDMZCewloJ5k/yE4ZDneIN+E6P9Yfu4JEkCrL+678t7ECctJklBdf/wKdhJYQ12xGlf9RP0MNQMt8k7QqddcBogRZhHAXU0S+eH97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG+ULLTA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so57505521fa.3;
        Mon, 13 May 2024 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715617757; x=1716222557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sABAyDDibQeTUxaqpap0tAGtEYkahruaupGbesZnVxw=;
        b=NG+ULLTALVnG8nXbcS05WAmLq6FOjMRDQy0Tu9YTARNmlmfml3Ke2lwizJlDNY+/v3
         F30xl2dXDSmcKuSba8+uOl9zVO7faz35ipRJcN4v79B8l7KUiKevTwywf6WVE2pKdEWp
         aUjcWZd1eH/b7toN/EmTWHwbtZGqldINkFPSrxd5jkBKE+p6uh5LD3ip2TFxIbYD4oPp
         c6hBs+nCoxGsa7uIhY+dQcq1b7unhnj65JSL4VWa43Otx9ABIQ6FtBFYzrnmSXFMke6K
         CiQ144uqhUXIWjlEo3ZK8R9TB73mwrXrrO9kdD6wljaKTTsB7GF5pqEs/G2kfkO1EbGn
         9URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617757; x=1716222557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sABAyDDibQeTUxaqpap0tAGtEYkahruaupGbesZnVxw=;
        b=K4/vfjwm7ZErzxSX5lmSpG4ciJppK/v38WlmGHWmcW6BHyL1W9BURBWdXqV6NL71oB
         50ZC/oEzqF1XnvBmQMtRsInWqpnOZHcWXuQYUwk0S9Te3LFxXaMHGqK4RabSscHqpROI
         IBxUityXIKQwFxvTa/aCBP4Fl1WFjVBuv2ZXblLao6biN4piur8F/f/qIyZsMhsAQwJ3
         wYuHKkXib5yzRyCXf3RXvDdZsEbzEgMaUNlt6c1R0TmxbNW6QNoZXDN31Cs1InVfp9QT
         gkoQlGU7oZewynVu9O0g0B+/BN8ULaztvx54dwJT7ybafflkYWi2GU7csP6B5Npr7gV/
         qO5g==
X-Forwarded-Encrypted: i=1; AJvYcCXAyAUGjPBCfTpdUXsQ1F9OzoIrFJelCRWuqll6rCiPcJXPL4ORUuAvQfpwkXD+hFkZ/0ImwFR1SVcIidrSLbosXm+WgbH79t0Q/PxgN4R08CeO/tCg+02ZEWbG1c/Xg6rnKbxxhoaxXELQ5h4xwVyULfLrMFT4/JKrdw2aR8WgBafLcco5Ra3iFWFp8j43WpTzZ6IwOh1/qATBlIm/AeYyr6TsT11Q
X-Gm-Message-State: AOJu0Yx7tQ2g1XdErnVU4jl2+pPMbQb2c3cblRJ8P5+r2tVI6GxHxue1
	xy7CDgSH7N04caxq+SW95ECyCCB9dQId+4aFqWkzOtZZOQB7t+LCk+nlDYMq+q9S0PIHp/3z++Y
	JFClQ/AcjUQ2TuxzJYIBlY5y0Bz8=
X-Google-Smtp-Source: AGHT+IEzW3swQESCG1PQZCau4vY6voiOCRmeopxeRXdBZmXXzeygMwKz9BndpIVFZiSJ3rYSQcVeLpqTsjWpyxNmprY=
X-Received: by 2002:a2e:91ce:0:b0:2df:1e3e:327f with SMTP id
 38308e7fff4ca-2e52039bcb3mr71238121fa.38.1715617756547; Mon, 13 May 2024
 09:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <d11dacfa-5925-4040-b60b-02ab731d5f1a@kernel.org>
In-Reply-To: <d11dacfa-5925-4040-b60b-02ab731d5f1a@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 12:29:04 -0400
Message-ID: <CABBYNZ+4CcoBvkj8ze7mZ4vVfWfm_tyBxdFspvreVASi0VR=6A@mail.gmail.com>
Subject: Re: [PATCH v2] tty: rfcomm: prefer struct_size over open coded arithmetic
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Eric,

On Mon, May 13, 2024 at 1:07=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 12. 05. 24, 13:17, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> >
> > As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
> > this structure ends in a flexible array:
> ...
> > --- a/include/net/bluetooth/rfcomm.h
> > +++ b/include/net/bluetooth/rfcomm.h
> ...
> > @@ -528,12 +527,12 @@ static int rfcomm_get_dev_list(void __user *arg)
> >       list_for_each_entry(dev, &rfcomm_dev_list, list) {
> >               if (!tty_port_get(&dev->port))
> >                       continue;
> > -             (di + n)->id      =3D dev->id;
> > -             (di + n)->flags   =3D dev->flags;
> > -             (di + n)->state   =3D dev->dlc->state;
> > -             (di + n)->channel =3D dev->channel;
> > -             bacpy(&(di + n)->src, &dev->src);
> > -             bacpy(&(di + n)->dst, &dev->dst);
> > +             di[n].id      =3D dev->id;
> > +             di[n].flags   =3D dev->flags;
> > +             di[n].state   =3D dev->dlc->state;
> > +             di[n].channel =3D dev->channel;
> > +             bacpy(&di[n].src, &dev->src);
> > +             bacpy(&di[n].dst, &dev->dst);
>
> This does not relate much to "prefer struct_size over open coded
> arithmetic". It should have been in a separate patch.

+1, please split these changes into its own patch so we can apply it separa=
tely.

> Other than that, LGTM.
>
> thanks,
> --
> js
> suse labs
>


--=20
Luiz Augusto von Dentz

