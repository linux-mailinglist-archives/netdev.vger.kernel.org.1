Return-Path: <netdev+bounces-85851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71E89C953
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FCF1F209B6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E21411C9;
	Mon,  8 Apr 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlJluVf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8D1422A5
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592326; cv=none; b=AN77DLvl6c4zueXMrGANGrQGw4MTPSpObCpFSNjMJO9wqEVxe3f6Bl4UqidB0rORV+7TJbu47j3GeZax9OPItYAybkM6k1Od+0JLVkae0Dx25VQdxeYoxJJHXr95k8qzZxY/jkHBE3tHlUJT7KAlqjo1pJmLaNvVONGTpPMcyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592326; c=relaxed/simple;
	bh=57Ihzb/f+H3jZ2xrBIhDJClQrFPvmpYpyfJp07nzvnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7TvFhSNb42xuo+oggrFFvle8W+LKlC3A5fBZuUXF3Iuu1xTE+jjX3DNPUQ+nmdx6t+0u42ICKn3yHWzS8PB5P3B2p/HD4URqYVJw7AFgGjh7hzG/3b2/1lk9lF/9BVUyumzlq5jsXmJ4UPU5ju+lZpwgleToH3MX/+68npIuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlJluVf8; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a267bb43aso104475ab.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712592324; x=1713197124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19X5jGFsCw98B4AsyMKMV9bptCVFkM/m5oPkYkbJ4D4=;
        b=rlJluVf8bufNoTyvIHoKRdRuymjZwtJN7ijFfByX0/rtQfeFQpjQroaiPWU74hTAnc
         KUwGPgNWpMPVGBcOxxuao6wqdP2l39dQkTOGgp5YbKF3/FG+cgmB/EzVQidiYqUCxgD+
         ajFZs/pzbI7f2eeq1nmzPjPfg6vSE53B6c1MRqM3zaFpILMXgT7vnoEZnA0wUQLQkHtX
         BNhWjkfkyg8XzCRCU56Xcm1EznFRv7iAxczoNoV0RtfEtWB0TliO1Ok+ZT+VBNLfilAJ
         TmnoTkBo2S90FB0seK1JMbO3yGzyhmBZB1sHs1JoYWYKFmBwpGPqBSLMGPhVSBwvc/V1
         AxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592324; x=1713197124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19X5jGFsCw98B4AsyMKMV9bptCVFkM/m5oPkYkbJ4D4=;
        b=OSnYH4cBzYh+jlfZkAgwVjzwkJQp05PaXKoMP8VOmWPtoLUjNdNDUFoUh2+zFk9jOb
         iZdBIHkiPYCK797LziFasVoknTX5+2sR74YxhMQpz0gnYC9FEQgNooeZq3e5z0mAyWcl
         1LKdf8uN92k+AF4fkj6liaEWbVX6MdwqQpZ5krGhpUr2EoyzdHIe97T5H21eTz1OYRfC
         yYaxPVGGVsN49x8BLigJF2O+nlyoMrcGCUOmhzmU0yr2FaVC4g3OyKX0S9Qf64P/h0Gm
         WxPhZzwIwk+ilrHEq8eExTnbGysEOUzTZUpI0q3ut6OVBIJAV0J3+TffGoT6+9w+KwjQ
         7PXA==
X-Gm-Message-State: AOJu0YyQEG4i83hhz9OywnAJj7i126MTFoz6OM6ZiDDAoOHEyPqOd+AX
	GhFknompKjHI+ZMY2n783O167kMgH3vei6qhCcrxWqy+nsNreYHTGeUgI6iUmSBdZi4OyrvSnpm
	wfXk+/WzLxS5UcckpqSjV6oE+OlGAAKpChyc/
