Return-Path: <netdev+bounces-241450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B32C840B0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F13934D853
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F372FE05F;
	Tue, 25 Nov 2025 08:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED612D9492
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060390; cv=none; b=S4mxeA/lA38eYZZ5q/n6Qo0Gsbkg7TGNvEkXazyDQ+iVb8vnPVxR8XpvEWfLoT7T6tmQgM6a5+ArKbO1dcRRlcwJ6vkteEdIY9mYuxw13JILXancW+8P91FgAEJYWRnAHPvsXCxzEEjzcVLz/s7Kt5ysHQTaLiBnd0az/nHHLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060390; c=relaxed/simple;
	bh=mUazT4CGhnuwAIL5Tegt1rikYOeHcjVEU08X4C323s4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LgWXrdTmS+fS3QGXBrUSK5aobsMTiv9oqd47WjbkOAgPEqypEDZKKutc3JlN/TKs6rjXyDjdbxv4EWx6cyV27GJTHo2P6hEHHHDyzEYqxFK/wqqAySsmI338hT+c0YqLwmUVs3VN2dpe6AydDPcODE/mr40wP54dy2QsIaX07gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43323ffc26bso35952905ab.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060387; x=1764665187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1dEBeRnJub0VdFHg6eMlC/lXNTqpgi+LBBoF933KWY=;
        b=KNowoVo6gT45ww5VReassjWdTtqf9Hchc8/FDR3T7uXS4J3HyaUT+8nQAF9HNN0kh1
         EDHZk5+Vdn94ikb8LTtp3LgEM9JXyjgV+tx/m8IWnynv451VulnVNbpv2bK7QA2ouwy6
         NDYs5dNKxUHwjZ6zPaFgAPqYKhuC/9R135jAgrtGeImK+811tJUdI+Bbux7DyPNfv+rr
         KqqXg61nL8rhgUS7K+/zZSQAAxE0LGdteR8qFUnWNFUmF0yCnLuh4dma6xe0Gf/+Xjay
         WKT4ti5iUAttMEoLDYqckFrLmIBb51wU1+gK/jkAvFubH5btQdqMJFgm4AjGjYcRxre8
         SXGg==
X-Forwarded-Encrypted: i=1; AJvYcCVv3+zev2UGWtvPynEOuOln0157l4hYUXeBjRBHMOLiZHYRhNDgosxIYP84SS0wHxWKOeHQ4pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiygrHEJZ403ncKc7gBpUolmuxP7f8vccIY82oog/IPC7dqw4
	79omHce3rMnY/NFtY/7mcRfynDT7MizUjOLb92CYyWU191gmzcVPyZ+oDaP1H0HuByNyJU8+lFc
	dQQic6Zq8AT5jO1zixhtJjT91EDnzIy6KD7e8fHZAb28nvVt1STAhx02qfRI=
X-Google-Smtp-Source: AGHT+IGlI0SP+fYg2piPM+tOTAGxNsTjFSc4tHXIHOmEJ5rLmhPAFm0JhWzehDhV4liQjVnyge0vMQjx8uVYYxnLh2IaioxPcYMK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2789:b0:435:a0b9:5589 with SMTP id
 e9e14a558f8ab-435b98edd8amr116749455ab.39.1764060386998; Tue, 25 Nov 2025
 00:46:26 -0800 (PST)
Date: Tue, 25 Nov 2025 00:46:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69256ce2.a70a0220.d98e3.00a0.GAE@google.com>
Subject: [syzbot] Monthly hams report (Nov 2025)
From: syzbot <syzbot+listfdd86da488cce9cff3d4@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9242    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 2816    Yes   possible deadlock in nr_rt_ioctl (2)
                  https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3> 660     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 347     No    WARNING: ODEBUG bug in __run_timers (3)
                  https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<5> 1       No    WARNING: refcount bug in nr_del_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=3f991c449d23d41216a2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

