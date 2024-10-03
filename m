Return-Path: <netdev+bounces-131522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC598EBFD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D8D1C2204D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC413D509;
	Thu,  3 Oct 2024 09:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AE126C13
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946145; cv=none; b=fktEntWSf/B3BZFvPD/rEJC7I/xpnDvtvhXxo7MjGOsTSLr5ubSslktNiLBLc/YlSxtOVQwfdwoHdgwO+x2MLht8tgL04KmxEpBr0AemwmlhRHt709eL1MOv8xmSgJDK3EuDvKhU/Ia2xDWiiE9O7blMDw7ZLuDumKBc48N07CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946145; c=relaxed/simple;
	bh=T8RZmIBTG2OwlLxOCYttHUNlzr3vc6lxdcfnyfa1QWU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o7e3NQqgFhlsACf99D3EqWbZOJADNZ3Qx8VyMx4p8e2g5pQHqJ8R0hqUhZrKQVv94CCPq6SRuZ03VUQ30aXmHnVs7q7JB8HEtowzWi1yB6CfbUBZg4If7xabNJjzO6WawMxKOooEzcUXr/Q1o+xceIhzg0bWx4t4/yaE+85F0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso9569385ab.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727946143; x=1728550943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96/JtGcYs5X55rRgUMx9WctVFVXj15MbvF5pfz7LX0Y=;
        b=Erzz7rsR5Dsj8xhJc6semAtYS/BW7TvytQ3QU3n//5Aj5Ld5XjAABz8lFg8YNOZFrf
         LpqwjIWUSR6GE+79j9As+1yFNwdO0oAgPhJrYBYvnw8G9VKRlzS7y+qe9Y1MmC13vLQD
         rkgfQ/S15/zmD81BgJw+alsaH4hFy3ImNCgfDi3ozW5cm+zS2+Qjnf+/m1WqyBZlwL1i
         4Dz3SJ2J/JCihxKux+G0WnYLHkyImwBhTt62hsf4s4GRwg790cAmlDBNN0YGDdTEACE+
         mR9/nyGa4Do5YRli9dPRzJp0dEVBbBJWDDcxR1H1OG2Kty5TXJ6OXfQeb56mizFKyCRm
         pP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXB4e/6KBZUpUB+6t19XzIPLBRjIcSsKqCtTZulzNAyCti7usQ89IGlVJnQ5bZQU/HsM/aautM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEW6X7+UNYEk8pr49NVCBzO17oPAlXKJsYZmk1imcXyCfSfeqY
	21WFj5hVKarKktdukORk8dCj0kCpgiQDijfvgi90nI5jNVyTdVU3EDuJASgRQjTXT4pfHTqOjKe
	+Dq6l4/5kjfBbiIxawl1lHcPdOzPcRW5/OycTVVlKwyEXdWA73MV5ZiQ=
X-Google-Smtp-Source: AGHT+IFTDuSIiRy3Lg7bKFADP5fMtd3Gi5LEj2NejCxT2x6PPpEHQP6M8FlKFEvsvD3sc2ctmcc2DhAxcpkrXAn0atiSiF2UeRcM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d09:b0:3a0:c7f9:29e2 with SMTP id
 e9e14a558f8ab-3a3659440afmr59958735ab.19.1727946143033; Thu, 03 Oct 2024
 02:02:23 -0700 (PDT)
Date: Thu, 03 Oct 2024 02:02:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe5d9f.050a0220.28a3b.020e.GAE@google.com>
Subject: [syzbot] Monthly net report (Oct 2024)
From: syzbot <syzbot+listfee1254971fd4ce8fc71@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 11 new issues were detected and 10 were fixed.
In total, 115 issues are still open and 1524 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  182129  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  23127   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  6218    Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<4>  5555    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<5>  3415    Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<6>  2547    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<7>  2245    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  1744    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<9>  1408    Yes   possible deadlock in team_port_change_check (2)
                   https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
<10> 951     Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

