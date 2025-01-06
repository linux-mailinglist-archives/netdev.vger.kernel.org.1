Return-Path: <netdev+bounces-155320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F2A01DBB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D6A1882ACA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90480AD2F;
	Mon,  6 Jan 2025 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrk7173h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D061FB3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131130; cv=none; b=Epl/Gjap+56Qc/PaqwEZK7P33z9hGVkWX2cFgMLq6PbdB/Wnh9OBqPp/FncJUoo9lO3/dXwBgmZj7EtpgOG0IMtCwWe5BmeveGBzhV1ra9Mw5hpYZxUJmPR4kaP8p2kWSK+Vcw0o5XWVdlWJ0I6icQB/iRJt5IXOoB6ZGmRSU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131130; c=relaxed/simple;
	bh=JujCMmZN7qp2/44Rcy0pe9jwqTGhtYmjAQZbuH0i5kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT2h68g6LaHocz3InzKctjInWjCfydHsH9JV6+Dabs+xZeSJA9TyLsUMKGtXVQwozEm2xqRi67V1QrbsLh47XLV6kR8LVN70NhkqvseysTFXlGZN7G16GTxnTSITqs1Tf4hgceQx1nMvJK4IDHyDpQ8AH9Wr6Hh8NVHC69D9ohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrk7173h; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e12f702dso605140839f.3
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 18:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736131128; x=1736735928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2n3/F17yGDFFPXrFze2lH3Bh4bHeuratL7gJizHyLU=;
        b=Hrk7173hICy8CfFEv3Pu1tWCYJsU2OC8KNWbNv3TZrX/p4H4NSy/ftDvX3lkj2S/hl
         elysLxn2/4xwiZC/YXWEL1IuD674AkOy98FggyGQZGbtHzinknxr1ezTr4yDQ3SKoV6y
         sN8Jo6M7oaXlEnJ146LBVpsIuhG8CzzA9xl4ie9q3KIxt9JKlluHJVfps5uPvrfjTmq5
         X+GCwzGlRUtQH7CvPydOnDO7E0oKrJrsvw2jDBFTGgEb1rf+5RiDx2QKm7sup5fwHEDL
         MIesi/l+/KDWOwYNJb6JqaUfSVXQ4vodx+/rQrRV9D+Cdmq/aqXQy58EJhZ5jZtAXOIw
         ST0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736131128; x=1736735928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2n3/F17yGDFFPXrFze2lH3Bh4bHeuratL7gJizHyLU=;
        b=IwIsQdN+FV8d73EvXoZoEZWSWCqbXi6AODMNJHc7QQp0sgsLxZ0EihN5VBQIN1EZgT
         AGJSrqXQDwRqUMk70fUPEp7bPsC6CEB4Qj6SCOtsXDe57Kd3HKAxtOQ/js5443o+Cbmb
         vsqOgVZsn8Qb02aIAgOHmhyeI7s7qg3RUpeW003Gg5C65Zw5mNYakD2tgxegg4QufG0x
         l4Yzw612oxQSca93WeoyevFM3HKbyMBVb+5LJdJEmtijhEdcjh3TXDbN4L8fmCjHp7HD
         maAncOt8s99PTcDUI9413I9YWxGgrIn/wUp6yJ+e9mHQdBoYPfgxYkVp3uVBbdo4HApq
         UPyw==
X-Forwarded-Encrypted: i=1; AJvYcCUbin1GnnYxCZs0pHy0pDEpugtWHic3g31OkSX1q5FgCnF42snq04ia2lhR7Yu1WYKxAsuQRaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmosNdK/u8ac+ObIbT7Fwi/4Ob73BDpFMMxfCi3AeNKnj55OW
	ydnmMEeE+TZNDRkVGItJYiibMIEouZAqvPwz1+alfKqVi52aepMLqJrH1xPgMwjU1RwrqdKUfru
	YZ/r0b88J6Tneltt2fizgAUUHi2M=
X-Gm-Gg: ASbGncsMdv7G+ivdE6hAA7FKBAydr5b/Iyy8syF/8Ki3nsrQhBvIP970qko3NFRtmB0
	kOZZIdYcLd4q+zm1+/7gjRw82OcyGILMGIDN20w==
X-Google-Smtp-Source: AGHT+IEorzHokHBTgXvonXX+n9ifdnusN72XvQ+fKb0fDXfg3wHA/ZXOnSaYOwpqRqRgrRlAs4h2/QzUM4fuMY8bv68=
X-Received: by 2002:a05:6e02:3201:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3c2d1aa3e86mr412972115ab.2.1736131127714; Sun, 05 Jan 2025
 18:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105090924.1661822-1-edumazet@google.com>
In-Reply-To: <20250105090924.1661822-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Jan 2025 10:38:10 +0800
X-Gm-Features: AbW1kvYIe76qDjxMBnJ0AU4xAX8FZ1XjXr3lAyHd3YfX4CGtB0FLG4Ccs2xjpWg
Message-ID: <CAL+tcoBdus0aH2GagbAkfxpsUh0q7YOHy0GguXeoABVYrQ_t=w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: watchdog: rename __dev_watchdog_up() and dev_watchdog_down()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	eric.dumazet@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 5:09=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> In commit d7811e623dd4 ("[NET]: Drop tx lock in dev_watchdog_up")
> dev_watchdog_up() became a simple wrapper for __netdev_watchdog_up()
>
> Herbert also said : "In 2.6.19 we can eliminate the unnecessary
> __dev_watchdog_up and replace it with dev_watchdog_up."
>
> This patch consolidates things to have only two functions, with
> a common prefix.
>
> - netdev_watchdog_up(), exported for the sake of one freescale driver.
>   This replaces __netdev_watchdog_up() and dev_watchdog_up().
>
> - netdev_watchdog_down(), static to net/sched/sch_generic.c
>   This replaces dev_watchdog_down().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

