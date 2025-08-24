Return-Path: <netdev+bounces-216321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453ADB3317A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A04C17B4D9
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4205238C23;
	Sun, 24 Aug 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGFpJs2K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AEC27461;
	Sun, 24 Aug 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053538; cv=none; b=eYL9Oj6uC2WKxV6KYcYAFjBBjQOBHM0XHnZPd6Ji41oLLX5un+qi/X2tshbmWSYwHsfdxd89l6lpBnbsm6RBetzirSmXe2jTI/72jADBK/ZulENmwa3gcKEwshdMN17GWYm950banxmKUpuuQQ3yfuuVOw6ia8r6jHKyQ/RY2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053538; c=relaxed/simple;
	bh=EO4cIM5fOf7b8Tyn0w9VlgLcTyW0OMRf5TRpWusyjP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhdsUHYpgn2XYkpcKKaR8L1MFnKG6SzjsxjVrZBOxCYKko35M4N6LBwtrMJFlXxxlUB84k9WQAPwruPnH7x2qID7jpWJ78yY0EluTHhTT5/hpPctL5PhsWLQaMi6/oebNjDhQVe4DuOBQhsd7gK9Fm6ReHrwi9Jwky3g/5rQI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGFpJs2K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2469e32f7c1so4051265ad.2;
        Sun, 24 Aug 2025 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756053536; x=1756658336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJhM3bu0eBt37kz5ZGDxdptQw7y4fPyKcwduYqAo3ds=;
        b=OGFpJs2Krsu7Ybzv7g8LVuG0t4PsntnTlxvrFMmo53NMc1NdXV76RlvI7Nl5tKOrQa
         ex6oWQirxwiB+LpavZkPkwA89skw/6/2jP7muKddCKx0H6FLR/SMEa/s1J7Qh3Tfo6H5
         BCOoHmu6AjYky+wZqUztOjYl0GWk5mSQ2ooikV0L61K1uY1WVKbrjAAzfOjfVmnEF0Rp
         q7O0Kw5GiTyWL6ONmhOkBAf6v94teFJ88JdzXb1sXCxe0/XdYGeJVrL6G8Bj3HpcmsgH
         eTiWLgOzlRN65yuAI0e/m9/cUTIYzzaz05V6TJFL595AVRAmPF+5yxt+EyPfOeLXAK/j
         +CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756053536; x=1756658336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJhM3bu0eBt37kz5ZGDxdptQw7y4fPyKcwduYqAo3ds=;
        b=ulhuciSxL5NiyzkkWIxcTNqwY8KUPbTGsOSExzgY6y5fRP7nCbVPldj1FeN/6LxioH
         SnFP2dHS5fJqJqZYlg3UIGue7nU0p3ioqbrnNsFEF+eCE4JxbgBtfwGw3etM3jnVHSNz
         heAsZiXF7+wG6FkCQPBkfcVlMD+7u8zaJdVBIBHBLRhysTJU6LG11SSmSV94xqHN88c+
         tW3OAjmE17VSnseDxJcLAKW4uixdk8XLGKxVS+PmCXtwUfhT/v1dw8uGn5h9PR3BXnic
         h5j2Px/mxwvtNfUsQBlcOYsB9PXyXFbISxvpoKvI+3T8suBZpKMprz/sVrAhfeuhMNWG
         CXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlhiyaf5e55GfBs9SJVks8VPKSpsTC8twtZiiyxxmZTMWLtj6DGMVpJCdka6uMq4sqKFI72YfUagYS@vger.kernel.org, AJvYcCW4cDRJp1OGhgTF3EALEvoEK86DEIkFFhKZWDJeajuTharJusiup7EOglQ+LTtXt+3K8p+vPaYR6rOmvBle@vger.kernel.org
X-Gm-Message-State: AOJu0YytKu5eq0stctyfFW0MDg1KdmekQCb4b6b+i4wxtrbTNzgtpshJ
	y2ni7EuXcoLkgC4nzRbTND3OTiesABYLcYF6AdDNtYx5J999g+TRFyNfg0jTeFnoko5+O00c5wr
	XIMXrRNzf9loMbqDkqbGznl5getmazJI=
