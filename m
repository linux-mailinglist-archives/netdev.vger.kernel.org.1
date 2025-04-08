Return-Path: <netdev+bounces-180474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693DA816B3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00593B8D7B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F21253B75;
	Tue,  8 Apr 2025 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTdQvuDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E224DFFB
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143395; cv=none; b=ekdNfXh38o2CXmY8LaNSLqQDhjMIOuXBt3RZUCuE+/gXwUX62oDsl9/sHsjl8PFWXKflnitEPszKyb9sFCcOCKsJemblhDJMnp+BYgzIYgR04yO0ko+1JaGemapU1uLpxnDQai4DNaBZsjErW2TCH8VOGZSXXsbNnosWumrQqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143395; c=relaxed/simple;
	bh=+Otf9WjrrPKgfg6yGiXwo0l1zq0oKhjye6gLTZS6yvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mouDJs6TsFQpv2BXgExs2CKwzLXyiAeqQuu3qnDASxMudFJ8BqPcSWfwqr3ZGBVdwNR7yh3T7MRUPDWGXsU48qe84/wk0ql7EBhzODFtSA3kXMOEjo3fFsmgBHq17O4wC578zfSm/y2ysi4A9inOAJH4yjehTv3hIoNCI9nLfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTdQvuDK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af59c920d32so4281808a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744143392; x=1744748192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mehwUiVlz7/z5KHfhV+Q1AQQejmAf7B/NmHE2o7479g=;
        b=bTdQvuDKzEOTNigjdl43O4VVLPxHsZROSIYkYX8YcyxI7yDFoYxoomuluH8SOotlGr
         UARyog2wi1y0/eVfQTQ09vGGrrQgo2ysmQly4rrbZrHUkiNqi2UX+9E1S2YtahotA8Fp
         q+HM+ONx3X8hyTi5MQhCU+KvNEjkEZeZHPmew7uIqfJteN7GKRl1HTB/9eBog0nuTjc0
         OCjUMRF69hplpUI68bCKqPXa0K4qI52lBg8IXAYndUBb0wTrr6M+nd1mcLPcmAbrnhz/
         Ugs+GOn0r0392mVd/AESzaGXmU0yODtNc4fY5OESdKZBGnSV9dFRYmXy8ZTeYM2OhxSd
         MtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744143392; x=1744748192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mehwUiVlz7/z5KHfhV+Q1AQQejmAf7B/NmHE2o7479g=;
        b=uVYL10GPV70Ne/L9Xl8QOMPeIhOiziJJgXfq4ZvFVUJMNdpjrttFgHTBGIXs9TGFwG
         HJOLPXwPVODAlLJrnrXqhlefWsG77em4crtlO/yYqOH16ZzPu88vtGV7TA8r1QoL4J03
         KCsao5Nu5mN15vofD7wU3saXqNPOQnOWBVv/XCDpX/YcFi63zvAOs8Yl9HsUGG/aW9Th
         yyJit0n3D0zpuM/JVwhYJcG2h6Jqt8Ve8gOfxRPrOx4PSgreqK5N26ekjYty6+8c8DdX
         8LJVCx+cbxDcJjCH8gm7kByAmeCbcbBg5HH1v+0ncGtpDnv5ljV6sMCofB7HvEwLKthk
         IviQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZOVyyGUD3jQfcZyRYXerpHec9ZRLC2L2GgJ5SbXR6Koxnx9OXhlYFvbS+oi0IRGSbs17nuRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwr2DnELjreYobHivA7NqIzA4n490URngFtFv4tCjNTf1hQpk+
	ioc1da4CHBL8lSw/eb1vJHvmuP4bjXiRhHBOmErSVUsXah9rxhUApXJm39TKbmnWw5b4qf0skeA
	XCsUPPvjUKbokBdgfibGyZeX2YkGp7ai2l4X3
X-Gm-Gg: ASbGncuzc5nNtVMhUpy421GnpPn2B9ucIvUHMFaT3xihWnpMsgB8v4OWNQU5QFUgnXX
	MZwUoPEH1DZ/1BCWb9VCkOuEGH9PKnJDeV82iuxliqV+tJ0QMJP22Ae6Dx2sBe3P/nwiLmypm6C
	cgkc8NzL7JDGJTJ6xPgIn9zP36YEDtVS/psiAUWDQniDFOEOiuTb9i81H07u3bzUj0NHxMnA==
