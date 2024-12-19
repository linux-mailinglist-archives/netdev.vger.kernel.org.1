Return-Path: <netdev+bounces-153409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16F9F7DCE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3F61629EE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B4225784;
	Thu, 19 Dec 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpFg9ObS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CAF41C64;
	Thu, 19 Dec 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621257; cv=none; b=hs7II/JHfcqzUyIQqbaonqNPaREd7qC+Rs3uRsxstBuKp/r8P3qxwygmsXW33QqS18qswn1dSXsS7FO/8gGdXgbVjAPvYm/SvS+Mybt48SAsmmT6wabTtOmkI7ibAPdQykJc2epxMrwhC1luRMZIjoiEkrerG+uhhxZg1ubeSp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621257; c=relaxed/simple;
	bh=lmQB6ZImK2UMRsAhsCHDt9W1HPsGOTifgLSoKJRzUao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxOHU/uv/+B/ON0QDQLmCUiy69SlCrx7qCOjp40gE8GnqvW5sRCLlt6AokCiB9Wvft7pucBaw5HbExoR8VdblNMoJ4FYjIsx8AV0Rgl7TD5Cn+nXBY3xTvtB3CkWCB7AXVfITCHEMJQGDiHOtSjv9TyF6KFFnsluDk9JNLV55Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpFg9ObS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso1577249a12.3;
        Thu, 19 Dec 2024 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734621254; x=1735226054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE+gvEw/fT7toeK0Wn7EsKMrAhVGbItWCmR6ayk++sU=;
        b=SpFg9ObSOP1frzcqzsldfX++CItbtlag+dX7smyJ44JioK9OC6XfsnngTDTihXw41e
         zjxU/qn49VdIHPdJkae/ouRiD/7f/0FE+SvkFm0r4G+Dq7qiEbAqsZ7nqCH6K9DFla3z
         RCiXZRvutD9s50T2gvY+XMdz7RmqroZ76bfam+YFYw8ZTLbA7HLjJA/C5q2rL25L7I6x
         hAFW0ZSvgDTzE1ijKssanyiBJYO82pwJs/0qLBPjEO7jhtRTnqqBcVjBL/xoUPjfn8cf
         EtzvUENg0IjSOcDEjgE4FJbYOKa8CjOqEcu62DT6kAkRmsZb6WuIZFmd9eMPJD3o+Bm8
         PM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734621254; x=1735226054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE+gvEw/fT7toeK0Wn7EsKMrAhVGbItWCmR6ayk++sU=;
        b=cO8SYSGnfhV5dfKO+YZwtixTaJr8jEbjRuk6yTZCSFVfp+IMKcj0cz6SNTdRvMxbv6
         I1ZTXvpis3dJ6RgOYhTO9eprgBr3McETHPmrLX8i1xsv7MJ82anJcf16TcPBd5HhCxrG
         ckMZ+kKm0cQL6AQpw/Z7WsDjUWvmkrEuQ7HfIeyvywgQorT8699L6zf9DyGOBkVzoEfH
         3c0OI80RDBoL13hC2My9LiLtuieQq+CdiYd5KOYy3YMMV7tHGSQwVexiE55TVrcsIvFI
         HyGS4ookKskj4Ujox60L2Yt8ogCx830RMyiLI0fuphRZRMl8cT4gt6gpz+qNedtQo4gF
         Wrlw==
X-Forwarded-Encrypted: i=1; AJvYcCVg+Dzie91Q7WpMFL5rXUnoTXXcptKBFsKU8n+UZZ4LTk2skb77gDq/D/PwMuhRoixEjYYi/p7B0AU=@vger.kernel.org, AJvYcCXNpWfXFq3MxYX0D9HIr0jacup9jdt4q6BbQhQz/I3p2yR5dB4Q2SQMyBl9BTUSA5EvhZyNCEJc@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0gE9o1zSC/QXBoLpGoWG6YXtG2MlIkI5m/ozIexZPi/Bxcec
	JxQDUElTNt0Up6EdQxrH7Vb64YX/+XoCl4RPd9gw6T42Nw1t/ADnLs4Mz8AHW8pU0uhvxw4uaYo
	E3R9NYyHRqxqLYLpNQOq9lrsqT1s=
X-Gm-Gg: ASbGncvZerBroTiFQR2bIOlqFQgPpf6cPyY6Dd2lBocHD4LT4gANVi1x/+TlggHOiLU
	6qn+mkeW9Hx/L+QShGx8CUuBhN8PCIJFAU0ZttqA=
X-Google-Smtp-Source: AGHT+IFLoYAYxtFOQGp9bUCzx/j78L2g4AATrA7ieG2lh/+k7wCxeq+giYsgTyqf5JURsqnZqKkf8Mpe8l93hUb4AOI=
X-Received: by 2002:a05:6402:5109:b0:5cf:a1c1:5289 with SMTP id
 4fb4d7f45d1cf-5d7ee3ff16cmr5491845a12.21.1734621253481; Thu, 19 Dec 2024
 07:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-4-ap420073@gmail.com>
 <20241218182547.177d83f8@kernel.org> <CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
 <20241219062942.0d84d992@kernel.org>
In-Reply-To: <20241219062942.0d84d992@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 20 Dec 2024 00:14:01 +0900
Message-ID: <CAMArcTUToUPUceEFd0Xh_JL8kVZOX=rTarpy1iOAD5KvRWP5Fg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 19 Dec 2024 23:05:30 +0900 Taehee Yoo wrote:
> > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > > index f88b641533fc..1bfff7f29310 100644
> > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > > @@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struc=
t bpf_prog *prog)
> > > >                           bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
> > > >               return -EOPNOTSUPP;
> > > >       }
> > > > +     if (prog && bp->flags & BNXT_FLAG_HDS) {
> > > > +             netdev_warn(dev, "XDP is disallowed when HDS is enabl=
ed.\n");
> > > > +             return -EOPNOTSUPP;
> > > > +     }
> > >
> > > And this check should also live in the core, now that core has access
> > > to dev->ethtool->hds_config ? I think you can add this check to the
> > > core in the same patch as the chunk referred to above.
> >
> > The bnxt_en disallows setting up both single and multi buffer XDP, but =
core
> > checks only single buffer XDP. So, if multi buffer XDP is attaching to
> > the bnxt_en driver when HDS is enabled, the core can't filter it.
>
> Hm. Did you find this in the code, or did Broadcom folks suggest it?
> AFAICT bnxt supports multi-buf XDP. Is there something in the code
> that special-cases aggregation but doesn't work for pure HDS?

There were some comments about HDS with XDP in the following thread.
https://lore.kernel.org/netdev/20241022162359.2713094-1-ap420073@gmail.com/=
T/
I may misunderstand reviews from Broadcom folks.

