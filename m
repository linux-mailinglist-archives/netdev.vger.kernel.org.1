Return-Path: <netdev+bounces-189764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C61AB3961
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613203BC97B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E5294A11;
	Mon, 12 May 2025 13:34:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2744293B72
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056875; cv=none; b=OAht0A73ZjM7Zb4rlqF6nhwi0OeHF9AkBtNoddh6sSbbC5GLVIhJcABf6mDMEVqTRqoVPbf7n3SUwF0AyUzUd+6FxE/fwl8y79nQCUpTfcMHq5xcLvLG1NShgYpiVDafc51RjdIhu0H+rYVP+1J8Y9bf/wZ69CvXTWJbb94gZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056875; c=relaxed/simple;
	bh=wl+3F8eTpNR2nRXfBq9CGFzHjza01r4LUHMwsOEe33Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vBCNwYQ19i8qDDHYoxg+nNmYTB+OOWIE16BHSvRNkjrUU4R4YM75NVAo3yUaQck/o4tEiXZ1J+K1gY7ww/xknAOHCRDIWTa+w1AH2aebbteDR6yRUG3a103qr1QLFqcKZxSpexLAYX3NHGZs8zfRlQoLI/6WIGEDXDk7guDhCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d6c613bd79so43731325ab.2
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 06:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056873; x=1747661673;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b27Pk0GqEJwbCqvpgYObHkg51OVsd3f/nd7AM7iKm1E=;
        b=g3F6qTUZC+QeL3WCDtPqTrJxM4nxdiCWrka111S2qIzT/eyPT2NDzeyMkP8I113dnE
         izOTinIUJUtEJxTO/wkMwIumG2Eh+H8fsAzMNFE5ZtOSoi2d776aI9oR35p51cVtIYB+
         +b/UH56tJZChqLe4kJFmxVjEj99jFhqpUSs9V1d3fEXfbjnpc1E7CTZRbJYHjh21c4rN
         dy8ikk29NPRxuUmnkZ8W43GGraJNQymLCAHs3jxLmhEFThlcr5wsgpv8kbcQCutC23S7
         ZhGtQkW7MIPJuHlYJUtVF4CKm3AffPMZixZErTyyEIBxAkk5IGfdM/1KCo4NYwsMSwbj
         M2OA==
X-Forwarded-Encrypted: i=1; AJvYcCUgcMgICY+pFrD3ufwuLXhnAhar7YtXCkOefr3BgsVv/WRyaEiMldjpl0qBCMsteju3XGQQyQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJy3z7ZLzpYgpIP2gvc/ltSdM6Zi637yBHAKCTuRM1ncyaiMG
	55eIelO/VxNgHklLP/BZlf1O81g2l7dZ/ZdR+rwU2XBwy9HUcsfij8h49R0cFZ9/UeyNTC4nGb3
	GJu3amc1XV6hl/6KPLuvUxa8uS2jtBgT/GpMIiCKGl0NSCzPp1JxagaQ=
X-Google-Smtp-Source: AGHT+IExU+RmJLuLIScj3qPHE6KbUQp9ULv9VSNxzAViRUPadJULffIFiUp+xyaXLKTBRYFXV9jb5R5DGwrQREIjHN1jPRbSR0sC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:3d8:1d0e:5308 with SMTP id
 e9e14a558f8ab-3da7e1e782fmr141354655ab.6.1747056868750; Mon, 12 May 2025
 06:34:28 -0700 (PDT)
Date: Mon, 12 May 2025 06:34:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821f8e4.050a0220.f2294.0064.GAE@google.com>
Subject: [syzbot] Monthly net report (May 2025)
From: syzbot <syzbot+list13a88a54d07849545a99@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 26 new issues were detected and 3 were fixed.
In total, 136 issues are still open and 1599 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  333909  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  312666  Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  7829    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<4>  7126    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<5>  7026    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<6>  7023    Yes   possible deadlock in team_device_event (3)
                   https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
<7>  6412    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  3215    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<9>  3096    No    BUG: sleeping function called from invalid context in dev_set_allmulti
                   https://syzkaller.appspot.com/bug?extid=368054937a6a7ead5f35
<10> 2547    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

