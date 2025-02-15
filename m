Return-Path: <netdev+bounces-166689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDAA36F6E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636DC170F83
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBD1E5B77;
	Sat, 15 Feb 2025 16:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5961DE2C7
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636523; cv=none; b=bQgvHx+C/RvchC0ycb0Fnl5PixAxz2E4/v6SGqVYhiRv9WtbKbr5ByNnqF5lPzgiQLlDf8lVAJeajQk9QlrcZeGZHAZ9xkAz4/sVy3SvvbWyfrXWiFnqWk0XDAQoCP/EUwwM4I5YbjxQCH8//tX/GuLT3NwyYaL+R04Qom3fR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636523; c=relaxed/simple;
	bh=IG/5jApV2sOSl8a3GEyu/nbUQiVzZuOltqY088VSr6s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kd8FssznRUnBTc51IeeOz6cjoz813QUU9+1vtNOeyXlnnbnAoRT/dlLlEa+j/BzTYnCM1nzXTm9wcjYL9D6j3EP7dYrw9we9rnCilLkHz/+hq1PACN+2R4uoCUpvhCmcXS1FPr7PRWMvc+XZl2OY40NOoCLB1SXJ69AOHu+AtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8556ffa0a99so133528539f.0
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 08:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636521; x=1740241321;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0qTm4qCvLRYalG9z/HrHmtBGe5kHsJD0r/taF4MuuQ=;
        b=anleQd6sha/bCN8ptzGC3idz9Btqg/anGi3gecMgPnoSEsDpk/KDG4kY0/wMnG4Q+Q
         e2GEY03PUeFexXSX+0vWMblVCQZVUH8nO8BhpRFId/+dLhowUgnkgYPWZ+jCvH+SSwKj
         yyUHq6gwj56JK1Pw94P2zL5eMvpj5xCInfDWn7kFETKz+XCp4H2b3KjcCsSdyf5dBOWY
         D25tj8+NSFSQR4SxX381rvxb3xBAVPyJ6HdvHokTWwjCy51TsvqWSgs7nKrPqV68AvOv
         qTAEu2H4XLfhP3TTNY/17PT0a4encEIa22CNsaxW5j3xRIfVo/NRbpKqDHE83NgvWvpr
         VwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/CblQrhrrwy/8OwSXdqo43gZ9QagM0gWQhBaeD4KhvCBUcm/foI7TsIZh838vlSiEqmpbfEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIg00ELBon7rn2dLjEUccvzWsD62PSKFEu7ET/5FnFm+yr1+QU
	btWyRLpYi8OTiwzfWSzrvKbbnobUeRsIyC1hTA/is0MAwjutDY/LnLAYDE50ITFd4UYW9cYuNC5
	ToA+tYQvwn+wBKXgUiB2ic8sXbyuTg4kY65LhaIO25Ot5/doja3Hxq3Y=
X-Google-Smtp-Source: AGHT+IHRq8GM6tfXpOlFN58zTXBcLQBL4mQaH5rBniMTJZY2Z7rN/MmFFcpQeaxnOqe9pRomS/ZoliUh7/cmnvphsSIgdzUvAVrp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:3d1:946c:e69b with SMTP id
 e9e14a558f8ab-3d28078ed3fmr19259425ab.8.1739636521714; Sat, 15 Feb 2025
 08:22:01 -0800 (PST)
Date: Sat, 15 Feb 2025 08:22:01 -0800
In-Reply-To: <67afa09f.050a0220.21dd3.0054.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0bf29.050a0220.6f0b7.0010.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] [bcachefs?] UBSAN: shift-out-of-bounds in radix_tree_delete_item
From: syzbot <syzbot+b581c7106aa616bb522c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, kent.overstreet@linux.dev, 
	kuba@kernel.org, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152659a4580000
start commit:   09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172659a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=132659a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=b581c7106aa616bb522c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e449b0580000

Reported-by: syzbot+b581c7106aa616bb522c@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

