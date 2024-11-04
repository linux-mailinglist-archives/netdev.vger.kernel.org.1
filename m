Return-Path: <netdev+bounces-141434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED89BAE84
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6231C214CE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2681AB53A;
	Mon,  4 Nov 2024 08:49:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7A1AAE2E
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710170; cv=none; b=StF0owDQIshfyZibv8TKg2kJ4GnvnvY+QuFxmtPAhPdgSOGZqnAE/B8skGcaQygqrVWF3l04zMRD6T1Fbc6tgCA3os70GhRC4I1VKxX6w9uDbT2fJuCH2Vi5Lu/9eqV1LNIvBYB/YvBpEqlFwCy91MXiR4mBbu/SMKIbwnZIEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710170; c=relaxed/simple;
	bh=T5ZpQ0uKsFL3crsxgJWknUqYfFswyHIDdqePv/MS2TM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o4gQyRZgjsaK7vubPINHscwsbrHK1qoGNREoWPQUb57puTzbBDNaTBIkfJScZim6pI4bEjDpFDJWszGfuhzhvYXYpiZeDn503EjIIYXsvl0rwgVadV9oDdKQBxVmicFizXVSeHf8HX1YB16SSjZgVf12Qms2JKD6yFqJJqZQ0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so24015225ab.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 00:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710168; x=1731314968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOwkWqqxohMJOQlf2H05azs3HD/JEf7oNqSDOLyAQbg=;
        b=BQEOeoI0O9v4cIriJJyvS8aFVQd0ic0MsxFtTb42Y1cPidl385+CY64+kThpVPPmna
         nNSaDpk6qxiVTf6GMJZc1Hp4jJarVg3V7yVx7kfaGhOPjfkN/Gl0aGMq+dkzAl0n1kON
         fBgXiA+dDalFtsiGteP/xT4w5NvE8bGDIjsMWDS4Q70GJB2nb5FT/pHL0wHTuYPbofn9
         QJOOV7H1D8Ecn+ZHaYtplNEckJq/rXa8Cw1uLtW9mGPS5SnvYJijQjAO8Mv+vXJVZhRh
         KhWHqjWc9IJFFAquzGf5KEAYV8/fa44mu64ZFA6XDeBnthIUobjYuoQRWbPkcOn+zcen
         kuZA==
X-Forwarded-Encrypted: i=1; AJvYcCW+G6pOAfyX0G2Hi+Mff6zFpJbl0rAFzFLXl8V6QFmIpMLSlNkuyWRvQd9BnUVG8hgaxitLbsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzato1Fymxdy322qfWwLuNoEOjrlRrlIurO7drAz/MMkkCJkLO3
	kxr5+7lCwxJjUwhVmzUeadFaOFHX60H0uL0ljh4Z8B6UbvurgoF4FKhp/Et4Qtf3Z8VdzYLI4Fi
	ijZ3WNZ53+rCavRC7DNzRnGAtsqrAfjlm8CpdCrc6Vvnqm8AlKWGMxNM=
X-Google-Smtp-Source: AGHT+IERiS/Vw313wFkEg134lNn/lq5m19mUh0+7/nBPpqfNeN3Gu7myMHDiGIvc6leH7eS3Po90A1edqYTTUV4UITdJursLhXv4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2401:b0:3a6:c24d:c2d4 with SMTP id
 e9e14a558f8ab-3a6c24dc619mr54630695ab.20.1730710168333; Mon, 04 Nov 2024
 00:49:28 -0800 (PST)
Date: Mon, 04 Nov 2024 00:49:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67288a98.050a0220.35b515.01b6.GAE@google.com>
Subject: [syzbot] Monthly net report (Nov 2024)
From: syzbot <syzbot+list84b6e2490d1fc17191ba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 7 new issues were detected and 7 were fixed.
In total, 111 issues are still open and 1534 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  207393  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  27206   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  5765    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  4885    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<5>  4702    Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<6>  3069    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<7>  2968    Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<8>  2222    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<9>  2000    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<10> 1875    Yes   possible deadlock in team_port_change_check (2)
                   https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

