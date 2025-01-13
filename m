Return-Path: <netdev+bounces-157737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4FA0B71B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A575167B91
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683D22F146;
	Mon, 13 Jan 2025 12:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781822A4D1
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772026; cv=none; b=Sx3oH4d+glzd1P6R5DRA7wNxp9jy3AJuZ9GQHMVUwCGGwqaJPonM2mIUYbFmV/5PNc2OUvC+OND4+nqURr4lXkqYsUOkMFM7EePEzB8xmsrdKmARdE2zyPvxDSYnZ8XXpW755KJ1V3mhIFiiN/0xq3TqbDJzD7rZSIJ5s5BACxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772026; c=relaxed/simple;
	bh=RMqixLrCBaOy/9vqj1YnU7ZZVjBPI3eSLuMjbEWPEEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nm5JcR94Lvw+qfKTUa3d3TDcOFee/FICuH6LDw3f4Bufj5A30X2B5whAQlluwgqET+nNLJSfHa15WWieb71Rgal/BawdIrm6eSCw9Lj75QRqlxKAdh8dq7+Cjqo8VuCTWTnPk03MCvMk6Ja3mIePQVDg2KJyXpjTK1A1+mvZYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a81684bac0so74549295ab.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 04:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736772023; x=1737376823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iScbg1d6pXUeHMhBZVlt8cevHYDSrCOtEczzf2kPWK4=;
        b=U9k6fkSBJsdOb49d8DrsCAF1ydMGfrii6rJBy6y4Zi7NFzQhLWEkgVq6r5pG99nFGk
         5dnaIsF43MvfLjG/H/PwAGZArEU0s/JWGyOD6m+qt8PV31UixmTq1Py3wM2D0kqeeQnO
         xmu8jel11IDNjPVIfPJL7VEZswE/aW8J+CrkQ+ohR45hLWhGLfExsx/lCaYOgVfnHPEi
         UB4q/muC0l/hhe1TvqXZBz97oYz49Z2vs/6TZLH+nQwf9RLKJSvcrjtvekU9SEYn3YbB
         sVnmv8Td0smQ+FRsPnTYZ6NUaHh1p8kXBaY3fjual2ZCIFskgghDnqO+iO8EnaRoFsuF
         Y7qw==
X-Forwarded-Encrypted: i=1; AJvYcCUDnj35PYWi7yhqBsdYt+eFxZu/NfiJNqBilNARbHzrT0cOb3PzgdO+07LDlzRI9luFSkyUmZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxU0IxRKMxFa/QA7qOQu/UDOjNkjGUsFqFdailVVp9a1z07z0
	j1ZDlhiZMsY4dhMn3Wvsp/eHrQFBccKCw1Awq2N4af4IU70sl/h/KtiTf65HUhUZ2Yrdx9aB/GW
	fZpjzIyi7a6dsmAaOm+/SENJzrxAMePFAT4louipLRGUGe1HS/4s82vQ=
X-Google-Smtp-Source: AGHT+IHPJP4MRDcsQbEE3EnRShsFiA6mrVr2Zhx2OlcBtRIU+7eqAmeDVqsL/q0YoyO1L/SGS4vlaU1saEZeTemcUOST4/oNzdnY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3a7:96f3:bb3c with SMTP id
 e9e14a558f8ab-3ce3a86b0dbmr145793965ab.2.1736772023539; Mon, 13 Jan 2025
 04:40:23 -0800 (PST)
Date: Mon, 13 Jan 2025 04:40:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678509b7.050a0220.216c54.0053.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Jan 2025)
From: syzbot <syzbot+listb2b30dffd05d7f628801@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 181 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 395     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 348     No    KMSAN: uninit-value in __schedule (5)
                  https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
<3> 120     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<4> 62      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<5> 46      Yes   BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
                  https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

