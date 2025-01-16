Return-Path: <netdev+bounces-158891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12084A13A76
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBA163642
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9F1F37CD;
	Thu, 16 Jan 2025 13:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0B1F2C53
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032843; cv=none; b=fZQOJPBVrIYPmmaBEhkHj7NDpfrxxg+L68ahvnT/zFtQhaavRD5HgLxNYpxE7mjetkWKbXSsfIygZBT1vtFSAJR18RqRfe5/H7FryOoALS6EUCz/NPupmfXCzOR30tQINR5m/js1/nWBZTd021/t4uDw+ygarTt9ImpdL1bcPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032843; c=relaxed/simple;
	bh=bt4Dqaj3KiJm6oOOP/oi3442OiP+mmJ00loVyqbtACo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hcd5sSc5pNkjI9e5/LaWU3X8+vUB3jf3QkJRV+Cgs0ZrHUMPukBSxahBlNwjnGPY9XK7tgSB6qKlTEsoWSJLub3OIxG7CB35vWMJIg2pEuHSTwk3bYelfKvE63rAPtvOOJbMoXUh705FZkDal5dCvPaVYYIzJ7SGZZqXnVMm4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84cdb5795b0so59562339f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032841; x=1737637641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZnwLAZE1hvc7zr13C8s1bzWnJbdM8KYpOkg+JFZ4GM=;
        b=bSzOy4DhukckTlsTZA2Z011UZ+wGheXX1F+NRFAhfP4lH4nANy4HtaoVtXPuvubXcd
         796pLDfN/dMtsOkUsG4ev3NKF5n+uyzGJOQPkU/QJ1OcRrf8YOM5tN5Yvm2Io8toVuDg
         heUkFDAv8HwG/oxd2DRQKSj3c4hZdBwPqj5yVVhBNw0tw0HRj5o4+1PAWcaV7aflSiI8
         L/TMp1LYyeYPhTBk6K7tUyFAdmYsYQuLeH6Q8AMxCqS87UgVPMoQMQBmzIhh0HduPzDV
         Tm7o2HvC9VPzAID+WD3SK6zevAFmll7tFhi0EucNdS2A1BYi4L5mSGDvKDmAjxCchikr
         D91g==
X-Forwarded-Encrypted: i=1; AJvYcCV6DVRdqy+czmwdcO2ZSgdFe+408stO3aHSfQSQnRJ9VwezNyKfSMRw3o8vAt7qdJvGtIndd9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ItU0bnjtBFKUB4JsGDCkCGktcGCs6KP7BcpUFyYfFLeu2vYE
	N/AFzpYIGtc/x8fW7B8rtOCJVsj3wFoZ/NhBjUezHvg2mRbwF+eIcI4jzSgz1YGAoip+HOg7Iwd
	Q+vNt6t379Cn8Q28spIsgh3dnhhm8utkFAvDCNXTiUsuJ4oB/noUHCPk=
X-Google-Smtp-Source: AGHT+IEyIfUjlHp2v67R/YAXNYsxt5y3Ql3uf8qYNFpqE7tp3+/B8sxZt7KvBlfasEoBjLjX+TxAkyqvfUXjnwvu5VqHMqDcS9/C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:3ce:80b8:7328 with SMTP id
 e9e14a558f8ab-3ce80b873d1mr74471705ab.3.1737032841121; Thu, 16 Jan 2025
 05:07:21 -0800 (PST)
Date: Thu, 16 Jan 2025 05:07:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67890489.050a0220.20d369.003a.GAE@google.com>
Subject: [syzbot] Monthly mptcp report (Jan 2025)
From: syzbot <syzbot+list199304eb885a80743e78@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mptcp maintainers/developers,

This is a 31-day syzbot report for the mptcp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mptcp

During the period, 2 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11      Yes   WARNING in __mptcp_clean_una (2)
                  https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
<2> 5       No    KMSAN: uninit-value in mptcp_incoming_options (2)
                  https://syzkaller.appspot.com/bug?extid=23728c2df58b3bd175ad
<3> 2       Yes   WARNING in mptcp_pm_nl_set_flags (2)
                  https://syzkaller.appspot.com/bug?extid=cd16e79c1e45f3fe0377

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

