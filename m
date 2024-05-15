Return-Path: <netdev+bounces-96572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBABC8C679A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0934D1C214E1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3013E8B6;
	Wed, 15 May 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCl06w44"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471512C7FB
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780583; cv=none; b=MEANN25ImAN3CmzZWq6ZdCDlWmrqLYWI/M24qxuOSW0DChrgCmfWfNSR6YuJWIuohZeml3pL6tg4tRwSY78sCMezY4kQw6ZuJARYOGQPF2CS1j6a2sddn5ibNXOF77sqP73UwX5uP1ILfdUzUeg0BSmk10SVvi5x1+8WD+UA2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780583; c=relaxed/simple;
	bh=ZIJKpFQGQCPHu7fdAfsBRhdtWKQgrUyUWFf/KozOkuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAzMSdMLtEcnsJFznGZAk2XQd+E2GjX63dICOdVF1CvQaGc44Gn73gUEephxEvdJ7cJCLbsqO2CYQQHGkHytKJxKFcGjZvSGIEfpxgXC82HPlb92gSDf3Zq8adtOtcPX3BO9vUkA9ZmU+dIJm/rtZ7yVGxOqtNVWHE84vnBSTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCl06w44; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso30600a12.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715780580; x=1716385380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkxNnBQQ3mFrgW9/g1qJOnfkFhqWA5W59jKQj1UZo4I=;
        b=OCl06w44Cf7V+Efllw7c0TnX0TzATPiLOuND7kYr4KEI4Pti/yviYSSMlnDjLy5xyM
         O+9/6eLJhaM8lWw6ELd6bcDfWZ9lgrOmcSo5bB27DM6OakaPMg4EkhOSg4/ccM12yDo0
         Mw50UxnoUPBQKWfp1DEn1QmuhH3xZaTDHSWGSWlJZGZJWu00r24VvrDlQKzfSyAE16+w
         Oqx9XFmu4eRLvO49eE5R3povR4orSdqqVfs6e3LLiwf1MON1oj/J1jWhGT6GbJHMjxL0
         EEKm5k6vmUR3TcvPikTI98jZ1gUeCQ++1YcSuiwoQx7RdvUxws01Kmm/JKbFd6d+HHCC
         /EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715780580; x=1716385380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkxNnBQQ3mFrgW9/g1qJOnfkFhqWA5W59jKQj1UZo4I=;
        b=j5LFsRnECjt1jZuArmYuNiIW75aPNNp4vOF5JNUppMitqkCAfPqlKWh3/JrRvlK75L
         ia9BZMfscwYTd/YY/LCN3sp1EW6Spd66mEetpMzrHU9udQPxyIa0D0xNXq+NmX4rDo4J
         ByHFaSM2lSmHe2AsTOiMkBD+mwWWtGVfxqqdPuniX+Cr5LV1a/34FkmtGXI5HXHQw3P/
         b7oUh4zgRgXDumTpDJc6YbrA/Zjf2hLBxlNHCsXNqrqLMo9hkc30rsCWV1H/1OGXR+g8
         SVZ+xtei9tHjXPdDxi/mP9QRUDRIU+4lZQ3Y6TvPsdqWNU8V71yi/thMS4aeBTOPgAap
         g6dw==
X-Forwarded-Encrypted: i=1; AJvYcCUcFa3KU99ZZv/8mpSYHXH5SHePCaaxIrIQ2yFt0t1Uf5qryP0rPRoH7Hcht8KS5eT9PTTz1RudrjisSFZkhJXE7BNEkc/n
X-Gm-Message-State: AOJu0Yz0OgOg4K/ui+Y2BKTZl0VWo4QwFEc+bpWJosrdmYdTyrWpvEk8
	Ig1avxD8ppcaXfSHRER1Y9yJApDdq4HLQRFdtOvfuTKei9Be+N3amhTmad0FZ4QxMLE7FckVupD
	v9N9ce7zfljHBxI8OZDXjtMpM2UAbeM1xb29x
X-Google-Smtp-Source: AGHT+IEPfVfO/DzSdvtd+0FM07L/3SVSFUKP/ahjrK4mH8em8O1KyW5dFmo/QjtOBFIZlWni20KUTxnbzlX+8pcgvHQ=
X-Received: by 2002:a50:cac7:0:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-57443d4db9amr725860a12.4.1715780579806; Wed, 15 May 2024
 06:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515132339.3346267-1-edumazet@google.com> <20240515132738.GD13678@breakpoint.cc>
 <CANn89iJUMN6VOkhLi__EH2VxMF1XatEn2x-n=0tLQ1+Bk3u+GQ@mail.gmail.com>
In-Reply-To: <CANn89iJUMN6VOkhLi__EH2VxMF1XatEn2x-n=0tLQ1+Bk3u+GQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 15:42:47 +0200
Message-ID: <CANn89iLA=SfNB6c65FG2DCD90NZLdzPBcA2a0VDhx+vsnXKnww@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nfnetlink_queue: acquire rcu_read_lock()
 in instance_destroy_rcu()
To: Florian Westphal <fw@strlen.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 15, 2024 at 3:27=E2=80=AFPM Florian Westphal <fw@strlen.de> w=
rote:
> >
> > Eric Dumazet <edumazet@google.com> wrote:
> > > diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlin=
k_queue.c
> > > index 00f4bd21c59b419e96794127693c21ccb05e45b0..f1c31757e4969e8f975c7=
a1ebbc3b96148ec9724 100644
> > > --- a/net/netfilter/nfnetlink_queue.c
> > > +++ b/net/netfilter/nfnetlink_queue.c
> > > @@ -169,7 +169,9 @@ instance_destroy_rcu(struct rcu_head *head)
> > >       struct nfqnl_instance *inst =3D container_of(head, struct nfqnl=
_instance,
> > >                                                  rcu);
> > >
> > > +     rcu_read_lock();
> > >       nfqnl_flush(inst, NULL, 0);
> > > +     rcu_read_unlock();
> >
> > That works too.  I sent a different patch for the same issue yesterday:
> >
> > https://patchwork.ozlabs.org/project/netfilter-devel/patch/202405141031=
33.2784-1-fw@strlen.de/
> >
> > If you prefer Erics patch thats absolutely fine with me, I'll rebase in
> > that case to keep the selftest around.
>
> I missed your patch, otherwise I would have done nothing ;)
>
> I saw the recent changes about nf_reinject() and tried to have a patch
> that would be easily backported without conflicts.
>
> Do you think the splat is caused by recent changes, or is it simply
> syzbot getting smarter ?

(It took me a fair amount of time to find a Fixes: tag, this is why I am as=
king)