X-Google-Smtp-Source: AGHT+IGtGWb6eUUkWxY8GmMQBNcnqZvHvFajRSqQv+lShjf9d+63mfLe+tk4nhM5dqhBVZdhJLi8weQ9qbY2tJuGVlA=
X-Received: by 2002:a17:90b:2590:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-306dbc3aeecmr798843a91.33.1744143392218; Tue, 08 Apr 2025
 13:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_PfCosPB7GS4DJl@mini-arch> <20250407161308.19286-1-kuniyu@amazon.com>
 <CANp29Y5RjJD3FK8zciRL92f0+tXEaZ=DbzSF3JrnVRGyDmag2A@mail.gmail.com>
 <CACT4Y+acJ-D6TiynzWef4vAwTNhCNAgey=RmfZHEXDJVrPxDCg@mail.gmail.com> <CANn89iK=SrbwSN20nKY5y71huhsabLEdX=OGsdqwMPZOmNW8Gw@mail.gmail.com>
In-Reply-To: <CANn89iK=SrbwSN20nKY5y71huhsabLEdX=OGsdqwMPZOmNW8Gw@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 8 Apr 2025 22:16:19 +0200
X-Gm-Features: ATxdqUHZ4TqwrSVVIkJror92e58_nqzO6Pz7ZoMxbuIXg9lHE1m-GgA4mZ4g9FM
Message-ID: <CANp29Y5cTga9UrkySy6GiOco+nOHuDnFOWSb5PF-P0i6hU+hnA@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
To: Eric Dumazet <edumazet@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, stfomichev@gmail.com, 
	andrew@lunn.ch, davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Apr 8, 2025 at 12:44=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com=
> wrote:
> >
> > On Tue, 8 Apr 2025 at 10:11, Aleksandr Nogikh <nogikh@google.com> wrote=
:
> > >
> > > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM 'Kuniyuki Iwashima' via syzkal=
ler-bugs
> > > <syzkaller-bugs@googlegroups.com> wrote:
> > > >
> > > > From: Stanislav Fomichev <stfomichev@gmail.com>
> > > > Date: Mon, 7 Apr 2025 07:19:54 -0700
> > > > > On 04/07, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot has tested the proposed patch but the reproducer is stil=
l triggering an issue:
> > > > > > unregister_netdevice: waiting for DEV to become free
> > > > > >
> > > > > > unregister_netdevice: waiting for batadv0 to become free. Usage=
 count =3D 3
> > > > >
> > > > > So it does fix the lock unbalance issue, but now there is a hang?
> > > >
> > > > I think this is an orthogonal issue.
> > > >
> > > > I saw this in another report as well.
> > > > https://lore.kernel.org/netdev/67f208ea.050a0220.0a13.025b.GAE@goog=
le.com/
> > > >
> > > > syzbot may want to find a better way to filter this kind of noise.
> > > >
> > >
> > > Syzbot treats this message as a problem worthy of reporting since a
> > > long time (Cc'd Dmitry who may remember the context):
> > > https://github.com/google/syzkaller/commit/7a67784ca8bdc3b26cce2f0ec9=
a40d2dd9ec9396
> > >
> > > Since v6.15-rc1, we do observe it happen at least 10x more often than
> > > before, both during fuzzing and while processing #syz test commands:
> > > https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
> >
> > IIUC this error means a leaked reference count on a device, and the
> > device and everything it references leaked forever + a kernel thread
> > looping forever. This does not look like noise.
> >
> > Eric, should know more. Eric fixed a bunch of these bugs and added a
> > ref count tracker to devices to provide better diagnostics. For some
> > reason I don't see the reftracker output in the console output, but
> > CONFIG_NET_DEV_REFCNT_TRACKER=3Dy is enabled in the config.
>
> I think that Kuniyuki patch was fixing the original syzbot report.
>
> After fixing this trivial bug, another bug showed up,
> and this second bug triggered "syzbot may want to find a better way to
> filter this kind of noise." comment.

FWIW I've just bisected the recent spike in "unregister_netdevice:
waiting for batadv0 to become free" and git bisect pointed to:

00b35530811f2aa3d7ceec2dbada80861c7632a8
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Feb 6 14:04:22 2025 +0000

    batman-adv: adopt netdev_hold() / netdev_put()

    Add a device tracker to struct batadv_hard_iface to help
    debugging of network device refcount imbalances.


Eric, could you please have a look?

>
>
> -ETOOMANYBUGS.

