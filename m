Return-Path: <netdev+bounces-147821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592889DC0EA
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 09:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C21636FD
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D939170A1A;
	Fri, 29 Nov 2024 08:55:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3D16A95B
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870530; cv=none; b=sQYXjRVSmiOAtkT0Ip866jUj2OLPL3e4/WSCdXKssD4CEhNfAm1OX9LZs6nxsDOQ7S5mQO1xqcS/u0GCtUk14CTYi1NmLgcnLTmpvM7qt9aZo1Zz07DzMf4RDzVRag1DhB+6RNmucb/07cF0A4bQWrLgFaprMHgSBHXUZ2aI8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870530; c=relaxed/simple;
	bh=BA7OguDmoSAtm1gbWG7d5eHN1tWSfXjI/uI+MEchFoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EP4VYqote5UnayKyXZ3x3dcHZffH8V8Q91Ec7n309pz+m/dxiqgU6jm4BeQra39N06NnZLBd1NzaxnRSblqNQKNBSXvzfv8fCTCFI/wQMfC2/vwCkQMxhAUVYtXXYo+dOQvaeTKUzyhD9Ow3m/+2vVLPfcpbdWegRBRzC6kFDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so18517655ab.3
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 00:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870528; x=1733475328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHJeA6VzEkZ1D1td3L2NHIlmUZhOrE7fAacKmomAWfk=;
        b=CaF08SvAf0xv2E+rjc9sYLLkvpKQIxepcHjhjYc9ryPmoNH68otnooiZcySyzaedCG
         14UbFQZ73X1om7xV+SQdXWEE9sgTMCD6MDiUQUuwmskw83fhEfTdXJTz6QZdKXld1AuP
         BsZskLP46KE9IE206bUGWnaKC7SzdDHlTCWQNDgyPX/QjkWFZBPBdo+d8l5iKyl+yQ1u
         VxUoSszo3mhoh0MkGzPE60Nqt8IlSoxK0MoJdks5rGAtRsLSH1jxsqz0Cy5vHwIVUrAq
         0xMG9NKwY4GTFA413yJenmMBU4xUmDI4GWQgN9V94ls84JBsRDsrizpOLfBglpNgE52P
         mGPw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+CTbuyBW2ocK9flqEmaHsBtdAwyjDZ13xQeZyuWDfUdoN6eFV9Zf5f4kKgbzOpvXguCqqOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeSBO2LBeZWEOx7Vbxkux09D8rapssu4fgfkhC3voHVtPXNB6
	xg1s9YRzcRuA+asCxblHWVs/7gM7JDNrRIwfCJJ/I/kd/txDkx6rXvZDE0HaNJQ92+2hO5fCNek
	CrPj26Kvj8wE+ZhF8UAYcwzpnQ7BT4oWxnaOfKBAtniFms8D5U1G3zic=
X-Google-Smtp-Source: AGHT+IGJr3LiiWwHhNZd6ZTSZoUENyppYXrKQYWmXD2OA/05uaxf4878i0MAbzNmvg7cL+g0U27HJr5C7bsR2mJthfo5Qr0GRbXr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a7c55f261dmr118452265ab.23.1732870528603; Fri, 29 Nov 2024
 00:55:28 -0800 (PST)
Date: Fri, 29 Nov 2024 00:55:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67498180.050a0220.253251.00a9.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Nov 2024)
From: syzbot <syzbot+list61c5ef3632c5b9ec2d7d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 350     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 231     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 51      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<4> 46      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 12      Yes   possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

