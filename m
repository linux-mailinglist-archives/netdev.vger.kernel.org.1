Return-Path: <netdev+bounces-119512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B078695602D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274D81F21D3B
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C1D1BC59;
	Sun, 18 Aug 2024 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnKGLMdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBD1A291
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024955; cv=none; b=KIWMR+OI4n60bwcTVNLj8vPMYqsYF0i0qqycfN5M1H5h8SkfFg5MH8L2NkIhdLbY/16QbODe5eKHPjHJtbUEI2ye8if5pH8ivcuWnaWyw+Ki1/CfyA89+2jZUZa+OQDn4ytcNL6rT7vTtWRqbYPWvx5edq7Yn+gV4Qh2amILN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024955; c=relaxed/simple;
	bh=hOw2OJgLG+CVtsIiR7F86hptRev3j1MMons7y73p7A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuOIWRqFV0unRkAT86EXznGvxfdDpFOIegxTrRAFbJ/dVGZXhX4njYge76eERmprYxPslT4vPddVRWI/A4GC/kGY0HC3LqK3UGqThhAY8uV/jaBAN8eBVTQie54E/NU/sUYOqFwCKMollUKTlQCWsmQxyvPk5LFGDBLWr8BQ7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnKGLMdN; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d37218c5cso4783265ab.1
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724024953; x=1724629753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzBHExKlQlMMSe3a2wfhU1/TOrHOedKmTaG2JQr1zyg=;
        b=AnKGLMdN0W9MXEpioGyEdOvqqVD0ISvXLeFY3xGEXZ0XsEdjJDzmRzaNjj7eYwFotf
         it5w2b5ae+64JaTf7viZyeldes+F/leBGhv59FAZyC23ezL3g8RzaILDaGvdJcLZfhUE
         v/etLrK29/b0bfCACTxCuF5KhXtPxq+PB3YMVTS42rTE0uP6846AHhYr65YK6ILcYcbM
         LsL6wWxKeYe48xMbHfBUTPjYgeMEpq62jHkoLZmGMDjG2GHEdukrWeUbYTSqiaxwSToS
         HgcF9d18KzPekHOt7z/uf0/DlCpbET6VYvV+KXMFlgs8lUjsNqCXRagY90A3GOD19KVH
         MLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724024953; x=1724629753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzBHExKlQlMMSe3a2wfhU1/TOrHOedKmTaG2JQr1zyg=;
        b=rjVboZT8Swo93icvCbj0Ni6UAiVf3rUWvt17eFydV8O20vWcbd+OeEvmxD2QU9lxst
         XihXELQBOelWH7OYiagDJSN17V3Irffys6WeuRnA/TGt7Eph8dDU/hN2c8iqK2M/Q6Fh
         BnLqrZLT+K7f2NbaMnBLMxhvrbLLH4u/lErAe9id40cVHv7qdANLC3eduIgz4rASuiwL
         TJLR879hZqZCr7l2B0XklDICZSL6QJyvyyqIyjWYiEjVQF3nm+PjDO+Y+oyiOULp2Uwh
         6a1gUdo7507ToWAZoVSh7OppKhvzB+Qhvgp4hrKQuroMdeppZbyFlGnsTps6EdA0XDos
         HxIA==
X-Forwarded-Encrypted: i=1; AJvYcCWdS8zcmA7zmCg2QjHK3gnwVOrjNtUGOOYk8wT8XeifoCoFH3JRR2jpYdwIS/ZmwR2xVQ8GfKkPZeAbFsTYgtIRIF/lmsUS
X-Gm-Message-State: AOJu0YwaKuSloiESpEeTV5KTBLZzypxlM4qJztEmtXQB5UxMV99HY3R7
	ngGoyPlTt5XQpfb3kYtmeH42zyW6joXascnWDbq8HdDdPbftAxefIktH7yXeeFx1qp21czD4Qn/
	dAEhQU1dOhWjmsEd/BJ7MDifk4YU=
X-Google-Smtp-Source: AGHT+IHDAI0aY4Uyx+ErEnYzqj0JkupICC+/oOPE+xbDTNwTCuwJg65jzKKoEnHm3loABygF0kPvZexnF7wD/VA/dr4=
X-Received: by 2002:a05:6e02:1a8f:b0:39a:e9ec:9462 with SMTP id
 e9e14a558f8ab-39d26cde827mr127493145ab.5.1724024952570; Sun, 18 Aug 2024
 16:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com>
In-Reply-To: <20240818184849.56807-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 07:48:36 +0800
Message-ID: <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: 0x7f454c46@gmail.com, davem@davemloft.net, dima@arista.com, 
	dsahern@kernel.org, edumazet@google.com, kernelxing@tencent.com, 
	kuba@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kuniyuki,

On Mon, Aug 19, 2024 at 2:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Sun, 18 Aug 2024 21:50:51 +0800
> > On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Four-tuple symmetry here means the socket has the same remote/local
> > > > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> > > > $ ss -nat | grep 8000
> > > > ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8000
> >
> > Thanks to the failed tests appearing in patchwork, now I'm aware of
> > the technical term called "self-connection" in English to describe
> > this case. I will update accordingly the title, body messages,
> > function name by introducing "self-connection" words like this in the
> > next submission.
> >
> > Following this clue, I saw many reports happening in these years, like
> > [1][2]. Users are often astonished about this phenomenon and lost and
> > have to find various ways to workaround it. Since, in my opinion, the
> > self-connection doesn't have any advantage and usefulness,
>
> It's useful if you want to test simultaneous connect (SYN_SENT -> SYN_REC=
V)
> path as you see in TCP-AO tests.  See RFC 9293 and the (!ack && syn) case
> in tcp_rcv_synsent_state_process().
>
>   https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7

Yes, I noticed this one: self-connection is one particular case among
simultaneously open cases. Honestly, it's really strange that client
and server uses a single socket.

>
> So you can't remove self-connect functionality, the recent main user is
> syzkaller though.

Ah, thanks for reminding me. It seems that I have to drop this patch
and there is no good way to resolve the issue in the kernel.

Thanks,
Jason

