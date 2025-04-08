Return-Path: <netdev+bounces-180186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F393AA8012B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E421896FE1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E726981A;
	Tue,  8 Apr 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLDvz2n4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA1267F4F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112011; cv=none; b=Grbj2R5sGMnzLl0XYfNL/5tpZKibIKqY17tIKqoo42CgV6hZeBWFPkOSqOlwdU3Lenpjbvqevm3AkPgWgUOVqMmNqzBMBl8KohYw6hbdWti/eofpEA06Oa31pvq8mnxcJDyQHb91AB0cVzTGvlbHy6DY6nPsM5/sXdJMo+fxNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112011; c=relaxed/simple;
	bh=pmfB746tZY3x2MSY89UXFLrQP4OguQ2wCGg19gP8NwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifTJZ1yA65HcLJDjfo0qxMcfjWzMBcZoKNhIpwZQcgt2ftjW9/xsA2JWKn3X0CrWzRwjpc8VNJLN4RSPJ7MTRATqERF4R7oNsM9lU9v0ertYJU4wNFckAfBhAV6yQGX72nrwagHIdWOLwTPUXCiNuQ1MkjKUo0fcpnM9H9enqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLDvz2n4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4774193fdffso79380481cf.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744112009; x=1744716809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmfB746tZY3x2MSY89UXFLrQP4OguQ2wCGg19gP8NwI=;
        b=hLDvz2n4zncsyxwlCeaOot9ouJzADOC+pPLGg14xoZnYiiBN8dnMPxG1pvcNCzQvVT
         EBNrRvWSAjvx2EoWR79cnWtUPLFL2hJMVXbzlxt5xRkby01eE+07QPUfdahH48Uhfrfy
         O/TPDaVpGlvR0ihm75KXzzHk6/DlfHrZgZCfYdjnfjqHNUXcdozqLuAfsdbjMFxHkyrK
         nN5ASQXejQwq5VkKit1c6IYpfiaPqLhw4R/opDzDtg0cg5k713HV+Ogz+DVELURnZ4o0
         0UKsd6a7LqkfvvcgacM4/0pLOZ4Y1kMow8ZJRAyuohq5y8Mvr/gzG8upCJAhkw1AXkoL
         HtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112009; x=1744716809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmfB746tZY3x2MSY89UXFLrQP4OguQ2wCGg19gP8NwI=;
        b=UxtrzMFKFTCJRJN2AKur7dVRVlcvfgB9VzVOdG0xJQxDNqLUi6HYHthkAx05HVfnEo
         Od8xN1ezoILQ3axtBgwfh1Je86gbgNrLIHWJ0JL0CV5gfldz5n4cQfxX2jkTCSE+BXM1
         cbcFmo8/yaMNKbBqgW4QPDCaAKgQLJEHpFCiSJDVizDYMowTVQxH+gkg+y6qYfYVxUPm
         550JbKXLVE7+xvmzuZsRI9Q1khU6Lbyi9zv32CZlv/bSFkiMEpYQcZv4FnTA/kKr8NF1
         4QA/FOT81clpxYBTov5XYlNXb/CIqYQP/aHnaJE310RwA3EWMGH83mvkYsk+dcBTu5bh
         6uvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmbX69ayGYS3sIv0trsa+HLulKQnXZsz9DpliOlFipTzqCon68y0Xonb/urqCOk3ESnTeN+ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOes9SSAjktgvjqX9dn0dswXN57caoH4CoN9rVRxrzoS/vkLaq
	u5X9V1X7b72858yxhv5WzwZaQks0s8r8bdpxXjJro2bRWU1edWaKt80iXIdyJwNsaYOzSb2WkV+
	W+PWwLMxM4/rC2YeyD8XWezuPv4+WBqgT7vHu
