Return-Path: <netdev+bounces-219737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F7B42D51
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36408486290
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2C82E9ED4;
	Wed,  3 Sep 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GAmlVTOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582E1D88A4
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941782; cv=none; b=thDuJPI27cE7Z3vn67Eeg1yZj/dyWIwTEwxyvjpBlCkXcYyp2v6TS7NPoJTJuynQuN7bWcaBehDplzSObALYzem8JYtyrgs4ThW2UwOuHDSsBZnPhTXEK2jwmKPbflyumhc1kSUCKPWplKyJFa5umBh0tfmBPTO3k3BjAnWovsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941782; c=relaxed/simple;
	bh=r2tw/SXKsViGJosKPqa46gpirEWHmAwA16Ckt/uA5bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMIT84F4btZ2RkJZlDHnH+S0kr81pzk8nWSx3/w2k18HNg7s68hC5CRIVEMMn3Yc0ialc7mwSVXqB2x+sY873dBPvpNUys6Ujqv94h/ltNwFp8qoPUp2S8A/RvvvQmfwBET7fVfkyVOz4fJgxjAFFuMoMPjj7TwnphF04NqtIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GAmlVTOx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77256e75eacso457111b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756941779; x=1757546579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4XIWP4mz0mOkbzLcWDjXBPjad5L7kQQIgQS1CIcJ6w=;
        b=GAmlVTOxtuWlDVWagPxBZGTlySkp96SH66DodT35+FwNqzOJp1mLmRCuHOiDR9JrQi
         NAa8Haaz8dLtCwGcCu3N5TdeTDSaMb4F3ehwlsuAaioU4BwNIHg6WJ7IBbd2Qt7p9iUE
         m8dyzwrHWiZvXF7FlNLWLqno9h95Dyktr9/O9Na6NkxC8tUXu3t2a+uNAB7Shn5ubzed
         8jx3eLmgRO9su3SSW+se+o2AUtKc+B13/RXYuUHNMnixIvqeB229Hqe3V0WL3skSeJN8
         3oorte4cgxHI2IoghR800+cVIZmgvudFnaVcxYMt5j7h+8ZSexPiR2dmMs1uA6US73YU
         W9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941779; x=1757546579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4XIWP4mz0mOkbzLcWDjXBPjad5L7kQQIgQS1CIcJ6w=;
        b=YIUzzW0aylcrkjrJJXrw/z8JeuKjp0GaFlZmN6E58CxkqQ4/vBCAxFGmsWExaV3ANN
         4o6450g8El/bkZKG9Tu3mqHUKGj4WE2PrBJvr9b4FlxtNj33WDpiE+CUUulhUaRhe/3Q
         8qRCOZpJcwjEkwE9tN9Rjq32X+UQXDRuNG27vZTlLHaz6cI+rGYms1B/K7t8SrZ+ILLk
         sRhCbdtXJPnbg+Iw3Hskpy3hoAeDp/Gry/iVoFmQ2CHPZYyHVMs59B7SUsInuqFwKV5W
         zFmyTTBMQrXRal/zP664KKNYTE3k3SJnUOYDaJhoga3gK2hzkU3fdC7r2DqoUFKn6hd1
         msSA==
X-Forwarded-Encrypted: i=1; AJvYcCU/QGdi/GV8c45mQFlav/UqB4BCntcnUYRB1PyVnqLi2c9Wn1+hDzNK28QxOO1XtYUKtcb1tMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9+9mEOsoSX0Y5oDfX2pt+CH6lvERGxRDs/Cb4kmA7aVp4ARY
	KQh7buN5f0Fecj8WQIDVrPFZy1PWQfQ+nGSvRjemBxrXBhojOxL1wQ3irzlyJcdxyBRg/X6w/z1
	3HApEEfT4Goz0gWxtxDRU3wUCiSi6okheWg+HmWAi
X-Gm-Gg: ASbGncspz8FJh5XWFpszSW6oTDUwO9M3NQKTLw8UxhKs6+30Izn6BjjcUJRglYd9Jci
	mJ97xaEr629cQrOIQvdc8jhBOojRIIXxrw5DQJyvB9724HPTjjJpehh7Mi1qLUvc77wzssvT9hA
	tm5izfTmklijDX0R9gJpv/Y5bXknikuJI+FyFDBldkLz7pcOtSzA08FA1cXf8tPVOtaNjZVxVSo
	rP4yR617EzVUX7RKBE6nwpeHiaaGQrw41e8ntDPGEWv731JK3D4SzmwmNTl+VaBWlrTo+vpBFsP
	S+q45XRTHCwnO8UtD/hFOL3HefPM04Xz
X-Google-Smtp-Source: AGHT+IH9MjGeox+wSgTiIMBeKsSu7LetRxaQTb6E/Q/TtqttUThhXc5gLE93MsmjwoVe3/bGA3nnvBy9ymVgyancptg=
X-Received: by 2002:a05:6a20:2586:b0:24a:8315:7f2 with SMTP id
 adf61e73a8af0-24a83150a75mr1841811637.49.1756941779042; Wed, 03 Sep 2025
 16:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
 <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com> <CAAVpQUCiaQ7yr+5xLYVaRp6E2pzNDwSiznEOkmd5wS-SAosUng@mail.gmail.com>
In-Reply-To: <CAAVpQUCiaQ7yr+5xLYVaRp6E2pzNDwSiznEOkmd5wS-SAosUng@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 4 Sep 2025 00:22:47 +0100
X-Gm-Features: Ac12FXzVdH0aYM16lsXXLkWflOvz9fPrPjqdH7hlsGgyEtSmdjfndIM56Q9g4_A
Message-ID: <CAGrbwDQVeE=-gVNQhWZ_YqsMRTX=2B49O7k3j-FjVHCLrTWUnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
> <devnull+dima.arista.com@kernel.org> wrote:
> >
> > From: Dmitry Safonov <dima@arista.com>
> >
> > Now that the destruction of info/keys is delayed until the socket
> > destructor, it's safe to use kfree() without an RCU callback.
> > As either socket was yet in TCP_CLOSE state or the socket refcounter is
>
> Why either ?  Maybe I'm missing but is there a path where
> ->unhash() is called without changing the state to TCP_CLOSE ?

Well, I meant "either" like in "*yet* in TCP_CLOSE or *already* there
(being destroyed)". Let me rephrase that as I'm going to send v5 with
your suggestions for Patch1.

> > zero and no one can discover it anymore, it's safe to release memory
> > straight away.
> > Similar thing was possible for twsk already.
> >
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
>
> Change itself looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks,
             Dmitry

