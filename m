Return-Path: <netdev+bounces-78048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B79873D81
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C7D282932
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342A137931;
	Wed,  6 Mar 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnOX00fc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011013475A
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746081; cv=none; b=toMJW48ixLyr4iyqedRuaipAd7mgpx/pGpd9zBYKar44d273bay1w+qWuj5rLRxiVYb0ww9CZFnL2F72GW1Ap8Z/CXPW0iITgpvmuBzjgDrOuBcfrd0BLh59/VerhJAEWI685r3v35jGKyMq+rx8UbuhcyAqqlgvZSSGnmw0B/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746081; c=relaxed/simple;
	bh=eX3/X50p4A7OOA8htCEucfM7TcgCP6daHV9nlBfFHEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSQ5Niido9gy6+Cla+jMpNcDX8LUwx1UcO490mKtZyhjvcSRiS99zvqqU0M2o2tdNzvE2pUgDfrESWfL1GUiw6LB9Bu7EPjxygMVel5SB5CeuLTOcXPvmHVi3nwOYOXkt/PIC022zk7yj71giS7CFt5bQvKyLM4ThUamkQbSmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnOX00fc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so5055366b.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 09:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709746078; x=1710350878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w94diZ9iNEVg6u9UwjKj2DUh++QG9DmeQZBnfcZOhW8=;
        b=ZnOX00fc9GvzypiOvC+omM8G+kx9tS08LA0Xd7fF6vEC4CtUQ5R/JecEBJl8DfDho7
         ACUKMLpS1o4Bs2X4pKduni6AfwVIXN3ijkJrmqFGcJrjJZlpR3MzeyB1HJVUqZB3Pr/J
         UhSkYKKRXuPTkCCMNNeYf4C0W3G5EfUQpK5fyxMKPHtFYHboYLSnJZ0twFOSuIy1t36i
         yerD9rhU1nyYW5P7IltH1utiKMehW1J8S4JTx+eEK5EIeITVvV/zvwhyP6SsGjpOiN8y
         EDFrAXHPZ84unqUWuO1PUWUbNASJgiHVhCI7+dEWJFVNGP+0/QLWkfVFJ2exuZLh2BD2
         gbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746078; x=1710350878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w94diZ9iNEVg6u9UwjKj2DUh++QG9DmeQZBnfcZOhW8=;
        b=g16/qHf7hX6FFwID7stkelgAguXzD75zElfTkamG0UhqnCUvnOkCjJ3nSBDWI1W1XA
         OoPGPPFxJDqBU0hgTPq/PNxOWyS0UyNXn5zmEv4hFKEV98CACSv41dUEuIRLTVCfZmTw
         JV0ny4euDnbQFSYQy3SpEuJMWluAsHwRGqm3S0thBxKeeHegGKft+/X5l42RtGf79Zfl
         14lcNC9YOds06yD5e7ovbr9Y8UU6Dw0Wi7t/zZkotg681BPcyyoaqMpt0E3EDeVOpdHb
         fa1Chg0hrcL/sadGacNQQWC/yRpDmct0emiUb/JwLdzjM6nX3uyn3l9mrS/eP149ifTI
         QDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRxbhZWFiTY9zDpOjRKIWbIcTpUVWBEpBBnuXHZFdSmx5eZXVpFi3vJySU+6o8RQt+It7nsfQh3voNGxw1KGXrUhmhdWVs
X-Gm-Message-State: AOJu0YxAUmPG8tYug+7kO2WMs2GDgkHfPqg2MwBYPoOu3HHwdLxwny+M
	vxeknNXSMEpSMPUDSp6Uta/Zw+FpdAtyeoUm8eSp2WdapLVBmY2Pk/QDZbKGGk+7jUuvJQz3+iQ
	ljiaUB9SKKzXXLkQaDqvU9jRQ8jPReJWYFR9W
