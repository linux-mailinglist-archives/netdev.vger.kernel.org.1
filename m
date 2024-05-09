Return-Path: <netdev+bounces-95058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE68C159A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD11F217D2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF187FBBD;
	Thu,  9 May 2024 19:47:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C177FBA6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284025; cv=none; b=gnkuMF6SHrF5HNoaQlz/jYfY3Nuy06gpnQ9wrXHhKHE4Ep/I6tpzrCzOuJpT+d9SQsX4yXo5hBudeA5yOTssmUsPW4VmPG+JkjInlk3Iv4/wh8JlRzMzAsOJaAcBnqovkQ3X2/99h2BOZ3bidiEt1WYPvQGThFfm2a+E3b9TMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284025; c=relaxed/simple;
	bh=Kc+4KbDEOPf2dGokV72TS0X0dQSm9vXGDWnMVG+oKpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=upufHGN8dRy20spVO5v6by30D4YJ840/Hs8IGzem4FaqdBYjvM/Te9SMvjm1UxMCeHhM1mDFvV3UwItK16uxEbtirxS2XQTmvfHwHW4aFFlS2wWUtWqOSQGn+Nfr0+Jjp3cRnR4kMcdv1OyfAgGZQd+dGdujXPbtNbfeBM5AfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so120012939f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284023; x=1715888823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUpDWeNdwTu/kjq1nCV2ON4vsT4uwa9sN0FBco+5YAA=;
        b=m9ZpxEXYhSQrK0bC900DSGiuFxdBobe24jrUWpXIq053gZDl/TIXqfQFahKa1QU5Lr
         veZaV1PcCT+fst9NRjoNWLjMYk4z+JlJ6O194ntODArxCaDl5L6fzW8P9mOyAIh1UfqD
         Q8FDna7qMFZMeBJXinpYtdWFKIhOXjEXlPhh8PvAIspQHSzjun69g1wsEi6x/oXfowBt
         fjWC7vcWRhMbki21m/pvD0pCkQy3orVcCawgyPqlWri84rJrKQHfASloTLp+jc2Oo6Re
         MC1EfMRH64Ko8zfgQwmNio77RC54iwSk7m0L06QOlJxqmC0THh3h0YnCIcMjFw1pq9R4
         IJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXM5Oss02+QvPwlaqQHt3lPfEVfPB2YUYXKtMMX7pMGUb02WCgZXeloY7kZY8yju7d9PeRu12KzvkfusR3PHdFkZlUh5cUJ
X-Gm-Message-State: AOJu0YyBgk+NEOVqAPShJp+UDV52pwpNS3j9kM8WBDEY+xEIvU9yBjrF
	SCT9nyu3e+ewLmDJzWlDoDbtlHk7iDHhVlrgpYlM5mDUWAsNEFRM/4dO2bf1vCAWDnhgz7n9LrF
	8vjgEtRDGeugj8SHV0uFQFqX+fjBlJJpvu6yyDYoufeVhRbbClcffi9U=
X-Google-Smtp-Source: AGHT+IFL7mpUk3NvnsMAFAD0opjcqCMStNVhCeAo6AMI+GlYk2KsYMOEnWkz4hm+4MpqDd+OAdaM3pp3FucnoGoAOtmsWL18I/gC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:488:7bb2:c9fd with SMTP id
 8926c6da1cb9f-48959341c45mr32573173.6.1715284022834; Thu, 09 May 2024
 12:47:02 -0700 (PDT)
Date: Thu, 09 May 2024 12:47:02 -0700
In-Reply-To: <0000000000009f0651061647bd5e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000decb7906180aae28@google.com>
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune (2)
From: syzbot <syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2558e3b23112adb82a558bab616890a790a38bc6
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Feb 21 08:59:51 2024 +0000

    libfs: add stashed_dentry_prune()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111fb9d4980000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131fb9d4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=151fb9d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=e25ef173c0758ea764de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fb63f3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e68f6d180000

Reported-by: syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com
Fixes: 2558e3b23112 ("libfs: add stashed_dentry_prune()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

