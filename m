Return-Path: <netdev+bounces-130118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB9988642
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CF3284F46
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98E189502;
	Fri, 27 Sep 2024 13:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE21EB35
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443710; cv=none; b=sonye0eiVtZyvUyvNY5yHqHsKucEVNCgJEVZ3D7lpWDweLlCmvTyBAu0O8tqBGFpKgfTosg7EPp3lbPgf4xWqqo4a5IF61kdwohHBdrkWcxiRd+VidU5pd0O93nizYNFMolmOCfGXBWcIi+KC9Hi3vNGHfkEaanqYQ9qVjiE3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443710; c=relaxed/simple;
	bh=0E3niAAD+G6Dw2wZipJtWeSFOTc8oYKzVvOCAU88kD0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=csYZWOPSih1nOAskpRZzKQRJv15qYrUMvfvHryXpenXIpv5vH/SECoT49Q+oiqKjWRCxD5I3hnAveYqyB1eLUp1TKBBR24TIbuW4j7PKdK7eQlRl33venU2mBPG81nw3B6NmKjhUf45j8pT0fuNAEI38mHVMp7rBm/gY7BRDrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso24983315ab.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 06:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727443708; x=1728048508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=et3EJGS/ZhbG/lI88ALbK4RuafRSN9jb2K6pRh2BmS8=;
        b=OkVoWhpcPeM4LZ5kP/zrTY0AYqnit0iXeniD+3CN2wWpfj3GEpjfL4kqnlE8ouWiyc
         zehrUn443chiATBZeNa52YQjYPgNluji2vC6Pg0X30MCOXAXhckq39xA2cxQsKWCf2rW
         xJDzAoH35k71KqQ96krm/ZjQDYBKW9xwcHx23wLq2xRAAb96pHY2xcHIr+wnLGhW9mgo
         Icq2AkZejR58xnBvAub2Vh3NMRwL/Ez676tAxeZuGHWnTW3IelQ+vdUmyZb/8A+H+YU3
         /h8B8Y34kiQDF1u6uMllmf8rZWG3VfBUQsRuapjyTJhETstU8IofRS0oE0Bey7rkTG9K
         XQxA==
X-Forwarded-Encrypted: i=1; AJvYcCXAPPBIIBayexWTuKZJgPWsksPCjMt7kRpG7YQkzMGrGA7FMJDlHQrXsDBmMZiVQjbw8P8eYRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1FHQNsqpfCBtex66fKMBXOjnv7mfsqY2hi8ONCBXAsW4TbSE
	41ZE1zHpT53wU8HVHOXMI8VyKHAIfE9hpT4Gn5C01T8e525YuO/xfF5X4a5lBXIKBUBHutu47nE
	+7plLYuwGK/3Cnq1NSOjm2mnlO2/bU3cP/Pq6RLyT1INzBNk/PKYidsQ=
X-Google-Smtp-Source: AGHT+IGbAy1zQGCXJ8P9FxZGs/Bk5j8b4JyoiAHF4y/M7LM/1pm90J9RVbpSJypvRrLgcIFQE61mi6q1oqHqwWy35OxkvgbNl7YX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3451c3a08mr32873305ab.24.1727443708274; Fri, 27 Sep 2024
 06:28:28 -0700 (PDT)
Date: Fri, 27 Sep 2024 06:28:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6b2fc.050a0220.38ace9.0013.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Sep 2024)
From: syzbot <syzbot+listae4a64541abfe3a7a043@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 61 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 135     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 111     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 26      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

