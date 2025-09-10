Return-Path: <netdev+bounces-221599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB59B51194
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4E13BA06F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4362BE620;
	Wed, 10 Sep 2025 08:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C162DD5F6
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493519; cv=none; b=UJ4ggBDR3HXp5a+zqI2UlQtFgu+tzPSDCWTB46C3zQCwcrbuxiPO/pr9MWyz3qAdcqK8jgHTz3V16M1EuIh3FpFnDEodv3AHgNm6D1I8Fp7/oJAocm66aoGBS0WX1EWGN/LbdK0V7stVduRJfRbwHFVWpORfWmFbLpq9vz0sMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493519; c=relaxed/simple;
	bh=S2CuiN4Cn68yiXA2JsJbOfDFzzbK2I3epVu42Zi6/BQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OAZ1GI0J8MEonYPHy/5yKnoAWLmdfg1ySPI1XoO24w4PmhIsSOJ8Ie/LbabAwlKlsapKvTMT4T943YNcQ9vU5NxBJi2ovQTJ9xHze+8+8G5LwMukYT6/ENlEjz3unGlD4bzgW1hz1+AucRuDA41mjdQ30KHwnZrONeoPPTmmnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8877b84553dso399557039f.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493517; x=1758098317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u95acIewyFF1J3EgBYIfRXlsjL8T55TJ1tUJBGSOkSM=;
        b=bIrfd9lHGWJ+aS6rvqPjQK2TKFHCTum6OIdgSrp8CThCRN8n/FItEyoGWHX/RQU+3g
         52S/JvyPlMypuSvntGwGc8GJX1kNODd7Gm9o1VVn9w7UHBt97NsevHTOtER/e48F5lr4
         6fD7lv0QYfmiEhSOkyqVQZUSYoF1wYKOzBB1uU8RANtFB6e8uMaAcUmMcM7w1VCxf9gi
         oFy+7kcchvwLXXywWYAU5bgjW+dgb8a/YQZWJiISItIIR/lnibPLVmBTmeArxwVwod67
         QcHmvN5t/KBswaMrUpPMvfL44raxev+N/UUIUvT0Uki3u3edUA/2DWFGOGICa61LX0NM
         LhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhp2EMrDNCAdSk4P/6dmjIH3XDlbmdgxU+CjSTP8N/Lv9qojGsSY7jzvGv8eSY9iL+U30l7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVBQ23a9hepApFrCfa72IDLSZsJHxQfQ+F5CIp1yaPcq1f0s3
	vb9pZm+IpgailQVgrxiw/prslWmIf9Hvda/qBg4Fz9EMu5pS2C9HWKgUMGkY4w0+dx45SeBLL7C
	wDOAOozGpjFLRIxN1e6G6N0DeMmH5F9uk/EaCe6t9HShAwrdnmc2mSiNHp+E=
X-Google-Smtp-Source: AGHT+IGzcg/wm2PHttGbI3po8u0Y0KNqW8L+wNQusiH0lTexSBBTiSNAmHESO/uJ4/VlzKA3EsnKToce5UYM6xchkv44wJGYn/fU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:412:5782:c7d2 with SMTP id
 e9e14a558f8ab-4125782cf42mr49266255ab.16.1757493516971; Wed, 10 Sep 2025
 01:38:36 -0700 (PDT)
Date: Wed, 10 Sep 2025 01:38:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c1390c.050a0220.2ff435.000a.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Sep 2025)
From: syzbot <syzbot+listed2bff2fbfbec329cf12@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 641     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 381     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 109     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 62      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 5       Yes   KMSAN: uninit-value in nci_dev_up (2)
                  https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

