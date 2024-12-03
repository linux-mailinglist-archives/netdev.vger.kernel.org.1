Return-Path: <netdev+bounces-148710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E99E2FB2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5443EB27B85
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5231DFE37;
	Tue,  3 Dec 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxN8FPVL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635716DC28;
	Tue,  3 Dec 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265159; cv=none; b=O14FruVEcrka5MvbdntigbZojM100VvlbwbED0R12mIOahjofwR3lWZqOOL8k5i7fMJJKYBxAJyXj86NLBArTu54AmgxnB36Ksa0P+C4enxfltXB5/e7NUCG6SSf9/CBp/07pk0R0nEM28HzPQQLcadsXHzmtt3NVJnXF9ueHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265159; c=relaxed/simple;
	bh=/bBqnTfrh3T7UDYQTvCzK5mOHnVENziHCGIZsA8YP3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQzEudoX7oCzmtuYvKm4T9W+eYa7knj8LA1JsTmKeY7dizcLXOLVXwegQ052PrYjeh87U6VS4x2NP/GDXzrTLrDrHWfy5uNKOzaSgp1mldEhjVL0fPg/EKwMV8DQaHiooDKSvnr70fj+OibnlgzxO6bU1Ny0HtsZ7nJVdF52s8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxN8FPVL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef4084df4cso54534267b3.1;
        Tue, 03 Dec 2024 14:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265157; x=1733869957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3uXVixO2HYoTxZ+HwXw2HKm344cdNU9MSG32y7b4Qk=;
        b=UxN8FPVLN/knMCNlGw4K5rX+1yfNgOGIXHXgi0KT+2soZ4p+NTNVlrh2SeSfJO8qGG
         1vbQ0w1ndZbxMjEE2XTUYz8LvBYDqc+9Am6GzT4PA/qS4tnIFI4fspoCd3zgqczY6bRg
         Mx5VQe1xQGOZMi5mmGmi8cJjhI3eSH2MxxI/5C+Se6lH9K0tUtLWcdufMatcYVoQfhUN
         cScSeXrxWvhzNrhLDqay5dbMaNTqstDxYIjZax2tNzGz6w2vVth0fnaB8J50QhxU5f+j
         dMYDSZVoWk+0Wb4QZaQCKW4rEzYSmTZQLrNU21ZSFLy9GwtpjrmpclGk1D3W+wg4vx4T
         jPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265157; x=1733869957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3uXVixO2HYoTxZ+HwXw2HKm344cdNU9MSG32y7b4Qk=;
        b=tDVu/7L6jXDqX8JBkLJONQ4KG3Z5yZrJyoXT5bUzpOUFzb8fbUN1RtlOVHTvdoInnS
         2EPVeY9y6jfNmTWLUkcdrZM0Xrkx1JAvjuejTFHWP2zUOQdx7x3hHSMAvT2UfnOelBoe
         Ai4nKHdq0oQXv6XbXYq7VsqyVNxTd0uIhdRDcEVpUeKv6xRTbNi3Rlj8P/t8Esy97rcc
         54IW064lRSC4KJNbuIiny0YajmYZ5oJ03P9RvcRp28tVRhliFpf8nQ19jwqqVK33Poc2
         GDPYQpK3bOlO2X5jZe51SVvpLCLqlW6X5f4vkF5YEFY/t4+gE7Obobwi6OnbOMBYbwcf
         MbCw==
X-Forwarded-Encrypted: i=1; AJvYcCWu41vo96f0nJwdfSKmkawB0tO/qMrB32zvZvRxiypM/+DhT0rfjxXbrwdwFEOpz6W3oM63FspFJhaw1bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMO6nI78b4HyEhWnKEc1g6TNabt8cwC2NfVJacKxeqQbT1CxL
	e+eQf0n4ndnAt3tE7Dchqk7akNZfloQetNlGO6lSO8i6jUDx7orltzJ8m2ByykKgFdqG1xsXtts
	V3wtjfXeEPnljjV1mywDew25rSFU=
X-Gm-Gg: ASbGnctIg4f/aL8eC10Jof5mIHuFqmH347fgfaXRj2f1F3twYv5Dc4V56ZvwBeTGyCB
	eJy46LPuSmjDiI+Ml9SFI3Vz8zAONtJAmIF6uQoudRxaS
X-Google-Smtp-Source: AGHT+IHdKPso0Q9UeLbszX084lHd/YkUoSrjxk6qabI3sAwyinBHwJSP95gkdk4ZVgLbdT+D1Gkwjcw7xohft4UO+2I=
X-Received: by 2002:a05:690c:450f:b0:6ef:6178:404a with SMTP id
 00721157ae682-6efad2d997dmr52558727b3.33.1733265157005; Tue, 03 Dec 2024
 14:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203221644.136104-1-rosenp@gmail.com> <20241203221644.136104-2-rosenp@gmail.com>
 <50e1ec4d-818c-45a8-875b-40f74cca1514@gmail.com>
In-Reply-To: <50e1ec4d-818c-45a8-875b-40f74cca1514@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 3 Dec 2024 14:32:26 -0800
Message-ID: <CAKxU2N_D1vjhfdX=ou2S+rfabe5nM9i=Q6YYYigLJMN3t9JS0g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: mdio-ipq8064: use platform_get_resource
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, ansuelsmth@gmail.com, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:27=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 03.12.2024 23:16, Rosen Penev wrote:
> > There's no need to get the of_node explicitly. platform_get_resource
> > already does this.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/mdio/mdio-ipq8064.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ip=
q8064.c
> > index 6253a9ab8b69..e3d311ce3810 100644
> > --- a/drivers/net/mdio/mdio-ipq8064.c
> > +++ b/drivers/net/mdio/mdio-ipq8064.c
> > @@ -111,15 +111,16 @@ ipq8064_mdio_probe(struct platform_device *pdev)
> >  {
> >       struct device_node *np =3D pdev->dev.of_node;
> >       struct ipq8064_mdio *priv;
> > -     struct resource res;
> > +     struct resource *res;
> >       struct mii_bus *bus;
> >       void __iomem *base;
> >       int ret;
> >
> > -     if (of_address_to_resource(np, 0, &res))
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> >               return -ENOMEM;
> >
> > -     base =3D devm_ioremap(&pdev->dev, res.start, resource_size(&res))=
;
> > +     base =3D devm_ioremap(&pdev->dev, res->start, resource_size(res))=
;
> >       if (!base)
> >               return -ENOMEM;
> >
>
> Why not directly switching to devm_platform_get_and_ioremap_resource()?
Because that is not the same.

devm_platform_get_and_ioremap_resource is

platform_get_resource + request_memory_region + ioremap

The issue here is the second. This driver (well, platform really) uses
overlapping memory regions and so request_memory_region will fail.

