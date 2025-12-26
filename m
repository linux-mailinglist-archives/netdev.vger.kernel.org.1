Return-Path: <netdev+bounces-246082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D08CDE740
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 08:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1203301FC02
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 07:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F57313E2E;
	Fri, 26 Dec 2025 07:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45F2EA159
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766735306; cv=none; b=orDz/h5TNVevYNEm058JB50EBXjSjR9HtZTcOoboFv2Klf/gUCiV3HYKPUK9EX8C9UTjXZWv+4UxACUSzzx8uCTqpkGVh1fCmbFLoamhygdFoymoqcJ0DXBYZP2FMMfEjMzIbI01jKJFT2wamKWMsgyWP/pl7qQgzy8sHgmjr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766735306; c=relaxed/simple;
	bh=4G3Gk8BSJMdDNtUzvBUVhRxLNT5rZEqpN2SsPHQCXK8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uOJmnEV0tvHlA3FXt3xSGYrCocpARqANuawkBbv7zTrYa9EoX79xiBUIjzKqSIZgJr0yFQ0/2iwkWWDd2Isv6xEwmRCEnBeS76YwZOnVwotxMk5LTf/IUmfZ8EGG6+1fQuZYHNuqYxSuLs1/iOdD2m4q5SLWde78QUliK4oqnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6574a047ec5so7026458eaf.3
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 23:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766735303; x=1767340103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6h858IFkNIDNDucXKHl3NQ/6iIv4DUqYS1WvnPgvU6o=;
        b=Zq6KxxFEH/Dq7je8bybBK8uQXgnaUDfuk0azG9HtHgp454Y/x1AfrV+N3KyNpm2dfn
         uXukjxf4gsOiY8fpVLVzQzVNrpJb21mzs/KAx3zAtOYRG6TwrxD2En5iRUkhBOv70UsC
         Tr0taFEM+ofCP13hHwVbSbxn8payGqCOjQbmKH02hQIlXg0IunQvH45SGwQj3fICwXTd
         meauGPpb/zgS53YFOoMxNSWWhQ63jaY4qyh2eNHNe9eRUOD++tJzc9bcrqQcBSmwlDDw
         VG64GKXq0ZJcq+CTZSZbY4Y+7Pjud6BdLblyoKhqmrGGU2eTpEDqFrZrij4VsFPoj+CI
         Z3wA==
X-Forwarded-Encrypted: i=1; AJvYcCU/kNdkFe4db0nsLTVjiHdgBu6iLZfcPMnATlV5Kl7tkcS1Xv0mi5+Zsca/O7BjUXQdgfbiehs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRZCyIimKCKYx/tWLTh8BGiLlsKpQBZhZFqomBUq1WWjwKonR
	GwKus+fFUy6HFw+9CjT3pOk+PGf4jH3FtHKsLODdtZYln4eg/UviMV9ssLD1pjBIE9gSIAcY2Ui
	hywZo0efsECcItnUv2fXS6OLEvv140Q8ZlxySxVIyiA2gAzS1M8oyvYXE6cE=
X-Google-Smtp-Source: AGHT+IHtxiqDKuziOWwIZ8U3mJEfS4Q8sOehAkPTpKr6dIGsLILiUSt3vQMPqrvPykLl88Ctq8WT09xe2Dg4ke4tEYR/xQ9/tnMZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:cb0f:0:b0:659:9a49:8dcf with SMTP id
 006d021491bc7-65d0e9e7f76mr6472723eaf.17.1766735303469; Thu, 25 Dec 2025
 23:48:23 -0800 (PST)
Date: Thu, 25 Dec 2025 23:48:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694e3dc7.050a0220.35954c.006b.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Dec 2025)
From: syzbot <syzbot+list22154e6adebbf6ad3dbc@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 48      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<2> 39      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
<3> 4       Yes   WARNING in lowpan_xmit (2)
                  https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

