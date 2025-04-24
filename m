Return-Path: <netdev+bounces-185549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F1A9AE0B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E981B65580
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618E27B516;
	Thu, 24 Apr 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaWCtypJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C41223DEB
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499368; cv=none; b=Zo8P3lRCQzT2ZRG+AoeGjdtSQmJVcnZXa3huGFTuHl4WL22sWPHMpeuymgjLtEe04gAT5qccjkx8e8z8iSCZJmmb7DNTVfI0bcMoRcBGIpOgaJhuk88N21E0vLgeFslUGFa0zIFYHjnIBsp66/IVHU3jXkV5cyYRrnwr1NGZOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499368; c=relaxed/simple;
	bh=wytmH7a5yV+mTmP/mf2zLdZqlGHahZ/qQLdzJIcj0B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o44YpDq0IEVYZv6HyiSXJlTa55Dv7OX576iF8aADINhINz5QC4aOBeSUBqlRq2V+RCzs1k5erQZDZTmLItp/fNrnhbDXJFWXSQ46HaeyCOBLWpos2Vq+49IFdK01YZCzT4SE7NIp9UvHveTIntsjgI7s0MQ4yP5lUJELOlz0c8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QaWCtypJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af590aea813so2085255a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745499366; x=1746104166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSWRON5bs+6mlhVmC4A6isWLNPJweUWm5K3Tnj4Gihg=;
        b=QaWCtypJNt40OogFeX7bt5jB4BnkdpS7ylHUH/e0bxt7WLzFBeFBDvefYasKFJCLEq
         h6MhqtHe/WplgYuSt1xBDhe3K4j03Z44F2P/jLT3uj+pw47ACcZgpc5WvekYrbnnsat8
         aNWyPkes7aYAxVmqCfrrjHpRcY2Ax10sJ2Ixjc09E1FQwYTEWaLx3keLd4lq7G/7gir+
         AFawJjCFdeMWXWfsg61VLxCtPldMQ7b4uT7CrumVxxsvbWCnx/ufcqg5ggYgze6+F+hK
         jxhJqIiscL5djMOudvJqUKWEH5CfYqzIFAaZPmjWCTLW+qBbvd9bsUG3mRtjF97sjslJ
         xRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499366; x=1746104166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSWRON5bs+6mlhVmC4A6isWLNPJweUWm5K3Tnj4Gihg=;
        b=sNxarRq/SVKs2ZfDIO1khmw/uVZlZ6/nADQFFeqpzSUmqDg/6cqOIAAJ5FwTP70UDm
         wccZBFT94nhK2IvwFscIU6SDdr2v7VnbKEYiyLJ+EKtWBOQ8oAk7IYIO/tI/PFwCdSJs
         ncTsvL5cz+muajq24r8LaGX9TNeHAY7T+DufCfTToR2JP6u324i8S4QL4VGFXFF/6Wqf
         pQf7Kwg6S7G94FaA1eWPjLd5lO1F+GPaB94/LK79j0qiCds9AJMGcjMzXv4OCn4vO07f
         E89mUDVKVWl2HhDF+36hH2falUaNfGKnPlIYWFctwEkfr7p6i4wKv7L+bwJV4cthUu+c
         8GSA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqRpw8S0RIZcQn9o+uelhZOINyf7VvI2/qg7ZV1aoecu4txsZp53MIrj5Dwvga/lUCPlule8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uXxxgh34Fepd9PK8BoIeThvj4XdCItBcobOlk6paigab1BbC
	ACoPakN+FdRG+Kw7zvsQ3e3LexSXu4StCDMHxTz8UGSbp/o9lQzepXRAwV38UsoobG3XuHuC73J
	DYp/oaxQw+XKvSK3bxcm0wSQMoUe/GbMz8QXy
X-Gm-Gg: ASbGncta9sq/XgHEjfwnN58mbVH9ISNOiZU9q3hSzf2M1QYPycZQXufxmDhtx43J1nc
	Yo6mjUCvM9sVp5kr8x3Ztea9ca2uBR+iIOj9JfeKKwmCmIoOjtlPhbdP7vj9owQX3DcQJDRwkZD
	SZAUjl+HqrPA7eAgUy2izLfBdfJscGYtKpS/sC6x69O2ZfbrYwtiJ+
X-Google-Smtp-Source: AGHT+IHbBDJRszZSled4CmWTPaftUgkcEDj8QcHI1jzPj+1jSYfi6PL9BwWaDk5Y1ey2LeNyPUAjVgmzfuh3lQXFxjg=
X-Received: by 2002:a17:90a:8a87:b0:309:f46e:a67c with SMTP id
 98e67ed59e1d1-309f46ea6a6mr170830a91.11.1745499365881; Thu, 24 Apr 2025
 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <680a33d5.050a0220.10d98e.0006.GAE@google.com>
In-Reply-To: <680a33d5.050a0220.10d98e.0006.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 24 Apr 2025 14:55:54 +0200
X-Gm-Features: ATxdqUGpo0kP3QfW2IPGszt9sTV6h7B_wArhkeQAE2UapEW8Hp8tyjMIS3Ixh-8
Message-ID: <CANp29Y4Zve8dohEhZ=12-w2SPOmOKbtt6U4MTvaK37CRrTQtMw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] net test error: UBSAN: negation-overflow in corrupted
To: syzbot <syzbot+76fd07ed2518fb9303f9@syzkaller.appspotmail.com>, 
	Kees Cook <keescook@google.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Kees Cook

Hi Kees,

This boot time error appears on v6.15-rc* when the kernel is built
with clang-20. It's apparently related to

commit ed2b548f1017586c44f50654ef9febb42d491f31
Author: Kees Cook <kees@kernel.org>
Date:   Thu Mar 6 20:19:09 2025 -0800
    ubsan/overflow: Rework integer overflow sanitizer option to turn
on everything

Could you please have a look whether it's a legit issue?

On Thu, Apr 24, 2025 at 2:51=E2=80=AFPM syzbot
<syzbot+76fd07ed2518fb9303f9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cc0dec3f659d Merge branch 'net-stmmac-fix-timestamp-snaps=
h..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D131c21b398000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac0f76cd0f8e0=
93a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D76fd07ed2518fb9=
303f9
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd=
6-1~exp1~20250402004600.97), Debian LLD 20.1.2
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1d6f321414b4/dis=
k-cc0dec3f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/072c28c931b0/vmlinu=
x-cc0dec3f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bcb44ff40c55/b=
zImage-cc0dec3f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+76fd07ed2518fb9303f9@syzkaller.appspotmail.com
>
> virtio-scsi blksize=3D512 sectors=3D4194304 =3D 2048 MiB
> drive 0x000f27f0: PCHS=3D0/0/0 translation=3Dlba LCHS=3D520/128/63 s=3D41=
94304
> Sending Seabios boot VM event.
> Booting from Hard Disk 0...
> [    0serialport: Connected to syzkaller.us-central1-c.ci-upstream-net-th=
is-kasan-gce-test-1 port 1 (session ID: e72bd3249fa5f4b40b974e21e6d99e16e83=
84254f2e85c0fe39918dcc479fa4d, active connections: 1).
> .000000][    T0] UBSAN: negation-overflow in lib/sort.c:199:36
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
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/680a33d5.050a0220.10d98e.0006.GAE%40google.com.

