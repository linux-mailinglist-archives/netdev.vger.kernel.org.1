Return-Path: <netdev+bounces-245720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBBDCD61A9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748DB30ACE67
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170A72DC787;
	Mon, 22 Dec 2025 13:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77F2DA763
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408863; cv=none; b=SK41rsFKg8axh94CctE67xNbqANqAAv/BL4YLFLzPDwOgNixJk3kONSus/Y9iRq7y2NTgo4KvtxS2pn7pZ/ATIR1NhEr2gekih7sS9piZr3e8XtTJARyxXAbfSs9BLKJfpDcB+Oieia4XUe0BvqAu5ynbtq0HC2kxwP2ui6VkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408863; c=relaxed/simple;
	bh=kCEImWU5BAfsTyn7yU3XrUEAqKLFvTH/+5XKT/MyXZA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lc+606XSd8zmyIAaqp1SGUSzqvK0cCtyW0GH8OtvZnvcyqBkMEDHWEY5D259PGlcoFMrNYluNaCCFL+ZNZ3HE6a/02Fm9bXr1Ee3UyweJIHXQq+c9zdvQeAy9U8h+STfVAuYN4nLYSDSSFh5cuRWnqRmZDDDPDiP0izB7rB6UVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c765a491bdso3744598a34.2
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 05:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408860; x=1767013660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNIiAjMZYFs+VOx0YLE0UBArZWoEny7hkKH1tDnXLfk=;
        b=VcLlBAmaRxqdiRb62gFi/TzHDg2cSgQGRV01iwNs2Xe7Fci8WIsezb44YPDdm4k40X
         4txbmWP5HD3KkVNGOHuZAgu2NXiQnCbX9d1Fd3OZbC4u0PKaYUHTquUDV6FKCUwsSeMK
         hxAdAGclFmAS2xrhWSlbMQXdLJeyCZbOF2EEoMBuoh35Bx2mEYeMTbMqWAK+lWpDOEHY
         go2QVuwYJYnX/jUiyby2LhgJBdyZ5YOX8NnYihfFE9n7zZzLJqc7glEvUyAqhKWo8Jwe
         bzs0U1rw1420NYeMLeT7HvDW1mps8TPzkJ2Le/uQMtd9kXGWcCs3VJh/REOaQB7u3O6Q
         624A==
X-Forwarded-Encrypted: i=1; AJvYcCUtBjd2b0aimvC1r2aQibmTpKholTiT/0Ddi+4iEnnWZ2UZFCu2oNArAItS52YZbS66NgSe5CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGcsIY669xaMOPo9zCHMDcz9VlYRhOEMdricd6+CH3doq98Hq
	uOE5uHXy3RaxUdU16auiQCZhBnBAdm2nawxgQXRzZl5gItGUcOXx0+qt4YB4J1/wyc5tQIByKZ/
	vG/JBQqSJpXY/1LUNDQZDsWS8ewFdPeGr8PRG7itQS9EOzO9VYYLvL06tYpw=
X-Google-Smtp-Source: AGHT+IHHQPDlWnqdFPXmsDDu2QANjD10YfdwStLWCvV9Eciu/0tI3wH+FaoIQR/pfKZ1LSJTXcxU+WRap3iyU4Oasa8ZuI0nkyQa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ef89:0:b0:65b:32b4:8403 with SMTP id
 006d021491bc7-65d0eb1f81emr3089764eaf.48.1766408860416; Mon, 22 Dec 2025
 05:07:40 -0800 (PST)
Date: Mon, 22 Dec 2025 05:07:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6949429c.a70a0220.25eec0.008a.GAE@google.com>
Subject: [syzbot] Monthly batman report (Dec 2025)
From: syzbot <syzbot+list471f2d695c5f42c85635@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 30      Yes   INFO: rcu detected stall in batadv_iv_send_outstanding_bat_ogm_packet (6)
                  https://syzkaller.appspot.com/bug?extid=62348313fb96b25955aa
<2> 6       No    KMSAN: uninit-value in __run_timer_base (2)
                  https://syzkaller.appspot.com/bug?extid=7d660d9b8bd5efc7ee6e
<3> 3       Yes   INFO: rcu detected stall in batadv_mcast_mla_update (2)
                  https://syzkaller.appspot.com/bug?extid=0a80c6499b110dbf88b7
<4> 2       Yes   INFO: rcu detected stall in batadv_bla_periodic_work (2)
                  https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

