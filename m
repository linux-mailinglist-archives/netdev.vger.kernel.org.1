Return-Path: <netdev+bounces-145496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673779CFAC5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7BA280D5D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284E1917ED;
	Fri, 15 Nov 2024 23:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D487346D
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711785; cv=none; b=hBLEL1K96YsL87EtzzU+vaoEwRs5IB/Z00RLueCBDR50C6e3MmRUaC4cw1S862pz1sTccQrxjHLSlb0gwezAkaCNtQV9fU7BkmwPyVczqcugscZep5Q4h23Sx0hi2mP1VqAuycvP1S8aptDsj7K/wy4pDbaX4Jw8nIE6ttpzW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711785; c=relaxed/simple;
	bh=t2XiTNbL3PGInfYAp4yZu+eB8efE/gjHGgnsP2+qp74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LocuCNoDwnvtmdNMeif4mPjxSEqnumOfR4mFnoEYxkgAnks51xbpiQgq5+TkyuNycZPv19AX7f6zpkwzdlHedkt+G7SHCeqQzCTET7vLZvSF84o5WiO3056BY7oUbc7jkMaZZrUVROWDlwj4gYpEUMwyB7j47J0okMpXpKLKIlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abb901672so241583939f.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731711783; x=1732316583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hiwjEO+AOrBwenkKAdfZyDGvRKtEogqhlLWQFYfXE8=;
        b=RYclv1cleuHLXVS3wtDgVBmT6R1K03hv6TCEj+m5F5RDV35xCA/54DTaRXfqURPOam
         3pAQtcz61I5CP8dA75KWuf4v4gBqbI62wC423+Focx5WiEkW/jxTRp2MZ0spfoShkcxo
         tih4hJ42/vABQjNHW14xspQQtZJVFiao90G5RMfFvjzegyNUyhLE1Hc2gB/VxsE2tIfS
         Db92euJ8M02x8D+joaP0R9grIa3lGFMT4tDNFMOfIRKPBDbMiZmTlS3G9X8QAS15KHiT
         5EAkUKY3h8JRR6mzmTB1vte1QGJeEnIKIuQRzGUFUb9wQMSaUTeU8ecBCxopVZKRR0Fx
         7+kg==
X-Forwarded-Encrypted: i=1; AJvYcCVevl0a2rcqpFuxbqU4UMvw3BThM5zARyJu874uyRWanr24UJlFowkyKZxxkT+tcUTEmD1Y+zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEUwM92PBiSbGcGZSdMJT9zEHncpgZrlUukIa4Fqq7T4y5/bH
	6H3PFPzI87gh7eU63K+uRENEfia7ib7YcU46FPPlF7nxEF4cUyTjlEkauZmYVLh92Cp+B+sIoqi
	c6OJ1i3LgMK8A7KN9uULv+dSfDKLRSzFuMuEHl96odd/MUdAC7lqmbfQ=
X-Google-Smtp-Source: AGHT+IGCWQb2OFq+eRkFN5Be/l2kdINtmGhVA25ziCy7onrqtTIY+y47XSwL8lIK4nziRpWINhyZ+hSokuOwnLRypykFMAjGs49x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:a:b0:3a6:ac17:13e4 with SMTP id
 e9e14a558f8ab-3a748079fc1mr51440345ab.18.1731711783356; Fri, 15 Nov 2024
 15:03:03 -0800 (PST)
Date: Fri, 15 Nov 2024 15:03:03 -0800
In-Reply-To: <0000000000005423e30621f745ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6737d327.050a0220.57553.0040.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in l2tp_exit_net
From: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, guohui.study@gmail.com, 
	horms@kernel.org, jchapman@katalix.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 73d33bd063c4cfef3db17f9bec3d202928ed8631
Author: James Chapman <jchapman@katalix.com>
Date:   Fri Aug 23 14:22:57 2024 +0000

    l2tp: avoid using drain_workqueue in l2tp_pre_exit_net

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1306eb5f980000
start commit:   ccb35037c48a Merge branch 'net-lan969x-add-vcap-functional..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1086eb5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1706eb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a36a7980000

Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
Fixes: 73d33bd063c4 ("l2tp: avoid using drain_workqueue in l2tp_pre_exit_net")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

