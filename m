Return-Path: <netdev+bounces-185714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2CAA9B837
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116381BA08F4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC318291163;
	Thu, 24 Apr 2025 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC2U0jVW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1D2900B8;
	Thu, 24 Apr 2025 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522475; cv=none; b=k5Q4RATCYice0z8g3rbapxpS7EiWuBgfw2GbVMx0RAtfMlDB6xe+XhnEG5hn+5QFACnKrJxbYVBaeygRCmLLTaYxAM5X9Hkh+EtrXShNStIZl41hmdWYwGoKgIPxnVSihazgg9jE5ybGiskzgF7SKHNauQSY4Mncxx+T0QtKElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522475; c=relaxed/simple;
	bh=VxZVbaLuerUQOiGUQNqAhYl1gyDXczPcezBxadZyF5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6mMEtygp2slosSBH8HnngVeZrcMa7Mhaaq7RT1QjomWCiUZQUgIjSCJzIJrfYXk5ehMxgs33uoxg+v/+Dq04gaQCGQbQPcfesfptsLDFzzu8XXqtxVRy0GFmj5UKR8i6vQZu6gVi84sXAiediAykZ+448x8r08bLo1gUGnUGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC2U0jVW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so6661565e9.1;
        Thu, 24 Apr 2025 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745522472; x=1746127272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxZVbaLuerUQOiGUQNqAhYl1gyDXczPcezBxadZyF5A=;
        b=PC2U0jVWr18RYeDmh1Nt620aQpb2yXv2Wt0VwJMJBljHAytK624IhcumdV3wgKWJCz
         dEFZl0up/67sUECdAastxFPGSAjwdbDr4scjRAb7ZsyQfSA0efvnXujW1zYfOQaJgAkZ
         vPdIsJk9JUHbZcY+WtfaOGQGjJhSCc0lusq0Khxh75642nXNxyhdSNPeXs1rsTdxliCL
         uQsOgbVO0yUc8Lgpx9YTYT6le++LV5nuOYR4PUlji7pdI8+ZXt++ZFqdRrrkyrCjHfxN
         YWdTqAuVawXxS77BGNBEnH5RW7B+y53x+RZj25yZ4WaALLp4oIi7yeNGLoCucipGWOOT
         H7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522472; x=1746127272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxZVbaLuerUQOiGUQNqAhYl1gyDXczPcezBxadZyF5A=;
        b=wLUIagXZ92oz1X59NUCK8r13geis5hZcdljvWpcC5mRmxoRjoNFGRmSYqJD3c8nQca
         ifQPlRR/eh8DV6RYTAe+1COJdD6pdIe0l6DP+ksCgi8mrbBaVjdyL8ugLcNUeW1lC+9O
         XygpZPtHjq8IfaeaZE4+Bp8LOsYFTgVSau74kMkglnR/q+xq7e5pUwgaN+/1Dvmx0KT5
         qrVHz7gY9LoSC8bUYYSn6MwBwAt095ikzoraKPN9i5agLZ+bJtKU4Ayqgy1iQRIzOwLQ
         a/jpozM9z0rMocCDWcuaNRvLR2q2n9FdSTb5DbEnvDuidYL4/8DIAOh7Nes2vGh145J2
         GtaA==
X-Forwarded-Encrypted: i=1; AJvYcCU1mXzq0/AHSICZ6HWTZNOaxzShFg05eNQve+84CvZjPULORYM6Rh7WLxRwKjMUMfCJe+RU1OWz@vger.kernel.org, AJvYcCUvOPfgCUKj8tvevDC3KbXdwKDihS7QB360mOxPBCKoB6MPpqwDONimxIAcY5sw0jih0O9UK0Oy1E6+xw8E@vger.kernel.org, AJvYcCV64NXWAiFb3ahfHIAnCyID0Lx+NRKxrf2WecFdEeoMqHiNhRbVph8wjOirRvN0yAIMZb5sLd2sxAnV@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJgzdXTdoMBiXnQLdUDdSD3fBi18K4OIVFqeTBzizhn9Km4oW
	MxNHujq5PiTILSieKzhPKCk/LDanNwmllEYlWNNZRA1OqBNAlEiq
