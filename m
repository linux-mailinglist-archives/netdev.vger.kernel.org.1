Return-Path: <netdev+bounces-230036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E0FBE3230
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19D8A4E46EC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4EF31AF01;
	Thu, 16 Oct 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkSana0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161852D320B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615056; cv=none; b=Wlj718P54RtaAPPiWZOGJOWdwfp97iRDy8nhOSWyqyhT1VUXJkVT8VS0kOgX4wC7kowJiNtvIYM5jvE3nSUxWltVVZOT89CQyfTmv/COZ/5q4iqRaAleI/2CFHxXALa4V8lfOfrhNzf/l5IqATA37WcQ1NALpSMAiSzoyryFiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615056; c=relaxed/simple;
	bh=agF1F2bUUnTySHOP+8Tsl7BwpaOdiIkiME53zY9wyG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWv5Kn7XcGdlsxYJ4m0FMwNEkXNx/RDxOS8RLrBQUp3fpjVDYn1mx6sECqajKb++fbGJYSPxA7RnPxJXrOgS1krIcM9TcC1iHswfwyVeRoo0w2o/8T51aZXQSAzyjU39ZKu5XlKeUZ2vey1xWSbRVrRfJz10iAk50Agiv9AyBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkSana0Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42557c5cedcso374272f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615053; x=1761219853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIQg+89QMe3VLlp2MASGpefw/MW7UYkrgkA5Oqa2nXA=;
        b=hkSana0Zeh55run/O/otGKPi547dTffQ/2xlhuz+nFeCkwd3JCuqGXXgFDUVfZjayl
         ZLDtPtlh51fUNGSL4PZg/DBQpK5HeFLrjbPKLM/oyrYRQdn9HC/KZxsLOTYvcYDfiT/q
         85eA4bTZeq0vR2NXziZ4kHhtL1qwk9egIrVUCFPoxbr1r5090iQaadY7WVZUUlHXk7yi
         OZft1M6W1ANehFHeSFo7PX+PWWExB7FuT+KwxPZyJqTdosmy9jy1B0KyPjx9HbtKNL4b
         gUsJR35dic2urDkJJg6f1N1yWy1FuQioz/5+76CoigHKRokz6zPzgwfqwai2U5jnA1kx
         Qx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615053; x=1761219853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIQg+89QMe3VLlp2MASGpefw/MW7UYkrgkA5Oqa2nXA=;
        b=w/UV+P+bF/hqho1aJBOEzFBcBz3f6e+EgNuIWdgOE94XWzWeszUuAAheH3F0PgCCfi
         P7g1SRW5HxuDwfKZvSEXENIR8KhMov6F9VMSTpZZE5JHnpFrLaXQh82cPQStv9XTleqy
         z21BJCGT62HSCm6Mr0tNV6sVyFeane8roO9Le9vDiKH20T83tcLx1XLoBKtx3vDQG1vH
         AiizKuIURCkhm6J9/8CIsGIBnDFVHK/WS2vKmPZ2gxcfoAwzQQubAAwWHPvLYUEe4WVH
         S57DsqX4Pyz5eE2bfaACQKeCBPRvjuCZ9V8qujPzmmHtvGKiHjWPpK++nk/pr5dQ1jD+
         +UQg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPNzs5mwF9FWCJsUPK7BqTpHSe7gAhQQTs3aEp11SeA1Lz4zsN54jtIvMnNYiLrOFVrRNRnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oKWfQkEPgBWVbnhwBHBx/7hWENPG33IyNOj+mpvR4F5PUiyN
	utSc8UzJa3+RFpbtuf2WkMuZnNLIfRCmhkOyWx0yMjiwxpMpEgpAVtWGACEgVn55fjF9s1DzQjj
	SaG1o/cnAsLM3p/40kbaYvTXPHWyVdss=
X-Gm-Gg: ASbGnctbH7ClnW04xt8fjICOkP8rodEinott/kqZo2pS1kX8McvyV+FpziRCS7ETg1k
	HU69FvT0MHcz8G1x7o0goA0bp0l+8HbuTPnz2Ky48uufXsmh860AXz1ChRRmi3ML9ZBhzAYSUBw
	ANxOeaOt046G95rYqDu0POukbEHB+iP1NeY0i0CBqbFBAV0QQb8ByvzR2eIQLRZgnOlPwpJknqh
	tVE2xMU3YT1WzW6V/CdVsNtouC3RwU+NB4qoYeNcAV1UtoRZZ2yZ1baj7z9b9/9kuK5z85UuUe0
	65SOf/Etv6HVn/wANTo=
X-Google-Smtp-Source: AGHT+IFWoH+IpToyfwfvy9H0WwkdW5oDffhLfyiryEU2bEP0OfrPczQI/80RnNyyzP9l9WxI1uXWrCYGND6G/4gh+9U=
X-Received: by 2002:a05:6000:607:b0:425:75ab:cce5 with SMTP id
 ffacd0b85a97d-42666abb4ffmr24304468f8f.5.1760615053106; Thu, 16 Oct 2025
 04:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210601005155.27997-1-kabel@kernel.org>
