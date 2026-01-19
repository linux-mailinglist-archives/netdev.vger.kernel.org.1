Return-Path: <netdev+bounces-251001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50522D3A178
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF0E307E7D7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A82339714;
	Mon, 19 Jan 2026 08:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6933A702
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810771; cv=none; b=L8UCMHB+WztTlN+K0oMkfEUgSlmSUp4jPkAoQeRhyS5gLovJmdgjmlsME4LxiN1gxQsugdofWB8L1BDOoIE06dR+5vTRbxG+hL7OoPWo8ZL79hbllrXyYDF38eWQaji1B2kJIwzWOy5LCGYr2E3WyqLJEkDCIl5kZGYl46e4ioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810771; c=relaxed/simple;
	bh=T3jioV0uYhMptpdE7ePGVnLpqqa/uKRiB0uW9fNRDwM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tAJz3n/hyXuSYCWLfjNlqUTCyoh3xKnDPa2BiXEVWDoJHrcW+C8DGu+Ka7fvI8p+daaMLUSzGOFmhs1l6egi87b42JfznBMInJ0mvAyub5jyy2K48qQ4KPu5B0Qnu1JYnkCiovgScAUWkIW3Ww2BpNxTF8GNkmQ5HQFw7JFboQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-661094d05b7so6864606eaf.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 00:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810765; x=1769415565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhHumtWrNDdqjzdDle9ocqVeWG/xH25wC5PEXN85HcQ=;
        b=QqrsfMiLQdDX36phKdxrTwoc6mP9ia9mxFvIIoB1aj0950IYvnf36a72M3N4/+Rd/t
         i+kfJJxpRB53FGtaGEHfvXQfbpjzkJoLJ3K7YjPhMAX7asg2Lr3lmBD4TfC3UVVZ/pT+
         XtiuHMBn3lH3owjOjizk4BT0Yg4YShGXfbZKygj3nZL6J23pM/uS7qqb0kg6O4UdRC77
         UFkXLFJ+UDVyENd+R6VZSb7rHmPzuIgEjuz6rv561TUHXXhIQMmpCEoDtrngPPKY9MMb
         al9SA6yIu1K5TQ97XdGMsEUl1OyxxWRzBR/XvOL5gkFdOchZkQv5+AFIUvcGK2uDfeya
         PFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/AD4Jmb1SphU6aA4dp+8RNDyGiwgjhqOzFp9t0Qu9uz4teu+JcCVaPcaZhTv0d2RZlNwere0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4CaIYYNYz4cbXHQZf+Ojw0A4hywyLzqD0reHm4XZkjxtxl3T
	qMNkga8mAHHfalKSu7Qxg0f3fRaLz/aGIMgzj7G8KtdCRopG232s6bEn78qFxQY+/EcrabcuwvD
	ZesDy+rLl+HPKjhgY1l8YRyiMxVa2Fs5R9lp0F+rte5w/8yqZghk6xD7NQMM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:210e:b0:65b:2795:cb0f with SMTP id
 006d021491bc7-661188d5889mr3835274eaf.9.1768810765139; Mon, 19 Jan 2026
 00:19:25 -0800 (PST)
Date: Mon, 19 Jan 2026 00:19:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696de90d.a70a0220.34546f.0436.GAE@google.com>
Subject: [syzbot] Monthly net report (Jan 2026)
From: syzbot <syzbot+list849c3c7cc70ceeb09a59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 7 new issues were detected and 10 were fixed.
In total, 101 issues are still open and 1656 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22186   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<2>  8157    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  3455    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<4>  2897    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<5>  2295    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<6>  2040    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<7>  1958    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<8>  1626    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<9>  1391    No    KASAN: slab-use-after-free Read in xfrm_state_find
                   https://syzkaller.appspot.com/bug?extid=e136d86d34b42399a8b1
<10> 1387    Yes   INFO: task hung in nfc_rfkill_set_block
                   https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

