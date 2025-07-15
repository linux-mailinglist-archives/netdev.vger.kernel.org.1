Return-Path: <netdev+bounces-207091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31885B05A8E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC941AA5EE3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AD19C54F;
	Tue, 15 Jul 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaVS8fW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3A1E1A31
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583701; cv=none; b=RANFP73mTxzB9TiSzSObBbAJ2reb4wdWvpR1OGRTOS3QqqlUF2E22iZs/jFAidtojXhtXt7wFC7v746OUwdquTOQLKFNpUv9BCSv9X3V5wO8dJmLCPsRmQzNrpf3IJRKseK39WDSnwh7aI97ZYfwTBBAPZF7vkGMy/RgcxYJAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583701; c=relaxed/simple;
	bh=Xsn94KhfYDPob5T7ILfJZxwMZPCvqLY4rAJBN8k1GM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLcbdeLReTb0dfnR9eBBEcjm/7Ef4tKUQ5Z2crCXrsnV9wpiZhllQdP1Wfm2h+H6Te7OfUh69p5PBkfvgAr18q0yAORPzvhS1Fppijhqc1GFGyFtjFPJv542+4iRpuTbuRa2C+e4iOcW2ykreSWtrFQ8WNL9FYSVlSrsmoG8sC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaVS8fW4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1316307966b.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752583698; x=1753188498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HBwGjDe8VVwT28tNkqKGKyonOmj/gRV1EAAlCLgN/Y=;
        b=WaVS8fW4fT8Rf/O5OuA0yJ1gCAoYikmQr4BbeGrVUkZhhphbsqOIXSFHRYTMBa5OBA
         JbuzUBoe9fSJezmBHeIygrLeGjFpmmgCfxxUKsCvFDvqAXw6iyT/JqumgyShoruwmpzY
         HBVZBwR/RNXpdi6tAPieof8Q3qGNaavRTk/mNNOcUK6bccQPegbbTD6mEaMH44PpyE8h
         a0lxKFW9qmfhQgwXecXPadRter2zcGFYKkKLpsBqekiyBXZE76LABRfuAEXIOUa0LYHN
         4DPO5ggiAejtCVyODzHFhXFNJMoJl5S8+qHpWknJwG6rl12+N5ak1fZumPLeO7bse5d6
         nxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752583698; x=1753188498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HBwGjDe8VVwT28tNkqKGKyonOmj/gRV1EAAlCLgN/Y=;
        b=X0ZVURHjEdxp1FG3eQ09B3sV7dC5uV6wJsFSgHrMB3KHUcsNZ/SpWLpQfXsBqQeg8d
         lYTfOtOVw6Son2Krut9z2YnKvR9DPaL6741t9x5Ed2vo4nyaRtD2SJa1Rue7eYL7X9zC
         24IUqHQ95l+sFVwX0pEBRMl4TXXI0ye336bvMQDfQqtov2F6RI+4Gyx5sBQXD9I3hfKt
         DwtIxQr7EuOqmU4lCGasZ7oPsb6jbpxT5GUvfKraoDiDMi0nsgs9VYUXeDlNmYlokB8F
         qGLY1rBbIzjHqPPuHiNOGZ9Lo28mKb4PQOMEtZ1Kk8jxVsDV0+agJYyUi91MGNKmjxif
         T5lQ==
X-Gm-Message-State: AOJu0Ywotj/q2dMtWA9z+UwueukBDM8HSyDxSgmGXx73GNPGH45bpZWt
	rC8zvissZzQcuac1oBxgmCCtnuWAK4aEVjWmJYeZ0cxpuz4/r0VzgWrJQq8Di+i6gcRq5npL63j
	aL8moK5iuULz8xYXa6TzhYmHj6i4l//Q=
X-Gm-Gg: ASbGncv2ZS+GiojIW4hQe22YmCcS0+S+7PPN4X68u+P9Wd5rHaXdCRD4mzKtUZ3E/l4
	N6NtVLNj6HQf0oGhGSoKAQ12GB2/z4xQGJ1+kEf+PabcyfczoMQ6iRGm3nTym5Xy4Pd2iId5PUu
	wHI1V5lIdPDHIArxIPesARBG9slOSN7kAKYIS+DFFblrLvi1dl2yR/8TZnMnZ8FK+wl9K8JR8rw
	8gPFgs=
X-Google-Smtp-Source: AGHT+IEtIODGnwh1RSAYtDnwt+8x/DBSaBC5EJ97QDSDvKwyLreiP/6fUuRwXob+j8wT2SaU+xRFfhBo4W4sDjPXJk8=
X-Received: by 2002:a17:907:7ba5:b0:ae1:a69c:ea76 with SMTP id
 a640c23a62f3a-ae9b5d7ec4dmr268790566b.23.1752583698016; Tue, 15 Jul 2025
 05:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABJS2x60cwpoDXTex0M+CyOepWbdvX8-RcwFmBu-vxvNywW0tw@mail.gmail.com>
 <f84921a4-ccec-4418-9811-959989dcef2c@lunn.ch>
In-Reply-To: <f84921a4-ccec-4418-9811-959989dcef2c@lunn.ch>
From: Naveen Mamindlapalli <naveen130617.lkml@gmail.com>
Date: Tue, 15 Jul 2025 18:18:06 +0530
X-Gm-Features: Ac12FXybt6gSZZdD4ejOKIuAQpzX56CjuRSB4EyNaBe_c4Hy4oxn-WjfEhwasCI
Message-ID: <CABJS2x5N6qwe1nO_hWpaTaVjh4sWUDs4UE_g0_scW65_eDqyfA@mail.gmail.com>
Subject: Re: Clarification: ethtool -S stats persistence across ifconfig down/up
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jul 14, 2025 at 12:46:15PM +0530, Naveen Mamindlapalli wrote:
> > Hi All,
> >
> > I am trying to better understand the expected behavior of Netdev
> > statistics reported via `ethtool -S`.
> >
> > Specifically, I would like to clarify:
> > Are drivers expected to retain `ethtool -S` statistics across
> > interface down/up cycles (i.e., ifconfig ethX down followed by
> > ifconfig ethX up)?
> >
> > >From my reading of the kernel documentation:
> > - The file Documentation/networking/statistics.rst states that
> > standard netdev statistics (such as those shown via ip -s link) are
> > expected to persist across interface resets.
> > - However, Documentation/networking/ethtool-netlink.rst (as of Linux
> > v6.15) does not mention any such requirement for `ethtool -S`
> > statistics.
> >
> > So my understanding is that `ethtool -S` statistics may reset across
> > down/up, depending on how the hardware and driver implement the stats.
>
> I'm not sure it is written down anywhere, but the general expectation
> is that they survive a down/up.
>
> Statistic counters going backwards is not so easy to deal with. These
> statistics can be exported to third party systems, e.g. via an SNMP
> agent. So it is better they only go backwards when they wrap around.
>
> Having said that, this topic is not closely looked at when reviewing
> drivers, so i expect there are a number of drivers which do reset to
> zero on close/open.
>
> Feel free to submit a patch extending the documentation, but please
> make it clear that the reality is, some drivers will reset to zero,
> even if the intended behaviour is they don't.
>
>         Andrew

Hi Andrew,

Thank you for the clarification. That makes sense, I can see why
counters going backwards would be problematic, and thanks for
clarifying the expected vs actual driver behavior.

I will plan to submit a patch to extend the documentation, explicitly
noting that while the intended behavior is for ethtool -S statistics
to persist across down/up cycles, some drivers may still reset them.

Thanks,
Naveen

