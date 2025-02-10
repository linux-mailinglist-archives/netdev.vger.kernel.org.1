Return-Path: <netdev+bounces-164635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD5A2E85D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36AC167607
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382C1C4A0E;
	Mon, 10 Feb 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtVptRR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1162E628
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181397; cv=none; b=MduRr5vi9r/b1Lha/d0Dlbbsxt2Dme2ZkWae+m6xYPIpLwWM2c0x77loCC93qj1M+DZyqGxbKpDHRuFeATYPu19HGbxZc9kSMFLuQPYRo4jo0c3nY1u1GxsZcwoJyQzTn0Umo/ZvD7beYLMtt/YZAbA9/JzEoAXuWCrK2/Uey6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181397; c=relaxed/simple;
	bh=YHZAunicXBq4GqntID36/UkKinapWGRC3Eof/WWee9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/7N+cpj8usJdTUXwLHrMI36mNTlBGWzHS13OjKS86qGEHjyX3w4ogaFj2EccqSdbOMqTCnCFGhYPISzKW8NUXuRhLzPcZlAIe5D7zhvYCWhk/6d7K382foS1f3lborp/Rdvar6MMxawFO+9dxWV/I2XVbLN7VZrrSYKbFQJER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtVptRR1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso1227989a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739181394; x=1739786194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaB8XrOaSPmPtRRfAfMhTkvyvw08PCoAdw6Xdl8ljmA=;
        b=AtVptRR1e3b/5mi1gb04cnmMe1/Pr6/7AvkzJcRiXNPzhI25842BT7062GMZJNb8TH
         cDyvkWRStzWalXYmE9minuGxC8QUwS9952MbjpcwLGH2BWRYluhuNYNOt9uwwKQ7cRvJ
         VzCvEqD22oDKHOw49NHE1839qs502ySOIex+Ac8F/VAfKsIb5fneiNtauA5YfZctWlZp
         REJestGuJaadNfaf8D7nneK1kugirEJQ24Yc1D0ydxiyUruFsELnbDr1cbI+76AnGjuN
         j/FAiekVR0PlnH5Czil9SafOB4WmbjGNNzX0EbmStMSp6TeUbibgdlRADLbUqPfaBcij
         6Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739181394; x=1739786194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaB8XrOaSPmPtRRfAfMhTkvyvw08PCoAdw6Xdl8ljmA=;
        b=rSWeQD38AytoWAi7qrPAJ+eFW3Yp4eh4K4IeprG9S4cWttEdENPd8KMQQR6SUqf9kj
         NLBv/KRNHy6+zY25uT680cRFxABjc8xgm6xERtUaiUzyhKyyK2D77hQ0apKHA+oj/tPK
         K+fJ4evLuNOhAGtJsUI3G6Td8zJluMPKCLKsUF0nua44y9Q3FcIpSE+roxmIQWDaQ0SB
         oWFcGHKp+IgQfwFSSLwz+yWoWdj+9gZV6vHYRPDNiA3m7QbMf3VX9HIjg3r0lxzSOnzN
         XbIWGDA1ZDTvNPrAOk/95YeyiWaeT3VJBg3DFOcZrle/a7catIXIe1nm848QEB+BMQ+h
         0imw==
X-Forwarded-Encrypted: i=1; AJvYcCWvG78QO97d6LCUBw/6ec3EglBLcwWph7HPJmn9P6EE89UQBbPvjDD79BpnDzToA/RtT/CKpew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mlIVIokXxivey9mlOzIbDbRD+hWwlqwFruHuW3ud/JDe7V7w
	eaAl9Ac+3ZDs/xCs2+wQ2yHJei1BYjCJy57qSJGydxw6cQDSPN6zmk7rbLg05ImtZ182ARrKOJG
	g7H38YFBvPten92rGqCB0mwKwI7vjhxjVusqo
X-Gm-Gg: ASbGncsYcG9oSGBj3pyEDwkxbkzX+v1Cp0vKevDwpFe0vF4srWW+XwXexyc+Zzc5tOT
	NvBsdl0Bju+OB/x6M5rl74SJbjgqUcUZ87aSjX98F5JfE9ML8DqpNi/39t5HE1QfrtAsjrUid
X-Google-Smtp-Source: AGHT+IGq2rRIV0JLfwK3nTRpZQ0SV+PeKupbvawARyi0VIFBhzdmR7cElx7NAhsEfqD4wkok4Tl4xrqRmDXK194o04Y=
X-Received: by 2002:a05:6402:1ecf:b0:5dc:1395:1d3a with SMTP id
 4fb4d7f45d1cf-5de45040136mr12859794a12.1.1739181393796; Mon, 10 Feb 2025
 01:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com> <20250210082805.465241-4-edumazet@google.com>
 <Z6nHRDtxEG393A38@hog> <CANn89iLCrohtJrfdRKvB3-XNtVjKDucNeTcxrmn4vAutgFyXAA@mail.gmail.com>
In-Reply-To: <CANn89iLCrohtJrfdRKvB3-XNtVjKDucNeTcxrmn4vAutgFyXAA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 10:56:22 +0100
X-Gm-Features: AWEUYZnGRZVWbxcwR30TkUYoDIqlU-fXnpdXIXCJNFyr5O-h7XmUtCgDAWA2EIg
Message-ID: <CANn89iJFcibv9J+fe+OzNVw4t5tS-47GZpmHKacSQ9mS+g1TUA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:44=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Feb 10, 2025 at 10:30=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.=
net> wrote:
> >
> > 2025-02-10, 08:28:04 +0000, Eric Dumazet wrote:
> > > @@ -613,7 +613,7 @@ __poll_t tcp_poll(struct file *file, struct socke=
t *sock, poll_table *wait)
> > >
> > >       return mask;
> > >  }
> > > -EXPORT_SYMBOL(tcp_poll);
> > > +EXPORT_IPV6_MOD(tcp_poll);
> >
> > ktls uses it directly (net/tls/tls_main.c):
>
>
> Oh, right.
>
> >
> > static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
> >                             struct poll_table_struct *wait)
> > {
> >         struct tls_sw_context_rx *ctx;
> >         struct tls_context *tls_ctx;
> >         struct sock *sk =3D sock->sk;
> >         struct sk_psock *psock;
> >         __poll_t mask =3D 0;
> >         u8 shutdown;
> >         int state;
> >
> >         mask =3D tcp_poll(file, sock, wait);
> > [...]
> > }
> >
> > If you want to un-export tcp_poll, I guess we'll need to add the same
> > thing as for ->sk_data_ready (save the old ->poll to tls_context).
>
> No need, I simply missed tls was using tcp_poll() can could be a
> module, I will fix in V2
>

TLS also calls tcp_under_memory_pressure() via tcp_epollin_ready(),
so tcp_memory_pressure needs to be exported as well.

