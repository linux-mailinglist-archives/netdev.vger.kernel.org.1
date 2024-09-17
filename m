Return-Path: <netdev+bounces-128742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5997B558
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E65A1F231C2
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE618CC0A;
	Tue, 17 Sep 2024 21:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720F158522
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609884; cv=none; b=HCMAVqnNP5zKCx8kA+jldMvf6d3ZFBbsEE8iJyX+zpvipZaVrvrOIDI6K01Jxl9jW/UcmEkv0gEOmAA/cw75T71/D+4vwFahO8PgYPiZqb/l3gcfssv0p3CWcgiDFdrhhkTtOllbtlL+nvpMjd66xoWe/DvAj/6IeZxwTckc8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609884; c=relaxed/simple;
	bh=nfPQE0hyAsdTsWbZEGg7yPTOSPBJi8HHg8i8Jkly/bs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ERCqBf5w/uHnDcj7fq+Naweqkmv22BkO7VTcURVJjIB0vl9xOE0h0Plk0TH16ACp10aB29jspNiKV7e/Cqt+NP2dOq5Casq59pLt904TBHNpqAEM0B74FBT/r2A280/yMCfF8wtkF46S/Shsvb1X4QvLfk/xeSkLTeXY0aMfAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce2629e40so915452839f.2
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 14:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726609882; x=1727214682;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foE3EDF4SJPXDXQBI6yzznfO4++2n29pS6yS5E+tNN4=;
        b=LAsM87h6ftWLgQlOr8x1w34w+6u5eOghbXYqH0uvLy4twl3lhh7SsxSqVtjcs4II4P
         3fLwyGXQITIoMxbg4FMa02KDBEIugiLHYIekLp7fZdZLM9h4X8e4ZkwMPdo4rfWXjouD
         AhGuP/L0SBThPXpKUTXKqlrfTf/0MOA6VELjzR+Y6iCXkEgth73isM64rR1oJfI+gFaX
         H65Fe8k8PdNvErM0sv5iOXcodsugcF6otYrfsv+dUaMdrSxdWo3+AfUfmyh/efE6NL5p
         3Ehbiogqn6N8VrUiTRlKf68Ru8S6O8H9mgTJpE9y75bASA31HSt2Df1/6eK2KrNJKaTl
         /G3w==
X-Forwarded-Encrypted: i=1; AJvYcCUx/HF4RtAPbpdFNKliS9z6fiYtjVzNDbmcTQoZggXAvWYxF2oHUx3K8fIQIQ9nP592SLvgR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxuxa5TSaFT8f5AQ4rlZsjLWpY6jIwttYahDAdvJoULN6yi2k
	cBCX3nI0YnNASWMzmPaOMUQJBxe8m+iCm5T001ihxgg/mUPx4/N/EUYcd/eJNeyqWtJhsbkuFez
	HTZc2dNsmh/9VoBMm6JfHmgyqYGIn5/pfqpvVrwoPQdnZzkIq0q7PI2I=
X-Google-Smtp-Source: AGHT+IE+sMH9Qq+1RZoge5VRSDxA1IuWlYZK32Y7IOp45hSLo5QmBmXfUAu+SsQDn8kxMvbgSmuQi+4AGtYV6JsTFbrBjVgJ6WGS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3a0:9c8e:9657 with SMTP id
 e9e14a558f8ab-3a09c8ea436mr79730665ab.3.1726609882386; Tue, 17 Sep 2024
 14:51:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:51:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e9f9da.050a0220.252d9a.0010.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Sep 2024)
From: syzbot <syzbot+liste6c9225a61a37daf0211@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 228     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 175     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 31      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<4> 23      No    KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

