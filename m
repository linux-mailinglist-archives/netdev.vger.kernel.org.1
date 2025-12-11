Return-Path: <netdev+bounces-244322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C1CB4D43
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 06:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AFFC300160F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10023D7CE;
	Thu, 11 Dec 2025 05:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8A1ACEDE
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765432709; cv=none; b=aF3FkaM9p/i4wJxcoL2HPJvXRgl30r9zVcND1MnZq7zOaeo4OBbVmhrfa+3Wdm/bjgn1Wqo3yAVu9Fm6ra/EF4ADGZSqBKnnWsupa8AfsYYI6K9HZr3quH9dASLIDi0D8XmhRM4jK50M+Xifq8Aryct7YXCi9sGYNzSTMRqJyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765432709; c=relaxed/simple;
	bh=gFzdWncsd05JppMuoS3BbcBpgtgIDjYSDmq6PBPfyP8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FWLipYzdrwTh4TJ+6WX8x/jHzPN9FjsfW56LF7ead5NQQcjATyPr4kz9eClngsfzrT6xpXtiCZS+vI0vq7e+qYho7PDqGJespsD81GGf95nTdWI/96zCZKmFgyazJKtJhNZEYGM1sPNm99MhmQZaTyGpcNTyUQc3wIvGWMlgIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-65b2fb9d54bso974902eaf.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 21:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765432706; x=1766037506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSmm2sTWzvRWZH89PpDmyRQg9v0RdfilTJvtmUBWWtA=;
        b=X7pac1f30g3GmZlfVKQprnexwYhWkYuO0y6Ff7OdJDh2nvmM7fvNZb+LLZR6NGFPdB
         SkvOcuokAsPLtyU3Vmi/sog6Rngno4hi9O1PvGt1gVKU75QDmLB9kg1n2JiaQHW6INU5
         pz2UiZiC2xRbHjBESTllf5YjgEBCm3QqZPd0RWocm2fNjXGVcTfIdsTlKtNu7hRR0zW/
         xeNTzojPaNnD1fXy6DXuNKD3oaR3J4rUQypBU54iZSkOi9Xnpl7le7t6NDSS0m3tBZew
         NwF9tdfAZ0IC7OmT1vw3hYhwV/lhh7gXPliJfAhtfYlX7Gophb2yXLywvha6WJ/ON7Dx
         LECw==
X-Forwarded-Encrypted: i=1; AJvYcCWpplMtM+RF9ObRRzkM8qRig8XlhcSGH+ktWLludObTyE9mr3KyRGcaw1/k9FRiI6tOcE7aWUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW48/8YvBQy7Z8BnaToVc/eFiADd48hi/5wNBVS2wZnr/vvoTB
	CfKtXkDonsmuBOKWVS5IPcj0d4eX2tk/dhxg6tpaaOC9SlJ+UQqFobwb0EmvzaUWPeWdhu8/ROF
	027Wxs3+sIBzAFzVQRK9SKz+b7VC7QNq5RqYSQSnQe/7R+ogsHH3i3X1iLRM=
X-Google-Smtp-Source: AGHT+IFZMWDWNZLZHlz+wyde2aicwy+2i5rIPRif8BFm7XEwqhgHBK7hpLUMAXTtcB/8+E9PSY9hKDGu0xLpnIVpGZULqwKOhWAD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e911:0:b0:659:9a49:8eef with SMTP id
 006d021491bc7-65b38259b26mr564591eaf.35.1765432706750; Wed, 10 Dec 2025
 21:58:26 -0800 (PST)
Date: Wed, 10 Dec 2025 21:58:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693a5d82.a70a0220.33cd7b.0025.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Dec 2025)
From: syzbot <syzbot+list982a249b1c9936065e88@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1284    Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 593     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 163     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 105     Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 31      Yes   WARNING in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

