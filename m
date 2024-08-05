Return-Path: <netdev+bounces-115737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C6947A4A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB91C211DF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB8154BE4;
	Mon,  5 Aug 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTKkUQMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD613AD11;
	Mon,  5 Aug 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856413; cv=none; b=i5CsXstKPIUch11AGb1tV9Kokmave5qKjD8y8Rge/p7du+TJ5fmNeiUxrkeU7WlJCtBzZaLE/Qcc9dgT2sPV5/xrz9muwQya0qGwYk6kGMqRYfNKIN3XQz6iVZK0uHwpa/FrkebEW33fua7p1CaBO9W/5skXj+TmOrw1e97Rm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856413; c=relaxed/simple;
	bh=8fliRfgQbQVkorVDTI/WBCSYgg0MzAI7itjWyp7vipo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/mJsV+dzJ+rysI8JLeJ0fdcjTHWFUMkVV7PoQpDWQ3A2zgZbaM1LfLyT5Btt1WapAxRT7uky4cZN730fJeLKBQkp18mUFLPXq33QVp2XDSA10vhOSfICSRsk7qnBHCJic5vvxVPyGIHNgeeeDg4jBB8AkANloMV6iHQp3/a0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTKkUQMl; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f921c40f2so413861139f.0;
        Mon, 05 Aug 2024 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722856410; x=1723461210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwF2nPGSqkMWH4sP2fSO/BXhofTHKOcgepBTob7PYoI=;
        b=lTKkUQMl3go1MbUQhfyZhMlCCeSMwuk8lHGThNcHSsLFJnAfM82WebG7PjVCe2SK8W
         PE2dM9OIJIJZHv0JoGa3xT0q9xXD0L91Xbv0+/auln7AsxIaHRSFkpJrGQMMfq17hKFr
         xvd2PyC01oRBGYakC4//58YTSiRbbyoLvv1g/TZ+es5TrLuUdjoZSX7mSVBKFtgGp3Zv
         Z0gt2AQ1xj3nsH2Uz8bqTFSUfGDSX6eQIlt75vLta2eDbt0Cnx171lkVPJ8H6XukxyBt
         zVFHp1qvG05TQ6e9RaTfrhEs/Yh4pNuco0PU2vTMxKx2I54D/VwI6Vu6N92ggqLNdRL+
         759w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722856410; x=1723461210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwF2nPGSqkMWH4sP2fSO/BXhofTHKOcgepBTob7PYoI=;
        b=sgYuTz7Oe+P5keWkMD16sLxD20YeYa2xM7o6vfo48TjCubINnscaN6oOj+ftDzxRW8
         3L0jsJHyyoW3Rw10vwq3zCKL0GKZ/35VcCzjkAlJRR02Nu90sWiegdhPhw4YUPZG/9m3
         28nwFLEryqkPF7oFKhaLoMo/Rn7yqSzPWt062rl7JNbD1iGj2AsHKP4SD3IGZrrzHIcw
         4BNhjac4rhlIxLzMLk+AA+j0kT4jV39RUCfKi9gb+B+fUTaSt9HblXd4ZnHjMb7sfDJ8
         4BZ5uAGMUrjHMpbjclftMQblY/o9r+OcpgZ5KUsKYzIMCIq0ZjgxT76SfE5kGIL64tZ4
         rbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSYyKmo4M24T/UltkXSREddQqMZoztj6uVfOP3dpg8tB/f0a8EjfSnuJZ/bUX1ekMmyJFvwnAMtmqgaJw=@vger.kernel.org, AJvYcCXJbt8eNt+IzNiU3hsuU6p0pOqadSVv3TLrGmgCx0orZSgFmKMnQWfW0tHnVub358OUMsieTuLW@vger.kernel.org
X-Gm-Message-State: AOJu0YznxMQqfvhd6XHw7A0GsgpbTbKY0xHHc9iRWJTLqPQ7Di41sSXI
	WEBsbSOpJib7a5DAcli9bZMd7CXcRIQ/rI4/G5jTNaQtn0rOb5Ip1A0T8RzYg+lkzd5pzcmTCVr
	jVQU6bNeLfkxxuM4nDcOAIa9NlA8=
X-Google-Smtp-Source: AGHT+IG+w4IStoGD34MKT2cv0myC329bSLTE1UoS5+OPWKOpZ9LvlW16MOXmfuFKvjX7PWPBiK8d3l9VZbsKwwQon8E=
X-Received: by 2002:a05:6e02:ecd:b0:39b:38c5:fa4e with SMTP id
 e9e14a558f8ab-39b38c5fa9dmr55714815ab.19.1722856410292; Mon, 05 Aug 2024
 04:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805103355.219228-1-kuro@kuroa.me>
