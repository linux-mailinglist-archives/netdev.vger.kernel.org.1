Return-Path: <netdev+bounces-119093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBE954012
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F418C2845AB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C853804;
	Fri, 16 Aug 2024 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+usB/Mo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090421AC88A
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723779434; cv=none; b=FFFHCtIDbS5iSTW0lrQ+F+Rlqm3dPLYW2zUWvr4k6lHv/J0iiJncomW4ZBefVwCyGPBMxXBvDpjXs4GylHgfi7xCvC4PlL4lj1zJqRxKMb1NGWhAerxJimnt71sPh9F15iF05tZR8m/nU66sWjSvZWq5ejTj2YXA8tWGuVJUUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723779434; c=relaxed/simple;
	bh=bJgE1HxuEsvMEwZltMwfjJ/5tJZJDfOwb80GxxJrYjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkWuSJzMUQREdI4a/Fu4yMIK6fHyLTk9rrPCrRafUTy+m4eyvkwz1HJ7kYpU9nJlln7wOG/WRmEQkLbvfwpvFvtScmA6/hbNvOz6/jZDnOf1JcxVrHs9n9j6pg/WryYQ2LeZolgFPw2nZTN2e7WcQmBHUzu/XEFGi+mrl8Hufk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+usB/Mo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d26a8f9dbso2356455ab.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723779432; x=1724384232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQZX4e7ZEO+ZGj0UK4PKL6KE8cf/CrNlqHVNAvBKA8Q=;
        b=V+usB/Mo6FuOofUsAVi2qRCHaflX4GJLu8KWhKv2wgSTPTXmvUjzd7UEVVfqPPVMVF
         5EDaRx1AGSNik01s2QVdU5mBK73VZm9d6W6V/cwkY9sL/9AwOK7avq3hME8572bFi0zH
         1jbBYzO/EwLP0WSyGg2dU2TfM7to8Zva4vMrrJO1spseYmrbwnZVxxVgv33X+1OeiM2d
         IAwhfRxgOw0vU9+9cZp8fzZ/Wlt61jedwgH9qK6mKFFbReTMt7zNYl6MQinwXSk0boRs
         syBrlEPe/zWOs2QIEvIewHRxLuh5tZZwyCq7JUZh3VYa756fg//gobLalytVWBdaAOq2
         fMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723779432; x=1724384232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQZX4e7ZEO+ZGj0UK4PKL6KE8cf/CrNlqHVNAvBKA8Q=;
        b=ZEWbi9FB7LQIICDvTyQBkuogIX+yC8pEVXR8mUBy5PtWx10Ge4tex/CWBILDvt4Ml/
         MnQdmGOcLKyfuyUwj0jNYX/RjHDasTvuNlhHEGZQKVL+j9cxRgPfu2rWIlYghZydGq9R
         4sfsYoOXOopuVvcwjw8mgQfGZah8eUwPm2LWKA/3BASInBTfYf+ho7A8djrJXqo48WoT
         FKr0i6D4J6Gez6PL6/KkDp4D+5UKtv+q/bFpU0Jv1+C6WNrevW8d/Pxza0tE1HxRU8in
         ndD/x6tRAHAyhFmifXkps6d532lqqi9Y+81QrwoWgPoOG9tgH7ApLLvkteV8DiFq1qjH
         B6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTKmj4IbLrMVk/eu+EbgC8q1DgRuaQkbJ2LkrLnJhrt15JGHQORfKJu14O7eGWmrq/8zCxL6FT6FIIu8jnkYCelJfftijW
X-Gm-Message-State: AOJu0YxcqyBCUXYSCDzsFI4DVn/keBjsHVX1SYfSTDzwCDQD2DrCJb65
	ZNkpPt067gcsK59v+odePKQ29FlHf29JhKJsqdxIihNueGuDGQHTKKGaFmCYD38D0cC4gVt3LER
	HojutIjY/T1dQ+zVz8/fdTRkfk/0=
X-Google-Smtp-Source: AGHT+IEEsGrTn9hrLuOGz7lp8dkDwujUi8Jh1pLndMPG9Le2Aj/i31z2G+8eNmZWBWwkkxJy86tH3Onpaic1jujTiXU=
X-Received: by 2002:a05:6e02:b2c:b0:39b:640e:c5e6 with SMTP id
 e9e14a558f8ab-39d26d5fa7bmr21268235ab.17.1723779432059; Thu, 15 Aug 2024
 20:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCc7Nm7KgaJxYr4arRxnB+62WrTSoSD79i5X-mkHBiO6g@mail.gmail.com>
 <20240816030543.15051-1-kuniyu@amazon.com>
In-Reply-To: <20240816030543.15051-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Aug 2024 11:36:35 +0800
Message-ID: <CAL+tcoCX2Si0q7HwvGspwqUeN8F1fPxocbb+BB8psQ++_2O_kg@mail.gmail.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 16 Aug 2024 10:56:19 +0800
> > Hello Kuniyuki,
> >
> > On Fri, Aug 16, 2024 at 6:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > syzkaller reported UAF in kcm_release(). [0]
> > >
> > > The scenario is
> > >
> > >   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
> > >
> > >   2. Thread A resumes building skb from kcm->seq_skb but is blocked
> > >      by sk_stream_wait_memory()
> > >
> > >   3. Thread B calls sendmsg() concurrently, finishes building kcm->se=
q_skb
> > >      and puts the skb to the write queue
> > >
> > >   4. Thread A faces an error and finally frees skb that is already in=
 the
> > >      write queue
> > >
> > >   5. kcm_release() does double-free the skb in the write queue
> > >
> > > When a thread is building a MSG_MORE skb, another thread must not tou=
ch it.
> >
> > Thanks for the analysis.
> >
> > Since the empty skb (without payload) could cause such race and
> > double-free issue, I wonder if we can clear the empty skb before
> > waiting for memory,
>
> kcm->seq_skb is set when a part of data is copied to skb, so it's not
> empty.  Also, seq_skb is cleared when queued to the write queue.
>
> The problem is one thread referencing kcm->seq_skb goes to sleep and
> another thread queues the skb to the write queue.
>
> ---8<---
>         if (eor) {
>                 bool not_busy =3D skb_queue_empty(&sk->sk_write_queue);
>
>                 if (head) {
>                         /* Message complete, queue it on send buffer */
>                         __skb_queue_tail(&sk->sk_write_queue, head);
>                         kcm->seq_skb =3D NULL;
>                         KCM_STATS_INCR(kcm->stats.tx_msgs);
>                 }
> ...
>         } else {
>                 /* Message not complete, save state */
> partial_message:
>                 if (head) {
>                         kcm->seq_skb =3D head;
>                         kcm_tx_msg(head)->last_skb =3D skb;
>                 }
> ---8<---

Oh, I see the difference of handling error part after waiting for
memory between tcp_sendmsg_locked and kcm_sendmsg:
In kcm_sendmsg, it could kfree the skb which causes the issue while tcp doe=
sn't.

But I cannot help asking if that lock is a little bit heavy, please
don't get me wrong, I'm not against it. In the meantime, I decided to
take a deep look at the 'out_error' label part.

Thanks,
Jason

