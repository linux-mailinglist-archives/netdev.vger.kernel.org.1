Return-Path: <netdev+bounces-218633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6134B3DB3D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABD616EB80
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217152701BD;
	Mon,  1 Sep 2025 07:38:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47426F2BF
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712315; cv=none; b=g2HMRdsg8JQWJwVLhZhv6MXTYRdxVsrYLe/PxwuiTuspw4F27PMca5sxGjYwdwfevhEgiMZ4Uzt02Vb5oot9Mc6/2QWpTyVzMGjk7TO9WHmITlPaOYNxE9jqzm/gXAnybhJcHqWoORbppKwCd1lMpWvqeCfdC+jYKUPK1lxosOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712315; c=relaxed/simple;
	bh=H1mxaiAMN3sc2eH/vsvRcfjUz6xIJV97cFrGw0wJMmo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nbxf/4O7XmEnxrH0eyUPPgbehR4DoYJ01WTAMnZ7nu3T2ZeL2Do9RDdck0qsD70/PjAWh4FQ1PMJEbjsjv+G6UD2agDrXQhTIS0ekLQsdlT6zEpA3rAgeBrad/H1jSA9hGcogBrb07z3UxSenuwSMPNu4DoXITzzD6TRTUNipsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88707a84524so873245039f.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 00:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712312; x=1757317112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obHWzG0ygEaObehtACUvL+DH8pKrrwQ0y+2bONAOBfg=;
        b=Uud17L8d6Oic/KxfMyw/RdKQrerJS3em74e0PrfP6tWQHopBj2euLs4Hku79RreKuw
         vtrJUgXk3uYLuvtGlLPOgOSmCHos298R7C1isF9YTTq5dpIs0aKnhkYJJ8cXrWeRvr2t
         IQnNF664aPlJ5c5Bz4m0BIpcqm9HrMgoCga50zgrjIENKUBE+Ht3Y0ESDAFa6AChEtTT
         TcGXF9+MCZZQrB01+jMjsJUW+zP49b+0moSFB+V60QsZMcX+8p5dvFhUOkQfyYFgtNj6
         nwddHjDJM8qflRK3ekljNp89u3OouFroZJZZvnWhgzdNyQcj+4ufsaOrS0sxQeSM5rUz
         sebA==
X-Forwarded-Encrypted: i=1; AJvYcCWrHI+kN+q+KKQiFBTLvbBlnkZnWK/PDPL74C63WZ56bhxKsYWu1wXEfmwh+Q9ZAYsllcb6sqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrMbxNTTeK/wo8qq3wl+wB8WF99YNURct+yV/w0BNxROSHgat
	wqtZy9l4GwEcCCoB456FiyvCwQOpC41MM0HA+ZSUGyt2v0Wio7+Wv3xsY7GVqUlpMg/rNZ65tR5
	tNzwfoD2tp4i7Jv41YirOXlywtuN4IW4HZJ3+kJfiZgj0lohGaNLMl41MOOA=
X-Google-Smtp-Source: AGHT+IHwJr2Tps5ny4OjP2FS9RRvLgmLjK2SqygClVKfYMS5rNpQPeem48MvZ94Qxz8iif+BgcBOiBp9rZELv0Nu9xUxQ36YmO7f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:180a:b0:886:f2c1:8ed3 with SMTP id
 ca18e2360f4ac-8871f51f15emr1016078539f.17.1756712312641; Mon, 01 Sep 2025
 00:38:32 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:38:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b54d78.a70a0220.1c57d1.0543.GAE@google.com>
Subject: [syzbot] Monthly tipc report (Aug 2025)
From: syzbot <syzbot+list7f83bd0f801034393a79@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello tipc maintainers/developers,

This is a 31-day syzbot report for the tipc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/tipc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 85 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 676     Yes   INFO: rcu detected stall in corrupted (4)
                  https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<2> 86      No    INFO: rcu detected stall in sys_sendmmsg (7)
                  https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<3> 26      Yes   KMSAN: uninit-value in tipc_rcv (2)
                  https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
<4> 2       No    KASAN: user-memory-access Write in tipc_crypto_stop
                  https://syzkaller.appspot.com/bug?extid=2434dfff4223d77e8e1d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