X-Gm-Gg: ASbGnctPpECXFsDJu5OByIA2ymcTs4bZS04QhVHh+gIEEHZgunotmFS124Q0FZDs6x3
	/4m/KUMNm3YvYxfI2mJ6dGuA83dCeei4ViVbTvHCXP0ooZ+/UQG/An3IXJaQeONFIUYsafOe/q5
	Jg/40IuVZPuYof8CJz7vwhZiB/vwLyQ+HZdqb+/+zc0Y3OYGHuDZOuPTnc2vVV9aKSupKOodnTK
	XcznllFdxd5Bf00vzQHQFdTeV3Wq8Q9Vjs+RfllVyMPJB1VRF7jGkbLEszrYN8BnRkGSzMO03da
	YVb3kr19YJ54A/N+DJKTXwdUBs/DNkY+kEZYNKf6qi4K0siaObxajznMCqFQXcWFseBxYUDqb44
	P4KLopggLy/iF44dQ
X-Google-Smtp-Source: AGHT+IFZGRprjS3R9kdZBnFSrqQKh3fPVHhwBoQA7Av3OfiEbnQa9dyvQJUljIblbrFBUYdwTbBs0Q==
X-Received: by 2002:a05:600c:1e86:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-440a3186746mr5102125e9.28.1745522472126;
        Thu, 24 Apr 2025 12:21:12 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d868asm31066455e9.26.2025.04.24.12.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:21:10 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, wens@csie.org
Cc: Andre Przywara <andre.przywara@arm.com>, Yixun Lan <dlan@gentoo.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, clabbe.montjoie@gmail.com
Subject:
 Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
Date: Thu, 24 Apr 2025 21:21:09 +0200
Message-ID: <8516361.T7Z3S40VBb@jernej-laptop>
In-Reply-To:
 <CAGb2v65GPqr5Vnqb_MhAJBAjQzd-vKi1g1pJ53oUnF0Ym2PH9g@mail.gmail.com>
References:
 <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <7fcedce7-5cfe-48a4-9769-e6e7e82dc786@lunn.ch>
 <CAGb2v65GPqr5Vnqb_MhAJBAjQzd-vKi1g1pJ53oUnF0Ym2PH9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 24. april 2025 ob 21:05:17 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> On Fri, Apr 25, 2025 at 3:02=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > > In my experience, vendor DT has proper delays specified, just 7 inste=
ad of
> > > 700, for example. What they get wrong, or better said, don't care, is=
 phy
> > > mode. It's always set to rgmii because phy driver most of the time ig=
nores
> > > this value and phy IC just uses mode set using resistors. Proper way =
here
> > > would be to check schematic and set phy mode according to that. This =
method
> > > always works, except for one board, which had resistors set wrong and
> > > phy mode configured over phy driver was actually fix for it.
> >
> > What PHY driver is this? If it is ignoring the mode, it is broken.
> >
> > We have had problems in the past in this respect. A PHY driver which
> > ignored the RGMII modes, and strapping was used. That 'worked' until
> > somebody built a board with broken strapping and added code to respect
> > the RGMII mode, overriding the strapping. It made that board work, but
> > broke lots of others which had the wrong RGMII mode....
> >
> > If we have this again, i would like to know so we can try to get in
> > front of the problem, before we have lots of broken boards...
>=20
> I think the incident you are referring to is exactly the one that Jernej
> mentioned.
>=20
> And regarding the bad PHY driver, it could simply be that the PHY driver
> was not built or not loaded, hence the kernel falling back to the generic
> one, which of course doesn't know how to set the modes.

Mainline is sorted out as far as I'm aware. Broken PHY drivers are part
of BSP code drops, from where these values are taken from. So, for sure
I wouldn't trust phy mode set in BSP code, but allwinner,tx-delay-ps and
allwinner,rx-delay-ps are usually trustworthy.

Best regards,
Jernej





