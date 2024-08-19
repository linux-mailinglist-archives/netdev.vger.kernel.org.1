Return-Path: <netdev+bounces-119554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8B9562AB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7440282385
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8771448E6;
	Mon, 19 Aug 2024 04:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636213B5A6
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042404; cv=none; b=Lihl6yRdyykf26ltyo7sQrX/2p4UOGzpTjIEK6LMskEj/IcbbpRc+rq3iIakLmix+xJFaetqEDGdpyxVKb5q7Rjyd1u6j9fRldntHbjY1xymIRw7rzdAq9Gv4jvQBmAoewDXSDbOW2B9RveOtdjGRPeIbm7C0QT/5cW8FasyAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042404; c=relaxed/simple;
	bh=ndPGcz+uTi/bIYAnyjXxTlLhFjz2KeP5UQ4eUxYbKxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MKZJQqiaibs/ASYH7Gufnb+yxftNzgeIJ0dpqDY7kdJiVHX72cyDqOtTnLY9QhflaHZuRb84cEiPwQIncQoKUcGCfBEretIr4NjFURjPqjTWglT3U1ut159oPJi7O3sAZ+UAvo4Vid0P31yn3MfTPah7fHa8lBauyI+rh+rYlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824cae494e3so378625839f.1
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 21:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724042402; x=1724647202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QxjT7FBtIf+YOOl5Ydo57Y1HRHDgzWdhn/AVlpRKbU=;
        b=WUmxbqRf/YZemeVJNLs7PcR7tVzq91WKR+gokqyTfndKw2T5yS8k3Ql2wPdBJrRjSS
         EcPAi4Ne2QI+UMMEJVEOaJCdTsl75BrrDSt8emUiQrUGM+Eo5iXDW5fs4444IF+OK/ZD
         wBKvaplPeQHzArdMk0FxwdAxhkPsrBNcJFAkF55wBsyl03uFF5RNwkKHkh1Dmm5wqQcc
         +YN6HW9oXKiCi1MRRCNXYlZL+sY9nD/kbk7kwc0+eO+kIiBaR7XynVixichFjVtfhJbw
         ywnks4q873Pz1L1ADNn5OnYZcJ0MXVh8KFOAc/XCQAiOw4+VnelszzhNfXhkKlmIMt7+
         mpCw==
X-Forwarded-Encrypted: i=1; AJvYcCWQXQemeOU0CvxH9BSHRo1ZvVxMZP//lW3VBGp2ViuchfYh5Fy6zhGbqDL9crxeIabmUhIYXqYR4jEBWfUTZydUH5jiOQMJ
X-Gm-Message-State: AOJu0YyMZ9d2tTh5kIQDSLjQU946uDHVW1/ZlsKWy0LWI0yJ/9UH67nX
	4GVbR4jgVUT7LNuBwjUhmgc59CgRI7wEWdDaOnK78he0H2iCJ2ftcCl1lx+0CV5ncOOumDB7nqs
	EB1f31/0LWrLEmwvlUmBqr8cXUNzvsXQGeW6O+rSrxRS4JyCImCpxOZs=
X-Google-Smtp-Source: AGHT+IH316qYQj7K/SEBVPvVeG35zflMK2F/Sc4nwXd5p9/IyQ5MeXxoQPgP4Q0j6l2BAJ0YCA/7X4FcoFqLlYh6md2L53cvBiuo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4cce15cdbd5mr504210173.1.1724042401927; Sun, 18 Aug 2024
 21:40:01 -0700 (PDT)
Date: Sun, 18 Aug 2024 21:40:01 -0700
In-Reply-To: <0000000000002be09b061c483ea1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1e97e062001e6b2@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
From: syzbot <syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	nsaenz@amazon.com, nsaenzju@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Jun 21 01:08:41 2024 +0000

    mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d48893980000
start commit:   a12978712d90 selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=736daf12bd72e034
dashboard link: https://syzkaller.appspot.com/bug?extid=16b6ab88e66b34d09014
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125718be980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14528876980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

