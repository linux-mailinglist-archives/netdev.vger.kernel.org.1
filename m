Return-Path: <netdev+bounces-115463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A909466D6
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 03:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75FB2827D4
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF76FBE;
	Sat,  3 Aug 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGLP97zK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330B6FB8;
	Sat,  3 Aug 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722649670; cv=none; b=oYga/sk+a9dBM2EFMsUXcgQDRT1QsVqIlKGtS7qMTHgPsB9tIDpDXOLEnHXkYNeUKLDvnNiFOt9iBbUZzOo6eA7eHy2n+h2e/kfZ5IlgHe6lWppycph4/Yk8sHf8aOF9QwA95+PpeKv/gZ0OwHr43cvVyTyAYks3tWLK4QfAjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722649670; c=relaxed/simple;
	bh=t2VWeekXhCE3HiK1BuWv+EKsOUefrqAE9gOuQimberk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6NYMGUgBm3QaHqkTOtbaYMA86yeivacGExtWTOYGA7Y8OBBr7wzkirSUoW5rlOVzGZRyJwkK/QZgA1H2lJHzDhrprP1xPW2cA5mEJzwmYg8w9pA279IFpnTLP+EKuf5OwC1GxX8kfII0sszAms0H8MVd+DgECqQanL0IVd46hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGLP97zK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b797a2384cso46476026d6.0;
        Fri, 02 Aug 2024 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722649666; x=1723254466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEEm8/Hs3ohpTUNtHXlZQ1mhqG7WBPtOBKhP8yZksGM=;
        b=OGLP97zKjdT8+s/liHirxfDSZLU6JIXcxgGArgv+/6dVAYeFgWJciV5UC17VOCex4K
         5wFI5U/TqUY8F+0v9RNpDfNvn3XfClx7Btho+tEez3wW4uEWRMm+lKoDr30CzKdTwH+t
         yChjqOQ/8pDfRXxGzjDWJ1A8nHt6vMjYQnL/8gOOY1lQVvfqXMeSKp63v6jyfBGhSfe9
         //1YJ8SPf4GVFqyzMmBLA8lQq78GE0couBytZ7Nezgg0BSHdH4VlOMJsf4JMcErfTBIC
         DCHFsfD9o8TsxsMnXd+FzY2i4JKuOpoyiHvW8n31dKcjqZKZSuEjWQKEThB4Leysuluj
         p78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722649666; x=1723254466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEEm8/Hs3ohpTUNtHXlZQ1mhqG7WBPtOBKhP8yZksGM=;
        b=AOg1qn9FlzCWhfA5ii5XDbqmGItG/g7GXWDMGMJlfaZGupeH/cIQYEWZKn79siLAz2
         VgVZYWj5XSxcceC5bm5l0Fr3t+VBtWJt6E8CRFb4408dxDZ2OipKMHy69pBAhhvnzgDQ
         o+tmE2VoaOG+XD021QEUqd1nqMQOhDYlrSH3D5Q5SiNaT91Qx1Fhx+NFZJNnXINJ6tbG
         bwZBBTRiXo5KHnctKboulHpeK46E+AggY6C529n9V+xs1E/1NaX/pFuyZUNApjJKIHNU
         D5CXax8ZxCOT59sdAm/BmZcddmhO3gAU/BFOW2BCAF7nwR7Q5S76LIRIMuz0rtvE8c3o
         qmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTjQEwjdLyXSdZ3eucyIX9TIzqG9pqZKKahwDHVJjx2B21TBJGKESMNuoaam2/LgoPjTqgizdP7UPlrcFjXjND7ApfBZFNftsVLXCfC6V6TvOYFkU5+2QzTt5+xaQwgWt8JQDN
X-Gm-Message-State: AOJu0YwvS+fqjSv4OOSZpTMb31Uzu8jKXGYFZTSGrG30oKd5xaypRKEc
	setTztZS//DPwvFjEFQqTY64qfOEG4IytYOrT6U+/b2ZFDmBeifi8Q1CNT3sSaeK3gT/hXn/nPP
	ddYFPQir4f89i686Ycy0t1lBOJxY=
