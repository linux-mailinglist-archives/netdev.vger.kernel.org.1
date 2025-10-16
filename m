Return-Path: <netdev+bounces-229931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F3BE22C2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA754848F2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586330505D;
	Thu, 16 Oct 2025 08:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CC30102C
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603788; cv=none; b=kNfwbaotnxaoXRu5NtOL6snaPqmQd+a3exh/ECUc8CT1C5W7Eun/fzKQ5sQAZs05MFgZY7VBukLeGuMZxd1kY5NtHgrfiDt2V+gCeJyYBS6w7ZLFu6+C0zishfzagpnlf70Rp5HG30o7SXlGrfzhQ+1kVjHnjai98+sEEeAOQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603788; c=relaxed/simple;
	bh=xRyKS0JwhRo1+3ea+pbyYR/pMKlpQE6CyKrU/ewKtDI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z4ok/uHUkO5NKvbAuqUcg8we9WJPVC5mraFZRgOj/W0UpckiyEmPCgYM3XfEisnAlNPPqI3/vrq75Up7FLvK6gSKWE975oKH8WnRbXlbJN9UjnFsoa/Sr9ta52PV0753hyLCjaOZYR5j9Nl/uPGkCJikbiAMxpdmRU+kPc7V788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430a6113286so5961775ab.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 01:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603786; x=1761208586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JOihzuxcE0j0kNCTYYmFHW8Dlvj1E60i67RjAgUr+E=;
        b=dNR+E5S0HmXeu/sGjb9yLHmA8ChnsaYyZsAFdmlSGguM6hpsr8E6AXoUwZwFsdqCSa
         O5FTJMNHW3u/K8n92HMNy8XKWAHjyKsPpUeUpqhSJQCdcPstJikvIDLhEprd0kfzxQhq
         MqHratgPE7nAs5EIA72M7WRxcgAAhzozYg9Y9jZETGGb0ymzvQPvyNO6ydGLL+f2f8dW
         nZ14j6s8cF+kNA9zQiE3K8BjPOBa/IAkY4ZcFUxvBE3lG4mGx01uMMQxm+RVcIyyBnuE
         r7DiTt3NWfB2e+qmH1ThOGJKs0RMF5Fl+kxqKf8NMzS8EC3wgsvA4pxIsSjgW6D4EoCQ
         p6oA==
X-Forwarded-Encrypted: i=1; AJvYcCXWoDLfxI/V/wy+j6dd4fOmOxcC0i/dcNN+yqGcQyhNvmW8eb25Hzdkq4EhbDbWfT15MO74VUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqdM9buAPZRJ/3gceG1P+qyouSxt94QHxB1Y+Zs88Gu4wl+ik
	muGQ1MXLOwSwVpOcNOblYHEDHuQAQ5qF23ThYb1NmrGcsWU42qN4vX5FRYycz5Y39hfKHBexmxT
	gg/X8YzJp5NC/FtRZNn4BPx9Omh5afm0bbv/98IAjGQfyCoWM18DgnQ/QmbM=
X-Google-Smtp-Source: AGHT+IG8pmSnZTt0oPjlzAO5BfvnE4unnP34RhDCkfrywJzb3EzzkrUpzn/dlen4p7wRCY5rVmSy3f4/oPLUCQ9efgGorSegtOSM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:430:aff9:a82e with SMTP id
 e9e14a558f8ab-430aff9ab5cmr46037845ab.16.1760603785852; Thu, 16 Oct 2025
 01:36:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f0ae89.050a0220.91a22.03e3.GAE@google.com>
Subject: [syzbot] Monthly net report (Oct 2025)
From: syzbot <syzbot+list00180149ebcbcd4214a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 10 new issues were detected and 6 were fixed.
In total, 102 issues are still open and 1631 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13668   Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2>  13489   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<3>  7713    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  3379    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<5>  3031    No    WARNING in xfrm6_tunnel_net_exit (4)
                   https://syzkaller.appspot.com/bug?extid=3df59a64502c71cab3d5
<6>  2706    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<7>  2043    No    KASAN: use-after-free Read in __xfrm_state_insert
                   https://syzkaller.appspot.com/bug?extid=409c1e76795047429447
<8>  1870    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<9>  1820    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<10> 1567    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

