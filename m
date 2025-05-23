Return-Path: <netdev+bounces-192984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10FAC1F56
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429433ADD65
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EF22422F;
	Fri, 23 May 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7X28vYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26D139CFA;
	Fri, 23 May 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991350; cv=none; b=YmVjBCcUv5sYUoShKLy7AFwQ3v9GXHgvTl+xWHlmpya6y+snkVgj4Ewym09mX3a5IzJvhddcTwt6dJC1P1SzXDbKKMOIAdfeY5PD9LIrhK7mS5J9fR8zvvDDWkD9+1bBh0qUopoA9sRJxMreDMvWDFvleyZlLsTZF/q+0i/kdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991350; c=relaxed/simple;
	bh=IZ7gqBrZgtYFnrMGX/kr93mrH6BsXgJrXrzx0q1yJns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIhpiPYJg1Uv7Nu9EiYNe66/BAcV7zJXUkEOqMr+VRSNk48SM1DTfGDJYoQZH2Z5sHYWrx836RPsOG+p1eV7yaRqDMo0VeDJEqGM5v2tdLr80nZPj9DXok17SZNiOioHK4NxoDe8T8HSkjY8g+6khVqtG3y/Rb5+bJQsW/USQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7X28vYr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e09e8adc9so14358567b3.2;
        Fri, 23 May 2025 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747991348; x=1748596148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ7gqBrZgtYFnrMGX/kr93mrH6BsXgJrXrzx0q1yJns=;
        b=W7X28vYrPyYdWP4JtTq7e9TyfTkU0llyB+dZDHe6jCuwuOgYtSqTVz09xGHwuhXraO
         YvHaGYWrv/EdMJ3vxsNp9V7S1PxJn+5QBs6gBioU8No6bsJRtXhFX7OLK9HVRest0X8k
         XjmX8VXDNtzPL0kyLAyYxE0F+PeLLGP6y6saOQuWgPXtGw85Wye+r4hBbSffej8phxL3
         nG/KrhFXglMbeqy4vGVzHBh0BUwF5kyY9xaoPf6fez+N4hTVhpaFZpPUv9N2MU0h6QoF
         /I4bDFqyUE8eBB56MeBRfkCDBsjMA3yV6LsrLHkYAJAzN/BB8XOkQesQdxnYFOqqFDXM
         BGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747991348; x=1748596148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ7gqBrZgtYFnrMGX/kr93mrH6BsXgJrXrzx0q1yJns=;
        b=JUlwxwE7NDEbq3bTbK+//tffApDmhZkyx27I7+7hSGOk/mL9x4/XybKuWzHeOCIDFW
         E4XwkfaK/ITxHiRX/eIQd7I/M2Zjpsmlj/TIk0p47wsi8D/Z0kgQq0mKzuJUet9Q/h3P
         dR6lG6leShP2d1frSWSbjv5rHjUb3SwPy2OlLLVx6c9fO24MN09S5UFiPkLQPwTyjpzS
         JbZFXbciHuw7sv7TpYb8gmS10lbctgSFpG+wJuPD1OEwoQhHdkbJqJHxzDDaGKUofgBn
         WcVyoJwPZUyA45uvSkU0axaPdlfZ3Oqov0OJFydinmZXDyOmtB8ZTiYklUfUieW7GVPO
         OMAg==
X-Forwarded-Encrypted: i=1; AJvYcCUien6BfxVeEqzW5ePsxxTcjCvmbsk12PjsM/4Kc8RozGb2eoWxVDoWX8lyN2xeaVGZJ3btD/5bG4LmGZc=@vger.kernel.org, AJvYcCUkDtlvXsd8bROf8netzJhfllvPzfq3+RsDsB4ObHxYi5RJX2E+M0GYbak9G4uwEnMPdB5bElC3@vger.kernel.org
X-Gm-Message-State: AOJu0YzWVmv+XTkvZbh9RfJLuawZq/JnwD86/rOm2KEYp8Gk4/jpNesd
	aHZDlQkz/1cT00pCSm+go3SjyAJ3KjeuMLo51JmSk5j5rKx2GgbZ71pmHD6Ysto2bMYARcR0FsY
	1/YQO+r+hMZH8RTNCtEhjemTDclsRiIQ=
