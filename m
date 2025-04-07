Return-Path: <netdev+bounces-179987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60778A7F0A6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25727A5BC9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01C226D03;
	Mon,  7 Apr 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbv6vzWk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEC227B8C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066949; cv=none; b=AtHnrPj5b3lbbK1a7elbzauKEUrTOHbgSzj6d/LcwrPnoQY+9fGutHzuUj56zNYQXa+PH82oVA+cS0hwYKlVOTQ5F1NiTgDjuzZHuXBTZYJ9iqgJXlkKujRmT32DJsp5nLmv41THkwYNz6FrUIwNuKHQTQ36qlcvBsYW5d3ImnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066949; c=relaxed/simple;
	bh=tRKmYXG085Ydf1hurTGiNS15VKWDla/lnKDL3Zfn/ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfRX6YqhMoy5eqgwHNYZiek9/aRuiHE1idSMzJMbDBGsTw0vOgg18D4QBedy2NdFDaiaatDkUOruQkJ35NcUxfeoHI7toCgXrlgkNPcpfT8/1VYiZfouwlyDYdL1bR3AEUgeuTukSitn/i+XIOwiW63WO4Hf7FbGVFGJfkznWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbv6vzWk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edb40f357so24538575e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744066946; x=1744671746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRKmYXG085Ydf1hurTGiNS15VKWDla/lnKDL3Zfn/ok=;
        b=Kbv6vzWkHBWbBtVK2HGY05vdyedAF+xOrD6zrSS1kBKwRZ3ouew3rJ/9vQpTZO8ioV
         qNwbFVUlT2QWW+ZKgw7hahMKXCs6yQGlF0mTnlCq0yPgle5K3Xg8JzraM7UWz2BlDUnK
         VikzApFOUqDuy3Z4VnbZVB1a2QrbF6IAdnz3A/MCNU27NBjVRQL0Vask8HJ2RgZcO1CT
         k8worXKSfPUXyd/ZUvgxJh4G4KUEtqJuTP7SsxxBIXj2+YwnGTO1ePsZa59VQAd4xps4
         fH1kHR3mDjuSxKAaYrfeoVrgH6Cxvx1dM1HP3IzGal15jptocxDlkxROIrglfyIy4E8p
         6D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744066946; x=1744671746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRKmYXG085Ydf1hurTGiNS15VKWDla/lnKDL3Zfn/ok=;
        b=f6Q4nzTjVvoVnfUVgDcEZ0AmmvC4fDvxuhj7X2riC/9HJySmX4JPSWtyxcrviIARrf
         LGsjHJn0wQHZJdk1ZnVETZoVan9JoDVRO5OWNE1b+SR7M/Cqy9sPkTOMvZqIsU3L0wJA
         78DQvWoNq72UNy54KOp3HjBx/6QHGxV8PgwyJHoCc++kwNk+in/ko03m9I2mSANqRet6
         pJjFGsL1feS5zp7/I8vVuxXCF2hCGRKdj2kivftx9NMrr7fAVEZ911NLD+cMDW2xltzC
         r7yqgXCZAG0qv7Np9xZQxZ39skPoT32Uc9A4dlLyVWbdt6oA+K1HDE+mnQjQCE8Goyky
         C6BA==
X-Forwarded-Encrypted: i=1; AJvYcCWa+oVfNopE5VEIAtSJFC7rYPmAGLRasZOsxLuhBYt/pnsqi2cbVCh3cMYD4iSNO0oMQW2GoQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESoRTXZmrKHAqgQBTaJeLY4o5LGgIin8vrJOpW0B3QE2D+iPq
	ry1n8Ky8bmPTV09sITt97ShvOrZIVrwBQuVtDPmHc/P4YNdBCZsfkDHtAHf5JJUULo4m7Ijjf/N
	yB3+u2jvje8XEcus/poeT0k0gwnY=
X-Gm-Gg: ASbGncueAmXhor4WTV+ZWuHPmNu8rB8JcJSpN+TqQH6FgT0blEa5Nq2GGOSPn1ZpkAR
	M11/OK96wqSIunXRrpJKumsnF6M8aqg3TymKuNO127er7EQ8/jhMojJrnf81C995wDesPzujkUp
	r/fHjkJB+9EXi50qzftsULjHuDpciQVqMpPzzlqIbKw9e88mvXlboG32A6z4s=
