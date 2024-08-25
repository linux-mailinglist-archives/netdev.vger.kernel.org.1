Return-Path: <netdev+bounces-121684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBB95E0D5
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 05:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35BB2825F9
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C48C11;
	Sun, 25 Aug 2024 03:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193961DA4E
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557026; cv=none; b=ko6kVeCMFKiQu5cs3SSAmfebkZmhRSm1r1KpzsOZKbrhs3JqULLRITWy2eaHD9R1TJV8u1ezXOJIEdlXC7TW4OVMfLYwuG753V6a/jKtXRQ8hRSyhG876NZdbfzOaWk9aIFrm8CkCEkz/6MXOkg59WZ1M9254fXkGWT8SmLyoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557026; c=relaxed/simple;
	bh=qs8x+3+P7R5Yu46yXDf1sNvEY3Wimh2kH94I3uOLjq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lN9pgBHzmsNbG+ThVnjspAr2YfG0PNxKLb+xK+BZ6zEPU327+rleKdi0KFLtrCD+RPmOhRrEahSp8FmxIFhqCgm3YVW8U6VhtcYCknmfeUbhbb9Owj49NvzIwknzTEKVwBnaCPyf5Lmk0ywJBjKU9mbvjbHQbPMJRvTeAuFUrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d49576404so34042885ab.3
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 20:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724557024; x=1725161824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Y7prTirX60Zjf7MKnC93bQnU3UQk7j54mGU0BXZMI=;
        b=MCFrHDCdRzQfYxCNHQQnJsqeYYtF5KOgdKU2EG/meOUXt8TOKQsJPsmCdstZfk4pBl
         xF/vwQu4zik0XbLgUJpTyJEHJKkSnlqSNLC7/lOTIdP9Q2NZ3uRIOywdarBI5Lg4Xv1c
         THQYi2ZacuM2WqN+S9zTfK/j6UCmcj3R3nOa1fPhOWNUStdAQ9hrlH7tAQZ+x3XDAhH3
         sLQ+O2il+aO1Nv7KE8kU1zZvBp4KAC9Iy+kgC2VyBfNg0PLvmXY3RntGEf/uRuZIp+MS
         2ox1Yo3ILtjWl4rNhgYxwxNnoWqOYEXk8FooMUfMCtOPGXF0Xl1DNXffty51GpwEkext
         1h3g==
X-Forwarded-Encrypted: i=1; AJvYcCUCJDL/9shr8tG865jlvVGboLAXnSK47qwMgYH+T7J5Y1F5cFfYKVdYz03BfMKO3Pjt8xvxUiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdJKNTDsQC5Izy7058Ta9JHmLpizPXziuAiCTKSY7J550fJTg
	XQKIGg/PvoAWCnUd7+Lg5DW0IHZ48VvSDDhoCW9cjnLb1KAF6ELUNyIQwkc8W0h+YfZOHgV6tbf
	Lh+lO/rY4+YfuGmqRgGR1eDyWbVZKCdgC9oNILx+N362fBarg+08mV4k=
X-Google-Smtp-Source: AGHT+IG4h7J5l4jttEEali2eWLWHbj4PjUwD+750YNkmr8ye40PAEwm3+AmjpuzBBHHVSW6sVcYvyyKkJNP/kSyTJnB4YaI/A0Rt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39e3c9f5955mr6047325ab.4.1724557024186; Sat, 24 Aug 2024
 20:37:04 -0700 (PDT)
Date: Sat, 24 Aug 2024 20:37:04 -0700
In-Reply-To: <00000000000039e8e1061bc7f16f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d26462062079b885@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	schnelle@linux.ibm.com, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d25a92ccae6bed02327b63d138e12e7806830f78
Author: D. Wythe <alibuda@linux.alibaba.com>
Date:   Thu Jun 13 18:00:30 2024 +0000

    net/smc: Introduce IPPROTO_SMC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e95825980000
start commit:   d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e95825980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e95825980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e70233980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a44815980000

Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

