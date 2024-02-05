Return-Path: <netdev+bounces-69316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8284AA6F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B122877C3
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D5482F6;
	Mon,  5 Feb 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="L0apddeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41E48793
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175349; cv=none; b=UFrLI6ivYE81gT+KXC/jk+y8RkrHAKXEJZ6KO78m0krDmDLw1hOM2AeWwyAYw6OL6q4UlKJkE1QpgI3k0aWRgMKPIjoRSs6FbULXhlPjT8koZjwyNYp88oTilAt3TjG0Mfn20u66PX4GRHHFz182/JiatVvr4ZWIL+R8m8Rjt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175349; c=relaxed/simple;
	bh=74dwUmASiC5281r5Qa5Ji5vlhd4W5FfqDIK6lHuXtZU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=p8Y+TXroOYfk5CIg8z2oXVt3sW/mDCNWHwSbOdwER0+68ZhxFKNh6gdU3BqjHCs31hh6L1yZBUQXNidqZf4bARrNtw3c+kFhD2x7eHk7Xc84GAM49JLLJSEJIHlkZSsKtUAIbjLBi/mgiLoTkcnKZ8ErIOf5GJRLtPxsoIL7iow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=L0apddeZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d958e0d73dso114285ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 15:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707175347; x=1707780147; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6NjLDojCJ01ycTp+FJubWJrJAO4uHjpTvj24wR9Uz4=;
        b=L0apddeZ45th5nxxbGrXYZAmZC1f8EuWklVBUjtWDlNo21YayQC7fWikJNDYaHbRvc
         urD2YpIOvLlnVjII0i4mCr0Nde2sUz5AR/4gkD8YmZxaZ+a1JrpqCwAgQEsH64a8wg+q
         Yag0jZVneaMVfEDVHtD0zBrjXdEmR63FPgF1HhWix8Zq3vm2cH9uI+NOwGukZjQDaRNN
         I447zQX8TwynPP4rWunaXGGdpBRLT2ISGH6N3ujGEq4S+NQQcRDOb/JftexWIn+/y1Pj
         FdS8pXHixQXqVjbIPJCXufHl0eJmjvQElLSFW19ylCPm9J+S12huIexGW6fEbcDVz3gb
         Hnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175347; x=1707780147;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6NjLDojCJ01ycTp+FJubWJrJAO4uHjpTvj24wR9Uz4=;
        b=sIAdscgP919TJ0pcx4cB6ndMLwAWVz4hneQKUDB3IqBse/p3D7VepSowhd9G+Pe7Vu
         QcwqSftVHaYT54aV5I1fPLfT50npfrGbuUY1sMCmjCphcljoHh9WDlMvlH36KfDDw19y
         hWZ4VAw/XYlWSQwgGUWjIrJIaqo+thVAme0PPhmYsaBP1hPo7jxXunxVoijjxUoztu7N
         lSBni0QlYoz0Ug+KYIlKmAJL1kvzf+JGRvwKa+TRxfivNbuBF5yXWbQqsubDteAXU68b
         LcLXoggarTJOPe0e2LHUMJgsr6CYaZl75TvqCjJZtUvN6ntTedr8/IesRdjdbK63wJ1+
         +Ehw==
X-Gm-Message-State: AOJu0YwH4M7QstYUE0PeWDhteJZEOweZ4U5NmoLKVJ8HzMo8iTpFRkiY
	t1TRj3ydrMOJpN0Pmducix6kpCsReSZGUGGcWuEuiRU3J/98qi7eie0unIP8Mw==
X-Google-Smtp-Source: AGHT+IEDlPDde7O7sYDTaCaZ32fPcwCKIWJEsggCvuZGi/iJqztBuGhug66KjRMdd/Paf3sWpzkKAQ==
X-Received: by 2002:a17:902:d902:b0:1d9:803a:8b0b with SMTP id c2-20020a170902d90200b001d9803a8b0bmr1234338plz.33.1707175347369;
        Mon, 05 Feb 2024 15:22:27 -0800 (PST)
Received: from smtpclient.apple (c-174-62-80-154.hsd1.ca.comcast.net. [174.62.80.154])
        by smtp.gmail.com with ESMTPSA id lh8-20020a170903290800b001d9119c89fasm425232plb.155.2024.02.05.15.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 15:22:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: The sk_err mechanism is infuriating in userspace