X-Google-Smtp-Source: AGHT+IEaCnYdW4hzybc1hdiQwGPZ/0w0lMKxZBib8gTdNtEjh0xIi+WUW+dbz+OT1oVbEE+02jHNnpMOnDcjFZHSFO0=
X-Received: by 2002:a05:600c:4fd4:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43ee047e935mr94240415e9.0.1744066946082; Mon, 07 Apr 2025
 16:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk> <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch> <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk> <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
 <Z--HZCOqBvyQcmd9@shell.armlinux.org.uk> <CAKgT0UeJvSSCybrqUwgfXxva6oBq0n9rxM=-97DQZQR1kbL8SQ@mail.gmail.com>
 <20250407100138.160f5cb7@kernel.org> <CAKgT0UdaeXS=7YTnTSdRO4hyNrSbxuM3pDdmE=1JCvkizUYrZA@mail.gmail.com>
 <b8a7138d-7e7c-49df-b9b5-9e39f02d0aaa@lunn.ch>
In-Reply-To: <b8a7138d-7e7c-49df-b9b5-9e39f02d0aaa@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 7 Apr 2025 16:01:49 -0700
X-Gm-Features: ATxdqUEjH0CL3H4Rini52AYy21ty4gcbdsHSYA3jpkw0cqByonJh8PBfGBO3U44
Message-ID: <CAKgT0UeA3Nv3w52YTt-FaFA5GQcx4wrUY+CXH6-OJmWAMo7WWQ@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 12:34=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Arguably understanding this code, both phylink and our own MAC/PCS/PMD
> > code, has been a real grind but I think I am getting there. If I am
> > not mistaken the argument is that we aren't "fixed-link" as we have
> > control over what the PCS/PMA configuration is. We are essentially
> > managing things top down, whereas the expectation for "fixed-link" is
> > more of a bottom up.
>
> Fixed link is there to emulate something which does not
> exist. Typically you have a MAC connected to a PHY, or a MAC connected
> to an SFP. The PHY or the SFP tell you how to configure the MAC so the
> chain MAC/PHY/Media works.
>
> However, there are use cases where you connect one MAC directly to
> another MAC. E.G you connect a NIC MAC to the MAC port of a switch.
>
> Fixed link allows you to emulate the missing PHY, so that the MAC has
> no idea the PHY is missing. The end result is that the MAC gets
> configured to make the MAC-MAC link work, without the MAC even knowing
> it is connected to another MAC.
>
> When talking about top down vs bottom up, i think you mean MAC towards
> the media, vs media towards the MAC. Because of Base-T autoneg, etc,
> phylink configures stuff upwards from the media. It needs to wait for
> the PHY to determine what the media is going to do. The PHY will then
> decided what its host side needs, SGMII, 2500BaseX, 10Gbase etc. That
> then allows phylink to configure the PCS to output that. And then you
> need to configure the MAC to feed the PCSs at the correct speed. I
> don't think SFPs are so different. The SFP will probably indicate what
> its maximum bandwidth is. You configure that in the PCS and let is
> negotiate with the link partner PCS to determine the speed, pause
> etc. You can then configure the MAC with the results of that
> negotiation.

That isn't really true for phylink though. We have to specify a
phy_interface_t before autoneg is even an option. In our case that
will probably be doable since we just have to press the FW to give us
the value. If we don't have an SFP cage you aren't changing that
interface type either.

> So fixed-link is not really bottom up, the whole configuration chain
> is media towards the MAC, and it makes no difference if the PHY is
> being emulated via a fixed-link because it does not exist.

I'm not sure what you are talking about. When I refer to the bottom I
am referring to the media. That is how it is depicted in all the IEEE
drawings. I think we are actually agreeing, but I am not sure.

What I was saying is that in our case we end up with the userspace or
FW providing a link setting and we push it down to the PMD from the
MAC side of things. Whereas for something like fixed-link you are
essentially faking the autoneg and making it work from the bottom up.

