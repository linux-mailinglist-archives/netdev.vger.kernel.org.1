Return-Path: <netdev+bounces-153303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED09F790F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D009E18941F9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C8221DA7;
	Thu, 19 Dec 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hfgh0FDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C876221473
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602379; cv=none; b=JNevC2RXsclZWaGqNBKI5FuOfpLUwaOU8lakuhUE/GgGu3Ac/GzOuABao1ydxGw7msyT50QDC3Oz/+K3Cq7P8zED1Sxs8GMq4059/w46tPHNh+wcvINvFx/H0UPzJuvwUxs+vt4js1aq/KRIHOVS1iVdmhV3VnQXYn/Aa5vFPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602379; c=relaxed/simple;
	bh=QKCp/gNCuco669Z2zi2by7t/lvHAUBdHpvv8Wr5R/VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDGioyU5VQsCzLDDpHT2HEyaQj3lwN3ChQWImi7zEecGCcn41v+VO7K2GXy4j/UObZ9G8iwH1BWdTAKFqry1J5tUxJSvqn4jum84wZ/tRhnzm8m2a9U618GIR7oKssPbKsAvOxibQdFjgy9bMhEynw37g5geL5OYlC4us7rDiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hfgh0FDq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so505961a91.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734602377; x=1735207177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHxPIDppD1f6CrsB33oJcxIFdvCTKls1KQ49xB/wnM8=;
        b=Hfgh0FDqJYn7yXWribzy8nf/m6udEoHTFqhSHg37q+KFQUm+s6PJBYdHMtcIbN6lnc
         CNaxpcBbj0sMyo9BNrVNwDyQQzGtvutsyJhfORn5i9Dqm2HRIR8zxD/zhOD477ykbgAe
         4K8fB6clofboDr4kETRLMhiCY5/fKuFYndSHVopKTZPCXsF47UfJqs9TeyZd8NLOqXOE
         n6RR7ADCYOo+E67fwXylVcC34soZJW2Zf4iV3DR/jg7uqf03WlisZZsfGOUJ9y4ktXcU
         nEhuUhViofAdnZpF2OO13ojC5N4hs+AekHwgIa0i65qoknv9mTNXNPVlQg8U0tDOaaxg
         vniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734602377; x=1735207177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHxPIDppD1f6CrsB33oJcxIFdvCTKls1KQ49xB/wnM8=;
        b=t7yDhv5m/smdWW5MB/+g7T1psN6kRXhdqOIeP7rQeA9fVZbqPkC82bIG1TripH5dk5
         BGGDGAjtLFqiSqbr1BVheSNhr0S4Uv981WXGC2ws5pdCCBnwYejpyMN1/wtS6wwMT8iq
         ufrHHxTdNBkhOIzBRK3QRVA3CSSK4ezGqZTCdsLx5kprsNNIVLYRsletQhQbdws3V7sw
         Rau3IqptRXCS6ZPM0ZpZ4gR/xbjBp0PP6v/ErOHA9mRebnexuTVsZi3P3XgNrZGhptKu
         zf8YXfZIUn3GQG6dUKIh7LiuwgdG04JVEWc4jDhwmtyB0mkVpo0AVAg4ljmshB/03joL
         nvsg==
X-Forwarded-Encrypted: i=1; AJvYcCUWEBGo4Xv/jHkQ4YfDVc7I47irTbDCTvrnto20+YhTv9T7kGpRohXNR2GDsk9+wp3Gi/oorgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVudc74taaoVwxEAIUvSkc5GdvzueVOjcOsVPi8/+OJ6avbFF0
	qtbSzRlub8co8/nvw70IQaEZ8ypF9rhYl1sm23I2TC8mclHZn69+Ylhas1teX0TFAtzeB1zCvwX
	RT0c93nGuX+/bdb+sQy4V1NsrP25qOvTQGmjf
