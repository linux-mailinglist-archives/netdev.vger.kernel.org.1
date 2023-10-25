Return-Path: <netdev+bounces-44060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBF7D5F65
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F4C281800
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F471386;
	Wed, 25 Oct 2023 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOQy3hTY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89C1369;
	Wed, 25 Oct 2023 01:11:19 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABEF99;
	Tue, 24 Oct 2023 18:11:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so77734481fa.1;
        Tue, 24 Oct 2023 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698196277; x=1698801077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldUvlikD+5XIQmvxpKaHp5+smB/6w0kvFDnKHFQsOQA=;
        b=bOQy3hTY9gp1y8rUwuz3yLC5X/Podrvmt1sfqb7GRWjmszBzoZzc7oTyIIMnOeZfvH
         iv4lQThw5xpwYYUgCiOXbjozi8PyToFBxYJ0IkCagRpxq16h3H3062RmDb86DVdU5NeL
         bVrQOjx4ymaSRjQch9feh41OxvpW1j3T8AvrFVg/mDC/eEcAE6evPQFqks7I3epfoTRV
         EmYG5Sb49kUIefVn40K3oYce7MYFmbbeayEB06287f5YOfkgUsMNz9xqOWNuU/IXI5MH
         gY6rOmiRqOeu+AE43vxaGws2ChM528tKEWfb7eOiSI8QqzIWwe/q4e7S98ZWZIb79AZN
         m6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698196277; x=1698801077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldUvlikD+5XIQmvxpKaHp5+smB/6w0kvFDnKHFQsOQA=;
        b=Vs0ACgEBLqqSN13LyA7e0eSq7eG+reusNV5EKDm+JsQqsylVwpu1aerlQM/Oa98v2A
         mk6fcZXmhKZRWQXS63x54aJF7+BoIklJB5HV3o0GyhO8Tfm2C7aYKTWVaTMAgeB/MH3L
         cS9Nvh3zbYAw0rzTYVSczl4kjzSc4WC7NMJcEQXmG9+kW91OtTA+rYKFoFRJfSi4sHNQ
         CRjyWb+1575tnn97IAvdEskHXuoaKOGKYXNupYdLlGb77yRCcjyrMRA0KsyJDhNqCiiq
         p0Q6SYIgAWJUi8a9Pm5Nuc98dDaFrLezBiYaYhvPkQz7/H5gxkdbAOMvEdCeiVJYuop1
         cY/w==
X-Gm-Message-State: AOJu0Yw1bCFHER9wvMJz2xUuzyjX2cty5nTIIeCkELz3fJZqxw4PgoYx
	0+qb75nzxkKL16lwlGQLvCg=
X-Google-Smtp-Source: AGHT+IEYw8DnBjtFxl4QoC6GJSt+6+Mp5KWJ8eKGMucEKHdCmqSlKHUfZO+2gnsvMIAxpN1xD9KF9w==
X-Received: by 2002:a2e:b04b:0:b0:2c5:1b01:b67f with SMTP id d11-20020a2eb04b000000b002c51b01b67fmr9406239ljl.52.1698196276499;
        Tue, 24 Oct 2023 18:11:16 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040836519dd9sm13261355wmo.25.2023.10.24.18.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 18:11:16 -0700 (PDT)
Date: Wed, 25 Oct 2023 04:11:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231025011113.lycdzy7vxazaargx@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
 <20231019144021.ksymhjpvawv42vhj@skbuf>
 <20231019144935.3wrnqyipiq3vkxb7@skbuf>
 <20231019172649.784a60d4@dellmb>
 <20231019162232.5iykxtlcezekc2uz@skbuf>
 <CACRpkdam5UZWbB_tAKoU3_jdZLbH0TFT3yt3Xf9G1b=_42e4zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdam5UZWbB_tAKoU3_jdZLbH0TFT3yt3Xf9G1b=_42e4zQ@mail.gmail.com>

On Fri, Oct 20, 2023 at 02:59:43PM +0200, Linus Walleij wrote:
> On Thu, Oct 19, 2023 at 6:22 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Thu, Oct 19, 2023 at 05:26:49PM +0200, Marek Behún wrote:
> > > Yes, unfortunately changing that node name will break booting.
> > >
> > > Maybe we could add a comment into the DTS to describe this unfortunate
> > > state of things? :)
> >
> > Well, the fact that Linus didn't notice means that there are insufficient
> > signals currently, so I guess a more explicit comment would help. Could
> > you prepare a patch?
> 
> I can just include a blurb in my patch so we don't get colliding
> changes.

Colliding with what, if you shouldn't change the node names?

