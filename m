Return-Path: <netdev+bounces-105363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371E910D05
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462261C23CFE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010C1B3F18;
	Thu, 20 Jun 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/TedfsA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C551B14F3;
	Thu, 20 Jun 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900967; cv=none; b=MZ6bCX+gY+GpNbYy1eNCJaFYcH3d4p+nuYQrEDrvfHXiI5J1knkJuZkNuFVoloYVivdfg4XiiUoNZjNXO5+nCEzanxceNfGaBzxwKbz5yQDALqcae0q1MyDC4GE+ES13NCC+f8+HJ53xnbdB6uMon2v/cbrlAngmSeAFLMt7TtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900967; c=relaxed/simple;
	bh=gSIt3+G/QszBV7cGLl2s1UNJ+sC0tb7bYBXBmuIdkEY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Vth9UA2si16F3CmQFLDv9tyciCCanyxbIgfWb3zt/OPFLhTnAkK7LPyHZoAD4ZWtyquz0LDP/j+qC5g2brGwSmKir9V67liIttr70bw3rJSVqg6expBl58j1Gk0RbEJtPuV9n3+O99fmxO8buwMEzEu6R0H9jn058mjj9dwVk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/TedfsA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-440f22526edso5005591cf.0;
        Thu, 20 Jun 2024 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718900965; x=1719505765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/moaf2TCG5+ywsF44roFMcGuf4MGqCAfYcBvfJ2sU2s=;
        b=U/TedfsAUFJgIomjbQ7xT6rcykbdwAAdJqcZ6FwnBo8ZpSd47o40O6voWxS5GVR02h
         iSqT+XL7kYFjNN4Ycx2UddOm6uRb7RI8zva9WNTCV6oeFFe+P5QKTfk6BGViXzq5qO+6
         9rkUkdEzFPI4mkwVPaO5/diYdy067Y1o9jFPLpG7vLkT7g6YWZHnz2how5iMkA+GX67V
         kOFwrWTMI+2ANfaUe4IvGWxO0Vld/Wgy1R1Wo6tWgL6WqVXl+8kbwVHxpKrf3zB/w+4N
         4xC2OiqGcOD/reXurnBR4GwOj218CLrJIh1qE4QLyaftPan0CZgeGf9Fk0kguJBaAOVi
         37OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900965; x=1719505765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/moaf2TCG5+ywsF44roFMcGuf4MGqCAfYcBvfJ2sU2s=;
        b=fWRf8QQ7KNhAQ2182eGTz1KGwBHbRzj0vl2BgadAKxC88G+DDMKP9aHekHMwn3UIDJ
         HShBdgPl2w58qh6SSJrBe9mNaJWIE4E71EW0T1dE4fUxXXbzpIXcEgcIGm/ZvNVrFxsL
         +gVy2xIYAF19iX+lkQLz/xVcbQsFJeA453X57uNXh+erNIVhMl4lM+mVbKcTgOPCw1ul
         lvdsS7H74tm2p5gXRnAniubu37GV7yMrQssQa/Qo+K5qqwDy94hua8lggJCKt4QMHu/v
         gUAD334o/QIfb5d4M+sgNSG+DJ1mtpl5rpr5R80znFxBQFwYogmIM5CsGn7JK/8vA6VF
         QvPw==
X-Forwarded-Encrypted: i=1; AJvYcCWnHLzvkIMcFZq1JFVjoNPiWWTFcjBomKJFBVLP+YFAzKVZxthGhJt54TlKrgqAc2w7wYoraUSwlMlTg3XvY2f4itgGpt90M9FGyFx98u1cWG2Y/+5YMZDb1629zYP3eY2Mpybr
X-Gm-Message-State: AOJu0YyMglYGTXcTzuLH9o5PSvPy3ArQ4DZTEHWRe8wVM5wZH3X2YwvV
	Z3wS9zSDMZOGnAZ8LaqDLOBAsdL3rtq51BJ7CRiVBMpTztg0RDmSVk7QVkUG
