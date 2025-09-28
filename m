Return-Path: <netdev+bounces-227040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D5BA76C9
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435C41896A80
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72901255F31;
	Sun, 28 Sep 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EK3SspDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF634BA4D
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086765; cv=none; b=jxMtFolZs+pmzekMNpT2USENV0Fu+ORpNmv4IN/IpiyiTM2cv2UCwDyvUhHaVftakUv3XCJndHN8NJ7U9Zs2wev4iDXEr5dfXZ6nXUC7x1QKV7UPdiWCHJ7mO6FZDXmCnVNyusUnawK6pJrA7S7fn3tAwCREjY4LBOjbribV3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086765; c=relaxed/simple;
	bh=58ZIhpk8r9fLmS/NIXCD3FUoK3OB+ORIt3i8iWEpQQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSIBW5FPCz3pw9jewUs+tKz7WuSOEuH+2rwrgQkG/FFCb/X1PRreMRfooSxq7JA+PVfuyxcw4kz69+OKjSjunjXFlFZAYMLupCaLCsZ+y3qRBKKBO6wIsj19tlhDrMwqMrAu7Zvs4inoMndGG0sqPgMWv6OQw0F0MSc9qgcmyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EK3SspDQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-336b9473529so904217a91.1
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086763; x=1759691563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58ZIhpk8r9fLmS/NIXCD3FUoK3OB+ORIt3i8iWEpQQ4=;
        b=EK3SspDQ1i7k+I+VgYxW6L4hksE/qpSCJEDbR4pG3+Wh+97SrbFLxQqhGw8hRSGvsX
         lLJ8HHC5FryOLmOdYcON6Ejc6wFNGYjIhsBodOQy8o+pNlKiuTEHoH1vgOCTcLR0oBj+
         Xkxaj26iav/O/zUavYh6WP1GfdljvIZm9zzQCpwrkUzu/7Y9aVt3oNdL23cZ/lODguBv
         niL8CTbtswmnDQ662AyvQ7f3zvz0aU8vQnes8hKyWCk/5mMfYHUDSe2ko8ieOq7gN/vH
         i0JDOu15LRQyMDhtGwsg+/pm3CtNiQElE0eHTlnVYK5czL4107/0pt57/LPk/ktZ+cuz
         gjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086763; x=1759691563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58ZIhpk8r9fLmS/NIXCD3FUoK3OB+ORIt3i8iWEpQQ4=;
        b=uISUDjQW2u6XITBJnGNJN9gVhczZJiJhZJaRIqPPCduxRcwtNnZX/0tefHZGbE1UI2
         Lwdw7dELlGDsX5bC8IfpMX7/CUKBhwGPMJNd0O9BxLoKZx4FQuNbRmhHXUnYs7NoGjrB
         tXr8LNReLcidM9eIhpIdvSMxqq5FxfQcHUgDR469ZY/Lnl7aTs2DNGvKMLWkql+4qBjW
         cKvNwpf7g1dM5yXA1j1Hr7nqhp+oLVKzwqxPFmrVIyTyXKset1cCIeC2x/c6fmWnDgM8
         OiQQFpj7N76Om9xXSqJMdcyX2zF6pi/RYoH6YedVqfhMHiu/o9XMX1sg4H9nYCy8VDA0
         wqdw==
X-Forwarded-Encrypted: i=1; AJvYcCV9cUITU78xAC+QqkSxBgGLIi8G1NRKCWmhwnjEmEj4giY2CLLX2srQm0UL6748ALCcR8YefXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpD/i3Bn5s82mOn8U2XGobYOsgPrfQxyUTICAhuuzJPsOM5FN
	kmITKM+Gt9+OEMz8l6mvMOXHF2xoBmCCYhybe3EkCcmF68ku6D7STnae+KiIsQlHCWVn2vgCqdo
	NFRBy9i5MvOpmwfwbugMI+zsVG/yvKZynqoyeY40G
X-Gm-Gg: ASbGncvWDBs1sngtZduMSn2UvayreGsstLbAUrBi9+WkcjF5dB7W4p/ooQGLsMzUok7
	hqbG0DUPgjhM8VN442WJO3ol/nmhXNOIqcwsAmLyBBL5dNx/QIJiNwMMnLDegB5qA5idvyjA8Tq
	uHX17qX6FxtdrpG0ke2Ri46I7bs8JbIPnmNu0PEjBlQ+ecnLAjGe41XTOqEA3LOtJPvRERHtRwy
	YAlM4xWZnW5B/dRfraNL0nlsxgBR6LNIn0ZQr7D
X-Google-Smtp-Source: AGHT+IE5IQFbHVA1ADqq8lHp/HwkyuBJRJ8gOhK1W7cV0ozAKaVEGR+vnVhaKeMKfd7N7KAEqq5glYNVVxEx1+YDe2w=
X-Received: by 2002:a17:90b:2c86:b0:32d:a37c:4e31 with SMTP id
 98e67ed59e1d1-336b3ccd560mr6791711a91.17.1759086762359; Sun, 28 Sep 2025
 12:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com> <20250927213022.1850048-4-kuniyu@google.com>
 <willemdebruijn.kernel.2e545b6e6e601@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2e545b6e6e601@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 28 Sep 2025 12:12:31 -0700
X-Gm-Features: AS18NWBMPRtGwHnnT2d-P8_QfA9Fk7q-If_xKalzmSvDg18vGC_5-gWmFOVx-5g
Message-ID: <CAAVpQUBfKYBagmPS1VSygq6FWWRPpPSBG1ozBa37xYO8RXnTdQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/13] selftest: packetdrill: Define common
 TCP Fast Open cookie.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 11:10=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Kuniyuki Iwashima wrote:
> > TCP Fast Open cookie is generated in __tcp_fastopen_cookie_gen_cipher()=
.
> >
> > The cookie value is generated from src/dst IPs and a key configured by
> > setsockopt(TCP_FASTOPEN_KEY) or net.ipv4.tcp_fastopen_key.
> >
> > The default.sh sets net.ipv4.tcp_fastopen_key, and the original packetd=
rill
> > defines the corresponding cookie as TFO_COOKIE in run_all.py. [0]
>
> tiny, not reason for respin: no link [0].

Oops, the link was

Link: https://github.com/google/packetdrill/blob/7230b3990f94/gtests/net/pa=
cketdrill/run_all.py#L65
#[0]

Thanks!

>
> > Then, each test does not need to care about the value, and we can easil=
y
> > update TFO_COOKIE in case __tcp_fastopen_cookie_gen_cipher() changes th=
e
> > algorithm.
> >
> > However, some tests use the bare hex value for specific IPv4 addresses
> > and do not support IPv6.
> >
> > Let's define the same TFO_COOKIE in ksft_runner.sh.
> >
> > We will replace such bare hex values with TFO_COOKIE except for a singl=
e
> > test for setsockopt(TCP_FASTOPEN_KEY).
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

