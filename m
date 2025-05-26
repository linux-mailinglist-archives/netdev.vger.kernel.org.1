Return-Path: <netdev+bounces-193518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E62AC449E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B05F3B9E38
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2DC24113D;
	Mon, 26 May 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipb/J+db"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35A23E35E;
	Mon, 26 May 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293749; cv=none; b=Nl7pwCi/axnVIfP4EYXCnKB9zd30h048qLgj2k+Y0L2tMuB+FU9JpBGOu8sNVVKSYtbMV/hduhVfN/qDaA4RzGvZb85aepUNLUMbZHYFGd911Gk4XN5OCYcmxOS+AOJBvdtomgEEmwa5ar72HtmnY0J2cK6ocIfGveE2rxDwHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293749; c=relaxed/simple;
	bh=KR9ydQyBqL+zWssbHMoqdPjTuy3H8LZPz+kipGRjVyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHrDkLpF86qZfpLFlYmVC6TID0CsHXQXtxt4CcAxRx1IeGBawEfaCeUDAbmJc0ZF6e2Au/fchftKycUtnJeZHWkZ1HYkQxggIVAYMxnvvLmquIgVa92xfxfXRV/AHgPq4oyMQu/rx4LNLXLks2fosFvFy98eTPQdYXjb1FsxseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipb/J+db; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e58d270436so18578137.3;
        Mon, 26 May 2025 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748293746; x=1748898546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87fhuAp8NmqR1otDh/HGxIh14e89XZX4r9lz9YqYugM=;
        b=Ipb/J+dbj0KkXiw0mAfaYWUgzIS3ty0MdH4aca54DRknblRXkRpotvmXoOO9B6V9v7
         yJ13kX3p80mCr3HqWZzEW2eat6sLjDZx4NEPebejMR38r1mR5MmkG9DdOHaspHv/wvzI
         13X1LZISUodKBdEy0TC8RYqQMVeEtc1zwo7mwh51OsI6wlPawaoBy4NQWRGKGKkMf5dz
         KPiV0T7Z0CPUwMaFdTi5yt64vOahagnmN5lvvtlGFk/cIN5l8CtsgWsUOXaziLv8W/oG
         xst4Gg7ilue+YFDT+sEc4+wXMqb3D0+825MeN0YVXMBaMiyKHc+jTiu+jL4G53L0fEAT
         DAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748293746; x=1748898546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87fhuAp8NmqR1otDh/HGxIh14e89XZX4r9lz9YqYugM=;
        b=nIckX+OGUWsAB14Iy3SyIRT9jh+0z4qgjrdsciBM377DMOQR01UxxgLyvba1sthopa
         6SEHwdqUMe+PI3Djtjbj8qG1tn2j6r+hOvh0wd4T/nh+ixWdzrky/bgunZhaInaJXRlb
         /8915CcrtVezbzJA4qU8BJACjGKAWmzhoOlPPwpltZFwqZ7AONBPHS5MnIPrMrDLZ2ag
         9rt3fS8d3zuScB7rGNJx8x2FgFPV9UpMQaHAuXFc1SKSU2m5lbeLvXMfSUThGP1WR043
         oVA+Lc4zgk8cHK11kYQbyJF9QOj2Lz/Ie+4Xy80WCGXBtSy5euEP8EmPMMyGGfCr0rIP
         zLxw==
X-Forwarded-Encrypted: i=1; AJvYcCXcPi5C2p9/M5bkCJUZSTdHj+YZ9YwYIFIUiRgjp0YyWtetwIcsTKaoPmb84mlYMhkgS8bnhfil8B6FcN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/X2RC9zWk8ZTSK8GizlyIQ1x4m24lVy63Fskis1R4I0ZSHaq
	2MtWyj0G7876VBCrBYiYUvTfsdqix1lbFy8rV4vzLUb3XYdRBAVclZcBhKHx/BYk8Y3RF65ggM/
	j71bpQhXbkjeBX0AaqoORhKHVV6Q97SQ=
X-Gm-Gg: ASbGncvd/RZ1I7JKQInqTDJA69d9REQLG+6JOQqJ+0AM1ij3olBQqaTuuQwKdms9pL1
	wGNg51CbFmC3pNy3pOlRf71znqm8BuP4ebdYrURox1zWRieZtiHx/EFNrXko3Ml/w2znMV8+oQ4
	yHbBcvtSDtYG5eis0MHp9LHIebOK9/VW1gbg==
X-Google-Smtp-Source: AGHT+IHJS491hwCg7QPzHL8sgVSadrrDFwt5Fkv2jVRTS71w6+V06+FNAv/Rmt5Zw/NYt58vCJJpAIGoZZeec3aMqrg=
X-Received: by 2002:a05:6102:6e85:b0:4e4:5e11:6832 with SMTP id
 ada2fe7eead31-4e45e116d29mr2273063137.7.1748293746485; Mon, 26 May 2025
 14:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-2-james.hilliard1@gmail.com> <a2ac65eb-e240-48f1-b787-c57b5f3ce135@lunn.ch>
In-Reply-To: <a2ac65eb-e240-48f1-b787-c57b5f3ce135@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 15:08:54 -0600
X-Gm-Features: AX0GCFvBOmoEuniobTH4Q2bGCB-bMqy5gqMhcJ9AabATXY_w6ImnhtwMSjGOdz0
Message-ID: <CADvTj4rO-thqYE3VZPE0B0fTTR_v=gJDAxBA3=fo501OL+qvNg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Feiyang Chen <chenfeiyang@loongson.cn>, Yanteng Si <si.yanteng@linux.dev>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 26, 2025 at 12:29:35PM -0600, James Hilliard wrote:
> > The Allwinner H616 ships with two different on-die phy variants, in
> > order to determine the phy being used we need to read an efuse and
> > then select the appropriate PHY based on the AC300 bit.
> >
> > By defining an emac node without a phy-handle we can override the
> > default PHY selection logic in stmmac by passing a specific phy_node
> > selected based on the ac200 and ac300 names in a phys list.
>
> The normal way to do this is phy_find_first().

Sure, but there are problems with that approach here.

The initialization sequences are rather different and the devices
won't be visible on the mdio bus until after they are initialized.

The resets will be specific to either the AC200 or AC300 so we
need to choose the correct PHY based on the efuse value rather
than a mdio bus scan to avoid a circular dependency essentially.

AC200: i2c based reset/init sequence
AC300: mdio based reset/init sequence

>
>     Andrew
>

