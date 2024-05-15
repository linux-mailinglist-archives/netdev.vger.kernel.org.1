Return-Path: <netdev+bounces-96637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9D8C6CEC
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41A2B223DF
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 19:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764415AADA;
	Wed, 15 May 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hdgbb0Ja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19443BBEA
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802231; cv=none; b=Abt9TNTZEuyjOGLL8hUqowitiAv+2HFty+cRFZoQdojYoUkqR7VKtpUeSE2X4b27vRmOkqQZbgJckUyGs9c9kFzyQptu2PXwhY1BkGpNVh165TFxu7kWpO4Ek3UW+dVxP9/hbKHISIrg8l20KeonMOCD3vyzyRrvfyA86qa8oZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802231; c=relaxed/simple;
	bh=RYar/7zaFrBj+BXf5wMgonGcdsGxdP5N0RcAlZNM7Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRhu22BSG/+YQIodwZK8tHa2/AtyLZOsAZr3s+/VitXIqHFFVLzwG1DwTqKaQJJes1wkhfvOuaduqB0YyS6Dia2iN3ZSrmBIBjg/Q8mashXpwjijLXiwvuutZdMnd7ZqNGLrWuPHkNCEoy3lsHNMSSIp1RFxKefkQHXj/BYIyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hdgbb0Ja; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62027fcf9b1so62226297b3.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715802228; x=1716407028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOO5YDp/W/zPL8XaZADxLt3JPZM9jSsWKXcDd7Eh5LI=;
        b=Hdgbb0Ja8k6Kmz8yPpDFCIfcF/NA23ZxO46UzB8fw5zQWGmH84xC3Z4KopaaOTC+JM
         MNZ0EbT+ndWl8MJI8Bp+UVEJW77XdZNl3Otjdr+o3X0MAg9U7ajy3xtychzriOmkWVGf
         0Qb6AHNoba/NqXB8EaUWT7HIloMHUbofc3TuMAIXs2K8vDEQEarkhAZGDwR3/0gtSwSl
         u4Opp3Sv3TTiLRk1xeRqq9XXNkCNVwfY4vQ5Ae1UYXToNyhM3xfUonE1BrdXTgGLwX3F
         YvP+AO3Xn4PLvZvBIXfeQTd1Va9ZFgjXSmlO1r5BuXMthcwKG6I2tGlj4jcDQwIMpVE9
         Ncyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802228; x=1716407028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOO5YDp/W/zPL8XaZADxLt3JPZM9jSsWKXcDd7Eh5LI=;
        b=GKCk4/Q6IVHAUDRhSKuG6+4pV5ru+d2xhFBMq7bkWYXCdf1twQMhSt6v/IqZ6fskUW
         URXQEDX+mcIsaG6wKALbu7f0HBnolSqpBBMCI3dy8gvo0pJo7EFmok0pGdHkingxRVJF
         fRIbOiAMO9/Jkm9hrXwAB5lrkikcCYpm3BfgS4AmXv2USJl8gZimEI0s2mXbBuv76uf/
         T6L8dQbD1YBFnetA9wmPDQNKSXmZN/zxwAcJ8ocO4lIO65BVJPMUVFS56UqkCgUp+YiP
         IvoUOKXSh1Ebl5Esx2Dy9MVlXl1zdv4bLT2qwsxPch8ZGxqb1tWGmqrf1seqw5KbUOOC
         GOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUASU0tSXJ0OGLhya7oAvpPEDJIUspk+3tIKicgH5c//kYJAxzO1qR8l/IfH/cwdB86X2tNIFLPD2OyF5dFvKQziSEzwqqB
X-Gm-Message-State: AOJu0Yx6S8c70nJwMXCSUth5Voxoy9Vvo7KISKeUsthrZdtnGYNwSCMn
	gdlidr7XTlK+TOqMdmI76h0Vq500dRO8dKpoipvmSgh9fJvsdWmGCogSHZ9V40Jki0/IFvjtYJJ
	kfm1wFBaR9kK7QQM2w2ihokHhQaHSvdR/kVnxRw==
X-Google-Smtp-Source: AGHT+IEDahYQuuBrJGw6zWZaUcygbbAyhRsVrCyvE8w3MwlpGhQ9ogwL+eFlZmRfFni/3NEnE5l74GIn0D8fkRd83s4=
X-Received: by 2002:a81:8ac4:0:b0:61a:e979:427e with SMTP id
 00721157ae682-6244158188bmr43454377b3.11.1715802228658; Wed, 15 May 2024
 12:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-1-b442540cc140@linaro.org>
 <CANn89iKX0Gk8J=QVe5JwNi39zNzzfb2mP9tD4E5NLdimfrj5-w@mail.gmail.com> <CACRpkdYPS7ox=rkAwwF3UCnh-HXqKmMh0CUmeG1QQMLTeQsZ9Q@mail.gmail.com>
In-Reply-To: <CACRpkdYPS7ox=rkAwwF3UCnh-HXqKmMh0CUmeG1QQMLTeQsZ9Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 May 2024 21:43:38 +0200
Message-ID: <CACRpkdZaFn8QsfS9m5w0Eq8sRc9-zoopGHXp9Lu1aJzkKRhB9g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] net: ethernet: cortina: Restore TSO support
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:11=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Tue, May 14, 2024 at 11:13=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > On Mon, May 13, 2024 at 3:38=E2=80=AFPM Linus Walleij <linus.walleij@li=
naro.org> wrote:
>
> > > +               mss +=3D skb_tcp_all_headers(skb);
> > > +               netdev_dbg(netdev, "segment offloading mss =3D %04x l=
en=3D%04x\n",
> > > +                          mss, skb->len);
> > > +               word1 |=3D TSS_MTU_ENABLE_BIT;
> > > +               word3 |=3D mss;
> > > +       } else if (skb->len >=3D ETH_FRAME_LEN) {
> >
> > Note that this code path should be dead, because the upper layers
> > should drop the packets before reaching this point.
> > I wonder how you have tested it.
>
> It's actually easy to provoke with UDP jumboframes.

Oh and it also happens with TCP. This is when TSO is not used, but
the packet goes into a DSA switch and you transmit
a maximum sized TCP packet. The DSA tagging code will add
some bytes of tag to the frame making it exceed ETH_FRAME_LEN,
and this will crash the HW checksumming engine.

This was how I found the original bugs in the driver...

Yours,
Linus Walleij

