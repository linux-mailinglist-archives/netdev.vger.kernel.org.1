Return-Path: <netdev+bounces-194395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639FAAC92E1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE0188ADD3
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672AF235055;
	Fri, 30 May 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpo6jYd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E920AF98;
	Fri, 30 May 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620754; cv=none; b=gD2APEgIovBuOBDd6qNpA2iGOvZa/uaCFur3irMJJUCEHjDDTQuk1dTpXTqzFq7ShWukaFPsEXkqEvFOxoMaDEpn3Jn+7acqWZcbdHv9VE0qRV8zVogchedlFpLh7afFXF8fYDXp9vLQbCLFKR1m1lAMAQaTVn1BM6fyrw5OHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620754; c=relaxed/simple;
	bh=3b/j2p8/A0nzwn8KAPA83lK1/OE0Z6OzCby2nHC0LHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D1abRbZV/bcz1PwofbRzcVXiRiGtqMioncHw0wH0tnxaqkC4zQRb6RDkpzNR1Ql0XuqoDj6TIeI80OAeJ7nmw6Wk7SCZTEoOlx4R8KyHB8hsGVwS9YJjd1bYLEm92p6rHjJj/8/RCTPIhP2uAXoFEIdYQjuafLab61tF6gZMI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpo6jYd6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so1911732a91.3;
        Fri, 30 May 2025 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748620752; x=1749225552; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNGwv4fAq8CT7cI87tqcv+XlIdXNzOHt3NdBDeO4nl8=;
        b=jpo6jYd6yXL4O6sBdgY74aCLknxmrIRtSfjt43+cRifYJt5Oni0jzrvxOsma03fFD9
         R676zpNCFCN5/JN5N02qfdacMIRKf8X7me/U/F3uTVzdQcXWp98cDHzrXa4jC1512xst
         2P+9uDmDxO4yJZA46xiGhAtbDGekEMd9BBoAYWo5rL7sl3zjIeoTfqM2kMmL3nZqckam
         y6EMqFVNmvmMCCZtILkqvytEB2ajgbjAtB4CY6gYvIW2OynTypvKa3ji0UyTyO+5jAMW
         E6GX0cArFgTtsfodd3wlkBPCYI1+07KBfZtTfUpklGi5y1E2wkYR5copYexCaHXx+dNQ
         d8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620752; x=1749225552;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNGwv4fAq8CT7cI87tqcv+XlIdXNzOHt3NdBDeO4nl8=;
        b=hZp9JhJGHDvAcOW47xWBAb0tLBPWS1d5A6rJLPVVJsyNkz7JaQIQPKFu/95oBxHvk+
         40piUGaHDXtjUhqEQG/sHdUUM2MgzflkOdW9SNscgHUiJA+aZ+Vr4FhTIV/07+J2JTvw
         uWI5B8i+NIuFuTgOPqQbnJYVMVqXAUbl4dDh6bvpJdsXz/mUy7B/GGWkrmRe/SAuTaz9
         vTit9uawg5leIgomq/1CVYDROx9BZlNhbGKHjpDGGz9nv8YwQrLUX02Gh+UKHHoWh8X9
         ltFhS30TwK9Ff+VKumpQqWJm3+KsdwQyYnhKGShLz1jvKRXoiMIj1sEFU9rvGleRk73o
         poJA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Q3iD/m/TUluzQPvpPgjKaWguysPv0xvmYkS5e43GhOvUCzTuuKsifGa5jkYUwU7H56AUPfZ1CauN5Uw=@vger.kernel.org, AJvYcCXuKPVtWKxXqQ4KWOx+Xqb73I4UMnDZ7RCoSNPWdJM5OrJwz7/17kr+6il3c/YPszZAMfax6I9O@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKxSDVns01kliDBybI4TS3vo6KzX1IM3+tELNHre8YLdIf3po
	/YqPWDwqiQAjHdP+Xtwo/z6qgHO5e+xPpjSzZ+8koVosV75bkfR4lqIxEyEy9Is7hHwQyui41To
	O72tZJYtfwFky2IL/Xf4RkLyQeYW4R6UQsA==
X-Gm-Gg: ASbGncsOptTzfPYu/zbd7bhXP6E0aFNwxjzmUCuJbYwM3Zy2sUA54kCN3KAi7pQoJA+
	eFrZvYIeUOWQ/WvbeM+3MKgafB8QYGX/41OOZ9sUXWzgJ5wPQIpyW8M1pd8X/71ku5tKNQ4/qu+
	FTBqpCFeyWsP9vSsdtZ6lqXKZydS/Y3JhVd4UDUFxRVEek5g73QpfOTTGAQU9xIhuXuzY=
X-Google-Smtp-Source: AGHT+IGEM67IA+KNd9AXkA7CoruGO/K0PIq5DSHiGxSP4f20FL820N0FagCNlao/fX6ogFIcvxxXyi7Eyhjgvr7jBIw=
X-Received: by 2002:a17:90b:17c8:b0:311:9c9a:58c7 with SMTP id
 98e67ed59e1d1-3124150e626mr6890001a91.7.1748620752000; Fri, 30 May 2025
 08:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530155618.273567-1-noltari@gmail.com>
In-Reply-To: <20250530155618.273567-1-noltari@gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Fri, 30 May 2025 17:58:36 +0200
X-Gm-Features: AX0GCFs5r8NMua92KA_uc_Vr6n6-poaeQqSMLlLdCTCqXaNDNBk3m0zXKnR4RHI
Message-ID: <CAKR-sGdu7D6StqwEahdGbM8oxL8J8amwEPiS8scVphfuPLMLhA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: brcm: add legacy FCS tag
To: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 30 may 2025 a las 17:56, =C3=81lvaro Fern=C3=A1ndez Rojas
(<noltari@gmail.com>) escribi=C3=B3:
>
> The existing brcm legacy tag only works with BCM63xx switches.
> These patches add a new legacy tag for BCM5325 and BCM5365 switches, whic=
h
> require including the FCS and length.
>
> =C3=81lvaro Fern=C3=A1ndez Rojas (3):
>   net: dsa: tag_brcm: legacy: reorganize functions
>   net: dsa: tag_brcm: add support for legacy FCS tags
>   net: dsa: b53: support legacy FCS tags
>
>  drivers/net/dsa/b53/Kconfig      |   1 +
>  drivers/net/dsa/b53/b53_common.c |   7 +-
>  include/net/dsa.h                |   2 +
>  net/dsa/Kconfig                  |   8 +++
>  net/dsa/tag_brcm.c               | 117 ++++++++++++++++++++++++-------
>  5 files changed, 109 insertions(+), 26 deletions(-)
>
> --
> 2.39.5
>

Sorry, but I've just realized that I generated the patches with "-N"...

