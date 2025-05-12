Return-Path: <netdev+bounces-189643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7750AB2FAF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B5D178C62
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9E255F3C;
	Mon, 12 May 2025 06:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A292550B9
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031663; cv=none; b=Glt+IzRVCrc5gyeQ/zlLqC6g+7IAKYuDDwC5JxUynFmToaaXOI8CEOLg4nQDVODBb3id3USWD+u3ci9Ib7xqa9Di7zG6EGqnwZP3pyRuKCWbSwGA+SwKs9BsNlhQM3SU5PXI8wZnCR1nFRiwaaPdg1Mt+yp2Ku4q00L11E+7n2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031663; c=relaxed/simple;
	bh=dx1xwTZDbaZY9TJ/RvC0JYpCldMZJmDYnz/sEdttaWM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZC5Z9nxsd5vh9iO3n3lU5vGbUPPsgmCPiasIJ18NgPRp4zsEVnQ+jAV1UHANjaDv1/aNkFBRVZsleYhB3JElfdyHvQDNmf1415SjM9vcJ3cofOYBuAkiwsy/AL5DqPMCkyta+6pikvgPzM7A8lnAZSHsXSUtJlg56rkU3PUJBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b402f69d4so347345639f.3
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 23:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747031661; x=1747636461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNCTCFViNT8bek4HRRT3/aNA6OTSRILgCslp5/6v4b4=;
        b=V9uiqrwivwXsSSXFrg2un2CNLh34dQ5F1wojBXLqSnc26h8T1D3lT6xSE4jjO445Zt
         hM2gLbLBuae/H/pfd+Yxx0TDTDVZ5qX7HEXNsWwtCUI8kri2P9CXY3knbF6zZNZbwDkW
         LXrBHUmIjyt8sY3nC4er6QZDcs+BjksPApvHJNyh5PkunGbu2Cy965Iny91PaVBdl8yE
         TeRXzQ4u7PslzYd/2y8GoL3hyJAR4p8/qDQJPZKj6Fv54rFpUH8cvt3PtINrRqJQf5un
         hKMc184yhB8CjqoYek07uCH2smjHtdMYRXVPH2nFUJ9m7N58Jx1t8Vk5uCLkVYYMKCyO
         IDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYhiBrrfOXZmpDo4TQRyEkuJxhEKyQHnlly0mzT6L+U8sn3dVpCh2RzyKirpoPOg9PNw0iWEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqe2SrduvL9jDOEqiFJpurVLv5VYy1CXE4n3SbLdQ0aCB6d0/q
	80Xt8Pez4l3Gg4QBa/mKrWNOyqrp9XXyUbenfl6gslFXIoiwFdn73m7rn0S6RjhkhdikREN+6Qa
	jF6Kx6AZHDeLrlyKvMZcYMgc2FGSgQIvsaPuRTZpM5Hc+hHP6lbP/ht0=
X-Google-Smtp-Source: AGHT+IFRefKmtjW6013ms9QCXydNgmsa0owtvurRwlGX5Q5Y5xPOhLB3uM/XOrm4j0NA2Z4BXCNjuho3jkrk6R4JlWiB5NCiL7kw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640f:b0:85b:59f3:2ed3 with SMTP id
 ca18e2360f4ac-867635c97d0mr1423178939f.8.1747031661590; Sun, 11 May 2025
 23:34:21 -0700 (PDT)
Date: Sun, 11 May 2025 23:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821966d.050a0220.f2294.0052.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (May 2025)
From: syzbot <syzbot+listad97b905a104dc343053@syzkaller.appspotmail.com>
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
<1> 12253   Yes   BUG: workqueue lockup (5)
                  https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2> 360     No    INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<3> 248     No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<4> 3       Yes   INFO: rcu detected stall in wg_packet_handshake_receive_worker (3)
                  https://syzkaller.appspot.com/bug?extid=48f45f6dd79ca20c3283

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

