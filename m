Return-Path: <netdev+bounces-171182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0FA4BC8B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371C13A29F0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C61F1525;
	Mon,  3 Mar 2025 10:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17CB1E98FF
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998370; cv=none; b=YqYZsHkUdu2xIqPQQl0Omv5/sfcm91MV/XsKHz1skM/ULXyssDiiU3y25yqUEX7l+1lujdzYT3KFtvqf8hv7YeitnIJ8B8OZYVv8k7Nm6mOeAh1mBVtgRYPs7EGXzglbizYEQJgm7sxFPiS5x2+ZpGyKh2/ZUUO2QRV9Sxt/iVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998370; c=relaxed/simple;
	bh=5w6pA4eYiBnHNqpcmteMeSrZV2g2L1eyHkQ8+j6h8f4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dXP1ydEMyrD4mRoOe42tj/q/j4rUMpwRCxgVH7ePN9EnwWx5/IdyRhoKl3LgtOyF6vReBg3ekiHKQid7d3U87Fw0gZdhwQQbKPmM/MEWqUDP7SiTmkJKg3MVeq010fFqwy6cFF2TNX3548UMq6PZIa3vM16T6fSGE9JqzdpfrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d060cfe752so40705035ab.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998368; x=1741603168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94B1AldC1Ra+VOi32bZczZH6eYO+XQiGIIy01bId2WI=;
        b=ETur2N/N61nPp/MK/Hyuwh3msvw7FjkNxdFtePd//G+cgWprL8EAovcLZrbd9bKaUD
         SACd8pL2uSSjUFjQShA2RyFcQWD2SPXhazzmLm+P4Exle8tHLOMsZ50ML3QOvrclqEDg
         PkT/0nUeTmy8VpByx5+y96sSIrXqtnY3FKgDBJaVMOvjhr9zPpIAGqBMYTdbZFnqr/xD
         ZJKq4oFzITZpId1P8vAJCT0RDgb24/yBOPBmMFC1DwmfGb+eJgW8XxZQzuQ1BzGmCBU6
         j6xfZsBSzlPBAHkoIxFLMXwmZV8FHl4qrE5xOwrgNBu/kJst3+onJXojlBXUCx9kZrEE
         buDg==
X-Forwarded-Encrypted: i=1; AJvYcCWBXgojOOXmAH7E/JrxfvgesgfITFO4Pe/yLAzlDQ46PCfKvKkhBniTIf0YVnZZ4IAkhCtgLO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRacslOzDH2RzVeBvE2seo1hhNtDJ7NjKxTggzwxBcdmAtYx1
	azj6Yw1uV2eLu6/mFJ8GLry9cjDkYlGHVIzw14zyn9vHJwbSVYqOaC9ppQosvSnfVaFLiX2Nt+9
	jPybbSzpPnzxSuqQe+YnImRVb1wAT7g5poqME98kzlYROqSDQGgIfrH8=
X-Google-Smtp-Source: AGHT+IHXGGfJycEVF1C0NA+tWbF57mYYWAfRa3uH7yonYPLILGd0Xs6oQjnQHhZiPUqQSby7mDcwV8F7CrVZ/77JAIhHK7ysIbjU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3111:b0:3d3:ff5c:287 with SMTP id
 e9e14a558f8ab-3d3ff5c06f9mr41959675ab.14.1740998368052; Mon, 03 Mar 2025
 02:39:28 -0800 (PST)
Date: Mon, 03 Mar 2025 02:39:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c586e0.050a0220.1dee4d.0124.GAE@google.com>
Subject: [syzbot] Monthly batman report (Mar 2025)
From: syzbot <syzbot+list0f38ff37debbbda9dc0b@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, 
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 555     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<2> 136     No    INFO: rcu detected stall in sys_recvmmsg (3)
                  https://syzkaller.appspot.com/bug?extid=b079dc0aa6e992859e7c
<3> 14      Yes   INFO: rcu detected stall in rescuer_thread
                  https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
<4> 1       Yes   INFO: rcu detected stall in batadv_bla_periodic_work (2)
                  https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

