Return-Path: <netdev+bounces-220826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D329EB48ED7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB3F7AEFC9
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B7309F0F;
	Mon,  8 Sep 2025 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZL4dTVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58E306D4D;
	Mon,  8 Sep 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337079; cv=none; b=oG2/MpND0dxNcVnH0Ovu/GCHW8fQFEDcSR/xKc0l2m28bTjuOeTVxJVWwD1dBBK5+NYql3tNIOIG9T5UtVIygebgw9UeNsQbBZB6oRNY/n2awghUcxgqyFOtaIECgNUnUoVSUGr2YXtF9IMspyUs2geOdlz9+PHPtTAQlnMsCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337079; c=relaxed/simple;
	bh=WZrrah9aMuAKLUBdsSI5zIoal5HgbHYywFN5Z3v6fSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz0JJvuzJJOA3EgCAma4EBc7TBkhErVmR9uDXIgGBLhK8zHvKpJQKdbYBKxv0kAOVlAgYEjIByqESKo/n5bbF4GCP4xrcCBAUiGt4l5L5t5uk2XD0PRLHJcndPnpjPySW7FbPmwL3KiVsY8/btBjIgTL6r6dIYDfG1eV3VohTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZL4dTVY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32d6c194134so1885623a91.0;
        Mon, 08 Sep 2025 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757337075; x=1757941875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxsScnhFRAfh8hoa8tdrt0Ueycuw3d3wWZbO1YmoHbE=;
        b=BZL4dTVYGiun4k4phPtxOF0W3m5VQO5VfEkya5D4aKuG6XxEm5PMyYp5h3riXylR++
         m4UKSwb9tH7BjLuoqiFGM5LJMYVTgKQU72Cc6lxhq1d2SDZei2Hgf+evto8D+DHQhwFS
         4hEUo613B4tohO+0iUWBlFhK87y9kcUxkCvcu5iLLNH493SfxEdTQpulL4yy/2W/IK/f
         WNGORyGWUMCWqpdHaWW3/6ZKfbdHxcoyqXinthWCwjEBNDEHDKJ6BjvfMIEzxXk3G/j7
         4Rar06OcQRFoLJRL97hV+NSkYB1qRJtI9SqxUuzqVhrVtY2ddrMnnkEOovn+stEls0PX
         XI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337075; x=1757941875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxsScnhFRAfh8hoa8tdrt0Ueycuw3d3wWZbO1YmoHbE=;
        b=bef1/i/pWfmJIxXkIeQQnkRzEM7x/SwGjToKYbBegjDLh2+Ujbkc8GlCHJS8H1p5TH
         t/s1URKIkJA3ouJ2oH+NxD/NRGLTDdEZ20zZq8WprONeHFpzjykN/puIyUVo0rqt23XY
         aTw7MuCrxVcxSKeaNQhjukLKmAOF/8qDRY1dlNvNj9lMN7lvc/ACFulr9r8Yc0eLaKfi
         vPbtUKpTOZkkgZtPZJgxotWFc2gYc454RH2u3qr/ab8I7fQXeFEc65V8xtK4Cfb+DGru
         2v6zuBpx99tLqK8EqpjiB5Yhj/dtV7K1oqkC6kxI0yhpO1FdKtsFilgvwpNw1gMPsqBG
         EL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3LuXUUVXQZeO5Vb3JRTvmTv0r4GnGDJ9O9u7WSgR9UeUaHAanTUNCsetpq0g3H5ZEwHkeMu2ltse5@vger.kernel.org, AJvYcCWEv/QrsvnVecxZFWUSFATxAy8YK29moxGmRd+5sX6qS9YoPyUeCEsH9piN/azTYmpHr5wbPLYUzzHv0eXB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l02jPvtgjoltQHtjMCmEnZ9u0LMCiRd5YBf79AfSTsr/iLW3
	NTCWLIjRteC6EMvNLxlZ3S7XBdgvvB4WKtau2aoDvztelm8EVVzZUTxszq9g58OMQ311L1knFAN
	Q6zjnxnW2hMusYP6n3roa9DDMhtJW+vc=
