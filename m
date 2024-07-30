Return-Path: <netdev+bounces-114276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13E942028
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD5B1C22C4E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E718A6C6;
	Tue, 30 Jul 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmQAVrwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13801AA3C6;
	Tue, 30 Jul 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365724; cv=none; b=l0tGMhyvPy+l1CASTYdjaIbt6nnd7QBnj3cos1ja/09FlWE7TiXB0erh6Er1ChgELgB3jpY15omZsKbUzI0RQmZyzjz58LyGy6qrBz3OPMV0/IqGULjjferSvfcdggNcmYyeKzryv1sJAQA3pWEmh14s9FSbNlimS2uZbX2f1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365724; c=relaxed/simple;
	bh=2dCsYnwkPXSeLC4b0QubMn/+6f2i/bESS5WxH91G0x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjOl4WlzpD5FhWdR11uoIGzxijk0KWd68f9+ognKAHJjRWGFAs5Wp1DgO5+ifCTTfQtrtimPAQIQgy8Kc/UA0lqQOkOM5qFH3OLLJfxzL21ptlFT1ZqOOUOrp+X6pzwVvHpnvMPP811g0woNjp1PKs73CHd1kXjPAs1uNqzTVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmQAVrwq; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso3551361276.0;
        Tue, 30 Jul 2024 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722365722; x=1722970522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dCsYnwkPXSeLC4b0QubMn/+6f2i/bESS5WxH91G0x0=;
        b=TmQAVrwqq5pXFsYEKafx0cPUpMCh2Nkvew5AjSwa5F89YDg1VPhi6WApOBJxIqBotf
         +or0A2k0XZ5oVsg6PeregZwb67/qoKuR5/O+7luhh0JTzAgUEz8xZV2c4GhEgx0H3DAp
         89AzkoUVOmWiD3PrGtBOrOxWdLxVY/dS5WF9JKh4r2TUZBfRVDjeOyARlk7PtpI0qF+D
         9WakrXGRTYkflllLC0W4YiD2gDnKN1TWepRmpsUWr8QWoOKh9A3fhMAniM771cvrs/24
         pd24SwklKvIaq80O9OPIzZZgyEWV4FHfsF3hc7Y1mqtbaP0CX5APbmFhXORy4QsfDZKr
         jSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365722; x=1722970522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dCsYnwkPXSeLC4b0QubMn/+6f2i/bESS5WxH91G0x0=;
        b=ue6uY9yVIkeqiCSaVMagEZeHcGYkTEJS6nBGZeHJK8UzTnemKVk9jxePEXYkwLGhyl
         cOld22p1SZeApeBUR1sOW7mq6vBCVtehRQJS0FwAJtS2yUpD7KqOs+eEQ8+h/gRUwTXW
         emlc1iSMzlEvcoP7nnUYAsoVKPdE9TtYMGS5emTW9/aFwg8j/Q7DpnLcMHukOaoGufOn
         FZqoAIIiu0VEMXcry1+ZhdeEcnn9h5SIZ3OFMPOxhEDctQM5az5VnT8OMsUAdEEbckAW
         OIJpZuRZ45ufal/oaQulAsjEvmBFRi+jer4MXtTvbFFK1Cszf4no6r4pO+5LJMeO0cAs
         RnRA==
X-Forwarded-Encrypted: i=1; AJvYcCV5evpyVPyH62GxOVZW5PFgr5FRqaSCdZephoJSfYtton2D9GCr1p5iCl448yKXmjtW38iE/43sCl9JqUTaIjv7BCsc6WLTzYu5s8N0
X-Gm-Message-State: AOJu0Yy923NvEx11zdYuKom3DcPHQRTPw9gp3uCxQh8mmxZoFP4q9SDW
	AGs5l9VIlvghP4exWJOtBlBIPbzVsR3GrjszoerJjGP1O80fja+Nz+1pyvSNHjS8g28HdgNo+74
	PTZ0sFayS5yoSHPKqDPE03Ok0p3k=
X-Google-Smtp-Source: AGHT+IGvA3MAl7nGobKWT1GG47gu2pKSHB96B4iZ1KpXmJ8bZ3AIHUGP8s5tylGtCTrHVZ+wkXScmdB7CN+JfY59L1w=
X-Received: by 2002:a05:6902:1445:b0:e0b:a7c1:9dcc with SMTP id
 3f1490d57ef6-e0ba7c1a1a3mr2041732276.20.1722365721796; Tue, 30 Jul 2024
 11:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-7-paweldembicki@gmail.com> <56335a76-7f71-4c70-9c4b-b7494009fa63@lunn.ch>
In-Reply-To: <56335a76-7f71-4c70-9c4b-b7494009fa63@lunn.ch>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Tue, 30 Jul 2024 20:55:10 +0200
Message-ID: <CAJN1KkzJrMV8uDU+Z5xdLSd56uUwLtX+wo1w-8YbNgg-w8GiPA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] net: dsa: vsc73xx: speed up mdio bus to max
 allowed value
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 30 lip 2024 o 01:10 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Mon, Jul 29, 2024 at 11:06:12PM +0200, Pawel Dembicki wrote:
> > According the datasheet, vsc73xx family max internal mdio bus speed is
> > 20MHz. It also allow to disable preamble.
> >
> > This commit sets mdio clock prescaler to minimal value and crop preambl=
e
> > to speed up mdio operations.
>
> Just checking...
>
> This has no effect on the external MDIO bus, correct. It has its own
> set of registers for the divider and to crop the preamble.

Yes. It's configured in a completely different subblock. Internal and
external mdio buses have symmetrical register set. It can be
configured separately.

--=20
Best regards,
Pawel Dembicki