X-Gm-Gg: ASbGncslyM2/1bAuGDAsV1OUA5pbO9ClPz/hOTVBJlIXChFhGbUXZk12fOhxkiEDOrf
	4KnEp2A89pI5t3E3VbRiFEOMTj6DgSrnWmZXvvqw=
X-Google-Smtp-Source: AGHT+IFv9YlrrOz1tdYwx4NjtiLKBm9mWs3b0IN1lwprLBLMTQowj4710V54bhGUX1aooZBPTUf0qd94Z0zKO9r1nV8=
X-Received: by 2002:a17:90b:2747:b0:2ee:8c98:a965 with SMTP id
 98e67ed59e1d1-2f2e9397cdamr8654169a91.34.1734602376710; Thu, 19 Dec 2024
 01:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6761aed9.050a0220.29fcd0.006b.GAE@google.com> <CANn89iLL9EgqDz8sjMke9okhJpxtzZkcPvaEQ3s01F89H5RP3A@mail.gmail.com>
 <c5f83a88-b881-4358-87ca-b3feb5405ae7@kernel.org>
In-Reply-To: <c5f83a88-b881-4358-87ca-b3feb5405ae7@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 19 Dec 2024 10:59:25 +0100
Message-ID: <CANp29Y7c_TKiLRGpdZ_PjE-o1k4BfGiRqh-2=2+Sk1R3iL2e4w@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in put_page (4)
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, dsahern@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot <syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com>, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Wed, Dec 18, 2024 at 7:06=E2=80=AFPM 'Matthieu Baerts' via syzkaller-bug=
s
<syzkaller-bugs@googlegroups.com> wrote:
>
> Hi Eric,
>
> On 17/12/2024 18:06, Eric Dumazet wrote:
> > On Tue, Dec 17, 2024 at 6:03=E2=80=AFPM syzbot
> > <syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    78d4f34e2115 Linux 6.13-rc3
> >> git tree:       upstream
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1644573058=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6c532525a3=
2eb57d
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D38a095a81f30=
d82884c1
> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D169b0b44=
580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f502df98=
0000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/7129ee07f8aa/=
disk-78d4f34e.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/c23c0af59a16/vml=
inux-78d4f34e.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/031aecf04ea=
7/bzImage-78d4f34e.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit b83fbca1b4c9c45628aa55d582c14825b0e71c2b
> >> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Date:   Mon Sep 2 10:45:53 2024 +0000
> >>
> >>     mptcp: pm: reduce entries iterations on connect
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D163682d=
f980000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D153682d=
f980000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D113682df98=
0000
>
> (...)
>
> > I spent some time on this bug before releasing it, because I have
> > other syzbot reports probably
> > caused by the same issue, hinting at shinfo->nr_frags corruption.
> >
> > I will hold these reports to avoid flooding the mailing list.
>
> Thank you for having released this bug report!
>
> The bisected commit looks unrelated. I don't know if we can tell syzbot
> to "skip this commit and try harder".

As of now, it's not yet supported. I've added a +1 mention to the
corresponding syzbot backlog issue:
https://github.com/google/syzkaller/issues/3491

I've also looked at the bisection log of this particular report and
the only suspicious part is that syzbot could have been too eager to
minimize the .config file. A different set of enabled options changed
the cash title from "general protection fault in put_page" to "BUG:
unable to handle kernel NULL pointer dereference in skb_release_data",
but the rest of the bisection log looks reasonable to me.

>
> I'm trying to run a 'git bisect' on my side since this morning: the
> issue seems to be older, between v6.10 and v6.11 if I'm not mistaken.
> When using the same kernel config, I'm getting quite a few issues on
> older commits (compilation, other warnings, etc.), plus the compilation
> is slow on my laptop. I will update you if I can find anything useful.

If you find the proper guilty commit, it would also really help debug
the bot's bisection result.

In case it may help you during the manual bisection, syzbot
cherry-picks this set of fix commits while doing the bisection:
https://github.com/google/syzkaller/blob/master/pkg/vcs/linux_patches.go#L6=
0

--=20
Aleksandr

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

