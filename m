Return-Path: <netdev+bounces-112623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01293A385
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4A51F2353D
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D508152537;
	Tue, 23 Jul 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpMED+Cq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CE13B599
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747439; cv=none; b=YDyXhfX/JI0cxgd/lgbdIIKvgLVKszkRDp5nj6OT5HKWPFCbj7ASrAL1Vn5WDcgVU1sR+WxTuFvIMbnm9ok2adKRJ8QJ4hLiCHIVv0DHbDiiBHEbe24iQlCykBRjP/j8EmNJtROBktIZpiv3zqz9GZ/eQhKmznqSoUjuuhuCOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747439; c=relaxed/simple;
	bh=YYv9D8mV/YZ4iqEHZZZVVlDGQ7R+EGMEO33Gf+Ic9+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTUfq2zDphp+L8HJYgvnYfDTu83o5tswuz1ZBnEXhZVvxSSfjV6tlPLtcR/IveONtkVXt1CiOYoYi46+TLib9P/nZzmWw/0lkTI6M+sTMK6djwn+c5cMecphQVldvrwwdh2N8L3UzbIJXCygskwMt6Vu67WX+39rZfklNarsqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpMED+Cq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so2052424a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721747436; x=1722352236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F86w3bUQV2FwPLcWStzl28Vji1M4qkqIpw05iMZTR6o=;
        b=dpMED+CqK/UwYY244P8l4diNw6nC7gAWBrk9dqPN18xrNyIL3466YNj6MO4/2DcS51
         KQmv2y8W1D7cERRc+3LfY6NM8/1UoreCuVX8AAbcw/BVctX1H9wRMon3g405Hi1XQJ5j
         kFeyvCo96bazyZM4h3TMfxIfRBBMWYyJ/0MDMic187Hoxlesx0Nqi0EjN3wea0FMtbty
         QDM5b15wvWc59r02vCz6meOKLhYmScXACFldI2dXRBJoSevNZKQQNnlUZ4tK1X6mH0G2
         RamujS3IQXPqx+zZZ4kb5AC/JU2NhhbUNCuJGFUaRFHoRk+3Vlj0jcGY/E3+6opk0bCa
         3/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747436; x=1722352236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F86w3bUQV2FwPLcWStzl28Vji1M4qkqIpw05iMZTR6o=;
        b=TOSsdaYgjr3Gf9WKfs4o68EduDjnuvUbiWUkfjXgIxvlJEsd/0ceJJt+SsoCXNC5jy
         JxOpkRyfFrohOdjFqnJVeIgdWxCBJkyneG+GdmAR/VY6gI4nvkJN4H15yzpEeb7RvBIc
         pKYwchtTzhK7Bj+74ESGj2dsbU6F0lJUiM3EHRNX4EY9nvDRtu676496GAJLnjn9QKqq
         Te5sm3yLbE6MTkovVfbbYsi8NsvVrkKTVc6fwwobOHcBv+JyEaH0t5r8lccBNcVqm32b
         xYFq8CtQ56K7O7TeqY7qh6K1P10jZ2I7x5jQ4WxMb6Ld2oqFdhK4HcA+7WyR4j8KeMol
         u4xg==
X-Forwarded-Encrypted: i=1; AJvYcCUCNLm/Y+cBmiuk798iv9qvtmU2ihignA/swxlgUCBrOvqpYSnLLtZM9DeluD5LaD5ynEOGZ0nTmvDA/KaRgpgIvUtbMjpI
X-Gm-Message-State: AOJu0Yyo4o20i88H7wUQuJ13BdrpNlrxjVf0sdWNL1jCOjrdpEY3RJt4
	elNyb01YjuFlQE1A38vW0hvCIpR3MuMoBzoHj65D0WSX3V+kesNwK2M+Ke14KUaRfMq7m5KaptP
	ejbFrly7UtwngKTMa/lJ4fbhcvzSKzLgfypA=
X-Google-Smtp-Source: AGHT+IFqDRknFO2Vhm94bz4zXnbZrR4xLEoXfWzut4DxgMS6fPIFKp/NJ3/n3ZPFjOgqHkN9n3JCavEarALYVO/y4zc=
X-Received: by 2002:a50:c34e:0:b0:57d:6bb:d264 with SMTP id
 4fb4d7f45d1cf-5a99ca4d37dmr2717360a12.1.1721747435637; Tue, 23 Jul 2024
 08:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723135742.35102-1-kerneljasonxing@gmail.com> <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com>
In-Reply-To: <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Jul 2024 23:09:57 +0800
Message-ID: <CAL+tcoDZ2VDCd00ydv-RzMudq=d+jVukiDLgs7RpsJwvGqBp1Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I was doing performance test on unix_poll(), I found out that
> > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_loop()
> > occupies too much time, which causes around 16% degradation. So I
> > decided to turn off this config, which cannot be done apparently
> > before this patch.
>
> Too many CONFIG_ options, distros will enable it anyway.
>
> In my builds, offset of sk_ll_usec is 0xe8.
>
> Are you using some debug options or an old tree ?
>
> I can not understand how a 16% degradation can occur, reading a field
> in a cache line which contains read mostly fields for af_unix socket.
>
> I think you need to provide more details / analysis, and perhaps come
> to a different conclusion.

Thanks for your comments.

I'm also confused about the result. The design of the cache line is
correct from my perspective because they are all read mostly fields as
you said.

I was doing some tests by using libmicro[1] and found this line '41.30
=E2=94=82      test  %r14d,%r14d' by using perf. So I realised that there i=
s
something strange here. Then I disable that config, the result turns
out to be better than before. One of my colleagues can prove it.

In this patch, I described a story about why I would like to let
people disable/enable it, but investigating this part may be another
different thing, I think. I will keep trying.

[1]: https://github.com/redhat-performance/libMicro.git
running 'https://github.com/redhat-performance/libMicro.git' to see the res=
ults

>
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > More data not much related if you're interested:
> >   5.82 =E2=94=82      mov   0x18(%r13),%rdx
> >   0.03 =E2=94=82      mov   %rsi,%r12
> >   1.76 =E2=94=82      mov   %rdi,%rbx
> >        =E2=94=82    sk_can_busy_loop():
> >   0.50 =E2=94=82      mov   0x104(%rdx),%r14d
> >  41.30 =E2=94=82      test  %r14d,%r14d
> > Note: I run 'perf record -e  L1-dcache-load-misses' to diagnose
> > ---
> >  net/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/Kconfig b/net/Kconfig
> > index d27d0deac0bf..1f1b793984fe 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -335,8 +335,10 @@ config CGROUP_NET_CLASSID
> >           being used in cls_cgroup and for netfilter matching.
> >
> >  config NET_RX_BUSY_POLL
> > -       bool
> > +       bool "Low latency busy poll timeout"
> >         default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> > +       help
> > +         Approximate time in us to spin waiting for packets on the dev=
ice queue.
>
> Wrong comment. It is a y/n choice, no 'usec' at this stage.

Oh, I see.

Thanks,
Jason

>
> >
> >  config BQL
> >         bool
> > --
> > 2.37.3
> >

