Return-Path: <netdev+bounces-239043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCE7C62CD4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 078CD4E5C81
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82031CA68;
	Mon, 17 Nov 2025 07:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BD31A556
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365832; cv=none; b=vBgqXNX2oVwAHXqo1IDmK8VDICmqxVBWlO9R7LA750iUP+g3YYjxxSxT2F+LmfoHOnYHSYe8DBurxVrMUwFrwYWThAMRnHjLKN1E2qRjTEhDYONa568Q+/VVUXvw5vkEZV9WV5x4ZU7edBII1XqoXRhM9g+ey53wLcRn0NjejZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365832; c=relaxed/simple;
	bh=Y8wB5ZxrHztDsFTZWNBUOw5uR5hPhpOcMrCCbU99oKI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hkiBZG2Z/2M6NcV7/MLESW0qO2ogvO0C3OCCY1i3rsaju+HRg5jC63HciREvaVSAKUojvQ1gplW78rH7qz8KMNs7tWff2cHVTSHMYvRhlYSEAyhXcJ6et406tS3MX6iXgGGeYsrEZXWN/8w65muqnKldwagKuI+hkSkNscmWclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9487904aeccso279835439f.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 23:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365829; x=1763970629;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ey1+m+0PpA+X8cyQeg5Cw9TKZCceb1snYR4S8Zq1UtY=;
        b=J5Pz+vJseJizSOFOV862QeHK4y2CFUQV1BFlB/sIw2KTv0cGwdv0h5vluMxEQ2tx5R
         ePNqZ2Xf/0sv5lJK7288Q7T67rhFaWfhd3AsG4U7+o29NwZZA4Wnp4wnHaGQHkOEp2pb
         W/AuDl8rFANZ4OubpD3A25ydCfo6JXBAtVAnCKD0hYFNq6kcGqJdtBJQnPFcAv6AUQh7
         4YTcqrdQsDTRDlNekoZ8nFDhkY3HvyGYV14bMpYuiNeYx62Z+vBg4giAShJGBy/GhyXE
         vpO5EoAULKChDCgbqrtxIii2gM6GgletmrKjb014+Mit+8wYgwcqfNzoy1DUKTC2dC/A
         jOZw==
X-Forwarded-Encrypted: i=1; AJvYcCXfELozweUqkck1nqUTbHKehmavTHzsrwbC7fBLjQ0ulNbZCNmGEh5q0jQgTQKmJmITM4qhMJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNGf9Vc75Es4NYccQoLoDngu4geAZTSA0fO26DJIfeWQjxUuh
	UWdP/lrtr4rntVclNrS6Sj0WR4aN+lFwdCMn6jkVFkdMp147GXJc1TUB2+/ii+5wX8ho0WvENgs
	3RIAMac8sUuhkAh+cBxrNurc04mRGUG6DzQtOL1D5hSqXSDdCndMNsNRars8=
X-Google-Smtp-Source: AGHT+IF4Ax7KDGsQ3/G5Um9Hq7UFEsiFYZmNZZrQEigC52suQIGaiib8cbPHnExXI7K/ZnrhQ9AH49U4Bm4ILaNe/BjfS7iya07M
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:434:96ea:ca18 with SMTP id
 e9e14a558f8ab-43496eacaa0mr92275175ab.16.1763365829199; Sun, 16 Nov 2025
 23:50:29 -0800 (PST)
Date: Sun, 16 Nov 2025 23:50:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ad3c5.a70a0220.f6df1.0009.GAE@google.com>
Subject: [syzbot] Monthly net report (Nov 2025)
From: syzbot <syzbot+listc0722b57ae1d515c34f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 8 new issues were detected and 7 were fixed.
In total, 99 issues are still open and 1640 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  20003   Yes   WARNING in xfrm6_tunnel_net_exit (4)
                   https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
<2>  15678   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<3>  14160   Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<4>  7864    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<5>  3393    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<6>  2760    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<7>  1916    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<8>  1894    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<9>  1580    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<10> 1537    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

