Return-Path: <netdev+bounces-181634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD7A85E45
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C8B17FA0B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C99A2CCC5;
	Fri, 11 Apr 2025 13:07:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE429CE1
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376843; cv=none; b=BTn6mbJ5j5JCkc+SAX6pzixXsk8i3zU0QuyzjqK3BRDbCc5u7fBRDMY5L2PScd1Z92C+EAgi+6iPf9NgMbGkbUrtBb01CzJXvNqt4VYLZgYc+mi4LuRJUIWZRuEHgbagJvGbpzq7cTttwd4jtDJhz8FpRWVVy0GKj0sTE9ll1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376843; c=relaxed/simple;
	bh=spH96PgGCe3FyPMJbH7IqkgbG26PXyo76sOr+JoBPS8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XLvdZ2ZQoxRBsEgsVCdtWe/iE/ffMNRYmI6h9sReJ1G0QPOnzjtfFDAs7M6uPwrjeY1Jd44UxW0Swe9begoDm5vTgP8vi1y4DJQX+7ourQkmy64rI3UgjLcjJu9z5ZqfnAH8DdShSv/0bRyZfim4jcUD8vHJWdWkgiSWcQFQb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e75f4b1fdso393824839f.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 06:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744376841; x=1744981641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5t+V+PJBNrCRf7SuNBoLNK8zVU0kFwToI+VtpEMXY4=;
        b=vIMJ5kz93R2uBKSJ0lBnDZJKZzJnfpTZ1eaCpUpL3/F1uJyU2Vhw85q7oebJ9AcwSz
         DQHxdBSypd33gVWYIeJ0uPhbtklqVZipVrvWSOEffxR/vi0Wdw3C6G3HzQ8fwSYIxk6s
         XykT2f/gmIgNArGypZpX/2y7RpMmaRFh1pLYDmUiwEP2mk8nLyz0PMghyIuWK/N2zgIX
         /li5bZsuJveTtwpMwfJgCx4TP5JmbIUmYlhxoJSdF59bc5RprfB+QcdK82ykc+N5xF3A
         //SM+q1la7U9SxS5NeNObaqZUFBkPA/egi6IemZMk4KYDnSV69ZkKK6Nc3tOi36ze20l
         H0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVVRcMBxuTFPCQpsGncWPUHFoAQiNiLNFPoipjNv6+4Qtg1R59YX5EkHVu2xJUyiNHcvAqb7v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4994gF9QBF4GDpWx/YBTZHiMYpYIg1kcg1675QBscbvukhFL
	pqlm8vb2AgYsPwxvtygGJOynHC5bGcnINNE5aMn0w9uoBUqLlZhu4DGGsGWyp1DqBa0tT+mC7J3
	9jXdsGzSEyOnNh4fDGWONSZ9lqFBAOq7xi5JFXSjR1zqu8wNT/uGfKZM=
X-Google-Smtp-Source: AGHT+IHylQSQLPuTufArzk4fimUu3VvUqWSvI7rPJeLl7KDcZ0xfZf/P8RL8ka9hymqKn2mPM/LuDeJZGEgwSL5mj/z8hLh+fTgK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3792:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d7ec1f3fb5mr32697045ab.8.1744376840793; Fri, 11 Apr 2025
 06:07:20 -0700 (PDT)
Date: Fri, 11 Apr 2025 06:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f91408.050a0220.355867.0025.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Apr 2025)
From: syzbot <syzbot+listab49c99c53036ef082c3@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 265     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 32      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 14      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<4> 11      Yes   WARNING in cfg802154_switch_netns (3)
                  https://syzkaller.appspot.com/bug?extid=bd5829ba3619f08e2341

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