X-Gm-Gg: ASbGncvHmhD7DntnolZY92jY0w4wS+Rzphv2aKGk6JGdyUUr9+rKjlEY4+YtZKnp2sM
	OD1J1fFPFPji1o1TBKOBDonPYFuQVJkAJn54pjZDF82yJJxhTaJW/+hX0TZyHYGFHXxvACjkcAr
	Xk/00nRLHDx0KSl202+TgohURs91Iz3ZoTwfeT8r+oxGDOMyPbxrJJrY5rkS8Q3j93Yqxs9S9zn
	EHfINiWhxgXRC4sMMnhLl6tOuQ01+AwcVx1OVZgWAn964CMY80=
X-Google-Smtp-Source: AGHT+IGbLlVMZwR3Xd5bA8lydi1jXvnwqkqz37RYXSTBmdLQ+adIm0oo1k46F32RaHp6p8hS4ztBFZQdjdRwQV1B2js=
X-Received: by 2002:a17:90b:3c08:b0:32d:3895:656b with SMTP id
 98e67ed59e1d1-32d43f19072mr11640817a91.12.1757337074967; Mon, 08 Sep 2025
 06:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905181728.3169479-1-mmyangfl@gmail.com> <20250905181728.3169479-4-mmyangfl@gmail.com>
 <4ef60411-a3f8-4bb6-b1d9-ab61576f0baf@lunn.ch>
In-Reply-To: <4ef60411-a3f8-4bb6-b1d9-ab61576f0baf@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 8 Sep 2025 21:10:36 +0800
X-Gm-Features: Ac12FXyghJGVt3ImgN51reDi_6wofgrvtuGDMUG92T-V2Vo85gQbM0bsPcGJDLQ
Message-ID: <CAAXyoMMEUeqxJaAYb8fbeACp7N=hFOQrPbtk4LDJM4CZw7n6mA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:00=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/* Prepare for read/write operations. Not a lock primitive despite und=
erlying
> > + * implementations may perform a lock (could be a no-op if the bus sup=
ports
> > + * native atomic operations on internal ASIC registers).
>
> It is more than atomic operations. Look at how long you hold the
> lock. It is not a simple read/modify/write, you hold it over multiple
> reads and writes. If the ASIC provided some sort of locking, it would
> be available for MDIO, I2C, and SPI, and probably mean additional bus
> transactions.
>
> > + *
> > + * To serialize register operations, use yt921x_lock() instead.
> > + */
> > +static void yt921x_reg_acquire(struct yt921x_priv *priv)
> > +{
> > +     if (priv->smi_ops->acquire)
> > +             priv->smi_ops->acquire(priv->smi_ctx);
> > +}
>
> So, as i said in my review to previous versions, skip the if and just
> take the mutex. KISS. I would not even call mutex_lock(priv->lock);
> Don't over engineer the solution, this will probably work for I2C and
> SPI as well.
>
> > +/* You should manage the bus ownership yourself and use yt921x_reg_rea=
d()
> > + * directly, except for register polling with read_poll_timeout(); see=
 examples
> > + * below.
> > + */
> > +static int yt921x_reg_read_managed(struct yt921x_priv *priv, u32 reg, =
u32 *valp)
> > +{
> > +     int res;
> > +
> > +     yt921x_reg_acquire(priv);
> > +     res =3D yt921x_reg_read(priv, reg, valp);
> > +     yt921x_reg_release(priv);
> > +
> > +     return res;
> > +}
>
> Sorry, i missed your reply to my comment to the previous version. You
> said:
>
> > The driver itself does not need an explicit lock (so long as dsa
> > framework does not call two conflicting methods on the same port),
>
> The DSA framework makes no such guarantees. The DSA framework is also
> not the only entry point into the driver, phylink will directly call
> into the driver, and if you implement things like LEDs, they will have
> direct access to the driver.
>
> So i suggest only having a high level lock, acquired on entry,
> released on exit, e.g. as mv88e6xxx does. KISS.
>
>     Andrew
>
> ---
> pw-bot: cr

So you mean holding bus->mdio_lock during any operations instead of
implementing driver's own lock? Wouldn't other bus participants starve
if I want to poll a register for like 100ms?

