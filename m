Return-Path: <netdev+bounces-123077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F479639BD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C967285612
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F81474B7;
	Thu, 29 Aug 2024 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EGPA3Yv+";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="dIQlg0xW"
X-Original-To: netdev@vger.kernel.org
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BF4CB36
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907961; cv=none; b=Lyejr0YbpPzPzDWheshsBFWOLrMYeDknn5tfoMp7dy2bwaRLzmsR3DO6pZ4OxyRGXUzJTeJ5IKcnLtsRr1eytK2oeh8bDQsGVyvlYBpYHmeG9MO79a354n/n9MGXq6E9tBb5lpAaBjElGcsZzkmIRrwUogBS295N7NY5lRIU0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907961; c=relaxed/simple;
	bh=fkVTBjI5EVgKxds8nwBxCOXVtcVkum/SwZEVDIO7pBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFpdho4fbIFoyg//W0ohv4Brf1borYTCnvPw3b2hX0IcsLA0sFJNO4wwSu5AlCoiKTx4nfsmfG/Urc1NlGMtmYDVqB/6epdnFLkehpNhFQIxoy3034BUiFH/2/HyZk3Cygczz9pJJFj0oGFcQV4mMyeA0HdbRZ8SGbZOlLTB+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=EGPA3Yv+; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=dIQlg0xW; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724907961; x=1756443961;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=fkVTBjI5EVgKxds8nwBxCOXVtcVkum/SwZEVDIO7pBQ=;
  b=EGPA3Yv+2VVrxGBASicBGVaZG7apF7GytAmoLwH5gi8IPklCWfORZFxl
   27ew14ojbQfTab8uanM8izo2R4uBI9+4WzAGU/nokjh2j4ASVKgEPiQ9L
   k5sP0RIePsaCwd64v/S8bYPkrR6LkdC9mbp9LYhkSrVxcZ+7nRrnyRGvz
   b0xlSkQAM6o4jK0nS1sKTcbYg3FGIcOHkqT7EVS0Rhlcax7x7RSGqhPCd
   DVm3To53RBU94JIw6LVCeK0Nrs7ilnDzogC8BKYtb6waKrkV0Xi+VSr2G
   izN/vl73J7DaZFpQWV24GhAOKlgghkDT5npabZsbKXkFtRCsfW4sAfTuw
   g==;
X-CSE-ConnectionGUID: gPILidQ1SbOvdbuLJqKirA==
X-CSE-MsgGUID: LNqp3po1RLCQ9r70l5K98g==
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 22:05:57 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d28a70743so2328125ab.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724907956; x=1725512756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7ki0XIr5uUI/th5K3r1sL32gxrfAdrUZKeYyqBGFEY=;
        b=dIQlg0xWxmSmOCrBEklKuC6nY67pEU1ODWtnml3iZgC2na2os4vTu3oe1npI1oZoDy
         2tuNRhizutLATDxkT6tBZ7if4DRgKejUbIDZm+PxjCJg7MvuqIv1V/Wx3KhlYZ749yoB
         tpZucRBnTb+xwi3wQdU7Jfl94W3fTTnd60ptQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724907956; x=1725512756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7ki0XIr5uUI/th5K3r1sL32gxrfAdrUZKeYyqBGFEY=;
        b=IMnrPuzP3Im8HZ06qNeua1D5a2bw1dKeUM97/5Y4ixHMgnJou2Q62FgKxzUPG/7FoS
         MoGw9SNpWJWByQpXR1geN27bUZ8o6at87YoU3liwAsE0T5bAM/KcwnJVntk3RjUyFoci
         SCaahvl/LkJgZv3LDA2u1pAJleNXSlyqjBkO0YlpRaR/wswhiB3nuT68deUrtegrBgLZ
         F5Lt/dMBwy6X2ExNNJMzOM1101SrQLuOSiu4nde3IN0C4RRc7ac57E1ChAd88txlGUHn
         cAcOI8fUsUDUHaT5QK6StfeIgy2jWshn1sDTD7xArEO6OQk2HZJ1vLid9y9lFC6QAwLP
         ZurA==
