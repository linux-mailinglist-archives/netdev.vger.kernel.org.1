Return-Path: <netdev+bounces-119996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE1957CC2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8468FB21B01
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F30D446DC;
	Tue, 20 Aug 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF6SI8ut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5C1862
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132121; cv=none; b=lJ4OzTSL5TCgc2A+GoK3BRyxs5r08P8cfdQVkzjbC80TkXzGq3hKEp5B/AmZP0TrJIbbv5itQA01R0KHlqAw+NGY9rPXbQD17fTJBgcHcnY84bfw+BVOmBvoASFXEgZT8mUjeku7Kw8l/PbqUB6P2OMBNNu3UuPqDhEtTFDW1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132121; c=relaxed/simple;
	bh=6aeUV4+bIiEzCZ5L+6wWmYpoDu/+neqjY8LPkm2b7Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLDdNQQo69MHF/GtTIuEq/4wHIjfLAboJZG3zAADLzhU2SsAMvRLu8d9cCl0vo9eLwgQYbP1cFNeTV2lf6UFh9BH98P7l4nzmt/iU7q+8thBROmZ2btwM0kCjoc0gLfrmYiJxHqVMx1O+mdFI6iTopOY0Ctmh8l7a482AetTbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF6SI8ut; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d3cd4fa49so7278705ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 22:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724132118; x=1724736918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDpKN2GUjpPxvgHJgOUY0VvJgQA8/FzeN4/AAlA5wqo=;
        b=YF6SI8utAi6Z0M+VdAp5SiwB7HjvT28fPYFzkzW0GoNJNnUbug8wn9WdrDQNlgn2aC
         EZ/+43CmQ70v48ZwjPok+OvELn3fjAqaf/R+b1F87FOcA6c0okrxNzmu/G1mGcXqyYkB
         ZqstqWgbKsWFVvrGbB17yH4dhpNpCXG9+l4cdHfxkevvMXrfC9hthcR+fuphCM7eVDm7
         c7wDwKh6cXNi/4rGUECs47KBG/onfwXfuIPMpGMxxrPXn5pYBLn6yqISsUL1VHvlrW6Y
         2PYNPRJ2aMsLsZUIHfVXu4TjeSh2+1h+UDIJQacC/zycOAA9T0u5znVg90b/2VsDdoIv
         Eptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724132118; x=1724736918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDpKN2GUjpPxvgHJgOUY0VvJgQA8/FzeN4/AAlA5wqo=;
        b=TpyRqdrTszzeNBoNX4kV1wP2lFuAvK74agPuRr7q16KwlgvuSuAV2WE9QRemVYNeYK
         58ICIm+951diApVXgLAL/Dry0OPR1kOkuFCgyZxRvdsH28hlLtzLXNVzVWmUe52CGH1c
         +Yft+30HGY+wAJ06F2uQFv+2M323eQBaQK9fiwdbgYYtaEjgz+iWB19449k0XCFGpL0p
         CDOY4zG/j1tj/6DirxKSbYhEXf0IDwNrCS2NUPS2VrZZoni3fkzM+LBm7ECEs4QAlzBQ
         ERSMmwJRQbeMW9fs1J4CNe01mi0PSL8h/WH1p76KQCKBe7oKGHU6GCXlRid5HDs6BW3F
         uTLA==
X-Forwarded-Encrypted: i=1; AJvYcCUplJaYtY0ycgNeCGG7+QW3gKdvmHSacSNw0UMev50mWlEfQtM+RasiyZmadoDEGF/n+RVxgU4+AvRgYz4uGfV0ZxPQW4ST
X-Gm-Message-State: AOJu0YzQXLGUIAA9lmCeyv3Ukx/eyGrEwdKQMxgswYsrIvPbgTq5QNpr
	skI2KNYHXyPJ307icoCCk2FJ7d4f9Nb8diCZoBIs6siyihQlvrzYtMR5x51GGEItflosbGqFrNA
	JR3XTn1cbn6mHbNHJ5ZbdYJELYZM=
X-Google-Smtp-Source: AGHT+IHLYxn59q/IiIoOgZqD4/yjaq1W7eJzDeHUEGdEHkunraMdY3y2xXKNgWQaqLEFy9MahWy5lgVT1RMWJdlbqvU=
X-Received: by 2002:a92:8708:0:b0:39d:47c6:38b1 with SMTP id
 e9e14a558f8ab-39d56f6d539mr20599555ab.9.1724132118300; Mon, 19 Aug 2024
 22:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoAJic7sWergDhVqAvLLu2tto+b7A8FU_pkwLhq=9qCE1w@mail.gmail.com>
 <20240820045319.4134-1-kuniyu@amazon.com>
