Return-Path: <netdev+bounces-131530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD498EC3E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D24F1C21C01
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5DF145B24;
	Thu,  3 Oct 2024 09:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE5126C04
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947505; cv=none; b=VFuL2b38fcySviK75sJQd6judvNgAlazqpGe/QlxR23kuexJion6/4AP24AquZW4v2iEpu31y0cBMjQ2eDG6oKa6+XDgU2OQ7/dQ/x5mdMibvzFMop6wKlJQy4Q+u+UDsSAP31PdShm305+mbpoV7e22659p27NiQgbYvudi4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947505; c=relaxed/simple;
	bh=u6hj189GG+ccx5sT9uE5dt2cYmo61Ppx23L6w79uplw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=orhO7006GHJS04R4Cs29DhH6KYYxQtd1iYvlI+QaWiy+n3a/bpKlou54w6kiZjYgoouGrIDXUS0Rll+YLkz7bl9Hq7M1k6KevveUS/WoSFp/89cWbU/p4m+MO998gtPnaQMt3XnkUKr2NDoTp60b9KDWTejtu+aAbZ0+LQFbDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso9170865ab.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727947503; x=1728552303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQEshfdEcGt3BzOt082LjIEo3dV5RB8eEbAA9cnWdn8=;
        b=uDvJ/dabeRtqY/HRYWHyelbD9eZI7kcGjirymDXi4CYbccrAq1wjZKLW3nM22oVQgB
         20gz4T7+AZF8BgBMAxiYVX6LfLGWKci4X2K1gjL6I5iQInAhFmCZBLHiEL8VfwkzNaST
         iR8JOYE5KeLwXtSvRCDzX+dejDnVqIXidlB/zlsK2FEWDX3IoQ+HWf8t/Axv8RfuTNj0
         /XJMIsxDhz2iuG6B2RdUlTiNZPRsX20+79kMjGlxvoexp+D76JX1omPFFa2Yfx77I9EU
         ucZh9syyL8E3A+WaeCbi8fW25RJUkuYZRiTtcIppRE41JuNh1d04rR3OvBSncUSH6ULJ
         cyBw==
X-Forwarded-Encrypted: i=1; AJvYcCWxeCN0zOqqe3qrLdz2m2cgQe7r0NWASVgx256RkvcccqUnbHlDyrfK3Dq+lMoe9M3fMk44MTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kg2MX8K4vB+lqwwIHHzljAtiCifu1ik4xYfrMRXRJw+DKy/Q
	/SIaS+ymeIzRM0RyMTAWxs/shQOPKH3rQ5E0/N453lsVQxS7uyWgZ3rLW5/NVfWInLHVVB6P56X
	6v8GWHoEboHGjhjxbIOQTBWfDXiZ9Q00u4o8qvOmiKsqaqlKOMol532g=
X-Google-Smtp-Source: AGHT+IElf4ihqnuzO+YqiAOsKc7D59PFA6F73np4DvD07a+VhDU1pK2PoluZK6X4VfPWXzcJ9ioBFOy9K9qhev6nM6Y4tbNfoBXo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e5:b0:3a0:9013:83f0 with SMTP id
 e9e14a558f8ab-3a365913588mr65485655ab.3.1727947503083; Thu, 03 Oct 2024
 02:25:03 -0700 (PDT)
Date: Thu, 03 Oct 2024 02:25:03 -0700
In-Reply-To: <000000000000bb900e061440909c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe62ef.050a0220.28a3b.020f.GAE@google.com>
Subject: Re: [syzbot] [tipc?] BUG: soft lockup in do_sock_setsockopt
From: syzbot <syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com>
To: bristot@kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, hdanton@sina.com, jmaloy@redhat.com, 
	juri.lelli@redhat.com, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, vineeth@bitbyteword.org, 
	ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104b93d0580000
start commit:   3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=124b93d0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=144b93d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1636fe27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136b5e80580000

Reported-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com
Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

