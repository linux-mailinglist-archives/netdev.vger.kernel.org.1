Return-Path: <netdev+bounces-194756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CEACC4A7
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75843A4E38
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36B22D4F6;
	Tue,  3 Jun 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itG7Po/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485322CBD8;
	Tue,  3 Jun 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947853; cv=none; b=Al+R0rCXd3btih80qK2t5Poq/y82E4drzily5WksBgfNnZIK1VIUyLyU13zhsdvOCSWJnV2cIWo3ZoGNishiZv452OanWkZXf+2qhyzPiHzKlYkIl8G6s9WjoUN5my2zSGG1jf4pSxvWGVCP9iiLJ/2wRT4FbFj+9uRRU1XQsr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947853; c=relaxed/simple;
	bh=cDFJ50B5U5uPFJC9elUkw7oiF8dm2hb1XYKgiCw75mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCss9et7ZorC/shyNYtXnEhDL+uFCcZ38B3RnVhGPmRtX9HdfG7xla3KQy6eh4qcxVxEfvjvaRtEucoDwAHmdgkgXWv8swijB2DDIbZuF1QyD/c6DUj3HRo3JlVDuvAFAyEtwCoRgC3r24hryUfaovUEEOV8ANDW0a2RNRtD8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itG7Po/r; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5961710b3a.2;
        Tue, 03 Jun 2025 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748947851; x=1749552651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc4NM6pw6KNZGmpFvBeiKc9tgGdf6YiQE3mYffB4/Vo=;
        b=itG7Po/rOZqRn72oGVo0+yoyg9OqDAkTEIxxWwq/mFYOQnMN5REFc44L3+FxKTduIn
         w9NtC3w2HpQkRxyroHSBYreuPSkvOLoYSJsXOiBqBOFGb4T6v9/omoV49ZV7klEPC8Is
         0Ex7UA8iJzB8dcBLOhrrFjMnKp292KBRKQh3g2PxWHfXJn3JHa1QCk3qj/CwVC/M3R1i
         qlepKiw+OvvpQJi+n5E1cuWNpAGwW1y2HiofT+NvxJfQPSJsJjHoH+6w1vp/qbcCcDvA
         xTY/fE7Sb8Bbo8bbcCzCgs0Y95IzudcErMieowDMi1TSlIcOFp4jIvbf8sQe4VnRHWEt
         N4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748947851; x=1749552651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc4NM6pw6KNZGmpFvBeiKc9tgGdf6YiQE3mYffB4/Vo=;
        b=ckgus4cIqBlKC2lGHywK/LOMlI9G+dxw5z/H9LYs7EA4HixnaGh/3ICatUFIPbqrda
         j/00JJfY+BF5e0IL6RpF5Bhq25Tni9B27s6CfYFB5nwviBIQi+FArvEfrX6HVxPwxX6m
         6US89P69+2avCliuK7XBUUf4OoevyEM+yaQu1VtEkoavAABi5hjGgeJcdQdtIz5jWsKX
         vRhvZlnE/V1lgcbvuy6899t1zENrh3ofXywvh/EAlEgfE8AiYyPJlTYlNn/C2DDRarTB
         PnKMAqDo1TpiLF3gmXekok+b4A9nMz3BotzwZXG5Qkej1RFjImgWNvIwn+6KiNBTQfq4
         +niA==
X-Forwarded-Encrypted: i=1; AJvYcCUC+XoVh7MNVWoiJ6reul1eAznE+jWcxVod0CoGWO95DbFSo0auO/rLETpiyAn5CppQYo+myxUT@vger.kernel.org, AJvYcCWidYWQsFUM1p16VJDVhA4lApwB7lLTaP/y2qZ0cF8y2aqjZJMbGsoTFifhgYTtQy6mdVWZRRjEmGFfCpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAl+rax0ye8SRXyp/pXhvFMyA/sf9uOGU66/oPkIzZpFxXeUs
	Yw4rGNkbwRSarryc8aHAPriyP7YJnDJIt01JRCHLVcPmrEQ21BJdKlDebmyFKainjPp31r1dadP
	HvI0YaKXyIB/Ezjb5/7D34CcvzdtaKlw=
