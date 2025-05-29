Return-Path: <netdev+bounces-194088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BFAC74BF
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87091C0165E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8315E8B;
	Thu, 29 May 2025 00:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0A1373
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476867; cv=none; b=l5XwyYGcI2WmUSX2c5Md8y8Ak9HBCsLxdyYAQLldcW1q2ORE66amLQxNtaIzXvt+04Z6nHOXNbTTH6mdX4t4ZZZ1skmdUk4jwPk625QTnq9EStCQGhx6FtIr1UT/GL+lfMfqDj0lr6S1lYOZfukBJ0ZuEHDxBchwrIp55NW1cLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476867; c=relaxed/simple;
	bh=Fa0O1NjH1sjPtlGGyFIGirvKwYKd98rA44oZchWQu5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yq6Gcs1eiIIC6IwRYbMvimanEYPe3YYKScMrM3UUm09tb1hLSUjc9qmYQ4innJzASAGC4/b+N6TgFy5XATECwJtQba4GS9auO8DtC8khK0K0x1F9Na5bbQYNQLiOhlI4BHPZr2XeBNFYjEu/bknwpWFEmiD3GmK8VOcC+fG8iyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso27872839f.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 17:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476865; x=1749081665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stvlnMbcdcBYZLpd3w6+KPyvEkXRg2zxOy6ZStT7IJM=;
        b=GMF1dAegyHobT0vGQEOg8a5U1g245VAc0kTxjmAmzdLrahVus+0TKkdRsDhHk5+tx5
         cQ2DNn5K443z1bD+YAzgJPqUAMuRr26qnoJjUIivMPum6CxAl3OJfDhNbuteyA43a2be
         ZfK4iv6vdqvZ5El/RwmE/JZVRTJ1Z26idOk3bIaY5Q1CjcBNFZmlmHj5qmLbhFIhqMfc
         C0zQ2Kh1HwRrrWJbjEW3Ea7cuBY22CoXEj0zgAFih2ZBfNDOdg3dyRN/CliF8zQNB16U
         R0LKdm1sbL8gBAL4ZsEbe2Gdij+LiPp0xjo6p09svGJMD2FvpkLVMgyMz/9Y/xyLxobp
         /KWw==
X-Forwarded-Encrypted: i=1; AJvYcCXwbueT/qN/4SFJ/tzaNfRI3ajPELKyyUyAC2LMNZbHn38tm/PfRepuyCJvMKpfwBtIwpJek9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL86uKnahlR8wDJWwnJeP8QbN0Qxjm/ADywFoN0acBFmSL6Ypn
	Be/gnvbXlUHsS9RAfuHYlyRG4du56YV5rgTbTc1cyHxWmQs08eRaqc5K8HEKnXEkBP6+Wi+i83j
	GOdopdz2vgFFz9gjOX3c+j5luZc6WMXq4KgsUcw8AdW7Rb/eri25eaklxE5c=
X-Google-Smtp-Source: AGHT+IE9VLpPsp2Q+7yXbHW9kBedtEHr+eCFJ1zkMmpIBTT0dGaXXX/zJ9vzHwbxhM7XEMjyiLyurnHeieiKw8oYYB24XJQopFoa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c08:b0:85b:3f1a:30aa with SMTP id
 ca18e2360f4ac-86cbb8edda7mr2276380539f.9.1748476864762; Wed, 28 May 2025
 17:01:04 -0700 (PDT)
Date: Wed, 28 May 2025 17:01:04 -0700
In-Reply-To: <00000000000039e8e1061bc7f16f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6837a3c0.a70a0220.1765ec.017e.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	lkp@intel.com, netdev@vger.kernel.org, oe-lkp@lists.linux.dev, 
	oliver.sang@intel.com, pabeni@redhat.com, schnelle@linux.ibm.com, 
	srikarananta01@gmail.com, syzkaller-bugs@googlegroups.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Apr 7 17:03:17 2025 +0000

    smc: Fix lockdep false-positive for IPPROTO_SMC.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cd6bf4580000
start commit:   88d324e69ea9 Merge tag 'spi-fix-v6.14-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b13e98580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131d9c4c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

