Return-Path: <netdev+bounces-107792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222591C5E8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E47B2271F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CBC1CE083;
	Fri, 28 Jun 2024 18:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833621C8FAB
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599904; cv=none; b=irQs6e+DCMSnuwMXYSWFvkYx2t230t7IxhGjrdu1DYQCX7z1sXk1q6HakWrrzTpXuLSK2JqCbCb/RH4e2/+pFAdATpkQF3H3v2f94Qn7vnACOjZUoOAGrJoJKp4W8/mY8zbvoR+B/IYd6GJmqGZoGgqNcfeIykxzhhrlDvOFdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599904; c=relaxed/simple;
	bh=WAgvqGSSMUhPpGWuEaYRvYoyRrVFQyKjhyHF8lm3m3s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qR6lpwVwc1ky59dKCHu2fm3HB/oRi2F5Wb2j6/jJcYKA5YjuVVtNJbP8auK2BY4RE1rb5slMuGcZx2Sm5SyVZrD7Sr0TbvKNBhOU/Nx9lqAmGijcGU8Ax6/fB4X7vOvYUJFamtkhtjOvJYjGVA+n6L9PgS+N8DRYe2OBZXEVZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-375e4d55457so10467405ab.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599902; x=1720204702;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAQwFq9UPZbXFZDZdCFdcQuDs/7IHMkcXpTnMEOHaSI=;
        b=Tv+J2jiMesm5XJWrpdMpKzrLcxCIjsJtZdhj4kHjmg/x+Ku/STT0T3rfQYI+ZZvGo7
         69GrJCoRW5lzqctDAYs5rY4/8QA3y20a1Nnl7IR0gvYWllMBX+6UwEdCel/LWslgfi4y
         6PaXRv1qFBqQsQBB3fVUqFF+dw5369IA4CHuG5U0xcuPlVYVzua59lYM6WDvYgBR9rAu
         rVJ/0oHHxcg1JzVQBIIvS7rbeaJHtVCed++2OYsJDNRIfK1dNIxWbdb8S9qiJ+YPpF6C
         /W6mU5EfnB5Q7nwejFiTyhRx5CpTWB+8hRE9tGbGiEKXYVsmm1TLYppIjJZjlJs+RnNd
         ma4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6O9k6lNAoZTaMcK4u8TFYdv/eC1iF3pbzUaxO4wp2NKJ+Q3rTr4bSVoKMY8OfyoEBocL7vxWvnM0yVBhHjsx60FUa7PTD
X-Gm-Message-State: AOJu0YxlAhNsq/2TazdGPkwdjR/lM9tsntOhdNDHWe7KCc+B7sqoN8MG
	w6PlVhAVSk0wTFajEN2Gw3YzWmCZ6V4c4O0Y2vmPbXeFrUX/E9TfU6plvVp0ySxHRAySVdzSHi5
	4glkAodnKIA9s9OuHe1tcg/RkHhk5J+tAQeO0yXZPDkunAEwlGPcqFPs=
X-Google-Smtp-Source: AGHT+IFyojeDoOQfAz+WpFDP13ym2ekViaAZ2Ap6ROc1rvqVHqXy6e4NW0dc11phb0kwVSPqpMSaRAWLrRTi/u2q8ChreueD8oNh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168a:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-3763f5c900emr15343485ab.1.1719599901745; Fri, 28 Jun 2024
 11:38:21 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:38:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cb7a6061bf78daf@google.com>
Subject: [syzbot] [netfilter?] bpf test error: WARNING: suspicious RCU usage
 in corrupted
From: syzbot <syzbot+784a3db26e5409459be4@syzkaller.appspotmail.com>
To: ast@kernel.org, coreteam@netfilter.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, kadlec@netfilter.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7e9f79428372 xdp: Remove WARN() from __xdp_reg_mem_model()
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16956dea980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1437ab35b9d90e65
dashboard link: https://syzkaller.appspot.com/bug?extid=784a3db26e5409459be4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca96920a98d8/disk-7e9f7942.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24f81a5f5d0b/vmlinux-7e9f7942.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31b888945299/bzImage-7e9f7942.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+784a3db26e5409459be4@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-rc3-syzkaller-00138-g7e9f79428372 #0 Not tainted
-----------------------------
net/netfilter/ipset/ip_set_core.c:1200 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

