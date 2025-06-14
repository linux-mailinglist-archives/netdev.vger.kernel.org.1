Return-Path: <netdev+bounces-197790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B8AD9E50
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635867A749B
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12623C4F8;
	Sat, 14 Jun 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj+JgVX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409711802B
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749918401; cv=none; b=VVJsflXdmd25ToJ8+1G2VaYicrMTotUQ2HOaixhLPsLZM64w+oUXxQg9CWPwe4912Eu9ryLF6q50p5H1l9jPj8U8CqpNwCgxIePyeDAEEzBz8iQOhdWBkLty0iLRfZQrkZmN80CheewhJYrFxt7zMY1C50xBlfBck3fe14XwDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749918401; c=relaxed/simple;
	bh=H//3AbhZ8B1JsoU77eO6xBV0uWIkUZQSV6L3Mm/9E+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V04uDAHE5aghh+HwvSLRH1WoDgcrxnGcJFoZDX0fJPcCgbdFKdA1cB+HMxZvSKSVbG8ne7Om6bigAA68nfYAmdVDvlX4kSRc6MCWLGp/BEKJ52ofqUL7iU87RhT1pjMPT+DeVhh8uw41vVFmGcA89wyKocVh8bT07GRrpGHC8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj+JgVX1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2997857f8f.0
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749918397; x=1750523197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJeJqV4oBTdIf5aRO/iLLsA9tYxv7L9gSsaCMHPq9lU=;
        b=Tj+JgVX16spjWEzHObrJDsZk4LM5kdKGC3uOGefkn43MoMw05Q0chrqxpdPAscbvLS
         sJNHyJkeXVRYYJSsPvwYtqwGc2VM6Qv7tQAF5wXDsbx3/GaVJ9iut47ESBRFndAKE0ER
         bYsOEWCBv60OAO+XwE32aMWDrUisLwQI4TDo204USo6JFelTB+x/OoCuhStW4uzdTuRh
         XbbH+lWiUpU4iogxxIzzTfMjpgIe5cN66o+rGWHT46yaw2kKOKL3i/R4rqMNOUAP5SoI
         4zr0IburUejQl+KFpyFyL8uTUKBv/dWnMBZZyTjx+5EJyjYG2ixHJwxtUCaq6aqJpF6j
         nV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749918397; x=1750523197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJeJqV4oBTdIf5aRO/iLLsA9tYxv7L9gSsaCMHPq9lU=;
        b=j84igaVoCUT6Vs2hv41UY+lEllUSgpvoRtzmsf5OvUu0Oohtep+4pT6jNg+g+rknL4
         75xsSObytu+eP6q4iZS0/ABEU1KaPExJ6D6YzhVrK7VMYBTIHMdEjD5kG5RUvsYwc+py
         U7a0Qw8JvILmCdIJq0VKY9W5Tb3TIzdQySCEj9aXv4XWfCjOUu4mfUs0uvE3x0EKXcf8
         yeYXfGFxy8c4hJ85ATO98M8aYCXtKCFUBNJ5qS21M3gQiN+6MKpMPdQfuBpb/+WS9UWf
         D0xfFfHRehOp4liA+VDQXhBhx9QErThL3gURqbQbFpfUZDiIOoPxnicRHJfJg1Id97jO
         jRcA==
X-Forwarded-Encrypted: i=1; AJvYcCUhGl0XMQ+cGrQZuze9TgTudZ8x9OsXlzCrAXrsVaF0DT98c6Zhe/TivvWvmBf+zDK/5kZRwJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGZ0RLQCy2OL8qSoYjdxD4jMQbSG2ydR6o+b9F+4HXy8ZmNZd
	jPyqZrj0/c9+GS0P0nuHFGm8oGT/Osbykk2FYzg4IJAkPded6waLoSbgMD/YjzxphANgkTXlvO1
	+UP3Y+1sRSW3Da1b807K2pYUo4kyycGY=
X-Gm-Gg: ASbGnctbC3J7wfOGFEb9bO0wEQ0mkDVQ7MiucBApAClotsVpgg7auwIa49/st5X+a7Z
	jZBH4upC+eK/+5AEk2ImPFk+5s5DW5kwK2jd+C/oXNZzJ/51DWaw3ieHbe23zGOlEMbC5SClyTh
	aYtoqmAVOC0KJPfSKP7x3Tm+C6RxuJ5lIH8YBRCynCUrVTMA8wYfJR5PSrX2Tk1S5mO+pnnXbUm
	l3d
X-Google-Smtp-Source: AGHT+IHJg0xsJM4qBXylG9JD4JNzT3W7AJPd1Mic88j0qwt3654Ga4FO/tcPj5wWk6ZFcZ/mh7nsT06oCDyoc37Bpeg=
X-Received: by 2002:a05:6000:40dd:b0:3a4:f430:2547 with SMTP id
 ffacd0b85a97d-3a572398da4mr3139336f8f.6.1749918397187; Sat, 14 Jun 2025
 09:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal> <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal> <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal> <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
