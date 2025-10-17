Return-Path: <netdev+bounces-230453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B9BE8348
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 13:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC966E4929
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03522320CAE;
	Fri, 17 Oct 2025 10:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F4325481
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698386; cv=none; b=gw0g7LsAs4kbD440pMxidBZmCT/Yp0yc0uYn6cqZF96hjeAY4iZ239HDUstdulryEcf0m5Q+Wskwyag0K8SZ0FD7RVZhSUUM8CmvhI3gXcPS4nQjA3LakpdhiZP0UoRuY5ZvFosg3XNCoe+LAehcqLDS1Zah1MuMAw3WnRIS4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698386; c=relaxed/simple;
	bh=UZ84pK8EZum2L4NrxRfDoOLY6Mk6uo+z6/MO8unb2Dc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XcyOc1LicPv3dHag9ADf0AIe93PPVHcJE0EdYpMu7PDpUyh+ccXUkEI2nOhfsYuZzPdU0dGYEQBP+Wbe2yqZ9Zixy+rdyrwhSFxBmAmgEcO9s+uxojZ62OwmQgj4m8EANajPCHAdPSeQEYVMubSWVpytxUE6g+OXUlRzyv9w4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f989e2030so22905255ab.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 03:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698384; x=1761303184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPL3Arg3gcXkbhPv1W9tkdK4HJ9POrjtlajg24JkOqE=;
        b=ahHo/r1SoPMBoewiTaXYcmZh+TMxBg3MPzK4eT0xL671fmqTdYV18t9TGdgQVNOl6d
         cTt/Fbt8izJjvJUZJfa+cFJIE3Beq7zdVyXbRLmfBl/dOAWjDptoUbozCXAADeHKOIR6
         SsJ8h0ESMDWPj9AriVUcoE+0uwOI9jLO4Mso3LVa/gfncdbEBZ9VDx1eSlvCKH47ylRh
         xtefDUMH3SJECQ3c933Fm6UtVp97mzEajF81eTe/9ZEYXWdbmZRlgpXQ9ez9IBpdOPD5
         TdQ9hbCCEk5cvVr2WzUko+Fv5mn5VwXZde10zdkQHFvvwdfXRuYHyza3mY3iR904TSID
         hEbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZM22ptKEeL0Y8FH4RlHVVa9UvizXqYewASjrqBchp9OAHHTm/+LX7QGMq/hK3mHdJncx64WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uGe+t0yj8AxRPHmSKORbVR8UMo8lmS590iwE1vVvDSXusRj8
	Z9DYge3WGM1e/EgbZOQskLi0+bhtmvgpzNNeUUP0/Dmjy/KoYSnzbSLviH9MOv5pfJyvXj0jo7a
	z23q0me+fmZ3ElOdR4I4z190XMagYlIVk7vhwUYme7jp9ctrvZ7lrCDp5d2c=
X-Google-Smtp-Source: AGHT+IHmxJ13Rz2Lu+NbMBxEXD8Heu8HuIssxc/gVTc21ECqI5eDExNTc4rXaDI9jqlDn4xLtV8QBDUtIbnuo7atZCPhjPPp+y2d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:430:aec5:9bee with SMTP id
 e9e14a558f8ab-430c524ce95mr42601305ab.7.1760698384460; Fri, 17 Oct 2025
 03:53:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:53:04 -0700
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f22010.050a0220.91a22.041c.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: alexanderduyck@fb.com, chuck.lever@oracle.com, davem@davemloft.net, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14ad6ed30a10afbe91b0749d6378285f4225d482
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Feb 18 18:29:39 2025 +0000

    net: allow small head cache usage with large MAX_SKB_FRAGS values

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177a35e2580000
start commit:   48a97ffc6c82 bpf: Consistently use bpf_rcu_lock_held() eve..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14fa35e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10fa35e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7e5e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ecec58580000

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Fixes: 14ad6ed30a10 ("net: allow small head cache usage with large MAX_SKB_FRAGS values")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

