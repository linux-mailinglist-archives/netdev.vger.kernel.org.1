Return-Path: <netdev+bounces-74675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20120862369
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DAF1F21EDA
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCFD168CD;
	Sat, 24 Feb 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7sRPJHJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064217580
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708762902; cv=none; b=Zd0bfoxuVqK+B4aC4gQJROJwbyq7osvxyghtyojQ8rloEyH7wqsfORp1GBSZqWEaMQvViEHzS/vHkvs8btvTJJqkVNyX3OY8hO0xPo/aQ1CGzik/fmQZ17JZS4rV1K/3P9etssB+1EjxVdPduPpg28jSdc53PzqZYJLHHpOBZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708762902; c=relaxed/simple;
	bh=dKuGj/QziNZozZkFuT6fsdiBuu7xEQHb7gDy6tS7AhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKsRvFiJtu3E5wQ5qkRTgilXoKD63w+WWmQ/1aA3BGQFMfvR9SUwnfZoA5qPWxTLawk91xllF2v2IJ5tXXW1EBwaa+zwEpNVHg5ChHIqrVpEZX86iw+KLgIdDK7hJaMMIyOOZxroqUBrynWeRieKs1LinV3K/cz7vtwXPEMXaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7sRPJHJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso3656a12.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708762899; x=1709367699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKuGj/QziNZozZkFuT6fsdiBuu7xEQHb7gDy6tS7AhE=;
        b=y7sRPJHJeHIAel6VN+M2k2FLkJqt8IrV5X5aPTOoZvhrfpX35bQXz0fnGI0J/mTgvH
         8ratkr2hh1KotAG8e+6JgP7mcge1+CqvC9wdfyQ2eAvIAoUXS+IlZT6qNTkV3q7TMZnE
         9KK6PLtxwKHF8o32X3RFCDbiS4EzNRbkdmfjnFBOFJGEXwtNjg5bnxC2Of7Q8WfzB4Iv
         PGrxOCoeogBg5XQv2ZG5rm9muWKOjZfPTpM1hXd76JT9Yd4bM1OluobIAQ3n0W60+PUU
         k3CNA0Mzocm3u3q2fmTurIm55nlXGnwTabod61Yxno1TOu6iF2LSM/jWfvOpovoZAd3A
         lLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708762899; x=1709367699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKuGj/QziNZozZkFuT6fsdiBuu7xEQHb7gDy6tS7AhE=;
        b=Fkx/cpZ0iSSFAA2LbqTV0iS5GWgwdM9LiPjL7Fz/5eeuKcu1SCfMSYTnbUf3zlLSiE
         1Lryh5jYKHN+W+7RJqFbB/z6eacCi7XuFxWEKvtqUgB9EpKjFlvU3AXH6sfi+D6ZpR+I
         +vwSe4L19vDdMIcSjIvYZ7wgtZdeEsExEcxS2gAMRZnhOJFpMbZjZ9Yim7vlHfUoPPdV
         HQ6OsBbIXF8MVSdw3OcDqTOpZMsdFdymzxJHNGyPkq+SGd60ncjZzz9JdhfH+icbe0GN
         FI4ZYbSsvsyI7Nq3OV2QhuFEnOSghe8t325S95tN7rHi3k+y+oXzi2mE6NsPCttQ1HZE
         6yLg==
X-Forwarded-Encrypted: i=1; AJvYcCUIBL9R8suwLuhPn/IRP8GiI42zbSMSqNkjDFZe5/8Vd1e98ro+mijjt2w58nR67XdtCOAZbkybGoBvKyF1WUcs3SI6x/h1
X-Gm-Message-State: AOJu0YwOMqWdDQbI9e9a6BOTxqbKFzTt7PxKVQRbWWGcbOW7Qo2Xxbq1
	e0jF2cdO1QeuoK034aio5iqXdItsGSwXHHcVzs2HKPXSO8y03/OEn83WevfWTgrxcj62XhBu9zl
	E0wfOOYEr5Eyi0ikvsYdPpcJiM7NIkl1841fNUVbcMktHWDcd7A==
X-Google-Smtp-Source: AGHT+IF4oa5fjnkSUgWIVhvFLIpLZFVp41vFYgYTcACeYJrTtv7HObfGAffp+t0Dta56g2yll+IHq/XQOqF0+yEI+ys=
X-Received: by 2002:a50:a6d7:0:b0:565:733d:2b30 with SMTP id
 f23-20020a50a6d7000000b00565733d2b30mr111245edc.4.1708762898603; Sat, 24 Feb
 2024 00:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com> <20240222105021.1943116-2-edumazet@google.com>
 <m2wmqvqpex.fsf@gmail.com>
In-Reply-To: <m2wmqvqpex.fsf@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 09:21:24 +0100
Message-ID: <CANn89i+UXeRoG4yMF+xYVDDNv-j2iZYTwUogQWsHk_OiDwoukA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/14] rtnetlink: prepare nla_put_iflink() to
 run under RCU
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:25=E2=80=AFPM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > We want to be able to run rtnl_fill_ifinfo() under RCU protection
> > instead of RTNL in the future.
> >
> > This patch prepares dev_get_iflink() and nla_put_iflink()
> > to run either with RTNL or RCU held.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> I notice that several of the *_get_iflink() implementations are wrapped
> with rcu_read_lock()/unlock() and many are not. Shouldn't this be done
> consistently for all?

I do not understand the question, could you give one example of what
you saw so that I can comment ?

We do not need an rcu_read_lock() only to fetch dev->ifindex, if this
is what concerns you.