In-Reply-To: <20240820045319.4134-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 13:34:41 +0800
Message-ID: <CAL+tcoCa1MCHnyd8Qy2LE5e6mUe8PLPp=tXAO56z7S34TXNuFA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 12:53=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue, 20 Aug 2024 08:53:53 +0800
> > Hello Eric,
> >
> > On Mon, Aug 19, 2024 at 11:45=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Fri, Aug 16, 2024 at 5:33=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This is a follow-up patch to an eariler commit 207184853dbd ("tcp/d=
ccp:
> > > > change source port selection at connect() time").
> > > >
> > > > This patch extends the use of IP_LOCAL_PORT_RANGE option, so that w=
e
> > > > don't need to iterate every two ports which means only favouring od=
d
> > > > number like the old days before 2016, which can be good for some
> > > > users who want to keep in consistency with IP_LOCAL_PORT_RANGE in
> > > > connect().
> > >
> > > Except that bind() with a port reservation is not as common as a conn=
ect().
> > > This is highly discouraged.
> > >
> > > See IP_BIND_ADDRESS_NO_PORT
> > >
> > > Can you provide a real use case ?
> > >
> > > I really feel like you are trying to push patches 'just because you c=
an'...
> > >
> > > 'The old days' before 2016 were not very nice, we had P0 all the time
> > > because of port exhaustion.
> > > Since 2016 and IP_BIND_ADDRESS_NO_PORT I no longer have war rooms sto=
ries.
> >
> > As you mentioned last night, the issues happening in connect() are
> > relatively more than in bind().
> >
> > To be more concise, I would like to state 3 points to see if they are v=
alid:
> > (1) Extending the option for bind() is the last puzzle of using an
> > older algorithm for some users. Since we have one in connect(), how
> > about adding it in bind() to provide for the people favouring the
> > older algorithm.
>
> Why do they want to use bind() to pick a random port in the first place ?
>
> bind() behaviour is not strictly the same with connect(); the port reserv=
ed
> by bind() is not reusable for connect().
>
> Also, bind() requires SO_REUSEADDR to share a port, but by default, even
> SO_REUSEADDR enabled sockets cannot share the same port if application
> uses random-pick by bind((IP, 0)):
>
>   # sysctl -w net.ipv4.ip_local_port_range=3D"32768 32768"
>   # python3
>   >>> from socket import *
>   >>>
>   >>> c1 =3D socket()
>   >>> c1.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
>   >>> c1.bind(('', 0))
>   >>> c1
>   <socket.socket fd=3D4, family=3DAddressFamily.AF_INET, type=3DSocketKin=
d.SOCK_STREAM, proto=3D0, laddr=3D('0.0.0.0', 32768)>
>   >>>
>   >>> c2 =3D socket()
>   >>> c2.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
>   >>> c2.bind(('', 0))
>   Traceback (most recent call last):
>     File "<stdin>", line 1, in <module>
>   OSError: [Errno 98] Address already in use
>
> Then, net.ipv4.ip_autobind_reuse needs to be enabled at some risk.
>
> bind()+connect() simply decreases the number of available 4-tuple on
> the netns unless all applications use bind()+connect() instead of just
> connect(), and it's unlikely.
>
>
> > (2) This patch will not hurt any users like in Google as an example
> > which prefers odd/even port selection, which is, I admit, indeed more
> > advanced.
>
> Indeed, it won't hurt existing users but will lead new users to the
> wrong way.

Wrong way? You claim providing an old way for users to prevent the
'breakage' of applications is wrong regardless of those users' habits?

>
>
> > (3) This patch does not come out of thin air, but from some users who I=
 contact.
> > ?
>
> Is someone who contacted to you really aware of all of the above and
> even then in favor of bind() without IP_BIND_ADDRESS_NO_PORT ?
>
>
> > In my opinion, using and adjusting to the new algorithm needs some
> > changes in applications. For some old applications, they still need
> > more time to keep pace with a more workable solution.
>
> They will add setsockopt(IP_LOCAL_PORT_RANGE) whether your patch is
> applied or not, then, only thing they need to do is replace SO_REUSEADDR
> with IP_BIND_ADDRESS_NO_PORT, simple enough ?

From the perspective of kernel developers, yes, it can work for sure.

I'm not discussing why exactly those applications design like this or
not like what we expect, but the fact is they do exist. If I were a
network engineer, I could probably know how to avoid this, but I'm
not. If you insist on asking why they use it like this, I can only
make myself clear by introducing another similar story to help me.

My original way is introducing a sysctl knob which can be tuned by
users to select one of those two algorithms, but it's not acceptable
by the upstream team from what I know. Then, I have to resort to other
ways of letting people have a chance to go back before 2016.

We cannot deny that the connect() using new algo causes some problems
which were missed two or three years ago, which may be considered an
incredible thing now, the same thing could happen again.

Probably we are not on the same page. I'm not unfamiliar with the
'correct' way to handle the issue. Also, I'm not arguing that we
should give up the way you mentioned. The only thing I'm saying is
whether we should provide a method using an old algo or not.

That's all, that's my final try on this patch. If you both disagree,
I'm totally fine with it.

Thanks for both of you getting involved into this discussion. I really
appreciate it :)

Thanks,
Jason

