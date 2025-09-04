Return-Path: <netdev+bounces-219982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ADCB43FF8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83D95A18B5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFC308F17;
	Thu,  4 Sep 2025 15:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7569305E1D
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998427; cv=none; b=Swkk2Qe7KSs6iXhfla4QWbZdbsQdXhJ6MKcGP2N7KPE0mB840EbMCoJP4wwOD61YE6VszTrYDV+30J8y94L8mfpQisv51s8xvlY0Qw2XbpWaec2RcGvv0sDJQ4hPsbFfC4qExEvOqTDCqt96LqMcEA4e+yrtZtIsnKeMpZwVPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998427; c=relaxed/simple;
	bh=WdSMSR85x87X0+DfffqCowskGNW4tPHLqZlvNo3jcgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e1oXNkjKBkcXBPIeAQf8tWhvso1sr3TkwDqn/Y6j1bK+x4WBfgLHvH+ASH/X2OwPqgnmjercR7WMPoF6S258w4zURZD/uE/i3XfcZwmwwX/aI1QkdjLzAxo0Uczu0t2vlnnO1xiXENksD4xIkmxtnCfw9kCtMs/l4px/6u2RtlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8875640a843so139040839f.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 08:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998425; x=1757603225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLO91xyldPwJGtv4KAJ9Dss03Zr2mNg6Ty96jb715OM=;
        b=NQYgq2AgAgXnGW8nsDJB+HpWvi1UctrSggQqMFRj1ynNB8hTtbG1EUaDAs5yvebboW
         ex42sB4TlIlO2RXtLJMDnjDN4AG4TzDZqhx5m1SQc/iuE6LP4dEj+FmDawPA4gvfIRMu
         znwe1wz3jjEWC67YYMlCa0m88KcFVsbY3O7s2U5LJos789n1ubkqD+CPYOelhE1ZxS4q
         /WLtyJpArS58QmXQASTcwC8O0MxgmU/R8amMNdLF5VLU7PsG++5bZKoU5vrrr++k6ypa
         M1KpaQnbXLs7mx8KkSJ8Kz8iBD/hnOCrF0C0IAKGGA0ceaTm0GWzIbHwpNntFSU2oAVB
         WDCw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbNKgEMxeLO21rDbc4HZEcQ3hRLyZw+E+f+F77UdhQbTeIVwjNIBWYSFZXo/KubyYsygAoww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWSIZHbBD20FYkHs50a3j6w89RMLrWcHfPaygdcbx7FhqyygR
	67NhNuMd9K/C51IE+xmfvrZ+IFcWnhbWobGy6xiCcNGraG1IeLXZPqs5K3DzcBr8/LHw92A3B40
	4hYc09OIC5OO/s82AVceM7+K4qwNxpm+53lbq836bGcU94DBXNx/hdaN/DEg=
X-Google-Smtp-Source: AGHT+IGPt5XXPZQ71LRSq35os/98bkbkleFEzJZRK9KO1wphEAorWaJE0sjRcGoS9N8q2GtO62tIzPc9fUr+UXPnANVDnXDcNjgk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:3ef:969c:c91 with SMTP id
 e9e14a558f8ab-3f400097800mr372808605ab.6.1756998424765; Thu, 04 Sep 2025
 08:07:04 -0700 (PDT)
Date: Thu, 04 Sep 2025 08:07:04 -0700
In-Reply-To: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9ab18.050a0220.192772.0008.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
From: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
To: apparmor@lists.ubuntu.com, audit@vger.kernel.org, casey@schaufler-ca.com, 
	davem@davemloft.net, edumazet@google.com, eparis@redhat.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jmorris@namei.org, 
	john.johansen@canonical.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	paul@paul-moore.com, peterz@infradead.org, selinux@vger.kernel.org, 
	serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit eb59d494eebd4c5414728a35cdea6a0ba78ff26e
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Sat Aug 16 17:28:58 2025 +0000

    audit: add record for multiple task security contexts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1199fe62580000
start commit:   5d50cf9f7cf2 Add linux-next specific files for 20250903
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1399fe62580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1599fe62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d2429dff5531d80
dashboard link: https://syzkaller.appspot.com/bug?extid=bb185b018a51f8d91fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b9a312580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16819e62580000

Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

