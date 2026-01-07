Return-Path: <netdev+bounces-247729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C6CFDD3E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72050303196F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7B31812C;
	Wed,  7 Jan 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DvfsDV/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A931A552
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790822; cv=none; b=dZlzhn+f/U7t3M+p0bhRnlQpg+o4rPh0vHpFo+aM8vJnMRzdF7lgvHX64fBzQ/iT/c2qTnQ6MWCq491tyEAElCbyD4lPOeb//O168HoUNav1X8jqV3BetWcNWYcBjOi8wIE382b9veWFaIgSnBTXi2fbNgnb8Le0o6D63iyIyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790822; c=relaxed/simple;
	bh=gjLcioOKjCaArvb7NVQEop76HM4t8V/bf2T2jADtt1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL0M28DTd118s7RmMNOKxlL7v0hnq2TNGpqSBuEr7GR/2lfT+FC+KS404NYXnBphn9Wbgzd31YvVMGoPS4EhspcmtKzWIxTZs66rRKChqx68TSKSxaAUBlIMzeM8Tupyf4NJ4mtN9xjoewIwJPTXptEgIbyAuA3MXtWec0y2nWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DvfsDV/+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47755de027eso12147045e9.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 05:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767790818; x=1768395618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8OM/wM0uqGFQsQ0XBq0KDPlvIR+dfDKEQPKcNmmmRA=;
        b=DvfsDV/+t+DmuITWYJP/WCQHzd4uRUatvyLsinyOClSbHtAwdcM9UekwdbFZOf5cZW
         hVRZzcrRshB4eB1fjid1nPS01GBXhExZ2giM7eagELOPZsNx5LyptVZnJYky7cutrizG
         Qy96IYpHJVrqOjT1GQb0D4wP9mSTa9Wa0dPiucm4+yY3pFP+DG5EveYBVLGP8Tu/u79g
         i6hYAkNSb6SxavRvVyMKawduPQ/9Kqmx03Ty+3VtiXL74juBGhMwHUp1WdyM0G5bR+jz
         eYppZR6tv55yVJvG01V4JBrubLmegZjUOyxo6UMH+pcAMDDA39AEoy34/XWIgl6QngML
         uMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790819; x=1768395619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8OM/wM0uqGFQsQ0XBq0KDPlvIR+dfDKEQPKcNmmmRA=;
        b=bL9PBf6s/vY09OV8sYmV47Epxc8ksFPf1cD6MqHxAHrQgOdgSHZH1i8AvH/9gn3S5w
         94n+6Np68mTP6tfwwA4NZ8FK2y4iHmwKt3dgOIeC9Jq3kWr+xzfQKefcfjy4t3YHiMG2
         upUDjWwthBP8zhFvU55u5eA2ySSyR1cw0Qfs+FnLz1FYbt7+5I9GGCUxNYllgwU4i1mf
         o9uvACDMOqadS64BPOuA6osYRj12h55cbg61Od9N5R+f+siKXV5uhIvYS4kp7FAy+8r/
         WxRNxuGIMIRqB8qjYWhZdB9aUH7R6SqxCcdtdOKhp8KfkHrkBwRspLY9TRROqj392/SQ
         i3EA==
X-Forwarded-Encrypted: i=1; AJvYcCXKi0YdvVygEGzlR8CmzoNKWLMZDjCBC00cT6hCjPZC3ht2gZk6mmsIR21yWzbV91Zf0TsFZE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNsAJDGdHtAVmt0Q03ixpbSenT/ToBOsdUmbB4kICaiJdEhLx
	utV8avOzEXB4MmGWWNQRAw+kTX+zcpHRYcvCaAaV6LpyIRfk820wWEtwGmFcXza24xM=