X-Google-Smtp-Source: AGHT+IExIWEOLoNqujKEdH8OtoEQO8gB0wbKNkK45PqbENZ1gMTxB6z0poubX+bqomq2hSPXOQV7Yg==
X-Received: by 2002:ad4:4dc7:0:b0:6b2:da77:9a42 with SMTP id 6a1803df08f44-6b501e24194mr60283856d6.16.1718900964484;
        Thu, 20 Jun 2024 09:29:24 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf23f6sm89986356d6.8.2024.06.20.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:29:23 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:29:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Mina Almasry <almasrymina@google.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <667458e38c879_2b190d294f5@willemb.c.googlers.com.notmuch>
In-Reply-To: <c38e22b5-090c-4e9f-80aa-37806aed5eaa@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-12-aleksander.lobakin@intel.com>
 <66588346c20fd_3a92fb294da@willemb.c.googlers.com.notmuch>
 <ad06d2bb-df1d-41cd-8e5a-8758db768f74@intel.com>
 <66707cb3444bd_21d16f294b0@willemb.c.googlers.com.notmuch>
 <c38e22b5-090c-4e9f-80aa-37806aed5eaa@intel.com>
Subject: Re: [PATCH iwl-next 11/12] idpf: convert header split mode to libeth
 + napi_build_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 17 Jun 2024 14:13:07 -0400
> =

> > Alexander Lobakin wrote:
> >> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> >> Date: Thu, 30 May 2024 09:46:46 -0400
> >>
> >>> Alexander Lobakin wrote:
> >>>> Currently, idpf uses the following model for the header buffers:
> >>>>
> >>>> * buffers are allocated via dma_alloc_coherent();
> >>>> * when receiving, napi_alloc_skb() is called and then the header i=
s
> >>>>   copied to the newly allocated linear part.
> >>>>
> >>>> This is far from optimal as DMA coherent zone is slow on many syst=
ems
> >>>> and memcpy() neutralizes the idea and benefits of the header split=
. =

> >>>
> >>> In the previous revision this assertion was called out, as we have
> >>> lots of experience with the existing implementation and a previous =
one
> >>> based on dynamic allocation one that performed much worse. You woul=
d
> >>
> >> napi_build_skb() is not a dynamic allocation. In contrary,
> >> napi_alloc_skb() from the current implementation actually *is* a dyn=
amic
> >> allocation. It allocates a page frag for every header buffer each ti=
me.
> >>
> >> Page Pool refills header buffers from its pool of recycled frags.
> >> Plus, on x86_64, truesize of a header buffer is 1024, meaning it pic=
ks
> >> a new page from the pool every 4th buffer. During the testing of com=
mon
> >> workloads, I had literally zero new page allocations, as the skb cor=
e
> >> recycles frags from skbs back to the pool.
> >>
> >> IOW, the current version you're defending actually performs more dyn=
amic
> >> allocations on hotpath than this one =C2=AF\_(=E3=83=84)_/=C2=AF
> >>
> >> (I explained all this several times already)
> >>
> >>> share performance numbers in the next revision
> >>
> >> I can't share numbers in the outside, only percents.
> >>
> >> I shared before/after % in the cover letter. Every test yielded more=

> >> Mpps after this change, esp. non-XDP_PASS ones when you don't have
> >> networking stack overhead.
> > =

> > This is the main concern: AF_XDP has no existing users, but TCP/IP is=

> > used in production environments. So we cannot risk TCP/IP regressions=

> > in favor of somewhat faster AF_XDP. Secondary is that a functional
> > implementation of AF_XDP soon with optimizations later is preferable
> > over the fastest solution later.
> =

> I have perf numbers before-after for all the common workloads and I see=

> only improvements there.

Good. That was the request. Not only from me, to remind.

> Do you have any to prove that this change
> introduces regressions?

I have no data yet. We can run some tests on your github series too.

