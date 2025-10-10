Return-Path: <netdev+bounces-228477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B5BCBECC
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 209674F31DE
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 07:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA0274650;
	Fri, 10 Oct 2025 07:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1A255222
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081487; cv=none; b=imxcVtpUWdwX4bMMqw9/EP94G8cMWCCOsssxXoaVusrlOz8if2IltBZOneh/wzps+vd0RLW4BrnJxwCh/YkQTBq+iVKJozGbuKhsBffg61Gl2xKMBTPDTXXTOp0dI7RF6oCHmNDJjnl9lNZn2LjLTcz6ulpTIvvRWUw+N8eEfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081487; c=relaxed/simple;
	bh=W90majqgrs0tolx4oJY7qz8kD+dyDGhIdiy8Oi9pIs8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hzZRDyFjOEB0rCNU2ZKLRJ22oVjegOKUhAsQVZMugOXCYtqpIYw+WVoWm1oIKJ66Yn+1HTO02el0aCeNcXs7W2PnbYHznzSfTr4rseAVWGVmANkTB9p7c0PCtvO6D3sEh84x5xGc6zh+roRXT6ggq/HzwAnsuBoJw55lr3r4w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so45533855ab.1
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081485; x=1760686285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCYq4z6Kszb2v0v6uENtGUQTd+mgNya6TE28IxsUmS0=;
        b=WnoxIj2IdpyuqMO1iCeQwYluPhKQsl56SGXwjEdIyprti7mXCiUzfX/d0QZe1SB09w
         EA/S/WowlLnrXMuOVcaU4qqCdyD5vleLhEOC7ha0UJnpcI6e3GRP3/wueenfrdwz6xsR
         Tl3d1ndhTNOsZhrBLMHVBspbd8EIfdo9QW6BuwX49qNmUOgYtYmdX6qr1ywgeUaS7yEQ
         TtJXiLMkHexsgFr5y+6DFBvkm6mCxV3oMfhw6k1cC1Ipv6DxliR7MTTDdQDxPv56LZi8
         u34Yj290ayTk0uDpdo8vEGiG0OUTE/CNrObsyyCuoW/MDhTEStCzpHtn4ZjryPvbNFmo
         BCFw==
X-Forwarded-Encrypted: i=1; AJvYcCXWeSSmbgofcaINDEJXkY9jF2Sto1CQIB6bcd+dKBHVoUUy8eCpxXJJxiYSDrzJz/wOjm17mGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaP4LFSHLndT9tsXol3lxy7HBEip/+yH8vRMD0mW7Ls3PDO+H
	QU4Sas4QgvyRjlQJ3gpP+KfsK9wBNOFDoElM2dSJnf6bYHRORYGP9xGGlERk6sSAWudNuqlvdmY
	QwiwxKobgrd0eJnomAujacZZqVO8odyK6nrGGS5ZnD4LxtW0SHeUqG4mgh8k=
X-Google-Smtp-Source: AGHT+IGIkRJsIU+QvLmjOyXTQC0ZaKHGg02aOWol40MTqH84ncsOxPaqhP7NnQVs/cw19AAZh4kbyWO6Y/0lKjfDdAkDEza1RXl6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:461c:b0:42f:880a:cffe with SMTP id
 e9e14a558f8ab-42f880ad145mr74119305ab.26.1760081485057; Fri, 10 Oct 2025
 00:31:25 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b64d.050a0220.91a22.0136.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Oct 2025)
From: syzbot <syzbot+list66dcae303d719007ad9d@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 822     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 443     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 134     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 73      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 11      Yes   WARNING in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

