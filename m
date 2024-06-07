Return-Path: <netdev+bounces-101913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611939008A5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1381F20641
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1725740;
	Fri,  7 Jun 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7gs6VIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84431946DC
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773825; cv=none; b=QNJJJT3dJx50ZWRdSpmdMT5rJXIpi1S7kLGlcOcBdBmBiMNdR9wAMBOCwx+pi2nBhZ4UNO+QL4rzrtX1DlPfEvxxpbcSopKdflHea3KNiLCNRo98AoKCIs3CtxWh5/uKog9YyyY56oFdQUixNw3V/1aEdMXXH8acUNRGDTfhzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773825; c=relaxed/simple;
	bh=BsrFiDkj3XaVa2tPAvvOLXV6zuktfGMVwJiwauB3Wpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPPeMoiod25YvXdSA9dbbMDl6e74ojF8AY7fr4y1Mu7ghpG8SAf0wz2fnDzTvQVbHMTyz2PgUL3293n4LqEWfKIKBE5EQMXyr0hunxVMhV7H2Vye5fv308H2osTm4z+taVvRVJs/fwSr/EEeTmiwTvI0zyQozNwliTVgSsbcqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7gs6VIH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso22611a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717773822; x=1718378622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMHGFDEKi4kXrPWi8qHoBcicE4W/e7MJXxpzOsHuCnc=;
        b=O7gs6VIHzbGAQ2zBo/ZtLG2JBFsbTNpfLkuVibB66uDPj8+dR+D67U8qWR/xXz26mg
         LPDJ+ZJc+5DfKqSr2EvJJtztIz4tu4pOpIY0WkF0q/b2mDMmPxhL7/jJxJHP2QINkgFW
         6tMEcQctcMxj2OAlvyUyUI1DSpV9/IwOYQ5vKXqnFu9gnkLvsqwDsMAWUzGviLmqmxF7
         qmOKGgkvUGT1JXdPqVNOAw9QmGy0YUtffmMVQIAyQimjIhT4qUnOM33jIHyY0j10TKgL
         sRajvEi2VFdYypZdH+Hyb3mEOZp/zMNzViUiZI9vkGP492dAwCw3jXW2I77kPnioNu8O
         0FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773822; x=1718378622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMHGFDEKi4kXrPWi8qHoBcicE4W/e7MJXxpzOsHuCnc=;
        b=wgoPuDAg1NabzLGRLZY+1vPffORKTCIrWq9iLhh5Z09Fsvv2mGD7SR/ff/qBYwVL8+
         pDXz3Y6zQdmLhaW7EKQLni3t6qT5PL0/aKYgTjLPBnLMSGWb3lenlIWZqcBHSZH1892A
         kN9RHxLumFA0CTFLyim1hnnT8fIsLZtjl4NBLwkrLczNFoyYY44OitM/uazs+UjNKtcf
         PtzpmrHl2QvaMeS18jmv0jnARxovHkjgwnErMCQucDlhRRrI9eW6fLqybxkgl88eXxs/
         RbKXjJXqEMaC8mGEZ95W7VqvaHXvANe/Y0FrZ+77tmwlgxxeCzt8ZF2OgkWF3QVHrqMk
         RFCw==
X-Forwarded-Encrypted: i=1; AJvYcCWE+as+3GiO4LEEi+rBMDNzNU09vgCt8q8O14Cle2qc/2P/1xMbkklJd1MnHjk1Wz+uI0Rwn3v4wKTR1Z0tGwbLnSyetsBy
X-Gm-Message-State: AOJu0YxEFQzf3hc4APiPsxGqNu+4HGHQmqMLkHuaGZ9KIG7R2+eC7fI2
	8+NivXvhIOQ/1HhH7hvPWPmyvkz/aoOMybRCj0tiNbxIHEF0o1U8IvVzo2qQNYclKpMKNFZ26nC
	LzL0dathHeaho+s2LtR8xxtvLxO5mb5sd4RpxKbFSVVyqLVwNZT4W