In-Reply-To: <20240805103355.219228-1-kuro@kuroa.me>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 5 Aug 2024 19:12:53 +0800
Message-ID: <CAL+tcoB7F3Aviygmxc_DhfLRQN8c=cdn-_1QrXhEWFpyeAQRDw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:34=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote:
>
> On Mon, Aug 5, 2024 at 4:04 PM Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >
> > On Mon, Aug 5, 2024 at 3:23=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Mon, Aug 5, 2024 at 6:52=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > On Sat, Aug 3, 2024 at 11:48=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > Hello Eric,
> > > > >
> > > > > On Thu, Aug 1, 2024 at 9:17=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa=
.me> wrote:
> > > > > > >
> > > > > > > We have some problem closing zero-window fin-wait-1 tcp socke=
ts in our
> > > > > > > environment. This patch come from the investigation.
> > > > > > >
> > > > > > > Previously tcp_abort only sends out reset and calls tcp_done =
when the
> > > > > > > socket is not SOCK_DEAD aka. orphan. For orphan socket, it wi=
ll only
> > > > > > > purging the write queue, but not close the socket and left it=
 to the
> > > > > > > timer.
> > > > > > >
> > > > > > > While purging the write queue, tp->packets_out and sk->sk_wri=
te_queue
> > > > > > > is cleared along the way. However tcp_retransmit_timer have e=
arly
> > > > > > > return based on !tp->packets_out and tcp_probe_timer have ear=
ly
> > > > > > > return based on !sk->sk_write_queue.
> > > > > > >
> > > > > > > This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being =
resched
> > > > > > > and socket not being killed by the timers. Converting a zero-=
windowed
> > > > > > > orphan to a forever orphan.
> > > > > > >
> > > > > > > This patch removes the SOCK_DEAD check in tcp_abort, making i=
t send
> > > > > > > reset to peer and close the socket accordingly. Preventing th=
e
> > > > > > > timer-less orphan from happening.
> > > > > > >
> > > > > > > Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting th=
e connection")
> > > > > > > Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging=
 write queue")
> > > > > > > Signed-off-by: Xueming Feng <kuro@kuroa.me>
> > > > > >
> > > > > > This seems legit, but are you sure these two blamed commits add=
ed this bug ?
>
> My bad, I wasn't sure about the intend of the original commit that did no=
t
> handle orphan sockets at the time of blaming, should have asked.
>
> > > > > >
> > > > > > Even before them, we should have called tcp_done() right away, =
instead
> > > > > > of waiting for a (possibly long) timer to complete the job.
> > > > > >
> > > > > > This might be important when killing millions of sockets on a b=
usy server.
> > > > > >
> > > > > > CC Lorenzo
> > > > > >
> > > > > > Lorenzo, do you recall why your patch was testing the SOCK_DEAD=
 flag ?
> > > > >
> > > > > I guess that one of possible reasons is to avoid double-free,
> > > > > something like this, happening in inet_csk_destroy_sock().
> > > > >
> > > > > Let me assume: if we call tcp_close() first under the memory pres=
sure
> > > > > which means tcp_check_oom() returns true and then it will call
> > > > > inet_csk_destroy_sock() in __tcp_close(), later tcp_abort() will =
call
> > > > > tcp_done() to free the sk again in the inet_csk_destroy_sock() wh=
en
> > > > > not testing the SOCK_DEAD flag in tcp_abort.
> > > > >
> > > >
> > > > How about this one which can prevent double calling
> > > > inet_csk_destroy_sock() when we call destroy and close nearly at th=
e
> > > > same time under that circumstance:
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index e03a342c9162..d5d3b21cc824 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -4646,7 +4646,7 @@ int tcp_abort(struct sock *sk, int err)
> > > >         local_bh_disable();
> > > >         bh_lock_sock(sk);
> > > >
> > > > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > > > +       if (sk->sk_state !=3D TCP_CLOSE) {
> > > >                 if (tcp_need_reset(sk->sk_state))
> > > >                         tcp_send_active_reset(sk, GFP_ATOMIC,
> > > >                                               SK_RST_REASON_NOT_SPE=
CIFIED);
> > > >
> > > > Each time we call inet_csk_destroy_sock(), we must make sure we've
> > > > already set the state to TCP_CLOSE. Based on this, I think we can u=
se
> > > > this as an indicator to avoid calling twice to destroy the socket.
> > >
> > > I do not think this will work.
> > >
> > > With this patch, a listener socket will not get an error notification=
.
> >
> > Oh, you're right.
> >
> > I think we can add this particular case in the if or if-else statement
> > to handle.
> >
> > Thanks,
> > Jason
>
> Summarizing above conversation, I've made a v2-ish patch, which should
> handles the double abort, and removes redundent tcp_write_queue_purge.
> Please take a look, in the meanwhile, I will see if I can make a test
> for tcp_abort. If this looks good, I will make a formal v2 patch.
>
> Any advice is welcomed. (Including on how to use this mail thread, I don'=
t
> have much experience with it.)
>
> Signed-off-by: Xueming Feng <kuro@kuroa.me>
> ---
>  net/ipv4/tcp.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..039a9c9301b7 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4614,6 +4614,10 @@ int tcp_abort(struct sock *sk, int err)
>  {
>         int state =3D inet_sk_state_load(sk);
>
> +       /* Avoid force-closing the same socket twice. */
> +       if (state =3D=3D TCP_CLOSE) {
> +               return 0;
> +       }

No need to add brackets here.

And I don't think it's a correct position to test and return because
we need to take care of the race condition when accessing lock_sock()
by tcp_abort() and __tcp_close(). What if tcp_abort() just passes the
check and then tcp_close() rapidly grabs the socket lock and sets the
state to TCP_CLOSE?

Thanks,
Jason

