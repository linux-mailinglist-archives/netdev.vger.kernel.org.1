Return-Path: <netdev+bounces-70920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC908510CD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CF01F21462
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31653717C;
	Mon, 12 Feb 2024 10:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192691E897
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733587; cv=none; b=QvbrJCe8WvAKY1bflqBKdZYUqZVKWdTcnjX3LLxcQ84dgnPgKR7MWlD9d7K+CBgUkKPbB3NtIB6I+zy89bop3yy/fYY7y03BNKGdV5xQsrV7oE7IjRKrdb1vP80SGEvcsTgYlBsaeJ+ylGHny3IQpm3C4BxKNLuBkiK+f64yY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733587; c=relaxed/simple;
	bh=531Ts2F2L+gYAuoaLZw+susPFcEHA9WVYqQFaFOod4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TVjMTvUCmjeJmqQ8tdha4wK3fNUa+lnV1MesF4y6nhHh02y+yxnuvlX52KdQPrHtTNoJ59l0AGbrrQ2EOeWAU++IiOfVXriwTN4UnFK9cVBpICaLRz5mSoujQoXXXQ+76ICIdUoLbRpyzUiw8LDWA7HFOCKsu/REjSkLpIztO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363bedeec4fso27289675ab.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733585; x=1708338385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROTc4vXH6Cy6WhFsQYMvKi8mWbRCVNpoUTIHgUKuxwM=;
        b=E/YquHRVcrQdUZqhsB3Seo6IC9rLXn6HarlCPYpkf+hHwH0sGUY9svhqKF7h3qBDUI
         XgDTcWj3WcvAj4LpPyqqlE/1pU+i9tiGyKnlyvVASG3S+PHUZ7WLV1/OEtwK09RNcqME
         fnxtdNIk7sogM4qjzPmxfGdz4a+0XbRpmoFSg3mcPMu1fe/bPJNHrKAMy0jC4HLGOwcA
         Lu6CTbK5ukSK5SZg0XCXYx/m4AYnpz8XOY1I4d/er1aJfn/iQsIHNpvvUPzLoQFi4A6U
         tp9uK4QryZ/Yl7sQxzqrlLCQwNJOWR0ygaIYAPqLHyZ1ldS0oQigLDeyG0DEw9M8mqE/
         D8gA==
X-Forwarded-Encrypted: i=1; AJvYcCXoxIR2ryNWKoWu0wBPjEYp2hp2XjXnpiR8dtgVFv/0AkOT94fMLxviV2dn7S3Iv7vbucyRaPPZzbuOoGJ4KJ0K+bXJCBFo
X-Gm-Message-State: AOJu0YzCvaaQ/6qYmxOckA56TrHs5h/z1fyAxVWDo4xHqcbK2QbOCKt8
	nKDrHhQHs+/7ZYAjGqJ4r5Ry/4UOGbXoXyqFhBRjgnG2CE4qxA42aAym3Ea7V7Wun3GQ8WdTTw4
	tFSafGNbLMsV8ei9H271/EYjl3MY60QWLZkgJPzpogaTtVnLwzbIIntg=
X-Google-Smtp-Source: AGHT+IFUCXdMO3Od87whdVdGgxMLtPs6AyV1D6OtQpIeraQYtc9ov1pY9Mo7EZrJk9A2zYklaR49LIaQtm3zy5wmqx28XAXLtq5v
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:363:bc70:f1b1 with SMTP id
 j12-20020a056e02218c00b00363bc70f1b1mr572390ila.2.1707733585268; Mon, 12 Feb
 2024 02:26:25 -0800 (PST)
Date: Mon, 12 Feb 2024 02:26:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8955106112cb5cf@google.com>
Subject: [syzbot] Monthly nfc report (Feb 2024)
From: syzbot <syzbot+list19658f79671580b2ed42@syzkaller.appspotmail.com>
To: krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 2 new issues were detected and 1 were fixed.
In total, 11 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 810     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 135     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<3> 36      Yes   INFO: task hung in nfc_targets_found
                  https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
<4> 25      Yes   KMSAN: uninit-value in nci_ntf_packet
                  https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2
<5> 22      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<6> 5       Yes   KMSAN: uninit-value in nci_dev_up
                  https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