X-Gm-Gg: AY/fxX6BvEzSYKln2xKnM30TkkzSiPXIQwmXTULaBYC66z8GfW+UVwowJYzepXi6qB4
	d/CLsT3E/wSOcwyREewN3E+7+E9+njemhuaaCbqf4qhbl0hMOlRNZTqTUi3nFUD6guSgQO4OkQ5
	BkWI32+YSJ9IXABqJW5DTzBd5n6c4h+xUWVtYLm3/ahMLYGW3Xaj7yYkzTjKGcVprRVrrzuzwNK
	fc/Na4c2BjtbS2ZdB9CrtmugrLJ65o9/izYdKm16vkxfxixuxjoCEU0hg6mUYgD3E65k3V6g4ke
	/FBSnolKx028Bzkjx8v8scoLsjMXHUTExyhHuhTyMG9j+6RCpkGYhNzNuy1dBCucE7UU/jCBGwH
	E7AE4fqH2DRq/30xEc0KBBuMDD/551sD2VXKVvcefgHtP0BEAShKHRMXs/BTaVkRYo+R8ZlLLk1
	UvppuTbQ7Cc69xTg==
X-Google-Smtp-Source: AGHT+IHXv9yotK6XG/wc2JBKVbd7hMIoqMUXk18WTbSVp9IFsDwfj8PCGizKHMxES3PasjFMQuD/Ng==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr29119595e9.21.1767790818492;
        Wed, 07 Jan 2026 05:00:18 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87189e54sm11153655e9.12.2026.01.07.05.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:00:17 -0800 (PST)
Date: Wed, 7 Jan 2026 14:00:13 +0100
From: Petr Mladek <pmladek@suse.com>
To: syzbot <syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com>
Cc: anna.luese@v-bien.de, cem@kernel.org, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, jhs@mojatatu.com,
	jiri@resnulli.us, john.ogness@linutronix.de, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org,
	senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com,
	xiyou.wangcong@gmail.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_file_fsync
Message-ID: <aV5Y3UG7JMJ0iE_i@pathway.suse.cz>
References: <686ea951.050a0220.385921.0015.GAE@google.com>
 <686f0cd3.050a0220.385921.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686f0cd3.050a0220.385921.0023.GAE@google.com>

On Wed 2025-07-09 17:44:03, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 0161e2d6950fe66cf6ac1c10d945bae971f33667
> Author: John Ogness <john.ogness@linutronix.de>
> Date:   Mon Dec 9 11:17:46 2024 +0000
> 
>     printk: Defer legacy printing when holding printk_cpu_sync
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b19a8c580000

Just for record. It looks to me that the bisection was wrong.
The original problem was:

ci starts bisection 2025-07-09 13:22:22.587055103 +0000 UTC m=+182.380303436
bisecting cause commit starting from d006330be3f782ff3fb7c3ed51e617e01f29a465
building syzkaller on abade7941e7b8a888e052cda1a92805ab785c77e
ensuring issue is reproducible on original commit d006330be3f782ff3fb7c3ed51e617e01f29a465

testing commit d006330be3f782ff3fb7c3ed51e617e01f29a465 gcc
compiler: Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
kernel signature: fd86d90e0d4e2b546bda0ba5ad3009b1c803f92f35eefc7a5a9a6a9779edb44a
run #0: crashed: INFO: task hung in xfs_setfilesize
run #1: crashed: INFO: task hung in xfs_setfilesize
run #2: crashed: INFO: task hung in xfs_setfilesize
run #3: crashed: INFO: task hung in process_measurement
run #4: crashed: INFO: task hung in xfs_setfilesize
run #5: crashed: INFO: task hung in process_measurement
run #6: crashed: INFO: task hung in xfs_setfilesize
run #7: crashed: INFO: task hung in process_measurement
run #8: crashed: INFO: task hung in process_measurement
run #9: crashed: INFO: task hung in xfs_setfilesize
run #10: crashed: INFO: task hung in xfs_setfilesize
run #11: crashed: INFO: task hung in xfs_setfilesize
run #12: crashed: INFO: task hung in xfs_setfilesize
run #13: crashed: INFO: task hung in xfs_setfilesize
run #14: crashed: INFO: task hung in xfs_trans_alloc_inode
run #15: crashed: INFO: task hung in xfs_trans_alloc_inode
run #16: crashed: INFO: task hung in xfs_setfilesize
run #17: crashed: INFO: task hung in xfs_setfilesize
run #18: crashed: INFO: task hung in xfs_setfilesize
run #19: crashed: INFO: task hung in xfs_setfilesize
representative crash: INFO: task hung in xfs_setfilesize, types: [HANG]


