Return-Path: <netdev+bounces-241152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A33C807DE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06A7F4E14FE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336762FFDF7;
	Mon, 24 Nov 2025 12:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99657261B8D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987908; cv=none; b=AihEyu4EEI3L4qkS6WjHAUa9H4cpe4/0nk2m0cdZRmMFbJO00YcsHHCesVAG7pf3y+CuwSk5LOcvlZfbLAro+JOvm/Z5R9mT+kwrIo33MbIJ80DzsAtTV7wWvuN3qEAGcNkfvDa44HKCVX9/FdMfAwpdi93yYQeAuoKZa2iXJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987908; c=relaxed/simple;
	bh=gH1uMmxpkObmIdfa3+yc9Op+Dg3bG4ezq39St2+tYxQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fs4aXletJR1lkyFZq+6ZtH7jzdDWnVUzWBhyoxNcVQ7EMq3TyfTQLCrITDQrSYrsKT0BRSfZ9+Fq+L2k7joX7XCreepCMMasgOmprc+s7qgaImFuL1F7B2urixpEV9I9LhAftykl//4YmR9DxDzD2qr8xVrkDqnFL+6FGh8wEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9490314b781so290555339f.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 04:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763987906; x=1764592706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aOLMgPTKzOfn6IWkaDXyZ/41+GOVQGDeseTOEg+Mn8=;
        b=O+1egkY9opJJy9hTzoYdNXXvaTDrEDZ5QRjW1d28TvY4+AuqIjBYmMwUGa1FDwBChj
         oAVmfou2za5hmCbjrlEJ1IIVbLX6iEVt/NkGfjwOzpB0BnvuU5JAfafiF7oOpr4f385w
         qHaGL3o/p8lY3fewiAFs2u8VNS72ib0pCD8Xi5J33r/YfFh48cQJhle+qMgOaL1bVjUY
         ik3VypWfYSZzHoAD4ksvZIf9bX+Te7GG9erDoip9w5bARYD1VE3POJrxf2JKl0mAS6Sl
         P9B7sBjLEtncy4GsLh9h1eg7CdJC7N8+UMRnFK/FnLZbfI8LPlRcbVq30SoswqVI8xnG
         0APw==
X-Forwarded-Encrypted: i=1; AJvYcCVq6BQxDxsq8G8k7gqkHAoRtv/fP3VXJL9oiyjG7x9Su+CA1aUKzehzsJv7EnyZ9zukhJy2LWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Rxl8Sgv26SPWsZHCPnblBwfiK3tpQE0V7M7hJW158jPyjXw0
	QLxK5uYGa8W4GFqi2IQz/TFWRqB3AOPX+iS9TQa/mQ06P8bca1dYl401pD+7L3qPeF9xY/lw+sZ
	pVXWDbd2POku1PFSVSXfYZ3kjvhh1zYfTBzd25464QIxdZFB2aBeLFwAtI2k=
X-Google-Smtp-Source: AGHT+IH+IKnFYZ9V9In0sQRjRyAoSQOYhz8ZVRhG94/V3zacbsOi4lPO3xaA9/9Dq3ESLt+7BnHUIdvT5EH5kbGJB6KB/0kwLlDC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348e:b0:433:7673:1d with SMTP id
 e9e14a558f8ab-435b8e9acb8mr105566265ab.31.1763987905869; Mon, 24 Nov 2025
 04:38:25 -0800 (PST)
Date: Mon, 24 Nov 2025 04:38:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692451c1.a70a0220.d98e3.008a.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Nov 2025)
From: syzbot <syzbot+list7c5462935fcfe1e6e175@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 191 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4593    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 607     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<3> 250     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<4> 115     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<5> 8       Yes   WARNING in __nf_unregister_net_hook (9)
                  https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

