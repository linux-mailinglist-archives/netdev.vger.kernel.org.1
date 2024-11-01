Return-Path: <netdev+bounces-141057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD559B94C7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5763D282F82
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDBF1C8FCF;
	Fri,  1 Nov 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Twz+bMkd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238C1C761F
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476550; cv=none; b=Hwx4C1tU8J9/6Kte8Md1RSGoqPMx3s+KUcpf4xrfTTEZM4Q7XsF3BaG6jYcyzyC66b2YaIX4g9a+RcY/AmKVz2o/xriRVSExJtYjw7ToMEFJxJxiWPA52w9hPAX7bLFa5u35V2k4TMuPJCkuLsNxBXYFQD8Dch6BKPYBnRYLw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476550; c=relaxed/simple;
	bh=4uAD9jOOqXaCa32oc6A+GDRWQpHNHx04sARiGTc2Qu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7axvwErUwoUeEHqiAHWHXWQ/mYgzKe8VxJm/es5KO3yDjO0M9nRC+u0VS3aRUwF21tvVI90DH+27JvyoaXzv2/3Ld/urA0u/DdpvUwoAYont40Hy/dorFrBGRexuQG/YTKKh0A5hDxJ2G7gRAlyRxudSTdgiAihnvFFcJN+q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Twz+bMkd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso1684925a91.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730476547; x=1731081347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLBlsEZQifedxSMlNM71vQWvxRSeWYs3fggN7cWB9ls=;
        b=Twz+bMkdAKNON9eZpqP/2UcRFv1nUm4omV0TdAHf3tm3AJPFpHcHsUFngDloahHqyq
         LVeF7djHyFvHYcig5dDo0bbtUfskSWDC7HEwx0tjEtbEZMaMJQJLCE1vMcmFLu5MKoLg
         864UBVpfgwWRlbwjDA5UtNg/CD3SB3cZW/eu4rwOTmNgUbKB0HYUestcDDv3gkObmq97
         WFBVjj6BpGlKtPVa5adTIxxJUcIENiUi9xpOqDNr7mnoOwSkGLq4Uv+NQeO08eUecxKv
         1u3A4DmynbELs7Xj5znoS1CUgtjvURcqI5fmD3YRbRnN4rJsUeu+9J7ggO/AdYk9Izgb
         nMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730476547; x=1731081347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLBlsEZQifedxSMlNM71vQWvxRSeWYs3fggN7cWB9ls=;
        b=ruyQMEyX/1z9DyXhZzDK5IAd0NSDa2PiPI7QNiXIfYEhPqC975lE4xgEMUV5aTlUWw
         Ar2RRFtnRk5fBke2RRCJVzle2HYc7DmRaDE7Yb6IXFpVtvJWG4LvY8GYjVmgp3JbmLuU
         D7MKzgHomm4TWSqdffjG4NHRHsS+zy8Uf7/4i8ygXX8RRdGnBz8/qULjdKv2FtMQ8NJR
         KS0hpCIE9i5cOrbNniv9qTc4Chw5SPSfCWtoUhZz7yjMqj2S1aWp9qusXmt1mHE2Mix5
         OWct73zs/nTKPYbRtmlNjkXxOD6VxDMQO5qpfA9VTXM7pr+onEi/5+OYraQa9OPYBSeo
         UIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp+3NcuWoiePwCoswNNDSTUnAZ3hGioUa1HXvjv505QF6dXkta9hk7jSIvAMp2w3CS+cM78n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl120Kh9FooWgjmJ2TCOXA0ZgEAKAQRzlxnTL+oBScDLEp+0/m
	Buum2AKHXIWpa8ygIw94ElN1BqHktR5xXt/ebbsARX5CMSI05x2+bnNvWPXmygmu3BxItQ3WExx
	IDYcQPDm2xH6RqigZLM/XZoxsQSgQ82z2aX0B
X-Google-Smtp-Source: AGHT+IHMRbP5nE3OD/sTxFNgEl4A+Ix91K3szIsn26YzRn5L7WbY5jaruHKUNjBpS/XhaoJn/vvvjAV9HGaLKjL/bmk=
X-Received: by 2002:a17:90a:d14f:b0:2e2:bb32:73eb with SMTP id
 98e67ed59e1d1-2e8f10a72a3mr26553959a91.31.1730476546681; Fri, 01 Nov 2024
 08:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <671756af.050a0220.10f4f4.010f.GAE@google.com> <20241022142901.GA13306@ziepe.ca>
In-Reply-To: <20241022142901.GA13306@ziepe.ca>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 1 Nov 2024 16:55:32 +0100
Message-ID: <CANp29Y534CT0jqhp5LQi_ZCs=1_i4duRO=4CJ52by9ZDW-1Wfw@mail.gmail.com>
Subject: Re: [syzbot] [rdma?] INFO: task hung in add_one_compat_dev (3)
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: syzbot <syzbot+6dee15fdb0606ef7b6ba@syzkaller.appspotmail.com>, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, Oct 22, 2024 at 4:29=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Oct 22, 2024 at 12:39:27AM -0700, syzbot wrote:
>
> > 1 lock held by syz-executor/27959:
> >  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/=
rtnetlink.c:79 [inline]
> >  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: __rtnl_newlink net/=
core/rtnetlink.c:3749 [inline]
> >  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_newlink+0xab7/=
0x20a0 net/core/rtnetlink.c:3772
>
> There is really something wrong with the new sykzaller reporting, can
> someone fix it?
>
> The kernel log that shows the programs:
>
> https://syzkaller.appspot.com/x/log.txt?x=3D10d72727980000
>
> Doesn't have the word "newlink"/"new"/"link" etc, and yet there is an
> executor clearly sitting in a newlink netlink callback when we
> crashed.

These are likely coming from the network devices initialization code.
When syzbot spins up a new syz-executor, it creates a lot of
networking devices as one of the first steps.
https://github.com/google/syzkaller/blob/f00eed24f2a1332b07fef1a353a4391339=
78d97b/executor/common_linux.h#L1482

So those syz-executors might have just been unable to start and then
they were abandoned (?)

>
> We need to see the syzkaller programs that are triggering these issues
> to get ideas, and for some reason they are missing now.

Once syzbot manages to find a reproducer, hopefully things will become
more clear.

--=20
Aleksandr

>
> Jason
>

