Return-Path: <netdev+bounces-108794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4C925807
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7407F28ED49
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F817164F;
	Wed,  3 Jul 2024 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiWKKQ6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5E143C6B
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001471; cv=none; b=nm8YVLaYgaSgY/s7b3zMXBl+ReG1WpxjfFpBOmktPBR1hgRFiVrAhP91CYxF2Tx4V90n+GTLiT6t73ZMvp4jDnzwrenu9wSYXgykqmLr2B9kDJaZ1uI2j5buIa8TJanYT4Rl6lcFu6uQSsdyuY+AKIn8xDjt5Jr6Asy1YBDxBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001471; c=relaxed/simple;
	bh=XPy1FzF1Ebx4bueMG5ZLQTSTYfgwB7PuWQdXDp+T4YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xsa5j86QwM4sb+3P43V5IPWTwHynLm8XN7HBZa01CbWgXO6+MjGcNXsaCjFDzkWIaEBjGkevSODyNNR+Q7Xllvtyb5zQMABXExEoJowvNuSfoJAXo7nZ+SdadZZtcFw/WAI7NL504TzbVIebmB2XN98jFYLHPSaxjP2LFlz/J5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiWKKQ6b; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375fc24a746so109075ab.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720001468; x=1720606268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpAR7Ny8q3WkzXllnPim4ghKxdVm2AsfgGOk/xi9Hrc=;
        b=CiWKKQ6bnAaA5eN+ukEzuXjSIIeTtkF0k7qOgKhFVYBgaPyvGglzvdXgi1RbmQIlqX
         WySC+TWtVgKnIH3eFTmRtfNkTiYmriRL8cRfl6pmuNIzkrEap0md26iYbNgrrcOk1Ltx
         AukByvIVtfwRUSZie1ZCvR2RBGeRlGMv5hjnYmVhMkZcclJfoouryqLzrQETT3qt+szH
         CAt7S4hwFkLUegLAS2wlPN8Wy5Y5q9DQx1jPY8p6cEF2v6h5nWBICesxzNSF7YV85Tkk
         8CDkcgecPgcIwpFNJ8Tqv9xIACcuk75iO6e8ICJJuc2vW/3OMiERsdcx+l8zDMZ1xDcE
         RY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001468; x=1720606268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpAR7Ny8q3WkzXllnPim4ghKxdVm2AsfgGOk/xi9Hrc=;
        b=vIj6TrjFn35y7dQSRetM/I/ggl5JyPRiaqTsXxM4G8PDGCz5tRQU7RinaqBFQ4mggk
         oL0Avg/MeaddYg0KaB+/VQbq7gjtCyp3HxXlXO2Zyfk0+7oprbGfmJbtLkhu77aRbYKi
         e0M5ze//1aag27i3zgVTHcpmTB5s671/VNef/c24mCJGHPL8tupPOGmQmcDRsTyn29p4
         /0XCtQNG52elA5A1rapQE1IVZvKYt5MLT+C+ENik4k7D9YgJNEUWiWaELjLnKnMQ4Yuc
         oS+dWDuSlAYBt1d3QfWtkJsK854MkujilNXbQJH6kU7bSyUnRyAIdyc0g6Nb1099GOTe
         ov7g==
X-Forwarded-Encrypted: i=1; AJvYcCUOttxK/+Oe1upllSd67lNkJ01AU0fPJZjiEQYG2PW+9r6TNfRIUJNqTVWu6vQ9Auv5OJnCAKU20tZyzvkZf8VHJ+kz0FCN
X-Gm-Message-State: AOJu0YyrkDzJd3ZUVXf15WUZ7jcjTiqNdm7PIbOHwjCIhUrsaVS6jVEQ
	6yejTsvZ08OKGj+XFYAFEQPUX0lT0YmzOmMtqd8HgNw5ZENENKNyaN6ya+/aeFxEzRQ4wjetrqk
	G5DqC6DOHX4P3r8bwlxjFL7j+KDT0g6wz1rHn
X-Google-Smtp-Source: AGHT+IH898YEcCwJpLbHzqqfGYM8WQrRWE/MGIIxJuHopTKOArBwznaH1U1QlxYiVG3aQU53jla4P0WZiSL0/plIfJg=
X-Received: by 2002:a05:6e02:339a:b0:375:f1f7:c53 with SMTP id
 e9e14a558f8ab-3820cde0e19mr2167885ab.7.1720001467894; Wed, 03 Jul 2024
 03:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000227d2c061c54ff82@google.com>
In-Reply-To: <000000000000227d2c061c54ff82@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jul 2024 12:10:52 +0200
Message-ID: <CANn89iJFATii0PdPxfhjurHXiBo6j5Dgqunok1dLJw_NNYtb7g@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_activate
To: syzbot <syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com>, 
	Johannes Berg <johannes.berg@intel.com>
Cc: davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:07=E2=80=AFPM syzbot
<syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1dfe225e9af5 Merge tag 'scsi-fixes' of git://git.kernel.o=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14a4f2d198000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1ace69f521989=
b1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2120b9a8f96b3fa=
90bad
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3894cf8b5271/dis=
k-1dfe225e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/573c202ade8f/vmlinu=
x-1dfe225e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a356d869b8f3/b=
zImage-1dfe225e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: suspicious RCU usage
> 6.10.0-rc6-syzkaller-00051-g1dfe225e9af5 #0 Not tainted
> -----------------------------
> net/sched/sch_generic.c:1249 suspicious rcu_dereference_protected() usage=
!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 3 locks held by kworker/u8:0/11:
>  #0: ffff88801efaa148 ((wq_completion)bond0#9){+.+.}-{0:0}, at: process_o=
ne_work kernel/workqueue.c:3223 [inline]
>  #0: ffff88801efaa148 ((wq_completion)bond0#9){+.+.}-{0:0}, at: process_s=
cheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
>  #1: ffffc90000107d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}=
-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
>  #1: ffffc90000107d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}=
-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
>  #2: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:329 [inline]
>  #2: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:781 [inline]
>  #2: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0=
x174/0x3170 drivers/net/bonding/bond_main.c:2824
>
> stack backtrace:
> CPU: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-rc6-syzkaller-00051-=
g1dfe225e9af5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> Workqueue: bond0 bond_mii_monitor
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
>  dev_activate+0xf8/0x1240 net/sched/sch_generic.c:1249
>  linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
>  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
>  bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
>  bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
>  worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
>  kthread+0x
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

I think this came with this patch :

commit facd15dfd69122042502d99ab8c9f888b48ee994
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Dec 4 21:47:07 2023 +0100

    net: core: synchronize link-watch when carrier is queried


Issue here is that ethtool_op_get_link() could be called from RCU contexts.

Adding linkwatch_sync_dev() in it broke this case.

BTW, this commit also made it difficult to convert "ip link" dumps to
not use RTNL, but rely on RCU instead.