In-Reply-To: <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 14 Jun 2025 09:26:00 -0700
X-Gm-Features: AX0GCFsP1x3BQI7eR9Nwu15uWdMZS9XVRhhEesI-qy5ZjBUAQ6zAk0Asa-2uj0g
Message-ID: <CAKgT0UdkGK7L6jYWW9iy_RnZV8+FofSGV+HTMvC3-fBtCBoGyQ@mail.gmail.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 3:44=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> > Excellent, like you said, no one needs this code except fbnic, which is
> > exactly as was agreed - no core in/out API changes special for fbnic.
>
> Rather than getting all religious about this, I'd prefer to ask a
> different question.
>
> Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
> and would anyone else use them? That's the real question here, and
> *not* whomever is submitting the patches or who is the first user.
>
> So, let's look into this. According to the proposed code and comments,
> PHY_INTERFACE_MODE_50GBASER is a single lane for 50G with clause 134
> FEC.
>
> LAUI seems to also be a single lane 50G, no mention about FEC (so one
> assumes it has none) and the comment states it's an attachment unit
> interface. It doesn't mention anything else about it.
>
> Lastly, we have PHY_INTERFACE_MDOE_100GBASEP, which is again a single
> lane running at 100G with clause 134 FEC.
>
> I assume these are *all* IEEE 802.3 defined protocols, sadly my 2018
> version of 802.3 doesn't cover them. If they are, then someday, it is
> probable that someone will want these definitions.

Yes, they are all 802.3 protocols. The definition for these all start
with clause 131-140 in the IEEE spec.

> Now, looking at the SFP code:
> - We already have SFF8024_ECC_100GBASE_CR4 which is value 0x0b.
>   SFF-8024 says that this is "100GBASE-CR4, 25GBASE-CR, CA-25G-L,
>   50GBASE-CR2 with RS (Clause 91) FEC".
>
>   We have a linkmode for 100GBASE-CR4 which we already use, and the
>   code adds the LAUI interface.

The LAUI interface is based on the definition in clause 135 of the
IEEE spec. Basically the spec calls it out as LAUI-2 which is used for
cases where the FEC is either not present or implemented past the PCS
PMA.

>   Well, "50GBASE-CR2" is 50GBASE-R over two lanes over a copper cable.
>   So, this doesn't fit as LAUI is as per the definition above
>   extracted from the code.

In the 50G spec LAUI is a 2 lane setup that is running over NRZ, the
PAM4 variant is 50GAUI and can run over 2 lanes or 1.

> - Adding SFF8024_ECC_200GBASE_CR4 which has value 0x40. SFF-8024
>   says this is "50GBASE-CR, 100GBASE-CR2, 200GBASE-CR4". No other
>   information, e.g. whether FEC is supported or not.

Yeah, it makes it about as clear as mud. Especially since they use "R"
in the naming, but then in the IEEE spec they explain that the
100GbaseP is essentially the R form for 2 lanes or less but they
rename it with "P" to indicate PAM4 instead of NRZ.

>   We do have ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, which is added.
>   This is added with PHY_INTERFACE_MODE_50GBASER
>
>   Similar for ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, but with
>   PHY_INTERFACE_MDOE_100GBASEP. BASE-P doesn't sound like it's
>   compatible with BASE-R, but I have no information on this.
>
>   Finally, we have ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT which
>   has not been added.

I was only adding what I could test. Basically in our case we have the
CR4 cable that is running 2 links at CR2 based on the division of the
cable.

> So, it looks to me like some of these additions could be useful one
> day, but I'm not convinced that their use with SFPs is correct.

Arguably this isn't SPF, this QSFP which is divisible. For QSFP and
QSFP+ they didn't do as good a job of explaining it as they did with
QSFP-DD where the CMIS provides an explanation on how to advertise the
ability to split up the connection into mulitple links.

> Now, the next question is whether we have anyone else who could
> possibly use this.
>
> Well, we have the LX2160A SoC in mainline, used on SolidRun boards
> that are available. These support 25GBASE-R, what could be called
> 50GBASE-R2 (CAUI-2), and what could be called 100GBASE-R4 (CAUI-4).
>
> This is currently as far as my analysis has gone, and I'm starting
> to fall asleep, so it's time to stop trying to comment further on
> this right now. Some of what I've written may not be entirely
> accurate either. I'm unlikely to have time to provide any further
> comment until after the weekend.
>
> However, I think a summary would be... the additions could be useful
> but currently seem to me wrongly used.

If needed I can probably drop the 200G QSFP support for now until we
can get around to actually adding QSFP support instead of just 200G
support. I am pretty sure only the 50G could be supported by a SFP as
it would be a single lane setup, I don't know if SFP can support
multiple lanes anyway. I was mostly just following the pattern that
had enabled 100G for a SFP even though I am pretty sure that can only
be supported by a QSFP with the 25G being the breakout version of that
link.