X-Gm-Gg: ASbGnctSUvyO01Ag/G8RkidcV256x8HwsrxuiURikmZMLiYxBy38MiI8+mbjiNWO5c5
	zkXV8rtxA7TV29QSppNMZkonH42J3hNXfxIn9m6HJe7lIz+KbKyRl84JJIr+msscgowRfu9F8OV
	NUUB0amiozyH+KAX9Ux5gQhuClBhiP/qHeMKieemK65g==
X-Google-Smtp-Source: AGHT+IGXaL7QqjDlaDb1GkhvoJFxiwsSoVycNITgF5U4Ia5QqlfCK94bczHMTbWAprkq1FvzTQY4gYXmRzGkMpjUfZA=
X-Received: by 2002:a05:690c:88e:b0:6ef:652b:91cf with SMTP id
 00721157ae682-70ca7c15312mr389216277b3.27.1747991348039; Fri, 23 May 2025
 02:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com> <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
 <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
 <2e5e16a1-e59e-470d-a1d9-618a1b9efdd4@lunn.ch> <CAOiHx=mQ8z1CO1V-8b=7pjK-Hm9_4-tcvucKXpM1i+eOOB4axg@mail.gmail.com>
 <e0d25a68-057b-4839-a8cd-affe458bfea3@lunn.ch>
In-Reply-To: <e0d25a68-057b-4839-a8cd-affe458bfea3@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 23 May 2025 11:08:55 +0200
X-Gm-Features: AX0GCFtnVRfex_9nhQ4cx9PCVZ832oz1Y9t0dDtKGYfJ3JHQmtusGVXqvc2KluY
Message-ID: <CAOiHx==NzwF3mXfkf+mS0AZzb-FTR0SHwG9n0Hw9nRiR4k-z6w@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on bcm63xx
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Without this change no mode/port works, since there is always either a
> > 0 ns delay or a 4 ns delay in the rx/tx paths (I assume, I have no
> > equipment to measure).
> >
> > With this change all modes/ports work.
>
> Which is wrong.
>
> > With "rgmii-id" the mac doesn't
> > configure any delays (and the phy does instead), with "rgmii" it's
> > vice versa, so there is always the expected 2 ns delay. Same for rxid
> > and txid.
>
> If you read the description of what these four modes mean, you should
> understand why only one should work. And given the most likely PCB
> design, the only mode that should work is rgmii-id. You would have to
> change the PCB design, to make the other modes work.

Since I also have BCM6368 with a BCM53115 connected to one of the
RGMII ports lying around, I played around with it, and it was
surprisingly hard to make it *not* work. Only if I enabled delay on
*both* sides it stopped working, no delay or delay only on one side
continued working (and I used iperf to try if larger amounts of
traffic break it).

So in way, with BCM6368 enabling no (sampling) delays on its MAC side,
all four modes work. I understand that they shouldn't, but the reality
is that they do. Maybe the switches can auto-detect/adapt to (missing)
delays for a certain amount.

@Florian, do you know if this is expected? And yes, I even added the
RGMII delay workaround (change link speed to force the pll to resync)
to ensure that the delays are applied. Though I guess the way Linux
works it isn't needed, and only when changing delays while the link is
up.

> > The Switch is always integrated into the host SoC, so there is no
> > (r)gmii cpu port to configure. There's basically directly attached DMA
> > to/from the buffers of the cpu port. Not sure if there are even
> > buffers, or if it is a direct to DMA delivery.
>
> That makes it a lot simpler. It always plays the MAC side. So i
> recommend you just hard code it no delay, and let the PHY add the
> delays as needed.

Sure thing. I saw that there are device tree properties that can be
used to explicitly enable delays on the MAC side, so in case we ever
need them we can implement them (e.g. a PHY that can't do delays).

Best regards,
Jonas

