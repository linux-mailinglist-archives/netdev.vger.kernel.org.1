Return-Path: <netdev+bounces-159984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB81A179FF
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCB03A6D3C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344441B6D0F;
	Tue, 21 Jan 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNbtB8uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567E1AB53A;
	Tue, 21 Jan 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451076; cv=none; b=pb/ZjyF/m9g4XkmoSljdTdtsFyUzmSZFkkSsPPjCpHNec+6WkrLcjEm6cczz06BUf8sRvhz8j2tFrXKV/7zP88Fdoq8NpklX+MtW/63pYzX7IVLcn8jjqWZJBhAh7BNOz8LnBQmLCfcwbsD7MrtCxvRR4cfhiwPMS8PTg5e3FZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451076; c=relaxed/simple;
	bh=ks4VYU0vAolHLN2e99mEh5LeroHbi64C8Pe0fUbFwnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3zf0XU33xljdRgkVF4IkOYKNW4pcJ3sW2sKQFBa0F9+US+JIhKXYRNfcjxovZ5XK1t7GIfNguercm4LNj9wL5ZV8DzXvIU4MyT4ZGtdQwPemK4JeOvUxoSDMn0pFvPXAdVp7ped7yEcvs8Fchz3LmwMrARzB1c7Auzgg8oD5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNbtB8uq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d9b6b034easo10869274a12.3;
        Tue, 21 Jan 2025 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737451073; x=1738055873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b56qKkkq27woB7DpV3YJkAgA19UIaFwIBrselPFU3mQ=;
        b=HNbtB8uq9cZxNvsBIKu9k5sAusR1VBbPeNO6iZ3W/+vK88OMbE/N/s5rWIFv8hcSth
         jIEUhpZ2owdwgQplekAvOvH3fqeUDnHIJeGxSAmAE6zwRh/sBc/lJk1jjcGCbiDlhmNA
         WMomKKSKZcpT836gxq+D2Qou004D4WV/gcBpHQehjM8AFtv4Js5PBELMpqF/gDG8CHao
         7mYAxcfcj7m1cb2k/3ZgM+zdAMW10SH5tcqEbgompZYQyplVgAtnDVZbfU/5I0Bg5nNQ
         pupl/xoXTehgz4MJH4krryGf78sV4iEQcrvXfpK2JEk/LPWPhSL3zAjqg9z0WvQxAk54
         lYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737451073; x=1738055873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b56qKkkq27woB7DpV3YJkAgA19UIaFwIBrselPFU3mQ=;
        b=Z+p2WFigWf4PtSm9Ny1mgFdZGZ+93G0kq9ePzevaY75mjRGwrBE6eIomHcntUItZ0B
         v9osB2nNeTffTglL06IKBLKwErnq+rcwn6qjbAD0Hz4GDiH7aaYoD5lWOsnpsFFu52pp
         3K3faWyknM7fvt6xG7VTBdu0i/K9P3q810j1z+o3BfxGXdbJsxVVMOr+LJ0DcnLrXo5S
         25WZFAdytB8kqXUxUsu6h+iFccZtXtReE6enVJ6WBzfFQhQ/qvnBDc/SfqJ2M9WG2c+P
         Sp5qnl0SrqVsqifQa7/bLtcSEJ6KjMEml8pfm3bCGNIr4D5P/un/ZI1cCs1AxzNqPAQX
         OVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2YyD5vSvXzwzZR1cCnsoBeTrEk2AnX9+k2zHFP23IdRBVzyC2aWyzUIaQVK1c1P7fqP0lqW5EYQ++R5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDTp8XFELyVsjUkOureJXprAHcieTGU2JLmYu5HxVlKnVfHJa
	dgETtt+Nb0Ksn0D75YOir0IKJz152tg4t7Mqi3r7KtdQ7reF/o6mjLcvo/pwXqPFLXJ7G9K/W+f
	lCeVz4C/Gtv0StlPAvKTVMj0XsZMeEB4BOYDw2A==
X-Gm-Gg: ASbGncvzbXOHn+IrUe+9ZLt/CRm1X2Hl8u49H0Zobggd+L8M6o3shcf5ArXeO1mARHX
	XKrsLfttwljX6g66FTj21JK7rrFYhRw5tfNYxfgXzd3fhdttjhDaz
X-Google-Smtp-Source: AGHT+IEfYtR0AgBf8cmJ0KdutspUQtO32ja7QUkiIOPXEZXj7oqiH7wQJNFKtbt9bbpg8S67t+HaFOXnoibcTudONLg=
X-Received: by 2002:a05:6402:5206:b0:5d0:f904:c23d with SMTP id
 4fb4d7f45d1cf-5db7db1d558mr18341951a12.28.1737451072346; Tue, 21 Jan 2025
 01:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119134254.19250-1-kirjanov@gmail.com> <CAL+tcoDVTJ8vA_6wBd6ZDh2pq__fwJ9vzm3Kx5qpMNvaxpObjA@mail.gmail.com>
In-Reply-To: <CAL+tcoDVTJ8vA_6wBd6ZDh2pq__fwJ9vzm3Kx5qpMNvaxpObjA@mail.gmail.com>
From: Denis Kirjanov <kirjanov@gmail.com>
Date: Tue, 21 Jan 2025 12:17:39 +0300
X-Gm-Features: AbW1kvbiiZ2XqlqHOjOPISQicXMCzJ3Yv5VwNOV7JyUotqcsX48LDnBh_QEBdY0
Message-ID: <CAHj3AV=wkJnX5rW4jdFycf6vtm1vW2a+gVNAcTnnaR7JqsPEeg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please take a look at the commit:
> commit b144fcaf46d43b1471ad6e4de66235b8cebb3c87
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Wed Jun 14 12:47:05 2023 -0700
>
>     dccp: Print deprecation notice.
>
>     DCCP was marked as Orphan in the MAINTAINERS entry 2 years ago in com=
mit
>     054c4610bd05 ("MAINTAINERS: dccp: move Gerrit Renker to CREDITS").  I=
t says
>     we haven't heard from the maintainer for five years, so DCCP is not w=
ell
>     maintained for 7 years now.

Yes, but on another hand I see that it's evolving, like MP-DCCP and
the according ietf draft
here: https://datatracker.ietf.org/doc/draft-ietf-tsvwg-multipath-dccp/20/

Also there is a out-of-the tree repo available with the implementation
of mp-dccp:
https://github.com/telekom/mp-dccp

>
>     Recently DCCP only receives updates for bugs, and major distros disab=
le it
>     by default.
>
>     Removing DCCP would allow for better organisation of TCP fields to re=
duce
>     the number of cache lines hit in the fast path.
>
>     Let's add a deprecation notice when DCCP socket is created and schedu=
le its
>     removal to 2025.
>
> Thanks,
> Jason



--=20
Regards / Mit besten Gr=C3=BC=C3=9Fen,
Denis