X-Gm-Gg: ASbGncsI3iAO2Ea+xWnlJ7MTxrkmVEmqj7KxaRgyblI4gDMQUavNFQDaawSSUsE6HAb
	bXUxc99TyngdPRmQ6RHFrFUYxJe10cJZDylPEk/ktbFbkDWmiDWzorYYCkITXEfzW3qy32cQgm8
	CjzEG0fmBSpQ8g92dGY6YnUpECZEfLgmyMuPIYZSlHjAEAJPJl95e+ady6JnArjsg4y/0rSleJO
	S0yNkOI6RecOhVyAT57LoLu2Z9P7YTtQz2VHv2d
X-Google-Smtp-Source: AGHT+IGn6/anJHwxmhLz866fQilYAB3u/10YWWDgctrORT3fo2nX8LNPfowT7Gh4YcUWHvPBBGaJHV6E9FSjTdH0XM4=
X-Received: by 2002:a17:903:46c5:b0:240:96a:b812 with SMTP id
 d9443c01a7336-2462ee5073amr139632385ad.24.1756053536159; Sun, 24 Aug 2025
 09:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-4-mmyangfl@gmail.com>
 <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
In-Reply-To: <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 25 Aug 2025 00:38:20 +0800
X-Gm-Features: Ac12FXwVLXCZKaK4opKKuH6D9QUFw5IZcBvrQNk5pjrhm8FryHuMhM4-arXVp98
Message-ID: <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
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

On Sun, Aug 24, 2025 at 11:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +#define yt921x_port_is_internal(port) ((port) < 8)
> > +#define yt921x_port_is_external(port) (8 <=3D (port) && (port) < 9)
>
> > +#define yt921x_info_port_is_internal(info, port) \
> > +     ((info)->internal_mask & BIT(port))
> > +#define yt921x_info_port_is_external(info, port) \
> > +     ((info)->external_mask & BIT(port))
>
> Do we really need two sets of macros?
>
> And is there a third state? Can a port be not internal and not
> external?
>
> Maybe the code can just use !yt921x_info_port_is_internal(info, port)
>
>         Andrew

They are used in phylink_get_caps(), since I don't want to declare a
port which we know it does not exist on some chips. But the info_* set
might be inlined and removed since it is not used elsewhere.

Port 10 is dedicated to the internal MCU. Although I could not use it,
anyone familiar with the chips would know it's Port 10 that is neither
internal nor external.

