Return-Path: <netdev+bounces-242648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF77C936C5
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6285E3A8DD1
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82F1D5141;
	Sat, 29 Nov 2025 02:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446371391
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764383765; cv=none; b=egrof86GGz8DuiQaGYTN/oAKNTWD5Dsa8/oXze9b0nRfNLQ3A86cQ38ftxWFUK90Co/wAbvzYEJq/U1/83Q7OEDKpO9I4kpMBgYkQa3O1V9mvxHO+YCiJskT1uHI6RxOwx1ZbhqxhmwE1vuJgKH8PCKhImVzVZGV68DC+b9pMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764383765; c=relaxed/simple;
	bh=jlZEXuQWXu5ozxrt8BypBEz5DV4RECDx/SWkMeOE0AA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RuklsWcOIOvYFVhwYQa+sjsNfDTFaG+k8JvPL7l06IIghMTic1VNJjDo5OpIWFV5pJnni8mLAzOGMgIgeYbPC95YdPwgHhhPW4tH1lPS0g+wDkzIIabq6d9F5BNBQD2lWiG84Zyeo4xEtDWiOaVyn2McnoNc0i6zyS6xIUgW8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433817220f5so26470225ab.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 18:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764383763; x=1764988563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVRUBzkEP3RMuIBQ3Tl5nQf+V+9fs47XPY85CjU5KvM=;
        b=SNBnJtedRaIOB/bLMyIwb8JJkt8kErJ/MblRKL2ieyjBmsty26GbHiYAhmjr6/Ka+X
         L81l5MM4nCHpSqcyDEVnTGNNqAF38sAMQS7kQcb0AU4dr5ZPnjLOVIcgkGOkl6FOqsys
         Qwh8JjB/oszSQOdAgmwJ6Jp4S7x7DUi7Mc3RFeUkr1av23dUlxwkiQ6wisdDaRsAhf31
         SbmWnK2IIC+SbwUAZr6rcWmzdIbH7km4OrMntx6V9rNIZ43dAF31SbeLG3n1zY9/dGXh
         le4K6m2zfGMJLMnA3ROT1UPUYBzgJtbJnUeM8T+VfokJCUInOACua0/xxDKQZHCkAPch
         Zt9A==
X-Forwarded-Encrypted: i=1; AJvYcCXfz3bkbuC5krpeeH3TJ6mvuxrI8x+AsGj9xi5Y9Seyf2myHjwo8NYMQHyEfuRC6j8+vy3Iobc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYawhCtBhKzX5ZhdB9mtAaikx+7136NvuHljd8KukISLjPwUTf
	dA3har07Xxiv7ltK/mQZ+AX1MDyIprT844vEDHllOsnhq7LkV1vg6WK0dwAtJjDL5WU+ol++9aQ
	jSphr9XrcK0rudwZL+GlxVHDhid1I7fZnL24FoOI/XpfnsaV6Kl1aH/Nb4fQ=
X-Google-Smtp-Source: AGHT+IHydbCiCWptMvdZJJTYFFUSNUtPQL7d2uxIm2t1vOswku86+Lxz6bLFY3tjyA7SIawWScMjsovqijGzIoMz7DhH0AALW0E0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:433:70a2:4bb3 with SMTP id
 e9e14a558f8ab-435aa866741mr295475715ab.4.1764383763554; Fri, 28 Nov 2025
 18:36:03 -0800 (PST)
Date: Fri, 28 Nov 2025 18:36:03 -0800
In-Reply-To: <20251129014743.1368452-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692a5c13.a70a0220.d98e3.0156.GAE@google.com>
Subject: Re: [syzbot] [hams?] memory leak in nr_sendmsg
From: syzbot <syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wangliang74@huawei.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com
Tested-by: syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com

Tested on:

commit:         19eef1d9 afs: Fix uninit var in afs_alloc_anon_key()
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a88112580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=d7abc36bbbb6d7d40b58
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a9be92580000

Note: testing is done by a robot and is best-effort only.

