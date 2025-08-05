Return-Path: <netdev+bounces-211771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838ECB1B9F4
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DDB18A1082
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3A293C44;
	Tue,  5 Aug 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HIVF6jFi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79232522B4
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418160; cv=none; b=fUlZMbsuq66KBV7WgeDRaB6PBltqV7CuPQGSRihggipf31y9lY33/Q3+N4JAXZ3jMtzHBxtnoOq4t3ShwvduNZRpFlfeEVSIPtPhz5j98emj5Ygf52/t0ELcLEctGQwhwdVq7m3PX6LO7oi8jN93lDoc5O/82OZKOzZPBJtkRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418160; c=relaxed/simple;
	bh=yRwKa2dpxZLra8wGKZ7T59g5/UHIisUODlygBYDlzWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV7Ga0BAdHPiLwZkrrO2O4DJiRDsBtW96DpM77xPGL4i+hIgOHVTWYl1Gp4OsBQ9jN58vcSQP1weSKbRyqYNGeEZSmn+kR4vA1Hkb/AINGqc22TAfQl5e1549qEVBTvWhsc+f5ISwBvTf66Mm2vMai7syU9diQhckxv+c5rxRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HIVF6jFi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af97c0290dcso300150366b.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754418156; x=1755022956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=raX1gawg21AY9SOkHHAfr69KGWhZgSSn9UJ00DFOtpM=;
        b=HIVF6jFiws0PRns1DZy4v6UD9LEb7OtusRuMoq/zgX+FKMeWxZCPEaH+l4x4kOCvLp
         dgOo/cNLGqYpOwtfl//JMPWtE2Ptcx6m/KzJ7FJCsviHxdtUUzB60Z/xKbmg4qJlzqC0
         lHBPx4YwjRZIHiyzNW0BMzUjCbrLBVSYAmRXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418156; x=1755022956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raX1gawg21AY9SOkHHAfr69KGWhZgSSn9UJ00DFOtpM=;
        b=PQ04/kNG4ULcDbvx8ku3YYNDaL6Ss+BHnPCESwo+77p9Bu6D20On4lUO/To+eDkgZu
         XOvZxyT8LKQHzvIq8CKC0RjjH83YmMKksD5chPkT8VwNBbBnG8bKv3wqWm/tEYRJQZyr
         ABKFG+txdE3Bb5MLqldh5+tfmA9TzXjRPk6H6hOLZb8Sf0gZHd7W07fELWpq6i9miul/
         9cljykTPuu/xvk4n0vddNwsLP3ctInElX1+NZZSbGm/Tua6D1YaApqYd4P1p6TFlS6Yh
         IVqY3iIcWjL70iOxJbAbaMA0Bj/QlBsZsgkznRvpcfws9tivFK4LzYaO9ZHV5I2WOdgY
         sKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMl+AatUGlEDwmdtX58F/KHLwZJg/4aaU7UZzZRoyacRbXYpaYSfsmicxqSiUYPReK6y9D3PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bciJIgWP75ZoVpBV13flJk6nizcAG71jRKnyQyTKshW10gYZ
	OftY1AbF1ZF64WGKAFTB8mdPdiVifeAHSoRNivYdJGQjHbS7PfSzWTvNZoSFVQ0aw34iOQ5JE53
	y3UW+5PF+Bg==
X-Gm-Gg: ASbGnctC3Dz6pn/DfuGWHzKZWVLFHkJcmFDrt3JkAY6QJA0pq2mMpC5daGkX0CcJEwQ
	DJN8DyneS/hrmtZiuC/Fq651RRp7n+xiW1F4au5f1re0uP3L15hSZ48DJ2FP1c65gtOtv+UhFd1
	xPocKJdjqJH2YBYJu8GqKGdh3IwvanAWMLpx4K0j3aenjMNhrWva3Gf5WTIYXn0RtkhP6f7624L
	x3aA9dRXTgqXvaLk5q35Ljx6+BB1Eeurx4N8lqJf+lhdTjbbmxfL8Z5KAY1K3q7CpRtRc44fN+a
	FNJWjZ/LKIboXryXSjyFhheN9XlqRaPr7V0+bRm84bh+ABmOb0qKKU9sHOa7NNeFs5/X/rPO1J9
	z9lPkLyslusMQee/qmw9iyzjascAVoiplADpv+BYA6Na9GhA0FJJ3XKYBYEEXh283kow5YEP0
X-Google-Smtp-Source: AGHT+IFBByyfvL/q9BOaC0xM+jdQaZMVUsPKbhHdtd7Kt/SAi4SVYvw1E42xMRMuVfiMXcX1epa3pA==
X-Received: by 2002:a17:907:6d12:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-af9900c231bmr5637766b.22.1754418156055;
        Tue, 05 Aug 2025 11:22:36 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0771f9sm957559166b.16.2025.08.05.11.22.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:22:35 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af97c0290dcso300144466b.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 11:22:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6tMzBq7OWGChWV1OYfmRTqwJ1PlFqpJsewyBafxuyNeJ2jVJ99BSCLpZqfS5jd+heD2PWHmo=@vger.kernel.org
X-Received: by 2002:a17:906:dc95:b0:af9:14cf:d811 with SMTP id
 a640c23a62f3a-af990078cdamr6855866b.17.1754418154788; Tue, 05 Aug 2025
 11:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org> <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
In-Reply-To: <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 21:22:18 +0300
X-Gmail-Original-Message-ID: <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com>
X-Gm-Features: Ac12FXyErT7ozxXaXNrZo7vnN1O87X36CHHYSSDaB5dnqnfCuIGERvksssGxq0A
Message-ID: <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Jakub Kicinski <kuba@kernel.org>, John Ernberg <john.ernberg@actia.se>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 19:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 27 Jul 2025 at 04:35, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Networking changes for 6.17.
>
> So I found out the hard way while traveling that this networking pull
> seems to have broken USB tethering for me. Which I only use when
> traveling, but then I do often end up relying on my phone as the
> source of internet (the phone being on the single-device flight wifi,
> and tethering to the laptop which is why hotspot doesn't necessarily
> work).
>
> It *might* be something else, and I'm bisecting it right now, but the
> networking pull is the obvious first suspect, and my first three
> bisection steps have taken me into that pull.

To absolutely zero surprise, it continued to bisect into the
networking pull, and this is the end result:

  0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f is the first bad commit
  commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f
  Author: John Ernberg <john.ernberg@actia.se>
  Date:   Wed Jul 23 10:25

      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

and I'll test with that just reverted on top of current -tip. But it
bisected right to that commit, and the commit certainly makes sense as
a "that could break usbnet" commit, so I expect that the revert will
indeed fix it.

Considering that I will need usb tethering while traveling during the
rest of the merge window, I almost certainly will just revert it for
good tomorrow, but if somebody comes up with a fix for this that
doesn't involve a revert, I'm all ears.

             Linus

