Return-Path: <netdev+bounces-121621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD8595DBF0
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3FFB217EF
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 05:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6014BF89;
	Sat, 24 Aug 2024 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUGhkOjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE441C6C;
	Sat, 24 Aug 2024 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724477017; cv=none; b=hRNFojGGIC6+cJ/zUWv7I1JPNPI3XS65Zy+Th2f/ruPGHZwrvrDq2rOzfgwoNR82tU4Rf9ADRpLmsj13tBEfAUXa+4USISQBV/K0eVT5md5B+p9ZObYlTd2yr9ufjXUxswLA8a0gq1m/m+xy/KiYnzeH4YKhaDUtn21Vqj+yxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724477017; c=relaxed/simple;
	bh=/iYod15BRbi6l20I0aW5glHzbzXso99DfI4MzxPHrf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt4oNTQHrsME5kNMV850Z01N789+PXHshvfjxJUTmfFbJM9bcDM6S0INusWtgJ60H0IYtp6dbhlr5GsRwRlCQEMsLLuO0oatACMYScGedo07dtTrtLuofTM+ym3Zxza0b3jcv49wxaxX3HP0EHTYfYkJefcM3XkQoWPE2J7ae48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUGhkOjc; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e16582cb9f9so2056836276.0;
        Fri, 23 Aug 2024 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724477015; x=1725081815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLk4f/ulSVBDj99KtdLT0XBurrxo6Qn61/1DzALA2nY=;
        b=BUGhkOjcWKj2zyTNns/I05cbybBfz9ScbYXSiKoTlbK9EHYY1IzjY/pXMZKjUoeRME
         IAQC12NKkaUEpvV87q057mB7bKCDQAsSvVV134gb3sznbDIwg+EZbAZaeBxdcz6L+yrm
         oyE3s81bBNQCwK2om65gKHSH5Pe7Ol5aE82hjxqCsoh5SxJUQGMiHLKw6UpuIunF6pus
         2zKzM6WKEdGWPNHOUwzjKZQrfrgb8dCeSBOKpq1b4MSnc4r+/UPqGDPDdxMiOuyN9yPk
         OeLIBWdF/DdPCbkEyNi76NkxxyV+scJLLj6kL8aJgDEQAubAiw/UWPOzBbAsBaKPPeCt
         gv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724477015; x=1725081815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLk4f/ulSVBDj99KtdLT0XBurrxo6Qn61/1DzALA2nY=;
        b=UZ9/NkSE9n8bQyRjJf0VV1gtDh+XeWSohqHPl004IEAVhoesmPhQyduALCCMFcISGd
         D1ck2h1eqqeSZeyk5zCnpSGIchOJFMFkv+hxr7deFUCIp2tuI/3vdMkos8y8yD+0ZrXr
         L/ew2zDR2UjuAbGF4d80OYXubIYhiwnmtxtKmycVNdgYprXRBkZGim2ptQRmhloJCNN9
         SLlxFx8tCdzND6SEKFqZTumtamIWOEZrcHrdchWmqhII53YCNFbDbI25AjMtJysdpNK6
         EXQ+NoYoO1oD3qCEt+G/RZdIQQb/FW1cRGnz0xhKUmquTMnGs4Ekp2aI9td61rKecfBj
         fd4w==
X-Forwarded-Encrypted: i=1; AJvYcCXouI+F8OPMvws/YqCPfmwtelX1dCOFiZEW7cHY45V4FLDVArfZaE7Nm+TOYVsPlaZ8Un4wI6uNkyFN6Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDc5s/irnp8mDUGNTFE/WJnPGGdD7o+goFK11eIJdaq7GSxIuR
	/OCvgar+KYBq0qjLIXU55rmUPOFr3SMqX6R1J7uO2Zy3X72na5gpPm79ZuSeM0pPjsjivncAaoO
	MBqAVF+TthC0Gf1u3CeoIeqiurRI=
X-Google-Smtp-Source: AGHT+IGm2eHnf1MlAoNMUkPz07UQTB9AmCRxv5oxUNi3LVRTuTYuST3fAZMkDbsCU2/ZXvEYCAXdi+OOID8C0PReLvk=
X-Received: by 2002:a25:8441:0:b0:e0b:de84:9764 with SMTP id
 3f1490d57ef6-e177652086amr8441652276.14.1724477015017; Fri, 23 Aug 2024
 22:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823200433.7542-1-rosenp@gmail.com> <ZslmB8RZo7z-uZQl@pengutronix.de>
In-Reply-To: <ZslmB8RZo7z-uZQl@pengutronix.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 23 Aug 2024 22:23:24 -0700
Message-ID: <CAKxU2N-Et8J8QkikD8j9GE05Gfp_utfgyuqiX5Hmh8R-OP5kqQ@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: ag71xx: add missing reset_control_put
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:48=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> Hi Rosen,
>
> On Fri, Aug 23, 2024 at 01:04:18PM -0700, Rosen Penev wrote:
> > The original downstream driver used devm instead of of. The latter
> > requires reset_control_put to be called in all return paths.
>
> At the moment of upstreaming this code, the original driver used
> of_reset_control_get_exclusive() and was fixed by f92bbdcc93 ("ath79:
> ag71xx-mdio: get reset control using devm api")
>
> Why not port the original fix?
On further review, this looks safe to do. Will submit tomorrow.
>
> Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

