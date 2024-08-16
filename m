Return-Path: <netdev+bounces-119121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221995422D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63F51C22B41
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C1823CB;
	Fri, 16 Aug 2024 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/6mi8Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701780BFF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791487; cv=none; b=gEvX0tkx9zIN0SNmApY1YhfzPoTj5Qi2ebBignZ7RzUAQhanC8wSwIe3KbzTaTOqyNYqBmmrDrIaypdpXErmzVrzWndOuJ90ddbiefv9kHTMD60I8NhJH3FJ/lkY+wVYzWZHUpG92EV5v3Vfn6qO98orkyocMbnD8BxfpmIIHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791487; c=relaxed/simple;
	bh=E3kJo/sojSIMqQ/5JhC/ycY28SVx1WTQ2zZvjEfoWHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfKodJ45MsM92OFVLCNt4IVn6K5cXkihb4X3tgEiaC2gsRl5Rg9Bjh2IW2YTH45XxUXGFN7KmahADnhWffrj/FXLxTafJRKl9sX3yW/KrkIf4vZkZwhOXxr68MKdmaa0myNpVjHUjygVYM/eerax6jhHgtDJ8EfAN91P5CfB+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/6mi8Pe; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b04f0b486so5506695ab.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723791485; x=1724396285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaGFmnqBrOPhL0oAM3DzNTSGf9L2HqmBFvXJ7xNXYDQ=;
        b=A/6mi8PezSfGyaHi6QXJQeUz+vnd6LNMxmJvd8RcEPW+aX+6kTH3P4AqTiROWM1wHT
         dm5lqWg5Nj+Z/af8AA0onkiD+3NlQAD3fwCN0vpZ3xHv8smKme17xHJkmCnACxpwD2Xy
         WAZ8ZQ/C5Jf3TLVX6vge+3YVodRAucMrzQTXkuMmNXZA7+0VQEuSfAxvOiwPMnakfIRI
         cM7rDJjqvvgjp4UDFcduPM0qGdp95Zn+NZlO8Q41FVjV/Reg3Jqd1luJZK0fawFP1LYQ
         Pd5tx23Ux4eXVpLKMz4P2eKoxtme4M8LI9h6rfulFRiePL/6tm6Id082KBtxhLP7cYSE
         t7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791485; x=1724396285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaGFmnqBrOPhL0oAM3DzNTSGf9L2HqmBFvXJ7xNXYDQ=;
        b=sbrqi2U6+yDqCViLPDKwsTxvtFDYjcBl277MH5wVsp1UP7Tekp8XmWbz4OIbjd+GRH
         3CEhpjEY58LiAtvdyuSMYgUvfLJrL7C58hHHi+B3MDtLaLaZS90u3QjxTVz+kQeJWHBk
         gcFTI50Txpzt8vQnTXlkqnVQMtLdwq6yx1bZa0b19gVMxJfMW6USNxknT0tP2nWpG9vA
         9s5WBrDgXvFRjuGtGs7PvMDxtviGndZ5VTA1V5lrKnEl5ZcmkdJ+nMeZ1LJvIh7F6O4V
         ZUsFLz48Un0sYkva+dkiG8hmU1zDiF6mv3R8V3e4qTUmTbdrtsQIUcQvoyGngTHY6ClO
         /oFg==
X-Forwarded-Encrypted: i=1; AJvYcCV5P5BO/CwlKPGWDN/2veRlvMcotImm8e7JdOtDOlCU5z6J5Ph89T6+lu4EqkYc61IHgGsOh+GJjbnHjYZwCGSZLmcUjFS6
X-Gm-Message-State: AOJu0YyIDWmUm75bELrjJ+NBcfEd6W6flrx6qDOGhm5A7fWpJi9aUaDm
	AgjMn5/wJ+owV+C3Sch60ong9AXLTi29yCO/vf24+lV6zV2ROGMZDu3B4nNc2SY9fu+53Os7VHJ
	Ks2Kd3oEgl+71pFn6PZWCyQS/OWE=
