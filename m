Return-Path: <netdev+bounces-103847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3936909DE3
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29161B20E9D
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C977FBF6;
	Sun, 16 Jun 2024 14:05:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EBDDD9
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546706; cv=none; b=cCt3RZwXssURUEKadX7A3iqViLax/k+XpKvxPXkvDoD/bIxMFwKvT/G/NKqqpi3qcJ3Rz0amO3/dZ/RbzAct2WWq1FNowNmUrEG9SO4SR/rb/6cQlqW63wD1bNGcRn62bxfVf1/wCpQVv2XGel5BkHKuRxvAE+J+LqD1mehb8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546706; c=relaxed/simple;
	bh=6io00tG+BXXD/bjavj6Wc0ZSI2uXwoyQQXTJiFre6ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DwhrreXd0jOjh3YawckWtFHjjtp1XYXY9QJrp0RnBzL/DN9hOZMExkj2QPB56aI+dO8wYCGPRiQQWIrRSW9MNB7ZCLMUU06j82U/A5uNJRSj8TmfF/ORtwgYor6hM6b+45YIz5oakHs9vDO525kn1YGZ0uoaAeWcS8DQXdnnbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e20341b122so380564439f.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 07:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718546704; x=1719151504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLcaaWng2TQ/H+FaOLphi+VM/bKUwUbvtr6FoaGnNrI=;
        b=AD1w6dgNfz6U0KgqSwd9oQ5/vUpoy8hLrDx1u7DtU3X4OGtEx7fK5NYllQXSYEE+nq
         S6JhC6TSz2TUkywrNAu/P0HbkAo9bQpOjJ+unkPBb7jcEI390m4owKoS703cmit6Ii9d
         4Oj5dwLLOzeU0sTIGozp3E2WEzUCSrmMX21KtWXbE4xZCUxX6flFeatzdbnWR/VDnoUk
         +AIE9rPtJym0EsCXge2jKly7kSFrdKn5tce6fD0WkLtA8ZrE9PuOyjE4l/YHhGqs2avZ
         +quDCgXIMYlMiaIZ8y8HERsiau31Yh4nyuSIebKyVLEKiVKMCHlabb2cX5TT2oveX8A5
         /thA==
X-Forwarded-Encrypted: i=1; AJvYcCWpXu9wNFIu5fF8YASyoaxQdBciWBFvJrts8pKDrhdAyunb3vr+nRsak9jtwcW/4mJ9bZz1QZdASe/UFObczKt4WzAu7aFr
X-Gm-Message-State: AOJu0YyBlkPcpsbONcjm1mB1yzvVtivrb+rOSXSgdPjIZKhjyxZzmU5j
	yHonEBkipYBS2g3ryGB3TTEoLotScH6G8VvRf4sxxyIHrF0g0qsjwwDJZhe5d0dfqvXq0vjdmzB
	MZWUfXNOArJXs/gBAYv2Ce+NEAZO/3heRb+C71tCE8jefLhNpgCA8l/4=
X-Google-Smtp-Source: AGHT+IGHyeFtvlt+ImnEUgnwm5dEInqksvU32QABvMV0/yconOjWp25/ZCqoFaDWtWWVmgcbKMIB0yhITZPgs6UzpCsDR8a/2Hhl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150f:b0:7eb:78b4:faff with SMTP id
 ca18e2360f4ac-7ebeb62c796mr20918739f.3.1718546703860; Sun, 16 Jun 2024
 07:05:03 -0700 (PDT)
Date: Sun, 16 Jun 2024 07:05:03 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d05580061b025528@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	hawk@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Date:   Wed May 1 14:04:11 2024 +0000

    cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16695261980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15695261980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11695261980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com
Fixes: 21c38a3bd4ee ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

