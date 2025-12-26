Return-Path: <netdev+bounces-246080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BACDE6FC
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC243007C7D
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CD1DB34C;
	Fri, 26 Dec 2025 07:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC57487BE
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766735245; cv=none; b=dsR6Fw+cILqMT+zX67xmfDAaSvEWexbJha4MdhqKm4i9shopPzjkIjIn9i6bbGshK39ZKb1q7wB9NBZOvaxD1kgdXDiIV61PN+xLvD2cKqmpa4eo2JmCM7YSB0+g4+2qMrOgkzZTyukNq6f3Fdf0xkLL/syvHaKgDHfl41b2xLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766735245; c=relaxed/simple;
	bh=UNsXj3V8BVUoYkRtHWST2T4L2TCT00/fZxiwN8LBSJA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bNrI/5MlpnZYMMSlERrVRCoky/JLqxNLcF4U78h9fIHlzDqgoR7dIHmJEMADA9H8uDaQIwsLD8JbUlKIJZL7btp1r9CfCsZvab1Su/ZcXa6AO4YK3lDjW/pqlyWnpUqvsbHOTwjHP3ucA1tA3FJ5vZ5UQK3irBc3dhzju/WbPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c76977192eso22674705a34.3
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 23:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766735243; x=1767340043;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MP4vBykJbYxGqQ4N+Xjb6R9EF1dhARO71RByzwm+SXs=;
        b=OyPe5EggPlMo8d/xK5R3vINwfS8LzcNKJC7xSP9gVO0accoWwNPMQ+Otiy9fCVqjsJ
         r74WZy/OQ8Ut3EQjN5PhBx/WSJdI9KadruC+q4P0YCp8w85RHIrCNZOm0PUGFdaHQLBg
         tRpaB+8G+2QJLaRGaDrkGSL1sT5gPuWUj7XQEMETr1QykaqeguBPfFgplki1XCKgneTp
         cFVGYEHRnmcyCFAbyyFNZFz4HECMzImzTCjXotX/r+pJqvsARzTmSYeYSaT3UlCq1Fcg
         fUnDIvny7zd8ACl6Ei95afghTgPNzi/eMPDZ8ba4ZXWPFU+lAZ4uBJUW969nb9oQjcJe
         vbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0hfV6NauGmn/KuHgPI+cmbVTFw9jIwtc0WWa2A5a8kAlXXbMVQ5sOhVNbQF0Lug1t+yUx2AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgU8VeUAUIqtdfIcrJ4xYoyu3Z61bBYyI15q5KThNoflGYTN/
	KEA8ejBlpcUmywI+gVxj2fJ7UlLPgsYWFcK/jYiynDF0h/974zHqXsWf6iZfJUDJf0ei7VwYaxG
	TTq0Zf/TiUGacOt7BjDcMZdHX7NOuqWd1ioHAV+9Of9fxQfJIY/8t5PfBfm0=
X-Google-Smtp-Source: AGHT+IE1dFIaxTIcRJlZdE+hZMymfmQx0LkUBrve2JPD6tLnF3dM/icrpoMNgLq9pKcqU6ucC1cyraYD/oCQlOf3+LgjHqAjWA1R
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca1:b0:659:9a49:8f43 with SMTP id
 006d021491bc7-65d0eb56dd7mr8731259eaf.84.1766735243381; Thu, 25 Dec 2025
 23:47:23 -0800 (PST)
Date: Thu, 25 Dec 2025 23:47:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694e3d8b.050a0220.35954c.0065.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Dec 2025)
From: syzbot <syzbot+listde02170f214c3819f6ae@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 191 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 627     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<2> 276     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 119     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 11      Yes   WARNING in __nf_unregister_net_hook (9)
                  https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda
<5> 6       No    possible deadlock in ip_set_nfnl_get_byindex
                  https://syzkaller.appspot.com/bug?extid=aefe8555e94ae62b95c1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

