Return-Path: <netdev+bounces-115231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2299458AC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8B3283F78
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1241F1BF333;
	Fri,  2 Aug 2024 07:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C881BF31C
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583590; cv=none; b=RMwbkM2XJ7OjsxiVVOUClwPBh9Nhwl6q2b5Klt2F4CygxL/TuNNbSJZPNORIqNBvqHwYEXec0yOA5sGg9S4nag+Ssc2zPl7bYNxmKdzJA7KI4Sn9jbWf86nmTyy97hhWJqksVD+zd4ET661UXVoiAN5v6R1ZMgBoQ6ROeXQOwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583590; c=relaxed/simple;
	bh=mXj5zq9cbihDCWhZIY+vpwJiaJLdPixCkZlSlmf5rT0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kjqr3AcNWFhZaM9uUSqaX7YuDOUM1JRCqfCNKic0K3P5zbxkxwT5wXpy796+nOm928VKX6AgEMT/hxd3hlZRXkybNxUU0uffUmNVjX0YANwwVHBeju3Ss84fIUxykVCX9iaK9m66YY9reL8ZCP0JDZtgDP+u4+4ME4fkpBDq8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39862b50109so113472105ab.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 00:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583587; x=1723188387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrXByCznmhsppVEKcGZ/MFeTWBUrt3Wcq6+zhpOmQNM=;
        b=eWvRj2ThvL+td9TD6yWWTvuKi/pZIHb7H1wUpjOEqvoBKiTEs9TreJLazb/OtiHN46
         euZxzG1wOWCWqGFMy3nTwXxMXJjTGLFPNS7IqVLxiMlKnd30BV20sy2gMlc/acjJFd6b
         aXk03fb4qhenck4bJZRmS5+5q5jQvL1E8D0K4FIHJ6Z/1CurvdfuGD6PEtF5t6g7MLAx
         QaG81VV0wvbsOj5FNB2hueWkAS/As6wOncg5lPhSYmYbnehf6nA4KPQ13msG0eC+ntNE
         n0ujU3ZPc7fgI3ZRD8XHKA7eGjw8DP96XC8m9tGmjhyq6C7fXTxoTomQeLph45u9xBiK
         H18A==
X-Forwarded-Encrypted: i=1; AJvYcCXXZFvZkJ0cDlBo2793r9/w1WTtd3LPt6IQaV6aL9Q/2aFLNaJgY05mV0vxzXNhn83Ju3ae0LpWcOQuglPu/2nwQ/quyc8s
X-Gm-Message-State: AOJu0Ywl0vAOaqFIvLdUWYJZDtvRXK+FfWweWRkcmNY2ZsCXuxDUOtHd
	+kIe8KSRUOLdbZw0fmIkJHpAX6GTWrY5mtMWqtZsP9nIXyx0TDtVgsawiIswgCL6TvPUulOXn1g
	6vXo0cys4IZbXcze8tXNxqB+w2+NtCXjfJloTlZGIEl1AsKxrLoF3ORs=
X-Google-Smtp-Source: AGHT+IFotTmT94wCutbGucYcHOJn2xrABFMGERzA2A3CFrqC1D4uiGnGJsP4CFNn5M23ICuawfJVIuNNKtn9+Od6xXoNbOQ5mlIz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39b1f7a3de1mr2031555ab.0.1722583587642; Fri, 02 Aug 2024
 00:26:27 -0700 (PDT)
Date: Fri, 02 Aug 2024 00:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d668c8061eae3ecd@google.com>
Subject: [syzbot] Monthly net report (Aug 2024)
From: syzbot <syzbot+list8e95f1289d8f38f9e414@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 17 new issues were detected and 9 were fixed.
In total, 110 issues are still open and 1486 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  97695   Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  12003   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  5132    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  1530    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<5>  1221    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<6>  683     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<7>  670     Yes   possible deadlock in team_port_change_check (2)
                   https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
<8>  588     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<9>  543     Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<10> 488     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

