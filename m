Return-Path: <netdev+bounces-241104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D63C7F3DB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC842346444
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4587254864;
	Mon, 24 Nov 2025 07:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9411EB5FD
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970387; cv=none; b=ii0cPnpEMqnCJTbMOwZOOd8z27PKQ3oz9yeebAmw1AV7C6HrHyX6duRWkgL8d2nBpsRyPbF7Qem6uSFRZLfooL5M7Aa/5XwEkS0sx6oS56zGUvQcz4W6FQnFnwKWTHWEj1bFNyDB9Psgrkaem9By28CGffcWEJZrE+JaG4eNATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970387; c=relaxed/simple;
	bh=P1Qnt7dE/JNs8Xq8k8Ilp+gjpzoNArTSyZC0RoLgO8U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cPBQvj0K+D5M0eyOjQcMpbKFFgFrmE0jwB9HFrJ9cdEerkg/9UbtZebaGaRo14AtZz2bzIreWir5a/QVzhEMR9c3F9Z/y66gYUWmPMGuUmJmoQUjg28BAsGH8jVaeTNSSEsKopXT9cziIgJiWQgX4aq+IO1xmZ/F3GpmIux0Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948ffd40eefso276722039f.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970385; x=1764575185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Em/20aVI2j5vJXiyoo0oMdRjjZFMPYlo6bZRrdj/+vY=;
        b=QLd+LuJK2FjSUl9TZJ36ggkq8gxy5Ml4l6xLnH4JU0HGJ5mQZy2f4TNv8kmiZYirDm
         XUH6UBofo/knsB2cl9r0Aocxk1P8AkJbOLYIzLic61xYKPqUcBs7cqCNKX3Y+3Mr3eJA
         SRIozrf/gxo6mQfY6nJfZaj7j0nGvYUz6kYf2+N5me+jbVxVqHuB396HXFjfl+q4iwpX
         2BqTIjN+kU80yd8RaM7fg/cFlEoPzq5IqYRuar+E8+LcF2cKcIJo/WkhlkRfNJoSktrF
         OR2tEetaJKi+D4B51dl5ulBumaHHCkDstSMO7ZSZLI9slnmZ18nh+j/Xu9dukPMBZcBI
         +ETA==
X-Forwarded-Encrypted: i=1; AJvYcCUqac9SWPLJDLmZx7RM/tr6XWxACDpJzfK/886kN198EjCY5Fiq1J929pJaVq1serUmBVEnotc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hz2HJfFL+Ra8zehpe+KNlugoEhqoPd8BIKoGu8JPu3Cff71M
	gI6UqpVcTqIpB6NVqsqcBwz1aDMoCOtGQLDQ1u1zUfu3Z7SWwHoL+gstyVRP/Dzlx7C4H0lPPBM
	2jtO30QVnwZbfVzAJUGm/DVQIcwiV2MlMzinoWfGrJEaUp+vONojj9oYxppM=
X-Google-Smtp-Source: AGHT+IGrX0xdmXVKtphDI18dGVhIgTFkImohtzxBkwFVEo3zJxc7BfZWaWPsukHllCA6q8TpIHKU2JHC4JQ9jiNZmxelNsejQhmA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-435b986a6a0mr59376545ab.13.1763970385329; Sun, 23 Nov 2025
 23:46:25 -0800 (PST)
Date: Sun, 23 Nov 2025 23:46:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69240d51.a70a0220.d98e3.007f.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Nov 2025)
From: syzbot <syzbot+listc1352ec1fd6125277eba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 1 new issues were detected and 2 were fixed.
In total, 6 issues are still open and 77 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 115     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<2> 36      Yes   INFO: rcu detected stall in sock_close (5)
                  https://syzkaller.appspot.com/bug?extid=9a29e1dba699b6f46a03
<3> 1       No    WARNING: refcount bug in sctp_transport_put (5)
                  https://syzkaller.appspot.com/bug?extid=e94b93511bda261f4c43

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

