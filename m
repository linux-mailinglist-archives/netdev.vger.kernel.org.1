Return-Path: <netdev+bounces-119725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18764956BE8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3111F244D5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D594D16D4FA;
	Mon, 19 Aug 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSZJAFm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884E16C84A;
	Mon, 19 Aug 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073725; cv=none; b=Jf/k+gyAjUki1usQ8LkUhvkLVRx9NMfGuVQk87LuvDqYJbfDOSljDhVgFkdwOP5L2pOtFgpmmWZq1ON02sMBTMVXycS81ddonMy39ItBqEgGarD/gfitFo2Av5WHenBlk65FuKnIJodM0vNmwXGivLmbiEUrbUs8ou0Njw990oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073725; c=relaxed/simple;
	bh=zw+YKtYXOT5zcBaGU5fOpcRsgJcGoqLRU0cFRnm8Ybc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjVvt1V/6Jr0c1DHaY2OW6W1LIWdZe3yYTi/fAjuqkzpFrmlufo9r/UkehZ1lbDmBpzo2yiY53DRBzQjhNOTDY1kHouDpFNZeIq3yU0n7SfybBWAfV/ByjNbZaAXyqoZsbK6w5aiJF67HrLyvTPP+D7XhWbqrTlgQBJxxk7VT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSZJAFm7; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5daa683b298so1581467eaf.0;
        Mon, 19 Aug 2024 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724073723; x=1724678523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uAtM7JBADAU2Rr1McM7VVNALxSGLDrEkBqaRVSqeYc=;
        b=mSZJAFm7mnt43Q6BF3rL+8tPMcISM0us8EaYgMN/4Ck2G2N4bM5uOQaTkePQhqahB+
         NSm7YS2Y6vcG6578Y8kHUwJ65cRTsD262JWKWVi6cCtdG9g+DloHgk8ZPyIg1dRHJSHI
         3oLVQSpL5KLnteJpnv0pHKVBVtDSLAA3/cf3OcAUZpDj8Ii6ay4lT2iTWSxyxtDp8b3f
         HyrdIG836TusEr2Ip9+Hh+hNu+HKP0VJSh7fi/jADHgWLlHiPPehYhHYSnUwWxOEqUUb
         p4PHBla6luAe5FD8KL0KYwjKK9cbZRV/0E6CP0S8Xyq/CISLG/neRvBOdMLIXD9+aiFG
         MYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073723; x=1724678523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uAtM7JBADAU2Rr1McM7VVNALxSGLDrEkBqaRVSqeYc=;
        b=Dgix7u8MCLAcVhthxRBRRTKERZQZo28pxfP0ulElqhIQGTJDeJRunpeyu4aXV3DTQW
         0nbbgdqKISXGiG5gfjwBckngn+AaJzdUl5FyEzdGz961Sui7mPGT3d7fwLykjX17VMrh
         AUiJL6sIGxQyqRffppJsuUOnYnh/Ep7Gpa6u2QLKArm3sXQV+vqVLLr9ShRbz8ogZ1tg
         mtyHHRu1/KfhCuz72JMFjEOt6jZeXlD7uTkOZzdv9uQBKP3dHbdAiZ/oXy2j3thO+pMV
         qRT93cn+/zzA5boCLik737RDkEQW/kmHDCroOe1UiGLs7LvcZoUqS8+pS+AUTuaIPvM4
         Ob8w==
X-Forwarded-Encrypted: i=1; AJvYcCUZkvURIjw4jTqNUIJDMukoGsN/vHkSPQZ47oargGrwtDrpR/8rnZ7kldOdl+N12FpXq2st8lIJOaONUbMHe9/4EJ/SMbiPKhFX1evJN2cZN6L9h7rzuXwL+87rCpJb4/NieNP3
X-Gm-Message-State: AOJu0Yx/vToJDyo+uTCnCJOVUa5r6naC7CTHlo24ZM0DBAhBpqJECnOa
	w1uhI8WSAQxN2cPeiynUOpT4xwDMglyc+UlxV65HlT9yJAKwScDVkZR1X4EwwZV734ElziKRrLn
	3fLLBIklYOso5cXAUSEJX4S5dBoo=
X-Google-Smtp-Source: AGHT+IEbIjODn9tEIkghxCMzKF+EyYUBjrebNGzWtU+vvyNq/AATtfCuXfXS/oC3FKdp4wPr4+pKUaUEQWrNCMW829A=
X-Received: by 2002:a05:6820:60c:b0:5c6:8eb6:91b2 with SMTP id
 006d021491bc7-5da97f339b3mr13730989eaf.1.1724073723395; Mon, 19 Aug 2024
 06:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819101238.1570176-1-vtpieter@gmail.com> <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf> <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
In-Reply-To: <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 19 Aug 2024 15:21:51 +0200
Message-ID: <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
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

> > Previously I could not use DSA because of the macb driver limitation, now
> > fixed (max_mtu increase, submitted here). Once I got that working, I notice
> > that full DSA was not a compatible use case for my board because of
> > requiring the conduit interface to behave as a regular ethernet interface.
> > So it's really the unmanaged switch case, which I though I motivated well in
> > the patch description here (PHY library, ethtool and switch WoL management).
>
> If its an unmanaged switch, you don't need DSA, or anything at all
> other than MACB. Linux is just a plain host connected to a switch. It
> is a little unusual that the switch is integrated into the same box,
> rather than being a patch cable away, bit linux does not really see
> this difference compared to any other unmanaged switch.

That's true in theory but not in practice because without DSA I can't use
the ksz_spi.c driver which gives me access to the full register set. I need
this for the KSZ8794 I'm using to:
- apply the EEE link drop erratum from ksz8795.c
- active port WoL which is connected through its PME_N pin
- use iproute2 for PHY and connection debugging (link up/down,
  packets statistics etc.)

If there's another way to accomplish the above without DSA, I'd be
happy to learn about it.

Cheers, Pieter

