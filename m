Return-Path: <netdev+bounces-118798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0233952CCF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508C21F21A5B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE3180021;
	Thu, 15 Aug 2024 10:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533F1AC882
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718428; cv=none; b=LpTBPzbt1hyKzNSZCJMqoOIrZVqovfY5/aAzITxiFEV6M5B21Dln0TPCsTK/WmjbOiAU5up2iArMihKyd1YPS0ubXkMybwYdfU3c5FVD9PBXmiLXC2jK0ZnxvSZgYMCp3RazOGMXStAo5L0LdcBqvFEGjdMHPqAgqZJJHVY3t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718428; c=relaxed/simple;
	bh=BCmmieNUI4lmEO0U6tUUzo6gPeh57OR7A4GuRgAbXMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P/2Wd+EX5wV7iHhqzRYXA+kN5t2ujfuROllSIhESBY3aXe0jlfCZJPvlXqu8YwpuVdwwaA3WrWcdTwMo7vUTEz0jbgvcG1OOdWkIAm7nFITJyAlEDxljfgJ/CmZjoX0g5MGIHZNo+WNTp6W5MDUHpGA7DagCJmIY6IDdNxtWdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8489097eso81263439f.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718425; x=1724323225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Yu9jYSVcnvbxIatxBmYFvoSLSb1OU99YNJNpjw3ik4=;
        b=QzuewKtfExz80VKVR9GPERq2LrhxViwEFDQoy4CMHqfr/NwDnudb9hfFHWHrwCwK3D
         pVNevjV/C7tb4LWDijM0ayUuNuncuiQUVn5/4ySk+h1SapWcllOZBiKAFJ+GzEWB4Ysn
         JBc5a8Fo337CZfZ1x/sTjTFBJhTt2GfFHWtkh6DEDlmBxviEWiBpdp4+JTDZh5ypzyLL
         XkgT+86d83B1yvHtozjceNXi2x0Bc5dXvaaPTEGmvStpUm39XXSv38y29Zql390zdpec
         ULrZWpEy+epk1BgmKbHsd/GsifSiiZxG6sV1GfvC04alCN/59uwrkZ3ZXkreYG9TkD51
         dz3w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8I3dXzNHaS/WkCsjSlV2n5v+DumW0hGLZHJUzlfba8vzaTFASTbSAEKcUxdOXujBovgrF6xkonx4wzApuE3/VSsiAzvG
X-Gm-Message-State: AOJu0YxlwJ+JFJLWRGHCOuVLOg0lh699wHRTtihlFLkqBmbEvBOz8ERU
	GDISd89ICX3kDnhDiqbNGOsM/gKYCAs29r5McUgUL0trif7YSHAmseT+xW9GxnR+cefdS6nnZqJ
	2SXpHZ1PFVFq6VHYP8FMmk15Xn96YD8eeNrl4Pm5koRXRk/Pi5PNOo2A=
X-Google-Smtp-Source: AGHT+IH3nDNZkdMLYskbOXMf/HRcQdTHbUXHqKTI0sYkHX84dShX8bUE0h8qfkQlgTbsvnTWT+x/goGGP9OIYUhv2rhQvB5QFE1Y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c3:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4cab0a036efmr244210173.4.1723718425345; Thu, 15 Aug 2024
 03:40:25 -0700 (PDT)
Date: Thu, 15 Aug 2024 03:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f9129061fb67866@google.com>
Subject: [syzbot] Monthly dccp report (Aug 2024)
From: syzbot <syzbot+listd5bb09218cb571c8dc9d@syzkaller.appspotmail.com>
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
<1> 106     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 57      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
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

