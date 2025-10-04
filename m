Return-Path: <netdev+bounces-227836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5350BB8764
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 03:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E174C2648
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A128373;
	Sat,  4 Oct 2025 01:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC1D2FB
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759539845; cv=none; b=cu0D/rcjCig8cdF9+RUe8TKoeD9ncpdQPob4DJu5T1v9rz0WqEDrYI1zZ5upHRbPn3NhMp2jsQ1ttA7a24bhLZ+OvMbUXnO+gs07VdFzYmvOdJGgXmuD5jqgT+eTQMoHRoKARyRkmgJ4qv8VKzalH1voIxmE9Xu7RgtZG3821zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759539845; c=relaxed/simple;
	bh=SOcgETh5xeubM838LXHr8nv9pfekOTux79h+0vKGLd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HbMWl+Atha4iu/VVTBPo4uqPkONW6DRocgfKPylGZxwgoS+RwQHNpY01UyQQtVGlSekdoaWHfYj9ntkXnA14PbOMTsWtHa21rC+Sm7na4cIQJRwMrDaaGs4xJ89sjmcxMwDFMEpLP7zGTYrxwiGuH1Pfl7HCwbUEjK+qQRwp+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42e74499445so28937495ab.3
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 18:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759539843; x=1760144643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBSZwqSDmh1BSWgw4JtT806Jg7bQjBuA+gVX18qZT4E=;
        b=nsJag/6G8vtnZ8G0aGpwB5yqTOUf6vPme/r3ahBa5s5tOc61OzMbQdgzQ8Fj4ofRrM
         fgpHcEpXxfkUfQwUtH99FMHt5zr9zxchSNLxqvcF4TEkKuZUZKngbQHeMVSgI2lEAQZd
         9kSRL6D05FMCT89kCKNZ0Wb/26kfWMZNT8u0oEs1q4b53seh36zgR9PNRDwg5I8ggHaV
         wTodD+xdcQInBb5vXMw0xvd6HYkEkSOusvEENp9iuB0zEk0V84YIMNz/zSkARynfN5u4
         t3WCaYcEz7Kx6ZdYfXF90FnbRen9a4snhlK0C3dzOSXIp73W2RXwTjX97QFb0JWV/clQ
         gE8g==
X-Forwarded-Encrypted: i=1; AJvYcCUR+QFSJNYb7vx6QsS/N5VrRuq3vRBLJqIqsPEZng8uSYVD5jmg0WvXW3sJDssct4j1ASAU+Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD83ANYYCIqYiLotJ/1hpcsXBwJRmxCtLj3FNxE3ey610dzWAZ
	0SRVyWCPef3hqL9uh4t4lXuGA/ZgVN8+yZ8eW9kqFiQAPU4rYwGkp/fBgny4REk3t5kYu69Dy4q
	PHTIV0TWzzf/hism+lOQaALYQUAiI0Tr837pZgXrBs/FDF8f7iNC6DEJobYA=
X-Google-Smtp-Source: AGHT+IG5JM3/o6FGfsB9hA9pW+iiPTtSAdodFWPBkviXe5k4KQ+1mesDPtmy+8ZNmTIw34B4iexXbVyss3CJ246tUdhyhjSRaavg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:42e:6e3a:3075 with SMTP id
 e9e14a558f8ab-42e7ad84876mr59415045ab.21.1759539843090; Fri, 03 Oct 2025
 18:04:03 -0700 (PDT)
Date: Fri, 03 Oct 2025 18:04:03 -0700
In-Reply-To: <68c6c3b1.050a0220.2ff435.0382.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e07283.a00a0220.102ee.0118.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in qlist_free_all (2)
From: syzbot <syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, bp@alien8.de, 
	brauner@kernel.org, clrkwllms@kernel.org, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, hpa@zytor.com, jack@suse.cz, kprateek.nayak@amd.com, 
	kuba@kernel.org, kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, luto@kernel.org, 
	mingo@redhat.com, ncardwell@google.com, neil@brown.name, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3253cb49cbad4772389d6ef55be75db1f97da910
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Sep 4 14:25:25 2025 +0000

    softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17566a7c580000
start commit:   7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d66a7c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d66a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b78ebc06b51acd7e
dashboard link: https://syzkaller.appspot.com/bug?extid=8715dd783e9b0bef43b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba76e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17741ee2580000

Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

