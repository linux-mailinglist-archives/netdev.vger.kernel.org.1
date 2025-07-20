Return-Path: <netdev+bounces-208392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64057B0B474
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38503BA147
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703671E3772;
	Sun, 20 Jul 2025 09:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5D17741
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002272; cv=none; b=uITRCyZ7HmkpoY4MYb46m6pOANswODlqFJiKPioPL+KGOoV7gcqmwfLgCPIxRW8wLwvhENdwhEHfQZkJkdgeoNWe2Rt8keLv+Ddm0JQ8R/y/fy/6jkVujescs4vY150cL6Xw9WfJlhVv2r8S5ffUaNYiF6SlgxJO354Ubm2ACts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002272; c=relaxed/simple;
	bh=oSQNqavC00MRshvUBI+GKy0AQT9Ig5DxZU/9NteZ0TA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nv7QoZAMkmZNgBw+hlpAO/087lTa8FYaaYxoxBNgsB/X3YzzUw9hIIXU8Zi8GNwFXlgM8CSu2/VhWflxrjQyk67eXEUTga9eclV1fZlnZT5affPs4DAl8Ojstwv4zino1o9Dn8ZerHNed75H4tP8DxkO7Wd2K7ybyvsFb67qSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e29c2eba6fso21169255ab.0
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 02:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002270; x=1753607070;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCYVbM74Z35SaOYrZa8wTkxPos+S0J6bbFwSjep4ia8=;
        b=tKEnOWc8cp2y5bcRwKqhvPT7BHFTIsdcrVTduCy5YzECUp6qVjK9J3MLYUZ54FvViI
         AUTknvDXeMhlqLE00d4b1BXN+9rAJ5PMa8+xI+Ma/+wD+4u8TFWsZ8xYfyvh0sXbtjWu
         z2n5+1vKeEWtOC4JPLz5mEgfzC+vc9QIHN8g0TD9+97KY9muNtu/HOoQRyAkRISpXK0q
         rEydmv3dVsjH89+kdftB607VoazP1ZaM52ZowX8F4K+RRIXwRuC9thimmv8UAbVLbJ8S
         WJ4d7yAOsO/CPG/f0D511u22OZon/Fl5/h1OPWyUqRWQMRrWCrNV2ZeT2zuVI4ei5D5C
         QuOg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5EDvPe/0B5vjjDA6D9yfKSGcx5t592sG90IWxu0HToUTQ/V/68IglNvlKJVsUzjFxAv0eOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2NwTbADdkaagUtXQjq1hZCaJxs3whdXzgoeh34iezFB3w0f+
	g7rM4nS3ZvNwWw9RKhBYe3Kk4rPDAroohH245vikrUsDrhZTlVcNht63ec9ANeMObfZQHOebUwF
	IcujSk+r0hu+OuSrmTyEt6Uij/3Y8JWyqRG6zrh1z+tZ5zP097XTghVHSMwQ=
X-Google-Smtp-Source: AGHT+IHeCaV+O9MUs6hHmTbSG11DDfmrBFqvwQ1fWkTRjVJE36pej0SyGDBncV8Gb4kGukriCBJBaUkSwFb+PADLILruSjMPmfQX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaf:0:b0:3e2:956a:3a64 with SMTP id
 e9e14a558f8ab-3e2956a3c83mr105114065ab.18.1753002270059; Sun, 20 Jul 2025
 02:04:30 -0700 (PDT)
Date: Sun, 20 Jul 2025 02:04:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687cb11e.a70a0220.693ce.00b7.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Jul 2025)
From: syzbot <syzbot+lista2316b751ebb20114d19@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 12 issues are still open and 186 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 540     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 184     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 100     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 11      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

