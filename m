Return-Path: <netdev+bounces-198011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1174DADACFD
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EED616550A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D32882DC;
	Mon, 16 Jun 2025 10:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBD273D9C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068150; cv=none; b=EWf1MfyfEBl8DSm7+rxjVBCBbrWU4znR9ztZoMttjZbxEwhfvZwcCG6/ps4w1z1Ud4IDkHU75MB5PWfT2R+Ud0m9tE5lg9vQDta2yXSGPhZbVLLV+sI518UNOxJXXwg9X6pHWEN4thiIJUeLqlcMyYO18H7BCbjaDbu7fh1TYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068150; c=relaxed/simple;
	bh=z9kAnrkpj2GfKxE79pAFRpyJIW6iX5B03w9R6zhT0X4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UFopa9BNaXnFrtpOnqVk14nN+xxwPsF1Ry1ErAecHx/eg2fF2O5DlQylSz9MyBhpYmyTy/OiEGwL6seaQu7dq/i/hvT6b5noBU3TqpYOETnUeLk6yzqY/cPnLFKlIfpcihgh2FXUsGLlRQDw62V4bMzLY47bhFO2WFXv9ewKypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso45236625ab.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750068148; x=1750672948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myEXstyGfSAkN+bF6xcG4feR2elJpzxIo3WyiuH/a/Y=;
        b=OVEblYOiWSO8CzsP18sZBtwJq+gIq+ekIqaQPC5h1XuUN5qgJGYgc/8t5WVfS8wrvv
         FZVcmtNd/CBc6ah8iGxGI5B2KNmaiyWMgm0imgsh5jV7ete8Ik4fDWNGJnhjCnp5co6+
         FSOmJduHYymAO+ELi3c4/ZxnG2HE7LJ9eHZn/lKTy2vGYVU9psgbZiG/+bMu48WeO44l
         YQtic7rfEfk5gUw3P2AorHpnC0ZenUjvnu6Emv1KHlHucKK/voGGE26EHpZuBN4U2BGP
         XaHpg+CmY0dJXbnWty6zL7GquhKq7igCI2vYhtnJUejaCH5SZLEbsYBU4eCl3yafczy4
         UqBg==
X-Forwarded-Encrypted: i=1; AJvYcCUcIhf4HqCmKFLjh4PnKvmsRU5HKxDWP/tiLfAiY8Tgpfgxa/egfQoPg7RSic9Y4gVvbDJao2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2kaf19xGS0aQdJHljCM8lpfJxYrHahioEtuyp4FVo69PbBRG
	39bOqK7RLzA6Kf0JdyrnTPP4qLTRKsc9m8DG2bQMkJVNfoQuWHaXgk1dWJbYkg8lELbqF4WhMYz
	gS0UfunzMcNc/dnPAQM/gV6DfDx0hHbzfrYqglRBYT9t5GcNhHCrlrv+J9yM=
X-Google-Smtp-Source: AGHT+IE8eiWFRAM5rURp9zmqZHi1FS/z6eQkz4OXZuea06egVDNxYRzDQP1WE/XQ3CLWQbe2r/oGDMBmQW8gq/iCHHdIXhc4axEW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1687:b0:3d9:6cb6:fa52 with SMTP id
 e9e14a558f8ab-3de07d6855emr93274005ab.12.1750068148473; Mon, 16 Jun 2025
 03:02:28 -0700 (PDT)
Date: Mon, 16 Jun 2025 03:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684febb4.a00a0220.c6bd7.0017.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Jun 2025)
From: syzbot <syzbot+list96e7686d3d4357107084@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 34      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<2> 17      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
<3> 1       No    KMSAN: uninit-value in ieee802154_max_payload
                  https://syzkaller.appspot.com/bug?extid=fe68c78fbbd3c0ad70ee

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

