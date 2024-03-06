Return-Path: <netdev+bounces-78073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5E873FEA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A224D1F26101
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6713DB8C;
	Wed,  6 Mar 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtKmG9gl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97F13BAF5
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750821; cv=none; b=pzPhbyOJJaHZoGdPMWetu5dc47t2fsWNBL7EhQAGbdaWIBoliBtRwqntl3hjimvrwmFbMHDpSEVKhxOvYTYoerJZWfD2wk5xJKWgGmPoSxPSGSIHBg7T/aXmCiXDCQ5r+3PUKl1NfADRlaBqqaUoKZCA+YOJer2dmHfspkzIQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750821; c=relaxed/simple;
	bh=kTYuxtfUD2QmfeyUk7cXkobb5wJLRuu/K1Ka7sZHiGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC+keY/x+Rafag/FtBnTjBAgWLnvy/xaI/R0H76tc20IEYxG5wZ1Vf4vPDad/Fu3UItsxLaGDkfLFKXSdlXiQ4SXnnmWAZXmR3w0hxrdBtAb31PbMA2C6qROQQ7PbPu+Hfo5Wny8X0MjKHs7200+vZiYVfMLWovpqkeR2uOUSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtKmG9gl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a452877ddcaso11324166b.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709750817; x=1710355617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTYuxtfUD2QmfeyUk7cXkobb5wJLRuu/K1Ka7sZHiGo=;
        b=JtKmG9gls3hps5Js9nOS3eTJaN6Pan9eCrV1eKhilDyHpnS7x7rh2qRFntA3sEHiBs
         Io1xfiiBQZG/2hU58VgWeOVavoN3GX9Sl9dxd29IMbrl23Xh7VsQfCzPK26j9JiASn04
         aLhJGQF2NXbZABfthWXEXchENI2fdGNGh/dA1cYSxfHfDzVm8JTY/EXizlMs9xotPsj0
         48mOoyLGE440Mu/AxrmqSrQUbpOKqN5K/9/Y3vbeMrA0LEIh93GsApuS4y1FJCjjcEMx
         USs2yM4x8XA+1YYPVurOuWOjqY4IiCUY/TWtXpfsCkMMpzZ/O19dLat7+bN7eSqBLsMU
         Rxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750817; x=1710355617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTYuxtfUD2QmfeyUk7cXkobb5wJLRuu/K1Ka7sZHiGo=;
        b=whKxGUMACuDlZu9EtImthDQQum11NmBiUpYYWubXIsDpuKuldk2hjFXLtCYxxNDZLs
         qO8hcrp7bpJRrZtkdaC/KHYk5I8Cyh9nbgqHTTz7YLoV6lhOYCxi+S1GWiFoy1oWBj6A
         t3vPOcAnyIiCU6hIZ0pI3tvOCjuhXiSgIo+9zA57vjLqH1sj4N1+yV9nQ0SmDunyZ01X
         Qs7WzmsQjQfPdU01DOFNwpUpJldBVzrMRMGQ3fmdodiD1Zvdtk2jbLOmT3XlJwDWD1bH
         0RLxVrb4vRn4iLcQNPpxesiMCQB/wmrMJLsd9ybGPPIcnee5dI5LjgVzN+rlb7+6p0a2
         iqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRj5sesGcmhYXVvPKd6VNmTh3A38W7HdIpiwVF1Hn8qof0tpBIT903kQv5ZjLgUR3wB4yppHCO3Zgxm1wIWOEEQ1LGPlxY
X-Gm-Message-State: AOJu0Yw5JMnrHzaDVOKACvPCluwVbRz/h1xJyfTdO8snYTPbZqF7atF0
	U2T/EHx9B78LP4O9DOcD6jyZgwD/00aeezSZtF24BBcCsYrkUe16Uz2Lw/yMz12Z2WaPWI3Z0xV
	yRj/1GWwYG+uKOvl7r4C8/watMsEow+DMUEoG
X-Google-Smtp-Source: AGHT+IGnpaVjr1MA0dqAHs0hipRfKx8zMIIxN1GC6HMsoPaQQ0vXmy5DycoKUbw2eTNz3TfD3AGOO+rnsX9WbGnjja4=
X-Received: by 2002:a17:906:409:b0:a45:a390:3232 with SMTP id
 d9-20020a170906040900b00a45a3903232mr4040783eja.29.1709750817406; Wed, 06 Mar
 2024 10:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094950.761233-1-dtatulea@nvidia.com> <20240305190427.757b92b8@kernel.org>
 <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
 <20240306072225.4a61e57c@kernel.org> <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
 <20240306080931.2e24101b@kernel.org> <CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
 <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
 <20240306094133.7075c39f@kernel.org> <CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com>
In-Reply-To: <CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 10:46:45 -0800
Message-ID: <CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
To: Jakub Kicinski <kuba@kernel.org>, Liang Chen <liangchen.linux@gmail.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, 
	"ian.kumlien@gmail.com" <ian.kumlien@gmail.com>, 
	"Anatoli.Chechelnickiy@m.interpipe.biz" <Anatoli.Chechelnickiy@m.interpipe.biz>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:41=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Mar 6, 2024 at 9:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 6 Mar 2024 17:09:57 +0000 Dragos Tatulea wrote:
> > > > Does the caller need to check skb->pp_recycle? pp_recycle seems lik=
e a
> > > > redundant bit. We can tell whether the page is pp by checking
> > > > is_pp_page(page). the pages in the frag must be pp pages when
> > > > skb->pp_recycle is set and must be non pp pages when the
> > > > skb->pp_recycle is not set, so it all seems redundant to me.
> > > >
> > > AFAIU we don't have to check for pp_recycle, at least not in this spe=
cific case.
> >
> > Definitely not something we assuming in a fix that needs to go
> > to stable.
> >
> > So far, AFAIU, it's legal to have an skb without skb->pp_recycle
> > set, which holds full page refs to a PP page.
>
> Interesting. I apologize then I did not realize this combination is
> legal. But I have a follow up question: what is the ref code supposed
> to do in this combination? AFAIU:
>
> - skb->pp_recycle && is_pp_page()
> ref via page_pool_ref_page()
> unref via page_pool_unref_page()
>
> - !skb->pp_recycle && !is_pp_page()
> ref via get_page()
> unref via put_page()
>
> - !skb->pp_recycle && is_pp_page()
> ref via ?
> unref via?
>
> Also is this combination also legal you think? and if so what to do?
> - skb->pp_recycle && !is_pp_page()
> ref via ?
> unref via?
>
> I'm asking because I'm starting to wonder if this patch has some issue in=
 it:
> https://patchwork.kernel.org/project/netdevbpf/patch/20231215033011.12107=
-4-liangchen.linux@gmail.com/
>
> Because in this patch, if we have a !skb->pp_recycle & is_pp_page()
> combination we end up doing in skb_try_coalesce():
> ref via page_pool_ref_page()
> unref via put_page() via eventual napi_frag_unref()
>
> which seems like an issue, no?
>

Gah, nevermind, skb_pp_frag_ref() actually returns -EINVAL if
!skb->pp_recycle, and in the call site we do a skb_frag_ref() on this
error, so all in all we end up doing a get_page/put_page pair. Sorry
for the noise.

So we're supposed to:
- !skb->pp_recycle && is_pp_page()
ref via get_page
unref via put_page

Very subtle stuff (for me at least). I'll try to propose some cleanup
to make this a bit simpler using helpers that handle all these subtle
details internally so that the call sites don't have to do this
special handling.


--=20
Thanks,
Mina

