Return-Path: <netdev+bounces-127997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C889A977736
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1093F1C24300
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BB1A76C3;
	Fri, 13 Sep 2024 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5JhBZdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F61B12D8
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197263; cv=none; b=S43qF6J5KxriuDEB71lP48eHiq5VdvKLaLsmWIBYLbM6uA0qfCUKf14c4emcP39lagNIhlFIc7FEAaN2lFdtsdOhzHJxH9vUBHA2sjatnUCPKS8WMuw7SOS4n1V0xbYLdaYTvYPYaAQCE5/HgVxkefirYjcvn1PCzacdvggbB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197263; c=relaxed/simple;
	bh=5BChQmZR9pQtxWJQ7KzWQcTI7/c3mxzUoONylUUGkho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsnTpsBO6ZIscyIICV9ooIzVNRaF5pZOdd8QaGApBP/bYk0oThoUCYTAApWDok0WAaO9NZ7r1Kxae+5WoOvZBpkJOsriX2cffdyyuSCPDZdV8+XVQuGB5WolM2J91p8E7opGgaR/Z195T4ajm59by6HL19HYUX9PsX9fSBVlaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5JhBZdU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so134505ab.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726197261; x=1726802061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BChQmZR9pQtxWJQ7KzWQcTI7/c3mxzUoONylUUGkho=;
        b=f5JhBZdUNjVTAd/CfCT5NZWTF66m8kAprkpGd2f/jtntNRbmKgObjQupMalRquLaAH
         hpj0qa7S+DBPBFzUfQ7LeSQV47BXTX63tQeJfnUgY+HnsUwN/5aUIvpTUhOUl2Fue2l2
         YgWkbnIYj8R6SUDusblB/pXKKtQ6eKQ1ubZ3e8WsKDVJrhPZ8h38jF5InRRQnH/vHrib
         Po6iMUkgPiiC/LuK+Zx/jc7yzqbgDr04W6fVjRHroi8JDId3jxk/0ZHUmjqX0AXcZ6oJ
         M5EckRemqk5I2KPGwGLjdFuDnYBNDdHTRPpaRubCptIndsgrJBCdpZQSl7ZY2zCKM55S
         SkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197261; x=1726802061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BChQmZR9pQtxWJQ7KzWQcTI7/c3mxzUoONylUUGkho=;
        b=SQQy/OCyN3nl/+bf6va1Jy/G3J3FrSAe6KRFotqoGz7EA0TwH4/BM7VKSfBvWMxpL2
         WZFZ3lw/Z2SFNnE/187iUQuJWlc83GOups+rHUT9IULYYckU3FjPgynBkP0+7yKrb0fO
         N5k3KhViFHhXMHf7hW7xZ8d8gMLe09omRZVVCRWNDbir11BYjW/hHH/MlNrPqBDHtAsg
         5lzP2oYGm/k1iCIBneqwvqF+bkuGoRVBYrPQueXC03AOVRIqv65nQvOSX0/436O5UYSB
         8YARiFmGL4EJbeqDM2Sr3+aIXVhfQx2aq4Q0BD1+AfxyefRPwT0z2SOW60dxZKQ4X70R
         mbQg==
X-Forwarded-Encrypted: i=1; AJvYcCUk+mLgPZaoLENM6Q0pk83upiVUOURIxvUuZQyP+ynMb71U5vfMn1qPtuBuqH7YLeY/5oBxf8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3BEzDP0BPyhiCK76AkYOFUFJLcu6VXYvnHoHx8I5tkFOt5G6
	YEm1ZL1p2yY7LEazHD1NEtXu/GAqXbydL/ara2QlcoPUCgaw20R5icnyhY+oS+P9rSIyKLGc6my
	N27h0y6Du2Z/fig2KBYlww7vEU9vtqA1+UVEV
X-Google-Smtp-Source: AGHT+IEkxgqPsNKDnds/eVtEysPWvXFKKgL74eRXd23NGUL72xMyWQkoPszPRpk08gepJWlb8EHEze3Z/SeEv8+HjdA=
X-Received: by 2002:a05:6e02:1d1a:b0:39d:2555:aa3e with SMTP id
 e9e14a558f8ab-3a0856cc931mr6139495ab.17.1726197260479; Thu, 12 Sep 2024
 20:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913125302.0a06b4c7@canb.auug.org.au> <20240912200543.2d5ff757@kernel.org>
In-Reply-To: <20240912200543.2d5ff757@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 20:14:06 -0700
Message-ID: <CAHS8izN0uCbZXqcfCRwL6is6tggt=KZCYyheka4CLBskqhAiog@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Miller <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 8:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Sep 2024 12:53:02 +1000 Stephen Rothwell wrote:
> > /home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
> > /home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is=
 not a multiple of 4)
> > make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229: net/core/=
page_pool.o] Error 1
>
> Ugh, bad times for networking, I just "fixed" the HSR one a few hours
> ago. Any idea what line of code this is? I'm dusting off my powerpc
> build but the error is somewhat enigmatic.

FWIW I couldn't reproduce this with these steps on top of
net-next/main (devmem TCP is there):

make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- ppc64_defconfig
make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- -j80

(build succeeds)

What am I doing wrong?

--
Thanks,
Mina

