Return-Path: <netdev+bounces-155137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002BA0134A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807A5188423A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D614F108;
	Sat,  4 Jan 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1r1SdLC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAEA1E507
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735979731; cv=none; b=q4hVuwbxE+ANf68l3p3wGiLQM/P+UaQx3G6LG7lqCxGcDhk2fLKQWYXZQYGPrz+aAtj7slpOVh7Y0a2QgnChOcCRkQcNTwryDQGoQ7HYhk8/cLNHTe7DQd3r1JMAhcT3UuXT8GAGqPsDu0fZLVSVlYNIGDXxNe1n1UOV6tbHOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735979731; c=relaxed/simple;
	bh=mczWY6x/Br+sV6hHlfvuv/eTsFu4HIZUPq7fYqR3iss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spQAJffEZVzES5IPNwY/E9bnWlN8OfwiSwZgnHi8n4M26pcSHIEDTaZeNxkQT1K5+MnbzkjvCXax3oH07dxoeJupuD0nC9KriWZ8CMRlMEqUgkIYe7Boun9k02+Jz0jpfPrSoTUrsnnFZuKrswEkfKM1fXt0Xzt6RowtrYEy+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1r1SdLC0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so19604236a12.3
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 00:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735979725; x=1736584525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mczWY6x/Br+sV6hHlfvuv/eTsFu4HIZUPq7fYqR3iss=;
        b=1r1SdLC052c0doQbYdcsQlraQAgHAQEFMa8B3j947DPFJH6u3wyJzQPuLNftA0zivx
         sVd2A8gWPhhW2tnz1xhLsJldw+/h0r2zpuK4soQIwNgcpN5crzRva9sA0+t/MpVieMtC
         E7IMvyUJ3i6HoAxr5ozAEznayHuL/2OoAFKkSNKJbHUocu+nbcsqc7yYsJVpJ7WXdP4e
         FeCKOl69cE4EY8+XLh2ic4paTulUB0pPj5yk4dync79WDX7mkVKzgnZpH7WaLjngiTHe
         TUySqzzIjdw1k7C1O8XA6WglvrFKnGwjavbsX9op33//Ta+bs8nTLdO0vMaJ7hT8tQII
         NqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735979725; x=1736584525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mczWY6x/Br+sV6hHlfvuv/eTsFu4HIZUPq7fYqR3iss=;
        b=CWn82WWGNdEi8g3hAa6mxHpuOpCujRgrrxsK/deNGQbejwjPFsJyCtp8VOdFlYsAHM
         gUzvlR25zqTY3F9Onn1osGieuqeV5xQB5bVN9WWcIwCWepw1dHGaK1LEDpbpJczvnErW
         1PC5BtN39o53ItQc7BPI1eSruKtJ8ulxk8s8covJj+8lUEszxpLdGPgQO6z8QTlrbUIM
         alN4mJ5GqdDxrSOvtJo1sP71O3uN63WYsX/lE5tLWKx/9hKKHYinz4j8WKTIrBahhhfb
         GxlMqPnh8h4NLh7UBkdwpUlpwVEXNdhg2QYjGP7WOavsJfSyo27+rVPw2W8K07RSys5X
         69Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXglnMGNpEAVwS8N6GPXP+V9ZFi/O/bDSXjtzBCD05nzsnBA4n3TPn7nwfGbXq4SUudTjcWxzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXtNVZOFIMBw5bOLDNBTHmpMr9i2ZKjeBC6WrItQAS1REICfN
	bPnHov7aznQLAndT0dNs6NIUTsuNDpon8ACp0gqzqEx6FbaAgMZEXOJjmXXYUflKZmuxcGNUPBB
	Psli+OWuIZ0k0RrDQ7QPdqR7rXgaNxoe62iCzC8hlOjvWMF7WpA==
X-Gm-Gg: ASbGncuehzW4I3DhDreegOgCEE+F3Sz99okxZFllPgfVf5euebDikShBiaKuXIdkVRD
	sMoKRhdozktBHn133Uu3BSrvVj7aB6kgvRDvqBnQ=
X-Google-Smtp-Source: AGHT+IH3McdPQkG4vDnAp/l2l13eLiYhYxXoyiiPzZ1cDQF019K74EkXrCU9/ELv+2r/5bf/84BYJoonDjrKot0x5qw=
X-Received: by 2002:a05:6402:1e8e:b0:5d0:8359:7a49 with SMTP id
 4fb4d7f45d1cf-5d81dc74098mr41036309a12.0.1735979725216; Sat, 04 Jan 2025
 00:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102171426.915276-1-dzq.aishenghu0@gmail.com> <CAL+tcoDoE27q4Wus_9rtQDqTezejZdNQ0V-9ynCoN0KZTiqg_g@mail.gmail.com>
In-Reply-To: <CAL+tcoDoE27q4Wus_9rtQDqTezejZdNQ0V-9ynCoN0KZTiqg_g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 4 Jan 2025 09:35:13 +0100
Message-ID: <CANn89i+cr3+k4_Q9=xtQX3rhL34b+2UvqCCzm+wwAHXrxmgCSA@mail.gmail.com>
Subject: Re: [PATCH] tcp/dccp: allow a connection when sk_max_ack_backlog is zero
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Zhongqiu Duan <dzq.aishenghu0@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 2:23=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Fri, Jan 3, 2025 at 1:14=E2=80=AFAM Zhongqiu Duan <dzq.aishenghu0@gmai=
l.com> wrote:
> >
> > If the backlog of listen() is set to zero, sk_acceptq_is_full() allows
> > one connection to be made, but inet_csk_reqsk_queue_is_full() does not.
> > When the net.ipv4.tcp_syncookies is zero, inet_csk_reqsk_queue_is_full(=
)
> > will cause an immediate drop before the sk_acceptq_is_full() check in
> > tcp_conn_request(), resulting in no connection can be made.
> >
> > This patch tries to keep consistent with 64a146513f8f ("[NET]: Revert
> > incorrect accept queue backlog changes.").
> >
> > Link: https://lore.kernel.org/netdev/20250102080258.53858-1-kuniyu@amaz=
on.com/
> > Fixes: ef547f2ac16b ("tcp: remove max_qlen_log")
> > Signed-off-by: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

