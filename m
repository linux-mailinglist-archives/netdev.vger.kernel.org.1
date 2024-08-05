Return-Path: <netdev+bounces-115626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAFF94746F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEA81C20B3A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3E13C673;
	Mon,  5 Aug 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eicmJWMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1179A94B;
	Mon,  5 Aug 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722833567; cv=none; b=hPH9EgErUY8Nc+fa8F4QVo+FNP4cU//NHM2lIV68PKxyTjlAtuv76dlRIslxcqk5lfYVKUcvwqMVqo8WHv18pP2B6HhzCYnn/uuqDf/F3QcFx20pYvKj42g7VKN/5qg1mTYTASwLtipOT4aUHtvwq8vudAbKV0+cj9mvHB6zqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722833567; c=relaxed/simple;
	bh=Z5a/fZtFFsR6Uvc84Jg99PNoLspLb9h0ZRzRPIUp/pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUHMVezI/u3qneERbyyhrVTdZKhyTsALfScy7+zCp2UD0nSwiIM3hmeTbPF/FL+sRp56zY7LnWAPFgUIJ80vouaCxUnBlUHB4QBKhGNERYsggvxPEKRBW5As64zxO/bdDXrnIFm7gsvN1OzWVypz2rcUdw8lwmiUurhNoRrSDY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eicmJWMZ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-397cdb4bf11so18526085ab.2;
        Sun, 04 Aug 2024 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722833565; x=1723438365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JI7bEukyDyDZBexgowMK4aNRizxBt+hUyHYCS1SmbM=;
        b=eicmJWMZgpv0qWcw81MyNKp2hJLOjmjxsvQwgTEKKLcvWGArh49KwXFnQGoO/wZ64q
         MEC/ZYp0BorKnFVnrjv+HVYKslTguEh1wpEzRinc53r5DuPHY+m/Bi5lzVoxEbOlP/3m
         vNewNibz2Qtvd9MRVm1a9VtUIhmwtKz0Prj5mLWtiP6LJ2KbYX1g0aSEV261cxdPk2mR
         XRpYGMuFLqsDqmOz3YagQQJ8CmroEHEjisp/zZTL+YiKiwzffbxZ28aa5XeSa21OPOaj
         P/ehRcBeipGSIJvQsOqh6T0QkqblQ18+jrgsEItpZBGQ1EfROFAF3SkThJyo14dZSFiY
         Qdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722833565; x=1723438365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JI7bEukyDyDZBexgowMK4aNRizxBt+hUyHYCS1SmbM=;
        b=L9NIYzAjACAdP+aBsw+jPxcNGfAlTf4ID5J9tEM7QwWQkE52fyO0umCHC/zOSQUOcm
         GQpT/b5RwUL9V1jLwVo4lZ/AdWJJes+WMGwz+ccf4Eq0sBbSwEFgZK9LQDozDMqkO1l6
         7Xabx5tljGaFEuhKtE0YDIySZLJKna30lvDFqnqC1ncu/65gaWYjPBlUXCI3vfnpi+IM
         3Z7NpwoJnghMmamlKdTA73CeddK9PExVqhSCjqqn30fqtL6S7+KvuvTLQLjvDowxNMnR
         UGHPrwUoFfm9+VXYk7jhVeaCNertqORanQEPITov6PTFSIsaBVJbOv12/Yd+iSLwqJpE
         OO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/ISqs1dARVMmD9/8KbNGDpz/0ce2ldsHVB8mjuDLTQEjw+UuUAfUa6TlV66k6tdk6oSH0qtGCoIDtaId4l9SAV/2rYI6qyeQ2Edq8L9qOy0+ZPwXWkqEe/3LYfARJM3uvsveh
X-Gm-Message-State: AOJu0YyVwHy9oxhbG/sz0opKNVCduiMCa7dVdBUvcgZR6g8wSRIpG9DV
	8weBvny28kT4frbw8dYNJSgxFp9LXtmjWHS+tYaYGq02ZDhAeGnwkldvx5zBQ+A8SYyMIRcDrcn
	sAG03dmYItBMP9ONgAJr41A24UiY=
X-Google-Smtp-Source: AGHT+IEo0StGWj1BQeapSmMMO8PykA0mmU492wzbwVSoOzAaC3heoKdK8MmKYsvoEhsf9gav1LrZEE1arW8qKL5UDfg=
X-Received: by 2002:a05:6e02:c6a:b0:39b:20d8:601e with SMTP id
 e9e14a558f8ab-39b20d86036mr102775955ab.3.1722833564730; Sun, 04 Aug 2024
 21:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
In-Reply-To: <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 5 Aug 2024 12:52:08 +0800
Message-ID: <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Xueming Feng <kuro@kuroa.me>, Lorenzo Colitti <lorenzo@google.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 11:48=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Thu, Aug 1, 2024 at 9:17=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wro=
te:
> > >
> > > We have some problem closing zero-window fin-wait-1 tcp sockets in ou=
r
> > > environment. This patch come from the investigation.
> > >
> > > Previously tcp_abort only sends out reset and calls tcp_done when the
> > > socket is not SOCK_DEAD aka. orphan. For orphan socket, it will only
> > > purging the write queue, but not close the socket and left it to the
> > > timer.
> > >
> > > While purging the write queue, tp->packets_out and sk->sk_write_queue
> > > is cleared along the way. However tcp_retransmit_timer have early
> > > return based on !tp->packets_out and tcp_probe_timer have early
> > > return based on !sk->sk_write_queue.
> > >
> > > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> > > and socket not being killed by the timers. Converting a zero-windowed
> > > orphan to a forever orphan.
> > >
> > > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > > reset to peer and close the socket accordingly. Preventing the
> > > timer-less orphan from happening.
> > >
> > > Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the connec=
tion")
> > > Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write q=
ueue")
> > > Signed-off-by: Xueming Feng <kuro@kuroa.me>
> >
> > This seems legit, but are you sure these two blamed commits added this =
bug ?
> >
> > Even before them, we should have called tcp_done() right away, instead
> > of waiting for a (possibly long) timer to complete the job.
> >
> > This might be important when killing millions of sockets on a busy serv=
er.
> >
> > CC Lorenzo
> >
> > Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?
>
> I guess that one of possible reasons is to avoid double-free,
> something like this, happening in inet_csk_destroy_sock().
>
> Let me assume: if we call tcp_close() first under the memory pressure
> which means tcp_check_oom() returns true and then it will call
> inet_csk_destroy_sock() in __tcp_close(), later tcp_abort() will call
> tcp_done() to free the sk again in the inet_csk_destroy_sock() when
> not testing the SOCK_DEAD flag in tcp_abort.
>

How about this one which can prevent double calling
inet_csk_destroy_sock() when we call destroy and close nearly at the
same time under that circumstance:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..d5d3b21cc824 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4646,7 +4646,7 @@ int tcp_abort(struct sock *sk, int err)
        local_bh_disable();
        bh_lock_sock(sk);

-       if (!sock_flag(sk, SOCK_DEAD)) {
+       if (sk->sk_state !=3D TCP_CLOSE) {
                if (tcp_need_reset(sk->sk_state))
                        tcp_send_active_reset(sk, GFP_ATOMIC,
                                              SK_RST_REASON_NOT_SPECIFIED);

Each time we call inet_csk_destroy_sock(), we must make sure we've
already set the state to TCP_CLOSE. Based on this, I think we can use
this as an indicator to avoid calling twice to destroy the socket.

Thanks,
Jason

