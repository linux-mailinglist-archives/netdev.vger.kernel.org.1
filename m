Return-Path: <netdev+bounces-246365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A865CEA0C2
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93E6F3004E2A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338C1F3BA4;
	Tue, 30 Dec 2025 15:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F813957E
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108066; cv=none; b=XwCWWB6jVtbXMd/zdiUdy0cJBar4AmnfRhuZi1HZ9OICU/XCoh6vOjXoym5B2F4UnMQKDllTLmyTpmOrvdCCzt7OyeRTPp27mXWeYIrpwjraz7pZUMhKgzkEtGSh8KV2n97aYj5bq6kZExZg8gZrj3laWyHsp3Wkhn6oSzloh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108066; c=relaxed/simple;
	bh=UqefMjhSVqeqxZ7cw9SZ3XXPaID45kiWVvBSiFES5nw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j+Jx3WP63/RZt8SR6MIuZP5u0Qvy76QpA0QrsQuoM4MbI2wvhH2uOXRHQ2vV1kbHvkaDYY3V2lfYZZgzV7OlfQDdBfwpDg4SGOgG4CHXXwMcyaQMwFzJWZ+3hS/zlI0ofWxL9FYgvJveLIng3+sYl3AMyJ0uhrDwMQdvbAbZHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c766d79592so24481204a34.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 07:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108063; x=1767712863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mGAIhaLqmqueebz091ruC6N1hhdYb289JyV9x3owoM=;
        b=B+5yrqU/IGhJ+Mw1V5spNPfbhTbT1UfC8TXFGJ93A7ciRwdazRG4Vmb9ZXAFkp3BzO
         21oJsv+/j1+cLMQeqQ2hDrPaIi6jRuAFv+wMCoym0z0nhGr5gS7oaYltNw8x1fS6QiD0
         o/x2La3qKZRINSMWKrgYL6lYjmq5uVWGhu46X94JIltlicAWLhBxynpecndw5NKIpP5V
         fKsrKIvD4WUnzc6CXg3DgWGl0WTu0zjl3IEHgEIZOAQCkXu9Hln/o5wIlOw5bbStBIW9
         +L27L6eA3NcnM/4+bmTGuisaISvuaJjntJAug1on6Dfwkpsi7TRav3tX5Lnzic4A7OL2
         yUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZK95Ohzn5gEIoY7CraMfU8ssr5RHdSs+SAWcaUZUx/hEq68DRtZ5p923DkEk7ZN3BdzOV3wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tFC3oFPC/Fw8OFyjzYUY4P93DoG22eW37XduJRjVJk2t7mBQ
	lcUNO4BjtUi6865cGtGAII5V0VMQd7or8nVC2ta1lwSUc8wPiM2IO5oeCOI9xc4iqIzAotSYtan
	n6MJ4ajvMc+Nx/m1aJ4lH8xWLL9MQUcIMJ6EDaHBzrOgBYJUJT7Q+rvvCIRU=
X-Google-Smtp-Source: AGHT+IHkKUH30RxqdCakjTYB1Y4xBbuTNTd0OXa/1EH11X4dbUPXfPlYah/opolSsQ87AVuh34brTp8VvzOuaj9iGfTQpVdHJrW1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e1c9:0:b0:65c:fb86:8a94 with SMTP id
 006d021491bc7-65d0eaa2672mr11026884eaf.36.1767108063158; Tue, 30 Dec 2025
 07:21:03 -0800 (PST)
Date: Tue, 30 Dec 2025 07:21:03 -0800
In-Reply-To: <686ea951.050a0220.385921.0015.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6953eddf.050a0220.a1b6.02ff.GAE@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_file_fsync
From: syzbot <syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com>
To: anna.luese@v-bien.de, cem@kernel.org, cmaiolino@redhat.com, corbet@lwn.net, 
	davem@davemloft.net, dchinner@redhat.com, djwong@kernel.org, 
	edumazet@google.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	john.ogness@linutronix.de, kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pmladek@suse.com, 
	rostedt@goodmis.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b9a176e54162f890aaf50ac8a467d725ed2f00df
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Tue Sep 2 21:33:53 2025 +0000

    xfs: remove deprecated mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1481829a580000
start commit:   d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=9bc8c0586b39708784d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e24a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ed3582580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: remove deprecated mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