X-Gm-Gg: ASbGncspZwbfRN/dNBAWPO2+y5aWwhT22fHK/nrORqIhms8UK8sSwjQXWMdym8DLs15
	HjHPn6c9OFl2lZNKX9reHU4B0HAqp5yWJ6ozHCgHXyD75f1L8ba9zQoZ3/+S25rC7RsRrPA6aDi
	4KBvn1/3GxNdFgXvVTkr0QiPAUi5wn4zy7T1ZGUA==
X-Google-Smtp-Source: AGHT+IFHPCsvlmhlWeIsCvIClxZz4k+jha4O3x2y574CMDdrnX/ftbN7RQHvNWavGdipp08MXHA6Nt7AXbYnxhDrnfQ=
X-Received: by 2002:a05:622a:19a4:b0:477:6f1f:e1d6 with SMTP id
 d75a77b69052e-479249115c3mr252735611cf.3.1744112008415; Tue, 08 Apr 2025
 04:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_PfCosPB7GS4DJl@mini-arch> <20250407161308.19286-1-kuniyu@amazon.com>
 <CANp29Y5RjJD3FK8zciRL92f0+tXEaZ=DbzSF3JrnVRGyDmag2A@mail.gmail.com> <CACT4Y+acJ-D6TiynzWef4vAwTNhCNAgey=RmfZHEXDJVrPxDCg@mail.gmail.com>
In-Reply-To: <CACT4Y+acJ-D6TiynzWef4vAwTNhCNAgey=RmfZHEXDJVrPxDCg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 13:33:17 +0200
X-Gm-Features: ATxdqUFoxW4EAQ8DWeKoT-eQ2hIeqNReBAeLwQIOMKacF92_AuEB3gUBe-fWFCk
Message-ID: <CANn89iK=SrbwSN20nKY5y71huhsabLEdX=OGsdqwMPZOmNW8Gw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Aleksandr Nogikh <nogikh@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, stfomichev@gmail.com, 
	andrew@lunn.ch, davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:44=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Tue, 8 Apr 2025 at 10:11, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM 'Kuniyuki Iwashima' via syzkalle=
r-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > From: Stanislav Fomichev <stfomichev@gmail.com>
> > > Date: Mon, 7 Apr 2025 07:19:54 -0700
> > > > On 04/07, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot has tested the proposed patch but the reproducer is still =
triggering an issue:
> > > > > unregister_netdevice: waiting for DEV to become free
> > > > >
> > > > > unregister_netdevice: waiting for batadv0 to become free. Usage c=
ount =3D 3
> > > >
> > > > So it does fix the lock unbalance issue, but now there is a hang?
> > >
> > > I think this is an orthogonal issue.
> > >
> > > I saw this in another report as well.
> > > https://lore.kernel.org/netdev/67f208ea.050a0220.0a13.025b.GAE@google=
.com/
> > >
> > > syzbot may want to find a better way to filter this kind of noise.
> > >
> >
> > Syzbot treats this message as a problem worthy of reporting since a
> > long time (Cc'd Dmitry who may remember the context):
> > https://github.com/google/syzkaller/commit/7a67784ca8bdc3b26cce2f0ec9a4=
0d2dd9ec9396
> >
> > Since v6.15-rc1, we do observe it happen at least 10x more often than
> > before, both during fuzzing and while processing #syz test commands:
> > https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
>
> IIUC this error means a leaked reference count on a device, and the
> device and everything it references leaked forever + a kernel thread
> looping forever. This does not look like noise.
>
> Eric, should know more. Eric fixed a bunch of these bugs and added a
> ref count tracker to devices to provide better diagnostics. For some
> reason I don't see the reftracker output in the console output, but
> CONFIG_NET_DEV_REFCNT_TRACKER=3Dy is enabled in the config.

I think that Kuniyuki patch was fixing the original syzbot report.

After fixing this trivial bug, another bug showed up,
and this second bug triggered "syzbot may want to find a better way to
filter this kind of noise." comment.


-ETOOMANYBUGS.

