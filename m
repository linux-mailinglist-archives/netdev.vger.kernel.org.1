Return-Path: <netdev+bounces-230190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E078BE51DE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118A64EF67C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6522424E;
	Thu, 16 Oct 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob8y+cQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E223C516
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640827; cv=none; b=AfSOPpZQoeqI7dne4eLzO6PNlkO2uHAOi6zrVNCIP7JQ11rEEH7Op+NrjUBu+yeHIcTJhAbVwfzIwfVREMCEdQU0dFloZBzW6rEoyqvT55HVEy5DrOkQraGyzzYw/CuqXtnzc/cyjxZtj1ObaR9pTYoefmEk0S2+O1N8eDCw9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640827; c=relaxed/simple;
	bh=MJ04rX3XkSBkvTok/bJnoouZLIdDfY2CseOfTojI+2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CC8LT5SotG+y0qZiSwNVOCm5bwmWcO0LI7rmF9JNPMxJfHppQ0gudUjv1IX6s7X9SsfgUuna6FPXfXXWjF+TJvrLzmbGCZW5gOE0/FsiVSoUMyhnOd2Ald5qCVLhB4Okx9ov3ykaYP560qPiQuchCy/c14eo8CRTZfvwyATYCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob8y+cQ3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ece1102998so889716f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640824; x=1761245624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mqzXmAQ50Rc5bcmH208zXLpg7zAZdmyFj4xDWg5G6o=;
        b=Ob8y+cQ30H8b+jWYxzJTpgnB/qP0OHDtMWhYkaVWjKQX44L3Z6Mfusc7+L9bMU0P0/
         IvmblgLi9/w2fZlx9t5OiFnNxiaHn0fK/N/csZtnNWOuTsOa94DoTimLIPZWQSUeFvks
         +1wWhZSH4OZEireqBt/8+Vgznbo5nK8+L3Hvdz7zwslvlZWx4o09gAOJobTUvhFRD0S7
         0EHIcYhU50LctxLw4Lj8zgtoV4DsiiEfwBAkb1TJSC3MhReu0uztF0EdW8mdG9HG2na2
         0jNfp9NDIOa3L4X5nvOgPmcou/ceYfODWpvJL0hNb5xiOm2i+5rTZmk22u3gOEHZ1Y08
         PxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640824; x=1761245624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mqzXmAQ50Rc5bcmH208zXLpg7zAZdmyFj4xDWg5G6o=;
        b=Wf0OgN0nOZtxjpbdaphnNcD6Tu3PGJtn1vlTW9U+Gz0fz1zMeVxgNd0fuD9OD0MTjB
         f6YfxUR/Z/ux4yxOxLQZpwRsdGF4UaYgxtTrXXOac+xC0a8La1yZIOV2zQ9Zvr1VvGJR
         ebxpGW11LRd2ZbGSOqq/hA293x/53tlV0VpqQkeaZhJG1WECG2TC32srTL5TlTX3PtcB
         JlXh2G7n/ozymtsn/lRnHvdmkM70XdPCt7MyQYawqsvh8rejl7kGB0yEPFNCxJx6QmVL
         hLrtOTKtGdsKxGvQa/xFu/uqGoxo0uQT6tqE8JUXwGKyJPVw5gx9pts1SaeeWORrDvuN
         uUGw==
X-Forwarded-Encrypted: i=1; AJvYcCWzPLBT9E2taYx1lCYHd5p/EwHnoHeHW60b3K3sQAz1UroXQCU4VzEhiGNnLckkktBP69DxuU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsYRJwQSlpE5XSdPZuXv91qPjlu0/AuNJEjioP/kWdcBROigV
	o8luMeAyO5ubXudfNmHMxAsLqdpvoN+PvRip0wBUl2ngD0Eg9uO3/uJB97vzP3CaxBM2+WRb80y
	+91rQ5p68Nuc3OzTyR/0TcZHHJn1oU/o=
X-Gm-Gg: ASbGncsa3GtLsk3VQQ1jlbcDycm16MNmymPKVQxgwXAYnb3KRYzEuL2SxWFh1rlizWG
	lg4RYHH4aIbE0Vj6SlkPiPeMFzS/67zMFYVzPn0R4Tg2i7gO34kNbhQNxNoXEfjZZ0JZJxBcynb
	+G+P5Edjs2ZakCKafZIX8VtmKq98R3n4kDbOucGStaNR6Dv/m0as3qVoirtC7U5Cwori+NIH2pn
	VkELO1XlHrlTCbdO9QT6wht7Q6C25sYtwSEcPUPpIH+FuItmntImWP6GHDFm2BOgwWnTu4dsvOK
	HF6R//NAANZYkKCPEVVUJIWQ0AzVGw==
X-Google-Smtp-Source: AGHT+IHhdgclFdo/jd6bons/G8sScySn6wGDuS6vqOFInfkOckOnahc3Uha5R92s3rwwgaWDN2XM43s6dNdaIy1xYhY=
X-Received: by 2002:a05:6000:2309:b0:426:d301:a501 with SMTP id
 ffacd0b85a97d-42704ded9d8mr719367f8f.62.1760640823754; Thu, 16 Oct 2025
 11:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210601005155.27997-1-kabel@kernel.org> <CA+V-a8tW9tWw=-fFHXSvYPeipd8+ADUuQj7DGuKP-xwDrdAbyQ@mail.gmail.com>
 <7d510f5f-959c-49b7-afca-c02009898ef2@lunn.ch>
In-Reply-To: <7d510f5f-959c-49b7-afca-c02009898ef2@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 16 Oct 2025 19:53:17 +0100
X-Gm-Features: AS18NWBfdkOYg0lWdUnzcKi5SK2B8n5vdgUohorTtHmKCqbaebeIlifqCtH2bR0
Message-ID: <CA+V-a8ve0eKmBWuxGgVd_8uzy0mkBm=qDq2U8V7DpXhvHTFFww@mail.gmail.com>
Subject: Re: [PATCH leds v2 00/10] Add support for offloading netdev trigger
 to HW + example implementation for Turris Omnia
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	linux-leds@vger.kernel.org, netdev@vger.kernel.org, 
	Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Russell King <linux@armlinux.org.uk>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Oct 16, 2025 at 2:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Marek Beh=C3=BAn (10):
> > >   leds: trigger: netdev: don't explicitly zero kzalloced data
> > >   leds: trigger: add API for HW offloading of triggers
> > >   leds: trigger: netdev: move trigger data structure to global includ=
e
> > >     dir
> > >   leds: trigger: netdev: support HW offloading
> > >   leds: trigger: netdev: change spinlock to mutex
> > >   leds: core: inform trigger that it's deactivation is due to LED
> > >     removal
> > >   leds: turris-omnia: refactor sw mode setting code into separate
> > >     function
> > >   leds: turris-omnia: refactor brightness setting function
> > >   leds: turris-omnia: initialize each multicolor LED to white color
> > >   leds: turris-omnia: support offloading netdev trigger for WAN LED
> > >
> > Do you plan to progress with the above series anytime soon? If not I
> > want to give this patch [0] again a respin.
>
> What features are you missing from the current kernel code, which this
> series adds?
>
I=E2=80=99m working on a platform that uses the VSC8541 PHY. On this platfo=
rm,
LED0 and LED1 are connected to the external connector, and LED1 is
also connected to the Ethernet switch to indicate the PHY link status.
As a result, whenever there is link activity, the PHY link status
signal to the switch toggles, causing the switch to incorrectly detect
the link as going up and down.

Cheers,
Prabhakar

