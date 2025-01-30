Return-Path: <netdev+bounces-161640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3008A22D66
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1953C162A85
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210D1E3775;
	Thu, 30 Jan 2025 13:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B691BC9F0
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242751; cv=none; b=qM5Gh/+oxQK/Hyg+TSdLDp7gGQnRRfy0wEmPBhvBTOD+xTK+ZUAbyx/FhB6B+MoLLksYkj8+v7MQoqceHwAEfXkNIzO7KG356sNL2ArurZTH9zbElAMqL9djm5+UzW/2AWa5TZ7BpxbB2zb+tR9fI64sIdZXDQMMyVkUGakFBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242751; c=relaxed/simple;
	bh=UWhx295qmY3GWSKOMZW+APOnFJqWoObpRK5OQrnQBYk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kbuCcWGahjhm92iNO4e+eTTWS1c4L98IawBNt+GZMn8YW9gVG/nHhASNxbxv3X6Bc9NQ6GD7rRPNtyTzNWb01/rx/5zuhX3M0kLEDNTDiqJTxOvBitbyNR2gWfwFsJgK3kIShogl+OLWNs7Ss55n5E0cJgSkALcUSbXT/i53U2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso4344955ab.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 05:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738242748; x=1738847548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcXw+weI9Kk8+GGZ8VUeVAxRzMM7UfZFaRgdoYJYpjg=;
        b=IHwQL/aOw/bkcl2cVZhn0MOUMnTs/SvFl/FvevlV8V98IFGQb1OLkSYFaTNRk9HyMC
         LDw2miQo/aSdETsq5vxs6LHzPXNGcLPbbwdNG26Oyb5OAg+E2P+qCauT0jvtooj9iyk1
         /eyWPDamsUn35vKL0UVSZm7jNZSlqz1xUuNnJmaHHQdhxY/I25RFv+UkXZg+2eG4V8FH
         pfjoYme8892e1Z/YgLL1W5iaOEonui2VoNbWye3v+PQAnv561h2hPvtLt3Iy6WEX4757
         XI9ech25mWv66tnGINIWZAmyLmFZmjcLD1SGRIcbzyEATo7Y+0LEz4VB+pTjmMJDYYBk
         EWJA==
X-Forwarded-Encrypted: i=1; AJvYcCUzc4GJz9gIysD7be/K7i56qzbOS/8K6hT0J7Bq35QT2xcoe+rZoXkO2S6pU+LfGV2xbv2dqM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZX8mrqAun3vXOu7WrMrFh0bpdgQNPwCjQbaAsNTUem/p/Ii7z
	2o2DZCpXrHMA3lkm08Y0POd9WGeyP965gM5uIKL2+IymQl4rlLxMRbSpiOh4r36PYpJA9HUYgAe
	FNqXuT/CpdXVp7/NZCcKXW9c+Xs8LwbP6B369Y/jJVcHYD/uFRLuZDYg=
X-Google-Smtp-Source: AGHT+IGNGlTx07cXqgLqsCN1w/mv7AKqoofadPmiBbvugykq4wQQuUgPz9Is0j9cRsAtzgcYvLYd/T0AsKEqT//r1fcggDQhJ3Q9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3cffe42f28cmr68960695ab.18.1738242748599; Thu, 30 Jan 2025
 05:12:28 -0800 (PST)
Date: Thu, 30 Jan 2025 05:12:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679b7abc.050a0220.48cbc.0006.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jan 2025)
From: syzbot <syzbot+list68ee45d79914eff2710d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 267     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 88      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 61      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 59      Yes   possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
<5> 39      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<6> 5       No    possible deadlock in siw_create_listen (2)
                  https://syzkaller.appspot.com/bug?extid=3eb27595de9aa3cf63c3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