X-Google-Smtp-Source: AGHT+IFv90ZYMWg9QerF6v+5ppJz2ZNnDBqVXiyjwZbKqsO/UO+WIO8O94lBWaxsitvf/yCHY7VUjjh1aXnRPIaK6Vo=
X-Received: by 2002:a50:fb96:0:b0:57a:2276:2a86 with SMTP id
 4fb4d7f45d1cf-57aa6e870a0mr565300a12.4.1717773821973; Fri, 07 Jun 2024
 08:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607125652.1472540-1-edumazet@google.com> <CADVnQy=3o8MF3eZ-drh1EPbNLfiW183AkUAZwbg4N3S=1DQN_A@mail.gmail.com>
In-Reply-To: <CADVnQy=3o8MF3eZ-drh1EPbNLfiW183AkUAZwbg4N3S=1DQN_A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 17:23:30 +0200
Message-ID: <CANn89i+ai=p7wRhFZLAoXgk5ckoqVV0eC691BY3Tb-is82n-Pw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 5:12=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Fri, Jun 7, 2024 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Due to timer wheel implementation, a timer will usually fire
> > after its schedule.
> >
> > For instance, for HZ=3D1000, a timeout between 512ms and 4s
> > has a granularity of 64ms.
> > For this range of values, the extra delay could be up to 63ms.
> >
> > For TCP, this means that tp->rcv_tstamp may be after
> > inet_csk(sk)->icsk_timeout whenever the timer interrupt
> > finally triggers, if one packet came during the extra delay.
> >
> > We need to make sure tcp_rtx_probe0_timed_out() handles this case.
> >
> > Fixes: e89688e3e978 ("net: tcp: fix unexcepted socket die when snd_wnd =
is 0")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Menglong Dong <imagedong@tencent.com>
> > ---
> >  net/ipv4/tcp_timer.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index 83fe7f62f7f10ab111512a3ef15a97a04c79cb4a..5bfd76a31af6da6473d306d=
95c296180141f54e0 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -485,8 +485,12 @@ static bool tcp_rtx_probe0_timed_out(const struct =
sock *sk,
> >  {
> >         const struct tcp_sock *tp =3D tcp_sk(sk);
> >         const int timeout =3D TCP_RTO_MAX * 2;
> > -       u32 rcv_delta;
> > +       s32 rcv_delta;
> >
> > +       /* Note: timer interrupt might have been delayed by at least on=
e jiffy,
> > +        * and tp->rcv_tstamp might very well have been written recentl=
y.
> > +        * rcv_delta can thus be negative.
> > +        */
> >         rcv_delta =3D inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
> >         if (rcv_delta <=3D timeout)
> >                 return false;
>
> Nice catch!
>
> Is this a sufficient fix? The icsk_timeout field is unsigned long and
> rcv_tstamp is u32. So on 64-bit architectures icsk_timeout is u64 and
> rcv_tstamp is u32. AFAICT it is not safe to subtract a u32 jiffies
> timestamp from a u64 jiffies timestamp and expect to get an answer we
> can use in this simple way (at least in general, after a few weeks of
> uptime when the u32 jiffies value has wrapped and the u64 value has
> not).
>
> I wonder if we also need something like this for a complete fix:
>
> - rcv_delta =3D inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
> + rcv_delta =3D (u32)inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;

We do this kind of (unsigned long) -> u32 conversions in many other places,
and they work if we store the result in a 32bit field (we do not care
of upper 32bits on 64bit kernels)

rcv_delta is s32, it does not matter if we cast (u32) to
inet_csk(sk)->icsk_timeout

Compiler  generates the same code (and result) :

mov    0x430(%rdi),%eax  // low 32bit of  inet_csk(sk)->icsk_timeout
sub    0x5b4(%rdi),%eax // tp->rcv_tstamp
cmp    $0x3a980,%eax
jle    aa8 <tcp_rtx_probe0_timed_out+0x38>

Thanks !

