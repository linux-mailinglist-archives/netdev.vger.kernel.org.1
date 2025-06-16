Return-Path: <netdev+bounces-198042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97338ADB049
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1841888C99
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA3285CAB;
	Mon, 16 Jun 2025 12:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548572737F9
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077265; cv=none; b=tcYyunw7SNu/AfI8rkeZRnO0ilPSGO/381k59tNKAtFCt7UZF/q4MJrkSgMEQNON64exS+OrJ17aa7XjObNWL7IXZTcY9ZIxACKQNAD4zqiHrGvHPBb2wf/Xcn7Gz2uvYazUOZPCCREgWgx0MUZWKPlsfWOXumr0BXkJzgPGJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077265; c=relaxed/simple;
	bh=KZNprXaoNfoaHYjHemA6YofvAUOkORsU2bqHvO7dDUs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XYWhL1BBgEWy6bHYhay1TVQI1x/l6mTOdPSDk6WytpkcHEXtlsAFxeE6knJByiFg80w9+n8vfb9Vey18nugWQ7mrUESXeZuQpgpNF7u1XrN+g5q3p1PzRe5pxg5wY7EJ5u2jNTN9SYyQ5wu9cH+dSXEN+rqlyLnAJHg8WW78ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddb9c3b6edso56256475ab.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750077263; x=1750682063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EywSoWx1oh75bdKkhb/CF3mvca8guENbG+VQo+//llY=;
        b=b+xa1Z+/YPE70FI7CfwRW3oQj52dYiUv5Bg6AEcP7S+eliIlmlGYF3oKne20VvOJbe
         sEhXJS5+GBhiJ5lFfMN/0HQ2GmtlTqxznRN/HrBXP3dQbRwNOPXJZh/w7jOfQ11rppHI
         UNkmRtJPROiX6CP5rsGzeyq+bta6UpBIeDa63f/4YzriP659LjZbmK21gPfx3NRaj4Nl
         Nh8nZwe5vz9SdK1ZXU/qxGliRDWNbuub+uVjyIKpTlDAv4YkCPw0SxDkmQlAbJ8G4TUT
         mzF9cfC4hRax5IuNEz3NA/Mq89cmnPc9tV+Kj+XM05VDdW8DgJuMoIVN+ugdbAdvE07x
         tJpw==
X-Forwarded-Encrypted: i=1; AJvYcCVJEzW/9wKwva5muuRN4RTMLX3iyr474Wex4qMB+o5m7uCH+3b0UJ6ccNBEGimSo94pVNK6f9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dNb8c2WisNwSS6LYBdomlzNyqkldvulZ3r26WJSJYubSa8AR
	c5JLJGbNEE+J+bdzyqpIZ3+FXaFuIHPha3Pb+tLoP20HWgy86/X1lJd7reFPDPG3spc0E1t6zty
	OIz7+0USvTj1M/Nfiu/CMa3wN+aLPWT7J6Lg0VU7LO00f313YswBzB7tg8xs=
X-Google-Smtp-Source: AGHT+IELIt9EJpzp0lXMB6qbr/z7PV1C/VGfrhZiQunu8N7r/BP9kLgcRjsJMR1aWG1N/ZdBaa3Twfku9bGlKYiuSPN8oW9SZGGG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194f:b0:3dd:ebb5:5370 with SMTP id
 e9e14a558f8ab-3de07d3404bmr99194745ab.22.1750077263538; Mon, 16 Jun 2025
 05:34:23 -0700 (PDT)
Date: Mon, 16 Jun 2025 05:34:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68500f4f.050a0220.2608ac.0001.GAE@google.com>
Subject: [syzbot] Monthly smc report (Jun 2025)
From: syzbot <syzbot+list7085bff455d583cbad1e@syzkaller.appspotmail.com>
To: jaka@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 340     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 93      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 92      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

