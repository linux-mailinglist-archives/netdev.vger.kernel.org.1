Return-Path: <netdev+bounces-63457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E982D0ED
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025221F215ED
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40EF2109;
	Sun, 14 Jan 2024 14:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A81C14
	for <netdev@vger.kernel.org>; Sun, 14 Jan 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf44da02c3so6748039f.1
        for <netdev@vger.kernel.org>; Sun, 14 Jan 2024 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705243024; x=1705847824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wt6VIBHV5JomMb6G/SAzgkJ/CF86v9+FpIHEpcIi30=;
        b=BuO6M/j45RKtlEelEvPMx/fkOoJRE1icn+WPa43gdLUH1V1iLEczJ+Exsg7H/3Pc6p
         6Z9VC+l5iKXPgZRo0wGnt98tL/q8xmpPV2gz3v3C9x4+NXa4SipiGtRFHEFA951Vro8y
         Sdjf3tfs791B0uRHSpvKWhIC43LeeKxt+uD+FgPdsu42odbTAONT+1weuFAazXntauV2
         tkjc62fu1eALGmZ8qM1KU2p9KRZMblZp17HzzM4KQQ/mVuw94BQ8VsNBmaOJOI6qXjqe
         Hli1NKjNzUhJqzGPcD8CrZi1SRtaqPFdz4jnqHDFGbOYx4cWV/KE8m4sDuofEgJD04Pe
         KAAQ==
X-Gm-Message-State: AOJu0Yyn0hs0O9gysXtzfTYSaxi8doq8Qvj/e+HnkbWuPlDYvPFARVln
	F64fn6uNbAVJoySEt5KYEniGjeQq3keXmLpoYjfayuT9yMQ4
X-Google-Smtp-Source: AGHT+IHZJp1y0/eT4Y5XcGEZHHluMb+1c3lYitvG1gsjKxbDv/arVmEig0IQH/tbT08VemxEN1ZaDQXwh5BN04ZeASt4LhxR5rpZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:35f:d260:57b3 with SMTP id
 k10-20020a056e021a8a00b0035fd26057b3mr398021ilv.3.1705243024532; Sun, 14 Jan
 2024 06:37:04 -0800 (PST)
Date: Sun, 14 Jan 2024 06:37:04 -0800
In-Reply-To: <0000000000005ab984060371583e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbb70f060ee8d44b@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From: syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com, william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Wed Oct 11 09:57:31 2023 +0000

    Bluetooth: Make handle of hci_conn be unique

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127944c1e80000
start commit:   4b2b606075e5 ipv4/fib: send notify when delete source addr..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138aad9e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125e0b92680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Make handle of hci_conn be unique

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

