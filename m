Return-Path: <netdev+bounces-233552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09BFC15539
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927CE1894F1A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B8274643;
	Tue, 28 Oct 2025 15:04:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7126B2C8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663847; cv=none; b=U6UQQ+GXu4o0ZBBMucCAf8WzkEXBhZcUr2HJE4Z6//J1ta4PUwDFUhr0knEO2F9wmN8JDaTbDJm1Gt9voRECv7p6njz1wx5dfPHhFtPcmq+0dunvCyJcgc3j24gpjFCvMy/iUGU5GTBUw8oJahnafuUdQ1Hsqflq2jlkwBWo/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663847; c=relaxed/simple;
	bh=YHNJ3+2Bl0kXz1AE7uKw8z2pj21d9oEcl/qcI/UkoCc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GEQkEpzoUo91vcW3xeMrDj3H9kltlFUi5m2wnWwb4x/vj8dg+hLRC/rA/TxKa2uEqcC5emn4LCeCYiCF0LWW/MqaGmsamW81GHZOgkGJOAtgqEj0DBYP0SF2b0n84x2m7TvXtMc5MocLGRxBRak6dzqewy1oZm+v8c9HI+AKExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so231545615ab.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663843; x=1762268643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WbENtpIuxc4z77nqKLhall3y31i7mXKp7vtElyIPCA=;
        b=dN+c3GWaon1K6X69Z+XUTUziV+tdwd6zPJVSM7lGCJkyYIOwJbs/UZru//9aFerRaX
         v1EWKiZiHr8D5q2OezibsdY6AI1CjHVl8/5jJpEcWq/4+f+mHG9jeV7uo+9fjlWqRHEo
         EVb1a6BGVT50OKP4/RXQfdVj3bjvQBMyVNzTjoU8iPLrNW+qxomSy8u5U+jiSnGTEVs7
         ej64Y1vc8bX+GqXW2nANLpL/21xyhdVhevi492t3ZWHLRedBJWAPxBYGOaI3XQiybSWJ
         7H/S1diBnraq/ygzkkSJKWc99nO1vd1haym/l5unkSUKRvmzxG/HwzpWegbtR6prTqLz
         037A==
X-Forwarded-Encrypted: i=1; AJvYcCXw68SwDBuBv//RFtSv1X1hVF5bux9RRwAMlQ9et9BSsKsFovZrH1NoY/YNIIN0MuuHDgXxLCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROfJOCvmrjjqTxbODXXS+l0Oaw3XWWRWTStEEgKkltQ49VSu9
	JJe3Pz/rhMqHAEa/jxue2yrTX/UFxzf7aQjkBDbWW3sHs30NvqotPFiGZ12MVhJxY+d+lKf2gBG
	uPui3aVvweBpCqEa/rycArgTXjRXYL+iS+Dnkr58BZKVB0DmjE7UhWUVup0c=
X-Google-Smtp-Source: AGHT+IF+EohZbBrSDQXXa4N4mZZlU7T6UimJk72y+wdqPoE4ji9fLb3tKUW2m3rfuTPzLylKbckQOUKWRw9X7p6OZ45VrZPr0uoA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4f:b0:431:d763:193a with SMTP id
 e9e14a558f8ab-4320f8388e4mr49779265ab.21.1761663843270; Tue, 28 Oct 2025
 08:04:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:04:03 -0700
In-Reply-To: <6890f71a.050a0220.7f033.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900db63.050a0220.17b81f.0026.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
From: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, eadavis@qq.com, gregkh@linuxfoundation.org, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, ming.lei@redhat.com, 
	netdev@vger.kernel.org, nilay@linux.ibm.com, sunjunchao2870@gmail.com, 
	sunjunchao@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 8f5845e0743bf3512b71b3cb8afe06c192d6acc4
Author: Julian Sun <sunjunchao2870@gmail.com>
Date:   Tue Aug 12 15:42:57 2025 +0000

    block: restore default wbt enablement

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b977e2580000
start commit:   759dfc7d04ba netlink: avoid infinite retry looping in netl..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0888b9ad46cd69
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136d9bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536d9bc580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: restore default wbt enablement

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

