Return-Path: <netdev+bounces-199376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A30ADFFA3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4D7A9724
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052D263F54;
	Thu, 19 Jun 2025 08:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82221A94F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321232; cv=none; b=M4xjnxC3369NLN5B+L3tBHmOqRXHyeaRdUnp0tTtLk00c3Fl5KDPRVYyBXJdqTBWrmYLNN1BzS/MZ8g4CYydZhXkyiut3b49CmZzp72yRO6QhMZKA91NzK1y9DDbZi/Q//Udy/MvUkrpFFuzIxdDhB374GUYjYk9ecztggoA3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321232; c=relaxed/simple;
	bh=cWBHqkKiS7RP9IZhf0JnGzgpy8YIgcFAm3ITjn3BpzE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pPLUfIYH9rRCbLoRXvylKbBHH2t/7CZHVUa4EwM14TH0Ie37a7vVSGEQ2AHocZbPaGlvcmqVNA6dQwi2Hp+D8ek39jxx3HxSZ/FEkmeI8eMaTtEu0z9usueDu3ATjeQBD9LPK/eYaV4pTdeT7xNGBaEElDPvOsjRETeZqkrgrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc0a6d4bdso6009115ab.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 01:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321230; x=1750926030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kj47JIn7RotE7ZzkA/g+sSblwgqxbu68sprIKcbjRbo=;
        b=v1vZvT6L8erDtbt6FKtAWsHQwpLencq9YW6OVzJiFwCT2Ig5CCDWLDh8giInDbfZ/J
         ArlPQDc9FdTDLFilBo5wOW0hVsmIWO8Pc3ACQr+HSO8xsbVzf7kDrLqdp9zo554699Hr
         yulB1wYJguzjoz+TErYJaooSskTWsjh7EYE2nepUgzZDq6LRZO/0dDZhXGsiWPMoPfP9
         aXKNBYFhjKnhS+6iaKc2EuaiRf400pih0VUlEmOSKBzLPVl20QcWLAPjE6t4+Q7o7bgd
         jGSM1jx+VznZRuH3GdEb+XY3rZgiTMgK+O7iSVU3D9oDgCj+vyTqlv2MTQ+SvFje8UjG
         ly+w==
X-Forwarded-Encrypted: i=1; AJvYcCVUdbKulxM4JxxCCXJe8NbnL2raBs69SasvyLWUwuMnztoDQU0yka7suJobcv+sWIUTWWgLadw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/Q1Oux8pHkeqbH1N+GGUqtQ6VaG9RhLGDe8bPEt9O562Fj2B
	Pm+dHCVn7kmNkgT4DGXI8PwhBab9krOnqaEwAFYjxEXHHGO/LZ37OVoHpj49/swubWZnFxHl14D
	gp3hyN+k9gjeFagbA66FSxHtI37sKZQVGCxFnO3d47XhctI02u89s/i2cfAQ=
X-Google-Smtp-Source: AGHT+IHekSLhE6eISN7XxCtRns/xqlyr1Tj56eRlcX7tBt2H9/1SWPRiHsc2bTLYO5oi+XCIY9MsM/AbXn4X37PJlgKrThzFHql6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:3dc:8b29:30b1 with SMTP id
 e9e14a558f8ab-3de07d50d7amr207885085ab.14.1750321230259; Thu, 19 Jun 2025
 01:20:30 -0700 (PDT)
Date: Thu, 19 Jun 2025 01:20:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6853c84e.050a0220.216029.01cb.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Jun 2025)
From: syzbot <syzbot+listd62d23e3f9e32ca7ceb0@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 185 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 512     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 173     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 93      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 2       No    WARNING: refcount bug in nf_nat_masq_schedule
                  https://syzkaller.appspot.com/bug?extid=e178f373ec62758ea18b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

