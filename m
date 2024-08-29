Return-Path: <netdev+bounces-123437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E607964DAF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085531F215D2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8241AE87D;
	Thu, 29 Aug 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3N40Hhg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B314A09E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956305; cv=none; b=VN0YeOwonnbrFYqmZeDWZk9VcSd81w8BtdHx+d5lEHyoOz97z5lxnH9UamXqLJKDOLZ9Z5AlGxa11L2PBknXM21MvRye8HgV6CxHywOMbYCc0whkv06YcZkaADvP88aInUaTEO+DM/8FxPQJso7DVSnVTW3XO5XVO5GBmX4bKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956305; c=relaxed/simple;
	bh=12qfTzcfqdcc1IaoiA3wISVqZCO2k0UEYvyIr/ZKM+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tt0YZoeRyzzBi7A0oh07x8Nl5b/W0TJ+NvOAK+TRWY/kogytDrHhECFMOcPs9MXWKHWdTHmtefsfZG4jF5xGQJKHaAasPpmaCQGLSdiv0mFEuqmJscx69GPHhdlOW8Q2m20+m8YmoYhAFeOjZuVCnEARGJC/gQmamVqRVjm6Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3N40Hhg; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82a151ac96eso37637639f.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724956303; x=1725561103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEgX2ZuLl3o5v+LfwjpVhTcH6B4pOznBQoVYjL1epxQ=;
        b=f3N40Hhgy/Qtev74ntMpFz+o27AgQ6P6o5YFSwBTo/SXd3vFKu5QWcGPtCr0YW+zWd
         ejt9EAS4eMRyVm6B37Rndb7PfG2kOYManESAiS10m2jRLYCR3M9zV5tW9hN8uvNnUC05
         +H7fSFpi8KqBp1T5JG5uoqKMXq0VoBpropi44g6XBNyYBNaBRbRjxhuwe451oKpM9u+1
         DVn4jJVNGegteqscTd190MmxkJO2E1pg0W55Q0WLQI2vfUVGsmVxnVnwjxKuYBY2utLx
         Ul19DpLmHsgoEPBZ2q2T132wLhKLwvAKLlobr/cqc73O/xgMEP7NFfoja3BZAAp1sC1K
         QnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956303; x=1725561103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEgX2ZuLl3o5v+LfwjpVhTcH6B4pOznBQoVYjL1epxQ=;
        b=PoDuL8VsWGIp/11jK7FiL1ZnBk5suahaAxopl5d9CLDriyBMwopDrRZsRADqtKadtB
         KLP0WwtEm08EYFQc5v6x8fN//5VOIi1i+cmDLdX+rDdyqvQ+HrlYiZXtXO5aVUPu0Hln
         BsRG18vcCPoKk2L0Wtmrw4JDr2rnz8UkQLqtodBva89XazVgulDmaWCsrNk44Y6i2wIY
         fKEii1xmt6ALd60LKOQ51TewsOOiHrswzUdGbZxFprK6i2eueJSAtCLa9/eyFEDVS2M+
         b9etkExOeA7Hs+5yQ6BBUby3CarLf/HNs9/BZbHvprDMR8Cw+/7kiRRGBniKlfHrK8cY
         ZXUw==
X-Forwarded-Encrypted: i=1; AJvYcCVLnH8pAshnptUTGB0cBgybTA45ZOvKDZdzYiCZAhKJIFseK/TBoa6u5heDeehg0uzXmTxrXGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8kUAEtxp6v3wVLIZVWYc7SV4cFTfxA9H/A3JBh8LRHFGcMV+
	vOyOiA6wn1p15b9vbFQFwifut8+Yu3bzRc7AGXIu5Jfk6/4SlMpPc1Ks25utP+ogvKjiqcxA/io
	dryd0rpac+V0WVmo0JQP8cp8AseA=
X-Google-Smtp-Source: AGHT+IGHt78DSsp1KakCIazzdueaT6R1LO65ggF0RXn8oiArSTwrFoL7ikUgtgpHgyj3Nj31QK2zQRWIeE/rxQ1q/Jo=
X-Received: by 2002:a92:c566:0:b0:39b:3651:f148 with SMTP id
 e9e14a558f8ab-39f37984004mr46031475ab.21.1724956303035; Thu, 29 Aug 2024
 11:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch> <CAL+tcoD6s0rrCAvMeMDE3-QVemPy21Onh4mHC+9PE-DDLkdj-Q@mail.gmail.com>
 <66d0a0816d6ce_39197c29476@willemb.c.googlers.com.notmuch>
 <CAL+tcoCUhYH=udvB3rdVZm0gVypmAa5devPXryPwY+39mHscDA@mail.gmail.com> <66d0bab153f94_39548f29451@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d0bab153f94_39548f29451@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Aug 2024 02:31:06 +0800
