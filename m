Return-Path: <netdev+bounces-155890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67207A04363
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F342F18856AE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A61F2360;
	Tue,  7 Jan 2025 14:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D391F1319
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261670; cv=none; b=Q4HVKP3qvJpIhaOgcvACwr2KOdtipfdkuV1dZE/OwVIyR8AOkiYWg4t5guC42vdzihjJREzoU/+mTry0iTe9T4sS0b9GNjtalN6v3tQoZvmYU1lrYgWJB2q9QojirnhjcLQ6BIKvHShJ0/lbMZ+10wwYZPrAeXugSzm0cE7RTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261670; c=relaxed/simple;
	bh=q/UTUd4wGepvnY3I65+DtC59TAsbKPAC1wXLZNgjpsQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g15V7symW+VvWNDxVN+XuA+Xm+VijavwDXqGf7ZihEK7C426ZfOwBEpg/DkqCybczYz5eVZBevsfm0DWWQnGnUB6Nc6fRMZZq0u5q4Q2wqhBgl0JEJQZbospRfnDByhPNRFJ0rb7+jSWJsxt1veI0sBMj08S2nc+xhq1TumRgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so152978545ab.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261666; x=1736866466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQNBTv/v8FF/k1N4jHYNKUzYslup0/Ac3YRstwEghs8=;
        b=kTO7OQj2OYPC28KWLpWY+8txEG085aowH4Guaxi9XVuYSgJx/26v33KutJLQ8U+4vd
         +7Fc/p3ef1Rfv4NaC0Q7vtH8CdI8pADKEMO50Q721z4WEQ29JWEgVq9m1u3/wOeM6cDw
         MteIV7Wf+jmR596z2+6/E/zzXxR+nfRAk9/E7scZukpHZxC9vmiGhnyW0dcVsxO/TSbB
         Mk8BjjYaPfsUKy/a3HmUu2x3cSmruVk/wToKJUY+YfKpd1IfMDTr2L9yo+9HYafywfQC
         5Hf/LS744IbqaCSXtpx9ml+0xQAwFPChieZ1OsCSh70TOIejuyegIJjJtLiBzCDW5hVY
         TmEA==
X-Forwarded-Encrypted: i=1; AJvYcCU6KqrmfT1oMmE/k7KZh9n1lrun0zP19d1thcWnCbwQDE9VJChyUBm7j+D2ikorQh/gZfYtmCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIcjQDJQi3hg+PRBZ7uhhqvg8AKzppjhZxCJITWc6icoQ26pU
	k3FRfCEa8TGg3rFiTemX/17aqyvvx3a9SX1FYlkYGrTMw96oxZt1yu3tzJT3Gn+cUEIcpEJhn3L
	eaFnnt1mJGdmjq3FkkX7lp+qs15CUFf082fp5SOFrSJ+rbkK1JgUz7d8=
X-Google-Smtp-Source: AGHT+IGSpDpIM7Y8UQT2RsbOUsEUEAWNg7z8znh7lgWQEMnUHf9SL8KLITjuRB/zcPlU609cYm95XZIHl49sRBAuXMp4TTEoyRiS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b87:b0:3a7:e86a:e812 with SMTP id
 e9e14a558f8ab-3c2d48a2f66mr445254125ab.17.1736261666273; Tue, 07 Jan 2025
 06:54:26 -0800 (PST)
Date: Tue, 07 Jan 2025 06:54:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677d4022.050a0220.a40f5.0021.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Jan 2025)
From: syzbot <syzbot+list99b8af0ec3a670fc3fa5@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 170     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 12      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 7       No    WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<4> 3       Yes   WARNING in cfg802154_switch_netns (3)
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

