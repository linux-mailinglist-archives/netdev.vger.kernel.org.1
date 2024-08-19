Return-Path: <netdev+bounces-119602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233959564CE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B460E1F22AC0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31834157A43;
	Mon, 19 Aug 2024 07:39:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F313BC1E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053162; cv=none; b=CDhnz0+dqXl+8R2t90Re8m8fQX9G6oAUwpXryhVTfIGd+b8+SGWzXXpf7zyx8kRXWNijk3/0DHFE3HdP72CwMnlP7iWX/O7uwtNZUAjyQ6hNzk/TJZmAV5lDmZk5kQ+luSX8eZR45uYEQ+xewtdVi3XHZzu7mpjoM4PfCMSaaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053162; c=relaxed/simple;
	bh=QC/eCvIe4Z0WaYM7c3KqLyuSj5z7rbLREK4iVQViOpg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GDr5GZTNgCfeSe38uUcj8HGaUSr38rjWXgrVaa4PU1mDHBwzJza/q/stv05NkNV2vkGTwKZcKmnonZB7bXGjomBmzFq0b5R3F/ipcult6V/ahSEbkzmjR94TyPhUoI1OSxOj0ql/glE/VpwKZCyiVaGiVWznvcCT7BZVbhg/fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824cae494e3so388104739f.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053160; x=1724657960;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTfnb67k22MLpM3A85hXVfpyRYO3HcoiSS4BqkZT7R4=;
        b=vh0uTVbK4qzzIEHmL2lUZF6EJMONFtWscles49y05upBU5IPcHXV0y5hxkwxCQKUr6
         uZvtq6SWL00DErVLkrlhYTsAXARwfYOgZoK1YHE+B8aiJ8DXNo2OpFd4TjblDqIuQRUE
         r24g4Qd6DyvqKwKsDdSfT/k9WL9pzIAkTfAauKBu06t7w0qmxNpHwNbCcydoPSjYZUus
         B2C+NT3nEsfwBOoabuDyZquVqyk3cOyDcEnsclScgay9F88EgnZ0oszvKMgvNdSzNlKe
         k6pcjhCjSLruzxXjHowFXanSGJY3BCLiDNq6TQ6Cx7EzoVTAA5tk/ENLGlAgX+mzUPRD
         bcog==
X-Forwarded-Encrypted: i=1; AJvYcCU3JQWQbx+xWcpoGA36uqu/6xzR+CNr8u3o2yA6mxbQ89aDW7U9z62hZ6bf0qwakepWAW7O2yPlxKyheFg4cuXL8b5aY83T
X-Gm-Message-State: AOJu0YzNYAsQRpk8kv12vGRuxUAXTFktKCwC4B9TjMUfe3z3t1+glO/Z
	Ur+GOwGnJr+JKNSHZCBFCse/Y7LNajyIi8UatHdwVtL44r6SdLtJiJC6oWHSxwNFPps3n3w6iFx
	INOf0C9L4u2ZXoWoL2iyKhReci7ix8KALgEjAV+yuAMv/s71cvTNoP4c=
X-Google-Smtp-Source: AGHT+IG6HXxs/ynnoi6WxlCaOWgBlvHY1/o9En1pwTOHwPYo7qCr0D5hUxepeJHr8fPf5GSbahkgVaqYuuvx3Tz3+gkbFisCdzOs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851d:b0:4c2:8e08:f579 with SMTP id
 8926c6da1cb9f-4cce15e045amr577793173.2.1724053159870; Mon, 19 Aug 2024
 00:39:19 -0700 (PDT)
Date: Mon, 19 Aug 2024 00:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b15070620046876@google.com>
Subject: [syzbot] Monthly nfc report (Aug 2024)
From: syzbot <syzbot+list6eb6e310c9acf922e970@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 207     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 139     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 30      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<4> 19      No    KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

