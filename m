Return-Path: <netdev+bounces-244188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED09CB1F34
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 06:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207BA3055BAA
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 05:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E41122A4F6;
	Wed, 10 Dec 2025 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xM0zdLXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39134A07
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765343890; cv=none; b=hC8e1UI49NYeUznjftaJG99yRyF56hoyJI+C/aWrXXbvGF6JEhTK29qQd0hbastATgQ/6gcGAVcvlYbNKPXk15f3p9ivqUe5d/T0oCq85ga8o6rDi08P3VLK+KRmdSLoTlQSoK0ocBHScz+a9MASL1+2YjDBsuJ6yYHvUFgM+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765343890; c=relaxed/simple;
	bh=Fr9/Tg2H0J7BKVc9x9/0nUVz4HTchB2NyGYmFsde/GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0Fhpi1/K1mwOpSZrmoyPHaeE/Ui6cuMEw4MDqtatNYv+JuztbLb89mSmJwlO+XOohFMAjwJ7i9FZfKMw9Ut6b8ybDdLSTDPD9M+2qn0xIDbCsYCjutF4RmHQllThmiS7/7NCYtfi8QfHhhD0nUKEz2L0CW28epAvz9LZlymRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xM0zdLXB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29586626fbeso73910475ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 21:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765343888; x=1765948688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l95VrpmsyH9Fw1Ar/sOgKq5aO4la4d+nt5vFeN5mlUA=;
        b=xM0zdLXBvL27bJB00d5r9zbQmXTuNOb7cIXluq6gaFdnUdVNXfnzNHycXQV/P88VVB
         IIrZtXYkwVOaneOBsYRgsRCdNy2mMUJ5alhYg9yTZyOWU4hxjEcvoFWG2fH2n83WeXWk
         /BpPiZDypnQ1Xzvq/o/X3Ifq7oCpKm04206K0qyM52a8tS/pX78Khup2DGVXjO4Q8Kig
         Z9MvHnV5OiiNRBhaPlbp50lpY/GiVybRgU8kYzDGSMWm2JvONqQxSJi8g1qJyvo4L9wo
         DFtNLmqCGhAR7FmewU2w2qvSS5T7Vgl4SESu2ftQpdI8SKglyXWPYH0BfR+jQbqBa6sL
         IzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765343888; x=1765948688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l95VrpmsyH9Fw1Ar/sOgKq5aO4la4d+nt5vFeN5mlUA=;
        b=dbENOvHgbfqekGxSAimLMpwNUrof2g12jHSAaScbd5yTu3sPLsH0FEVl5732LexMIO
         ndsc4YFX7X8ftOZC7s5LiPjtInXKakVgCImjovevpzPbYztQQThLTSkjgnliosAyxffP
         GJ+RWDCqCt4YUrnx99W6tved/pQVE8xwLeCXn9ZMQfQY2iH45RHNck5D++1legKyWkF+
         luujW9J1jMrI0OhaYAPcFo/K9DGIfv57gV7TTq3JH104duPfOvkf/f5o1Sru59Y54jak
         x4tBdEixDBp9cmCnj5SKM12Hszq+selGDov+WofFLoYh/qDkCI6/7Y/Us5rt4OhVZycd
         0g8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpxJI0meHNTU5Ba0AhmxBu9NIwHKPneUC23V4NQbUnY8DoxMz9l4A2MHJWTCCC0fIxfp+sZJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqNQNfCz/3TYLE/YrFLPm52DO0LtvtzZoVgIyIji5oyqd0gSd
	2emxh2TCfkBzA3J0ivurPSP7+B6bWo2SJzPPjGex5qIf4ovmZQCXtH+GNnqfOud63ADgNmL/dXW
	j+IxpUX3WEkg/7hACL6VTn+PFaBRw+xxgN2+RG3x5
X-Gm-Gg: ASbGnctUiZYsonfrmNdRNPu3kgEBYwGrez5M7rwo2BDa2ziqvDAmu+D37sGmd2UUM5O
	NyxFKj1EDeyImGc6PMW5rf3NaeEN7WYAaoxWGuKuADDIiqxUypOamWQX2s5X1qnKi+FQ3jfapI9
	6ro7e+hHmjGEBGi/2xGw3wYHbZH3DR/EFxMAbDXMErWRtSaH3PH+1/deVsXQjEjf+Q65u0DCIFd
	z3qPP7r2K72UQM/gE1VmOnvtLibw/Jz1qq13MOa2f8ybcxByIhN6JpemzDZcddPYMZ0GHfppEdT
	uD+l2IKFs8E8EJwV+vr3O03cTDE=
X-Google-Smtp-Source: AGHT+IEaxjzg+KXDV/IHI1ZlVpQaMxFIDGhDkHw2B4zjC15HR/lVuiFPWnRIbfN83lrRIVexgcedoQkg+FiZGfaCBfA=
X-Received: by 2002:a05:7022:2224:b0:119:e56b:9596 with SMTP id
 a92af1059eb24-11f296cdbd8mr839128c88.27.1765343887418; Tue, 09 Dec 2025
 21:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208133728.157648-1-kuniyu@google.com> <20251208133728.157648-3-kuniyu@google.com>
 <CADvbK_dEk5a1M0tO8MULiBMwcyYV99zVCdhNC+mfOkv=RQauHA@mail.gmail.com> <CAAVpQUDH711WYOn68SCJDzNO+d0L19erDBQrXg4tb3_JBwA-iA@mail.gmail.com>
In-Reply-To: <CAAVpQUDH711WYOn68SCJDzNO+d0L19erDBQrXg4tb3_JBwA-iA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 9 Dec 2025 21:17:56 -0800
X-Gm-Features: AQt7F2rtgg749YLITogsyUs_a29C6MdGsnCf4u4vefqzXxDuvXJWcdJrjZoOgXY
Message-ID: <CAAVpQUBN4FfBpeBs7S=xL2sXsTLhPTcscHGyAtkjrNyceibjMQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] sctp: Clear pktoptions and rxpmtu in sctp_v6_copy_ip_options().
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 8:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Tue, Dec 9, 2025 at 2:26=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
> >
> > On Mon, Dec 8, 2025 at 8:37=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > syzbot reported the splat below. [0]
> > >
> > > Since the cited commit, the child socket inherits all fields
> > > of its parent socket unless explicitly cleared.
> > >
> > > sctp_v6_copy_ip_options() only clones np->opt.
> > >
> > > So, leaving pktoptions and rxpmtu results in double-free.
> > >
> > > Let's clear the two fields in sctp_v6_copy_ip_options().
> > >
> > Hi Kuniyuki,
> >
> > The call trace below seems all about ipv4 options, could you explain a =
bit more?
> >
>
> Oh sorry, when I drafted a patch a month ago, I cleared
> newinet->inet_opt instead, and I found other IPv6 options
> could have the same issue.
>
> https://syzkaller.appspot.com/text?tag=3DPatch&x=3D16e930b4580000
>
> I'll add inet_opt patch with this stacktrace and separate IPv6
> change.

sctp didn't support both pktoptions and rxpmtu.  I'll drop
the change.

