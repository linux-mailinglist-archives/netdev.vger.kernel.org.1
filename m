Return-Path: <netdev+bounces-78072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BC873FCD
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30DC1F2254F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8EF13BAE9;
	Wed,  6 Mar 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+6iQs17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507A135418
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750488; cv=none; b=s4yjRGMC7PUW49FblOQR0o1Df3MtkgzmUggaySpxkvaADLGyTnS28gzkOAkV1i3WRJkSrXQ3SkkNCWaLZTe3R9yDu5oKeP6QAJScAxKuNfOY/eQ6fYv8ZMFkk9LYWvRLl3B+6PPoLS7A5Mxv7uzWiMpxUWd/uFg/bmjBnEWycW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750488; c=relaxed/simple;
	bh=ArsTKsXHQof2yGqmTsW0MPeeUHyHUqiUp43CBbiEDkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEa+B2PKH2bXypDLop4kTjNtos1nYebZ3XHZ2LZLIDNmCSSy67BCMeqbhFmMv3NWYtc+0z5a/zZTs1sJD8D5Wckzwbl1Vvw9shkk9rLBwSqYYd0tmX55p8hGisoBEtj/CJaS13vA8c6bD0/3fp75YvHYtp288mQ8G4ZRBfS33Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+6iQs17; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so12847166b.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 10:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709750484; x=1710355284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArsTKsXHQof2yGqmTsW0MPeeUHyHUqiUp43CBbiEDkQ=;
        b=Q+6iQs170zrfY/P8rn+jj2GatlZQijQST9+JM0WzozJgwdKcrEMnRoU7B8qLpo6r04
         8Y8xZEhtUBglYpxSl6Xksql0qqPe7fHx2PidS3H/FfUtFtWXyX4Sc/YMOR+Zyef66h4A
         LiTYQ56O78YL+h0k5RE/t738cVduZkfU+gnocv9TGlvgCMT1tXM/j6l/gHcA/8QdXSCO
         gaupO2yxB1wsv6Cnk2kUDaqR9ZT4sTdg9d2QeEHkExZxqHr/viOSnT8HPZWEpoH9mQps
         R2Xx/XKfjf6HT2d2oFYXDHtlCt70YcPahh+XHccBDCRzomaEycEuCOsIKzJ0eovzmqVg
         2xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750484; x=1710355284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArsTKsXHQof2yGqmTsW0MPeeUHyHUqiUp43CBbiEDkQ=;
        b=fN+GOW6OplEhQuZ7zymWBJaNTpR2g3tEni/IZuVaB7kvEoIKOYMwwL474Xa6MHBVgt
         p5MVCdPHBdYrxIzX27tANiHu6nL5m/dYMSxQgvNLgFV8mhbie6FwNarSnNJgRaRYP6Qu
         8o+L8YcTgSZjQkxvN6TlwrX9DAiw13XtktKFQmXqPEFfYPDdSVK6o2UZ71FaiAD9zi/l
         ae6Lp02q7lQzG3S/W+eQOhURdQ2PcPYHNh2MMyrqN2EjJ/3VKkG49R6lzh4FUqG24362
         nfbmw/YnXrmLNipKiN0ljxXRNizvEFF99CEarJsXIkJnOR5/8V6gNc0jO+XbN0yHJ1cZ
         Ssfg==
X-Forwarded-Encrypted: i=1; AJvYcCVg0GKcX/I5zHWgkPlOqJXrBRlpcSGCrwBZZGA5EVw+iunvM79Oz418CZdzmRfmd9l0Ii2sgqqG3Pd+1D/Iay37zbNvgY5T
X-Gm-Message-State: AOJu0YyAZdMxv3LLVx7ds4LDuxo/pDQXHd8FaKeAjDr59rg2bh8xSd19
	HogjyBt0j0xsBlFK1/OadwvnjoMaA/Yz8gT5EQD0jRLt7psFe9hqAYu/UUJMzzBEV+1gZqPyI2n
	82Peaa98XaSBB32RgFxvFHNFhOGgwj46Jw77B
X-Google-Smtp-Source: AGHT+IEcj9L5XlTsUgR7NutURA5guIGFaY0Ag4iCBcd0lDLfPYQ4ZdXQa05kpAWGdG0hTeFJxeVbtTCZUKN0+egjPWQ=
X-Received: by 2002:a17:906:d045:b0:a44:5589:c098 with SMTP id
 bo5-20020a170906d04500b00a445589c098mr11219162ejb.7.1709750484307; Wed, 06
 Mar 2024 10:41:24 -0800 (PST)
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
 <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com> <20240306094133.7075c39f@kernel.org>
In-Reply-To: <20240306094133.7075c39f@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 10:41:12 -0800
Message-ID: <CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 9:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 17:09:57 +0000 Dragos Tatulea wrote:
> > > Does the caller need to check skb->pp_recycle? pp_recycle seems like =
a
> > > redundant bit. We can tell whether the page is pp by checking
> > > is_pp_page(page). the pages in the frag must be pp pages when
> > > skb->pp_recycle is set and must be non pp pages when the
> > > skb->pp_recycle is not set, so it all seems redundant to me.
> > >
> > AFAIU we don't have to check for pp_recycle, at least not in this speci=
fic case.
>
> Definitely not something we assuming in a fix that needs to go
> to stable.
>
> So far, AFAIU, it's legal to have an skb without skb->pp_recycle
> set, which holds full page refs to a PP page.

Interesting. I apologize then I did not realize this combination is
legal. But I have a follow up question: what is the ref code supposed
to do in this combination? AFAIU:

- skb->pp_recycle && is_pp_page()
ref via page_pool_ref_page()
unref via page_pool_unref_page()

- !skb->pp_recycle && !is_pp_page()
ref via get_page()
unref via put_page()

- !skb->pp_recycle && is_pp_page()
ref via ?
unref via?

Also is this combination also legal you think? and if so what to do?
- skb->pp_recycle && !is_pp_page()
ref via ?
unref via?

I'm asking because I'm starting to wonder if this patch has some issue in i=
t:
https://patchwork.kernel.org/project/netdevbpf/patch/20231215033011.12107-4=
-liangchen.linux@gmail.com/

Because in this patch, if we have a !skb->pp_recycle & is_pp_page()
combination we end up doing in skb_try_coalesce():
ref via page_pool_ref_page()
unref via put_page() via eventual napi_frag_unref()

which seems like an issue, no?

--=20
Thanks,
Mina

