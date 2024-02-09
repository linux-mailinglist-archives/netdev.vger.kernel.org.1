Return-Path: <netdev+bounces-70457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73FC84F169
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38361C21FB2
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398F65BC9;
	Fri,  9 Feb 2024 08:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5265BC2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467786; cv=none; b=C53dmJBEemukcMjRBMdobQbD67tm8K9EcFbsBo35qy2tSpcKqv1z/FoMpS28FDCqC/mOgUukwkl6fcr5GtNHt5l/d7mCOYhbAx4gxwyUq+KUUxQ7gI0uC6eVX8dQH6Qi6RXm5ID4mx6aLGXLIT/q3xGYhzmJ8aVcjAWf9rn6NvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467786; c=relaxed/simple;
	bh=Zck6MFVSsVoeJrJI9g41GzXMVLesXH2u0cKmmnlZ1JI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nYNp2eRnmqDmwN6rvBYfDwste59G5b12q6R8CRx5aExwD39HTbA5jFHVp4JQHmkdHzTdFZfXckVR906x1zSV11dYZFpdvEG9n792oiFUd0r4nE4paYE4lc+DANPvhmzL/xz1GwP/pHj3GZsPD93jQBaUzvuHuECDFbmB2nCFdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363c88eff5aso5532075ab.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 00:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467783; x=1708072583;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24Yrgnnur9ND4ExOfD7XjN9zPiPpVt+LDVK8jBNwB24=;
        b=tTco9eXn+WuTxqUmoAPj/SbHbivCVgQI1nWf5GRlnU8z5Uuo7pD3SC8B72oKtSS7n3
         UV0mggMT5Xnd+gP9IX050noiGOIZG74N1KQd3vO5WaZDTbzX466vrfl3vV9s4ALI/cgN
         vlJlcQUfz0MSHs7q3Ntq8bZeliLmDdeuS1rWT9NdwyrPc/MjCbEq09UfjqgWHzfgge7k
         vvhWrSUJmuSmTmk1jDgHePcTnnXanx5ENUyE3qYH+6kbtAFdfxRkmNFpt1nddKLRWPNP
         FwlUZav0IJhR65vM9wuYD+IwACwsr3w7o03fibIgyrvVKyDGS0LPD9sh3+VxdBraP+SU
         QFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeFi0R5os1JJCwfCDOMhgpRgmi1antrmJUIus5I8uyroSf8AeLFzDD1ebNteXingoI7F3VHu1y1mPh9pBVhSUUSzeejNY/
X-Gm-Message-State: AOJu0YzGo2qMzaV9U12eY7Iy1UeIJIZfzvfhzCh5cf1zQ2qspGVZmeng
	hayJ3Tk5WiX5TyrdMFbfBBIhDSwDAWiJUf57O1c1J2xFn/ZOC8vjZQ/Go+TrFPnpzdJHjZLwM5p
	mOTuTUiDfeEsDAcfBXcps/m+G0Lj8m3th84fCichAvtZk5BVew9b+P18=
X-Google-Smtp-Source: AGHT+IHBJbYxhXRQMd9Rfmr15cbvFKFPUBuW/TZQdWNmRozZQaLQJqA9PD+aJwrcavFgPhXueA01XHrWSDiqo/QuAICTYy1825Nx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:363:ca65:7d12 with SMTP id
 s7-20020a056e021a0700b00363ca657d12mr58589ild.6.1707467783730; Fri, 09 Feb
 2024 00:36:23 -0800 (PST)
Date: Fri, 09 Feb 2024 00:36:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b700a70610eed280@google.com>
Subject: [syzbot] Monthly netfilter report (Feb 2024)
From: syzbot <syzbot+list54bd6dcf58b0a6cd42fd@syzkaller.appspotmail.com>
To: fw@strlen.de, kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 158 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 47      Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 38      Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<3> 29      Yes   WARNING: suspicious RCU usage in hash_netportnet6_destroy
                  https://syzkaller.appspot.com/bug?extid=bcd44ebc3cd2db18f26c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

