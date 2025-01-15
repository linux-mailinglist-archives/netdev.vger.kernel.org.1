Return-Path: <netdev+bounces-158519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33411A12568
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846153A27B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178870816;
	Wed, 15 Jan 2025 13:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B824A7E0
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948909; cv=none; b=a/ood1OVn5D/dqXpc5o5hWE5k52shBFEqSlwnEHnDTOVwATF5lPMGExaISZPGU3AGm9Qdp4WCyJ8p5S8Nss6V30eIM/8YvHGCe4ZhLzeAMH/g7S3BcUDsuJvp0QcqLxvCr7paTQDUvYt7As8xRXzmM9k7FeseO5ar/w9vCHDRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948909; c=relaxed/simple;
	bh=rEAPHA1abP0sujPJONmG9VSZxci9i71qDCn7ZtGof0Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ulb9puRhOncn2qeCGZAt+uXKkKBRdm1+ARoVNSEpsAhJGZpJd3+yxVpU6CErSHrLjpG6y5ZhBkTt5/kjR30kQFc5Cr/sNNMZHdL7+uCxmGCOVJ+VjsimHlDYe4x2QhNW0tyk+Q9N31fuD8Gxguh0HsgVQGwZrfvbbgaY8tStC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so120657705ab.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 05:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948907; x=1737553707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NDK5DLIh1fZyrKWvILXfndimZCQbg5cpXOPK/22uk0=;
        b=tUJHQ8aPPXhaay3JDrxV3LXiWXVR/vRYkJRqN6GGeXPqUKv+PTrDQvXsv/HBkLkGZ+
         6k5eU8GL0TKYNk4mdqPZi/lfO4Q1RqtM3P1e3h2NLhY2GOqTKsyo0ODgve2Td7nuSyeh
         eYht2CsYHaDgI1gBHoB4uyF8erxhvxwAlI4MFR07NO5p+I+ZkQi5384XPNTFrgX9o576
         5wick3yCuivU3lZ8k7t8toBrhSH6KdethzRbtqNjXFedEigbSvlUHiKJE0xKK4B0LJ4B
         CQsu1guy5QjmudFZ8TX4BhBY8vPawG+N2iIYxPAasUuQLQy5bsjHJ+WX/r4W4U2VIf4c
         aNNA==
X-Forwarded-Encrypted: i=1; AJvYcCUSV1Pwev7xThCH4GXvFnTlMeB7I1rQliuel0kZ3I73J9xPyUuRWeNPkdHhaAEbTQSjMeRonq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzArMd22ylkXGpCsPlV15nILa1SxbREO1zFFEGUpYAz11cOptXS
	QoZ0umt3j+uEBLbBB0OiYUjcVKNSX6w3rCMTxtHWxiRqUirZtbT0Zbp4VJ5lvjMKSIwzVM68JXN
	QcglrZpwtyMU2WfghaCvyZd3o/q5gAvBSdFK05aq/HzWrmRYIutbYOMY=
X-Google-Smtp-Source: AGHT+IGEJ90l3vPxFfDM1H+9IFajPIQeWKsRHU8XoSqebmq/RfqTf+MjiT4lrbL8LKAzJamxgt+VH/ULcmuDOVGSQJZkU6FlBQKX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f89:b0:3a7:dd62:e954 with SMTP id
 e9e14a558f8ab-3ce3a7a8ab7mr238896135ab.0.1736948907275; Wed, 15 Jan 2025
 05:48:27 -0800 (PST)
Date: Wed, 15 Jan 2025 05:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6787bcab.050a0220.20d369.0018.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jan 2025)
From: syzbot <syzbot+lista7b682df404894299f40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 8 new issues were detected and 0 were fixed.
In total, 60 issues are still open and 147 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  70405   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  6211    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  5866    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<4>  5673    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<5>  3627    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2248    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1194    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  740     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  397     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 335     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

