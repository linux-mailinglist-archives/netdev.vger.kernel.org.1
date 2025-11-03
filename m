Return-Path: <netdev+bounces-235103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61311C2BFE6
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293C81899D52
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1730E0D0;
	Mon,  3 Nov 2025 13:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EED306488
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175437; cv=none; b=StODYP253YHXHCRCEAgzFgL7YEFGTH31ufszsBe8HJgcy1gttybM+BfCixdrAHbw8M7gacVdVjpKXe8TiOf9NvwYQh1Bwi81mfB8cw+MBwiKS8VGoBopjhGizL7Uqnmv2TwO5aeUv+I9ZhN9GbEwrXFTJ3INtHyNz9vsEpQwlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175437; c=relaxed/simple;
	bh=0kweIpBjLwsaUfCaQ3Lz+4RHhynx7QnaLSBzfQ3AiyY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HCn9EycbOgm+CmoDDoe4xVYPZOjErkdF0scxh3H8OQnppCXYvo/JOR3C+ppZy/szxfVB86ve7Nks6RanIxAkevwdP4DvBxpwh87UjqkyfY2spzJS/ohR3JgbCodquN9Ugf/H7Syi/U9RqTxt+XVznQ/OssNO73Gcp0xQUi6VhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433218d02e4so67296315ab.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 05:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175435; x=1762780235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLJ66hhXNV/HWG4YPamY6JleAjJAHrH8FugRFTyDWnU=;
        b=k7vSX0yirLk0wLTAOHuW8/pZ186B/nk/1C0qDbywcQn1HIxzATpr6+5k6N3lpPa1fp
         4w3b9EL20mLLoMStrIMhaQl2es40Ru4ZgNwICX+mggD2UeYMlQlsjXWrAJ9ciPc9PzoU
         XkeSX4ZnvX0KGTqZSqj8/Llvghm9VuzX82XiKcY6EpanMm9SpIhME+1PcuuTr0x5Tr3S
         s5o/ffPF2a5bZOwlKZBPCwgAmhSSD7nkdf7B2rNz4ryzR+p4AmmyZRE+1sqhLrjH/NW4
         uLB9npjB1eSlf0zH0jLb1Kmr7/f/4uNlXMNS9JsQ0evWw5M7FpcLL/0v4fkBbIuKWBZw
         +2kg==
X-Forwarded-Encrypted: i=1; AJvYcCXSd9V7G+Wi9frOqvtQJMh9Vz84+0v/DZ1pY7++LtTrqG7HsGa5d8K1SXF/Uo7dw853vbNsu+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4R8PITGYa0Inj7EaESVZ8iLjA6UXJx1mZu6/Tf1sHZ8irDJF
	jSoSlHCxPihY3UVzKYxOkdlhI5hLsYFJSZ+OvHpQwgDAsD9M4Uu0FBeH8jSSSO3dNitbDdL/woS
	rWmWlQD7pLIUTyun9Vb78XAXAJG1sztwrRs+a3V/XeQ/nchFSNZ3WsDmc4TY=
X-Google-Smtp-Source: AGHT+IGnJXgJ7H+vLRXpvZRmXLRGl0W558D8Tz1IMtZDd5OAmew3vHktzusxKJXjGf2AlKR+2Ffxyj3Ze76tWWaNL2NhFXcpRuWU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:270a:b0:433:2aad:9873 with SMTP id
 e9e14a558f8ab-4332aad9b89mr55929615ab.29.1762175435219; Mon, 03 Nov 2025
 05:10:35 -0800 (PST)
Date: Mon, 03 Nov 2025 05:10:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908a9cb.050a0220.29fc44.0047.GAE@google.com>
Subject: [syzbot] Monthly smc report (Nov 2025)
From: syzbot <syzbot+list2de134faa4e1daa63f2d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 49 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 573     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 146     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 19      Yes   KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
                  https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