X-Forwarded-Encrypted: i=1; AJvYcCUI/k84e1qKb/burjW7ORcZ1uqzY9mcS4KvJpJEuD2M+mDnCmLvYzJ8jPB53pbwNwqVKEEXN8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgD1oXys79GEcPyGbmcpTAFI3ZDpVyRhrYt0MrHCCrb6R8e5PR
	L8J9LOu0U4wb2lodf6ord9r/1hLjn4aICtSnyF3kTYRyqPAOyU4sHI8BM03yuZFJsLghIzP4pa2
	hkSGNtBBY25rKlXdj6g4BxnL6vztlqogZN0oTcaQRAgfAtkFIb8n5D1lykWgmMSHkj8ZuR1xfzp
	WS+oNOavUvjmmbiNs18jdMRB3hFL94yQ==
X-Received: by 2002:a05:6e02:17c9:b0:39b:3244:a355 with SMTP id e9e14a558f8ab-39f3b34f798mr3015795ab.11.1724907955867;
        Wed, 28 Aug 2024 22:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGEvO4eezMVg0uNVGJlLVxBnnO1du+5nNXST5ApK/OVJk/QNq4p1HfqSwlNw58ZPdwRdsVb/jgqZOudbhdt7k=
X-Received: by 2002:a05:6e02:17c9:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39f3b34f798mr3015695ab.11.1724907955466; Wed, 28 Aug 2024
 22:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-41QZdm=Sj2N4QyYyeNY1EMq6DKY+q7647-53ysZEs8ZQ@mail.gmail.com>
 <20240829011805.92574-1-kuniyu@amazon.com>
In-Reply-To: <20240829011805.92574-1-kuniyu@amazon.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 22:05:45 -0700
Message-ID: <CALAgD-68WWDvqrVL0XgjAWuc8K5Wi+3y_cst25Tjsq+qoUW9CA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in sock_def_readable
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, gouhao@uniontech.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, quic_abchauha@quicinc.com, willemb@google.com, 
	wuyun.abel@bytedance.com, yhao016@ucr.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would ask you to stop sending these reports, we already have syzbot
with a more complete infrastructure.

Sorry for it. Previously, I did not notice such rules to report bugs.
Later, I will only report bugs with reproducer or with a patch.
Also, the bugs that I reported are fuzzed using the syzkaller templates
that we generated, but not those from the syzkaller official
templates. We want to find bugs that do not have the corresponding
official syzkaller template.
I also checked to make sure that the bugs I reported did not occur on syzbo=
t.


On Wed, Aug 28, 2024 at 6:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xingyu Li <xli399@ucr.edu>
> Date: Wed, 28 Aug 2024 16:38:59 -0700
> > Hi,
> >
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a null
> > pointer dereference  bug.
> > The bug report is as follows, but unfortunately there is no generated
> > syzkaller reproducer.
>
> quoting Eric's words:
>
> ---8<---
> I would ask you to stop sending these reports, we already have syzbot
> with a more complete infrastructure.
> ---8<---
> https://lore.kernel.org/netdev/CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA=3D=3DEVh+=
O74VHGDBNqUoA@mail.gmail.com/
>
> (unless you have a repro that syzbot doesn't have or you are confident
>  that this is true positive)
>
>
> >
> > Bug report:
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > #PF: supervisor instruction fetch in kernel mode
> > #PF: error_code(0x0010) - not-present page
> > PGD 0 P4D 0
> > Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:0x0
> > Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > RSP: 0018:ffffc90000006af8 EFLAGS: 00010046
> > RAX: 1ffff92001572f0a RBX: 0000000000000000 RCX: 00000000000000c3
> > RDX: 0000000000000010 RSI: 0000000000000001 RDI: ffffc9000ab97840
> > RBP: 0000000000000001 R08: 0000000000000003 R09: fffff52000000d3c
> > R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc9000ab97850
> > R13: 0000000000000000 R14: ffffc9000ab97840 R15: ffff88802dfb3680
> > FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffffffffffd6 CR3: 000000000d932000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <IRQ>
> >  __wake_up_common kernel/sched/wait.c:89 [inline]
> >  __wake_up_common_lock+0x134/0x1e0 kernel/sched/wait.c:106
> >  sock_def_readable+0x167/0x380 net/core/sock.c:3353
>
> This seems to be caused due to memory corruption.
> skwq_has_sleeper() has NULL check.
>
> Recently I saw some reports similar to what you posted and that seem
> unlikely to happen without such an issue in another place.



--
Yours sincerely,
Xingyu

