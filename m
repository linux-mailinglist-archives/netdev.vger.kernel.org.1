Return-Path: <netdev+bounces-115759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2F947B63
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5E51F233AF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0415ADB4;
	Mon,  5 Aug 2024 12:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847615AD95
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862464; cv=none; b=ozFcOCsjGYZlikMNY1cCDXJjAI3WZqCedpuXRcqy2jn+hzkmmO42crLHUSrflPdsGvS3Q3JgZSKJLKh9WFDrcA7trvzngBlvmJVWs400VwunI/kZ/C7Ek/Lbs6y4usXriUwvCwuElHdYdCovL4IB6vSbBMzTe9p5ovcTWyEhYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862464; c=relaxed/simple;
	bh=yuJZEcBEMqvyrqge5m0+PRMHE8hGMmvMYa57tBPGSc4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qeHGQ3y4XFEtjUzSTEnYX17Sd9/DHoNW3GPXWfIiwfakJS/DTiCeR7DYU2k+Sq60sM6QoaPnsWoF9NHYpkGvGRP2AGZDLl1pV0F1x2NyHHq516FavV4jCECec/NbYcjmy3khtBML23HF1eojcbAgFNaem5ZwXV9Fb6xZMWQvPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f99189f5fso1353189039f.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 05:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862462; x=1723467262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vedShJ3qHOydwe0PS7IY31SetgcMJJeyAmG2uC/Jjw=;
        b=D3OMHdKxyMlS7lKtasOnO+Dgpiy0nG5FfPDd3VCHgUNGO2Tf+57JJIEYJ4CwTSnrUQ
         hp5XnUjopZEfyp4bbQ0BnesrzOy8v+PK7sjMMovI7Qwx7VhgOL5W6K+RO4zCGSzIHFtY
         hqZzNQcpm2bnRz/bObbuTS2NKfY0G08dqsxUfOUeuj4o7zhVYoKqZ5Ngb9OkeL/gDJJi
         2aDPT5/3DZI12GUj2pNEEQ9ZVi8lCkpWnra+7N7HKDWy3LGvzlRHSK+JnWX1rmpK5Bpw
         yFUbEpiM6CW9crmri9Fs/qezLeLHwhAek+W0aCbud9cPBtHMEpnFjYONUVx5ZzPC2ja8
         yquQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWZF+jEzntLrUVTWsLJozZCqqOCHE+6PvUP6bUJ3HGmPrC2o4wI2BlsdP3msv6H862BOq/lAVcDiTf4vO7IYM4BHTuTLp2
X-Gm-Message-State: AOJu0Yyf1sb8KA057rnJpFNyUiI/bXFMcl0fQcI2DW9KMVoanCVnI0TH
	EyXnTx31kC/GVosEYHfeEe1O2I+/FGV4GvHavSWe25Xbs4X2o7S1Q70FxjrQicHEMm2b18cn/x0
	FkVeNq5DLKtASEszkyNTv4R6YVET1nEoTAYtq74iUVqZ0dosO6AnhT50=
X-Google-Smtp-Source: AGHT+IETjZpuDvXqM09m5u6UCBoa1KtfdON7AIQfd4X1CCN2+VvqXFoN18lWWJrPUWD4HAf+dlmO4X127iHs47vlS3k8ZBvFEN8w
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-39b1fc4a7c3mr8788585ab.4.1722862462515; Mon, 05 Aug 2024
 05:54:22 -0700 (PDT)
Date: Mon, 05 Aug 2024 05:54:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000134fbb061eef2d35@google.com>
Subject: [syzbot] Monthly netfilter report (Aug 2024)
From: syzbot <syzbot+listca8d1ea06b0f6972495e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 171 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 352     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 97      Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 65      No    WARNING: locking bug in __schedule
                  https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef
<4> 29      Yes   INFO: rcu detected stall in ip_list_rcv (6)
                  https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

