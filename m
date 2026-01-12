Return-Path: <netdev+bounces-248915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7BD11485
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C769430AB2F8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7F3431F8;
	Mon, 12 Jan 2026 08:40:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42A34167B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207236; cv=none; b=Rt6aPKRZGwvgegXJQNBe2QfOFEJZ86AIfVE2u/Trse6/rL3rKY6Z1GiYx956hqHt+4ivjU/oIW9imTbmMdYjRJoAXqwuBgBb2PzqwHyHOikQVL2iSYjlAFcT/cae5m0Njgft5+MwQEi/nwxBspPhquh1lUPiWVl6eN+kG7grfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207236; c=relaxed/simple;
	bh=Rcj2mAVpoxDF0aLFcO9b3Y2bYdj1gESiHYtQhNIBAZs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FIBSgxhpcY5m0qLOIEFhYcT+UUSs2xCD++4BWuoAf9U3stIfM45A/JOcHjugsc0KWwemsZIo66FTgDcYfkuZZ2biO9cqcmw3LEEz41vxQYF9dK91XGAwJY3AZF1NmH0kEic+MLTRH67ux04U1uLNkE40UlzVwk+jcSi+4HudVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-656cc4098f3so12662459eaf.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 00:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207234; x=1768812034;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTOrSmULq9yXyDJqCO0gwowwWXJ7tl1tAmXtOohxlWM=;
        b=lM2wWm41Vv+RXyd3jVoR7N8sh7e/Xonl1W/awIJCdDjhm+FuU0wv56Cb8h+uAf+Z3R
         mIihGt6GaYGzGGjhpEniiyF5SHPprcrjqD+BhNhHiAp4W1XUV82N2Yr2lW+96w3IeYm3
         s3ix0tjqOIAzNMkaestkKDajT6CeQFsqt2uhv5TdOPla9p7nqGyWiGsPqt85egsHfK6O
         xBg9hPr1ofCoCKf+hpY9CbR7RHy6blAjkO6NFCteVgpZjkpxOilKk2vzqXummoyKSnVq
         e9hpN4CrUnw+iK1MOr2MEeHC6fiE+UbZqTFLKU3tJ5xqlr2XJlTGW48PYhllEWTNuJMG
         fwgA==
X-Forwarded-Encrypted: i=1; AJvYcCXTlOMHFp49qYqAxHcGQNvoRuGc/ZBc46WSzVPToVOF5uncD1NnhEI7E1xj2khGFiqk30Y/UTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPQ+1BHumD2YR0QvL4NX4HxdwE/31Phw1U6agV4b+KAVM0S3n
	b+MBLCeRNTVOQU8AipfpMshMs8X+j8WgF72ak2GABMoXI8D26Kt1CuxP+Cvz32fsP+vcwwjFxek
	rRlkGm8fy70TrBvppWVBi7Od37UqDgZbiFvOAMNjnsAVu9XnDmOKi2MXVBBI=
X-Google-Smtp-Source: AGHT+IGsBKS/0suwp2NmA2PVhdLt/V0mAX39xKREr5uhSZgbDf8k97jrNZc94N4jIYCFjvVqH8nhCZjPilnWUHVnd0swxlZ0cRuH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168e:b0:65f:6684:83db with SMTP id
 006d021491bc7-65f66848653mr5640393eaf.32.1768207234036; Mon, 12 Jan 2026
 00:40:34 -0800 (PST)
Date: Mon, 12 Jan 2026 00:40:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6964b382.050a0220.eaf7.0092.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Jan 2026)
From: syzbot <syzbot+list85bd0688bd37b6d4c0cf@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1387    Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 622     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 184     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 110     Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 31      Yes   WARNING in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
<6> 1       No    WARNING: locking bug in nci_close_device (3)
                  https://syzkaller.appspot.com/bug?extid=f9c5fd1a0874f9069dce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

