Return-Path: <netdev+bounces-93808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A88BD3F8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CE0B22818
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92E157493;
	Mon,  6 May 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTn1wpW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECEA1F19A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017315; cv=none; b=mzhkJ19KUKmOx1GcDXHpzi4cxLG4v1pw1sxtgPIO/20v/Q3B2KO5m2ggevfSNgdI5A4y3XyPIkcOycsFRS/JTOOOTeSmFYVoIjlXlO2hBaElHF1al7LF3sfaTiFiB2fmAkbCb1EFpNSZ1EvgaEieE7i3wbZsndBdr10WIFKnUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017315; c=relaxed/simple;
	bh=nLJAILkalt6iefFfJPKdilxUb+O6Rn16iRrqaTmBNz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq4fM0IjVCGcmhhUyxFTk0OfT8cRnhWKYVSJNcNsHSsbkTnQeTpZvOfzlQEzp2HeJWGS7zHh8T+dcx66a+sNgZ1ithHeSG1BPIeMEUpbAKEnRAY0GF5eIP6Tr3OZYo/l2WW2C6+W6y9mDkk7ItVua8JSpTf9tfmy1Cb8E3vn0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTn1wpW/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1029507a12.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715017313; x=1715622113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDFGAztt/IhPfOe9B/RQdU+ZVEYUBbkKeWfaXW8xILs=;
        b=pTn1wpW/+NXMEUn6/8N9uvGaft+uQZZfYcdUKwxXmQe7AAeOfRdcm51qmx0EnS7inF
         9MXyoz5yBift0wry9RsW+HI6RbSeMg1zVNlT5utTGsatLZNJPQp5Yh6NBuob1DqeKXtR
         fv99ZaoAv8tUDdSVsf9q5CmCS0+NKK84O/ahzrqpxpXTlBmHoZFOOgHIGVAH60uyfRaM
         Qtu/AiSzqWgM0BXtufRxjYwXS9XtcT7TWmVoopP1JPIpjqsxJ+hgtIWLr3GwFhmrW665
         lXujRiP0jhxoEHzV9CfK9/eVIJvxgLeeLUm464lCDoq+ttNt6y3mAvLHE0lv+0DkR+a7
         Pywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017313; x=1715622113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDFGAztt/IhPfOe9B/RQdU+ZVEYUBbkKeWfaXW8xILs=;
        b=ISOgt9uQRHwc4+U72+DMZb5NfYnfE7xmHbgsAZ9PjND7AudoR9XAnsArRQD/Vu36Gs
         R4SW5SqZAtqIgFWwAQkayumo53ujqriYUACkdHIdwpWHklW668pW6xA1LnEICYSpLEru
         Ke8ON/MTgsxrqtGvwwYJJ2JOEPBxUbXe/DMhlP7NsnGKwKYeSehW1KnOYoAu0rIwe/eN
         7+ekPgFYdUDhqga8MiA+5Rd74qMQ4bGDOcrAHBQkHyZ7BFH0uPjUEnEvQDa9D7XLSz8Y
         oiOmnGkI5gPoCgIkX96yshvznhGVbVe4JpzplN3l8a0r0mtDxC6ZoauZMswAmpOObZob
         o+Gw==
X-Gm-Message-State: AOJu0YzilVEJaWwndZ6YHUogwtkl70qvgJIRX+5kjViXOuogVKxnp9Jo
	HIsGiBg58a2itsjgU6e04/tHqsrKrye4fB6DWg3zIM0q8jHgwQcQ1T15QOYY9PbTBmCtW+EznZS
	LG+MbaK18/2jIOpSbQma3IuJqd+nba4rUG1Jr
X-Google-Smtp-Source: AGHT+IHDOZO0UInyDE0EAJb104RYS2YQUC7CVwIx4Lb45xKW3gzX+3WBNH7OiYjcMqaIFm91bgotXjoqYS2IW0tKg6s=
X-Received: by 2002:a17:90a:ca8c:b0:2b2:812e:1d8c with SMTP id
 y12-20020a17090aca8c00b002b2812e1d8cmr8759723pjt.2.1715017312563; Mon, 06 May
 2024 10:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com> <171491642897.19257.15217395970936349981.git-patchwork-notify@kernel.org>
In-Reply-To: <171491642897.19257.15217395970936349981.git-patchwork-notify@kernel.org>
From: Shailend Chand <shailend@google.com>
Date: Mon, 6 May 2024 10:41:41 -0700
Message-ID: <CANLc=autjsuVO3NLhfL6wBg3SH8u9SsWQGUn=oSHHVjhdnn38w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] gve: Implement queue api
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, pabeni@redhat.com, 
	pkaligineedi@google.com, rushilg@google.com, willemb@google.com, 
	ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 6:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Wed,  1 May 2024 23:25:39 +0000 you wrote:
> > Following the discussion on
> > https://patchwork.kernel.org/project/linux-media/patch/20240305020153.2=
787423-2-almasrymina@google.com/,
> > the queue api defined by Mina is implemented for gve.
> >
> > The first patch is just Mina's introduction of the api. The rest of the
> > patches make surgical changes in gve to enable it to work correctly wit=
h
> > only a subset of queues present (thus far it had assumed that either al=
l
> > queues are up or all are down). The final patch has the api
> > implementation.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v2,01/10] queue_api: define queue api
>     https://git.kernel.org/netdev/net-next/c/087b24de5c82
>   - [net-next,v2,02/10] gve: Make the GQ RX free queue funcs idempotent
>     https://git.kernel.org/netdev/net-next/c/dcecfcf21bd1
>   - [net-next,v2,03/10] gve: Add adminq funcs to add/remove a single Rx q=
ueue
>     https://git.kernel.org/netdev/net-next/c/242f30fe692e
>   - [net-next,v2,04/10] gve: Make gve_turn(up|down) ignore stopped queues
>     https://git.kernel.org/netdev/net-next/c/5abc37bdcbc5
>   - [net-next,v2,05/10] gve: Make gve_turnup work for nonempty queues
>     https://git.kernel.org/netdev/net-next/c/864616d97a45
>   - [net-next,v2,06/10] gve: Avoid rescheduling napi if on wrong cpu
>     https://git.kernel.org/netdev/net-next/c/9a5e0776d11f
>   - [net-next,v2,07/10] gve: Reset Rx ring state in the ring-stop funcs
>     https://git.kernel.org/netdev/net-next/c/770f52d5a0ed
>   - [net-next,v2,08/10] gve: Account for stopped queues when reading NIC =
stats
>     https://git.kernel.org/netdev/net-next/c/af9bcf910b1f
>   - [net-next,v2,09/10] gve: Alloc and free QPLs with the rings
>     https://git.kernel.org/netdev/net-next/c/ee24284e2a10
>   - [net-next,v2,10/10] gve: Implement queue api
>     (no matching commit)

The last patch of this patchset did not get applied:
https://patchwork.kernel.org/project/netdevbpf/patch/20240430231420.699177-=
11-shailend@google.com/,
not sure why there is a "no matching commit" message.


>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

