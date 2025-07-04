Return-Path: <netdev+bounces-204221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79DFAF99AF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04181CC0373
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF12D836D;
	Fri,  4 Jul 2025 17:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA72E36F1
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650205; cv=none; b=F1S+A0ZXGdbQJbY3iPswk+bm9aPcguCXgHuVa7r55ckD+QH4DMXNmgP+YAal8XcMgvE6iA9HtUOd73yk9uXZv7DDxmyzKUAPpEuJg6hXGu/ZlpcrEymoCxkN2N+j49D3Q0aeea9c+T4v2E3A7VOk3/pHxyekTIz2fbh9RHrnd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650205; c=relaxed/simple;
	bh=zrYTDvGOlmSZtQrfORepRRVlqWrDOJpT6GqytBe+RZ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QGuvSop9EhnCCnMk87Plzi7OYnl1x+nKTYSzkFE+NZlN3ncLImATQnuDv3aBbLBxC7iKdVeYR1HqzuiPBPUdW+sJRpGMvAwpxTZjGTljz8v/Pw+km6sjB4vJ860MRRsZ2Ah30UQGeomUzThaf6kfQKimDbZdx8cJfJcBWI8BBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df4d2a8b5eso12046935ab.3
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 10:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650203; x=1752255003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXkQhBykES1nSwdbUE+gP2TwFAw0lH9cppHJmoIvqEs=;
        b=Tpz9fZLA63we6pO8GNoqfZmZLRpUxKbm6nipO+cA290aOH5S5rj3LtfoPgMPRmxJl2
         NQQ5/DRtBfOpIkvUVn8TQWmxiofMYTEzslkzx43aWwSJMODPngbJeTYI6M3azMW/cVWe
         c4SBvtynqH19CdPit90NyP6OJCWja+HFYpxdMkDcLUTiAfLHlYbXLLNUfN9VVDgoux2g
         1mgbuGPrrDd46WhfkXQH2QqmM6m0THLmt1jn8zR5OYJHSl5v/jYeGMLoW8kSC6EFl/n9
         +bK1aj3UyNJb1RcPLNwNzEKD3e+6a9Ks7uq5pFwbc7DNPUJwx8ai3Wxphdy5y7FLoDj4
         sqeA==
X-Forwarded-Encrypted: i=1; AJvYcCX2w+rqYXTxMQ9QOY0PA7WZp1pADEO8UQbu3EfOX2IN2OKUXwgBTcLKoH3X8bHJ+hntiMlwM00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitEc1xqP6lTsS+3el6qtuqzU4nW8LZifubz+GuvPCXQmA2NEr
	tvLKkHu4FjfdHBw/ln48NZn4aQ+GBgWEtOIrX75SQRQ4xG2UaT9od1hDABBT3WZDh0LnjgUBML9
	exSZvNuRF8H9GGW2XJAenfiamHFcO3Q2DC3SO6s+eXrXe8Ktr2y4N9w0HIuA=
X-Google-Smtp-Source: AGHT+IEWyI9pxgAMZpkdRCMtYs+ww+Ai87izt2xSQ/4Rkr020gu3HPFVzM5KSAsBLRXe2bw3RUQVRx3SWfZfux9bhBtL45yREHIr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2508:b0:3e0:5942:2942 with SMTP id
 e9e14a558f8ab-3e136ed8dfcmr22340485ab.6.1751650202835; Fri, 04 Jul 2025
 10:30:02 -0700 (PDT)
Date: Fri, 04 Jul 2025 10:30:02 -0700
In-Reply-To: <686764a5.a00a0220.c7b3.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68680f9a.a00a0220.c7b3.001f.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in drr_qlen_notify
From: syzbot <syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	nnamrec@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 103406b38c600fec1fe375a77b27d87e314aea09
Author: Lion Ackermann <nnamrec@gmail.com>
Date:   Mon Jun 30 13:27:30 2025 +0000

    net/sched: Always pass notifications when child class becomes empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d66c8c580000
start commit:   17bbde2e1716 Merge tag 'net-6.16-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d66c8c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d66c8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0724e6945b4773
dashboard link: https://syzkaller.appspot.com/bug?extid=15b96fc3aac35468fe77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14044c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14840c8c580000

Reported-by: syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com
Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

