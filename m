Return-Path: <netdev+bounces-158841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBCA1377F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5E3A5523
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA01DDC12;
	Thu, 16 Jan 2025 10:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457E1DD9AC
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022283; cv=none; b=UhpM7RYhxtpHXi1cSwJcqAnHL7K0hioxl2Cu8LD8+g4SA2FeMOPDZ4n6fytU4obirkw41Ia/pr6yWVuFMyH3Zmdk3ReiTtEwsbMYxUU92fXf0VFBR4IlvWlPII5V0On7gPFtBQ8/4cxc3KBKaQ0RRXoq20XBQxjgmJlF078Whr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022283; c=relaxed/simple;
	bh=B5LpU+MA0KRcDg61W9UUbZEPQ4TyFr2ADhgCF1O/EiM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lsdf0kTYYVd5LXTNiStOOojk5fPNYymOTN7detkN//XXJJQpIf9IPm+X3oA6K0pSqWzjdZtZ16yaVFMrz7DvFcf4NcI9IrNp+yUiqw5bCtNx4YBaT1QSaYoaZ0pLKlFgWeKvUCeJhtjuCeMjRirVaLNgGV7Sx+TipX5nfLs/GCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cf6c83567eso2186795ab.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 02:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737022281; x=1737627081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rxoj+qDIbA08kT/EOPOM++NdhdUzVPmu+TNARtJbBko=;
        b=mlfB2IryIgv9PfqmCKCIaW4lEi+Y17dbMruQoiGHo6NUjqL8cz6vdjpVh1QJ5aDN0G
         WNM7Hog1KrumVT8rIZt0aQ6eDUiRlQSEYmA0h1WHlymStibyrTGGGIbR28YbwfyZQltJ
         nt6qkzyyGLA58wvyIE+e3MFLKYLbNBZULALMhJ01ambV24E1h4MG1w1H88mYJdes65IY
         4HrPUM9M43BXvwSvt9LUVxxtMn5CVdAPNdMNNaSB69c+SKSGu5idozAUW4y2gi0BZTfN
         3eABbGJklBLb1vXG99jgxFqdKD+h6PLDNFkU3wFib4qGsAkl1kGD4xPC8Wv/4zCWBYOv
         q1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU1/NnUBz9nRO4Z+bikDgsXT5iXqRi4a/ptESLVSP/dNaPWnwn6ZbaGFvuEIzL2R7wNMME4upo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bOcSm7RvGIsRch77ze6vbyYg19UmPuwYMqbSjuO7fEdMInBP
	/lrCFSx9PTTJXQaW2spZBsufqjEUNDQfNLG0Cer1VusYEIncFVCF4puMwKw0FddPYixI3JmfgJh
	zvxzJnV1edrTGShTqebHqnqsu6Nqvbp0IPviNGJYYsILmqTsAc6WTT6M=
X-Google-Smtp-Source: AGHT+IHo9k/WazPeNk/aXmdagn3znjCbJ0diij9GMQ7EJ/1RrjX1X7a0+OX97hvkZDUr3Mo3yfQ904tyW8PaJLLnnp1/RyrI/SZE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3ce3aa74970mr300338755ab.21.1737022281590; Thu, 16 Jan 2025
 02:11:21 -0800 (PST)
Date: Thu, 16 Jan 2025 02:11:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6788db49.050a0220.20d369.002a.GAE@google.com>
Subject: [syzbot] Monthly dccp report (Jan 2025)
From: syzbot <syzbot+list400d4846735a1e045350@syzkaller.appspotmail.com>
To: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dccp maintainers/developers,

This is a 31-day syzbot report for the dccp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dccp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 108     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 60      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
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

