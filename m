Return-Path: <netdev+bounces-143098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4C99C123E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110F81F236D6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392F2194AC;
	Thu,  7 Nov 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUdxFw1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DCA21832A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020655; cv=none; b=sc+Adcm4e54alHEJ9lHV0qDfXbNU7uXlHryz1qiM769zlMi6NLNZgoJUl34YRllL+88zm68gNweSx/F7V53RHbDseDOXvXVdZYjkbL05mR1aQdVKQVasl8ZycJ0D+xF+yJk3PCyfC6IoAatOo+i56MoSpdshJHSY+srdpXTgFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020655; c=relaxed/simple;
	bh=BhxcMHtLLtHwPPWGtXd9fvcEeapSiu/a60i7ogxcNi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX0p3Aj7hAd0GubzPtzSPz+rhWbnJWPnjKNHqzr7ZJGR7A/rD6s32evz0h96ob1dIWCRjU5796+ZxSwrsjMvauV6R7g9jL+bdUS1WAVAGSRw6dMBFtkIBFD7UXsToCZKizCfJ3xAUo6w/ZdMIJYk9HbRyPGEldkG/hhulloMFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUdxFw1J; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea1407e978so14708477b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731020653; x=1731625453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlntkSFiHNeZkBFtAn8m126DlC2mYBr54/x5PoDfpxA=;
        b=dUdxFw1JDMG/3R2o1Pf1cCjtVoF8bUHifzwKWzNb/EcEa53q+dhrFlgp05wBedUweN
         WG4qf47Csa2xa1GWvvdnSPQGmAVxqCJ97lzsnerijupoZ1A6ETj1wRoVjPYRetishazn
         9YZjOqv/HCnMIhRGzgl01vNGVggdp/qJJ2WzqSAUZyYD3Ke22Pn44Uf7Z62801inPvYs
         9WpYgkoT9ZGJSkLDPmM3G0r1bNsa41zc4uQUQUaAmwCmyueTaCRCegt2pRz/IUM7ebaY
         ixaRKzvIQ6M7qvntf+Z6wfTnxagMNOklQlzjcNuQpE2il8d92BELvq6baEU3x6z+4hWl
         OCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731020653; x=1731625453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlntkSFiHNeZkBFtAn8m126DlC2mYBr54/x5PoDfpxA=;
        b=ngR3tRM5vjjF8Ah3fk78OQO51RnVgRvztsxRKEqSruxgg3295B7lVFcqen3TaoQrKf
         JCT/kaJByeHCw/mj4qeQrLslw0KoZ7td633yvCzFTZzASBrcuGpXaWSHZrIS4YJrD9yl
         ruDJ35E1rdKXHRiN/kKRNbNU5FXY2J5qplNp96l6fm3ytB6GMuYIdLe+AINLw8Pl9j2l
         cueenrIdHSej2epBJw4zsRtrDkzYpEpZv8b/BCYmFdvg5XOPV38mJ+MAjIS8p8cpJEC3
         QYFIzuOcTlyLMRDanaj+HeywKnej9JsOYlo+cZSFqeEMtMvVHcu+VqWDkJn++snLH8/9
         T2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Jh+F2G4KAeeZmReFoFXHt7mpP/WrNMP9oyv+NST5nWKsKKuRkOtiUmh8+gXDmcoKOinkY4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMMGBJNBrATxgZC0Tho3jDOlhmXTcJhR2FRkp6j0Ot8an3GHX
	F10+zlHWPQekNGK/32IJHbJrMH2bxAtdQ5DvQUJsN6LGL2BsnlkOYhD95Zr+8pbSAgK0UVJdUlE
	9bymcod5bpVaxSz8tnSaDW/orbAjh794nBOWK
X-Google-Smtp-Source: AGHT+IEb2Xaj5GrD2ejkS6S27Jg/4eqckXGxaD2HDeWP/WC9GDRcrkcjw/qpYzRH6bRDS4ZblgpGPOdYoz9Xo5Wte98=
X-Received: by 2002:a05:690c:4d89:b0:6ea:4d3f:df9d with SMTP id
 00721157ae682-6eaddd71c30mr9760277b3.4.1731020653185; Thu, 07 Nov 2024
 15:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
 <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
In-Reply-To: <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Nov 2024 18:04:02 -0500
Message-ID: <CAHC9VhSdC_EnMMu05UbcFAGa8y8OyufTra6kC5zhxDP_S6QucQ@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:54=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> ... That made me look deeper into history
> which commit actually added the decrement on free and it turns out it
> was done intentionally as a bugfix - see commit e4e8536f65b5
> ("selinux: fix the labeled xfrm/IPsec reference count handling").
> Before that commit the logic was similar to what my patch is doing, so
> I could be re-introducing another bug here :-/ The commit message is
> not very helpful there - Paul, do you happen to remember what the
> issue was that prompted it?

With that commit being over 10 years old, I can't say I recall much
about it.  I did try to sift through the SELinux archives, but I
didn't see much from 2013.  It's possible there is an old RH bugzilla
issue for this, but my RHBZ-fu isn't good enough to search that out -
sorry.

--=20
paul-moore.com

