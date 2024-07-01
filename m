Return-Path: <netdev+bounces-108075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01791DCC5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F01C20D1C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3413F13D53A;
	Mon,  1 Jul 2024 10:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C512C52E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829703; cv=none; b=eE+b5y/ehG2Y4rDELdtUyjBVwbVUnqocfNN2cMzTGKOQuH+4bxDyB+VPcgaWam5nLMReqxdaVcRG5pVL5mNhwML89l5xxl0SPhmebXT6LdG8o7JqcnpH4Y3Ov0/sDl0q4SoGKq7vzCp+eBJZEXuwAfrIycoeafTpltMJFE0vCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829703; c=relaxed/simple;
	bh=VHq9lv8P6o5v2IRpcFlshpMbyz0aAjxgyz1N0pgMiw4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ov4XS7fBZ5xdplYj9QJp/1skK9YstaDxA0IBoCYu51pUUrUTqx2qIMBAVX0SZKzQvH4iXxXVvY2uZQCIXwFgFAHFYXW7iGn2Y3+etFg8LEVCbONPhdB1LeFFF3/iH7E/rB5Wk0HTAwDUaKbZOkO3CX1XmlSI5imPa5/E/DdxpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f4cff1d3d5so271926339f.2
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 03:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829701; x=1720434501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cb4kimtksUVNOGi6GY1upSaZRlO3u1Pe+pWruvEzsnc=;
        b=VgKTDwCNa6E97NjEgTT4/eAyZlMh2LYF6sAY8lsZiJfprHKL0Xu/Unj1LFXCji4ht4
         2uCfAD/9WT4/UPBCzyMbRVG7fHOZ02t5YM+1aIgCVXdHyrBblkVDPt7GlxvSOQ/s3pWR
         pb1BL/tnlPt/zvWWfDhUx6HBpokw6/4WJ+MZPRHQ7w7kmofH5KDstyLszuGufXOu2qTR
         u+NFknks5q5UBsrLKtc5Ldn97ac93Ypb3oZYNfMWcW7F1yBmw8La6G+2zRsz93038ePC
         sW0g+0TBMwhcWvT4qQdesZewyL8i1HFL3NteULZGMyF0i/Zr5VSmB0CT0vAyoHfSZrSm
         h59A==
X-Forwarded-Encrypted: i=1; AJvYcCUKToubpvhW9H9EZttc11RNBDCfoHFWJwvGw7XtW7kCKhQbICdeGLxW+9YisGvYOnrh20guCvXwQwm7y5hsI6RRxGaeKoDx
X-Gm-Message-State: AOJu0Yx2/8hkI0HvE0DddxT0icJlVhaDuZq4ulvsjQQEGpyLo09qLS9X
	DXg1ta709O2JKvEQuAavWlFoonO9DbwtibNPi30aIGDFl0K9bspNSiW0uLX5FbbJqokFs9Pu3N8
	QHwK76mrUALV8/l50HZERFkidwOcTnnYBI/kfbfhtcDtPhtbGTMqhU54=
X-Google-Smtp-Source: AGHT+IHQBpTKTwhTbtvEMrj8UPMGCIPHavhSSaAzOjTX07vbEeG6atsTrtiT2tVqO5Y00eYmQ+uWxpYqKMxTq3A+Bu2tpafSpa9M
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16cf:b0:4b9:645c:8d7 with SMTP id
 8926c6da1cb9f-4bbb6eb8eb1mr330728173.2.1719829700825; Mon, 01 Jul 2024
 03:28:20 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:28:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064614b061c2d0e69@google.com>
Subject: [syzbot] Monthly net report (Jul 2024)
From: syzbot <syzbot+list05e1a6cdae342a145179@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 15 new issues were detected and 17 were fixed.
In total, 99 issues are still open and 1471 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  61814   Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  6379    Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  999     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<4>  927     Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<5>  911     Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<6>  670     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<7>  523     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<8>  479     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
<9>  432     Yes   memory leak in corrupted (2)
                   https://syzkaller.appspot.com/bug?extid=e1c69cadec0f1a078e3d
<10> 347     Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