X-Gm-Gg: ASbGncuQfbR9F3BSFN10vtAYfRVqp9Tt6gtJUhxYkdBZH4aSX6oknWoBNv0gOzsrepO
	ryCmvvimBOWop4XlrECnT4r+xZyKteDEOb9LFQm7NQDP6umTnWoeRVlj3zgQ0JZgNZixxi9D/KO
	qkG640kZWGx3N8HhoScwodPjP7rHBKS2gpMfMVsL4V9WBt1T+jJTa3jgcYyjsowtR/bPA=
X-Google-Smtp-Source: AGHT+IGTbWhP/8bCjLKFc+xQ5UOtSCO1oPELL/wgDD8ixi2TzBLinTpBoWavERvATIn8QDsvso1eJD1WxnXgyG+uqn4=
X-Received: by 2002:a05:6a21:3996:b0:218:59b:b2f4 with SMTP id
 adf61e73a8af0-21bad1ed9f9mr16343458637.42.1748947850766; Tue, 03 Jun 2025
 03:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-5-noltari@gmail.com>
 <5d3d04c0-d9e4-4f80-8ab3-7bedb81505b3@broadcom.com> <CAOiHx=nQiYs43oHXJpOhUn1dJ-tzD-TPdB22zcHFxjUBKXeVng@mail.gmail.com>
In-Reply-To: <CAOiHx=nQiYs43oHXJpOhUn1dJ-tzD-TPdB22zcHFxjUBKXeVng@mail.gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Tue, 3 Jun 2025 12:50:14 +0200
X-Gm-Features: AX0GCFuyiT_d8KNPW7k3g6jK43WaZrm7DEmW-LSpZjMyWBPw6tbzjqspbMpdzbU
Message-ID: <CAKR-sGfepgD7fKpG4H2fN4B1e7eVpmdv4r3hBH-XHKprNigVtA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

El lun, 2 jun 2025 a las 21:59, Jonas Gorski
(<jonas.gorski@gmail.com>) escribi=C3=B3:
>
> On Mon, Jun 2, 2025 at 8:06=E2=80=AFPM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
> >
> > On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > > BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FW=
D_EN.
> > >
> > > Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floo=
ds callback")
> > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > ---
> > >   drivers/net/dsa/b53/b53_common.c | 13 +++++++++----
> > >   drivers/net/dsa/b53/b53_regs.h   |  1 +
> > >   2 files changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b=
53_common.c
> > > index f314aeb81643..6b2ad82aa95f 100644
> > > --- a/drivers/net/dsa/b53/b53_common.c
> > > +++ b/drivers/net/dsa/b53/b53_common.c
> > > @@ -367,11 +367,16 @@ static void b53_set_forwarding(struct b53_devic=
e *dev, int enable)
> > >               b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
> > >       }
> > >
> > > -     /* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
> > > -      * frames should be flooded or not.
> > > -      */
> > >       b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
> > > -     mgmt |=3D B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
> > > +     if (is5325(dev)) {
> > > +             /* Enable IP multicast address scheme. */
> > > +             mgmt |=3D B53_IP_MCAST_25;
> > > +     } else {
> > > +             /* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide wh=
ether
> > > +              * frames should be flooded or not.
> > > +              */
> > > +             mgmt |=3D B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_=
EN;
> > > +     }
> > >       b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
>
> Since the only common thing is the register name, maybe it would make
> more sense to have the flow here
>
> if (is5325) {
>     enable IP_MULTICAST
> }  else {
>     enable DUMB_FWD_EN
>     enable {UC,MC,IPMC}_FWD_EN
> }

OK, then I will do that by merging this patch with #3.

>
> >
> > I don't think B53_IPM_MULTICAST_CTRL is a valid register offset within
> > B53_CTRL_PAGE, or elsewhere for that matter, do you have a datasheet
> > that says this exists?
>
> 5325E-DS14-R, page 83 (or 105 in pdf paging) on the top.
>
> Regards,
> Jonas

Best regards,
=C3=81lvaro.

