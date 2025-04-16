Return-Path: <netdev+bounces-183208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318A4A8B67F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34C43A63D8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC323BCFD;
	Wed, 16 Apr 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ9aS4zl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02E1990A7;
	Wed, 16 Apr 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798373; cv=none; b=jd/kFY5qbZVXIMYaZMK/vJBnIFgJqV4Acs59NSQdhbtP+KXR9RIZsEsNpyeN8gCJUCeUInN9WSR0lNYe6+YOIGSmuNs7rPgNsMMyKTmHVHVkbHULESt0I8uuwkzjrY3C8GaPqow8oIwG9cEr4011OFopqeQlgT0R4NqdiNjhHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798373; c=relaxed/simple;
	bh=1r+Isg8f/c2kqwIlg8Ba9Y4smt7tLmBuV62Bq/vYutk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG5Rtscre29hpgEmISG/+3d4d3q+U6w9eDqD7BlTD+xVUdZhEUbEAGe0aP4mv9qHk6RIEB71FJVBCjMG6tlylTEJfkpNrfhnr1gqYgNyLUP/asCjRYCMH4JcoAaKBMCWS2lIHJEU7OTj91hGAu4LH9hGLak5KkBRtKnMEVRWU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ9aS4zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D649C4AF09;
	Wed, 16 Apr 2025 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744798372;
	bh=1r+Isg8f/c2kqwIlg8Ba9Y4smt7tLmBuV62Bq/vYutk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QJ9aS4zl2LqwkemHoYAzso857fBzAUNSaE8KeJUmdBmKMhXqQENmNmucsumJuPjHO
	 dgRAgpQx83FNn5qvPDEpmmsaNZbOs0ur977Y2uItIpvabg7IVjIDCkmfNglP/VMP3q
	 b0e+2JZCbmaC6bby2Ze4n0Wa2iKuZfMaaccxVNfikkBJ+J8qoDJtlFZuNwOSzSV+MZ
	 NIU323FH0ro4Hubfc+sPgvqbbQe24x18n6hQGbNv1skUcE6xZpnwO6LyKMXPQ4L8XF
	 lHv5F6E2EoR8plNFKSl6UpYQtO4fItIVkHlA/Z64XzSUJWYXfkbU7emnskSEgmOxwZ
	 5HaOz6wWXZbtw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2963dc379so1090618366b.2;
        Wed, 16 Apr 2025 03:12:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHAMsb00pWL/hVERLDr7nAwQwY0dQlf9ZEMhBdNWtqN65VP/Q5GwGQBSrFV/SKYHLjqzIF7VEGFJvgYFM=@vger.kernel.org, AJvYcCXSw5p7dA6I+RZhOB1Nl2uuuutgC3hbWh19JdDuuOH/VOI2XW3chON5dAeQYkdSX+QvhSaMbxh3@vger.kernel.org
X-Gm-Message-State: AOJu0YziFsTnw64I/UM5qi0Bk6S7kwhYngTWpGuN3MJiK/GAXukMtYFs
	9Av2edokbtRbcmKVh+vjinKN9LzNwPQ+RN9dRwwxywQ2PyeU/X+zHbBLUO4xr2J45aHJU9n8EC0
	TIX7gV28mUwR+T/48eY/EKM+b7Jk=
X-Google-Smtp-Source: AGHT+IFnykHuewB9jGPC8MTy0mT3ysEpGVlhBELN6aRyj+xNO4JcPP7XeoygaEGYkcdnPIyODv4sTvH79N/xLBixU6s=
X-Received: by 2002:a17:907:940c:b0:aca:e1ea:c5fc with SMTP id
 a640c23a62f3a-acb429dfb90mr103508966b.26.1744798371058; Wed, 16 Apr 2025
 03:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
 <20250415071128.3774235-2-chenhuacai@loongson.cn> <62da41f9-2891-4c63-94b4-83230cd7ddae@lunn.ch>
In-Reply-To: <62da41f9-2891-4c63-94b4-83230cd7ddae@lunn.ch>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 16 Apr 2025 18:12:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6QEBvQWDkJHxba=TRr_Y7L57gqcZYWE9p-SHkyX0S3kg@mail.gmail.com>
X-Gm-Features: ATxdqUHnZAVh76tz72EUYHX5B7mJ4VwADdODGjp8gFkVGJIDENyVL5GqxaiOAWA
Message-ID: <CAAhV-H6QEBvQWDkJHxba=TRr_Y7L57gqcZYWE9p-SHkyX0S3kg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: dwmac-loongson: Move queue
 number init to common function
To: Andrew Lunn <andrew@lunn.ch>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yanteng Si <si.yanteng@linux.dev>, 
	Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biao Dong <dongbiao@loongson.cn>, Baoqi Zhang <zhangbaoqi@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:49=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Apr 15, 2025 at 03:11:26PM +0800, Huacai Chen wrote:
> > Currently, the tx and rx queue number initialization is duplicated in
> > loongson_gmac_data() and loongson_gnet_data(), so move it to the common
> > function loongson_default_data().
> >
> > This is a preparation for later patches.
> >
> > Tested-by: Biao Dong <dongbiao@loongson.cn>
> > Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 39 +++++--------------
> >  1 file changed, 9 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dri=
vers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 1a93787056a7..f5fdef56da2c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -83,6 +83,9 @@ struct stmmac_pci_info {
> >  static void loongson_default_data(struct pci_dev *pdev,
> >                                 struct plat_stmmacenet_data *plat)
> >  {
> > +     int i;
> > +     struct loongson_data *ld =3D plat->bsp_priv;
>
> Reverse Christmas tree please. Longest first, shortest last.
OK, I think it is better to move "int i" to the for-loop.

Huacai

>
>     Andrew
>
> ---
> pw-bot: cr
>
>

