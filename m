Return-Path: <netdev+bounces-119639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5B956719
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F31C20863
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9EC15CD6A;
	Mon, 19 Aug 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSvt7JYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C08158532
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059925; cv=none; b=Oh974/ru4dPaYte0DUmwrHMbr3/CzMva7qx8m1BM5ieDlq2CHwtX5duayKa4a7WnUVKiAR3l0rf+Dg89AufozlCtbVPVULKXloZhp1+QVWLmv80NGCUOEsu5Sp0Cvq9touv0XmglV9Uu8f8HIt+rktY8zW9GG0rLTfrkZ70+j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059925; c=relaxed/simple;
	bh=XCguDipzMoCrs4fmoNfvhMd0FGmiPO2d9OvkW8RAwMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtg5URkWv3nd0qZvQZ8ePfSPu533aVT3wIa6zAdozeihsXgOAe6lwwj57hjajO/bYASrNSW0exUpJ1bPGNKBm5tNOlEN+yvPvJJ1dGhQexetY7B1g7GedZBGdnhwQVwdKiSUOfkoMsGBJLIo9rGVL+GtHUpNv8qNOeIaG5Jfuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSvt7JYx; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d21fdc11bso13609935ab.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724059922; x=1724664722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlUX60LJN5aviZ1WJ6fjIE5qij9C5r1jBIK1sqos0V0=;
        b=TSvt7JYxa1huaF4vRgoMYtRT3LS3Ebgk0+00+XdPcLv8LEuNztbpdWw+UhPr/Ya/cX
         CJU4bxc7NUfOPI00DjO7fjvL2uPvALAx12qW2QGItsb1a8hP/rx6WYtdPD7ELA8xfEOL
         KrTVwH+K6FK84z9q/sHcdUVUfUhMmhlKMhuNW34ygSxl533zDasS7oj+rI4/VzThK6o1
         cmK03vZ93YwEsEx50jrBy9zK5jnkrSd7rknfy4frZDrMzEVUG/LtCDaMRLwQxzWDLqQh
         G8qYJEPAKORALQCpqbgej8cf5Lwu2M/IMzaQNRkyFeqKQQKG1rOmZrlVSZrGC5N4Xumz
         Q7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724059922; x=1724664722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlUX60LJN5aviZ1WJ6fjIE5qij9C5r1jBIK1sqos0V0=;
        b=PQY5tDnNvUwXcFs2z48p7Zpeo4TQl09YslcVRMDiJfs3ORrlR9av/KELWTFyZmlMqB
         iEVunNfVrcG5+/FhhFgMw1rNIjvSNfk8t1lIpwYBSIzO74ekzc/srC6t8Gc9A0r5DR2d
         99BoIlXWyCG65hd3dTzlWnX80Duu5LHAyeLMSHmqw/nQ1nDdquOZvT0vzXdNHkk4ugbs
         fWoDqbg7iHtIM6LMqWSipj7Dfl0CLl9paPR6c0GffAQqAJsRcm+1ABuRmJsV5MTJ77eh
         5e/F/qdxAVt8SHuKXn4uHB67CflbThjguDG4TSOGg1oQKOeiJyE/ZkeOZlRsGelRgUkD
         YqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5CWo6fzk0A8cnuPfyl+fQSz+9hP4lwV2O+QhVXSxNa6el86odv9VKUZC0vpu1lNSlyPTVrobOpETJrbh1XLOtD4SRdgOn
X-Gm-Message-State: AOJu0Yy2YmRV2WvM0VjTj5EsZ3/DcVoaNFOg8KFCx41IvmBdTZXCZocQ
	5NmjOWUoDMJ0c90vk5O6Ym9PMT4F4Z28lxnz23/S5noU44zGvnX7TEwVeSRSXnqencaVdL5inBn
	4bOVdUgPChSAF9BJeTFLRpzDpizU=
X-Google-Smtp-Source: AGHT+IGRkcGVl7DIJsRY45m4+jmQ8ok6dtH25APioGWQvxkFIiOxvfrrKGHgFiOq3xnS6XUWBiYWJA3t1wk1h9I4utU=
X-Received: by 2002:a05:6e02:148c:b0:39d:229d:864e with SMTP id
 e9e14a558f8ab-39d26cde62dmr110391855ab.2.1724059922522; Mon, 19 Aug 2024
 02:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
 <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
 <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com>
 <CAL+tcoAEGcaEdCjxs9_nM7ux_r8tuYhjsMtJZfemHQ+DLVqUYQ@mail.gmail.com> <CANn89iJmEgeRv5w+YwdOGf0bbS6hNRtYWQ860QGu=KMJqVKZAw@mail.gmail.com>
