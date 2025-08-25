Return-Path: <netdev+bounces-216507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46810B342C5
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA7616203B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756F27510B;
	Mon, 25 Aug 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJuzxpVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E8270EBB
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130781; cv=none; b=ld9HDbCw10j1slDZtCezUvWeOu9AtbXB/7dP86QEw83ATiXnGndvpjlAWEw9CHcedXHpbLyeegUxmXyh0krznanM54NT7jhrIpuCde04uzedzR2NEfDIohiLI9lAve28MLh8sCmnmE72dn0AxGkmQwl/StE0onoO82+/eszhWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130781; c=relaxed/simple;
	bh=0NmoVODVaV93z6Plmuqd09AhbeJjAwP9TZKUaMoQOaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npt3uStXr0dPgZOrNSs94kTkZXBMbCyD48XWh1LeJpcVEu7Vbw+yES3LZmC4GsGAj2Xsn77NMQRQ2m66v/Cwn1MAgaUcShclNgBQbaue2IBTfIpJrMoflchKxvcE4VwS5t+rSlcQCMHqktHeRevtcXhzesRfPR6IlgtqLWkGEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJuzxpVf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e571d40088so40226185ab.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756130779; x=1756735579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUk68waEmLiLSEeNzstQygO/7zRHyPkWgUTafNVmqZc=;
        b=gJuzxpVfCA/WYVF/NRc/bmkMyHzCYNWK2QhkF0UvR4SCn3h66ZAkKX5lxoB37BCKra
         wJiq/pTWC/HXeD0jkHzni9CfQ72caTVyjptAlgpFE1LdfkjUbVDp4L4JbpZZT1EHTiu1
         QkRqSBv2qufEAgVU5SkDZqd1tLWd/kurJbqjMQ9GuhnkOgfDDvhm+HyXuC3dbS6Jxu1P
         XVnbpTn5Rnl33aspULdeCbnubyaKQYJt0ds+aX95snWZ6KuBXdwNSGLHPAYfTL1l8TRB
         Y5pyX0iP3aj4Os9c0yc9i15k6FYB+Fd3iFbYEGVwW19q1iMWVrTDc+AKRtCXhCb2LhFS
         Ga+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130779; x=1756735579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUk68waEmLiLSEeNzstQygO/7zRHyPkWgUTafNVmqZc=;
        b=Rh3H/u9SLQn6tPyIeAgVS2dCb3PwBNYAk/VF3qbjsP79YBxYuwS/BuIrsRt0EQDF7h
         v87LJjX7NSgyrPwVj9rd/gk0gDlCCFdaIIC40+nybt0Ming2S84PeIGWHyasRJ+nZFCw
         mYLqYOghvcvCKatSMA2pbVKoPGd6442n3rsKM3LigYPMWZiZf97lyHFCQ7l4h6l1/0ck
         Gf2ODm3pXvhffoYNoU6AZixNoU9dx3KB+x9L+9oQGJX8LnFa6Liz3DvlaXQYsnnuGz2h
         2MM6ErbphylcDwMd++6+7g9MZWy45mPhiiy0DXC44ZY3S7N2hCPOIXCs5ESwxa4nL2R+
         EWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVYlUM0n2IngrbRw61RIFvcdZtTuiZJCQ3HoqA3vz4t5umN/i1ZnsPUzLnIYSxJMn3S6eqnFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQFGzUsZkKcL3usZC5nqZFF3ypIoYmhHLboM/QfgPpm+Uihns
	xEe/cPxmXQdfkGACHGfwUvskJpFgvuOdqYnXxz9LsRqZfSlrBhYS6Bcal8dCxDpLATOFoS+Sf+Y
	mdYhqmfP5o+mJGHbhdLMV65i2QTr39p6poS/ks9l3TgR952zie26pneZi
X-Gm-Gg: ASbGncvHD8pghWHp7ezjDLFsXdRiCyxksCD8lRefSchRjeI94IcGTT1A/lPyB9SaoBO
	saOHuwtmEGqq92Lp3k9q/OIWSDLcM7OybbIXA3HvqdeMi2Whlza4gUDGqdzYVkElhuwxXwCok2/
	Bqz3vPS3/Hlg3PNfFLshKf3JHHCZv1BDpYS/1NdFWyOkz9r393hJP0Z4F7QRnIaAOUDrIvCn8As
	WV9hn77y4Dn
X-Google-Smtp-Source: AGHT+IG+baG80ggynxRrI09GUOhyFXK+dnaZ3AT2q3XS7oax1jWQxVvgWBIAH3PiFXmZ3oH3El25fb0aTBCw0418Z9s=
X-Received: by 2002:ac8:7d49:0:b0:4b0:e1bd:a2bb with SMTP id
 d75a77b69052e-4b2aaafa22bmr158190671cf.50.1756130417250; Mon, 25 Aug 2025
 07:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com> <20250822190803.540788-6-kuniyu@google.com>
In-Reply-To: <20250822190803.540788-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Aug 2025 07:00:03 -0700
X-Gm-Features: Ac12FXwPT3mvxAJcGEAzFCobcN2aE5JklEPalIZdSsp7-MUgMd0iGd1-zH78MZY
Message-ID: <CANn89iL_D6p0CwvBpPVWvQu0m6vN4Trgum40-F6txjOwz9T1cw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/6] tcp: Don't pass hashinfo to inet_diag helpers.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:08=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> These inet_diag functions required struct inet_hashinfo because
> they are shared by TCP and DCCP:
>
>   * inet_diag_dump_icsk()
>   * inet_diag_dump_one_icsk()
>   * inet_diag_find_one_icsk()
>
> DCCP has gone, and we don't need to pass hashinfo down to them.
>
> Let's fetch net->ipv4.tcp_death_row.hashinfo directly in the first
> 2 functions.
>
> Note that inet_diag_find_one_icsk() don't need hashinfo since the
> previous patch.
>
> We will move TCP-specific functions to tcp_diag.c in the next patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

