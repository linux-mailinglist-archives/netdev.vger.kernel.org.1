Return-Path: <netdev+bounces-119629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B295663F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0D8B20CB4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0015AADA;
	Mon, 19 Aug 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr3jJI3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6915B12A
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058127; cv=none; b=UwrQ5zVjDFCygBglpsoLFfgNAzH+lFiwddAjRLmxl0mhlRXf8ZXgxrd0lXc4lcRnlVvkqy9WFM+beoYKk6/c2dn5bjh0lzu+9NSH4b643CeB8oFjbwHcdTIAF400Z3ZVYeD7QDutSIrr/wlJhuUWbIotn2jmnoNBSPsV9OT5I5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058127; c=relaxed/simple;
	bh=Q1Dl8ZP8vulfgOVf/BJvvfeVT6UsI2Qop1VXiD3EJV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSijhUdwxlLP/MOVjzhIUGIXySOYB71HZkpr9qg2dJhsplbGuyc6OAnAXoOuAp/WCBOVKqQdQfr7MzD8PkWZ8+h2+2vYEFF1i4LajJNRlP9Ji1L1Nxju0Cpa/yZ6su3ZX+dEZOApzb+fO0owNDaY9OoGVoTlkhu20wyuhR33xqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr3jJI3M; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d37218c5cso5868235ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724058125; x=1724662925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpW8c0BxQs8o0JwsWnOisErrJX5CRtUjzzhv+f90hbk=;
        b=nr3jJI3MEDnivkDbxhLDh1+wd4HWGEcNSzT+lNM5mrXU0Hgs7Lpd8+KRW7VK4zUIx6
         DONbyMPOHjqghoqovh/p6W1l/9PYJLALFiysVYD+WLNYL5+eSjsBLyF8Oc5lpS/QF6X1
         e9rep6631CR0AdCCxtvIE74n25p/IOchZIHlQIPDX1piYASTeIdMp/HuEFsCi3KeGEpb
         +R8j2VwYkh2zweR5QPQH9sEkB4KhkIPK9XFXsglShfzl3dYS3uAdXcRUQT74z6mjFEOz
         DzSIisBPOXGhEzHpvRBvfHOxqQI5OG5sJUw2cKMgh0E/3CAaYK3qLpYnfVve7Jly9Zeg
         scgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058125; x=1724662925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpW8c0BxQs8o0JwsWnOisErrJX5CRtUjzzhv+f90hbk=;
        b=nqBx+nimZYaa5gLZGr3RR4v+kClMmziKuqVoQLjTq8a9xtMvMGr9YSU1Ds7+btVYXc
         7NzQ1dj3n2X6a/sSx6p4rQ9yCDB9/eg4lPQcPKZku36y2VbjyFta0HzdCgJNT/nlXRIg
         BcMiLqAqn5HI78Ok6ptR31jI4YMwYmUK+jFQAubIGFdldG09x3fX9tjkorq2VtZ1OlYa
         cTWFkB/A8xLgxUsvQG5jc7qOvm203WEth0yJybIhCPTSRIrBZpQgNvPADfwWOrYAVPNz
         VvSfSaLQUpXl6XRTUWBzbdCMR4QRxB1hCkFRnfK3jL1y+3MFHddwIaHxwrT1vQCswUbj
         TQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN/g8XamR2PG8JOFIdHsx5eAAdRg3u6EE+JT01RmPUym5IGiyK7eikwYjOZcw5EGxTQv/nNjtRmKRDxAJ1w6Sdn6HXKP3G
X-Gm-Message-State: AOJu0Yytwgo81b1q15LMJmLybd562spjHdD4Jykp9yb6YyjGuaoI8jKF
	BFCO9DL6QTFvhqgzY2L+svsE6PwRY6jPLSFPHBljmjcaSe6B6AldzHr8oDC6jRof57P3i4KB0kI
	gzkLv793bcYz3D47kU4RkBSd7vJ0=
X-Google-Smtp-Source: AGHT+IFm8O/CJYtNppV68Dfr7juRSopaLBeudYW7O8E/yGms7Tjj0qp3SHlwMSRYtgWHWbTT4SYn4zWnjT1cXrL3iBM=
X-Received: by 2002:a92:cd82:0:b0:397:a8a2:7c58 with SMTP id
 e9e14a558f8ab-39d26cde8e9mr116323445ab.3.1724058124517; Mon, 19 Aug 2024
 02:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
 <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com> <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com>
In-Reply-To: <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 17:01:27 +0800
Message-ID: <CAL+tcoAEGcaEdCjxs9_nM7ux_r8tuYhjsMtJZfemHQ+DLVqUYQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 0x7f454c46@gmail.com, davem@davemloft.net, 
	dima@arista.com, dsahern@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Mon, Aug 19, 2024 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 19, 2024 at 2:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 7:48=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Kuniyuki,
> > >
> > > On Mon, Aug 19, 2024 at 2:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >
> > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > Date: Sun, 18 Aug 2024 21:50:51 +0800
> > > > > On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljaso=
nxing@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > Four-tuple symmetry here means the socket has the same remote=
/local
> > > > > > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> > > > > > > $ ss -nat | grep 8000
> > > > > > > ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8=
000
> > > > >
> > > > > Thanks to the failed tests appearing in patchwork, now I'm aware =
of
> > > > > the technical term called "self-connection" in English to describ=
e
> > > > > this case. I will update accordingly the title, body messages,
> > > > > function name by introducing "self-connection" words like this in=
 the
> > > > > next submission.
> > > > >
> > > > > Following this clue, I saw many reports happening in these years,=
 like
> > > > > [1][2]. Users are often astonished about this phenomenon and lost=
 and
> > > > > have to find various ways to workaround it. Since, in my opinion,=
 the
> > > > > self-connection doesn't have any advantage and usefulness,
> > > >
> > > > It's useful if you want to test simultaneous connect (SYN_SENT -> S=
YN_RECV)
> > > > path as you see in TCP-AO tests.  See RFC 9293 and the (!ack && syn=
) case
> > > > in tcp_rcv_synsent_state_process().
> > > >
> > > >   https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7
> > >
> > > Yes, I noticed this one: self-connection is one particular case among
> > > simultaneously open cases. Honestly, it's really strange that client
> > > and server uses a single socket.
> > >
> > > >
> > > > So you can't remove self-connect functionality, the recent main use=
r is
> > > > syzkaller though.
> > >
> > > Ah, thanks for reminding me. It seems that I have to drop this patch
> > > and there is no good way to resolve the issue in the kernel.
> > >
> >
> > Can we introduce one sysctl knob to control it since we can tell there
> > are many user reports/complaints through the internet? Default setting
> > of the new knob is to allow users to connect to itself like right now,
> > not interfering with many years of habits, like what the test tools
> > currently use.
> >
> > Can I give it a shot?
>
> No you can not.

May I ask why? Is it because self-connection adheres to the
simultaneously open part in RFC 9293?

I feel this case is very particular, not explained well in the RFC.
Usually, we don't consider one socket to act as client and server
unless in debug or test circumstances. As you can see, some people
have encountered the issue for a long time.

>
> netfilter can probably do this.

Sure, It can do. It can be a little bit helpful, but clumsy. We have
to set specific rules for each possible listener and then drop those
SYN packets if they carry the same remote and local port/ip.

Thanks,
Jason

