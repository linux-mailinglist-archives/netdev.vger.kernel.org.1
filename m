Return-Path: <netdev+bounces-193532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66982AC4586
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 01:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEAE18984CE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD024167A;
	Mon, 26 May 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/dp25Oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC21E8332;
	Mon, 26 May 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748301782; cv=none; b=VSISZBKZIeNCWitXYg7PTO3mAHBO+yrXNYEh8ongGwRMgxTPZlWFSF3pyIR6pndp6HRbprNjYmkoZe00DdV/TllPhSkDWOfwqG21r4lDP0vlRAm001x1pigI8oFx+X+3eAjwkSxwJ9RprVA+EkkvPPtXg1UU7hJ5A800eFH2cPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748301782; c=relaxed/simple;
	bh=NAPAPDD+78wGKH6ZcOgtyAHb7B27RqAuSq6Mxjqyho8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORNzZwgm7zl+GC/heh7huYvwR440llx8GNm/5UsRefFdyvTrk+3vZJ/kDm1GNMLZt+o5mKtrqZ0QJwkaIxrbVWkOJJ4iKR0t1RDrJ1Rd5SjJe7YSE5Vs+DEBBT+zATey6BjExnRvbekR+EpXJ7jNB7E9vS6OJ+P5ccTZuhxeNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/dp25Oh; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-525da75d902so774182e0c.3;
        Mon, 26 May 2025 16:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748301779; x=1748906579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC03/XuOWxCMaYoNF0Q5x7guuS3v9+l1Cc12aAtnnkA=;
        b=a/dp25OhHQpKLGy3KL5nMHMqunJh9KQZCv9gxJy33VQOTN/B2gxsxr7fm6wntY7ui9
         dLCYXaXE0E9q9nMnrKdB4Dj0036+SVXsVeOMogt4jxWmp14UpDw4QwmF+MnqcgZ5bop+
         MDYbzYatPBgiqugjyJu5APt6Vji4hET3grbKU2hICU2lwjrf/XuJmu0cfZAXanhKiCBQ
         Jp8ceVo4NqWU7iA2UNP2ir+OyxrojBIbuELyF9+Z5/lKMZarldslBLMqkirQNMi0T9Fa
         5/TCR6NEWqo4epxiap/yA+e+BGpP5B4XGeIiRxRz+1CGS9NQAcCKVg5/JIMmGkR4k9YV
         /sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748301779; x=1748906579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC03/XuOWxCMaYoNF0Q5x7guuS3v9+l1Cc12aAtnnkA=;
        b=hm3zJcOhhOkCGgjcTDpK+UnJ0Lw+6YKStuByxWNF78mGpbeB88QWvovJHEzlafLpC1
         phLqTEa6U7BwXa+HqE/IcCpzLwJ8Q2U0PpmH0JUl6OSB5JzS5QnTKiuSKWVhTce+HIB4
         3KEvyb7nQwMFcsmo01jy29Vt6bnW3CC+a1XPcbYIupahrsGi/PkAm5wnFHgCLdJWvuiA
         dJI3Hqwgi8OJgvyT6ptmnXZyKMfNN+2PT4Xta7sBuCCpB1/EzY9941b0xuTM6qH1ofRZ
         9VwsXCypSTUiJGKIWB3qA6035bBq9QF8nCCuUANlj8PoqXW/pnVwIzE/fIVbD0Uf6ugr
         GmwA==
X-Forwarded-Encrypted: i=1; AJvYcCU4wV2rOTuT8B1ocW12QCEkzFkTxHTmhQG/TQGWpF9MJwPKZbD7rvWxGQ3QCKcRczD+P7CmPDRj1lpX@vger.kernel.org, AJvYcCVSgSipzeBdNl4BHXTmHIY9P23dwFkiBQHBZcKPvzQ1WiU+x8P7Fx8R09nmljCOuy8KeLCCtcYSxGKUJMza@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoRvMhBT/yjpiTtlcoIWYiImoVlhBELm0vRt0Cnz3fPHdl8Bs
	2nKyYorBFFMxyMujD8dP9HhohhHmBSRZTfSjlgNgK+cPlqnlnlBRb8CWHhDCnvdJNAZHw/vo6Lp
	IgQ2Uf9FVUPN/mV3GPzDfUtSY5KHk2oU=