X-Google-Smtp-Source: AGHT+IEBkMzksp0NHQ8swQKzOv58zFZ3WYJCQCTWJNk2pd57sW7vdPk0BysnKSIsx8vreleNP/wzinem9L/gnOwQfU8=
X-Received: by 2002:a17:906:1c81:b0:a45:98f3:997e with SMTP id
 g1-20020a1709061c8100b00a4598f3997emr4847806ejh.7.1709746077588; Wed, 06 Mar
 2024 09:27:57 -0800 (PST)
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
In-Reply-To: <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 09:27:45 -0800
Message-ID: <CAHS8izO-dWP3sHdZYjsEZfF3XS8Qt8jhWAXmx6LU=O9PWtzoqg@mail.gmail.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
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

On Wed, Mar 6, 2024 at 9:10=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Wed, 2024-03-06 at 08:40 -0800, Mina Almasry wrote:
> > On Wed, Mar 6, 2024 at 8:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed, 6 Mar 2024 16:00:46 +0000 Dragos Tatulea wrote:
> > > > > Hm, that's a judgment call.
> > > > > Part of me wants to put it next to napi_frag_unref(), since we
> > > > > basically need to factor out the insides of this function.
> > > > > When you post the patch the page pool crowd will give us
> > > > > their opinions.
> > > >
> > > > Why not have napi_pp_put_page simply return false if CONFIG_PAGE_PO=
OL is not
> > > > set?
> > >
> > > Without LTO it may still be a function call.
> > > Plus, subjectively, I think that it's a bit too much logic to encode =
in
> > > the caller (you must also check skb->pp_recycle, AFAIU)
> > > Maybe we should make skb_pp_recycle() take struct page and move it to
> > > skbuff.h ? Rename it to skb_page_unref() ?
> > >
> >
> > Does the caller need to check skb->pp_recycle? pp_recycle seems like a
> > redundant bit. We can tell whether the page is pp by checking
> > is_pp_page(page). the pages in the frag must be pp pages when
> > skb->pp_recycle is set and must be non pp pages when the
> > skb->pp_recycle is not set, so it all seems redundant to me.
> >
> AFAIU we don't have to check for pp_recycle, at least not in this specifi=
c case.
>
> > My fix would be something like:
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index d577e0bee18d..cc737b7b9860 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3507,17 +3507,25 @@ int skb_cow_data_for_xdp(struct page_pool
> > *pool, struct sk_buff **pskb,
> >  bool napi_pp_put_page(struct page *page, bool napi_safe);
> >
> >  static inline void
> > -napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> > +napi_page_unref(struct page *page, bool napi_safe)
> >  {
> > -       struct page *page =3D skb_frag_page(frag);
> > -
> >  #ifdef CONFIG_PAGE_POOL
> > -       if (recycle && napi_pp_put_page(page, napi_safe))
> > +       if (napi_pp_put_page(page, napi_safe))
> >                 return;
> >  #endif
> >         put_page(page);
> >  }
> >
> > +static inline void
> > +napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> > +{
> > +       struct page *page =3D skb_frag_page(frag);
> > +
> > +       DEBUG_NET_WARN_ON(recycle !=3D is_pp_page(page));
> > +
> > +       napi_page_unref(page);
> > +}
> > +
> >
> > And then use napi_page_unref() in the callers to handle page pool &
> > non-page pool gracefully without leaking page pool internals to the
> > callers.
> >
> We'd also need to add is_pp_page() in the header with the changes above..=
.
>

Gah, I did not realize skbuff.h doesn't have is_pp_page(). Sorry!

> On that line of thought, unless these new APIs are useful for other use-c=
ases,
> why not keep it simple:
> - Move is_pp_page() to skbuff.h.

I prefer this. is_pp_page() is a one-liner anyway.

> - Do a simple is_pp_page(page) ? page_pool_put_full_page(page):put_page(p=
age) in
> the caller? Checking skb->pp_recycle would not be needed.
>

IMHO page pool internals should not leak to the callers like this.
There should be a helper that does the right thing for pp & non-pp
pages so that the caller can use it without worrying about subtle pp
concepts that they may miss at some callsites, but I'm fine either way
if there is strong disagreement from others.

> Thanks,
> Dragos
>
> > > > Regarding stable would I need to send a separate fix that does the =
raw pp page
> > > > check without the API?
> > >
> > > You can put them in one patch, I reckon.
> >
>


--=20
Thanks,
Mina

