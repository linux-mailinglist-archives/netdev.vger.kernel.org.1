Return-Path: <netdev+bounces-66358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0383EAC4
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1AD2859EB
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 03:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4711C80;
	Sat, 27 Jan 2024 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="fXk3AKc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC481170F
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327951; cv=none; b=S6vrdrX7gPYrlciisL9+R+MuutHXj5ICdKtJIGIBBoQiZ6AG7x2NkeBUwmcwKwuBvHQ0s5S1Tiqz1+eHszhs9HcB/8McTq2wid74JTXIXluaXCr3IsDvRleslkCnZkl3NXPzYCB9bBeumzZDURGoogFon6iIfHcAvo6itYvNQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327951; c=relaxed/simple;
	bh=eTQEXhnfypPww0cVNl9MEzmf6vsRKlkEfS2MTJWuWpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acOtQSyX0V3MZAMwdmpn+HzcGU+vdZ2wYOvfhkE43nPEqC9fRWbt65xCKMMC0pCsuY9aW+pxUkWAlaUvg67z/pfgXSxdkfZZK6+GsV4gLhRsbuwvRvtXncTiN1jTvSPNRSyhA2kDOKFJq/SppZ/yhT5rKVzt0do8w0HG00Nj0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=fXk3AKc6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso18564495e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 19:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1706327946; x=1706932746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTQEXhnfypPww0cVNl9MEzmf6vsRKlkEfS2MTJWuWpg=;
        b=fXk3AKc6l3z/vCm32Nugy1/40SSAXwmok1tsPU8DEyZiIIzWVm8q5sxN50M4jRWiQ2
         74k5VkEJlxW/DSw2Y9q4zqWtiYkzivkciEVscJvTilQDNtRJmMwC2yYtqqHumOIAJaFo
         GhA996wz8QIPhZYuwse4ysEN4TA/uEmyhWZac0xfVgXlJOTVw35G+/4LZMPMUFIRAZiX
         HJgJeuVFe+OVlbo23a5yLmNxplfpYE4EugQSwz/AgJotbMmfpnno93TR4bWswffSBnh+
         fApeZtm/+DXOLXwCx6gZu10JMSRmuRRGH9V1yVhXyCUD8Rd/MiR6zt8h18QaafNYeFJV
         27jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706327946; x=1706932746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTQEXhnfypPww0cVNl9MEzmf6vsRKlkEfS2MTJWuWpg=;
        b=FTiOW6VsL7BkINOUwBV4Eq6rvdsbbuwApUIppxSL3TdrmMee2BL++vEaZOVqsrLwWs
         iO0yGxAd//feWTvWg8/4i29H746EeIenOPEMftuV9f7yKLmWMwCI28wLunfC5Q38Q2br
         QN3flDtU9y47Kzn2GVuRcl4JbLO4a3Z7oJsMAcRurYGp1EKu9/kB+z2s8prYi5QPuDod
         NI/q4jmjPfI9LUAWKUtHyNp+E1Egd8x7iD0YoYnSKUjZK24UvVCAQ2eHo7klLXb5fRPE
         C8BeVnkwdh76CJmXzM6mYAj2lDHPzUPIvYE+OnJL/7YV9YWtOoHFpAyCIucOHyft477+
         opYA==
X-Gm-Message-State: AOJu0YwdiLydVYHZ/Yhdf7ohGGRZw6ywA7Jm4+IbzjPcpDVZ+5M7UUzw
	bikO+maYOaROnSiSKGC++1LmaJhEHdeYKPk+iDGWAI85qXCyH/GC07eEsfqX3AUXewbL3G8k3FA
	mTkH1ulWrbUjVZjpr4mb/hD1OV7IQlz0tVKzAtjZDkH+xqKkK
X-Google-Smtp-Source: AGHT+IFr5C8zZ6k/CLFtRpT88vfoN73LTRUvLxcbQJVNxAsKZCJOEkW2n3HOo4IDDfUhHsL+WcF7mY/OqYfU4/ddUok=
X-Received: by 2002:a05:600c:1c88:b0:40e:bfbf:f383 with SMTP id
 k8-20020a05600c1c8800b0040ebfbff383mr519994wms.136.1706327946493; Fri, 26 Jan
 2024 19:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk>
In-Reply-To: <87y1cb28tg.fsf@toke.dk>
From: Pavel Vazharov <pavel@x3me.net>
Date: Sat, 27 Jan 2024 05:58:55 +0200
Message-ID: <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 9:28=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Pavel Vazharov <pavel@x3me.net> writes:
>
> > 3. If the above scheme is supposed to work then is the bonding logic
> > (LACP management traffic) affected by the access pattern of the XDP
> > sockets? I mean, the order of Rx/Tx operations on the XDP sockets or
> > something like that.
>
> Well, it will be up to your application to ensure that it is not. The
> XDP program will run before the stack sees the LACP management traffic,
> so you will have to take some measure to ensure that any such management
> traffic gets routed to the stack instead of to the DPDK application. My
> immediate guess would be that this is the cause of those warnings?
>
> -Toke
Thank you for the response.
I already checked the XDP program.
It redirects particular pools of IPv4 (TCP or UDP) traffic to the applicati=
on.
Everything else is passed to the Linux kernel.
However, I'll check it again. Just to be sure.

