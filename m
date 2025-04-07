Return-Path: <netdev+bounces-179517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA7A7D447
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D1188BC91
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF9224AF0;
	Mon,  7 Apr 2025 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XA46FmkP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C1823DE;
	Mon,  7 Apr 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007846; cv=none; b=Uxw3dZOG7TLBbykxr2y0f67xcT8AQMnTcb31V9NGSi/xOm79PB+7edIxJgxs8NFnmdAs69TiVu+7SjOY8cnFfn1XDd+c/iwoiFLUTD0J+YiAma2cdDyyl+COSofRn2VbAdDQvw4FhPak1+2iWRSB98GfJBvuQwcFh82K/PmC73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007846; c=relaxed/simple;
	bh=1PLeiOJan5E04enkubnodEdWWhd/M6a1vmpMxhunRCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyM5+PijeVPgoQ3TzhZB7XwP89K9F/RajQh2N88hoq5TxS5lPPXIuNvZkqdOjrkLv4bc135oZ6yKm9hG6WRMiQOXAFnTF4FsP80+KWvA9f/Mq33LLpFVuGr6JoairJGtVVq2gM3dsBKLGykfNiuTNCoar3QzQAswwWFL3yEMsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XA46FmkP; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744007846; x=1775543846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VLIhyyYceNiIMAaYJakHuJEpyqlifxIxyTlUbCOBkRM=;
  b=XA46FmkPZmlir7C2spH2HCH6Rg2/9y3EGB2+YuSg3CIocAqW1Y2mrM5w
   B8GABkMryVNPNV+fAvO4/X7lG9UIxBOeUZCMEGBrDCgvtMQ6kBdIBadHP
   CZ84jINUbzjNWyTSk2Gnao1pxyxFObB2mgIZ8qO63OtVnS2PEiGVO1YHG
   A=;
X-IronPort-AV: E=Sophos;i="6.15,193,1739836800"; 
   d="scan'208";a="286171158"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 06:37:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:16998]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 9f665dd0-fa91-4dce-b38f-b6545df837b6; Mon, 7 Apr 2025 06:37:20 +0000 (UTC)
X-Farcaster-Flow-ID: 9f665dd0-fa91-4dce-b38f-b6545df837b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 06:37:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 06:37:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
Date: Sun, 6 Apr 2025 23:37:01 -0700
Message-ID: <20250407063703.20757-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67f3694f.050a0220.0a13.0280.GAE@google.com>
References: <67f3694f.050a0220.0a13.0280.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>
Date: Sun, 06 Apr 2025 22:57:35 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8bc251e5d874 Merge tag 'nf-25-04-03' of git://git.kernel.o..
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1133afb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=24f9c4330e7c0609
> dashboard link: https://syzkaller.appspot.com/bug?extid=45016fe295243a7882d3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1040823f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151d194c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a500d5daba83/disk-8bc251e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2459c792199a/vmlinux-8bc251e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/558655fb055e/bzImage-8bc251e5.xz
> 
> The issue was bisected to:
> 
> commit dbfc99495d960134bfe1a4f13849fb0d5373b42c
> Author: Stanislav Fomichev <sdf@fomichev.me>
> Date:   Tue Apr 1 16:34:47 2025 +0000
> 
>     net: dummy: request ops lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13233998580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a33998580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17233998580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com
> Fixes: dbfc99495d96 ("net: dummy: request ops lock")
> 
> =====================================
> WARNING: bad unlock balance detected!
> 6.14.0-syzkaller-12504-g8bc251e5d874 #0 Not tainted
> -------------------------------------
> syz-executor814/5834 is trying to release lock (&dev_instance_lock_key) at:
> [<ffffffff89f41f56>] netdev_unlock include/linux/netdevice.h:2756 [inline]
> [<ffffffff89f41f56>] netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
> [<ffffffff89f41f56>] do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
> but there are no more locks to release!

#syz test

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c23852835050..925d634f724e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3027,7 +3027,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
-		goto errout;
+		return err;
 
 	if (tb[IFLA_IFNAME])
 		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);

