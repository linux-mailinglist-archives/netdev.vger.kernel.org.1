Return-Path: <netdev+bounces-246081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58FCDE714
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 08:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6EC3009832
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01FC313279;
	Fri, 26 Dec 2025 07:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280025FA0E
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766735305; cv=none; b=HpkF6wdGVGYdWTymbx7tRQFikkCal2VDrjmGUqKVZxdfBELSnTaxXOBsSUF/aPqIT0tlWcDQPgRb93CSGwPYv8rAQZ8kKTbhPd5JmZyZWV/uE5HS48khEE3ZI+ggZw67HUEdmXWpTQrmpmCTf2ZfrQJ2nKLZmVXjaByfcThfVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766735305; c=relaxed/simple;
	bh=ftFRFt0U9pmJXxWqQCcAVjc1cKrvlyiFHWcp6A1zYyA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ssluOKL2bld/TeVwF+wO5bI68hMCYrswIzP23fY7OEs1KyClfsbGbj/87yodnHieEMyHJ0aG1/jLDKA8HBQIBUu8oomuH02vZsn+BKE2g6iLjlAtXPenkb8kss9G+LV2rw1gc/6Cfqf9r0kzsQv0JJ0whLwDsm8WyjsGdNx+NtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65747d01bb0so11669665eaf.0
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 23:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766735302; x=1767340102;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGVqrst9LCTnf0SF44BNbr/KWDe7463rRLU2tsdam3o=;
        b=upnEjKZSR/p6sJrC67ZCDhf7Lw0gq0ton1J2vyOg3p51unAlpeRQdSgBM3CwC5TQFO
         qHZJNWf2QWflGxhGbY6lwXiQJKiyntrBKiwSIKp+Jdo+nJccEb6NSDVWIVSUIGkgb1aD
         JURv7zj0FEonQyw2HMuNwoJfIES/WrrItvoEMRyeUIk1hFI88ea4qG3JNeduu05WfVpy
         3geFGo1bwGExdmuvhxJwnZ4ggNlO3gObndCqGFyttQnooCvRPKwJ1OkvwyfBlF3qlSJ/
         uB5fVRrXqKhzFRv6UPwfO0ys8A24a6ibPQfT3LpSz59sW3g9qKYhjnelV+Qa5Nf6Odbt
         ybdg==
X-Forwarded-Encrypted: i=1; AJvYcCVg44QimSgzfFMPY9XuDUqLDu87pjEHgMdyUSG4OYu/qQTN2ZscQsLTprdkkUa3TY56WSRkytc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFkAWF4UvxTaf0Ukg+4leNHfPepOPyoXGVuQyT4EnyhjXadDT
	5aS1QvdVYXcHttqr7orJ9Y73PL/NPlIUp7LxqdJ5PBilayUdW7HD/pHm5hMkO17hVSqNpkJvCeg
	ypM5iyVDI1XCSvQBTXRXUmCirxznSphfMOOa/JgLbJsL+XgiUDXcaAgJ723I=
X-Google-Smtp-Source: AGHT+IGKh7hFRNhGPM0+1u5wGLSrnOLVnl5f97CwncPfn7WEutnADZVGjx4n7e5CAvmuGXeGFm/Z1kPxg1/4JBAyaU2yPP5FGZc/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c87:b0:65d:2872:31a6 with SMTP id
 006d021491bc7-65d28723305mr7340780eaf.17.1766735302652; Thu, 25 Dec 2025
 23:48:22 -0800 (PST)
Date: Thu, 25 Dec 2025 23:48:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694e3dc6.050a0220.35954c.0067.GAE@google.com>
Subject: [syzbot] Monthly hams report (Dec 2025)
From: syzbot <syzbot+list0a9f29ed00cbd992cb40@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 10788   Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 3818    Yes   possible deadlock in nr_rt_ioctl (2)
                  https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3> 1192    Yes   WARNING: ODEBUG bug in handle_softirqs
                  https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<4> 799     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<5> 394     No    WARNING: ODEBUG bug in __run_timers (3)
                  https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<6> 20      Yes   WARNING: refcount bug in ax25_setsockopt
                  https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
<7> 4       Yes   KASAN: slab-use-after-free Read in nr_add_node
                  https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
<8> 4       No    KMSAN: uninit-value in sixpack_receive_buf (4)
                  https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
<9> 2       Yes   KASAN: slab-use-after-free Read in ax25_find_cb
                  https://syzkaller.appspot.com/bug?extid=caa052a0958a9146870d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

