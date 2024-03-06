Return-Path: <netdev+bounces-78027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68987873C6A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960B71C21526
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D573135403;
	Wed,  6 Mar 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eotKCtCl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45994111A3
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743222; cv=none; b=uxMjO2sp5YKNm9wxNae1JaN6l415kyxM+oYPS0NMKruTTKYeiVCvwUHpbYinJlFr644A49Z002MhxwpFnIJsq8zOPQt6KQnAtgmM2N5fsKWLJB1qfy9zNnIrWtcaZiKpE7Dvx1v44ubWcMZY+ELySb9ZEMm85Eq3SyuLjG1FWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743222; c=relaxed/simple;
	bh=Yegp3wOSPvL1W7YR800iskMPmhja07Aw33gkny63/R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyAAgmwOL0GlDckGidVAAAnieuvBbNb4jL6kDzxsA1pDQtZktO4WWwdgZTOPS1lIxV2HxI5p7DKEN2/iNv6WGxLsEHbJ4XenzeA1FoLEZtSmNHxeiRZo0r6M6M7NxPMtyH3alkLoso2V9B04j3nk3EvzwurX7TfOQSDRPIn6Lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eotKCtCl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so1125271966b.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709743219; x=1710348019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjlGkktx8405hHF5yhBJ78WUMqlW3sHOtv1UsXx/Tng=;
        b=eotKCtClQjby+TlKa1BqftSG9J4OuD8acB51YpBT58FKSzg1ZLX3qEU5kyxjQvJkei
         Z/eEtvXS0RfBj+oVcZZta/yOLSIHYmZR37leN9xqZ56iARrpjQrepZh0bDULODWYKVFr
         aSgfr0IJxTu/BIhskDYqgHV+o/gkdsyjyaKBI0z2kS3r8xiTw/yiVlthr56aVdUdPg83
         fOPcYNGsbN2ZFCqXPMReCrxHKSrQ5b5V9jz9FXiaqQ/5cWa8aasDNaJ1+A0qJryiANS3
         oZV+wh50QnhPj+10yqYJaGlWqJo2sMZdf9q78DiuxygUcKaMsyeXIJYMbH16sgOxqsUN
         EgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743219; x=1710348019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjlGkktx8405hHF5yhBJ78WUMqlW3sHOtv1UsXx/Tng=;
        b=FfeA+r41z79a5wWyMMrImPbK7MPmr1pNu9MNQnq5UtxOeMKlKAbjSTTcFa5zbLXVGL
         UICLyd3otBxSlJSGo1yAjzZN6LHC5sdlkjCbYvxt9nSNqMfebc05/Imts9dicBF3ACCI
         sNRCnRiXP69cbwV6vtO74fOrWUyrM7KAX2y5ChxyYMXR0yc2kHMTYEGBDABFzym/7ny6
         PaRaQGkbZslAQWKYjoVnbZ1B4XUJB4BNAMGRHAC0bHEOmNYl8ZP1R/p/x5IP26ZG5RMh
         EYbGAL3F5+hXpUU3NA1AK72dP6PUaU5VR5HOob46rm4ExeTcdAOBhPQ+APsuDGGg8NdT
         lsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz9nD1z/KJQhQyssOG4olwLKneuVP69UgZapv4/7i1sLmKMIGYPLWlvf2pNL1MJpDLyIHM7BzrXj+RRKTAiBvPMaRjXi+U
X-Gm-Message-State: AOJu0YxIzzFpwrWOYHGP1LdDyFySCjEr9+mp4zBiSY0SUl1f0W+dXVVi
	xkKOSG0ZImlQ2fQADYBQB5MQZIJ8kFo6XlEDfCXbNXoTaX9a2cTGeAb6shtIZRBxcZjCIcGTY5I
	rQDRh983rsCKkht8ITc0o4LYMC3Yr2OgH66GD
X-Google-Smtp-Source: AGHT+IEYIFPLuidYagpc6h1Pc4i7Rm1xE1UUat5OYul8fQF42ujHnTo6FRnkomzB3xZgNd8pXEwxcFKrtDPvo6gGLQs=
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c779 with SMTP id
 lh22-20020a170906f8d600b00a452e21c779mr6965186ejb.4.1709743218198; Wed, 06
 Mar 2024 08:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094950.761233-1-dtatulea@nvidia.com> <20240305190427.757b92b8@kernel.org>
 <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
 <20240306072225.4a61e57c@kernel.org> <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
 <20240306080931.2e24101b@kernel.org>
In-Reply-To: <20240306080931.2e24101b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 08:40:04 -0800
Message-ID: <CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	Gal Pressman <gal@nvidia.com>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"Anatoli.Chechelnickiy@m.interpipe.biz" <Anatoli.Chechelnickiy@m.interpipe.biz>, 
	"ian.kumlien@gmail.com" <ian.kumlien@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 8:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 16:00:46 +0000 Dragos Tatulea wrote:
> > > Hm, that's a judgment call.
> > > Part of me wants to put it next to napi_frag_unref(), since we
> > > basically need to factor out the insides of this function.
> > > When you post the patch the page pool crowd will give us
> > > their opinions.
> >
> > Why not have napi_pp_put_page simply return false if CONFIG_PAGE_POOL i=
s not
> > set?
>
> Without LTO it may still be a function call.
> Plus, subjectively, I think that it's a bit too much logic to encode in
> the caller (you must also check skb->pp_recycle, AFAIU)
> Maybe we should make skb_pp_recycle() take struct page and move it to
> skbuff.h ? Rename it to skb_page_unref() ?
>

Does the caller need to check skb->pp_recycle? pp_recycle seems like a
redundant bit. We can tell whether the page is pp by checking
is_pp_page(page). the pages in the frag must be pp pages when
skb->pp_recycle is set and must be non pp pages when the
skb->pp_recycle is not set, so it all seems redundant to me.

My fix would be something like:

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d577e0bee18d..cc737b7b9860 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3507,17 +3507,25 @@ int skb_cow_data_for_xdp(struct page_pool
*pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);

 static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+napi_page_unref(struct page *page, bool napi_safe)
 {
-       struct page *page =3D skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
-       if (recycle && napi_pp_put_page(page, napi_safe))
+       if (napi_pp_put_page(page, napi_safe))
                return;
 #endif
        put_page(page);
 }

+static inline void
+napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+{
+       struct page *page =3D skb_frag_page(frag);
+
+       DEBUG_NET_WARN_ON(recycle !=3D is_pp_page(page));
+
+       napi_page_unref(page);
+}
+

And then use napi_page_unref() in the callers to handle page pool &
non-page pool gracefully without leaking page pool internals to the
callers.

> > Regarding stable would I need to send a separate fix that does the raw =
pp page
> > check without the API?
>
> You can put them in one patch, I reckon.



--
Thanks,
Mina

