Return-Path: <netdev+bounces-203465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12BBAF5FC2
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D37D1C223D8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE5301137;
	Wed,  2 Jul 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1HsILuO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F977301149
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476677; cv=none; b=G4OVvJWEK2N85fdxlllMBVv2vcncdYvJc1s3h5hlb3SjYYR5E0lvoOVFBeQTET8plbUgoVkhPCUgoO41aIiAPc0peWJRfjegRnFiSRdoKvGD4tAkfvXPs1z9gZPDR75MDZcpHidzj6DbKdgrtFz6lk+lBjk7GnXRXcZleepiJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476677; c=relaxed/simple;
	bh=zjPZQvEuksLWsT5fzIb91sYDRjIA4s23g8GcBkH6H8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ7Fyo99EY3NGmBpr+PrphtGtMxG35BcWWnJyrtZGqvaFrXJ7wfAxzSr+CQQ3QMNgbE9RQEAzt9sHL+pbqiNm9sPwc4oetWdqlkpM07N6Do96oOnj0Ir5DNaZuyfbysuubosdv2r5UdFqfAZYzPKHVLC+a2P7QJebPcXdmi1RFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1HsILuO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e81d37a7so5069845b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751476675; x=1752081475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya4xGxAxjtVfMTDSjjIOyrgySWGHrrhl3718AqnJSqE=;
        b=J1HsILuOk52utTfFGtKNl7PRi4xZhg04Wq+8N1l1Qu4EvRzqKoCbufbLlPOTGDAmN9
         udk8RRYz85Iv0cWrw4x5ijCzoJxvO4XudgP0SsOWZCR/8fnmfs1Y7sEt2WyGeYEOO2k5
         xWh1q6fui4Ym+FuO+koV/jqgq84a0adSLSaJAsPrapWNKv1AKbdNYNxQL6dytvWPzUQI
         vAbOOeho2/9r1GutGMCiVpffKGpiJlR7KygDSpHqRP2qPv7Wyn30psqr1dnIPVQqiyGD
         f/N4P+ijntJNCk5S4vmA90adofz/8xcqUJzSSFShV+q1a0s3D+aNXaozOzTd/b7vEVGe
         LJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476675; x=1752081475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya4xGxAxjtVfMTDSjjIOyrgySWGHrrhl3718AqnJSqE=;
        b=L4kK0EzVMSnMy6opvNn4VdLzFqJJTmfRYcbFaiTKUo2nlRBugL5QODulee6T/s0HxM
         C8vvPTxwqV89SJC7EMygvhc9RBAHfMyPtPUzY27Nqv6ZjSJbBTRaNXrj6kDoGAQRc8kT
         PKmvNwbDMYFN8vWpLq10OTizaakXNJjfMP3W/lpDhEp45QdUPxe2C5GDGHHMoJgaPK5V
         eq3SNxyi/fmolEr9Fk9bHQZtsRdl5yQcakw4wpo1V911A7kQ36y+iMsTB4fwaXyZxnHo
         8O2vpnVJAJrjJqpg2zcsQumJbwL9SkIV9/AYXIwlXQdgumT+d44/CiCm/J/C3SeK/OcK
         rdyg==
X-Forwarded-Encrypted: i=1; AJvYcCWh9xrY9xHJhccpRbWPfWXRHWAoWGwuCgIsBLAtYCJAg/dQCCIhH0xqvmddieGKbkM3Vb7wRxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cepjKqJvrSW7AM9AEtFDTTaHwfmpfaplOPeMZKM1zUkkoD+o
	/ItLovlVx2oJMJzV1L7af7SPqpK7xmSzI6v14oQgCJWEHj6DEwdm4qGCInshS3EkDIFKfgyjDXW
	G3Djs5i7NbqByUCOsZhUGY+fjfaXixD05OqbuGc2r
