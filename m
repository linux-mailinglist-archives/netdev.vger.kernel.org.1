Return-Path: <netdev+bounces-145232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44449CDCF5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A831F238A7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7941B4F24;
	Fri, 15 Nov 2024 10:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5619E990
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667766; cv=none; b=u9IA7pzmBXwa+0xJfLba1WVdj1Z6vIt7x2Q6ki7YeUiFGE1Ry6n8SPjHT9G4C/1rOkZL4KyDLt4VhKpvpm67JAJOVY5u2k2G/zFRuFd44CQ3xJaEArbs2hjw9hderW87YIUTpTWpzxjOqo/DGYT5UyhoMuyMWQhOO9wWJtFF05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667766; c=relaxed/simple;
	bh=YBWq//aMFNh7AbrBVww1FmxzHMu3uKd+Ddt5w5rf6MQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u+c/3umIUwGPvx4tTfnKWYX2tt9DmbmhcXsSF2++VIzymH9wPyub+DILnWj3RNJ1xdvUKURkH6IOWDihqwjUpKP4VeplcMqaJe9Vu544vhuYNBaurYsGOVep/luS6op+nMoUydEwfFDBHImXMDt5dkn+k2Mw/HkvsRN2/vBplIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ae0af926dso171054339f.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 02:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667764; x=1732272564;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgZi5loVeC2B/qYjithZ8jk/6eHuBMqIP1U9qENvnp4=;
        b=H3zG21eEabXHEMYXj5Aa31UqYCJbYcs8ZuSY1kcVqSiYZs/dB8Yixpmklh/pHpLnyZ
         P84QaH9MwA7NG9lPi7T/ShxtwNj+U8cdGOyV7ha2MHiMFmYbI2jqSv5N2gEDTh4m1qQX
         7Bg4gCU8uoXZULKFn88EfTKderShKLRZ8dyDHoMWMzfpJ4vFWQrezYJ6TJBlXBU8WGUO
         QhjC6YcPaujKjP1xR/QpOsSA1Ga+/La0bYmOPMR2aG9guekVJiyLy2vlrMms9eUQmih1
         xUycdY42x0LiEJqNaWjG3K9vR7ySt3BxL8xTJ1GPesxxI9apaaIxHQs6biOBeaU7ZV+G
         zYzw==
X-Forwarded-Encrypted: i=1; AJvYcCWWltGrtv3wX3n/LYtLqrOVHlJ6jv8a/7dU1geC75FPmSfqIxX00JGmx2SDGX46Wg61MuD2oIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXWsu2MsvMefri/Wz90ITkJHMpGPfRKHNXuHdiq3Io4o+Nn+/
	nMwQYnrAV8vq6gI7QIYbW3OebOU/nIuq8xnLhbuXPB22R7WEAKPVS94JCOQdLllqLdAZCpM4sD8
	9KwfMt/non7v031pWqlUFB16aQTuup0WG5o8IAXb0nNqZOKc8ycFYyCE=
X-Google-Smtp-Source: AGHT+IGf8YOFsFfRlgu/78sYo9Xhztfmj2R8J7nD5wC4MTFFueOKVE0QcuSl/LSymva9Cyje0Zgo4i6QJbmE0JllsyQeC3UaPRmF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:158d:63a2 with SMTP id
 e9e14a558f8ab-3a748077d9cmr18832205ab.18.1731667763990; Fri, 15 Nov 2024
 02:49:23 -0800 (PST)
Date: Fri, 15 Nov 2024 02:49:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67372733.050a0220.2a2fcc.0077.GAE@google.com>
Subject: [syzbot] Monthly hams report (Nov 2024)
From: syzbot <syzbot+listb3995cb5944bf0cec442@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 35 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1684    Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 360     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 20      Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac
<4> 2       No    possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

