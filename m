Return-Path: <netdev+bounces-157783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7FA0BB35
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FD33AD784
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7820AF61;
	Mon, 13 Jan 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNjVCbYB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1A243351
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780378; cv=none; b=DXnsL9KQ+fX5LoiAT/+e+16i1OwhJU39JOUOVtFPG7dsO5kcVGCKkr7AA5aWu+4B8XAEPwjLk62LZezqL5IsfgfN+3Cly1vVHZj7rSBk6ouJw9aZKAzzU1XbCjBuA4a2GSLWUaIxTDRS68MFHxVsg/GTf9fh9ez/hFdlAieq//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780378; c=relaxed/simple;
	bh=5BNLW1HlfBXlUzg5l7iSk1P1DIOdUsBXprwKqRgIWlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUvuVtIPuK28rOILUQg1EFnVF/7ekVNCq4xWywKI25dTbMdpoHig+RTdXzUw9WDFDHGqqUWssW7rh1hj6adJl3uZRj5FSY+2xVPfLSCQCo55bjrI5JA5pY5P1F2f3M9CU23fxsb1I3uC0+QaGLKd5QsrLVlBPCM3Ze6C2QTQ2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZNjVCbYB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30613802a59so19016361fa.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736780375; x=1737385175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdUjo4kNCNAUx2CihbgFTiI1+JwoKMH0cDUWp6eUG48=;
        b=ZNjVCbYBz+uL+YjrScbxaKJgWUFiDu6mQKjw2z0auecAb2IRQ7UxOysTdXvTbznslL
         x6sbSbYwo+8G5Iz/6qxaMxKn4cVAPdi4EY3yQejuU77ux4WlwFycjPisBzYu9xFTgiOM
         SRgnRAy34aGRYyD4MjhlCDx4yWkgIE7OM5CLF83hhxGpocbPFQDYcpoO/jyq3DI/rM8V
         6gX1OJaWW26UeT8JztM71Ikssz2+reSuDxKTu+nA5yTvc/IMv93Tdpk+IxGio+pD//SI
         OgIRM4YE9KUSdUXHr+1KAkxrtSzlZbo7YnP1srz8YJl1zOhGUU5VMfSc/Ov7toAt/oxb
         g/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780375; x=1737385175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdUjo4kNCNAUx2CihbgFTiI1+JwoKMH0cDUWp6eUG48=;
        b=wNUbIEfvF9pEU8H+tTt2VWfKxnNqcR869+KBBdvaWcCH4S7qlUdZrwRGzh962etyPJ
         i6td2IeQbKckcijvK19zXMuG6m8KlPVn1b7ut9U8yyvv17pqm5pKwlVYpqOypFkBwY/7
         7BA8APOrX363ihe3r5k36yJNCqgMvk7Pz9DX9qLiUm6WcRZuEJLypvMw5O7/yahwizT5
         PYtERWLZ9gP4YIGNEfhUUzO1+nFl1W9JdIQ3zyPanb3s2XT/tcDWF2GG4ca8tKMUjdxS
         5unRt1MjRCq3E+/XIC3x9hr/kA8s/AK0zTRtosd5Dt9lvmSSD6Knn+pBnzLX7e3W4rfL
         TmvA==
X-Forwarded-Encrypted: i=1; AJvYcCXYuZTaFn53xJjzdnej9gIjUmCv62Uz6lR8JvcEeyW+ZQS54i2Z20Z8CU0x1VrLP+FStS85G+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfHnQ+GQqW4G7gG0hLKh8HAM4lI6v8w9XUsWi0s/LkUHabUk8
	zS+OYUUN+B++D1/BeVJOtiA55iDzw5OiMOTsCYSZJnLqNlbrX2Z5T1Efr6rI+uhE9xdObtBzMte
	PDhZiHNBCBSjMG2OH85jO2tzgNnyLdRph1aVd/A==
X-Gm-Gg: ASbGnculRpxoNncDQmdsKZdN4J3cFwWtuYRC7+cuxkUpkUzDMQnHlKKJ4UdUGfNAloi
	VJtWp3yb9VBCpuISTHdxGF99tdQSbXw1rC+bo
X-Google-Smtp-Source: AGHT+IEmD70M4UnRSIfsVFDJz0yx7Fsx8vxCsqnqPHiGw7baPCyGLZoQldsbVIvm7yG0Cho03+v1B2rrjdmnO9FPgbw=
X-Received: by 2002:a05:651c:1415:b0:304:9de0:7d9 with SMTP id
 38308e7fff4ca-305f45a0f1fmr51506441fa.21.1736780375061; Mon, 13 Jan 2025
 06:59:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220-net-mac-nvmem-offset-v1-0-e9d1da2c1681@linaro.org>
 <20241220-net-mac-nvmem-offset-v1-1-e9d1da2c1681@linaro.org> <20241231133533.GA50130-robh@kernel.org>
In-Reply-To: <20241231133533.GA50130-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Jan 2025 15:59:24 +0100
X-Gm-Features: AbW1kvb39DjeK5SqO311_iFkJDqeTCRJdc67NxpNkW0HceKwPqSdOxvFj8fL5HY
Message-ID: <CACRpkdbF9ezSg0qR=RwFpHJNf5P7i4cS+CmRkReNScKk5mxB0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: ethernet-controller: Add mac offset option
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 2:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Fri, Dec 20, 2024 at 08:17:06PM +0100, Linus Walleij wrote:

> > In practice (as found in the OpenWrt project) many devices
> > with multiple ethernet interfaces just store a base MAC
> > address in NVMEM and increase the lowermost byte with one for
> > each interface, so as to occupy less NVMEM.
> >
> > Support this with a per-interface offset so we can encode
> > this in a predictable way for each interface sharing the
> > same NVMEM cell.
>
> This has come up several times before[1][2][3]. Based on those I know
> this is not sufficient with the different variations of how MAC
> addresses are shared. OTOH, I don't think a bunch of properties to deal
> with all the possible transforms works either. It will be one of those
> cases of properties added one-by-one where we end up with something
> poorly designed. I think probably we want to just enumerate different
> schemes and leave it to code to deal with each scheme.

The problem here is that the code needs some handle on which
ethernet instance we are dealing with so the bindings need some
way to pass that along from the consumer.

What about a third, implementation-defined nvmem cell?
#mac-index-cells =3D <1>; or however we best deal with
this.

If it really is per-machine then maybe this is simply one of those
cases where the kernel should:

if (IS_ENABLED(CONFIG_ARCH_FOO) &&
   of_machine_is_compatible("foo,bar-machine)) {
    // Read third cell if present
    // Add to minor mac address
}

> Or we could just say it is the bootloader's problem to figure this out
> and populate the DT using the existing properties for MAC addresses.
> Though bootloaders want to use DT too...

In my current case it's so fantastically organized that if the bootloader
goes into TFTP boot it will use *another* unique MAC address.
(Yes, it's fantastic.)

Yours,
Linus Walleij