In-Reply-To: <20210601005155.27997-1-kabel@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 16 Oct 2025 12:43:46 +0100
X-Gm-Features: AS18NWBU-wtVr5kLmrZv7bertvZq4Wnh2O08mxKVk8ekzeQgzZFVdBE5a6YusNY
Message-ID: <CA+V-a8tW9tWw=-fFHXSvYPeipd8+ADUuQj7DGuKP-xwDrdAbyQ@mail.gmail.com>
Subject: Re: [PATCH leds v2 00/10] Add support for offloading netdev trigger
 to HW + example implementation for Turris Omnia
To: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: linux-leds@vger.kernel.org, netdev@vger.kernel.org, 
	Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Tue, Jun 1, 2021 at 1:53=E2=80=AFAM Marek Beh=C3=BAn <kabel@kernel.org> =
wrote:
>
> Hello,
>
> this is v2 of series adding support for offloading LED triggers to HW.
> The netdev trigger is the first user and leds-turris-omnia is the first
> example implementation.
>
> A video comparing SW (left LED) vs HW (right LED) netdev trigger on
> Omnia
>   https://secure.nic.cz/files/mbehun/omnia-wan-netdev-trig-offload.mp4
>
> Changes since v1:
> - changed typo in doc
> - the netdev trigger data structure now lives in
>   include/linux/ledtrig-netdev.h instead of ledtrig.h, as suggested by
>   Andrew. Also the structure is always defined, no guard against
>   CONFIG_LEDS_TRIGGER_NETDEV
> - we do not export netdev_led_trigger variable. The trigger_offload()
>   method can look at led_cdev->trigger->name to see which trigger it
>   should try to offload, i.e. compare the string to "netdev"
> - netdev trigger is being offloaded only if link is up, and at least one
>   of the rx, tx parameters are set. No need to offload otherwise
> - a patch is added that moves setting flag LED_UNREGISTERING in
>   led_classdev_unregister() before unsetting trigger. This makes it
>   possible for the trigger_offload() method to determine whether the
>   offloading is being disabled because the LED is being unregistered.
>   The driver may put the LED into HW triggering mode in this case, to
>   achieve behaviour as was before the driver was loaded
> - an example implementation for offloading the netdev trigger for the
>   WAN LED on Turris Omnia is added. LAN LEDs are not yet supported
>
> Changes since RFC:
> - split the patch adding HW offloading support to netdev trigger into
>   several separate patches (suggested by Pavel):
>   1. move trigger data structure to include/linux/ledtrig.h
>   2. support HW offloading
>   3. change spinlock to mutex
> - fixed bug where the .offloaded variable was not set to false when
>   offloading was disabled (suggested by Pavel)
> - removed the code saving one call to set_baseline_state() on the
>   NETDEV_CHANGE event. It is not needed, the trigger_offload() method
>   can handle this situation on its own (suggested by Pavel)
> - documentation now explicitly says that when offloading is being
>   disabled, the function must return 0 (no error) (suggested by Pavel)
>
> Marek Beh=C3=BAn (10):
>   leds: trigger: netdev: don't explicitly zero kzalloced data
>   leds: trigger: add API for HW offloading of triggers
>   leds: trigger: netdev: move trigger data structure to global include
>     dir
>   leds: trigger: netdev: support HW offloading
>   leds: trigger: netdev: change spinlock to mutex
>   leds: core: inform trigger that it's deactivation is due to LED
>     removal
>   leds: turris-omnia: refactor sw mode setting code into separate
>     function
>   leds: turris-omnia: refactor brightness setting function
>   leds: turris-omnia: initialize each multicolor LED to white color
>   leds: turris-omnia: support offloading netdev trigger for WAN LED
>
Do you plan to progress with the above series anytime soon? If not I
want to give this patch [0] again a respin.

[0] https://lore.kernel.org/all/20210930125747.2511954-1-frieder@fris.de/

Cheers,
Prabhakar

>  Documentation/leds/leds-class.rst     |  22 ++
>  drivers/leds/Kconfig                  |   3 +
>  drivers/leds/led-class.c              |   4 +-
>  drivers/leds/led-triggers.c           |   1 +
>  drivers/leds/leds-turris-omnia.c      | 284 ++++++++++++++++++++++++--
>  drivers/leds/trigger/ledtrig-netdev.c |  56 ++---
>  include/linux/leds.h                  |  29 +++
>  include/linux/ledtrig-netdev.h        |  34 +++
>  8 files changed, 377 insertions(+), 56 deletions(-)
>  create mode 100644 include/linux/ledtrig-netdev.h
>
> --
> 2.26.3
>

