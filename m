Return-Path: <netdev+bounces-221569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495CB50E93
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850E91899F7F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D712E0914;
	Wed, 10 Sep 2025 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HBmLqIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C41E3769
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487427; cv=none; b=LqafIaFqQ2OjuEOla+6RT6h2h0t6qVIULRP5pfNxI3WInKY3iRFseoLk9myBlhpxdc4CTnHK+z4hh2kmQOOipdg14feNu90w0ugTtFsflNqmNgucm9u/9/g3CJBZ02n5Hvs6byM0Qu6kXQ0hWxLu0NYmTqLbcsnY3r5LBLB/CaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487427; c=relaxed/simple;
	bh=XkfL6d26GRcixEltWh28WuK/QIxalBC2ohB9mDI4ILo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLc2QKkZi8rKeSn+3je7hruLguRRmpaBpRP2/WbCKaG1bBpIFLwr9itrOaZVhmi1dcx2BedTZnIeuRokfA4A9Ic+fpKJs+GwAtS3XTnq+CvOSNz+Zqj492IaZBA3Uvabop3zEH6ri2dMPcoUBwp5fBUP6O9pwb/JjF6r+5tOVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HBmLqIh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445805aa2eso63408995ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757487425; x=1758092225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puD1TE/RgTZQnY4bw6FuXLXdkx5MZebuWIxeLzksRCQ=;
        b=1HBmLqIhlsQH/fmbIXPGvnlowKY10EGkXSHo0jzqjltePjRuxSi1dLb5cNAzzHy8b7
         k8tUKahasLbBMzsCL0uJeUTWIG1lkMtf/SgVployOBZB6ERnsWsZkvTZnyYMBAwNzREj
         Zuii8avCUjCh69sqEMdrmLTHdqEbiTd6m3yM9hNkqgPRnjSMcPzVZRYwcAiNPcfmC5i8
         RCyDiuIpI9/mxILszUUhBKBzPISZB1fkVfzb6lKayapS1RHgnkONOiPaQrFHjCfOflTL
         D6VyeL94oSvtjXnk0tlOmSl2YezZTmQahQyX9X62jmpEe8lZihDZTEXtuUUsLi+ces9f
         Et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757487425; x=1758092225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puD1TE/RgTZQnY4bw6FuXLXdkx5MZebuWIxeLzksRCQ=;
        b=P/Uu1HrIxsh5Y9fi4NWEOp1cdmwygn6NckxADN+yx+e9ajO2YSjssagd/bMJ/tcusD
         5wczMByX9UewuA/E361B06dtI1RJNzWkaVVtCYnMCDCIH+Oi7w22vNG2u6o72LIeMm3w
         IBOUXx3R74dfIGRi0SQsiqG6uouZg5w7IS7cA/XG1YwOnoeQ9+85ZzcwgJkDiFf6l5Ub
         tCPRE+JA8+ANa11+Lu24C0kz27ZyjsXYUpUFAYMu0qpMYHbGSdsi4itxsutD9dnp//LU
         DaQOG5wHboUrvgu+cwutuyYAjDt+pt7W08DaJPGmW3dv2bpwRo9JPJQ9e7Z2SvhI2WqA
         YDFg==
X-Forwarded-Encrypted: i=1; AJvYcCUN6lQb0zEpTdosHbiaDTd+Q1Zsp4J4Ik/gpYtS82Y/qA7EhuCqPHp8hiyZRJpkFCGL3CaeedQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgaims+XpEkzQipcdMQQL8XRvdzj+O9zIbxMlSaHjuwD8qyNwV
	leH10mUzBkMTJ/FtZ8vAT2TfQJy0zSl1wTidFTbC/86mfHuwJiVXFk8pRo7QownrHdu3ir38kY1
	fkRSzQeqhTiMUMAnb4hja66d44C7E71XbbyfTvPye
X-Gm-Gg: ASbGnctKbE2GYNOOi2XOyJaAePPHzbBql4dEdohiym/sp9FbGsToj0FbeYrZl64pJgp
	kheeHBA2lFSws55kEwf2kk45oqQxdCycwSRada1z9UXzv6oNd0Qu0VTz211pyKGXrlD344PBK+0
	El1A0tFWpR60nwRLq0PskwazQtmrJfNZEugxxSu+Z6UOLAXiGJKLj+2IMIUEoe/d5GuWj2UJlJr
	dTxdZglZDr/GSWqgG7VN3Kp9FuIIx97Qcm6F7IvlWTLaXQ=
X-Google-Smtp-Source: AGHT+IEMftrHjw5YOZ9yXt3768ya1wIi7X1CjNPJm8ZS33uJQG3R56Og+bzHYVGtSfGjKqtBv8brGrO/cvmOEEIyJUQ=
X-Received: by 2002:a17:902:e801:b0:24c:9c5c:3096 with SMTP id
 d9443c01a7336-25174c1cf26mr177648245ad.48.1757487425144; Tue, 09 Sep 2025
 23:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909232623.4151337-1-kuniyu@google.com> <a29689e0-cabc-4fdb-a030-443f0ccfb468@linux.dev>
