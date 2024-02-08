Return-Path: <netdev+bounces-70377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8741A84E9C7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C6AB28047
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6C3EA67;
	Thu,  8 Feb 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="I8oRC6K5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED744F1E1
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424851; cv=none; b=gw7OfWa4Jclkpcmt1JNZTpcGaZNGNjjgMKemGuXaGqcbJq2h7fJ3ZD9y8X+r7GbTLRMT9a7WXiHH+38NTixIZyMAGIYNSLGRbd/SZ15zORV8UtHIaSMZ8wBLrwt+XoSZaGw079llj2C5PxQwTgzTbJ4A3Wg+EHefWzj1Mkuw0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424851; c=relaxed/simple;
	bh=ga4ULga7g2GIWamrr4laebCK5Zjy0BEhbeQ7MlM0618=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuUnhwdmu2KsyBZBJ2l5Qu5Ng86wyLReYXNpSagNYES7YmXS8cdHXq8o2p0697B06/7SrLaSaxk3+kUIWGhaXYRtnCm+3cm+ULkuFBt+ODQ7Qp7+6Cd7XBvwYz9leAB0dbsxliECDQK1KK8ZnpYba3mXaHCpZgHZTjegEP03JTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=I8oRC6K5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c03b2ac77aso34723e0c.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707424848; x=1708029648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQYuhPwf89MOoIk/qFHllaTijS8wOxvgEWYqCkWWJ2A=;
        b=I8oRC6K5342/JJMPYGtW3pkePdHFKVCqVNvxbYIOFrrsCVapMfi1zgzCn/CVFwncWI
         db5OBNTDPFvMBhTNJsrQToee2nBZ323GQkGXP0lBnIRYYs4xSMGnRdOwP9XtI28TwfVb
         sZ07ggodClwTJ1QVG2QWZUnX/1VyROVvFo044avdNo0jW+NZwcvZpZw2xAysvOA3A+xH
         0w1EbbjEJPJjYU/LITRWHCKDdkJI2MV4DuJh/7kkexoVmr4THMMNMaUFzTcJLVS1a0RS
         BdR2yTexs7VIgup3p0Ps/ZgoREfUEnDdlxBRIY9lE2DkwLKyNfPgTP1m+UqGYyuQYlId
         sAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424848; x=1708029648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQYuhPwf89MOoIk/qFHllaTijS8wOxvgEWYqCkWWJ2A=;
        b=uXp8hrMlyzo16Gjx6Iyl+3iBA/IBg7ejfr79jCZvd1k0vhhu/fPM5jUNLmM3IfQu8D
         czD/LUUo0NL/2WMLUZjJXqTMy4F+y+fviR9CtFXMID7Py7hOttBuMtTJkpCZupU9CqCm
         AoRuW1sqL5v3jelcKe4jDksmbeifLTN27nGo3tuuTQyCfsoMkb2fetyba62LsiODvQ/i
         YhnZZT+RLU8W8DpnWGVb5/oOYZuVcaVRjqDjhRwE78wVgmW6BFaTOh3wPSgxXz6nSx1W
         t4/Ogbi9K6MZZ1okICGshhaam8jLohlSzakNGaHnB8+yV4nGOLhhzSZaVFKej4ggxVsB
         BWWg==
X-Forwarded-Encrypted: i=1; AJvYcCVlEyQ43V7I16tFZs0rc/zqW2Q8migynM65aK8sLE0L2t0EjzAWU44hClABrzv7+mngUiir1Lhlviv6OdkuzAwkkIsv0CUW
X-Gm-Message-State: AOJu0Ywae1O765iQN8Xg3TK7qGp3DUFBe9axjfvVRY57dtpAv1i/zBul
	7R9M+FJ1ccDb2ts1xryU9ErMJtxCMFkKVtv1TxR/PqfQ0/2eKly5+2mzcJS1j4jLRwPZs76xSh4
	CbNjcNwCKGyqcygS9PuxWqaMkbbytV3iMuGDk
X-Google-Smtp-Source: AGHT+IHtFk/NgwQNlxYZ2ENGD8BCV+5dayWmsUIXGgmvFZaaYcwaA9MLABKKvd3jDU6QK5KD7rLTS/SJQklg46AQSwA=
X-Received: by 2002:a1f:c8c7:0:b0:4b6:aeb7:3f1d with SMTP id
 y190-20020a1fc8c7000000b004b6aeb73f1dmr771409vkf.9.1707424848434; Thu, 08 Feb
 2024 12:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
 <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev> <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
In-Reply-To: <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 8 Feb 2024 12:40:36 -0800
Message-ID: <CALCETrVM6ooAH7eaZc6Ugh3FOon3M-ohWAS_CVQFc_194Vj9GA@mail.gmail.com>
Subject: Re: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Network Development <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:05=E2=80=AFPM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Thu, Feb 8, 2024 at 11:55=E2=80=AFAM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
> >
> > On 08/02/2024 18:02, Andy Lutomirski wrote:
> > > I=E2=80=99ve been using OPT_ID-style timestamping for years, but for =
some
> > > reason this issue only bit me last week: if sendmsg() fails on a UDP
> > > or ping socket, sk_tskey is poorly.  It may or may not get incremente=
d
> > > by the failed sendmsg().
> > >
> > Well, there are several error paths, for sure. For the sockets you
> > mention the increment of tskey happens at __ip{,6}_append_data. There
> > are 2 different types of failures which can happen after the increment.
> > The first is MTU check fail, another one is memory allocation failures.
> > I believe we can move increment to a later position, after MTU check in
> > both functions to avoid first type of problem.
>
> For reasons that I still haven't deciphered, I'm sporadically getting
> EHOSTUNREACH after the increment.  I can't find anything in the code
> that would cause that, and every time I try to instrument it, it stops
> happening :(  I sendmsg to the same destination several times in rapid
> succession, and at most one of them will get EHOSTUNREACH.

I caught it in strace, finally.  And I also finally grepped the right
part of the kernel tree to (I think) find the offending call chain.

__ip_append_data first increments sk_tskey.  Then it does:

            if (transhdrlen) {
                skb =3D sock_alloc_send_skb(sk, alloclen,
                        (flags & MSG_DONTWAIT), &err);

(I have no idea why the transhdrlen path is different.)  That does:

static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
                          unsigned long size,
                          int noblock, int *errcode)
{
    return sock_alloc_send_pskb(sk, size, 0, noblock, errcode, 0);
}

That does:

struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_=
len,
                     unsigned long data_len, int noblock,
                     int *errcode, int max_page_order)
{
    struct sk_buff *skb;
    long timeo;
    int err;

    timeo =3D sock_sndtimeo(sk, noblock);
    for (;;) {
        err =3D sock_error(sk);

I'm utterly baffled why that check makes any sense whatsoever.  git
blame informs me that it predates 2002.

I'll contemplate a bit more and send a patch.

