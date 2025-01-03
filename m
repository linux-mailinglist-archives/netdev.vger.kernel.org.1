Return-Path: <netdev+bounces-154857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC5A0021D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D9B1883D42
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006914A099;
	Fri,  3 Jan 2025 00:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F2146000
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735865164; cv=none; b=Ylul89o4RqfSB5MBnHPxDfUrLQkHGSjpCYxDuuvpRvY/VjtJMK4uRw4Eiy2xXiHVmTuiZVZ32krIje6a3ALDZFshKmuWmcRfGcqTnv6SkBp8NjlZEMtu7wfvczD3PrIeHcIn1IzoxU1Ht+cq2sdN+kVWLluahAe/dSaxprhcr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735865164; c=relaxed/simple;
	bh=dFeSjNAmhYRPFDoMVHhliKC8qfP++MZ3qf1PdPFQxvs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DJCPhAhtzs2o9UWQ22LpVjBjX1T5BQF0aHDKxMGSGV/sLev+pePUCxQ5CCY2ofV/wwOAPG5lHoX3vFCVgsVGLPxFXwnieCQsS2vbC/ISonb13iew9mRy/GWXEgiPDluSouyaEPFI+kf7DFtuHI0Bj0m6WqITVZLwSbVadmhd3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81684bac0so243741365ab.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 16:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735865162; x=1736469962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYrkFQ7I1vK/8bZLkAm/VSldpl3A1n3rZuJVzqWrdzs=;
        b=bAkImstGFl+eWlcYy+EzX8fixwqQE5+8VvQeXEV2piyeDEt5bAFERm4EQsDOhmItAS
         x/2oC4o237Sj5wBT1wCKqajvhqe6e+CjTQqns3hp7zra/uH/oWZXrLs2jx5UUZzrLFn5
         ZkibQIFAKbqH3vXpQcEEmGC/105v3ulWF+2WnJN79uC7vKiu3THFoRL19ZUupscxCrIb
         NKAfJJ6yksNvrGfERiiYkM+YlLjKWkg/6ToOebflgwwNd64HXyCVQElzhAibIJliO+Wm
         BC3fQeEiJhkcM5LjuOdY5r33lP7I6PGuyJex6KLDWW8Ze7RV6hmTSqsjv0HdMG4/diJd
         neNw==
X-Forwarded-Encrypted: i=1; AJvYcCXz1uVB0aj/KG0BbMuMSRPIuNjYMeG7VT7S3EFcgh4+7sMONhQvwedSh7kckBIZSqcuDPu2S8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJPZH21m6u8OJtl3tIaqFI5uZrLfrOjMLPeltkVT1F4+gdl3b
	PrYCb5/9oeEuiN4djg6+towK356rATd1gyzYcpKkAE+LBBySdpQiTQB+P8P39dpferSIx9OtEwR
	am/BEltcPZdeIWE8CkcKd0HzjunylvNiyHeh/B/Xdci00QLyWiwkDVrM=
X-Google-Smtp-Source: AGHT+IGwF9Xn5VdN0IylmHFQfxLyPfRqdP7j5S3e+7V5wVpAQEJJ5dRCStikzHWMjN3KyF+eWkeqkhfSMYMNh/GiJpfZmyrJzdqv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2687:b0:3a7:e83c:2d10 with SMTP id
 e9e14a558f8ab-3c2d5b37857mr460147425ab.24.1735865162093; Thu, 02 Jan 2025
 16:46:02 -0800 (PST)
Date: Thu, 02 Jan 2025 16:46:02 -0800
In-Reply-To: <6756b479.050a0220.a30f1.0196.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6777334a.050a0220.3a8527.0058.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
From: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, davem@davemloft.net, 
	jannh@google.com, jhs@mojatatu.com, jiri@resnulli.us, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117df818580000
start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=137df818580000
console output: https://syzkaller.appspot.com/x/log.txt?x=157df818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8a8df980000

Reported-by: syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

