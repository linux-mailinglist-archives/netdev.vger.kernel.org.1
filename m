Return-Path: <netdev+bounces-90433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3378AE1E4
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D06B21148
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637E605CE;
	Tue, 23 Apr 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Od7jFFq3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB25FDB5
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867370; cv=none; b=hV010MYWwJM4FNeF32S1pAPuaWNZdblc1c+AldXiqlPu0RihsuhKA6G7nbRm2xmLlIBWoEy8b28OGtapIDNm2KaKvfw2WbK821kGMl9LwN0xJjraWL7Te5GW1C0BJnV16YlGGZ5Tzu40vmEwmytR80dR35yjfVit2y8k+kXfIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867370; c=relaxed/simple;
	bh=jy5arJm1forKrmneoXB2SHX8PNwRuIx0u7xPry8cZsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcN0Vq71hBNMEns8db1wp/W9DbuvOOpiFmv04QMfPJ8Z7+XJ17Dh3phYdIzuvW1pwREwvsPthMFA4lcokaIp4egGkUzLB3a7v6HNCA7x5v8WtvXvf+qO9GT8S1r0bZnUNhViiI5aoKoLxtzGSp9iHOLJfL2anevTz8yno7+xqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Od7jFFq3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so10437a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713867367; x=1714472167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3NXpsdHuYBobJGGyVWsy5SU7aCIFWQG4b8AIKli8P0=;
        b=Od7jFFq3mqrPpd6LeZRscG0mYmp8d1sW0jlQA1P8HTZeNt0jtOhYN2LudVgKLjB6AX
         jtH96KI0VyI5WnpVyzCwvrftcwDB/vb0qS00HbkqXH0OCMTCQu0wFQ+GGsIbkXz7/sa2
         /8XtUG3o8m70RUN5j1JmdCWtP0/EqhGrsuVsEbHiK/RVm5AkbDj65CC9CG6VCXczeg4y
         4OXfn3kP0l5pSJY9+0SBKTeVP1sisHMvFxbtJWPKBe2DqvYksUa9hBNEyYM3ZVLIxGly
         CJUAEuOm2p1cVU2TGa/XPcXIlMzOINxTo8pFQlP8DVZSMx40Kgs2psAsLWzsA5+cbI0h
         RUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867367; x=1714472167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3NXpsdHuYBobJGGyVWsy5SU7aCIFWQG4b8AIKli8P0=;
        b=EftGCJGBJNsZXyz4bKn3YJtx1383A2x56FicdVi/I6gA8ux7S0P3BGLQSJUNkJDUhz
         R7gS0ytNrZlBYZQelTLH+yfsW4ak3ElPlNJ1GG9qucHHZxBP/GxYZ4MjrRq9Fq4Apb6K
         RV2LAAT77g1jtvv3A1GCWJ9LTcRU2g8yMYvetVyz/I76/Hd0Rcl/bk3E1wgevGc6aPJh
         ZgHzoXdn3y+RA5JYA17MfiLXefhctf2tse0XLQ86Uy6y6/oGqbZ+X1zVhNYBqQhcA2uf
         u12wCJ2MIdSb9XvWj0W3MqVU1di1b+UBPerfxA2plV+hb977eI1EERs3w36B5C7DwgSG
         6Vpw==
X-Gm-Message-State: AOJu0YxnoWXFpY01ainh+Qrhavbg+9MIl1UZJt+aWMxKG4ra5KFb082C
	Y3R965eHq3+6yGUEf2wIABAaVmxe23bMiAYsgDfAGbtNxCrBirfqM3LFT0unw6xK54AQlNikrD7
	/1Ajj2YApSBDmKUYqPpdCbLS5BGgWidjes/vb
X-Google-Smtp-Source: AGHT+IFIa/gpuCj2TMGZXBVHlclRlxTnGu9zd7qdxOMxi3vxfztcbE20f7CqYCAjND4a530cK1sVU/pdfE762+OAhVU=
X-Received: by 2002:aa7:c147:0:b0:572:ca7:989d with SMTP id
 r7-20020aa7c147000000b005720ca7989dmr105916edp.3.1713867366480; Tue, 23 Apr
 2024 03:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name>
In-Reply-To: <20240423094117.93206-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 12:15:55 +0200
Message-ID: <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:41=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle

Hi Felix

changelog is a bit terse, and patch complex.

Could you elaborate why this issue
seems to be related to a specific driver ?

I think we should push hard to not use frag_list in drivers :/

And GRO itself could avoid building frag_list skbs
in hosts where forwarding is enabled.

(Note that we also can increase MAX_SKB_FRAGS to 45 these days)

