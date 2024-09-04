Return-Path: <netdev+bounces-124825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0496B154
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC21C20E0C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6812DD8A;
	Wed,  4 Sep 2024 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRQfv+69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1712D74F;
	Wed,  4 Sep 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430469; cv=none; b=BmV2NQ00gB2bVsVAh9GefERlCIUOAnJyvWFLogxVwFFcT4rVv0w1DO6lZ8WgFILs6M1snFiM9eXVJNjsQUXH3j0OVgNKKsmOls+NGNfBCqbZ0PIdPxyPlIl1P0xorNDR3SnqCWNJutomp/VvxgCfOrdhH4XoYxWsDKTsgI+BhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430469; c=relaxed/simple;
	bh=A7Ol20CGaKQZ9UeOqfoYctWw4BO/w3Dq8e8ia0OEW9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiTF6UbIP/4fpOsduZZF2okoGwiJ3iuNR7zbptFUn2bu8vCGkiqmJGNhi7ZbWllTq+A/kWF3w4CEKClr9/5tED4bgrji0ijsvszjKfMm4AwXg9+m207PfZiKRwJOzwwlT4iHAyVG+SCTWqhzVBwgt5x9dxRd7KTUmlI1Y2mcWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRQfv+69; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-277fdd7d468so1337710fac.1;
        Tue, 03 Sep 2024 23:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725430467; x=1726035267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ntGNQX8ooCG660UEQhJ2p32C+ITOVnSqhmpySBca4sI=;
        b=JRQfv+69gQoqy7DrYnC3zMRGHpWHO1/R1LZk65sXK1y+0OCcuJa+6DpQdwE6XRo8yB
         1mzVqbnim56oUIGDGbVn3tcmprbJ6vHT+3QiB+kRk6SgLdsLFU5TzFOOTlRxZDyNfSWp
         wJ9xfRSHJZ8cx31lIEgu4hZgDNR2MI2bkClmz/MkKXwtRDBxk2YdxzFSL2IKadD7Var9
         BkJmhmHXzrirSp9FNKkfeDvTDRkEyZuEvmCVWcVJCPAPo1tiLujZJqmh71+xxxT8DgNC
         9TEnit53zelaap2yUfEGQnmGX6Fes2hVvNaInWzuyronvvO3hxB/XT0pLq4jS3UnQgGt
         sDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430467; x=1726035267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntGNQX8ooCG660UEQhJ2p32C+ITOVnSqhmpySBca4sI=;
        b=CnJKlFWhfXY7azToXk39Uoo+QkTcF1/U1jvtBODLL11uRokDbDYtwjJphdlrh/MJ4O
         lSTEndTp2SybyuhsYDN/sxmxJAmlToC7xW5PrLc9GyyP2JJqv0LNr9n7Osrg42j2+nAs
         rvK5np+wdvooHQqjiDzbqe6tecUe7a+1QF8XrTOIbJFernVlp8AjEjK2wfoaBXGx8769
         u8QTKsG9q/afvAhfGRc6kGA6Q+DCXTcd7JiFPAT0UPMsICpmmC6LhCEjJk1fmZzUN/Fj
         Ewz7Xw/Dy2ifUdAWAj9xW7pc17jlIklUu4AVGa0QTS2RCRYrwLs5grQiQO81INZQNRMd
         cnoA==
X-Forwarded-Encrypted: i=1; AJvYcCWFrPPkQr6xiNOfAfPW8i5amWUO5aG5xvVUXwvCE4hC5U5p7WmZgNuLCozoVpv+o3RXYtdeXqj7+vSnOgg=@vger.kernel.org, AJvYcCX7Tl0jA8YkqgvUzxVvDGiGCobsSrkFHnaciiidZ2EJ1wCdEftBDFO3YpGoIwgYqHpz+RehszOi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8goBkq1n+N/VvMtJic+M86rirEBW0eMeQ1V5qcy3VpH8bDkkF
	ItXGbvChYMyVgUCRhdEcxQr1PaDqTURiVYkgyMyaRPhln/Zy1BJjmJPwYokiSgTDSIFWmp19yKz
	NkITYuFlHtkobKBJhjKGQNDU2S/w=
X-Google-Smtp-Source: AGHT+IGhmFyBEvCjap7NOLKy271m7LWln0enLzxRQbw6tBNtIQkHhfFqU5zMy6+Lo1l2WFma3cZszynDRTpjFCYznxk=
X-Received: by 2002:a05:6871:5cd:b0:260:e58d:5bb6 with SMTP id
 586e51a60fabf-278002ec341mr7975821fac.19.1725430467227; Tue, 03 Sep 2024
 23:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903072946.344507-1-vtpieter@gmail.com> <20240903072946.344507-2-vtpieter@gmail.com>
 <23ae38b92f44b1cbdd703b2785ad7e50e82e7c1b.camel@microchip.com>
In-Reply-To: <23ae38b92f44b1cbdd703b2785ad7e50e82e7c1b.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Wed, 4 Sep 2024 08:14:15 +0200
Message-ID: <CAHvy4ArvDazCeMX=AbKi67iJOUUy63djFDr6rr9Z-PWqABA9UQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: dsa: microchip: rename ksz8 series files
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	linux@armlinux.org.uk, Woojung.Huh@microchip.com, f.fainelli@gmail.com, 
	kuba@kernel.org, UNGLinuxDriver@microchip.com, edumazet@google.com, 
	pabeni@redhat.com, o.rempel@pengutronix.de, pieter.van.trappen@cern.ch, 
	Tristram.Ha@microchip.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arun,

> > -         This driver adds support for Microchip KSZ9477 series
> > switch and
> > -         KSZ8795/KSZ88x3 switch chips.
> > +         This driver adds support for Microchip KSZ8, KSZ9 and
> > +         LAN937X series switch chips, being KSZ8863/8873,
> > +         KSZ8895/8864, KSZ8794/8795/8765,
> > +         KSZ9477/9896/9897/9893/9563/9567, KSZ9893/9563/8563 and
>
> This line misses KSZ8567 and 9893 & 9563 is mentioned twice.
>
> It should be like
>
> -  KSZ9477/9897/9896/9567/8567
> -  KSZ9893/9563/8563

Indeed I messed this up again somehow! Fixing now..

Thanks, Pieter

