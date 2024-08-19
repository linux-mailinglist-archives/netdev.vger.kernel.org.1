Return-Path: <netdev+bounces-119727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D06956C61
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56914B20DCA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB516C6A2;
	Mon, 19 Aug 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbXYDxNL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4B166F39;
	Mon, 19 Aug 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075036; cv=none; b=mFgX6sbGfhrCBAkoUN54UJPMJNS4BQWJbZ9jex1dtyKZzvLaGvC7m13NjDXlPv3NdBpQLyktC4b+HT8Epw4iI8OGzRddvi76kt3ihZ3ki8ITK7bqDsQkSk4XeziKB8NKC3L3lbHAmS9XJ4wYP1nJLovNsAKpQ+s4+mIP2PT1TRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075036; c=relaxed/simple;
	bh=lNFjR6FNCh6NEgR8GRinugqjCm1dLFqOxfHiz+SY8+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtHbJRWFuu0xFhi/UH0w53YboqR5ReCuzwQt5n/ykZit6Rrj4YDrqQ1tDUTUblM38wR/6BraA2aOqtnct0KlKl+T/u2gpwDRlqdmjr4Q1kusa1R9+64pS+M3uNR+Xn3sFMbg5dVFd0kbjCR5XulPl+x0vhMWj2ksGBILY/F5uZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbXYDxNL; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5daa93677e1so1590196eaf.3;
        Mon, 19 Aug 2024 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724075034; x=1724679834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nDTgs4SC6fJPmkxSSLbCjmUrQ/DeEeUV3fZhZzG+MoA=;
        b=hbXYDxNLrVc71ZU0wFv0USLa1Xk0l1W+vUtT5+7KPsPsxoMMhgoFkgs5ZWegp3M4sI
         aKdDt+/OvLa8ulfFpx25sZ1Sjd1uelFl2/zQGbuvHWbZzw3QDqpdUSyexCKvWSdpxFcn
         fmb+jG/t2o4t8+h51+sP7C1lstAftTN5iJ06GEjiJVVEFOU8AsPE3jPl2itscNDGDrBL
         lrul4D7gOTSmnVjnup8oZXthM0PI6H0Mula7K/eeruTlHDqz5NaPV/1PufOQ85sGjzdj
         9BsE6b8m2Voz4JAH+FIkqWHhADoBNB1Oaqc7sTAv/a259zuVR4a47Nida5L0lJ6XV6Zw
         KvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075034; x=1724679834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDTgs4SC6fJPmkxSSLbCjmUrQ/DeEeUV3fZhZzG+MoA=;
        b=PpuewLLpQPwkJtBInKvaaMUQR7C4fMn080zfCw1hVS5ocds06TBlokuhbudyGbaeTQ
         wB1XEYn6409/3tmPCF8fYRPkm4eGfb0qepKDndNhYVrnqQjeHbntQjawx6Rah0QIZhdt
         RuvZy6gQ5wyVcIx860txHBhQv9As4AJMXR8uM+FGSYCDAnD1UBTEaFTgOt9RFe/lOF6n
         VR4rzsVY2XAUc6Ed+oZ6nFSWloBemymu15MM5UnGMJVeFYpODiPghn3Z/jycL2NPkdky
         FsuTxi+n9eAYrSJekk88pZVpf7w6LQSYXxD+xefg8ca0TuDE2+nOE19fzijTAFTCZXts
         3IoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYQ08AfDYIq8GQWh/slq97rFgwRQrE1zrgDTHOeifzrangf94EuHJ7stM0ZrUvpdLYmUgj1vcS@vger.kernel.org, AJvYcCXjRKbJu8ThfF+tN9jCdfuQVBMQQp92dcV53mNxXDhSrs43oQ9WfclMMLT5UKZnwFGFkA5u2M3sWul3e2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTk4TShfgm7r5eB5Lt3LqsFDoWDNU7vTLErusOWg8Eps517cl
	FKPvNT7QL9F9E0G52hZAlFKpgATeseRKCsP3aSczXwjNlngLds5e4MAtGm6bdludBeta7tsxGvP
	zQINRJH1egICAk7IxSCwt6zQX8Ki7ywCAeBzftg==
X-Google-Smtp-Source: AGHT+IFtBaqUjJ1MmRN8st2zgV4pa3jigcjoZ90sQ0HydHesP322pBXlZW8Dah9TL3uSsz6uYjrnwlX0n2/j3ozLNuE=
X-Received: by 2002:a05:6820:1acc:b0:5d5:d7fc:955c with SMTP id
 006d021491bc7-5da9801a875mr11065976eaf.5.1724075033783; Mon, 19 Aug 2024
 06:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819101238.1570176-1-vtpieter@gmail.com> <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf> <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch> <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
In-Reply-To: <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 19 Aug 2024 15:43:42 +0200
Message-ID: <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

> > > > Previously I could not use DSA because of the macb driver limitation, now
> > > > fixed (max_mtu increase, submitted here). Once I got that working, I notice
> > > > that full DSA was not a compatible use case for my board because of
> > > > requiring the conduit interface to behave as a regular ethernet interface.
> > > > So it's really the unmanaged switch case, which I though I motivated well in
> > > > the patch description here (PHY library, ethtool and switch WoL management).
> > >
> > > If its an unmanaged switch, you don't need DSA, or anything at all
> > > other than MACB. Linux is just a plain host connected to a switch. It
> > > is a little unusual that the switch is integrated into the same box,
> > > rather than being a patch cable away, bit linux does not really see
> > > this difference compared to any other unmanaged switch.
> >
> > That's true in theory but not in practice because without DSA I can't use
> > the ksz_spi.c driver which gives me access to the full register set. I need
> > this for the KSZ8794 I'm using to:
> > - apply the EEE link drop erratum from ksz8795.c
> > - active port WoL which is connected through its PME_N pin
> > - use iproute2 for PHY and connection debugging (link up/down,
> >   packets statistics etc.)
>
> Then it is not an unmanaged switch. You are managing it.
>
> > If there's another way to accomplish the above without DSA, I'd be
> > happy to learn about it.
>
> Its go back to the beginning. Why cannot use you DSA, and use it as a
> manage switch? None of your use-cases above are prevented by DSA.

Right so I'm managing it but I don't care from which port the packets
originate, so I could disable the tagging in my case.

My problem is that with tagging enabled, I cannot use the DSA conduit
interface as a regular one to open sockets etc. I don't fully understand
why I have to admit but it's documented here [1] and with wireshark I
can see only control packets going through, the ingress data ones are
not tagged and subsequently dropped by the switch with tagging enabled.

PS here are my iproute2 commands:
ip link set lan1 up
ip link set lan2 up
ip link add br0 type bridge
ip link set lan1 master br0
ip link set lan2 master br0
ip link set br0 up

Cheers, Pieter

[1] https://www.kernel.org/doc/html/latest/networking/dsa/dsa.html#common-pitfalls-using-dsa-setups