In-Reply-To: <a29689e0-cabc-4fdb-a030-443f0ccfb468@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 9 Sep 2025 23:56:53 -0700
X-Gm-Features: Ac12FXzRJjDYcU3YwWkBlBmRCjJa2jeB0pN4hbqXsRkQKANtBfrKnRdCjd3cWMk
Message-ID: <CAAVpQUDeaiGUdxGQHSMRU3=zwJy7a0hMWXjoRkfdYPqaZLU09Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] tcp_bpf: Call sk_msg_free() when
 tcp_bpf_send_verdict() fails to allocate psock->cork.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:15=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/9/25 4:26 PM, Kuniyuki Iwashima wrote:
> > syzbot reported the splat below. [0]
> >
> > The repro does the following:
> >
> >    1. Load a sk_msg prog that calls bpf_msg_cork_bytes(msg, cork_bytes)
> >    2. Attach the prog to a SOCKMAP
> >    3. Add a socket to the SOCKMAP
> >    4. Activate fault injection
> >    5. Send data less than cork_bytes
> >
> > At 5., the data is carried over to the next sendmsg() as it is
> > smaller than the cork_bytes specified by bpf_msg_cork_bytes().
> >
> > Then, tcp_bpf_send_verdict() tries to allocate psock->cork to hold
> > the data, but this fails silently due to fault injection + __GFP_NOWARN=
.
> >
> > If the allocation fails, we need to revert the sk->sk_forward_alloc
> > change done by sk_msg_alloc().
> >
> > Let's call sk_msg_free() when tcp_bpf_send_verdict fails to allocate
> > psock->cork.
> >
> > [0]:
> > WARNING: net/ipv4/af_inet.c:156 at inet_sock_destruct+0x623/0x730 net/i=
pv4/af_inet.c:156, CPU#1: syz-executor/5983
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 5983 Comm: syz-executor Not tainted syzkaller #0 PRE=
EMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/12/2025
> > RIP: 0010:inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156
> > Code: 0f 0b 90 e9 62 fe ff ff e8 7a db b5 f7 90 0f 0b 90 e9 95 fe ff ff=
 e8 6c db b5 f7 90 0f 0b 90 e9 bb fe ff ff e8 5e db b5 f7 90 <0f> 0b 90 e9 =
e1 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9f fc
> > RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
> > RAX: ffffffff8a09d0b2 RBX: dffffc0000000000 RCX: ffff888024a23c80
> > RDX: 0000000000000100 RSI: 0000000000000fff RDI: 0000000000000000
> > RBP: 0000000000000fff R08: ffff88807e07c627 R09: 1ffff1100fc0f8c4
> > R10: dffffc0000000000 R11: ffffed100fc0f8c5 R12: ffff88807e07c380
> > R13: dffffc0000000000 R14: ffff88807e07c60c R15: 1ffff1100fc0f872
> > FS:  00005555604c4500(0000) GS:ffff888125af1000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005555604df5c8 CR3: 0000000032b06000 CR4: 00000000003526f0
> > Call Trace:
> >   <IRQ>
> >   __sk_destruct+0x86/0x660 net/core/sock.c:2339
> >   rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> >   rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
> >   handle_softirqs+0x286/0x870 kernel/softirq.c:579
> >   __do_softirq kernel/softirq.c:613 [inline]
> >   invoke_softirq kernel/softirq.c:453 [inline]
> >   __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
> >   irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
> >   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [i=
nline]
> >   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:105=
2
> >   </IRQ>
> >
> > Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor s=
ocket TX/RX data")
> > Reported-by: syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/68c0b6b5.050a0220.3c6139.0013.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >   net/ipv4/tcp_bpf.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index ba581785adb4..ee6a371e65a4 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -408,8 +408,10 @@ static int tcp_bpf_send_verdict(struct sock *sk, s=
truct sk_psock *psock,
> >               if (!psock->cork) {
> >                       psock->cork =3D kzalloc(sizeof(*psock->cork),
> >                                             GFP_ATOMIC | __GFP_NOWARN);
> > -                     if (!psock->cork)
> > +                     if (!psock->cork) {
> > +                             sk_msg_free(sk, msg);
>
> Nothing has been corked yet, does it need to update the "*copied":
>
>                                 *copied -=3D sk_msg_free(sk, msg);

Oh exactly, or simply *copied =3D 0 ?


>
>
> >                               return -ENOMEM;
> > +                     }
> >               }
> >               memcpy(psock->cork, msg, sizeof(*msg));
> >               return 0;
>
>

