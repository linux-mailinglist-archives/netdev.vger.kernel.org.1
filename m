Return-Path: <netdev+bounces-127855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B298D976E42
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216C9281660
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09721AD256;
	Thu, 12 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcMCPEZq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38887192597
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156588; cv=none; b=UfAKtXRkbpjxOrwsUuisJjlk5bfTGmKf6M2pVRr9r1CAY3YufBrTDyt1JUPZVgZrtGngF9eoESpGSxHvOcpqYEClNXsyzTdISbjFE2gVBfqrTBB+9yQ74ZbNrcUthtAr7tZg8cv8FdtcLUfvPcFnvLlSSNHRoIHhVg5IOeTLuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156588; c=relaxed/simple;
	bh=0KxMTMFwLEWDiU6JsY1B7nSNuzcA1yktVMPv4kYdEes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svYd7R3IxByRFTJRy5Ac3AOC6LjyPJETcstvQ/kLxPlrcOmwcF21euclJOu2uf1kb8KHhUlCujBoJkEW8KvzzUe5C+jPJFfgq+0/B9tBorrxUgbTDtkGuj4hHVND17Hnn8AxJDxAhZAaJ2ImRvjfXxwgnpBXnIN8TiNpywiqI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcMCPEZq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so143277466b.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726156585; x=1726761385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyRNygCbaKKxy4c7gezDYP3ib0gJYCoq+xh8HPggzLY=;
        b=wcMCPEZqyRQselA/r8jd3H26lhjrEl5W3QnxOmfIezk4fVnShYOdXO6Bl5icHgpgtD
         b74qF3F9XRUMRyNgB/fpV67C8pi0CRoYEYuZJX9bjqxhnwq1SAYCQTE1W0boWUV8D5VH
         Ejny+mKQ0EG4eDUTnpIKzx1CUS7Fe2AhESGbIWZ03NktFKNvTvbMzytiidtzoVemiFDB
         HLVl47KAFI95gfUep/pr7/CGBAHWdQ2dPWquJsQ91/60Y8Be/nKhsKIQ1bCdhAbGkJu8
         5EDQ+/xakqt8C9vvlA/JgxxA+BjP9xhmIt2Pfi9cZ1q8lRdLz6wzGGVMZatnWvy0pR8h
         u+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156585; x=1726761385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyRNygCbaKKxy4c7gezDYP3ib0gJYCoq+xh8HPggzLY=;
        b=bV2eKjF3Cvp22bkZJa9EIxXIiIyUcR6muxcGP+byy9v09ES3qYmeyRMZ7pnF/5pABp
         mgJuAUfxJHtACUnopqxqMqRpVMTHQ1FcxRvEigoTMTMYqOU5DFAfogrcSbxnzrXE4xGA
         xbwpeBn9pUO/mhv5QsrmrR2fUnG7JejJ5xmdpt90imWhUdl5XZii9FBtL5UHwLuem6Yi
         ZElMjfCuzdlb2L2kZYOu76s2p5XDcHVMJCCfe2l65ScUvykFYHCFNzYDll/gVFnpmNZf
         747vq6+PSGwAEufiYN7UaeD6ldVZjAm7Vp//sQq0SNz05S3D124B7nkv40Ef0XWpzmhP
         LD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8NSW5x3GYpKVK4XcnuTGAGeRjjVoVIM6E4LW9d1d9O69z4+VuFQAWoHuk1JJ2tqCBEIOgNoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7tRCzw8/FBY0K8ZzEn00HTDfGsnn+yDy3n5Sa876Iw+zS+C8
	cyMTNtIEoTcrIVix1jYby3yup8Te+mKLqOvKHvyjeNY1CCg/fTp0updMMgRVWBw3hr6WWIvvJKj
	hR2Z5ftPt4r7aEQ/qT9hTBu3kLM5ZS7jE0MTc
X-Google-Smtp-Source: AGHT+IGVBHBJ4sB9gIBjwyQM7TkYIWL+8lUMn7Zt9w5XS5Y0YO1x2Mclf141VABjb/XKkh9aDWdNjmH/ntHJB90cCDI=
X-Received: by 2002:a17:907:25c2:b0:a8a:8c8e:f5e6 with SMTP id
 a640c23a62f3a-a902960a0d6mr297623666b.49.1726156584984; Thu, 12 Sep 2024
 08:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911135828.378317-1-usama.anjum@collabora.com> <ZuHfcDLty0IULwdY@pengutronix.de>
In-Reply-To: <ZuHfcDLty0IULwdY@pengutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Sep 2024 17:56:11 +0200
Message-ID: <CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
To: Oleksij Rempel <o.rempel@pengutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Chris Snook <chris.snook@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, kernel@collabora.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:20=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Wed, Sep 11, 2024 at 06:58:27PM +0500, Muhammad Usama Anjum wrote:
> > The err variable isn't being used anywhere other than getting
> > initialized to 0 and then it is being checked in if condition. The
> > condition can never be true. Remove the err and deadcode.
> >
> > Move the rx_dropped counter above when skb isn't found.
> >
> > Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> Thank you!
>
> Regards,
> Oleksij

I do not see any credits given to  Qianqiang Liu, who is desperate to get h=
is
first linux patch...

https://lore.kernel.org/netdev/20240910152254.21238-1-qianqiang.liu@163.com=
/

