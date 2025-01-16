Return-Path: <netdev+bounces-158842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF6A13785
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF49D1883162
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731A1DDC15;
	Thu, 16 Jan 2025 10:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C501990B7
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022345; cv=none; b=b7q9iZiYwLiJmW3MQlT97YaHBWIBcsX4P3K2N5ga7GgjJKjqdWOjWC/aaWCK8o8ONHeYgRL3TBfJwsBcWem7K0KgHU5khy0ApYZ+45SBACEPlyVRuU6wQZy0rG8pn3DZLYcxJ1fKYw3/6ON8iD+MkzT7toLsBvaSVwIBkVzEsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022345; c=relaxed/simple;
	bh=9STRm1svxW5QUhegM8koQv5W+OAbJCN8Cvt/8n16Nfw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nx9Q1sehwo43QlOOO3t1i1o5NPcl2hLGwVBbV0lserOAzInvscYNmVjXH7eyCXCnbU7PLMQXI6Nv/MxNHvRatqTenKRjCkJmZ5AySegOCCjW8cbwe6Fmdnf24Wx2ZiQOmrImQhaO77AOL0PDmoRawyMv6zNYfOBX2XwXNr9i7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so13993715ab.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 02:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737022343; x=1737627143;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vi6bWHZ2WD4rDr2R+lz5qyb7iiwfSNFaHhCWQen1qOk=;
        b=u0PROxjx8QtONz85+cUCPMhIzqTsTS9lQhLGrzrsfT3VghzHlFMy5mMuJ0zpj1qUi3
         whAbG4pLUCTVxW5K3BWbAWe8gMJVblcibDxzd0mT+vxwsYglawolxWbGIJRyIX9LC3SF
         VrhHSRvxkfBB8/KvfcNsZOzdumUEjx9CI1NwtTCRUNeHu+kbQNwPYC6cWOrS/Uz8KEEp
         aInNQ7uyloh6nci3Pw75zdN5Jxa7N/6Ng8Jqolad4kr6dU+ileBjOo8HASveGFcJHATD
         Bx7/un8kR5mQQJiI/MflAq/PShT9nCSvLymyhhNjukaS+7xPk9C93omx15MprNOsumER
         4x3A==
X-Forwarded-Encrypted: i=1; AJvYcCVrf187DCnYbaKo95nzPzXDLiiLJeEnzT/Qh3UXzAyBHE8/Ke+2CmkRml4WG6Dm5CYsgaX5Png=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVtdO7p+ve/RXUbqgLOYOrCnY7NB9NqiJJgM+how/jynAYsWr
	iFJOyfQ6T4tuiwBOysUYZ8pABuluBWFkqku/E7SgN7RVdMjBEFnkWbKutgI3CtnYDpgutWBF0ZS
	QDU/AG7y7vUimwONoqTAvrnqdGB8x/BnP0BaarVq+JQiXdttTj/b/B64=
X-Google-Smtp-Source: AGHT+IEJxyjEqqj2BwsGzMBkjUF56+DFQz5Yavt3OdoaeYdBEfmkRGucBILJZutlcnBX+DPYbTzrtN32tw2zfYkCCfXJdTWr3pLS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:3ce:7d23:34f with SMTP id
 e9e14a558f8ab-3ce7d23048cmr99905335ab.15.1737022342858; Thu, 16 Jan 2025
 02:12:22 -0800 (PST)
Date: Thu, 16 Jan 2025 02:12:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6788db86.050a0220.20d369.002c.GAE@google.com>
Subject: [syzbot] Monthly hams report (Jan 2025)
From: syzbot <syzbot+list6e764589c9e10496560e@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3145    Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 517     Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<3> 505     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<4> 63      No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<5> 50      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302
<6> 27      No    possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<7> 7       No    KASAN: slab-use-after-free Read in ax25_release
                  https://syzkaller.appspot.com/bug?extid=a5716c7fb89dcd7205d8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

