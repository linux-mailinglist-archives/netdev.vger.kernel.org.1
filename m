Return-Path: <netdev+bounces-215172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D9B2D5CF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DB53BCD4F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479B32D9EC2;
	Wed, 20 Aug 2025 08:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC5A2D94BF
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677499; cv=none; b=rhTcq7uzaxouQkFDK+8ZkEsggSNkoWgtCTTlsfEPfJF4toPBT50lX/f+eHEwK0y4qEeaOeMS1IsCEyaYqEUt1L643/qh90LWHRrvjUh2d1KIJ3NQDT4iVt6FpUgDofFfrEsbvyI8b6fPzyzJG9DIPn8d/hLckArz5l1vDaHIwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677499; c=relaxed/simple;
	bh=V2ORPdLKdyIF6IEfPL3tmlEaAeXzXJCqBpmsLyhacgY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=osw4Ulm74dnG1PnHayIGNQJ0ZDv1xWdWbWkGRCJW4bqQIBIYWyHkKahqkE2ABAiHN/2oi1q/LYi7pzwGOBeli82/6OESHrkIGPl0a+i5nLgM5EwJyMT+c64OPR/vdoOF1dnFNJPYwJ+Lp7yxkuFSPDfpFuSMK37BkVubfRTO43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432e1eaa5so1586629439f.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 01:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677495; x=1756282295;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfbB1FSHiw6P4C31LBsKWDW7GmtJlZq19wObesXeHDo=;
        b=NzX0GPntZIQOWM0I5a0eIwoHaQxhQiHJbIgguuA0SVvQENoHIugA3k66LUYN/mdZPq
         K144GZEYUAz7WhIAOWPVKQFGgZ/KPYym+/q8Cp+UlschGx87gfDyGKwJzkoA/5KEDNdN
         WtmqB+uOQUx5nn2nm+uSxsVeyhOELntPBepa7TbBvBA9d3yCBf1bgJ/TEbXYfgc6fFJH
         PWhtkgeQS53s3vG+cejt0/A2zlFZvHZMXmGZ/zbf1R4D4NbqLAingNaGTsLXwC7htm3R
         sfWIJIYlFthBljsfXdblLIVeml0lq/kt1zW+7S4UMhuLM+CdC08i8Qj7iC+8pDpGs3PL
         /ryw==
X-Forwarded-Encrypted: i=1; AJvYcCVkP1ZqC2sx2ZuMwab6f5CgW6P1IYVvNgckf0TbJwIQXe/TqZgvvKhI0j1IXla80mEgb4UBliY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxiJ/V4UgSXgJCXbUesWj5+tf5CbNq9/ysKGoo4nTuY6XmhmI
	yJtjVDr0AFXhxsR8W8Dp799yTG57clJ99vQKkhSvaUV2auKKlQeYsLznkp0rDb4YhFW4xitVXGc
	4N4ibI23n310y8nbfnATlkrQGVwvgHhUgWCOXbCBuYDiHskz9ob9iN2wtbig=
X-Google-Smtp-Source: AGHT+IHnRF+BVNV37CIIil93Du05nxMCfrOSZyzGWdOXk9nJ995NrsrdEI3T3s9GiJy67Kvuu4cXP2vILSqqRV705ZzYbnkNZ5za
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2511:b0:3e5:50a5:a7ef with SMTP id
 e9e14a558f8ab-3e67ca7243amr37639535ab.15.1755677495685; Wed, 20 Aug 2025
 01:11:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 01:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a58337.050a0220.1b2f6c.000b.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Aug 2025)
From: syzbot <syzbot+list9abda43ae935f9073c3e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 1 new issues were detected and 2 were fixed.
In total, 10 issues are still open and 191 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 552     No    KMSAN: uninit-value in __schedule (5)
                  https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
<2> 203     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 104     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

