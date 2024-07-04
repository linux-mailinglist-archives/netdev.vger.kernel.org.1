Return-Path: <netdev+bounces-109120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C19270E6
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1CF1F22F04
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05741A38CF;
	Thu,  4 Jul 2024 07:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087FFC02
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079367; cv=none; b=Ohx7DekigbJAunGUZKHVxaL5t62GTd716ow9Rl6xCNcNiDzENKAEGrjByU22tmRQRYmiYACEky3PG5P9G3nIWiJVMvv/nl0ddo86YflqYEnEBCWFia1ynbyeUktVEwAbHBQ4Mx2OFD64fGi51O1uxeu72+27tHriokI+B+7jiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079367; c=relaxed/simple;
	bh=EnNRo7YyZ1xQ+CMWi0DEEDmZzM5z18k1m1vd/CI/CaE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fo7HNTdc3cKW/frvcurifCZAzYMrB47unN8867lhVI996rQuqi4IgfjPWWcHs3vTBfr6nQxwvYl2YMrWrX62IYjWi+4rXRLFGBEHnYMcF1L8NmJzD6OZ41iYUeNE8fgHq3Ctlv4LC7arzZMqEiTH7n4fvzC4ZKbb/hcO9GChcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-381dd2a677bso5066505ab.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 00:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079365; x=1720684165;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CESjReMpw9UUZWiMl1S2EfqE+jINbArnlNEMrzlMIIQ=;
        b=eYq7ccEHSZZDIAvFa2aDFH2gI7cMG6/Bswve99V9IAutZTnKCVKKmYwQDEqEbKygQH
         ZpvjgCpXHdZB5G7LPFO42u+TbL+vXIOxWuOWreCQi1CTZQEjgpok8HvegIqLXSh0zQoS
         1P/D71FtGjb3ru4+3uQ9QYYt2i0IcBMrHGdTl87y6qX/hIrorCXjen87R9dnhLjeII2v
         o94itQrhmHC6b0bRrE90vjykA90ofFl+NfxgkDXoKdmgLx7Ocs6WtzdIRfT9w0OtiMvx
         dfFbyyOda+N7kqESrotxQOdDunXAQugwEZfojce0AOyo+mY0IM1vGQsxO2W8cvPlXW05
         yjkw==
X-Forwarded-Encrypted: i=1; AJvYcCV9KV4Vd1jwmvB1kdvfTYWBjppuX3xlLgGZA1Dx7TsKkXMOD7+pkno1GxXIyIDac2vabg8XhRf2ylpUtnX5BriZ652OJ3NQ
X-Gm-Message-State: AOJu0YxXFa4c/07H0UXcggajytvYKZocSakyNbbOxZ8gmYkEkP29Lk0k
	ga42dsH0fq70MwNPmOkJJj2gpXvd5tT3vSR0pW9dwvPE+HpVKGfyEZFFC9Lzk3uImjUJmtu8F2N
	uavOTxNd9d9GMw72Ry9aO9tMQ8jn7a+6i0KGEqU0p62GdAO08lksWd+M=
X-Google-Smtp-Source: AGHT+IHslujarCjx8vMDA/mHyCkCzDO6dHYu/JDiYkgzwH7xDCwLMC/dgOQOzT7wGhZQf683n8H/R/Xfz7pc5ktVNhBXOJd8vTMX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10c4:b0:376:46d5:6583 with SMTP id
 e9e14a558f8ab-3839b37d8c7mr157225ab.5.1720079365458; Thu, 04 Jul 2024
 00:49:25 -0700 (PDT)
Date: Thu, 04 Jul 2024 00:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009059a6061c672f4d@google.com>
Subject: [syzbot] Monthly wireguard report (Jul 2024)
From: syzbot <syzbot+list3f44d498ace31a0c4fcf@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 0 new issues were detected and 2 were fixed.
In total, 8 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1009    No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 59      No    INFO: task hung in __tun_chr_ioctl (6)
                  https://syzkaller.appspot.com/bug?extid=26c7b4c3afe5450b3e15
<3> 14      No    WARNING in kthread_unpark (2)
                  https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

