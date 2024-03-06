Return-Path: <netdev+bounces-77848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61120873319
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E970128681B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069455F861;
	Wed,  6 Mar 2024 09:53:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF95F554
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718799; cv=none; b=Gg1dluuV4TBD5ylYdnK9b7o6m95W8bHEafYmgxL+wf2lPM4x67pYog+yiyuddmwZsdxFeAtMDSWE83ayUBajqfhdKRX8JJWL+jeZ//mH0ByEhrJYXIOhz2r8zvpkLuWpdmbfittK/yQPMJ0KEU9lUht1pFL3MKyR9SnhkrrGfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718799; c=relaxed/simple;
	bh=RBKpY6uTHbNRvkc++ykcWeEmfUxZUBNwIYIcX1qKjUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VJPISTe0Y3bg1MRFmwPlO2RjxVXEAjPX3kVPPaoA8i7Ln5FVOJ79zbATdUB5LuUGEbpH14ZooQZMuZmN4LPeWv/AjYbQhB4Q0YFea/FRQRB94il/JQzUGK7Uuzia8ionOeqhxqKr4gDB+Lh6iTe7SjNmByH3MHMadjbKQKcO/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c874fb29dbso67926839f.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 01:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709718797; x=1710323597;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7GshgTWBC/O7D9m77niat5ipmKRovvawMUZYhZfFyw=;
        b=GhLRfg+5P4i50DKT/ncLAg1Kd5zlR9Bw4njIcgXRlJWsXqi2WUZaOppl3usazyDqwh
         NDMx4b6cKSVW9N+ftZuwQlzZWN1IG2Mwg6/KQ3U8E89aibzZBmLkmx4Hn/9gy/7w9ZCB
         M27pIl31gUk1B8p5SOmAGLOFVHuiJzAPv10ZjTP+UtWoO6PT2lORB+uJjj2zOuXJKURN
         yvEpdOeqFVzSGE8FYhtJpEs2uXyqBYjqSf+iB9kGG9Pd8ne2fL+G2jNKoXgmj2hlT7qC
         oX/XknhaZPg1deg0JMqUOP31MlCfKFZN7ssaE1q/etvBtjVrj+R/U5x9LULG0p7mx2Ru
         ojbA==
X-Forwarded-Encrypted: i=1; AJvYcCVLLEfFWFmjPjDWTpe6z0uD85kgLkRQKUBpHxErH6MxVE5QQVUOVHeqYJZLrWpLsO9rIaZ/Bm0EtTJbgGqhHE8htM3585NB
X-Gm-Message-State: AOJu0YxUMgJW1PDMYsKPgUtXRt5/IfTHpOTBdCQ8/SPrEcLP4WRHrlmm
	2g5yC/CPqB1CfUcEzHI/40tVfzAkjwpiLeKTGP22EhhKium0YGsPOs54NAgZimgQMkhZhNSFFtq
	q8KRVHEOGK5b7CJOKp/OhhEyYgzEhrKX0iDZa2LfiGUEggp9uOkr3z1A=
X-Google-Smtp-Source: AGHT+IGf+1HCcLGFBTjKehh1H4T8kt4HVAo8Zc5w6ywbaml/rk3AHPWNa1CIGOXyFav/zdeME3dCRaZTyXSttRyTgaNbk7NjStYF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:e82a:7cec with SMTP id
 m35-20020a05663840a300b00474e82a7cecmr442251jam.1.1709718797575; Wed, 06 Mar
 2024 01:53:17 -0800 (PST)
Date: Wed, 06 Mar 2024 01:53:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009870f70612faed33@google.com>
Subject: [syzbot] Monthly dccp report (Mar 2024)
From: syzbot <syzbot+list41dc79b1e0e10a83fb37@syzkaller.appspotmail.com>
To: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dccp maintainers/developers,

This is a 31-day syzbot report for the dccp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dccp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 102     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 51      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
                  https://syzkaller.appspot.com/bug?extid=94641ba6c1d768b1e35e
<3> 17      Yes   BUG: stored value of X_recv is zero at net/dccp/ccids/ccid3.c:LINE/ccid3_first_li() (3)
                  https://syzkaller.appspot.com/bug?extid=2ad8ef335371014d4dc7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