Message-ID: <CAL+tcoCfmOyAXxFTFgFtgmY4AbYUHSh0vB-VvMcn+svpLskm7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] timestamp: control SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 2:15=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Fri, Aug 30, 2024 at 12:23=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Thu, Aug 29, 2024 at 10:14=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Prior to this series, when one socket is set SOF_TIMESTAMPING_R=
X_SOFTWARE
> > > > > > which measn the whole system turns on this button, other socket=
s that only
> > > > > > have SOF_TIMESTAMPING_SOFTWARE will be affected and then print =
the rx
> > > > > > timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE=
 flag.
> > > > > > In such a case, the rxtimestamp.c selftest surely fails, please=
 see
> > > > > > testcase 6.
> > > > > >
> > > > > > In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag=
, we
> > > > > > can't get the rx timestamp because there is no path leading to =
turn on
> > > > > > netstamp_needed_key button in net_enable_timestamp(). That is t=
o say, if
> > > > > > the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect w=
e are
> > > > > > able to fetch the timestamp from the skb.
> > > > >
> > > > > I already happened to stumble upon a counterexample.
> > > > >
> > > > > The below code requests software timestamps, but does not set the
> > > > > generate flag. I suspect because they assume a PTP daemon (sfptpd=
)
> > > > > running that has already enabled that.
> > > >
> > > > To be honest, I took a quick search through the whole onload progra=
m
> > > > and then suspected the use of timestamp looks really weird.
> > > >
> > > > 1. I searched the SOF_TIMESTAMPING_RX_SOFTWARE flag and found there=
 is
> > > > no other related place that actually uses it.
> > > > 2. please also see the tx_timestamping.c file[1]. The author simila=
rly
> > > > only turns on SOF_TIMESTAMPING_SOFTWARE report flag without turning=
 on
> > > > any useful generation flag we are familiar with, like
> > > > SOF_TIMESTAMPING_TX_SOFTWARE, SOF_TIMESTAMPING_TX_SCHED,
> > > > SOF_TIMESTAMPING_TX_ACK.
> > > >
> > > > [1]: https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onl=
oad/hwtimestamping/tx_timestamping.c#L247
> > > >
> > > > >
> > > > > https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload=
/hwtimestamping/rx_timestamping.c
> > > > >
> > > > > I suspect that there will be more of such examples in practice. I=
n
> > > > > which case we should scuttle this. Please do a search online for
> > > > > SOF_TIMESTAMPING_SOFTWARE to scan for this pattern.
> > > >
> > > > I feel that only the buggy program or some program particularly tak=
es
> > > > advantage of the global netstamp_needed_key...
> > >
> > > My point is that I just happen to stumble on one open source example
> > > of this behavior.
> > >
> > > That is a strong indication that other applications may make the same
> > > implicit assumption. Both open source, and the probably many more non
> > > public users.
> > >
> > > Rule #1 is to not break users.
> >
> > Yes, I know it.
> >
> > >
> > > Given that we even have proof that we would break users, we cannot
> > > make this change, sorry.
> >
> > Okay. Your concern indeed makes sense. Sigh, I just finished the v3
> > patch series :S
> >
> > >
> > > A safer alternative is to define a new timestamp option flag that
> > > opt-in enables this filter-if-SOF_TIMESTAMPING_RX_SOFTWARE is not
> > > set behavior.
> >
> > At the first glance, It sounds like it's a little bit similar to
> > SOF_TIMESTAMPING_OPT_ID_TCP that is used to replace
> > SOF_TIMESTAMPING_OPT_ID in the bytestream case for robustness
> > consideration.
> >
> > Are you suggesting that if we can use the new report flag combined
> > with SOF_TIMESTAMPING_SOFTWARE, the application will not get a rx
> > timestamp report, right? The new flag goes the opposite way compared
> > with SOF_TIMESTAMPING_RX_SOFTWARE, indicating we don't expect a rx sw
> > report.
> >
> > If that is so, what would you recommend to name the new flag which is
> > a report flag (not a generation flag)? How about calling
> > "SOF_TIMESTAMPING_RX_SOFTWARE_CTRL". I tried, but my English
> > vocabulary doesn't help, sorry :(
>
> Something like this?
>
> @@ -947,6 +947,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct=
 sock *sk,
>         memset(&tss, 0, sizeof(tss));
>         tsflags =3D READ_ONCE(sk->sk_tsflags);
>         if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +           (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +            !tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
>

Yes, at least right now I think so. It can work, I can picture it in my min=
d.

In this way, we will face three possible situations:
1. setting SOF_TIMESTAMPING_SOFTWARE only, it behaves like before.
2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
will surely allow users to get the rx timestamp.
3. setting SOF_TIMESTAMPING_SOFTWARE|new_flag while the skb is
timestamped, it will stop reporting the _rx_ timestamp.

Having the new flag can provide a chance for users to stop reporting
the rx timestamp.

Well, It's too late for me (2:00 AM), sorry :( I need to do more tests
and then get back to you tomorrow.

Thanks for your good suggestion, Willem :) It's really a safer and
better suggestion. I have to sleep...

Jason