X-Gm-Gg: ASbGncvrXroNeqcxQWFiv/qUbKEHDMYUhxCLPSz08HC8/7SLnRKb0QPNkdndMTLx4L9
	2boSccl5X1sZx06LBlCBVGA573Ny8OX3LdeRPk/gbv0B3uPVlUs1OvOaC6lyVWt5DoxV9wI/cpo
	hvUsR3JnAbrFXJXPDWeMK+EkqDpJg33tS1vgtpgMI4VSp9nni9CkXr2a38lmNPsuJerht35JBlc
	N4=
X-Google-Smtp-Source: AGHT+IGmmPSKFCczhqoDpbSMa/8crpukAaWPjbnZ3FzkwSDizenCO4kkDSZGd5PeoW63TymSCeqnkCWRsS6mO+7B9j4=
X-Received: by 2002:a17:90b:3905:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-31a9d57d962mr233671a91.2.1751476675082; Wed, 02 Jul 2025
 10:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702020437.703698-1-kuniyu@google.com> <20250702020437.703698-2-kuniyu@google.com>
 <CANn89iKmA41ERK2VFScyrJ7PNNwqH4VBK9kpzNgxO3oFTRq=mQ@mail.gmail.com>
In-Reply-To: <CANn89iKmA41ERK2VFScyrJ7PNNwqH4VBK9kpzNgxO3oFTRq=mQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Jul 2025 10:17:43 -0700
X-Gm-Features: Ac12FXxpXIAAb0xE3IaTucIz8EKZD8JdAz5qM1UiKJHy1X4M6l1wpbSLPm3vF5A
Message-ID: <CAAVpQUAfTkuqBsad+TcetvbbkidmA9pu0F+TRir==Czd9ZV4gQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] atm: clip: Fix infinite recursive call of clip_push().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:03=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Jul 1, 2025 at 7:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > syzbot reported the splat below. [0]
> >
> > This happens if we call ioctl(ATMARP_MKIP) more than once.
> >
> > During the first call, clip_mkip() sets clip_push() to vcc->push(),
> > and the second call copies it to clip_vcc->old_push().
> >
> > Later, when a NULL skb is passed to clip_push(), it calls
> > clip_vcc->old_push(), triggering the infinite recursion.
> >
> > Let's prevent the second ioctl(ATMARP_MKIP) by checking
> > vcc->user_back, which is allocated by the first call as clip_vcc.
> >
> > Note also that we use lock_sock() to prevent racy calls.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2371d94d248d126c1eb1
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/atm/clip.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/atm/clip.c b/net/atm/clip.c
> > index b234dc3bcb0d..250b3c7f4305 100644
> > --- a/net/atm/clip.c
> > +++ b/net/atm/clip.c
> > @@ -417,6 +417,8 @@ static int clip_mkip(struct atm_vcc *vcc, int timeo=
ut)
> >
> >         if (!vcc->push)
> >                 return -EBADFD;
> > +       if (vcc->user_back)
> > +               return -EINVAL;
> >         clip_vcc =3D kmalloc(sizeof(struct clip_vcc), GFP_KERNEL);
> >         if (!clip_vcc)
> >                 return -ENOMEM;
> > @@ -655,6 +657,7 @@ static int atm_init_atmarp(struct atm_vcc *vcc)
> >  static int clip_ioctl(struct socket *sock, unsigned int cmd, unsigned =
long arg)
> >  {
> >         struct atm_vcc *vcc =3D ATM_SD(sock);
> > +       struct sock *sk =3D sock->sk;
> >         int err =3D 0;
> >
> >         switch (cmd) {
> > @@ -682,7 +685,9 @@ static int clip_ioctl(struct socket *sock, unsigned=
 int cmd, unsigned long arg)
> >                 }
> >                 break;
> >         case ATMARP_MKIP:
> > +               lock_sock(sk);
> >                 err =3D clip_mkip(vcc, arg);
> > +               release_sock(sk);
>
> This will still race with atm_init_atmarp(), which (ab)uses RTNL ?

Ah right.

clip's vcc->user_back is expected to be freed by calling
clip_push() with NULL from vcc_destroy_socket(), but
atm_init_atmarp() sets NULL to ->push, and memory will
be leaked.

I'll add another patch to prevent setting ATMARPD_CTRL
after ATMARP_MKIP.

Thanks!