On Sun, Aug 24, 2025 at 11:34=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +static void yt921x_smi_acquire(struct yt921x_priv *priv)
> > +{
> > +     if (priv->smi_ops->acquire)
> > +             priv->smi_ops->acquire(priv->smi_ctx);
> > +}
> > +
> > +static void yt921x_smi_release(struct yt921x_priv *priv)
> > +{
> > +     if (priv->smi_ops->release)
> > +             priv->smi_ops->release(priv->smi_ctx);
> > +}
>
> What happens if priv->smi_ops->acquire and priv->smi_ops->release are
> not implemented? Very likely, it will mostly work, but have subtle bug
> which are going to be hard to observe and find.
>
> You want bugs to be obvious, so they are quick and easy to find. The
> best way to make the bug of missing locking obvious is to jump through
> a NULL pointer and get an Opps. The stack trace will make it obvious
> what has happened.
>
> > +
> > +static int yt921x_smi_read(struct yt921x_priv *priv, u32 reg, u32 *val=
p)
> > +{
> > +     return priv->smi_ops->read(priv->smi_ctx, reg, valp);
> > +}
> > +
> > +static int yt921x_smi_read_burst(struct yt921x_priv *priv, u32 reg, u3=
2 *valp)
> > +{
> > +     int res;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_smi_read(priv, reg, valp);
> > +     yt921x_smi_release(priv);
>
> I don't understand the name _burst here? Why is it called
> that. Looking at other drivers, _u32 would be more common, especially
> if you have functions to read a _u16, _u8 etc.
>
>    Andrew

They are locked wrappers for their unlocked counterparts. I'd like to
name the unlocked versions __yt921x_smi_read just like __mdiobus_read,
but that was turned down in the previous version, so I have to give
the locked versions a stranger marker since we use unlocked versions
more often.

On Sun, Aug 24, 2025 at 11:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +static int
> > +yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *va=
lp)
> > +{
> > +     struct device *dev =3D to_device(priv);
> > +     u32 mask;
> > +     u32 ctrl;
> > +     u32 val;
> > +     int res;
> > +
> > +     res =3D yt921x_intif_wait(priv);
> > +     if (res)
> > +             return res;
> > +
> > +     mask =3D YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
> > +            YT921X_MBUS_CTRL_OP_M;
> > +     ctrl =3D YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) =
|
> > +            YT921X_MBUS_CTRL_READ;
> > +     res =3D yt921x_smi_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, =
ctrl);
> > +     if (res)
> > +             return res;
> > +     res =3D yt921x_smi_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP=
_START);
> > +     if (res)
> > +             return res;
> > +
> > +     res =3D yt921x_intif_wait(priv);
> > +     if (res)
> > +             return res;
> > +     res =3D yt921x_smi_read(priv, YT921X_INT_MBUS_DIN, &val);
> > +     if (res)
> > +             return res;
> > +
> > +     if ((u16)val !=3D val)
> > +             dev_err(dev,
> > +                     "%s: port %d, reg 0x%x: Expected u16, got 0x%08x\=
n",
> > +                     __func__, port, reg, val);
> > +     *valp =3D (u16)val;
> > +     return 0;
> > +}
>
> ...
>
> > +static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int re=
g)
> > +{
> > +     struct yt921x_priv *priv =3D mbus->priv;
> > +     u16 val;
> > +     int res;
> > +
> > +     if (port >=3D YT921X_PORT_NUM)
> > +             return 0xffff;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_intif_read(priv, port, reg, &val);
> > +     yt921x_smi_release(priv);
> > +
> > +     if (res)
> > +             return res;
> > +     return val;
> > +}
> > +
> > +static int
> > +yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 dat=
a)
> > +{
> > +     struct yt921x_priv *priv =3D mbus->priv;
> > +     int res;
> > +
> > +     if (port >=3D YT921X_PORT_NUM)
> > +             return 0;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_intif_write(priv, port, reg, data);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
>
> Going back to comment from Russell in an older version:
>
> > > I'm also concerned about the SMI locking, which looks to me like you
> > > haven't realised that the MDIO bus layer has locking which guarantees
> > > that all invocations of the MDIO bus read* and write* methods are
> > > serialised.
> >
> > The device takes two sequential u16 MDIO r/w into one op on its
> > internal 32b regs, so we need to serialise SMI ops to avoid race
> > conditions. Strictly speaking only locking the target phyaddr is
> > needed, but I think it won't hurt to lock the MDIO bus as long as I
> > don't perform busy wait while holding the bus lock.
>
> You comment is partially correct, but also wrong. As you can see here,
> you hold the lock for a number of read/writes, not just one u32 write
> split into two MDIO bus transactions.
>
> They way you currently do locking is error prone.
>
> 1) Are you sure you actually hold the lock on all paths?
>
> 2) Are you sure you hold the lock long enough for all code which
>    requires multiple reads/writes?
>
> The mv88e6xxx driver does things differently:
>
> Every function assigned to struct dsa_switch_ops first takes the lock,
> does what needs doing, and then releases the lock just before the
> return.
>
> The lowest level read/write function does a mutex_is_locked() to test
> that the lock is held. If it is not, it prints an error message.
>
> The first part makes it easy to see the lock is held, and it makes it
> clear all operations the driver is doing is covered by the lock, there
> is no need worry about two threads racing.
>
> The second part makes bugs about missing locks obvious, an error
> message is printed.
>
> Please reconsider your locking. Also, please think about, do you need
> a different lock for MDIO, I2C and SPI? Do you need the current
> acquire/release abstract?
>
>         Andrew

That's exactly what I've done: every exposed virtual function
yt921x_dsa_* and yt921x_mbus_* is guarded by an acquire/release pair
(except for few exceptions). But I might add a check for locking
status in mdio_read and mdio_write.

The driver itself does not need an explicit lock (so long as dsa
framework does not call two conflicting methods on the same port), and
holding two locks, driver lock and bus lock makes things even worse,
thus I left the acquire/release method to SMI implementations. If the
I2C / SPI / GPIO bitbang / etc interface supports native atomic
transactions, it can choose not to implement acquire/release and
leaves them NULL.