X-Google-Smtp-Source: AGHT+IEig7IS85gm+1sKI4rYSu0/kSo1mv7JeyY/UfvHeOgOyB0aaNs2fMKVITg75ZefNkFSNLGzitQeKUG0nadSCQc=
X-Received: by 2002:a05:6e02:1e06:b0:39b:bba:be89 with SMTP id
 e9e14a558f8ab-39d26d7cc85mr31063155ab.27.1723791484956; Thu, 15 Aug 2024
 23:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCX2Si0q7HwvGspwqUeN8F1fPxocbb+BB8psQ++_2O_kg@mail.gmail.com>
 <20240816034646.18670-1-kuniyu@amazon.com>
In-Reply-To: <20240816034646.18670-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Aug 2024 14:57:28 +0800
Message-ID: <CAL+tcoA+5nQqdJAUYXoa=Y7KJX8LDRWQP8sBrOUfb4LMwkHrCg@mail.gmail.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:47=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 16 Aug 2024 11:36:35 +0800
> > On Fri, Aug 16, 2024 at 11:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amaz=
on.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Fri, 16 Aug 2024 10:56:19 +0800
> > > > Hello Kuniyuki,
> > > >
> > > > On Fri, Aug 16, 2024 at 6:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@a=
mazon.com> wrote:
> > > > >
> > > > > syzkaller reported UAF in kcm_release(). [0]
> > > > >
> > > > > The scenario is
> > > > >
> > > > >   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
> > > > >
> > > > >   2. Thread A resumes building skb from kcm->seq_skb but is block=
ed
> > > > >      by sk_stream_wait_memory()
> > > > >
> > > > >   3. Thread B calls sendmsg() concurrently, finishes building kcm=
->seq_skb
> > > > >      and puts the skb to the write queue
> > > > >
> > > > >   4. Thread A faces an error and finally frees skb that is alread=
y in the
> > > > >      write queue
> > > > >
> > > > >   5. kcm_release() does double-free the skb in the write queue
> > > > >
> > > > > When a thread is building a MSG_MORE skb, another thread must not=
 touch it.
> > > >
> > > > Thanks for the analysis.
> > > >
> > > > Since the empty skb (without payload) could cause such race and
> > > > double-free issue, I wonder if we can clear the empty skb before
> > > > waiting for memory,
> > >
> > > kcm->seq_skb is set when a part of data is copied to skb, so it's not
> > > empty.  Also, seq_skb is cleared when queued to the write queue.
> > >
> > > The problem is one thread referencing kcm->seq_skb goes to sleep and
> > > another thread queues the skb to the write queue.
> > >
> > > ---8<---
> > >         if (eor) {
> > >                 bool not_busy =3D skb_queue_empty(&sk->sk_write_queue=
);
> > >
> > >                 if (head) {
> > >                         /* Message complete, queue it on send buffer =
*/
> > >                         __skb_queue_tail(&sk->sk_write_queue, head);
> > >                         kcm->seq_skb =3D NULL;
> > >                         KCM_STATS_INCR(kcm->stats.tx_msgs);
> > >                 }
> > > ...
> > >         } else {
> > >                 /* Message not complete, save state */
> > > partial_message:
> > >                 if (head) {
> > >                         kcm->seq_skb =3D head;
> > >                         kcm_tx_msg(head)->last_skb =3D skb;
> > >                 }
> > > ---8<---
> >
> > Oh, I see the difference of handling error part after waiting for
> > memory between tcp_sendmsg_locked and kcm_sendmsg:
> > In kcm_sendmsg, it could kfree the skb which causes the issue while tcp=
 doesn't.
> >
> > But I cannot help asking if that lock is a little bit heavy, please
> > don't get me wrong, I'm not against it. In the meantime, I decided to
> > take a deep look at the 'out_error' label part.
>
> I don't think the mutex is heavy because kcm_sendmsg() is already
> serialised with lock_sock().

It makes sense. I have to say that it was my concern.

After digging into this part, sorry, I can't find a easy way to
prevent double-free issues because:
initially I was trying using seq_skb (something like that) as an
indicator to reflect whether we are allowed to kfree the skb, but it
doesn't work for all the cases. Supposing there are three threads,
each of them can call kcm_sendmsg() and wait, which makes it more
complicated. Let alone more threads access this function and try to
grab the lock nearly concurrently.

Making the whole process serialised can make life easier. For sure,
introducing mutex locks can solve the issue.

Thanks,
Jason

