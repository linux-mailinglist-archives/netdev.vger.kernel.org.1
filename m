Return-Path: <netdev+bounces-193520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8595CAC44D5
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E3F7ACF9B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE6212B0C;
	Mon, 26 May 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l551sFee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41CB14830A;
	Mon, 26 May 2025 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295137; cv=none; b=qCFs0eo2vQh3Fv0ODoZEE49vJRo/WrcUzyPUuVIglifUhYC6jP77JeyKgwwQXpbRLpNCgtG0KrT6Vwo1x+fjKvPO0XHSPzZzXP07X7FVARHT1/QpQmqp5wXo50yCjRQLeTRfDjNCg+vm5zR39NcOvOmBCKeraodSA8XUbq4cEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295137; c=relaxed/simple;
	bh=8SuyawwOzMJT3mItihnlzI4S/30pK5tVEVFGLgLFAdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjRq+Y15vurv8Hf2LjshO+KYWglMzFm65JG0fIxnMxc2xx1Hp+cRg4I2prdkuuwckn2J4ORn1J7Ncov07s5TXOj6caUQsagKX+QdqGXebyB6sX/pD1/efoNamj9sP9cafEdQpoP2rlTz2a10nfLa1ZUvle+pK3TsKqvCfW/wupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l551sFee; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52f05bb975bso446776e0c.1;
        Mon, 26 May 2025 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748295134; x=1748899934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzpV9AN34TI6kAQfSgmCAMHhHbvNRBBzplgVftxgPoc=;
        b=l551sFeeQCvZln4vZa2M7HlO8t8SdWNXY1T2IBYA/p7zBaYAgadrZdp0hkA/cpEjTM
         9K0N9eqSsSnJAmQ4/vhKgudCl6ydSMCIEDLbsf4GlsSw/LBURLq13Zv7JAND9cq3G45U
         st4OobiLOJfb6XC1/TWSXe9mQPwet0RNlIm91nEy1SI9bBRrQGC60WSJfyxY7TTjUQUH
         AGCIw/e6xuR1FYIhEOC6QRDTY3D7Rgdx/gbxQJi6HrYh6b67/a34oVutYG2paq41hDrt
         +qXxdpmF7O+RCRz3k1P7M/h1inHsaoEyudIXJgjbvKO06ioqGeqlX39R9phD2pMkh2pp
         KW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748295134; x=1748899934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzpV9AN34TI6kAQfSgmCAMHhHbvNRBBzplgVftxgPoc=;
        b=bNH1f3aNPVBh8DbC4cxL4pLkpZyY382e8fbSpLFBtdM7y8QXQH1RrnNiKpYgzxOVXL
         9gXj63+hK0A96zWZ2g79GstVx/sgDmTuZT7U39RVG0Op0pbbmoQnheaEKKT8+YSZUVlP
         Eb7Ub+iX978HdVPDdhE6NyzXZMB76ODzQEDT504oXzo4lRyhO3aSDRNnwnayJsejid/G
         cSO/rXgkEbbU6ySpgyQsWEQRMTXPiRn6zz/bdNEmHDYWC9+sPfs/9W5M6S6/oFd3bmXI
         Md2SkUUj8AiVDRARGVf/u5fuCps/K1hyDQOhzix6Qux0jk4Z4qTU9o0ydssqN5X6U+fE
         T26Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFWXwImPHtQV4fuk0rnlR5rNU6BCNr35Wz/uOtB7pINIuXeds3MWapXcVhpNbkxdHj0X9EiQGNb/MT@vger.kernel.org, AJvYcCUuVCqY0sWHG9zhAyw/TH+dk0HWBaez5z64crVzLRtLNOjoVEnQuZ3/b2/matD+H7+ceQuBDztp11hPB4jK@vger.kernel.org
X-Gm-Message-State: AOJu0YzR41s8WQuBw6L4yg7qt4u4eYiaqz7SBcjLezP2bkksSM0piOvB
	7krZ7vDFnuZvxUsh6HAZbGEXGvowMAHHhUxieUYgX+8vTfC10jXuiL9ZFl/tYAu25bk6uRB5py1
	2hx1Acm+MCqSolGMOFWGTFxw9I/wUjyk=
X-Gm-Gg: ASbGncues6eD95dSycjwxbJBI3e12XQCCywbB63QSr7zhWiucONLN7JhnK/cerGExog
	JsAUwzkqAAVQzychXcp2ayEO02zSq+fh83yJkj8gPb4D/sYhwGye+LYKTweYZoazinImxT909zD
	oX7CFGdvNE2dnSPpFNHNKG9U2F7PJyAo5u/Q==
X-Google-Smtp-Source: AGHT+IHtZAC8edhOL+psA4G3fkxBszlG+/mcFK1gxSVp7v4PGsINYvWQPIQCRIQn2+sMGuqIUnNiH1ypKvmk5wpNu3w=
X-Received: by 2002:a05:6122:a23:b0:520:3536:feb5 with SMTP id
 71dfb90a1353d-52f2c5ab85emr8028797e0c.11.1748295134606; Mon, 26 May 2025
 14:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com> <959e576e-bf36-4d01-9ffb-023931b61574@lunn.ch>
In-Reply-To: <959e576e-bf36-4d01-9ffb-023931b61574@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 15:32:03 -0600
X-Gm-Features: AX0GCFv9rmZ8vY8FFbnP0lrSecl40feRLs3yqUdAEeCO8w03J4KjSgCY4nGuva0
Message-ID: <CADvTj4oqjCkMeK0p8ZBa8PQmctc77hpiFK2pqgBJaxRFDgQoDQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:36=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +        phy-mode =3D "rgmii";
>
> Does the PCB have extra long clock lines?

I'm not sure, it's a copackaged(maybe on-die is the wrong terminology)
PHY I think so I assume the clock lines are internal, in the device specifi=
c
dts we set something like this on the emac1 node:
allwinner,rx-delay-ps =3D <3100>;
allwinner,tx-delay-ps =3D <700>;

There's some more info here on the AC300:
https://lore.kernel.org/lkml/20200416185758.1388148-1-jernej.skrabec@siol.n=
et/

>
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bi=
ndings/net/ethernet-controller.yaml#L287
>
>         Andrew