In-Reply-To: <CANn89iJmEgeRv5w+YwdOGf0bbS6hNRtYWQ860QGu=KMJqVKZAw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 17:31:26 +0800
Message-ID: <CAL+tcoBVYE0+TeRW8AkmxXAYuJ04Za3XmZXD5T5R=LxqXRWzbw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 0x7f454c46@gmail.com, davem@davemloft.net, 
	dima@arista.com, dsahern@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 19, 2024 at 11:02=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Eric,
> >
> > On Mon, Aug 19, 2024 at 3:30=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 2:27=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Mon, Aug 19, 2024 at 7:48=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > Hello Kuniyuki,
> > > > >
> > > > > On Mon, Aug 19, 2024 at 2:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu=
@amazon.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > Date: Sun, 18 Aug 2024 21:50:51 +0800
> > > > > > > On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljas=
onxing@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kernel=
jasonxing@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > >
> > > > > > > > > Four-tuple symmetry here means the socket has the same re=
mote/local
> > > > > > > > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8=
000.
> > > > > > > > > $ ss -nat | grep 8000
> > > > > > > > > ESTAB      0      0          127.0.0.1:8000       127.0.0=
.1:8000
> > > > > > >
> > > > > > > Thanks to the failed tests appearing in patchwork, now I'm aw=
are of
> > > > > > > the technical term called "self-connection" in English to des=
cribe
> > > > > > > this case. I will update accordingly the title, body messages=
,
> > > > > > > function name by introducing "self-connection" words like thi=
s in the
> > > > > > > next submission.
> > > > > > >
> > > > > > > Following this clue, I saw many reports happening in these ye=
ars, like
> > > > > > > [1][2]. Users are often astonished about this phenomenon and =
lost and
> > > > > > > have to find various ways to workaround it. Since, in my opin=
ion, the
> > > > > > > self-connection doesn't have any advantage and usefulness,
> > > > > >
> > > > > > It's useful if you want to test simultaneous connect (SYN_SENT =
-> SYN_RECV)
> > > > > > path as you see in TCP-AO tests.  See RFC 9293 and the (!ack &&=
 syn) case
> > > > > > in tcp_rcv_synsent_state_process().
> > > > > >
> > > > > >   https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7
> > > > >
> > > > > Yes, I noticed this one: self-connection is one particular case a=
mong
> > > > > simultaneously open cases. Honestly, it's really strange that cli=
ent
> > > > > and server uses a single socket.
> > > > >
> > > > > >
> > > > > > So you can't remove self-connect functionality, the recent main=
 user is
> > > > > > syzkaller though.
> > > > >
> > > > > Ah, thanks for reminding me. It seems that I have to drop this pa=
tch
> > > > > and there is no good way to resolve the issue in the kernel.
> > > > >
> > > >
> > > > Can we introduce one sysctl knob to control it since we can tell th=
ere
> > > > are many user reports/complaints through the internet? Default sett=
ing
> > > > of the new knob is to allow users to connect to itself like right n=
ow,
> > > > not interfering with many years of habits, like what the test tools
> > > > currently use.
> > > >
> > > > Can I give it a shot?
> > >
> > > No you can not.
> >
> > May I ask why? Is it because self-connection adheres to the
> > simultaneously open part in RFC 9293?
>
> This will break some user programs, obviously.

I agree. It'a headache.

>
> I will ask you the opposite : What RFC prevents the current situation ?

Not really, actually. The reason why I wrote the patch is because it
indeed happened.

>
> >
> > I feel this case is very particular, not explained well in the RFC.
> > Usually, we don't consider one socket to act as client and server
> > unless in debug or test circumstances. As you can see, some people
> > have encountered the issue for a long time.
>
> Can you provide links to the issues ? How can a programmer hit this
> using standard and documented ways (passive, active flows) ?
>

I've listed some of them in the previous discussion through googling
"tcp self connection" or something like that. Let me copy here:
[1]: https://adil.medium.com/what-is-tcp-self-connect-issue-be7d7b5f9f59
[2]: https://stackoverflow.com/questions/5139808/tcp-simultaneous-open-and-=
self-connect-prevention

After investigating such an issue more deeply in the customers'
machines, the main reason why it can happen is the listener exits
while another thread starts to connect, which can cause
self-connection, even though the chance is slim. Later, the listener
tries to listen and for sure it will fail due to that single
self-connection.

Thanks,
Jason