X-Google-Smtp-Source: AGHT+IFNI07BDiZ8oSdjhs6pn+ONrpHIV4Nj1RGsHnwJuNZjNHxNFkgIHCeMAgX9Nz2sY592BX1YSgFQ4mM6AGg6464=
X-Received: by 2002:a05:6214:54c3:b0:6b5:3da3:adaa with SMTP id
 6a1803df08f44-6bb9830f93bmr62616156d6.3.1722649666256; Fri, 02 Aug 2024
 18:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802054421.5428-1-yyyynoom@gmail.com> <20240802141534.GA2504122@kernel.org>
In-Reply-To: <20240802141534.GA2504122@kernel.org>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Sat, 3 Aug 2024 10:47:35 +0900
Message-ID: <CAAjsZQwKbp-3QgBj9KEUoqLvaE5pLX8wsLq01TDC8HdVp=8pLg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
To: Simon Horman <horms@kernel.org>
Cc: cooldavid@cooldavid.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:15=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 02, 2024 at 02:44:21PM +0900, Moon Yeounsu wrote:
> > `ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
> > Therefore, we should use a well-defined function not a bit shift
> > to find the header length.
> >
> > It also compress two lines at a single line.
> >
> > Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
>
> Firstly, I think this clean-up is both correct and safe.  Safe because
> ip_hdrlen() only relies on ip_hdr(), which is already used in the same co=
de
> path. And correct because ip_hdrlen multiplies ihl by 4, which is clearly
> equivalent to a left shift of 2 bits.
Firstly, Thank you for reviewing my patch!
>
> However, I do wonder about the value of clean-ups for what appears to be =
a
> very old driver, which hasn't received a new feature for quite sometime
Oh, I don't know that...
>
> And further, I wonder if we should update this driver from "Maintained" t=
o
> "Odd Fixes" as the maintainer, "Guo-Fu Tseng" <cooldavid@cooldavid.org>,
> doesn't seem to have been seen by lore since early 2020.
>
> https://lore.kernel.org/netdev/20200219034801.M31679@cooldavid.org/
Then, how about deleting the file from the kernel if the driver isn't
maintained?
Many people think like that (At least I think so)
There are files, and if there are issues, then have to fix them.
Who can think unmanaged files remain in the kernel?

> > ---
> >  drivers/net/ethernet/jme.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> > index b06e24562973..83b185c995df 100644
> > --- a/drivers/net/ethernet/jme.c
> > +++ b/drivers/net/ethernet/jme.c
> > @@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
> >       if (skb->protocol !=3D htons(ETH_P_IP))
> >               return csum;
> >       skb_set_network_header(skb, ETH_HLEN);
> > +
> >       if ((ip_hdr(skb)->protocol !=3D IPPROTO_UDP) ||
> > -         (skb->len < (ETH_HLEN +
> > -                     (ip_hdr(skb)->ihl << 2) +
> > -                     sizeof(struct udphdr)))) {
> > +         (skb->len < (ETH_HLEN + (ip_hdrlen(skb)) + sizeof(struct udph=
dr)))) {
>
> The parentheses around the call to ip_hdrlen are unnecessary.
> And this line is now too long: networking codes till prefers
> code to be 80 columns wide or less.
Okay, I'll keep the kernel coding style too!
>
> >               skb_reset_network_header(skb);
> >               return csum;
> >       }
> > -     skb_set_transport_header(skb,
> > -                     ETH_HLEN + (ip_hdr(skb)->ihl << 2));
> > +     skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));
>
> Unnecessary parentheses here too.
Also fix it :)
>
> >       csum =3D udp_hdr(skb)->check;
> >       skb_reset_transport_header(skb);
> >       skb_reset_network_header(skb);
>
> --
> pw-bot: cr

Thank you for paying attention to my patch! I'm a beginner who just
came to the kernel.
So... Sorry if I sounded presumptuous and didn't know much about kernels.
But I don't understand why we have to pay attention to unmanaged kernel fil=
es.
And why do we have to check whether the file is managed or not?

Thank you for reading my email ^=EC=98=A4^

