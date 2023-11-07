Return-Path: <netdev+bounces-46446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541387E4147
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5380D1C209F3
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6C30D0C;
	Tue,  7 Nov 2023 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAXNPXkL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8999182C8
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 13:55:13 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55710FD
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 05:55:12 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f6efd64so7033095e87.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 05:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699365310; x=1699970110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/3ePFEPzKQWOM3nOSX/yJ6R3zGL0DsR9CwluQIWSUA=;
        b=JAXNPXkLy+DjDu3V+ygMQ07tIqiRV6FuoXH+ZBIcYOcpd4Bbbrqqyp40vmu3z20Tat
         0NyU9VIuAw4zrE+E4VNHukyoRzbfMlsz5TDJxM4WYrgxpXnfsHnrR33zGBn4XxlODbns
         OgHv8PFeoFuujxanX+AIKkZOl+hciTpJalscq5wJEhJycX7eboVFnOS8IIE3cohLlAIi
         iNUduoVbZbuyajgcip+iFrJTPmjGRILv0k3YvqBoHG0qiO/WcOCRLh2Spse7WMaGTE6s
         9/mknsN1+bvWrjKEk5xFLup6xmhOnAuttFdSbjSURuj18QIWhelN/Mhygb6YOZShzh6m
         yGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699365310; x=1699970110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/3ePFEPzKQWOM3nOSX/yJ6R3zGL0DsR9CwluQIWSUA=;
        b=q+b/o8Xl7Kulzp1iXSAk8p2c1VDdnjKwyhPeHC6vDCG8M1Ok+XuSjLnE3wibgHL6KN
         H6X9ppYMOMUzDqwQYm3dbsP1tqr/rckcBJhyky7rH+wEAEc2aubS59BFL4TOQopjB8O4
         pTibmjapHxr2MiDoJdEo9LohQZyK26DwxaU0opWNrMHLQdUEKMB8cHAdZdHQ6tDas2BW
         xPWOMkWOGhDWrslYT/IpEvbLDNqZM8YiL4fzacFGBpd447nVhArIO/Otb5O41h1eFa8t
         FkkKeRixGcZWXNj/5vEZ5hwApGdLUa4GzxIJjd9rHzbhPeaDLlTR6YpQ+V1RZG2H+7WK
         +ejQ==
X-Gm-Message-State: AOJu0YxTeZ7JI886uJ47joFVq6T77UNuLztMCQbaKWnc+XuspGGgONyq
	LL40/yIDGdz4AVBLdTWioJ6qayvO4LR1GwdtBYs=
X-Google-Smtp-Source: AGHT+IE0lDOGqWnY5/Dp21jIBsj7GHx6gwQkrqcwfVNx3qqxklbu+FAoTfobUWwn/frNUhKJQiCEJK1morasBTY4GqA=
X-Received: by 2002:a05:6512:3582:b0:505:9872:7a16 with SMTP id
 m2-20020a056512358200b0050598727a16mr22137256lfr.49.1699365310221; Tue, 07
 Nov 2023 05:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf> <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>
 <20231102155521.2yo5qpugdhkjy22x@skbuf> <CAJq09z5muf01d1gDAP9kcsxC9-V3sbmyqTok=FPOqLXfZB9gNw@mail.gmail.com>
 <CACRpkdaBC7GeeGYoZ+CYjSVV657yFm=B2L6U2mNyh+AVsLbnsA@mail.gmail.com>
In-Reply-To: <CACRpkdaBC7GeeGYoZ+CYjSVV657yFm=B2L6U2mNyh+AVsLbnsA@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 7 Nov 2023 10:54:58 -0300
Message-ID: <CAJq09z6_nVvXsvL0KD9fYNELNkdFg+_dM95Umb4hJgrUP3H-5A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> > Your proposed Kconfig does not attempt to avoid a realtek-interface
> > without both interfaces or without support for both switch families.
> > Is it possible in Kconfig to force it to, at least, select one of the
> > interfaces and one of the switches? Is it okay to leave it
> > unconstrained?
>
> Can't you just remove the help text under
> NET_DSA_REALTEK_INTERFACE so it becomes a hidden
> option? The other options just select it anyway.

Without a text after the tristate, it will already be hidden. However,
we can still ask to build a module with no SMI and MDIO.

> > If merging the modules is the accepted solution, it makes me wonder if
> > rtl8365mb.ko and rtl8366.ko should get merged as well into a single
> > realtek-switch.ko. They are a hard dependency for realtek-interface.ko
> > (previously on each interface module). If the kernel is custom-built,
> > it would still be possible to exclude one switch family at build time.
>
> That's not a good idea, because we want to be able to load
> a single module into the kernel to support a single switch
> family at runtime. If you have a kernel that boots on several
> systems and some of them have one of the switches and
> some of them have another switch, I think you see the problem
> with this approach.

We already have this situation. As the interface module uses
rtl8366rb_variant and rtl8365mb_variant, we cannot select one or the
other at runtime.

rtl8365mb              14802  1 realtek_smi
rtl8366                20870  1 realtek_smi
tag_rtl4_a              1522  1

If we build it with support for both switches, both modules need to be
loaded together.

Somehow initializing the switch selectively autoloads the tag module.
Is it possible to have something like this for subdrivers?

> > I'll use these modules in OpenWrt, which builds a single kernel for a
> > bunch of devices. Is there a way to weakly depend on a module,
> > allowing the system to load only a single subdriver? Is it worth it?
>
> Last time I looked actually having DSA:s as loadable modules
> didn't work so well, so they are all compiled in. In OpenWrt
> I didn't find any DSA modules packaged as modules. But maybe
> I didn't try hard enough. IIRC the problem is that it needs to
> also have a tag module (for NET_DSA_TAG_*) and that didn't
> modularize so well.

It does work, even the tag module. As I mentioned, the tag modules are
even loaded on demand. You just need to load it in the correct
sequence.

>
> Yours,
> Linus Walleij

