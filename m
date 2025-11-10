Return-Path: <netdev+bounces-237180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A2C46A75
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623421893C02
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69930E858;
	Mon, 10 Nov 2025 12:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27630BF77
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778307; cv=none; b=P/DjVdc1HLsFPRne8rgZqV3IgZhq3IjNAnZymTtbe7ygdbSWIJvWTl39+1Oxg/PK3XVOFP22b+BSMnfDLMw0ZGx6nFRRtsahs1UOpd9j/J5oq68Nrdm+ySNI7JN5qgk/D6r+mvFRLw0SpbpJ60xnX+kk6+RU96FPvgunTMn2/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778307; c=relaxed/simple;
	bh=xTFQJUL0lkezhYAsgGSIUDLeIxSvIp5EbM5Uvpm9yqU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k4p1ZPTxyHqe1Zxsc8+LprhIg6Qu0qgBY/cNLOMkkojQp6n59W0fOYSD/k8sJkhWHYedMvkq86OCjWsPSTLbZzqMIj7slP978EtjrHglBJEQTU/D7FWhhQmCcEwpShRvEFaWCDgUFp748q606VYgqzLRJlDslKDbE3otM0eTK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9489bf08bcfso110500539f.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 04:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778305; x=1763383105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfeuF7t9W0tZyiOKHRfcCmdh/gFU/KWuvzDJl6kuhGI=;
        b=eKVUy/zhwuwvyGmXmWcqUr0bQG8GstVOgCZKBZRjBiLJ+pjcFuDHDSM+gWgieYcQQ4
         CKq4ADyupjwAGK0RkgtTW+zUc+4mGTsh/tAsUUtuz5xCNZfpsAjXbGvaHJJmoYqyIZYL
         XyTOqRW7D5XgkcNAoX9rcnNTJBznk8LbnHpccThY26850DH4a3S6XZOB1FT5gyrVqW/j
         6PwTYkk4ey/prpBEJCw8Tazqv0IczpR0wIfV6QQGwmc81zI0G1fRz5UjBVFkShqHEt2X
         vHlmzKEPw1C1tOH/GEbnwO+sYPFf/4t2c4H2PBRxE9E4eHcKNHH6QL1TucJ3CDbN3//6
         VbOw==
X-Forwarded-Encrypted: i=1; AJvYcCXJINuBzGBFzX8pOX2JUzD3acpv+HCpOL27ucsCJdW2MEwGibPlC0AxK+62hiW2+KgQl2gmTZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzN/OO2dtHMlX7s0MDMwYC9ZM3cBI6dMkyLaFOVk+MTsGpMa46
	Xg/alhMWnjzs/bPzHL1U4jlJfnvDIty2HHjf8cAUki6qGpownngDskpX1xsFxn/13+mDFABe9xY
	Hdk1SQ/U3qAwWunNMYCQVR2dgALBF4EoLcsnf/4EP8iScTUPMl0THStC/sL0=
X-Google-Smtp-Source: AGHT+IGtuLGpBtrmikrQ9Ic4MmXUZMZWF+Y3kzEQnrlfWw9N/Yc4msFn9uKoKTYkQC1V9aXzMzhsOkvyWhzdv4VkCDcqwVS4X2eK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6f:b0:433:2390:d556 with SMTP id
 e9e14a558f8ab-43367e4c6f5mr103496525ab.26.1762778305300; Mon, 10 Nov 2025
 04:38:25 -0800 (PST)
Date: Mon, 10 Nov 2025 04:38:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911dcc1.a70a0220.22f260.00ee.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Nov 2025)
From: syzbot <syzbot+listf1e3e59758b3b8109ede@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1029    Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 518     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 145     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 87      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 23      Yes   WARNING in nfc_rfkill_set_block
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