X-Google-Smtp-Source: AGHT+IHy2aYJULXm3OLLOCLsr0Kqpzh5VRnlZOJjGXPJu0dVRpBRyZvc9+JhriPmBBhop4DqeN+5NrtAO6x7PDW8+go=
X-Received: by 2002:a05:6e02:1050:b0:36a:ef4:1a31 with SMTP id
 p16-20020a056e02105000b0036a0ef41a31mr378927ilj.3.1712592323721; Mon, 08 Apr
 2024 09:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e2077519aafb2a47b6a6f25532bfd43c8b931aa.1712581881.git.asml.silence@gmail.com>
 <CANn89iJoZ6P=BPWNwuxGeJ+eTpAc27y=KgEoO==6LKOw7QB9YQ@mail.gmail.com> <01d4264c-e54a-4b21-9dbf-6e31ff6c782f@gmail.com>
In-Reply-To: <01d4264c-e54a-4b21-9dbf-6e31ff6c782f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 18:05:07 +0200
Message-ID: <CANn89iLcSxm0j3J6n1DAJZ9Atv3CUEuw3Yf5qh2CW+tfN70x6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: enable SOCK_NOSPACE for UDP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 5:06=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 4/8/24 15:31, Eric Dumazet wrote:
> > On Mon, Apr 8, 2024 at 4:16=E2=80=AFPM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> >>
> >> wake_up_poll() and variants can be expensive even if they don't actual=
ly
> >> wake anything up as it involves disabling irqs, taking a spinlock and
> >> walking through the poll list, which is fraught with cache bounces.
> >> That might happen when someone waits for POLLOUT or even POLLIN as the
> >> waitqueue is shared, even though we should be able to skip these
> >> false positive calls when the tx queue is not full.
> >>
> >> Add support for SOCK_NOSPACE for UDP sockets. The udp_poll() change is
> >> straightforward and repeats after tcp_poll() and others. In sock_wfree=
()
> >> it's done as an optional feature because it requires support from the
> >> poll handlers, however there are users of sock_wfree() that might be
> >> unprepared to that.
> >>
> >> Note, it optimises the sock_wfree() path but not sock_def_write_space(=
).
> >> That's fine because it leads to more false positive wake ups, which is
> >> tolerable and not performance critical.
> >>
> >> It wins +5% to throughput testing with a CPU bound tx only io_uring
> >> based benchmark and showed 0.5-3% in more realistic workloads.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>
> >> v3: fix a race in udp_poll() (Eric)
> >>      clear SOCK_NOSPACE in sock_wfree()
> >>
> >> v2: implement it in sock_wfree instead of adding a UDP specific
> >>      free callback.
> >>
> >>   include/net/sock.h |  1 +
> >>   net/core/sock.c    |  9 +++++++++
> >>   net/ipv4/udp.c     | 15 ++++++++++++++-
> >>   3 files changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index 2253eefe2848..027a398471c4 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -944,6 +944,7 @@ enum sock_flags {
> >>          SOCK_XDP, /* XDP is attached */
> >>          SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
> >>          SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet =
*/
> >> +       SOCK_NOSPACE_SUPPORTED, /* socket supports the SOCK_NOSPACE fl=
ag */
> >>   };
> >>
> >>   #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_T=
IMESTAMPING_RX_SOFTWARE))
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 5ed411231fc7..ae7446570726 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -3393,6 +3393,15 @@ static void sock_def_write_space_wfree(struct s=
ock *sk)
> >>
> >>                  /* rely on refcount_sub from sock_wfree() */
> >>                  smp_mb__after_atomic();
> >> +
> >> +               if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED)) {
> >> +                       struct socket *sock =3D sk->sk_socket;
> >
> > It seems sk->sk_socket could be NULL, according to similar helpers
> > like sk_stream_write_space()
> >
> > udp_lib_close() -> sk_common_release() -> sock_orphan() ...
>
> Yeah, thanks. So sk_socket stays alive even after it's removed,
> makes sense, but I wonder why there is no READ_ONCE in likes of
> sk_stream_write_space() as seems sk_socket can just randomly
> change?

sk_stream_write_space() is called with socket lock held (so far)

But for lockless UDP tx path, things are a bit different.

