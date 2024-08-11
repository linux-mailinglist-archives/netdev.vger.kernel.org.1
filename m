Return-Path: <netdev+bounces-117454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F194E025
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 07:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817081C20BCA
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 05:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F518E20;
	Sun, 11 Aug 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIS22I9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CF11CAB;
	Sun, 11 Aug 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723355009; cv=none; b=odH8EUC5jcDXe9bN1TnCq+Tch8U9oqc2adYgCJM5CTJA2p04j74teK+tm333GXKGyqOE+zbpHac22BKbr0h9w2MFug0GiFvauZCLzGaHwYTXhpipJDw3xjKJ8G8rPvmv0dlt7iZr7hSwDqJbAQuB0NWR2+KpH2TDvcN7q5kxrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723355009; c=relaxed/simple;
	bh=6tis8Onk4vKI11B/pr3JpmguCMVU9HAlccL79Vr1kJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2sfe4jaAuAG/8n1hehB+p4WT5n1E+COc8fE/k+E07tHNOl8+hVsoRXQhxjBkWRQkZhm3Pv/g8Uh/cY4sWS19K7/Wv6mXpGyTy8QUwALUlqNuWlWDQC3OkyrDWzaWEj2YMz4Y0vSIE30smJJGda3uT4nzePU2W/QH3mgUXdob68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIS22I9e; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39aeccc6377so12491365ab.1;
        Sat, 10 Aug 2024 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723355007; x=1723959807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fegtz1E7mDaSdzG9wq3lbuilj1QmL6UN/2jOlbF5VCw=;
        b=VIS22I9ev3f2AaWvzK8JKoXkhJ1vag0Nd442d2dZnpZUAMb7q/tB61MUHBEzZGgROk
         z4ln0qfMHM+6joqZYWfWFJYm/8+PdOBWF+LuyAQuJK1YV7Dc6Es/pBw1tWUJG1pHafwI
         A01SiNnEOIDlvm5sgZbxdqWLTdQc0KcYPKkT9lE1rWg5fAvc/wGbMHf8Blk+PPaNZ2iw
         DnHIi5NjvqgL1ZF83kBEUyOnzy5dNjaOAqchbcL+3dm+Q5DeCmLsmCG5p9MAasEx8dyu
         KlzRkl/hnjn/zKQ8C0CGn6Ksta4Hpm78Jf3/LPqiB3bL+VUe34kvtq7eLxgb3PH7o//S
         d0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723355007; x=1723959807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fegtz1E7mDaSdzG9wq3lbuilj1QmL6UN/2jOlbF5VCw=;
        b=Jid4CZ6dK3Df0fBHlve/sHpcT+dMQZsnSbdWwGC4AZdAig8cdcK2H6OMdoFeDL9m+4
         xQWrXFJ0gN/6U4zpBCFnZLSXmPGLBZenwRnaZS584ftHySOTXaMSUiw8/jAg6Qrkk2yF
         V0t5eWL2V9imlav+46GgSntwJXqwDobH4v0zkIs7t7eLtXChnc0TWPA1Nr8h03M1fzwY
         fGd69SSlcZlpjYhtpyFFkxfvnBIvGNa0OrcDFGn9dRQ0MFXUp/SHq93xKYLjAI1wKoZV
         u7SqvlC4aNuGQE8osCRMCl+1gv73jH/yKA6blT6sO+MHT6SW4uhJOZKy4tqG7Jz7ONhS
         KWdw==
X-Forwarded-Encrypted: i=1; AJvYcCXHjcFbb2p2cMWDPWZKwqqYpl9mBD2bOEeW7PR2SxLHcIJ3PjM6UdKdMxibns+QuBypntzT33K2r7MFcSL92s+EdfVI6eJEEC9pw7w49G0jMOIeIdIOhtZqlqvTl5lPWSDkrat2
X-Gm-Message-State: AOJu0Ywe2Nwcbky/q/dHFtGLZ4MgNF3Mhk2gHIawJ+NoTQUAttp3+7Na
	EbEf73YgUO3RuWBBWJ9mygdgAAzruDBfaQFj1S6oc/z8MLf6SC1TtGZrdi8EKOO3nl2vTBsfoSQ
	gMj1sfJ20ER1qcCoBJsmD7iVCfHI=
X-Google-Smtp-Source: AGHT+IHWQUBxgrASvNC6A9bWXO4CsyE76eLvd5MWDiATYZjXYvrjUz+yGdlBDgOTsrfvedZzSm3oyw5PwfGfug9TTfg=
X-Received: by 2002:a05:6e02:138d:b0:397:98d7:5180 with SMTP id
 e9e14a558f8ab-39b6c1187d3mr89700155ab.0.1723355007148; Sat, 10 Aug 2024
 22:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003a5292061f5e4e19@google.com> <20240811022903.49188-1-kuniyu@amazon.com>
In-Reply-To: <20240811022903.49188-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 11 Aug 2024 13:42:51 +0800
Message-ID: <CAL+tcoBC4mB6Has_uX=DB9=BrRMmgfjCEFj+J-oPzLS25w6btQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kuniyuki,

On Sun, Aug 11, 2024 at 10:35=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: syzbot <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
> Date: Sat, 10 Aug 2024 18:29:20 -0700
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.ke=
rne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D117f3182980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D25544a2faf4=
bae65
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8ea26396ff85d=
23a8929
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/573c88ac3233/vmli=
nux-33e02dc6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/760a52b9a00a=
/bzImage-33e02dc6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > refcount_t: decrement hit 0; leaking memory.
> > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0=
x1ed/0x210 lib/refcount.c:31
>
> Eric, this is the weird report I was talking about at netdevconf :)
>
> It seems refcount_dec(&tw->tw_dr->tw_refcount) is somehow done earlier
> than refcount_inc().
>
> I started to see the same splat at a very low rate after consuming
> commit b334b924c9b7 ("net: tcp/dccp: prepare for tw_timer un-pinning").
>
> The commit a bit deferred refcount_inc(tw_refcount) after the hash dance,
> so twsk is now visible before tw_dr->tw_refcount is incremented.
>
> I came up with the diff below but was suspecting a bug in another place,
> possibly QEMU, so I haven't posted the diff officially.
>
> refcount_inc() was actually deferred, but it's still under an ehash lock,
> and inet_twsk_deschedule_put() must be serialised with the same ehash
> lock.  Even inet_twsk_kill() performs the ehash lock dance before calling
> refcount_dec().
>
> So, it should be impossible that refcount_inc() is not visible after doub=
le
> lock/unlock and before refcount_dec(), so this report looks bogus to me :=
S

In normal cases, I agree with this, since inc/dec are all protected
under the spin lock. There is no way we can decrement it if we don't
increment it first.

Thanks,
Jason

