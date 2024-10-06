Return-Path: <netdev+bounces-132445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E472991C03
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011821F222D5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E057167D80;
	Sun,  6 Oct 2024 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv8VRefE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AE1662E7;
	Sun,  6 Oct 2024 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180455; cv=none; b=FrzsYfhWFosDN+FLhBPqof5GHhfjm8k/FhdpBVJqfLWFK4bh/SVxoe2tNYym5UmRB59EnueEGUDmAPoSn/q4sfvcscmyygF4mZCoILFtXJUPeEQ1ez5FlqYpiow6mYbBWcZpHDszxErCpArNXC82NWVJuK3H04DsqY6bSEFVd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180455; c=relaxed/simple;
	bh=DfHKlyGMMDSIEpyOpChzXkyr7d0SUJeFnkxyBlqeeUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ5DTX7G3QQhDaBdzLrsCa3lAFrW2uwOfXbM0fKHRkR88qV2M+RP4ocv+dFQlv2TsxWgL4Nx5Qd76wbUA2QT1rL4bG787B3bwHaPawH0ELYH2peTJV7dsHydaYMG3BgNUEPHcYoo2m9j/V6dSeEhbrkY7TfUhEDPnxbywKfo3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv8VRefE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2c4ffa006so18791217b3.3;
        Sat, 05 Oct 2024 19:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180449; x=1728785249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHfnHiUzEI/UKshaDa/FSlqT+xIZ/SlWDTUeS6ow6HU=;
        b=Kv8VRefEnrA02rEy+6uMj0cxyZ1RUGpE1X/i0SjjFv7onfZOogfv32RUmuCoySrFr8
         ZDGpv6/EdfeZ4yRL5BRaK2OraTLTvtOwKIH5RxlcYnQ/hEmis6nahfogEAKf+g8f/TrY
         EArJgioqQ0HATFcs9gBOs3R22BxP0Az9Aswzdfc+ap/+g8o5riV/nGXuJTM+5XdVQRVf
         WBUHJ9wfqu/1SgMcsYpDCpWhQZ4W2nlMP2iiIlnaf+HPVbe0kZoyEnzTSUJX6cTEP7Cm
         7FY9WSBlN0bT4qTimm4Ui65gSvOK4Lhg2kXhG8WuMvvPjSCAOsYRRC8gBiJvHyHrkYOS
         KRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180449; x=1728785249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHfnHiUzEI/UKshaDa/FSlqT+xIZ/SlWDTUeS6ow6HU=;
        b=cwX2Ibu+SkCtH0jY1RzAyln890xTF+mpQ9kJLuw4vocz9Bc+JnAUS/9qSbGcWnoe29
         5C+3HYa/2GfDqO8E3MNaW3DOfBjgj3QfzZJNUjsE2m8W7FYZJ3YXBE9pO/YIMdhNUHwx
         7/KfRtj53/Idf1jUFm9Yz7dRhcBycwD22FCCg6SWY+S/+jB6KfVdgThBegW9GuOM/SBm
         0unLDY9Jy/f2ojY56yGoaLKy7msIRs/9F4nQDggKk/ebU4Zj9iih8szJB7OB8qEUjXjz
         Xa2OMV6Mycrj0Q2nA8B27wV1A5Jcsg9gPPPm/o2rKkBIJtAmEkIASm7hSYjN3OAfnS1A
         8oMA==
X-Forwarded-Encrypted: i=1; AJvYcCX7nGNZyWM+fZ4hZegHmQ2moriIcEED7TSvNuUoKwH1PjOS4jtFB8fCQg+qQ3YCxIkK1Naf5zITg3lUmzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqatF2hyvW3NMUuxtTMR52dBq3YcGuIPD9A9PthzKwkjmNGy4s
	nBFEhjYDiL0EqTE0ua3B9SemdOCDWKu4eYiSz7MFTWusiRG+tGfEal1EoQHyFiq10wal1bPM9lt
	0mAp8peNFXbO1avVfp7W1jk6OaLG3jA==
X-Google-Smtp-Source: AGHT+IFJy+LgYQwq0nrgUHUwCAaoG2734k2vmpWFgGbVp6AkBTn2+tbxiFboZZB217Qqd6X6KcF27o7YDv5hX5H8pH8=
X-Received: by 2002:a05:690c:dd1:b0:643:92a8:ba00 with SMTP id
 00721157ae682-6e2c6e8b44amr68894507b3.0.1728180448829; Sat, 05 Oct 2024
 19:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006013937.948364-1-rosenp@gmail.com>
In-Reply-To: <20241006013937.948364-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 5 Oct 2024 19:07:17 -0700
Message-ID: <CAKxU2N9JGcU58Di5C9Ga_Xd91ywEyoZ1kC=kp8+R3kggx4vw2w@mail.gmail.com>
Subject: Re: [PATCH] net: bgmac: use devm for register_netdev
To: netdev@vger.kernel.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 6:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> Removes need to unregister in _remove.
>
> Tested on ASUS RT-N16. No change in behavior.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
yikes. I wanted this in net-next.
> ---
>  drivers/net/ethernet/broadcom/bgmac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet=
/broadcom/bgmac.c
> index 6ffdc4229407..2599ffe46e27 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1546,7 +1546,7 @@ int bgmac_enet_probe(struct bgmac *bgmac)
>
>         bgmac->in_init =3D false;
>
> -       err =3D register_netdev(bgmac->net_dev);
> +       err =3D devm_register_netdev(bgmac->dev, bgmac->net_dev);
>         if (err) {
>                 dev_err(bgmac->dev, "Cannot register net device\n");
>                 goto err_phy_disconnect;
> @@ -1568,7 +1568,6 @@ EXPORT_SYMBOL_GPL(bgmac_enet_probe);
>
>  void bgmac_enet_remove(struct bgmac *bgmac)
>  {
> -       unregister_netdev(bgmac->net_dev);
>         phy_disconnect(bgmac->net_dev->phydev);
>         netif_napi_del(&bgmac->napi);
>         bgmac_dma_free(bgmac);
> --
> 2.46.2
>

