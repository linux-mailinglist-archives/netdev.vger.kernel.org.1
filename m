Return-Path: <netdev+bounces-129587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39296984A82
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 19:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D641F24954
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979AE1AB539;
	Tue, 24 Sep 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AytFswKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B84E1B3
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200648; cv=none; b=GgV/nUmNzPZS/YIw9pviqeOoFA/RC9htimsFgc2AiVc4Ly9RLI0ZzQZI37YtMAOcZJprPaGlPNSU3tPdGYoZLia3kQK0x4RaNb15B30BolMAu7YfP5dB9cpkXX/xJBcKGtCwGRHZx123rLa9b6jH4tr/ocnCqvRxSoS49o+xS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200648; c=relaxed/simple;
	bh=+WovY1b+sv/D9elEPpUptE7C5zHRe1X559aWUPzfzfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlOp4vtM9zq3o0rRaeDxve1d8KuxeRFg92jxLksv6fsPdakhtYItmOLuyT/Tiny2naZaakjmJjqDkRw2xzYh3X/oLncsX3f/Ad7eUbn0FsO7WPeb9whQXYKAz+pMj6EKDRLjoYk337bgt1coD3E46d2xSIVNQMnanML0iKOyPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AytFswKm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8ce5db8668so537921666b.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727200644; x=1727805444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfZ8fgSDovQp6OAqhp6OWSo9JiUV9/HdSsJXIOB+1oc=;
        b=AytFswKmkhzkaN0IyGRFS6yKQsyBKClbVFRiXfO434yth3VAwiJ74tQRx2iuQA+Xhs
         nreQjufKsDJuoAyTjK79C6wrtk6mwurENhvn3BP8M4NzL5DpZclW7ErYorqghaR0V90W
         n4e6e3AcNcg6BqrR9nQhmuzS9kDmomezAZiKhBwqvSFjOqJxwoxvLRImbrymCu9yMWW0
         E7gA+gWrjFP1a4/d3/6s+jTII71eRog2nCfyvlxCvdYhyjTAJwFS9VJa59/XC2COH2JP
         BHFUoK0gcU1Zx8JEDua/Ks861hWQQq8BaskLzcWvc3oNYcIwsUzqtbikq2s5cOa2LEii
         cfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200644; x=1727805444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfZ8fgSDovQp6OAqhp6OWSo9JiUV9/HdSsJXIOB+1oc=;
        b=uViOFixcIfxdNZHHl7Dk8zX1Jn+Dxmj+baxgheJnMqzYxIW17l8ihNuX7O7BQV62Kc
         rd/Kome9tlAXYU+TAXbUBCEtRx4FX0XZfXooAVy3a7zXn2oa3r/zpfGfgcPho85d/ePN
         7wlKODO8jrt1rUvpC9/6KcfoKnHNHMq5b+ZqCXCIWwUyL5MdknBVPNAnoSw9bLL1taRP
         lcs9w8UMOGVjmxKu0q+b+iBnnAPaSwqih8TI0M4CmW4juap+lFifowd8De8+IAzycfeD
         ahNK38yDe18ZoMRrZlbEidOGcUDU5NqeBVGFXXruOE2XuCg76Og5gr+caq8nixl2vgXe
         AH4g==
X-Forwarded-Encrypted: i=1; AJvYcCWIBSo5FZDP/9FatSzuGfHc8JnplfKRcotfhEQHX+FHi9SzwpnkAYlgzTFFrPjbznDIxzvVucw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdd3vf7zAm5+IRaLsl6h6c/XT4yZKSQwth3KfnXLDkrr7UJkiH
	UZ1JCHRpWHSudOhwgQegkhMNTM/WM2rYSWXeVVHdE7Qory6iHcJ22R3CGLP521uvNlFb+b15+VR
	/JWDmmUR0SRVPMQwad0X7x0ur5gJpPJpmgtXuuCpqqXOCjybBqPKfLUg=
X-Google-Smtp-Source: AGHT+IGl0XoeMK5jhmq79tv0ZZuVSpmVgpyUTqdIFPz0UpybpqmCtyC0nfH6FBs5zO7TKkMxEqH5E5veaZCSL1qFBDM=
X-Received: by 2002:a17:907:2da7:b0:a8d:e4b:d7fe with SMTP id
 a640c23a62f3a-a93a0121087mr14935966b.0.1727200643682; Tue, 24 Sep 2024
 10:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal> <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal> <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal> <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>
In-Reply-To: <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>
From: Feng Wang <wangfe@google.com>
Date: Tue, 24 Sep 2024 10:57:12 -0700
Message-ID: <CADsK2K9aHkouKK4btdEMmPGkwOEZTNmd7OPHvYQErd+3NViDnQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

The easiest thing would be to upstream your driver, that is the
prefered way and would just end this discussion.

I will try to upstream the xfrm interface id handling code to
netdevsim, thus it will have an in-driver implementation.

Thanks,

Feng

On Tue, Sep 24, 2024 at 3:34=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Wed, Sep 11, 2024 at 01:40:40PM +0300, Leon Romanovsky wrote:
> > On Mon, Sep 09, 2024 at 11:09:05AM +0200, Steffen Klassert wrote:
> > > On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> > > > On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> > > > > >
> > > > > > Steffen,
> > > > > >
> > > > > > What is your position on this patch?
> > > > > > It is the same patch (logically) as the one that was rejected b=
efore?
> > > > > > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> > > > >
> > > > > This is an infrastructure patch to support routing based IPsec
> > > > > with xfrm interfaces. I just did not notice it because it was not
> > > > > mentioned in the commit message of the first patchset. This shoul=
d have
> > > > > been included into the packet offload API patchset, but I overloo=
ked
> > > > > that xfrm interfaces can't work with packet offload mode. The sta=
ck
> > > > > infrastructure should be complete, so that drivers can implement
> > > > > that without the need to fix the stack before.
> > > >
> > > > Core implementation that is not used by any upstream code is rarely
> > > > right thing to do. It is not tested, complicates the code and mostl=
y
> > > > overlooked when patches are reviewed. The better way will be to ext=
end
> > > > the stack when this feature will be actually used and needed.
> > >
> > > This is our tradeoff, an API should be fully designed from the
> > > beginning, everything else is bad design and will likely result
> > > in band aids (as it happens here). The API can be connected to
> > > netdevsim to test it.
> > >
> > > Currently the combination of xfrm interfaces and packet offload
> > > is just broken.
> >
> > I don't think that it is broken.
>
> I don't see anything that prevents you from offloading a SA
> with an xfrm interface ID. The binding to the interface is
> just ignored in that case.
>
> > It is just not implemented. XFRM
> > interfaces are optional field, which is not really popular in the
> > field.
>
> It is very popular, I know of more than a billion devices that
> are using xfrm interfaces.
>
> >
> > > Unfortunalely this patch does not fix it.
> > >
> > > I think we need to do three things:
> > >
> > > - Fix xfrm interfaces + packet offload combination
> > >
> > > - Extend netdevsim to support packet offload
> > >
> > > - Extend the API for xfrm interfaces (and everything
> > >   else we forgot).
> >
> > This is the most challenging part. It is not clear what should
> > we extend if customers are not asking for it and they are extremely
> > happy with the current IPsec packet offload state.
>
> We just need to push the information down to the driver,
> and reject the offload if not supported.
>
> >
> > BTW, I'm aware of one gap, which is not clear how to handle, and
> > it is combination of policy sockets and offload.
>
> Socket policies are a bit special as they are configured by
> the application that uses the socket. I don't think that
> we can even configure offload for a socket policy.
>