But the end of the bisection looks like:

testing commit 4ca6c022279dddba1eca8ea580c82ea510ecf690 gcc
compiler: Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
kernel signature: 03f8650641fe155806b39e47c854b91bf96ee0d5e9d18ff940235c5a21c89620
run #0: OK
run #1: OK
run #2: OK
run #3: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #4: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #5: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #6: OK
run #7: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #8: OK
run #9: OK
run #10: OK
run #11: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #12: OK
run #13: OK
run #14: OK
run #15: OK
run #16: OK
run #17: OK
run #18: OK
run #19: OK
representative crash: BUG: MAX_LOCKDEP_KEYS too low!, types: [UNKNOWN]
# git bisect bad 4ca6c022279dddba1eca8ea580c82ea510ecf690
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[62de6e1685269e1637a6c6684c8be58cc8d4ff38] Merge tag 'sched-core-2025-01-21' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

testing commit 62de6e1685269e1637a6c6684c8be58cc8d4ff38 gcc
compiler: Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
kernel signature: 8e4e982610da69c055ecca8aaca23f23a454eb4db0ee20d8bf6d5ae22aeebb01
run #0: ignore: lost connection to test machine
run #1: OK
run #2: OK
run #3: OK
run #4: OK
run #5: OK
run #6: OK
run #7: OK
run #8: OK
run #9: OK
run #10: OK
run #11: OK
run #12: OK
run #13: OK
run #14: OK
run #15: OK
run #16: OK
run #17: OK
run #18: OK
run #19: OK
false negative chance: 0.001
# git bisect good 62de6e1685269e1637a6c6684c8be58cc8d4ff38
Bisecting: 2 revisions left to test after this (roughly 1 step)
[0161e2d6950fe66cf6ac1c10d945bae971f33667] printk: Defer legacy printing when holding printk_cpu_sync

testing commit 0161e2d6950fe66cf6ac1c10d945bae971f33667 gcc
compiler: Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
kernel signature: 7566994b210981fb429e3b5e9ed670407710135484fee131b57299dc8b3071f7
run #0: OK
run #1: OK
run #2: OK
run #3: OK
run #4: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #5: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #6: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #7: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #8: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #9: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #10: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #11: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #12: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #13: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #14: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #15: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #16: crashed: BUG: MAX_LOCKDEP_KEYS too low!
run #17: OK
run #18: OK
run #19: OK
representative crash: BUG: MAX_LOCKDEP_KEYS too low!, types: [UNKNOWN]
# git bisect bad 0161e2d6950fe66cf6ac1c10d945bae971f33667
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[f1c21cf470595c4561d4671fd499af94152175d5] printk: Remove redundant deferred check in vprintk()

testing commit f1c21cf470595c4561d4671fd499af94152175d5 gcc
compiler: Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
kernel signature: a7cc6b185bdb5074103099a969663e598b6c2f53f61168a0f2e7c1d9bc9e8426
all runs: OK
false negative chance: 0.001
# git bisect good f1c21cf470595c4561d4671fd499af94152175d5
0161e2d6950fe66cf6ac1c10d945bae971f33667 is the first bad commit
commit 0161e2d6950fe66cf6ac1c10d945bae971f33667
Author: John Ogness <john.ogness@linutronix.de>
Date:   Mon Dec 9 12:23:46 2024 +0106

    printk: Defer legacy printing when holding printk_cpu_sync


Notice:
=======

The original test crashed with:

    crashed: INFO: task hung in xfs_setfilesize

But the bad commits around the potential bad commit are failing
with

    crashed: BUG: MAX_LOCKDEP_KEYS too low!


Conclusion:
===========

I believe that the bisection went into a wrong direction.
And the printk() change has nothing to do with a hung task.

Best Regards,
Petr

> start commit:   d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b19a8c580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b19a8c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bc8c0586b39708784d9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e24a8c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ed3582580000
> 
> Reported-by: syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com
> Fixes: 0161e2d6950f ("printk: Defer legacy printing when holding printk_cpu_sync")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

