Return-Path: <netdev+bounces-251178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B2D3B147
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CB783038101
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E02EDD41;
	Mon, 19 Jan 2026 16:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEF2EA473
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840013; cv=none; b=Y9Ip3d0RR7/Rkj1Kp6gE85BDrTFcQqeN4lZatKQb2fSLSX9jMdb/7iSX77H34EwKutpOywYRx43+4po6DqSofdSLvrcj51vebQQ9AtsTUtZHT/zqNfS7ukszda9QiGaON4sbHB1m8ol6TAA4yotD7ONMbbr1/NmEShoxeTgy06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840013; c=relaxed/simple;
	bh=DzwnTBOKZrW1VnGMIzybUOHJNbRRFkalswYuPe8RZYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSAyttNk7YZJZj4qpJDPF8ckSJ3DJv+644uSWiURdDHm5enUjvH7NOpdQ67tOEf/KAoq5AC/x5Re0vj87PJr9z1ZfzyTZILiMzLkB2BMjY/PGTp9pNt0+uYmIMJZaBGIC8BghQ1DJwHsHUfqpLkT2uNjhjXPUYO0tOSiVMELJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5636dce976eso3466796e0c.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840010; x=1769444810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHeLbzKTRLrsHU7Yrs3oNyJNjYmQgDzjREnwpGNLYz4=;
        b=SSQg/w7Lwk4VClB5nW9z7mJLg3pEhy+Vdb1ylPYNHCJkA7XdkUb2Cl5HfIcEgDV2S9
         i2BMOOoo4yrZ8I2gppIiSOKTZGzhB1+NjUyJhDy4hS6kM9753OFR6HaDqjl9ePnB7fBL
         OQj+OwwEwOVJxsEcGbZmoYreVnXAPyxThFTRpPrNlET3OPPCJ1i1VzhnXGVNJ8rrBZT7
         5tGVeBv0FJy779+QM2y41TVui6fx7+5ZpUbGStqbtU9sx/gww1/P5AE/OeV9ga1PzMtP
         WHXq46x/awqrPoyshQPLqelTFT+fXStntlvsoiFLd3HbCH3FfpYqlvnNeauZvTEiTHj6
         NNmw==
X-Forwarded-Encrypted: i=1; AJvYcCVai7C9cy6IO0kDATwBaRb4uAj+h2NfWk75dtb3Y0E/LYkd2GFGMUtL2s+QHk0TAUik1B86lP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdL7Phr9T/LqUjSAmMFoPMqxkAyZHCQAoMYL11XmZd32qpgnoA
	QINuKoaunsQ5mTDRUTLFZxXaCqW1BcSKhoK7Djjzr2nVbPBbqUR4PDenvf/2lGAO
X-Gm-Gg: AY/fxX6coGax4tpwuqNXQvLEiQ6xyaPeFhhvB3lS+1C+RX4z/Kl6c0Mnz7+10wOdw1l
	PtFPxXtEjfqkdynOfgNA3JKFxcHU86H16BhMrVhnPIH+9VrnmHhzOomto9C0jKRDDLRgeft0+Im
	CFNZlyD0YLI3UkhWE/9RIwbSL4AwC/h1PgUkLO36HUBECLU9NlsjRq7zpLUSX8uxPS+Sx8KX6WK
	Hzc7OIx1eph4HDnd5hToioibfUMF52n3bv8jynkWZUu5aerUFHQCwNrQDlotm889y/5pr8mrQ5o
	A6YDnqu1he2RXF6t0dhYvz53Ll11sDgbiEErkYFcl4c2mZ22FfKJ4T+JfEG4W3hIpiEzIWeRpkh
	inR20z+JomSwaryEOmfzrOVwcjuhrj7WKjJJWaAwn+V2A7lV/jddGAi0a+JXHrSvU9gyIzk3WOl
	sSDAayThe47Em1E73oHCZG9GttbFghWi1MNYgcNLzv4sQ2/Dea
X-Received: by 2002:a05:6122:35c7:b0:563:62ce:b28a with SMTP id 71dfb90a1353d-563b63da5eamr3111323e0c.5.1768840010252;
        Mon, 19 Jan 2026 08:26:50 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6fdb07asm2771702e0c.2.2026.01.19.08.26.49
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 08:26:49 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f63c8592cso3772374241.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:26:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW08mmoLIaU3AP2HZGzKmREXJTHM9VGgYUfC6kMFSEQ+B+YSxZ6wKl2KO5OGN61hhqX2OfiNV0=@vger.kernel.org
X-Received: by 2002:a05:6102:304b:b0:5ef:a24a:50b5 with SMTP id
 ada2fe7eead31-5f19253ba4amr5672990137.18.1768840008742; Mon, 19 Jan 2026
 08:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
 <20260117163304.20caae7c@kernel.org>
In-Reply-To: <20260117163304.20caae7c@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Jan 2026 17:26:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9J9QPp16aDD-_2Q-chWANWeTyS6Dw=xJdkm8r-sPyFw@mail.gmail.com>
X-Gm-Features: AZwV_Qg5syuFPC8HV97bsY14SXc1tA3fkUNNUbrr7vpIH4FRUVjB7jL1flr_3_M
Message-ID: <CAMuHMdX9J9QPp16aDD-_2Q-chWANWeTyS6Dw=xJdkm8r-sPyFw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/tcp_sigpool: Enable compile-testing
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Sun, 18 Jan 2026 at 01:33, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 15 Jan 2026 15:27:26 +0100 Geert Uytterhoeven wrote:
> > Since commit 37a183d3b7cdb873 ("tcp: Convert tcp-md5 to use MD5 library
> > instead of crypto_ahash"), TCP_SIGPOOL is only selected by TCP_AO.
> > However, the latter depends on 64BIT, so tcp_sigpool can no longer be
> > built on 32-bit platforms at all.
> >
> > Improve compile coverage on 32-bit by allowing the user to enable
> > TCP_SIGPOOL when compile-testing.  Add a dependency on CRYPTO, which is
> > always fulfilled when selected by TCP_AO.
>
> I don't see why we'd care. I understand COMPILE_TEST when the symbol
> is narrowed down to a very unusual platform. But this is doing the
> opposite, it's _adding_ a very unusual platform on which, as you say,

(I wouldn't claim it is a "very unusual platform". 32-bit won't be dead
 for at least a decade ;-)

> this code cannot be used today. If this code regresses and someone
> wants to start using it on 32b they'll have to fix it.
>
> Please LMK if I'm misunderstanding or there's another argument (not
> mentioned in the commit message).

In general, we want to be able to test-compile as much code as possible
on all platforms, but not bother everyone who configures and builds a
kernel for his system.  Until commit 37a183d3b7cdb873, that included
the tcp_sigpool code, and any build regressions would be caught soon,
and fixed (presumably).  Of course that still doesn't guarantee the
code would actually work on 32-bit, but successful compilation is a
first step...

As the maintainer, the decision is yours, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

