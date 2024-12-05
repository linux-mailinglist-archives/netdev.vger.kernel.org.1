Return-Path: <netdev+bounces-149289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F789E5089
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DE316A633
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712321D5AA0;
	Thu,  5 Dec 2024 09:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7991D3194
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389469; cv=none; b=pKu2Xae2KRUji8btvChkydMaErJ7XWK+IHt64/hgg8j6FviHPNq/5pkkgtZMiafAMzHQMqsAdkc0IHclVQd4QIxSoRGQzdg1HnUgASpr9RlbljW0YeoCC+LBxK5W/UDI3CiKF4VmO12BL8V1kNJBgU8PeG/bolFx5T+kW5P++Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389469; c=relaxed/simple;
	bh=zgVVy5XTLk3ptOAekcjfO0olEswNPRCyhZPPRQnNnwQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZWgc3g50i1p8YqEPQdn1Bcof9RriTaPYcj58GpuPZ8xV5wZY4FwpASDfVK+IOGWcWpc9zYHNjCJm8zgdZfKzbFU8MyvXPT0nBckiUs2J02rfutOz0TJS1E50f2dJ2Ie7O9oCcXhFvTscMUP5Lb1FeoMps+Kk+M473n4dRFyCUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso6675085ab.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 01:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389467; x=1733994267;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A50ennj8/l5LmpVJOQIb11du27QuZZWN9nvndJYiIt8=;
        b=uJTc8xfbQOUHr7wvRzB/sO9J3FnS5zF7dXwH5FhoViUgC6zlWbxVph8fcqOYTqSnKH
         pAWW6I1VF1lg7Ib74eHUS5oMyX16JnVdUkRrGhDVdipBCdfxHJ7tgUDR0QaxIaxewQCJ
         8j9GT+rml2Nz2HI3NPXsktPfEimqn2QY4TMm6kPzflRO8AMcVs+ds9noRwXB2lTvMaYI
         QAPABDBD3U1fP6NYEJUoPfob5m66iMzcpuoUcXvZt2QKmB2fCQwd3hW9DBveTJwsHJXJ
         W4MmGqdMvKvbBYE0QTB7vhHhqVFb6gfiCIZRcGJ18BjH3npNsMoEZtA01MfK+1bS2OUI
         Pm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6OXKrNu8RL8aNYtVj/wl1MJvnAiAFf/EfpKgr3+bh40W3S0O57ExbLfrrrHhdQTpRc8AlyQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxZIfOpWz8amke5mH+GFbuFXW8FglT8ol7TLe+hLcEyYkyl5y
	XOIS0A9ACKjvKhtKlVsx4XbiTRMwIYeW4PDVpHTRSHD+AdHOLx5yf84S1FRvpLjltziN1nn1xvV
	BD2+dwsKDld5s1QdIP1Nmx/7zVfhRd3PCZK1DAkDQ648b3kFVvPkQ3AA=
X-Google-Smtp-Source: AGHT+IGkizZga7sN5CYWA5QG1tBS31IluCqSzfXOIYfU5mE+eH6H+k9kkXC3INhDqYtZ1bVXrqsdHzGTV31W1c+dJe40KXNLf+zL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a7:c2ea:1095 with SMTP id
 e9e14a558f8ab-3a7f9a372a3mr133223625ab.1.1733389467082; Thu, 05 Dec 2024
 01:04:27 -0800 (PST)
Date: Thu, 05 Dec 2024 01:04:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516c9b.050a0220.17bd51.0090.GAE@google.com>
Subject: [syzbot] Monthly net report (Dec 2024)
From: syzbot <syzbot+list3c1df63765a7b6dd6d70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 14 new issues were detected and 8 were fixed.
In total, 123 issues are still open and 1544 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  229243  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  31386   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  7345    Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<4>  6028    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<5>  5974    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<6>  5836    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<7>  4913    Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<8>  3323    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<9>  2606    Yes   possible deadlock in team_port_change_check (2)
                   https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
<10> 2505    No    possible deadlock in do_ipv6_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=3433b5cb8b2b70933f8d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

