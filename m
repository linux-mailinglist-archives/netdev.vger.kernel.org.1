Return-Path: <netdev+bounces-197479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE3DAD8BFB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360003B752A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F72E2F10;
	Fri, 13 Jun 2025 12:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4D2E1737
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817537; cv=none; b=YkNg4DhcHSqIM5AWchsuEL+D9WGG6DxDxlIR/qDGvdNzS3TIpJ0Zbk9E03u8k8KfIputNWoKBCjT/QdeiIOJaXuJHEKhPLhi+U7G15ojKOqA81tox06h9Vgm4M4J5TalniMCaUPry30LeS9mOme7mKdj5PULzAIu0VBygjWhB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817537; c=relaxed/simple;
	bh=ieuaF/eOzbwThScPtbCckDkqjmzKbcUwG/RlN64T0Kw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TkkM3p68AZHxuvch3daMJkoOVKhJhaUs2cy5UuswtEhvplI825IdM7Q4PrHQ9/hXQqmxG7yCqNCWIJR4Gy3C2Ag/JdMBSiXAkLm6nK8K79gUEyDKj6GiuA8dJ3bpk//jNw0vF/o4LcNHcUnjEvYtqlix4tdfEzLu9LpS2UHhOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddd03db24dso17856965ab.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817535; x=1750422335;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibp4dIIwZgTSSwcsN0VyzRoXN8VD0u0/cjQjv+2VsnY=;
        b=MyazINJ+zeF4ebzdgVHFapDBoRu3ZUEn6eOgD8eF0DrfToUDjFEliYbcnWtWdylIY0
         YViF0lW0c9+Hmum4/bAlkpj+hQBGR1nkH9dg4IetfTNS2/QvWPVOBNKnCban007uiKxM
         q67Lm1cZRXBlTBtG95ZoU2ba6UbO/bUpdUQgoQjt5KW8zR81XzxXbBu8ZRAbVi+WHQWb
         xJb3X/mIIRuTZDgnkF0susZH9K9ginM7f5GBl9MdXuNfe6JrsDK9CopfzswJm5PCjU+2
         0u8bUf5azZxsUf3aslvDiaUlmDXIuDBv8nCVrs2jKasOFPvamifERkxbsVAhXpFbwzwh
         qrxA==
X-Forwarded-Encrypted: i=1; AJvYcCVaegjMKDBA1ujw1PyLn+yEf4zSYmIj8RxQbu5Wuwle6z8HufsS4yAgkQwLA+VHEMWRFRAwqHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3UJk7xDvYWUJNWEdiGMakAifZjzFWxkaB41QQyibAbesoPptP
	IFlK8FjjP9poUT/3TQM/I2viyDPrSOC8b3XrFFDj136yiodfkNb3odriNCu0dAxgLTApZfCxEo9
	NB+IZHQvFAYOtqUEGQMur+pjtgXeqOcu5fgxRS4yjzTxyozCbjivmBn06omI=
X-Google-Smtp-Source: AGHT+IFs4UCj39SqCIZVwD3R2/U3pj9jrQXh0sKHApLOgyKcANkGEogY19O/oHk8O2vb3LHAj5OSQwfz8z8Abqvm9sFPHfs/V1SP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:3d4:3ab3:daf0 with SMTP id
 e9e14a558f8ab-3de00afd8a3mr28580615ab.7.1749817534748; Fri, 13 Jun 2025
 05:25:34 -0700 (PDT)
Date: Fri, 13 Jun 2025 05:25:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684c18be.a00a0220.279073.000f.GAE@google.com>
Subject: [syzbot] Monthly net report (Jun 2025)
From: syzbot <syzbot+listf0228ddbe98f29873fa7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 21 new issues were detected and 9 were fixed.
In total, 145 issues are still open and 1614 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  352391  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  331292  Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  14606   Yes   possible deadlock in team_device_event (3)
                   https://syzkaller.appspot.com/bug?extid=b668da2bc4cb9670bf58
<4>  8218    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<5>  7128    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<6>  6515    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<7>  3361    No    BUG: sleeping function called from invalid context in dev_set_allmulti
                   https://syzkaller.appspot.com/bug?extid=368054937a6a7ead5f35
<8>  3242    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<9>  2581    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<10> 1681    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

