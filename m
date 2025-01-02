Return-Path: <netdev+bounces-154730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974F9FF9BE
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5E31883B00
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D180B1B0F0B;
	Thu,  2 Jan 2025 13:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632D19007D
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824083; cv=none; b=ppp2iWN5SCLx7li6/n6c7UvGOsl+OopwNWcQJp7Fk42n1HP+DyJCeHlbWPuZkvPTxtFUrpoAIdhI2+udez4N1chUEVmiuCQ5m5PSJ/cWbRle8S9Am5QSD8XTC0txxBtjod+PVCgk/914wFTgprszzD4r3ivAaQUUTvmSLPJHi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824083; c=relaxed/simple;
	bh=jeJLFBSNU7soNTdKg96Dngptbnho0PDj10tUnGKtp9U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UAPNgnR10XlioJ3sOA8sMCX+dxw3qhU+bIcODAqiTfBCjShq1g5qqbML85UxFQy9N3/kuZS3P5uxiJS8FCGnmxs+Dx47Oj1w5026geY9nHdK8dDvQiPYXchc/OlSsd1fERwREHird+NFdSP3YFrjyfpoIiPxQS5lIbWpFfddcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so196783385ab.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 05:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735824081; x=1736428881;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9V/EZ0EvqEvdsn41gg20GJ0Mm9e7V8wfEKxrHCgDgNk=;
        b=bURQJYa5z2QzcjJbie1FswKMONI9fUtsLBKKQLfvW+uj97Jt8rqzVxcXmd+qUqL2sv
         95zOyOTF8Aqgg1uMl8y633wdaz8qD/umv0rYp9uHeoZXL5HlfecHBRF6tjB1mp59fUtT
         lQXDv3g+6jX2WNpc18q8ZvtUDuyq4E8q/9YDujFZsbhN9aQnAr7lAII7vRYF1010ST4p
         F8dM6016AndFV/mLNFEoRl9oRJnYU5CXCjoPkjmUVs/lp66WLUybDMUmH9Y5SAXYkQOO
         CS1ky+xSpLieBSnWQJVJ5wczJZjobNcisK2kIm4NJi5nccuFiG6s2ZgVvuCrPjw8JAv5
         ZWkg==
X-Forwarded-Encrypted: i=1; AJvYcCWIWFSR6tfpatQtd4eR++EH9hDix8ZFu41LSEyQEqq1LgBhlhGWOYiRqHcWjvUPx60UqH75bZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+wJWd9CQtywF5B/X5KbTt0pHO7oCZKPjBl1vCKXCR9/fDfO4
	6Qf+dwePbOZUztcQZidwMhY6RRPQIpvMLNWZ+E9UpEKEOwrtv8yrGblAty63SfGIp9qSbxuUwRv
	V9DxmVvAVWM8gqG3W41sTzlxH4GUJScdWWRN+637T+wMTHmc7tNuaCdQ=
X-Google-Smtp-Source: AGHT+IEK06P8nOxEIZAdvx2DkabZoIZxWP3JTH68tAps6q1RHePYOtrfjxEkvAMelq4P4ZdIgmaVaoqy3fZr6+sAZ9W8hRhU19ae
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:3a7:e800:7d37 with SMTP id
 e9e14a558f8ab-3c2d278282bmr370650305ab.10.1735824081356; Thu, 02 Jan 2025
 05:21:21 -0800 (PST)
Date: Thu, 02 Jan 2025 05:21:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677692d1.050a0220.3a8527.003c.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Dec 2024)
From: syzbot <syzbot+list3911d4304d6487fa3e94@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 294     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 244     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 39      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<4> 39      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
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

