Return-Path: <netdev+bounces-151771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363249F0D1E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00796283661
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E291DE899;
	Fri, 13 Dec 2024 13:16:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEE17548
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095793; cv=none; b=eQ7g4OxTQo+vArAEBuQsXYq6++J72rsRQkYo3u8X4x/XO/SbDslNXj7a4kWNYdzYp6TsHgyljphPCu6ehEl+CTVHYG5vB1ELnekc1W1DECCM3Hw1JNE4GKodTHgraZT/AXY4yVT8oHP2b1WUvZJHRgMYX162jETEDStTWUamBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095793; c=relaxed/simple;
	bh=MfODUbaKjsDTInyPezTB9iD2+taJp9jMC+mbhYdLpKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KI4axNRNrttDzTq8QxZlUDdU94NParo6IZ2ZssGN547N1VB04YFzGmJLsfXhnEHoztu39MO+o1qr5l/a7Ooax4IOQOfjiTtSnEerQgFRmaPQGgULUE7zSNXElcp9cj3yyu9UwdYH1wuyWzgFBrAjGp9LjNiWE8wd/0N8LVX7QQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so17901635ab.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095791; x=1734700591;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoBiKipHNLLpHGGGSTJe/jfqJxnRClX1ADVodHH2Ukk=;
        b=kiChewzK2y5R2dB5wgX76CL/CN3onXGJ8K2wYTkMaFUcpEhbPCF3nkc0SjU4F/Kabq
         I/bHvB+hTAiBQNShDBoco4f5lTN6UC7rhvhqbDt+gAyYrRF01p3JRzmyKaWSxkq0d63V
         wz6ed9y8zOygS31JeuMVvnIMtJIosZi2akXs/TeqwZAj6/WRpMl4Ojr/aKGAhqIXy26v
         JNudRWX5kJyZ/DQYVWvKWfPcpt+kv7ETJCCKNUUlw+rPOMnXGtW4izzLdcg+GBcG36FV
         ku6xIMm92x+I0Sf29BUtciniJaaB0+kE8D/mTwLDNa6TiAMiq2MTDFIvvkJYCWKmdkkL
         CDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXxYmaIO/9RtgjuboytZQQjjeshu9dPj3dD33aiKf6Yr4I+MKuKtOTOoiQ/4SJFeONOlUvAq5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YythxLjwqMT9oLLzFNTEGT7tzS2TLZtk10u1XPBwLA3Wn8uE0Vr
	WE0PqhtOuneNDXm1Fj2UtTKmvvxEJsH29LhBfRNAAigriz+LDnEYYI5mQen2jkV9/ElE845suJq
	rL90AStjL5Pt1UB0BcRuh+m481+0bWuNhxqYC8fK1EfAVyG/nemzLK9o=
X-Google-Smtp-Source: AGHT+IE/k0fH2aZWvFpnpJL0Kpg078Jm4gbrIke1NK4w8p393GE7mD5tDe40KwEIlaW3OO2uN7GjbOFMai0o7tHJH4bF+ddEJxL9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:7811:1101 with SMTP id
 e9e14a558f8ab-3aff2dd4d49mr35489215ab.20.1734095790862; Fri, 13 Dec 2024
 05:16:30 -0800 (PST)
Date: Fri, 13 Dec 2024 05:16:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c33ae.050a0220.17d782.0011.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Dec 2024)
From: syzbot <syzbot+listcc55049a3e829aa8f20a@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 4 were fixed.
In total, 12 issues are still open and 181 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2851    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 119     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 52      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 47      No    INFO: rcu detected stall in sys_sendmmsg (7)
                  https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<5> 39      Yes   INFO: rcu detected stall in ip_list_rcv (6)
                  https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
<6> 37      No    INFO: task hung in htable_put (2)
                  https://syzkaller.appspot.com/bug?extid=013daa7966d4340a8b8f
<7> 10      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

