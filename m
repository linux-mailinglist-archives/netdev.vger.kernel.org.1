Return-Path: <netdev+bounces-100087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB6B8D7CD2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC10B20EEF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11655025E;
	Mon,  3 Jun 2024 07:52:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530634D5AB
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401150; cv=none; b=X0iuO6wQZrOdmTuqzK1MHgSHP7tUZZrkpg44HFi0un3OJOA0Y9Ez5p964j+N3RjSDsS/455IueGY+/qeP28TAGumEWNiUzZfH/+hcRgMXc+uNUn/ivHfBgOfrvE1YxmaYpqzozabaIAtD1Yk9IlPHjAq/i5qOy7VzwtQTKl/vzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401150; c=relaxed/simple;
	bh=KcJRQhY3nMROuW8nO7tJ4lFJ4VWQJyXIpKfmyB62Rrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DnoGLqFXNJVBVO/XdzyqLlmJS7khpjr3dQNWaB+qAcIUqztGRR2lw213PiKptfvmli+kXTvenJ2r5Ykg06baI86XboX5csbOcb0fbQ9QFOqrHMwJooCc++uNYmblFPCDCeQCqLbCUPaZUELoaYMWzwMAUBhJ363inaGO4kcwPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737b3ae019so45841595ab.2
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 00:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717401148; x=1718005948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/aGlV4k0Lr3kE7dmWlGvv+6D6/deQLCQVo//mqUHVU=;
        b=TOV3LbO0gyEOyelbfHU0DNJma8Q7RAwlkDBrWfzDtArLay/XZeYBe1eZvfJv+3lFsw
         s9xKOCBKSkMsOanIWavP3oWx6/1wcMcmSNm1WrQiWUX89R7giFDmw34DchsHnbBAulz2
         40GGbGfKfTTnsn9h8nZ6T/RKwHE/miyAGkVAL4TuxMGcOaggtTDLroxQVLVN1mwfY+0C
         V7t5wTuJnfov85dzXZvWqgc0L1mhmN6GksE08k1CMILgUh74idWxbT3edDcs/7k22l9Y
         CkGdv1HInr3NI7ZvSaCVZIBGrJM+YPPdiW8GviOhiWxEmPCs2c0RRlVXJvcoga7b59mp
         LDpg==
X-Forwarded-Encrypted: i=1; AJvYcCXa8um1myrEyRwvC2ciDhkkolaVQbEXeKqcEfTKgMERQy6xyHH6qFML5JYjSOjVYmycpj7VgcVwRzuXpvyiHrHeO4JCNlxi
X-Gm-Message-State: AOJu0Yyp5ntD8AxoojSv26mZ/exA2aj7rHaSCKFAaaVFYL0r2zZ0V9bg
	wiLrn56kg9MHTWU3xYnXImCogZ1brbVFSTiENGXe3a6ojOmy1fRFz3cJjy5U+0nQyD6Md81rTMU
	t5QXkdavadnj82cRQ0e8aZxP5j0mjNxHCNdZV8V8ycmlDVT7IiobdwJ4=
X-Google-Smtp-Source: AGHT+IHZTLwnXciYRBxGbMsaDQQLLx01yMiPJRv7LvWByuU29JWGTpzhUWdV2Zq7IB7EG2pRfo6lNpmjpj69CytAvXf6AfPe3WQ2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:36c:5014:3bf0 with SMTP id
 e9e14a558f8ab-3748b9e18dfmr6369595ab.3.1717401148573; Mon, 03 Jun 2024
 00:52:28 -0700 (PDT)
Date: Mon, 03 Jun 2024 00:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065d96e0619f79dff@google.com>
Subject: [syzbot] Monthly wireguard report (Jun 2024)
From: syzbot <syzbot+list782da1462944fe92dbc9@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 4 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 972     No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 63      No    INFO: task hung in wg_destruct
                  https://syzkaller.appspot.com/bug?extid=a6bdd2d02402f18fdd5e
<3> 48      No    INFO: task hung in wg_netns_pre_exit (4)
                  https://syzkaller.appspot.com/bug?extid=1d5c9cd5bcdce13e618e
<4> 4       No    WARNING in kthread_unpark (2)
                  https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
<5> 1       No    WARNING: locking bug in wg_packet_encrypt_worker
                  https://syzkaller.appspot.com/bug?extid=f19160c19b77d76b5bc2
<6> 1       No    general protection fault in wg_packet_receive
                  https://syzkaller.appspot.com/bug?extid=470d70be7e9ee9f22a01

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

