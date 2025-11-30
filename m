Return-Path: <netdev+bounces-242783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF42C94D5A
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51143A468E
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8F2749ED;
	Sun, 30 Nov 2025 10:08:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E932475E3
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764497310; cv=none; b=TsFl2xBLYIqCZgpAQE5Kd7kaqlHWBd25fy3weKeoc6RMe5I+gV9lq/s6AW7ffoQnT6a1inTJ3CPF67fdD0sQTTL0fJOcfiywt2ewQJHIo7sNlE2v+3ktgG9VTTPBwA2OpGUu3n4V8e0x62kBYFjeCzaOWfe6xC5E8wiqlHa+igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764497310; c=relaxed/simple;
	bh=3Mt7nhZ/eyWbrmwvtwL0fPGY11X1eZQXyzB91dJBHh0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bPArp7BIMrg356lRj1tUS+9SewVgL2F35bnOy79KHkBVTGlbxNiJ5YKn2w6v4Gq+LvqHfV2ond0x8bC94DOefrhLoXl/AaPbMrMuthBasLPfxTEcTqGDPqYkefIj88GAB7dUBhu4WeOFQOcFTPrKilt8qBsiEVHJttb5+dnbxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43300f41682so19938725ab.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 02:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764497308; x=1765102108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3K7iySWhM+gptBsgtkO6TcPNFoLX5PLzUL4vKtYMqUs=;
        b=RBwIihHgdNTgXvGJ3xoJs2p+cZETOaPdrKrthel8nRDfgSZ6h3pbq55ysBW+MQ7x9k
         Yh7ItEPwwQWTomemYJ5VU4pfVp5nEhMbEKV9VoQR/eA/YM24lO1/jeGjqO8zTvbjWPdJ
         RQ259cSlNhelarECgc2MzLBU2GCGyPMAfI2/vzQwmQVFmKVTSOvC9M9P995VB8mWmkkn
         dFI7OV2jCQmp1DXoEJ58p7OzlKfj/ghBHeA6TV2nabgXPQ9SukctfagaXA13UXOrjRQm
         b5nDEpje4fNuA3hFdyijiiOaEUcfwuI2Vuc0l3rx20dOm71JiKBgshQPfgEumTbu/LwJ
         KPFA==
X-Forwarded-Encrypted: i=1; AJvYcCXe6+bD55wtwpNwOVOyiNIgegQOCJciErR7SYF430J4aQ1i6LH8CNt4UnE62uiJf/ycZyUiVhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKWCOqzGJWRda86oG1JWR4AqkuoRS5uXNS5hHWtAQJ/5eiUPh
	Rzq6HY5UcOUaHxG/JwqSX8Q/NAtODDiuuC1nUZoWM8UKtnqcUE7rYR5XZkwbaZu2v9tzLEWB0Ti
	EeRwnuM6PF5ODfnPGYhNfDEBhWi8lHo+zTjBKjTEMibJ9/tLI74EliRUW6qQ=
X-Google-Smtp-Source: AGHT+IEZOvXzBnfn5kCmG7tBaPdSbl1HhHQmIhzvCcPizYRrA2D9o7Z8iohxFoCO9ICBJWh9KbH2hZd1+6vxpqC/dIbr+T232sfZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-435b986a6a0mr204507785ab.13.1764497308584; Sun, 30 Nov 2025
 02:08:28 -0800 (PST)
Date: Sun, 30 Nov 2025 02:08:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692c179c.a70a0220.d98e3.016b.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (Nov 2025)
From: syzbot <syzbot+list5b2674f0cf5d03097358@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 20 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 687     No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<2> 375     Yes   INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<3> 138     Yes   INFO: task hung in wg_destruct (2)
                  https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

