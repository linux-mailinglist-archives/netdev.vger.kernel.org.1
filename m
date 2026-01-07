Return-Path: <netdev+bounces-247645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66843CFCB58
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63DAD301594F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EE02DF151;
	Wed,  7 Jan 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnJKy1QJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAE285C8D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776496; cv=none; b=H972y79aRibLp9DHkyCp/hzeBZlHJ+HVDd4+/EPdjG8DkVLmy6/4+rU2eNwKPgDC8Lm6DUJX9MYaGiPXtKSwaxQvMo+ScAobjs85jSwYg17AUADvH+6vw4m2mXb5KGjFVzf2GxN/7+Z7QGZXTEUQkzADbNxWvBz9ialr3X139Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776496; c=relaxed/simple;
	bh=lajboQwmY46irx1tD0V6P2fuEJu9U2GvIdFGxGbxITk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIBBEZcgl/qigt1tQvkq/sKoTILt5d2DfCQG46NbizcMe/PBoF7CMeoiKG8opHslUuZbf9oslJsEJmQgt6tizjH9P/qf5jhH7hOOJyicsTP4DQR0cEeRCU4yDFu4AGQgCK6eKFNgQ2dESgovzc49p6if4s/EV6oib8MPafsfLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnJKy1QJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4f34c5f2f98so18450961cf.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 01:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767776494; x=1768381294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B++K+gndml/j8tqUz7axZIesXE+WhWbKqRea1ooJ200=;
        b=XnJKy1QJAtkynA+OfMuLnKpEDiAMJ/jj5LWLVfmA3lXDQ/d2Tz5GUqwrQ1gTyWyD8Z
         ps2+2MIxVFX4lMIBmXKHJXt9lV9Vs7u4JFYlsxTVsa5dCkgu0sGTdOpSGMwXwgX7LPet
         ul/OKXkCDqXEm+ezuNSFNh693L4OUbzUAQ4hAXoqlhi/wT/IRlifgPl7RaeEYDvRN/h9
         FVTFPdyWh04EhY/Z8C4ZI3/XzutGJnzdssIhsldV1o9u5/3QJnBMPDCna9VI2ZX6h5mG
         Xtwqz2jWgD/tOBrW3E5saTnS4RxMS4HKbg2RT6KwM3MmxdNawC7mzndN/4SZiG+zXfhJ
         ce2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767776494; x=1768381294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B++K+gndml/j8tqUz7axZIesXE+WhWbKqRea1ooJ200=;
        b=R/q3Ag2w4a12PLZMIvAZxIEktrc7fLLwEiTrecjEos1H1+YKijVgx0xRS/kpvfneim
         nl/bVpplL5M8q+9G2OUbZMQzfi3ssYV4t993bbl2RrMScaJT0RR9qva+4VbAmRqvHh5p
         z7ZlSDIuTEwmdDxluWymDnbc3gzojmt4OEHQc4NogQxyA6TWp1JUJddJPvvTYADTQPDx
         ErxKBxevMP48LDMTtexPsEN9KjSUqt2L6bYzf6OvU5IaGkYFsf/13KCeE8/zS54nE6tp
         9GlJ8CDuA+hcfLG+/8HP1pjdyKZpRwx8COErjkbSzlYdt+Nglh9fimAi5b+K1YljT7kg
         KwyA==
X-Forwarded-Encrypted: i=1; AJvYcCWJTI15/khK6uDk3LZmaGiq1siJ6MWoYoKMx4oD0ZvgtvzaExyuv4fqNTDv/cbdPr/TeoHlefE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8n8rLRhpjaqCWWWdgFLFCFgmFq7v2dZbhyIqm1cY/0L6am007
	Imis0yZS+u9qCdyLuvz8H5S+y2Hu0Ai/I9mg/gOMlK+GEzFvvIWpCzVLw2pDDWYk/Gs8aU/z8VH
	urEcdsMjgJUdSfjeVt0aTBimzLSJB6UvuLub1xY86