Date: Mon, 5 Feb 2024 15:22:15 -0800
Message-Id: <76689FA1-68C1-4825-AB9C-804966ABC34F@amacapital.net>
References: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
Cc: Linux API <linux-api@vger.kernel.org>
In-Reply-To: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
To: Network Development <netdev@vger.kernel.org>
X-Mailer: iPhone Mail (21D50)



> On Feb 5, 2024, at 3:03=E2=80=AFPM, Andy Lutomirski <luto@amacapital.net> w=
rote:
>=20
> =EF=BB=BFHi all-
>=20
> I encounter this issue every couple of years, and it still seems to be
> an issue, and it drives me nuts every time I see it.
>=20
> I write software that uses unconnected datagram-style sockets.  Errors
> happen for all kinds of reasons, and my software knows it.  My
> software even handles the errors and moves on with its life.  I use
> MSG_ERRQUEUE to understand the errors.  But the kernel fights back:
>=20
> struct sk_buff *__skb_try_recv_datagram(struct sock *sk,
>                                        struct sk_buff_head *queue,
>                                        unsigned int flags, int *off, int *=
err,
>                                        struct sk_buff **last)
> {
>        struct sk_buff *skb;
>        unsigned long cpu_flags;
>        /*
>         * Caller is allowed not to check sk->sk_err before skb_recv_datagr=
am()
>         */
>        int error =3D sock_error(sk);
>=20
>        if (error)
>                goto no_packet;
>        ^^^^^^^^^^ <----- EXCUSE ME?
>=20
> The kernel even fights back on the *send* path?!?
>=20
> static long sock_wait_for_wmem(struct sock *sk, long timeo)
> {
>        DEFINE_WAIT(wait);
>=20
>        sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>        for (;;) {
>                if (!timeo)
>                        break;
>                if (signal_pending(current))
>                        break;
>                set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                ...
>                if (READ_ONCE(sk->sk_err))
>                        break;  <-- KERNEL HATES UNCONNECTED SOCKETS!
>=20
> This is IMO just broken.  I realize it's legacy behavior, but it's
> BROKEN legacy behavior.  sk_err does not (at least for an unconnected
> socket) indicate that anything is wrong with the socket.  It indicates
> that something is worthy of notice, and it wants to tell me.
>=20
> So:
>=20
> 1. sock_wait_for_wmem should IMO just not do that on an unconnected
> socket.  AFAICS it's simply a bug.
>=20
> 2. How, exactly, am I supposed to call recvmsg() and, unambiguously,
> find out whether recvmsg() actually failed?  There are actual errors
> (something that indicates that the kernel malfunctioned or the socket
> is broken), errors indicating that the packet being received is busted
> (skb_copy_datagram_msg, for example), and also errors indicating that
> there's an error queued up.
>=20
> I would like to know that there's an error queued up.  That's what
> poll and epoll are for, right?  Or a hint from recvmsg() that I should
> call MSG_RECVERR too.  Or it could have a mode where it returns a
> normal datagram *or* an error as appropriate.  But the current state
> of affairs is just brittle and racy.
>=20
> Are there any reasonably implementable, non-breaking ways to improve
> the API so that programs that understand socket errors can actually
> function fully correctly without gnarly retry loops in userspace and
> silly heuristics about what errors are actually errors?

Contemplating this, recvmsg() can sent status information back via msg_flags=
.  Maybe we could characterize a recvmsg() call as doing one of the followin=
g things:

1. Actually fails, via -EFAULT or otherwise.  Userspace can get an errno but=
 doesn=E2=80=99t know beyond that what actually went wrong. Should never hap=
pen in a correct program. ENOMEM is not in this category.

2. There is nothing to receive. This is -EAGAIN.

3. Received an sk_err error. This is a *success*, and it comes with an error=
 code. Users of RECVERR can=E2=80=99t reliably correlate this with an ERRQUE=
UE message.  Maybe they don=E2=80=99t care.

4. Received a datagram.

5. Received a queued error message a la ERRQUEUE.

6. Dequeued a datagram (or ERRQUEUE) but did *not* receive it due to a check=
sum error or other error. (And there should be a clear indication of whether=
 the call succeeded but something was wrong with the message or whether the c=
all *failed* for an unexpected reason but the offending message was nonethel=
ess removed from the socket=E2=80=99s queue).

Maybe 7: Received a message (or ERRQUEUE), and the checksum was wrong, but t=
he data is being returned anyway.

I suppose that a flag could enable this mode and then all but #1 would retur=
n a *success* code from the syscall.  And msg_flags would contain an indicat=
ion as to what actually happened.

Thoughts?  Does io_uring affect any of this?

>=20
> Grumpily,
> Andy

