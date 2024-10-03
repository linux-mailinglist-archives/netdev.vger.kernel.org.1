Return-Path: <netdev+bounces-131518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B6298EBDD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAAB2374E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99B13D8AC;
	Thu,  3 Oct 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2Q4hm1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30213664E
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945227; cv=none; b=ZuBbv9V3L3W0gSrhhzSgdOShdX8yHRG3mY3rn0cR2RlM2B+VgTZz/NmsdZejkUZQiwOZKfcok42YSUE+dt49NNiBZkcTLYQGCQOABBk4CQCXdW2ThDShUGVNBo7ioFIBwFLqZFf/hhQpQj1aWUSE40p/HYr343GcH+12NTgnjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945227; c=relaxed/simple;
	bh=nh3iKVHuIov7eMZfm8q1FUzsC0zhjNRt9MDTrXyNxck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvicNswXlE9T7E0spG9LP3ffLSwvxfZqVb5+auWsmcCDGwu/LzcWJpzYeA5A7/4iWn8s8V2Ihv/EYiZTFE4loVhPPLesJNDLb/MI7/IeGfPZTN4Z7ylc7dHf5s4PTyRSXBp8IyowcBdObJO5cWC3AG6oWW3F4Mak4UD6ZDyOiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2Q4hm1y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso774013a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727945224; x=1728550024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSiPzrmzoIoMCOJCQ39CROW4s9bHVIocbjOAHp4Gd2o=;
        b=U2Q4hm1yICJi3tKuj/girfaof7VHiCAygejQ/bLBqYhwc4p/eQVYYjd0q+10U04ytK
         FvjGvGJhWuXChJuZY0HF4p5MVrTyEfoNXZqg0flrjH/4ubZuP9/5+TV2+rqtLWzS8x2q
         Lh9bxRADECQBGtTKVhAQdbbIpd/yeQriPCmKc6VPX0HNpbz6rCzfDVrVatw/OINsCmSP
         dYU6hVnEJxpsWqpwY04CsOMhk5fvg9TvCizhAzBPd8qQj4y9XpJStdvCuArjGW/oHaNE
         iM+ZF/AeKqm2mO9q5y9UfAOR8z71DlSiWDaGGB6bIFKuXAaoO7/0Q45e6gutvDi9yobf
         4bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945224; x=1728550024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSiPzrmzoIoMCOJCQ39CROW4s9bHVIocbjOAHp4Gd2o=;
        b=QTeYogcpR0Tu+WQMKet7OCThoH3lirmJmElROJEFKgYqdTDl4clrjJUViG4Z+nAUDs
         koXfIY3t1TYUZav6GPXdCr6jhSeK/wgH0Pr8BUGVNqkMgDWeE7DK44o0bh6jQB3+esY+
         HMX7Z3ytW8bBLhdX9f5jC1WnIWq08Ox8Z2FKbV+Bo/RYZ1Tw86je6iSnS+hJLPXiXpht
         xg3ii2Rmgq8eLmFS3WptWmxqR7XRQtEc1Q1qFPOPxDkhWE2y5yChdxayYeTIjCxFOk8Z
         RbDFAL9zskBCn0LKsv0WgR0b7x8zqPge+iJ5Lbz493qi45In4bZj827oWw0XhuqF2ATl
         VmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXknGwsVm94nobYq+9ySQRk/FIDgc/SKxRivQu5KPOhg88TYAPMFiQX+dL2D1iRilnRlOVcUTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefOidJkkpf9+zGzKgzjpapeLMZHGEk+x0qIAIh+uXP7iYPbol
	ZDBpPXzF4igcP/hy8CRyUh99PYzkMRJMfvtKRyuNzeqhJHlpTEPjJ5Hvi+xj5jR2IYt7PpB4R9l
	KiAkrh8L7lEyGNAZhiBgPiOaYUABHiM0airey
X-Google-Smtp-Source: AGHT+IF+GPKQZszYUr0X8NGccGwW03+Jj//xlIgGpJ/U2dxYRVqSMGOJIQZmNewncQEjXeMhAvXtb9pvXPXWEX8CFMg=
X-Received: by 2002:a05:6402:34c6:b0:5c5:b679:cf29 with SMTP id
 4fb4d7f45d1cf-5c8b18eea38mr4612747a12.1.1727945224017; Thu, 03 Oct 2024
 01:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003082231.759759-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241003082231.759759-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Oct 2024 10:46:50 +0200
Message-ID: <CANn89iKfvO1Z8_ntCre-nG+6jrq-Lf0Hym_D=+w68beZps4Atg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: refresh tcp_mstamp for compressed ack
 in timer
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:23=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, we refresh the tcp_mstamp for delayed acks and keepalives, but
> not for the compressed ack in tcp_compressed_ack_kick().
>
> I have not found out the effact of the tcp_mstamp when sending ack, but
> we can still refresh it for the compressed ack to keep consistent.

This was a choice I made for the following reason :

delayed ack timer can happen sometime 40ms later. Thus the
tcp_mstamp_refresh(tp) was probably welcome.

Compressed ack timer is scheduled for min( 5% of RTT, 1ms). It is
usually in the 200 usec range.

So sending the prior tsval (for flow using TCP TS) was ok (and right
most of the time), and not changing PAWS or EDT logic.

Although I do not object to your patch, there is no strong argument
for it or against it.

Reviewed-by: Eric Dumazet <edumazet@google.com>

>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  net/ipv4/tcp_timer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 79064580c8c0..1f37a37f9c82 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -851,6 +851,7 @@ static enum hrtimer_restart tcp_compressed_ack_kick(s=
truct hrtimer *timer)
>                          * LINUX_MIB_TCPACKCOMPRESSED accurate.
>                          */
>                         tp->compressed_ack--;
> +                       tcp_mstamp_refresh(tp);
>                         tcp_send_ack(sk);
>                 }
>         } else {
> --
> 2.39.5
>

