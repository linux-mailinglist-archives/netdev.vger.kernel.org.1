Return-Path: <netdev+bounces-92417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D58B6FBC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AEA1F252D0
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E412BF32;
	Tue, 30 Apr 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r36se5dJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7AA12B176
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473242; cv=none; b=AcNWUJ5+M24dGec92CvteJFhRRCHXawAbVdtqQFm2FJ5X0IPsGGK/Gn2y++tbjHcJmL11CiN03BB1RGy5pK1MkwHGZLBhgrnvbTjfDetH1PVGzpDsXSUikRw32Qj0WPC/49mpSuZkVUt5Vr6U0bHcHGbSvVjfi57/R5aEw9DNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473242; c=relaxed/simple;
	bh=uFm8Qgi91vGI3dt8K6sPdGExsyb2lsag5x2vqkD5m0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1lHHOGhQfbpdEMAZqYmwdU4aHSt9t7FpdIkZ3V6x/noTGduJ1KR9czHPR919cKzgCTHXxwFHLWwSYZeBinPag2NQUDnsLeBxZ3swSZN6fudrnYA9YY3UrI6soQMop64S72mJaqB3vQKT/mnJiYyR1N85h7ifcAngSLsDHvQ3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r36se5dJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so12430a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714473239; x=1715078039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMlLVgBu7y+Z1UA7TogJJjdkdi56Sm40tXjGRA7ggLo=;
        b=r36se5dJQCKGcfsiBB0KPc2qk55NDdx4AomEXEz65ZfuiGL7KOqwsyGy4d0l7bpWHZ
         KMF/XxGGXsq2Sp23VFet/2II3wMcf2+aW2wDlQDoxNES2itHGeaHmpu4UyRZnlOfs/hr
         b9UW2W3Slatz9A+Tg0m4xxieq3k+dDgYjwcgxN60OmVOm9aH2ohbkATvhHR7qLGYdhsZ
         BXTM5/gmahUf1BQb0mwK8hpGjmFC68ZZ0R+BqAzEoICQoO3c2TgaT6c5Tyt80tNgAojB
         w8qad0Ip9OLmBGitCify/6AIO1lNYptdp4+gjACkXIFgPxHAzk7yzIDd+r2M1Z4iuAp1
         //dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473239; x=1715078039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMlLVgBu7y+Z1UA7TogJJjdkdi56Sm40tXjGRA7ggLo=;
        b=WZjX17r7RBtbQDRheQiy7UhYtwot7hZyDIlsOGib9cXBXvcJyCOP0DNJpOYMQ2o3KR
         JLF+3ytYShVaRFJaHho1+h/enmD3vy5PF2jqGwYg/xCHh8IbLvLfu99zjXotaoOxO12d
         Efnn/lHKay2Bjc6kERNeIUbvHtzZSa8WHBSWTbeSHlGskKklDax0vyE1opz9DNCBciUG
         MyYzVShdV1shcZUGaUy0av9xOXDLaXiUZi2MC6RmSosgWxXhj6jZc+ubat/dPG2fxf4U
         bY0BQHxXb4TpOsYHrbkpZIMGEwcRXOSMm78eTi7Wkbe43Ig4radAqddgiojSw1+G3/ow
         pGOg==
X-Gm-Message-State: AOJu0Yz+Vf9kSU0DziMqIMXL8jAqxEw02JMtsLq6KSB8vAgC4+f0/W4V
	aJxaf/liNiMnozdvr9aLGUV8Yh+1IPstoK19vVCrOfaAHcB2WKf4mZN+UyXXXiNVpQqfJhgiTCP
	9hsT3K4TXDSmUP3PNna83Huz9TJw5Dg+M0JYu
X-Google-Smtp-Source: AGHT+IEGoRSj77pAj1+8/T/SwwEZLP17Tgv8sozjKtTH7NkK88VClopgrecRadcPE+UqROtC1ej8ioxHLFgLfyHUHms=
X-Received: by 2002:a05:6402:1cb9:b0:572:a1b1:1f99 with SMTP id
 cz25-20020a0564021cb900b00572a1b11f99mr12520edb.1.1714473239040; Tue, 30 Apr
 2024 03:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427182305.24461-1-nbd@nbd.name> <20240427182305.24461-7-nbd@nbd.name>
In-Reply-To: <20240427182305.24461-7-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 12:33:47 +0200
Message-ID: <CANn89iKPrTktMF8EGV=o34ePe1vWcKHhBs71E0vOaymkhLy6dA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next v4 6/6] net: add heuristic for enabling TCP
 fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 8:23=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>
> Signe-off-by: Felix Fietkau <nbd@nbd.name>


Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks

