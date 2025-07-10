Return-Path: <netdev+bounces-205592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D729AFF617
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CC5171073
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7B433A5;
	Thu, 10 Jul 2025 00:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E78F54
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108246; cv=none; b=Cq9hTdQU3nkx+eRD865EGXRAZ5/lFxp00USGwOt4KgooNTmrDSWT0J26e2ym1p23fdTXZsRMtuzBIE9NZcNnZt560vsZn81uz7Misz+wpZkB+4/XnZCjnEP7kw12wqaBIy9eV3DrY4oznwwPkmoV+2PabAi0atgAYRDqgZl6KsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108246; c=relaxed/simple;
	bh=GtFfO5UBSQpd6M3n0qyyFSGpUGz7IH8edCIj/6qkjNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FoB41JAEnkhhs+CcUqQwm/Tt7trmCl7n62miLij7WHaSLywjxiNNKEgn6GOwiRBbhIEkZ0b5SADCIa1QnmD/PMx5UDBcDoUcYVenZIHDrLkAwNl93MUJ6zpMpKENgPu+x88Y+nxVwVizjzu3T8uSSfPxFMO4ZZZaEdkeG554t7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87313ccba79so89808439f.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 17:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752108243; x=1752713043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6ubFXBJaVX9NJ5Nijg0B0BPCDcgJxeSI1/VddLlHAM=;
        b=EfGta/yzd9y5LB2zyLLhkhGDwg0RUBBvg7Z2oeaUDxz8/AnjVQM43AlvQG6F5WumH2
         YgxSiXuDmdi0w7N93FGa7/P1KMOwyNPv860cJRyMFVnBS+IBWclBTQcTk9IwTe+d2gym
         pcamb1Qk6rIxwWFbvGb6BePLHM655aZaO3NdLPuVgtUZq6z5z6ihi4SbKny8Ld2KuRDc
         wDq/DVv3z9QTACO1L7F3Wma+Ico8o80+WnlowaBjv+NYJs3xx0I+3Nh8tL7MrDBTfgsI
         HqN68qXh3MY4Pp9y2DBuADqforB6VS2JHDuHeTWhZ35uCu8Ufvch6nL1OJK2TiNXfVqW
         YmxA==
X-Forwarded-Encrypted: i=1; AJvYcCV5o2rw5XL/74JM+Zb7HDRZkbxhfue7HQCVBkpdNsF0whoZFeQNzkmfro8GzoujLhlKcWIMOpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX44yFtcwJFHa0fTMP7FfV8JCs4PxWciO5B9z8FVemsgCS4MTa
	FGcc367Z4PReh5pqB3/MFdRWYHbJB8QRjH6sWrFulrHJ6msakuDMcpBG6x2vDFyZi0z1MjDHwFd
	IYbbhCBS1rdIeWrN12jq0d+j4ROjk7rzqdlf9/CYkEswgMjxR10oseOZPu3M=
X-Google-Smtp-Source: AGHT+IEEZTrsGg61LrPeklxaxuumgz77c9VLsfiGovZIPBLMORTLfebejWKSzMwqiccyUFrmz9OwM5HLJ3KvEiSnw5pXU5bjBcFZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:408e:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-87968fe0bedmr74344039f.8.1752108243595; Wed, 09 Jul 2025
 17:44:03 -0700 (PDT)
Date: Wed, 09 Jul 2025 17:44:03 -0700
In-Reply-To: <686ea951.050a0220.385921.0015.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f0cd3.050a0220.385921.0023.GAE@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_file_fsync
From: syzbot <syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com>
To: anna.luese@v-bien.de, cem@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	john.ogness@linutronix.de, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0161e2d6950fe66cf6ac1c10d945bae971f33667
Author: John Ogness <john.ogness@linutronix.de>
Date:   Mon Dec 9 11:17:46 2024 +0000

    printk: Defer legacy printing when holding printk_cpu_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b19a8c580000
start commit:   d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b19a8c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b19a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=9bc8c0586b39708784d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e24a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ed3582580000

Reported-by: syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com
Fixes: 0161e2d6950f ("printk: Defer legacy printing when holding printk_cpu_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