X-Gm-Gg: AY/fxX7UPCsVQd9O3KY4JqfVBhkkR4y1R5/XxofK+ElkSjbTmK+5EqOlWiDM73N+lhY
	AAyleTgm87CTac3IXFVyREOZisPajfzmWRoLCXintWr4kmEGKG+Dmen/+1NJjzrGqJ0ZJDJf/BX
	UDUrtezNLcGPIdIGnJ7Anm8Zw8QCvMlfvV4Lp4SN9lWbs4T7J5cVW7fBRHwbqgRPgaY7hdqjal0
	7Cs7AoT7sxy8PGrWiyO085+qFbSttrTpZeWyco1brtfw9IG53rgpsA5VDqvwkvg3UawgA==
X-Google-Smtp-Source: AGHT+IGoZLlsfI4enbPoVn9JD85jrSE2kaeR1eH1/pQa+gzAKSeCeKLmqgbsRbNNNgnQRSxPJSQkB0TntGC1dKaUoLo=
X-Received: by 2002:ac8:7d0b:0:b0:4ec:f697:2c00 with SMTP id
 d75a77b69052e-4ffb49e6e22mr19306771cf.42.1767776493643; Wed, 07 Jan 2026
 01:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106144529.1424886-1-edumazet@google.com> <20260106095648.07a870f1@kernel.org>
 <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com> <aV4ddkDATvo9lBHi@strlen.de>
In-Reply-To: <aV4ddkDATvo9lBHi@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Jan 2026 10:01:22 +0100
X-Gm-Features: AQt7F2r3Z4CpXt6clVFyIAqdtzn-jz3RNhGkFbTcNCpTjMOWOT5VfewdKk6wI7U
Message-ID: <CANn89iKkThtD7VAN3OaOmC9=Ekiu2u-0TJ1BJaD+g7LCg9ARVQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:46=E2=80=AFAM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > On Tue, Jan 6, 2026 at 6:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Tue,  6 Jan 2026 14:45:29 +0000 Eric Dumazet wrote:
> > > > v2: invert the conditions (Jakub)
> > >
> > > Thanks! Much better now, but still failing
> > > tools/testing/selftests/net/gre_gso.sh
> > >
> > > TAP version 13
> > > 1..1
> > > # timeout set to 3600
> > > # selftests: net: gre_gso.sh
> > > # 2.16 [+2.16]     TEST: GREv6/v4 - copy file w/ TSO                 =
                  [ OK ]
> > > # 3.16 [+1.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 1=
5
> > > # 3.17 [+0.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 1=
5
> > > # 3.17 [+0.00]     TEST: GREv6/v4 - copy file w/ GSO                 =
                  [FAIL]
> > > # 3.18 [+0.01] 2026/01/06 10:32:57 socat[20533] W exiting on signal 1=
5
> > > # 3.19 [+0.00]     TEST: GREv6/v6 - copy file w/ TSO                 =
                  [ OK ]
> > > # 4.19 [+1.00] 2026/01/06 10:32:59 socat[20559] W exiting on signal 1=
5
> > > # 4.19 [+0.01]     TEST: GREv6/v6 - copy file w/ GSO                 =
                  [FAIL]
> > > # 4.20 [+0.01] 2026/01/06 10:32:59 socat[20549] W exiting on signal 1=
5
> > > # 4.22 [+0.02] 2026/01/06 10:32:59 socat[20560] W exiting on signal 1=
5
> > > # 4.23 [+0.01]
> > > # 4.23 [+0.00] Tests passed:   2
> > > # 4.23 [+0.00] Tests failed:   2
> > > not ok 1 selftests: net: gre_gso.sh # exit=3D1
> > >
> > > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/461862/65-=
gre-gso-sh/stdout
> >
> > For some reason I am unable to run this test from a virtme-ng instance.
> >
> > I guess I wlll not make a new version of this patch, maybe Florian can
> > take over.
>
> Its failing because nhoff is moved by 14 bytes, test passes after doing:
>
> -       if (skb_vlan_inet_prepare(skb, false))
> +       if (skb_vlan_inet_prepare(skb, true))

Thanks Florian.

I finally understood that my virtme-ng problem with this test is that
on my platform, /proc/sys/net/core/fb_tunnels_only_for_init_net was
set to 2

Tests have a hidden dependency against this sysctl.

