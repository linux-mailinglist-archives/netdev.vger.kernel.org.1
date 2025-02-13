Return-Path: <netdev+bounces-166021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C11A33F3B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B427A34B1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19A22170D;
	Thu, 13 Feb 2025 12:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFD20C48E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450065; cv=none; b=OVwhnIK+4DMeKKjiF1gpf02aiOrZf3arGYRHg6vQT9OQhgaSMJVgiLy9XKWcKsoNSd9y3hi2nS75qIQ8iIxVyjF6YgbMlLsKk/zZyQAclg0eFDuGMDBgcvXawgJoTJ9L+osxBgme6grz5SI3MCIoAxfO3duerN/lLVLUdH7Wm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450065; c=relaxed/simple;
	bh=sD5mXAs0RA1YhX4PpW9ed8iq/PD4N4vdb5CxzL1bD0A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m1ZTWE8dmUfi8p5W1/WQ4/5ZNd5hmIh4nxIbK6saNqDpwk6kL1x0je+Wmf4xkVCcn5E8AVZ9rcny/LLD4ZyNK7nfR2+J3svV3nU4dfdzQx7GeEEHbDplTyAGU7+XYBe5AikQn9q8Odjn3/ybjIfXqeyqs88gpBX5wEhIl3Rq9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so6381505ab.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450063; x=1740054863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOsijhvCigFjzeUnrAKfzrHq02qk08wDCDqZc+XWjnk=;
        b=uY2ifeJpcFCwP7qAm5xfr9S/CTBVy/TvYi2JWISfFhK3Hx/RkjVs6UmPJlKbftZ0+N
         9QGExl8FK+NHjeYrhEg3hQiSbTBEyS8vf3GdVqUtVg5QNFiimwVjPj70fc/KLkAdaisT
         h+9nDNy8MtzRTFs+KH9+1TnS61HLwhXxhhEsVRKzH3vW7oLjNa4lmpDwvUUZx1coSWF6
         JdpxFa21vfLh4pKwUMMIOOGLEtU8Wy1RTTPHoEQtS465+27HC1TLZZUiTYTJNOH8+YvV
         yHo5SI9cDMOSHdotjVJT4NppDPxF9xnOk/lO6cec2qXVecnzy9MX5V7dcATDpizgE5/N
         q83g==
X-Forwarded-Encrypted: i=1; AJvYcCVnT71GTBvx1hOj+I2cIBhurT7YK/QP2hp00BTiWmwzHSmsboL1QJpHcy7rjr8gf59QQ2yWPh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDk+joY6GVZh+wHx+OyWotstR+yyi8RVGAYAQe2XknqzMfrEFe
	EVPsEavOz54DGShtlQQd8AIyRnNyN4dl+PW25AhmQuSXisqwBq0xM2RW/YP1E5BhngY4X0ZXkLs
	O3OiU4ua6VBMWjMPO+0YF5VOEjQcothkASEO6x5hyrP3CXxMLeBUR1Bs=
X-Google-Smtp-Source: AGHT+IGxqZHI1riEKhbV8ypBp5pEp0wgedke4FH5wNKfZsx2F6WsH05HnMBiuuS/DdikDfJQVcg41QmB4I8m6WTWMEWCGOaRQ/w7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:3cf:bc71:94ee with SMTP id
 e9e14a558f8ab-3d17bfe4532mr51179275ab.14.1739450063243; Thu, 13 Feb 2025
 04:34:23 -0800 (PST)
Date: Thu, 13 Feb 2025 04:34:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ade6cf.050a0220.110943.005b.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Feb 2025)
From: syzbot <syzbot+lista9445699986af9d74946@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 181 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 128     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 11      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
<3> 4       Yes   INFO: rcu detected stall in tcp_setsockopt
                  https://syzkaller.appspot.com/bug?extid=1a11c39caf29450eac9f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

