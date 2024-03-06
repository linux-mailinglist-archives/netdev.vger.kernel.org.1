Return-Path: <netdev+bounces-77956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C978D8739E3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F58B289F59
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6D13473F;
	Wed,  6 Mar 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCA3pxET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D333134404
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736959; cv=none; b=fbiXLX3vAQv3v8JCXkuiiWzY8wSzohDHf3tX3TngROTbFfhaAzB37UDSo7uZ+G7urFS3wE1fS6iEsRyncBmrq8N63MN0BTzU2ww/pbLR7dqaMnR3vH44hIMo6gfU77G+hRaP+vh+UYZeUdrBRQZPNwAcYeFYxPIdYgLiAVS/q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736959; c=relaxed/simple;
	bh=AIQwTTuZb/bkpUI1B93DUztoPtr/cSqg9ygDBJUJ4wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNGUAQ4n4PJWP2efWDmcJbRzeDihk2NBiQ/ZqGhZNtucKHF9c2UHDo5WcK3vqouHW5xohpW6QIq7GuRgNo561rGvn50lUTIc9fUuBFTruMXNzqYVK557V4rXfp8/AFk47kmsIXBJgjGnyiY2cFrGd9vBLonpLPCvaPavztXakg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCA3pxET; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so10628a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 06:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709736956; x=1710341756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIQwTTuZb/bkpUI1B93DUztoPtr/cSqg9ygDBJUJ4wg=;
        b=PCA3pxETtyhyNcthYqkghg6Y2KQoHBMMzvwveS/aFvk8jlWMAfwxxAFidSZq4HjgAs
         Zq3t5qhpPcLaz1HYn7A4NMrVmdkowBn/AJiaM2UZtBCKJ2fM63LlfB4y7knxXrjcxapL
         0M2yquIhHs3qACve6Hw73Jw5UcBLxnWFrTyjuUzfHHHLyBEC7R6v5FIMwidWLqq88mGs
         qxON+bFaTGzjIOnvGbr3JmR6hA6XK3H309BXhfUmM736Mhl9E44TtXPGnogYTHStBgeY
         TzVo05octd4cESPwntuZOXdLhJkfx+qdX4k+nGZhOQZE0fuQsyraS+Jmm0jWHsDo9Zwy
         cahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736956; x=1710341756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIQwTTuZb/bkpUI1B93DUztoPtr/cSqg9ygDBJUJ4wg=;
        b=LIUNw3uZ59bODHQ/PtggT9bahZmhj52SEXQerRh7m5gBLn7Iq5BNwsZ9YymoswEoaQ
         jO0/1J9ctFL8GFj9w6Jey9NX8nump+JDM0RqAnKoA+Bauycg+0BidFNRX9q0VnOE4fsV
         eSIqSp1B35rMgmqjeRi9wv96nvrmnNIXZavLq07W5GZXfGVrtIUhp9VZ4xSXa0r+qUAg
         uvEMqPNfFx/FZMsFN4QU64UwVQwi8zS8ge9sXsqqUsQhSjoOdzlLC9KWJgzyLQ9TD3xj
         eZuAkOJjBJQHdqA1kRzk3gFE7EiXautntU9h7xZuhU33BMY+bllAb48JiLM+ulCTjjq9
         1Drg==
X-Forwarded-Encrypted: i=1; AJvYcCUD2f4uRB2nH18R+Cpm6zO1vnVKV6XcHB/erQIZUv46gRSj4RLnAPtqz3J+kvGr86PMtX+em7q5F7pvoWD796W76BCOlqEt
X-Gm-Message-State: AOJu0Ywu+Wqww/uW1l8kRbD8gaZxHDw9kf/2b9mAVdDJbJpXGs82D5sf
	7WBS+srJBpOl0tTtN82YGchHbUu7/l8xUMqEMDOrq+ArbCmDzYMgqSCerwCPfe9bgJ64Sn+HxrV
	HMJwBqoDH0uY8azC8wgtJ72UEjWBp3+W17Q4E
X-Google-Smtp-Source: AGHT+IHymXJO0JUCr6GUZP03rcrQSOpK9u+fdHZe7sDeqVpnpCj2Hyv/ZgaXxsHtQjW1ojWdu95kkde6XwSp4tPHO8Y=
X-Received: by 2002:a05:6402:11ca:b0:567:eb05:6d08 with SMTP id
 j10-20020a05640211ca00b00567eb056d08mr154089edw.6.1709736956088; Wed, 06 Mar
 2024 06:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306095430.1782163-1-Ilia.Gavrilov@infotecs.ru>
 <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com> <CAL+tcoBSkBG0SDnjDOzjqzpSFphrE-_Qyw_DcdcebHcRCU3xgw@mail.gmail.com>
In-Reply-To: <CAL+tcoBSkBG0SDnjDOzjqzpSFphrE-_Qyw_DcdcebHcRCU3xgw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 15:55:45 +0100
Message-ID: <CANn89iJu49jEDS3LAmeZLEx_tfebwORnajyFBk1rx0rdbyaMfw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Paolo,
>
> On Wed, Mar 6, 2024 at 7:36=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On Wed, 2024-03-06 at 09:57 +0000, Gavrilov Ilia wrote:
> > > The 'len' variable can't be negative because all 'min_t' parameters
> > > cast to unsigned int, and then the minimum one is chosen.
> >
> > The above is incorrect, as the 'len' variable is a signed integer
>
> The 'len' variable should be converted to the non-negative value as
> this sentence:
>
> len =3D min_t(unsigned int, len, sizeof(int));
>
> See the comments of min_t(): return minimum of two values, using the
> specified type.
>
> After executing the above code, it doesn't make sense to test if 'len
> < 0', I think.

This is essentially dead (defensive ?) code.

Most compilers optimize this completely, no big deal.

