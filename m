Return-Path: <netdev+bounces-119514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BF95608C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4CB1F21E11
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1F10A0C;
	Mon, 19 Aug 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euzu6ArG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27812B8B
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027243; cv=none; b=k2vDkGCyYWBDvEs87LcbMxbRDqMudVM2/GVuHFnswCWzQSSaOEUlQBVIEec2GCzvTzme3Pp/ZNhLKHwHGVyoNjie9Nq3jDVn/gf8uez9BC+v2NJgzW1gPq3l/HUO+HLRuUN9qU0rdO+ve3UobR0icJVQtpZDyWgCGjwT7SInnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027243; c=relaxed/simple;
	bh=zQmN6bhwYFWZmBiol4sctRLouWbFv7BSeGwZgCuSY00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+CACqohXiK54C/d44Bw4NoR6+i6O60R3GQHzBE4LOmnBgt8Jg7oYE1gIyDBeJZk3M9MW5KJRdxkWUFf0HmyFT43OCuc0LL00YSaXT4C9usfz+zCkY7mtEdUmrxfuxS3qHBKssdwY7elzsWKJyrWDXdEp3aGSxXKKH+MHaNvUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euzu6ArG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d2256ee11so12131035ab.1
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724027241; x=1724632041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVNhoZssKpWpLm86UN5yzhBz5Yuourk9D5wC2j9y1mU=;
        b=Euzu6ArGfNY55zWrGjNRcwD/joC+k4oL3G5Wf7gjUKPau0slqBRIT/aOv3eConNV06
         +vCcfiVyRT/aGYDsxR+zuO3L282PgU6kpfeFL8mVB00ch7cEMu9mO1JgsIefwmr8SXdD
         NpDjJBml1eiEjOnHHpVOwbZ8IUk+0pduybK8HS2xLnlkZGDktN2+M9nYLAhRq4PL+LnL
         VOR06HWkaH414gLuUpeDhARF0g9oe1Q83ibQUN6iVW0LU0cLKTXP6IsF4HfgtfghJRf5
         rjrsfiQEJDTRbDB1H+T2V7Ekuc3g1+6tdENSOLcBjfj4q8XWQjgBriyQFa/HIFxegLfr
         rmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724027241; x=1724632041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVNhoZssKpWpLm86UN5yzhBz5Yuourk9D5wC2j9y1mU=;
        b=kJhsCAfXnKhBooZFQft5I8CAHuVYHxya4+pjqfK9e3Zrh8Ciuy2I3UqF3/Ylktn4ge
         G7lYN5xuB0kqbxxNLqY+lvOQxGuf8ADKHMazMshO/rEafxopF4Jdq/4Re4f+aQZ4uaEi
         /08tpJxFX8ejB9QfU4bZ5Tm/Hm14Y26l1lnQwIsw/r224S1MRltjD8v2q5v8apPswyyK
         6jG9o2NcHfIyPchZs0qPBmbb0J7fK3M+gAGAUg43eSodMVgZ+yCk+91uOW5+ONr/q08i
         daFa8etWZbI5UUlmM7yeTSwg3Qti2iQUteeCks9xA+Lv75/8lg/jNPC6GBHm2KJf80Eo
         o5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSjK0FajJqG4NCoVIeJ6CNoiR7mty4ZPXgB28ZltJdQq7qpw+BTUtxlFuqLweLvmlHr4dDhrUHpK33+v4NfK5DaY1otM5e
X-Gm-Message-State: AOJu0Yyo9wsByHH4X6EzhPKIr8yIAl4gQfRVQMDbJ/kzIWwLKi9Q1gjb
	AJASMmpmaSPN/u1rAVpVV+XhVtxtNBGWkO6buCEEFHOLv8Iagw8blBRNLArwpCgq2jbvzjWb2z+
	fdQROoQIydXa7qJrPoXd7TP8Ym2I=
X-Google-Smtp-Source: AGHT+IHu4Bq/GO+A7v5R3++UaSnLHQlLqmMSaR+DKX4RNF6YXe4pmCyuBP5Ggb9G0eoAVNYGEud2N+MDpj1gIqMouqg=
X-Received: by 2002:a05:6e02:1c04:b0:39a:ea4c:2982 with SMTP id
 e9e14a558f8ab-39d26cfb468mr127600645ab.10.1724027240833; Sun, 18 Aug 2024
 17:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
In-Reply-To: <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 08:26:44 +0800
Message-ID: <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: 0x7f454c46@gmail.com, davem@davemloft.net, dima@arista.com, 
	dsahern@kernel.org, edumazet@google.com, kernelxing@tencent.com, 
	kuba@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 7:48=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Kuniyuki,
>
> On Mon, Aug 19, 2024 at 2:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Sun, 18 Aug 2024 21:50:51 +0800
> > > On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Four-tuple symmetry here means the socket has the same remote/loc=
al
> > > > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> > > > > $ ss -nat | grep 8000
> > > > > ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8000
> > >
> > > Thanks to the failed tests appearing in patchwork, now I'm aware of
> > > the technical term called "self-connection" in English to describe
> > > this case. I will update accordingly the title, body messages,
> > > function name by introducing "self-connection" words like this in the
> > > next submission.
> > >
> > > Following this clue, I saw many reports happening in these years, lik=
e
> > > [1][2]. Users are often astonished about this phenomenon and lost and
> > > have to find various ways to workaround it. Since, in my opinion, the
> > > self-connection doesn't have any advantage and usefulness,
> >
> > It's useful if you want to test simultaneous connect (SYN_SENT -> SYN_R=
ECV)
> > path as you see in TCP-AO tests.  See RFC 9293 and the (!ack && syn) ca=
se
> > in tcp_rcv_synsent_state_process().
> >
> >   https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7
>
> Yes, I noticed this one: self-connection is one particular case among
> simultaneously open cases. Honestly, it's really strange that client
> and server uses a single socket.
>
> >
> > So you can't remove self-connect functionality, the recent main user is
> > syzkaller though.
>
> Ah, thanks for reminding me. It seems that I have to drop this patch
> and there is no good way to resolve the issue in the kernel.
>

Can we introduce one sysctl knob to control it since we can tell there
are many user reports/complaints through the internet? Default setting
of the new knob is to allow users to connect to itself like right now,
not interfering with many years of habits, like what the test tools
currently use.

Can I give it a shot?

Thanks,
Jason

