Return-Path: <netdev+bounces-65081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DD8392A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB152844D5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E85FDAF;
	Tue, 23 Jan 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZJUdZUtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF115EE98
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023662; cv=none; b=HMTJqy8ryzpC1mDEz84vbDGVEoNtljC8hltksSxZKNSrOA8AtQGLCPqgUEanqm2j6nemuGi7Hf0u7cS0k/L0NZ6iSG7TCRmUdQkbuzRDsVhMlK7DsbpYBBZhh6vwrZUNKmhThhLDgGwUeV/ywqjAqVFrr9tUGQ0HMQnR5ssWZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023662; c=relaxed/simple;
	bh=Z25+7+eZRMEehXGp6WoC4354Ldu8Jwzdw/xs6nI5mas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGGHW4xBO9i6EH9w/v5zTiInnMz9P1GiN2WCFuZ9zH06271Ijqrl0EFX1I5MRQfWXstqa0rYDzWHDm/JJYUKHcPtAi5Qud1rmYjmD9G5RTCzfwku4lj7wnxtZR4mM9CU/fAawP2RHG/FywiwkYLmem9N3NcohYJiNa2avgNsWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZJUdZUtq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cddf459ba2so9382191fa.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706023659; x=1706628459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/acSyEquTjXcuiLAZAu9D5jbI1RMTR/MKbLTHxg44OI=;
        b=ZJUdZUtqF9XMIQDqFUojYL8t8gC6Jxax7LXcNWSe8Df4oKJhCCFprbiXoGrZ1fj9WQ
         MT0kC2nYPrwXtLQJu4mZ/aATDA6cuFxzAJ8kKyBTczUiXL1bqqrOqDC1V3By11I9kK4Y
         fuw9SyvRdulYbx87pL0XMdSOVmMRedKqUpEvSOn+Z0jjCoDYsKhHI/x/jl82FaXrRqY+
         HbwR9a4kKh3p6g9yIdGBqFDyMcDaluudWIXUAoDRqwyBaqPDE7xYMuejDIqphAcvmG/1
         McHUxduPJldwGGnHFsxeUpWWndcZqO1eSDMCkuhh3NObyaaWJcj67Ky4k7G9WfrmAjHF
         gOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023659; x=1706628459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/acSyEquTjXcuiLAZAu9D5jbI1RMTR/MKbLTHxg44OI=;
        b=ZRh1jEsYwJdFF6moavTEUIL6Xhqq8Zjga60KOZX+y1NFMQvlXO88vHspYu4Quwc8VF
         3EWHn24lKG9j9SKEE3SIn+/OY1L8PeJ2etzITcQbOGYwFXXf59SXgAB0pkQvky74jire
         2h2Z256uwMHAejEtOLCZ0RSnicVVdHLed6ao/nIG7DpBAgreH4tRWFcUoarNlv+lo7Tf
         BCKzCvxeXSRC/U0Hn4Ieb5X6AztYX+OpmNfBgfdRe3GM3nE9ZWuNC2VljmYvK7dOqpDi
         SH9byjpqDuN31i6bn9O8Fe4aaLKrjCqNneY7woTryjztFMytCWqeAifQgeS7Yqyzc3A0
         OmJw==
X-Gm-Message-State: AOJu0Yw9QpE/+YZc67M13j+AGySYmvAml3/C7Dnq8Jue1PHptWP0oKDd
	b5IvSyOmfppzBvPu7dfybLfaExFcsAp1WEiBy2bMTSaxHw62+rp0LIEcEkG/X7ler9bEQGwl4O4
	vH87WWSFf8iN3eIBNnC62sIiUwS8JrknC++4gog==
X-Google-Smtp-Source: AGHT+IECOsu0WmbMJlmTCB3EljPXp0hBtHwIU8u+z0RczVGoG395LSveV3dNvEJs5hqE6Jjd9Fu7sQw0E9z43zZ65dM=
X-Received: by 2002:a2e:8356:0:b0:2cd:f76f:640d with SMTP id
 l22-20020a2e8356000000b002cdf76f640dmr5982118ljh.2.1706023658752; Tue, 23 Jan
 2024 07:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120192125.1340857-1-andrew@lunn.ch> <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch> <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>
 <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch>
In-Reply-To: <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Tue, 23 Jan 2024 07:27:27 -0800
Message-ID: <CAO-L_46Ltq0Ju_BO+rfvAbe7F=T6m0hZZKu9gzv7=bMV5n6naw@mail.gmail.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev-maintainers <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev <netdev@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'm not sure I fully agree with returning 0xffff here, and especially n=
ot
> > for just one of the four functions (reads and writes, c22 and c45). If =
the
> > end goal is to unify error handling, what if we keep the return values =
as
> > they are, i.e. continue to return -EOPNOTSUPP, and then in get_phy_c22_=
id
> > and get_phy_c45_ids on error we do something like:
> >
> >     return (phy_reg =3D=3D -EIO || phy_reg =3D=3D -ENODEV || phy_reg =
=3D=3D -EOPNOTSUPP)
> >         ? -ENODEV : -EIO;
>
> As i said to Vladimir, what i posted so far is just a minimal fix for
> stable. After that, i have two patches for net-next, which are the
> full, clean fix. And the first patch is similar to what you suggest:
>
> +++ b/drivers/net/phy/phy_device.c
> @@ -780,7 +780,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bu=
s, int addr, int dev_addr,
>   * and identifiers in @c45_ids.
>   *
>   * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
> - * the "devices in package" is invalid.
> + * the "devices in package" is invalid or no device responds.
>   */
>  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>                            struct phy_c45_device_ids *c45_ids)
> @@ -803,7 +803,10 @@ static int get_phy_c45_ids(struct mii_bus *bus, int =
addr,
>                          */
>                         ret =3D phy_c45_probe_present(bus, addr, i);
>                         if (ret < 0)
> -                               return -EIO;
> +                               /* returning -ENODEV doesn't stop bus
> +                                * scanning */
> +                               return (phy_reg =3D=3D -EIO ||
> +                                       phy_reg =3D=3D -ENODEV) ? -ENODEV=
 : -EIO;
>
>                         if (!ret)
>                                 continue;
>
> This makes C22 and C45 handling of -ENODEV the same.
>
> I then have another patch which changed mv88e6xxx to return -ENODEV.
> I cannot post the net-next patches for merging until the net patch is
> accepted and then merged into net-next.
>
>   Andrew

Does that mean if there's a device there but it doesn't support C45 (no
phy_read_c45), it will now return ENODEV?

I suppose that's my only nit but at the end of the day I'm not unhappy with=
 it.

Thank you for taking the time to look at this with me. Is there anything
else you need from me?

