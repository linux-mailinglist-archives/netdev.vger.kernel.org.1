Return-Path: <netdev+bounces-128071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D7977CD7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2311C22024
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167361D88A4;
	Fri, 13 Sep 2024 10:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7B1D86F4
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221805; cv=none; b=kN45JohHzkBckv66dfopn6/JRA4UysMQ1MOjUw4EWF1JUb2KpgFbME3CsKgjw7P5YLg4I4Bj10lFvGrEbrpdesg5d36IN70PPuIP2PCKNgJnSSFUcIA7uVu9OrBMu/VG/wIBMKoiUb+twhJiJa1SBR8qLn8YDCVSDFmRACEOJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221805; c=relaxed/simple;
	bh=FbUmRP2XHGZQhiOCWtw7JE6mpsESXDH4ur8n7VuSaiY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u8L1v+kxWUFYJYx44u5yEWnPdfbP83hHjntXLCJLf2kAtoM/RY0vSIusOBxFk+73+O7RdTy7OhYZjFDWp2BW5y2bOYIiP0tOxRDcroZCcxpJobo5Cy4BsylpoC2hSI2QVPoaC/Dct7s3q33F8H6HNQ5xN2hLi/Z0Hw/kuUKyxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f4e119c57so18600395ab.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221802; x=1726826602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMSeyNmo4I5UKIr27ZSFVFOvJj/3uCTuGvzRA3OhzIM=;
        b=AljVAACUw4wqKRZIaVVe9c8p0pWHo4paGOVb3T5G1535LjysY8/opnVNbM1vb6HblA
         JLMb7x3TYnBU5dvmL7PyZixeAgQta8lQOrM08R0TDjxqXDCDNsdyW6xkUlgva+gen1DE
         9zKZSrLQLmxuHsBcIMSlmvUyNgG0almGv5260JVOyo7MYf94vqNTjiw1XKvtu8Cdhlen
         6mjTj9LkwmeI+9xcG4iepQm4q61uaVD+wE5fayFtRUHiYGfG0LxKVVwltTLPb/PzeVMO
         SFDOOMnUlaf34yTthazm1k+fo5g36aREgGSGN+aXjBhHYDSSaGWEVSRB1as0YOeeVqjW
         Kb/w==
X-Forwarded-Encrypted: i=1; AJvYcCV1h8ZLpzIffUAJo0I0ditokASZSc0Z32MItf67BFIK8z81PWVoaqVqN+0Wjqtju1l4no0PGBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2Y4+IrAS9LBfIJw6PqR2UAOIJx+opaUAS3dv84r76MxOP43h
	54JWqIhx8Dxdv2MghFbBAp8NrzhQJtWsl3iP7gSqV8xdju1yYdvRUfm/h6zsvfNKIRSc9FEkY0I
	ZvVVhuSS3lZVTSa4KVr1Z0iDr9FiOxF+rAs1midAV6CtEr4QSjQiBJeE=
X-Google-Smtp-Source: AGHT+IGUtAV7wYUEQOtWKgLLetpmFJnkMxMiloBQa0eQtht2JsrKsSBTlQgqXwlD1EtBNmyF24ElD7niM2jw2fYU953TyI4tkOdx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:3a0:4bd1:c1ba with SMTP id
 e9e14a558f8ab-3a084924382mr47735975ab.16.1726221802575; Fri, 13 Sep 2024
 03:03:22 -0700 (PDT)
Date: Fri, 13 Sep 2024 03:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058a7dd0621fd5528@google.com>
Subject: [syzbot] Monthly hams report (Sep 2024)
From: syzbot <syzbot+listd30be793d42f6338da3b@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 687     Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 312     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 18      Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

