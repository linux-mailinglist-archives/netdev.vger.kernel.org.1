Return-Path: <netdev+bounces-119695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC78956A6C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CDAB25D0C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0D1684B9;
	Mon, 19 Aug 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQDv8JBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6E166F3B;
	Mon, 19 Aug 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069142; cv=none; b=sN4b3DyX5gt8KLxhKCLtuzKvL2AsMVB1ZfOlXct4dMRfyqkfVnakAAdok1nQ6GgJxHQ92aTc2ospSspBTOYWvWCltV4vPdbP3P8XHRUE3czdKsD6yT3z+TMIpRMbReOIZnaQvEsG9hWvEF1Kzk/dHkKYMhA6GRWCmGSyKyjxaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069142; c=relaxed/simple;
	bh=myQ2izwA1c6xffD1CaeDvuz/WBIh15dZWQdpm/qXHj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tne9pkac/3rYJu1B90R/GVpJi0/fQJ30XWjeLEe+ufB854KydSHIquRhCPA5WW9dSEz1ToL7oAXFU50L8fyWU+v9har9nXqPnEd3VG4KRedHcx0GvZ4cvVfK5eJ7uclLb4S/L5/hioBaLom2SCOSpHzzr7gmHCVoWwDYi84bGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQDv8JBl; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so2655181eaf.3;
        Mon, 19 Aug 2024 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069139; x=1724673939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=myQ2izwA1c6xffD1CaeDvuz/WBIh15dZWQdpm/qXHj0=;
        b=dQDv8JBlLER0sdSMSC6liKxX+AFl6Vzc8zGcej84xEqKj7PpR0/o6TR12wGbGajDw6
         KV8hPyJZ8zI++U3owYKgZYKq4lpTKqELdLelAwHecY7Pble2gtuVvOhDoGQa7Jij/V5W
         hVAoUGsdF6aVO9rMnSsoNc4M2+9CeDFeiwHC87B3eDyzr1TBtiuN5k9WR2VIYx4DztwE
         w0sqBZyr6GjOnInfAdlcFgrIR2VoCBNDQtHoxoqNF9DlqreDTR+/4FXnHxPeWmbheumQ
         U/AmW5W7WMNUgMZU1EVBdlpWM/5BbMuOrnQduBwKA6IuhHKVN1P/beOpwpWCMB4YHHn0
         SQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069139; x=1724673939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myQ2izwA1c6xffD1CaeDvuz/WBIh15dZWQdpm/qXHj0=;
        b=lLkX295ts0GJTI56udgGvIswbnhCxGb0JYveKBl3UKzoTLyNv4ETlk2DscPREfwEq2
         Z69vWJUrgUvz9zCfz9zDxCXMdyHpfMUBlYtdb2C9UDcRpb03JEvZDV5TxCgy4q7Cg9nt
         MKe9Y3YzD14c9UAyKJlNrZpwOzjaqAkmLqfSaK/ubg2cvu1w+1/R+8dhhyyqMDUIztZm
         nMEt65T1O/r+H2PZuPMjPJ+yUbgckCGJZxlP95lqoH7eEk7u3uocqkY65EjUZpMa8ImI
         DVo8OX5cXtkKrTRmqkKkyyAGR8o2SWNvZoCABOIczFbWf8QYZwh0mJiGyd6U4KBuDY32
         dTuw==
X-Forwarded-Encrypted: i=1; AJvYcCX+5MahiSdyNwGt7wEBdcvOf0Xa84KPeWq4mfCDd8mGGRzchdauTSeH8cnV/R7BnDSkQaQNC+RbMrONLXwaOq6YZPKP0qX+lZMk4ouHxmhf6HDt++HgtltLHQJrNjhrEyBcZZkE
X-Gm-Message-State: AOJu0YxTXtdV6BFkcnziopkitk4cwE5yI2ErnZiOOads8mBYWgC8BmG5
	K8Xd6+mN0ZlJayciDSLffUfVuarEzv8P+99ZZffAvE/OsaI49nUm/rfoyxme5IlZY0JAhTnKudR
	AyGM6TvCxD0RfKwS3LkzwUeXR7Ws=
X-Google-Smtp-Source: AGHT+IHkgmz5Vw9oKF8SbH3YtZC93/ypDzV6fLmUrNwA2ETAak31GBVb1OW27J2DvgVtX7OQOC0dypQkngxHERsECog=
X-Received: by 2002:a05:6820:168a:b0:5c4:4787:1cd with SMTP id
 006d021491bc7-5da98026986mr10184265eaf.7.1724069139649; Mon, 19 Aug 2024
 05:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819101238.1570176-1-vtpieter@gmail.com> <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
In-Reply-To: <20240819104112.gi2egnjbf3b67scu@skbuf>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 19 Aug 2024 14:05:26 +0200
Message-ID: <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> Hi Pieter,
>
> > - DSA_TAG_PROTO_NONE
> >
> > When disabled, this can be used as a workaround for the 'Common
> > pitfalls using DSA setups' [1] to use the conduit network interface as
> > a regular one, admittedly forgoing most DSA functionality and using
> > the device as an unmanaged switch whilst allowing control
> > operations (ethtool, PHY management, WoL).
>
> Concretely, what is it that you wish to accomplish? I see you chose to
> ignore my previous NACK due to the lack of a strong justification for
> disabling the tagging protocol.
> https://lore.kernel.org/netdev/20240801134401.h24ikzuoiakwg4i4@skbuf/

Sorry I definitely did not try to ignore your previous NACK but here the
motivation and solution are both different, which is why I did not consider
it a patch iteration of the previous one.

Previously I could not use DSA because of the macb driver limitation, now
fixed (max_mtu increase, submitted here). Once I got that working, I notice
that full DSA was not a compatible use case for my board because of
requiring the conduit interface to behave as a regular ethernet interface.
So it's really the unmanaged switch case, which I though I motivated well in
the patch description here (PHY library, ethtool and switch WoL management).

The solution is now the one you proposed earlier.

> > Implementing the new software-defined DSA tagging protocol tag_8021q
> > [2] for these devices seems overkill for this use case at the time
> > being.
>
> I think there's a misunderstanding about tag_8021q. It does not disable
> the tagging protocol. But rather, it helps you implement a tagging
> protocol when the hardware does not want to cooperate. So I don't see
> how it would have helped you in your goal (whatever that is), and why
> mention it.

Right I understand, indeed a misunderstanding. Will remove this part.

> tag_8021q exists because it is my goal for DSA_TAG_PROTO_NONE to
> eventually disappear. The trend is for drivers to be converted from
> DSA_TAG_PROTO_NONE to something else (like DSA_TAG_PROTO_VSC73XX_8021Q),
> not the other way around. It's a strong usability concern to not be able
> to ping through the port net devices.
>
> At the very least we need consensus among the current DSA maintainers
> that accepting 'none' as an alternative tagging protocol is acceptable.

This of course I understand as well.

Cheers, Pieter

