Return-Path: <netdev+bounces-75882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCBF86B8B6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 21:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D558B21CE2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B06E5E084;
	Wed, 28 Feb 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="1jRHfke3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405215E077
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150463; cv=none; b=QVeFhIbtIAAW+C39+AP+djSqT9HwYSZWxKpJESW5Z46udTbiEkaYzsYR1+5wXwESZqmg90nss6loFJLRR4rC0/g9AfOTFh1IHcbAk7hCXRsnOe06WaKxvZ36dHvY7ZqAu966UCyNdUPtMPYxsgFfZavT3VO6Jft0EUmuyYdTsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150463; c=relaxed/simple;
	bh=OoLOaFtjiu5mHAEpVsVyKx/jaXG/BTwjD3qUzA1ql+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYWzviUASJ2kIZ5PYHYYWmVcURZF5rer8ZFszD/lyEJIK/Lc2XLypHbc7QrbTR8F26OoDzmMDIZvxMeNvjaNz/fJbXvVQOa0Ggi/zG28NorWm8dleSuKuD0m0fJlYDlJn5lU7XeZyum1SY9+2JLgSkZMFVYBMjSZgvuWXB7y6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=1jRHfke3; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d19972b455so7848e0c.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1709150460; x=1709755260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNIoc5z9e1UL1YdttUpqhucICMbrEHRvuLe/Sh1Z598=;
        b=1jRHfke36baS7LtteMU/AHdJM1PhWvMzIb9G5CjU3Wc4d71nBZ/gVvyoeE3O3Bakdj
         zOFUhy0m+UH6C7ZClbBhFkbk+eB0SeeQvWQDnaOw/0C5y0woXx3CGyOmsvFv4Aympe7h
         aTEpj1VrAlBU2wM/WV5UN0ALQqDVLyeaGs8UtCkGyYtZ+vJY9NWXawgkxwyKhI9W/EcN
         4blQcKsVapDhMNKDguOjKAGM8ckdUzuNRJgsAVBS4T3y3P3E5rJ0+2Jg1jIuGkrUrXnw
         0NfRugMSicD9yahdVaihtqSug5eRMmKjlX1MUIGVhoSE4UrCanL810G0SzHlOTzahwdJ
         R+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150460; x=1709755260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNIoc5z9e1UL1YdttUpqhucICMbrEHRvuLe/Sh1Z598=;
        b=luQ3zzG04G8dMP+kZZRX+Ut+vfHD0xOV7mrEQ6sAN6FkMPjwVxhbFFJHg4PpMywnRk
         iyqiyhsG5NwnpTo2hqEaYupAs0OhiaXrwOhw0y4/GNlQtKAcqjV+dS7wZoDnm0F/Su92
         gzQDOJDq/5x2MgiWp/1QhbfyaU812f8NVyddj/nPKdkoGm6vYPXtaXj7BMiwDFuWSsWb
         sZVDqAjz1gHQ1Wx+xYXgEGFvD2tbqikvqTKw+HZHdphLq+O+lh0YtllweN7ewljQuQP/
         CrcjVgkuwziCikJJS5q4Y1E7/c9gqPyMOw0wIuT8y7RSM3sdHxD63rGSFGR10BAi5lZK
         qA8Q==
X-Gm-Message-State: AOJu0YydI6V0IcRlTQw+FMeq4KiLDyqQ8wOYJDCOJn0EUTE2dycbI/hq
	uBoOiD7dNOko6U6oJIMkgKejtkTxJ2dHJmr58dBYxHAKVIQ2mhXCtopkO8VTq58+jtPv3sgfgYI
	p27kZ3t468KOhvUDlb8trTOnh4W5yjlx1Y8/t
X-Google-Smtp-Source: AGHT+IHTBM+WR/AKVjuDKYcFjCDqCl2g6BPsVgzaaT0GitljWXCEQLn8iMCiISvoFBuY/pp5LEQPBVHtK28UNPL4pIA=
X-Received: by 2002:a1f:cb84:0:b0:4d1:3f5d:50d4 with SMTP id
 b126-20020a1fcb84000000b004d13f5d50d4mr725653vkg.8.1709150460121; Wed, 28 Feb
 2024 12:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
 <852606cd9cbc8da9c6735b4ad6216ba55408b767.camel@redhat.com> <CALCETrUZuhvR3GygBfyfLxeas+igNe51Tnx=HEnh9LoFutN-dQ@mail.gmail.com>
In-Reply-To: <CALCETrUZuhvR3GygBfyfLxeas+igNe51Tnx=HEnh9LoFutN-dQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Feb 2024 12:00:48 -0800
Message-ID: <CALCETrXTOQRaGf650+fdyH1yKJLFY-WTpXWkThakacV0GKA=eg@mail.gmail.com>
Subject: Re: The sk_err mechanism is infuriating in userspace
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:24=E2=80=AFAM Andy Lutomirski <luto@amacapital.net=
> wrote:
>
> On Tue, Feb 6, 2024 at 12:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > What about 'destination/port unreachable' and many other similar errors
> > reported by sk_err? Which specific errors reported by sk_err does not
> > indicate that anything is wrong with the socket ?

I started writing a series to improve this in a backwards-compatible
way, but now I'm wondering whether the current behavior may be
partially a regression and not actually something well-enshrined in
history.

The nasty behavior in question is that, if a UDP or ping (or
presumably TCP, but that case is not necessarily a problem) socket
enables IP_RECVERR, then an ICMP error will asynchronously cause the
next sendmsg() to fail.  The code that causes this seems to be ancient
(I think it's sock_wait_for_wmem, which predates git, but I won't
swear to that)

Looking at my own logs, though, a Linux 4.5.2 did not seem to
regularly trigger this, and I'm getting it on a regular basis on 6.2
and some newer kernels.  And, somewhat damningly (with IP addresses
redacted):

$ traceroute -I 10.1.2.3
traceroute to 10.1.2.3 (10.1.2.3), 30 hops max, 60 byte packets
 1  * * *
 2  10.5.6.7 (10.5.6.7)  0.593 ms  0.793 ms  0.988 ms
 3  10.8.9.10 (10.8.9.10)  1.247 ms  1.547 ms  1.881 ms
 4  10.11.12.13 (10.11.12.13)  1.032 ms  1.333 ms  1.679 ms
send: No route to host

Whoops, traceroute is getting a bogus return when it sends a packet,
causing it to give up.  The real trace should be longer.

So I'm wondering if maybe this behavior should be seen as a bug to be
fixed and not a weird old API that needs to be preserved.

--Andy

