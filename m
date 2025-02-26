Return-Path: <netdev+bounces-169891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E543EA46438
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EA018949D6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2C2236ED;
	Wed, 26 Feb 2025 15:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3B22332B
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582681; cv=none; b=LKnG0h7SJMA5AsKUgW9ul6BPeJa71CKgp9sHqNdI2zzfuFv6NMBrePx7X78O8PjqR++i9FT7m65phlOeIKxTYZ328loKzUrmjoWJX4dSCfe2kM8/LWawe3Vo5uU07PNoIHxKrh1h6lOJV9bIWg0mSM7zPsfDh94w+F/fYP3uG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582681; c=relaxed/simple;
	bh=F5MHjnxjp60UbX7C7VXPZhdokYMbjfeRTKKE56j9AOw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ABfTVakVTc5MNKl18Qpb5QmNtn3CYC4WoXH8O8bXL7CiqEabIHZkwOk0I6ictnks1N/c8S7o5vMilCKsLaXNbpKDstSx/9WH5cOkxX7TZ5p1W97UfN9eZz0rS0jBwdjEEAQOIeOh9w/Wcabdej3KUgrjyH9yZQ16scMu6hwtbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2dbso125927285ab.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582679; x=1741187479;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dLauZLjtD1/TVsQ0moWTJx5/4WHIVlZCeig0SlGWPs=;
        b=dGzN0JbAUDNl8WawwbSqceNAH0Ac9x04/aXc9a76TUJjYWlxU2WCWlz42W1Cw71G62
         jecKnD1VaqvbUGFfNNojLcXUgPQBMYLOAwTvKFn/LD5cILuy0SyitK5EyolIQuqlRtBr
         35G+Fi6DQ6YS7WUjb34jKmZZef/AfNqvi6lslE6Jl8cNdsjvESGsxzmB1w5UZn63Ypfj
         osae5pMB1SZ/W4QgIWWdl4HktjffdT0PZ6ASbpY4R2htZT0ErBKHmePqBI9Lh0fvBab9
         LeBCYc0fKZ46/TxkyKaJd3tPZFt8k6A0IMA+8VNkajJYN0Fu4dSR+Osp0H1qksdvKxTo
         PVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUulGHmVUAvWKfskAgfNodAwesirlkEMPZL9JmEMm2VWJXDFaLHjQAp0uUmhp4KKbxvMPWVZK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoTKldNBMrmiR/twYBsgAK+sl/qIje2NtYn2mCCmLI57hfC7WO
	hx9qJoC8PzWO4TjG/Qa1m/yYLjxuUu8GJ6DeQGzzHlICcQFHmD9muJRZzAcQShlCeD9f+BnN756
	VZlSJfBLoTYOsG3cNVjmwMeKybNb/uNcfJjA0kKaZlYU2s+aZ3KVSshQ=
X-Google-Smtp-Source: AGHT+IFWNkOZPpbWaIscX0T93fyWvSpD2MSpDIArX7UaxaX13x6kE4c5nSkLpJPQdJ+/g0COYhrtnDi65vQXePfzfrS1M6ldb2DK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3d1:9cee:3d1d with SMTP id
 e9e14a558f8ab-3d3d1fa94camr44865315ab.19.1740582678784; Wed, 26 Feb 2025
 07:11:18 -0800 (PST)
Date: Wed, 26 Feb 2025 07:11:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf2f16.050a0220.1ebef.0020.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (Feb 2025)
From: syzbot <syzbot+list4d08105289e0b54474d4@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 19 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 356     No    INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<2> 125     No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<3> 121     Yes   INFO: task hung in wg_destruct (2)
                  https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

