Return-Path: <netdev+bounces-173225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D85A57F49
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 23:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECB916CA03
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 22:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7CB1ACEBE;
	Sat,  8 Mar 2025 22:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257914A8B
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472242; cv=none; b=u6K9/8valagKS6xDXI9+u3URvA4S/jSplpxssrFpTJ12wjXcvCEMtFdiIk6SnqQp2BWCXWt3FBy1eJToJjacN237c+kVpoCKFpfHp7P7TnM9ZiIe0Zqj7poq09PvLZRlETswBVEb/Cf8PtBglF0JtkFHfO0SJq/6H/THa9414SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472242; c=relaxed/simple;
	bh=SaTkhtG0SkaBVklFl3Ngn63TnegBv53XmZOw6nVp0II=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kGi2i7v40fP3G8406WG/xafOltGjJlRdmL7vmaGfHMsRVSOEQNTsjBg1URSXMWgxWgDOi3lErlTB+I1KvQ22KgQCkao2QZFouvx1q7G8jzAMwqRyIZMS3euBjTLjMvCyhEUwSudnyRSfa1U5q0oSA1UsHHY4RlQe9j5ghhEEK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-849d26dd331so362635639f.1
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 14:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472240; x=1742077040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG5ILowWsEuUT19TjhP+3edOOuFjMjQ6i4y2LcVwbow=;
        b=YMuXC1wQ3+8R3E5Mxjc++yuT5nyc0VQ7iEb39eylEzVu3yUEa6u2yA5H3x6y0XTFwr
         GIIF4lMkvizcThviGby2OFI1TP7WvD4S9m5D4Nrq82W5iMwN+xrWA2FzTBEhFmN8tE8i
         rM0vnnw0J03X4bl0JqMi3/d9kL/lq+x9Y6igRe4iLzPXpQQorWLM/ICcUETQm6FYE361
         hMrA9WCIuWFctdnCnXzE9UETYFvtG24CA/w5PdBNyehIP0n3aJm88wxoHItGFcHIKIWG
         qHZTfPd4fuImfCEcxoBjowHddppVbz++KwfPjweRlZrRNMzc0dovnVarkgsnReUACy7b
         RydA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVXkUK+qePOP12JVIlpTgZEdJPfr1+UPrMO5lsAqqk33jcqDfW6l8AsEtLr3zm3nf5slHk8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKA0z17VmfILhdktq92O4IrYAMMy6IFHz4RWusqSwV5eZIgml
	Q5m5wiSkhRA9IAvGRO+06C7YdlqXdRTaV3BBFEvH78k7VF2Fjas+obw6V17UejueCdyqbIGTWrS
	4P6Cba9nYIGYTWO42DYfFJWCx/DOPa+zmiJEvtzkNMZgWg3IN2x1ELtI=
X-Google-Smtp-Source: AGHT+IFlHdfId2qa7tgSdU4uU+v4LWE1zzqSKiBGTx9q2+hXmGyACQ446Nrl/tFuRJUGXTOBSxy3kq4rJN6HjUy8AM7ZYXEhBdyg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:3d3:f15e:8e23 with SMTP id
 e9e14a558f8ab-3d44af3375amr52658495ab.10.1741472240574; Sat, 08 Mar 2025
 14:17:20 -0800 (PST)
Date: Sat, 08 Mar 2025 14:17:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc1f0.050a0220.14db68.0059.GAE@google.com>
Subject: [syzbot] Monthly net report (Mar 2025)
From: syzbot <syzbot+listfe984f00d0c1292a848b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 9 new issues were detected and 7 were fixed.
In total, 135 issues are still open and 1587 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  288132  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  60606   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  23481   Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<4>  11616   Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<5>  7654    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<6>  6743    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<7>  6207    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  5554    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<9>  3542    Yes   possible deadlock in do_ipv6_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=3433b5cb8b2b70933f8d
<10> 3166    Yes   INFO: task hung in linkwatch_event (4)
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

