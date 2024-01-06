Return-Path: <netdev+bounces-62133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24D825D58
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 01:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640A71C228B5
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 00:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3D210F2;
	Sat,  6 Jan 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWUkDdeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635710E6
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed7c0741fso48338276.2
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 16:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704500267; x=1705105067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtmIp/5jJlfTvNy6LJ3hDr7M0F6S84IB/YrS6vkaJ/s=;
        b=RWUkDdeIHy9iIhB+4+/Qdn9w3P9xHuuyA5/HiYdKKxXA7SYosm11G+yoNYVS7N9Cvu
         UvbefNRS8T0B520u9mHVuPbJZAIT8RLUHhaORhkNGYqDYxZUIRqOl8vDiHUmyUaypqBS
         gMQYuLDYmTJ1LMpremr9i7tC9rg1SDxVjuSNKmYWGoacQvw+inJaAM4WNRCht2hiRJfP
         t3BspicvRz8GjeFhqGuc1zOM2sE4+hGT5fqHdfECaTU/XKyMOL/BN3lvIbthwdmA73rM
         DcVWpkM5LFZpjZdCf7LPlFMynp3GnTNnA/nQdouIw1KoKHt+BP+OSIz6OWBd/GM7pQFA
         z1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704500267; x=1705105067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtmIp/5jJlfTvNy6LJ3hDr7M0F6S84IB/YrS6vkaJ/s=;
        b=LdI5do40Gu6FC3R3vnQxWwXoyFTCvJkZqiZHKE4HB0XpumBAR2ZR73UGMNCrhDHi+1
         M25mXb+jsnZ9bhDQN8jMun53oFIPgWckLuJdmje/EWcRAuhlA/1GiMZZBNt4OSHQo1cZ
         Pv5uyAgqlzazhizV528ohOtIvz6y6/xpfGmCsyPj36MC5FrkxN5lBzm14yXN6rY9pxMb
         R0gIDRlf32nnWVPzoXwoguVH0IzTIt+0048rKkV2xw420bKC9fzJiD9IuLzGREBtdPsm
         RgN6t1ATRGvjOyN+mPyeFNmn50T2iSQWICoMEm1Pit5PQS0xtB393UiI3EbNgsK4Yd5m
         Mcpg==
X-Gm-Message-State: AOJu0YyGSoqpVprU7LfRV/G84I9lA+TPwx2EWiPF2Y7kdYPKM5EO2XSS
	bilbiADaCAq6gik+L5kwBaHW7gCLZ/DqdloT0CefFijGhU4bdA==
X-Google-Smtp-Source: AGHT+IFORx5RO+zYuOUtSxqsjHAPQCIQXhIB1zwU2lFgVGk5ZYR4tZ6ziqXtsIwPbSaRWqcuzw67f/Owf5uP+SUlkTo=
X-Received: by 2002:a25:fb12:0:b0:dbd:9a3e:50d8 with SMTP id
 j18-20020a25fb12000000b00dbd9a3e50d8mr119540ybe.111.1704500267630; Fri, 05
 Jan 2024 16:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-2-cf61ab3aa8cd@linaro.org> <20240104005327.a6747bpbqt24xlbo@skbuf>
In-Reply-To: <20240104005327.a6747bpbqt24xlbo@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 6 Jan 2024 01:17:36 +0100
Message-ID: <CACRpkda=JszRwb_JpqGbVLtj0Q56tmjiE1_ZgmZwqaC_gHxLKw@mail.gmail.com>
Subject: Re: [PATCH net v5 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Household Cang <canghousehold@aol.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:53=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com> =
wrote:

> "Looking at the size of the frame is probably just wrong." yet you keep i=
t.
>
> Not only is this confusing for you to say this, but I believe that the
> skb->len check is the _only_ thing that is needed. Explanation below.

You are right (as usual).

And the analysis you write make perfect sense.

I dropped the entire patch, and send only 1/2 in v6.

> The one difference between DSA and VLAN is that for DSA, you sometimes
> set TSS_BYPASS_BIT (for large frames) and for VLAN you never do.
(...)
> Do you know what "TSS_BYPASS_BIT" does, exactly?

No.

The datasheet very annoyingly omits all details on the TSS
(the checksumming engine), and the documentation of the bits
in "word1" and "word3" only say it is a way to pass configuration
to the checksumming engine. I think it is a genuine oversight
by the document author actually.

Yours,
Linus Walleij