X-Gm-Gg: ASbGnct5/GR02mcD5VMGnUMkW0pHNJQayv/UffQTxpM81fRioNpYJ3gWTfG+xbV8N8G
	oMgo+v1/ywGzo1IfEaP1zn+WGPeDDf7X8eNZe5VSf2Ywtzu3DjzZTAV+r+MeQ6FfptVOAHJadD7
	zDisrf7WBDwGETWiRzNbMe/8FtGqcHsFFYwjMsobE5Qti5
X-Google-Smtp-Source: AGHT+IFzKvKpSlFrb29A+sbxmD83XHx6KY3PDBx92mB2cK4b03AI554D48rVRv1CSb7aDYfIUCfFLjNZtV9qdmUBqQQ=
X-Received: by 2002:a05:6122:900b:b0:52a:cdda:f2a5 with SMTP id
 71dfb90a1353d-52f2c31882emr7542326e0c.0.1748301779382; Mon, 26 May 2025
 16:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com> <959e576e-bf36-4d01-9ffb-023931b61574@lunn.ch>
 <CADvTj4oqjCkMeK0p8ZBa8PQmctc77hpiFK2pqgBJaxRFDgQoDQ@mail.gmail.com> <d4109cc5-83d5-4acd-b0fb-39a50043060b@lunn.ch>
In-Reply-To: <d4109cc5-83d5-4acd-b0fb-39a50043060b@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 17:22:48 -0600
X-Gm-Features: AX0GCFv3GoYFahfXaX4AD29prOBqSMyyUCB0mQcsqn6ElJfHobjLmo9NhUK-PQA
Message-ID: <CADvTj4qdoD-mo7CxNW8VitZf+wXTiZ7m28R4JPQ9kQJGhUH7bA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 4:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 26, 2025 at 03:32:03PM -0600, James Hilliard wrote:
> > On Mon, May 26, 2025 at 1:36=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > +        phy-mode =3D "rgmii";
> > >
> > > Does the PCB have extra long clock lines?
> >
> > I'm not sure, it's a copackaged(maybe on-die is the wrong terminology)
> > PHY I think so I assume the clock lines are internal, in the device spe=
cific
> > dts we set something like this on the emac1 node:
> > allwinner,rx-delay-ps =3D <3100>;
> > allwinner,tx-delay-ps =3D <700>;
>
> Those values are just weird. The RGMII delay should be 2000ps. 3100 is
> way too big, and 700 is way too small.

I think these may not actually be required when using the internal
EPHY's now that I think about it again.

> I think phy-mode =3D "internal" would be better, and just hard code the
> delays either in the MAC or PHY driver.

Hmm, would that make sense even though the MAC driver also
supports external PHY's?

> Thanks for the link to the old thread, which was 5 years
> ago. Hopefully since then, a bit more has been learnt. Quickly reading
> through that thread, i don't think an MFD is not the correct solution.

Well the current patches I've been playing around with for the AC200
phy are pretty similar to those patches still.

Here's a branch that works on both AC200/AC300 but only if I do
the PHY initialization in u-boot:
https://github.com/jameshilliard/linux-h616/commits/acx00

> In the last 5 years we have had to deal with more chicken/egg problems
> with PHYs. It has now become pretty much standard practice to put the
> ID values in DT, to get the driver probed when the device does not
> respond on the bus.

This is what I'm doing right? I mean I'm putting the phy ID in the
DT for both the AC200 and AC300. When doing the reset driver
for say the AC200 I would wire that up to only the AC200 phy
node and not the AC300 node(since the AC300 reset is MDIO
based while the AC200 is i2c based).

> The DT node can then use phandles to the reset and
> clock controller to configure them as needed, the core will probably
> do that. I2C is a bit messier, you probably want a phandle pointing to
> the i2c_adapter, so you can use i2c_transfer() on it in the probe()
> function.

Without a MFD or some other node that exposes a reset I'm a bit
confused about what driver would actually issue the reset.

Yeah, we need a phandle to the i2c_adapter, but since the resets
would be under the AC200 PHY node I assume there would need
to be some sort of intermediary driver implementing the i2c reset
right?

