Return-Path: <netdev+bounces-179455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99934A7CCB1
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 06:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88DB7A776F
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 04:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C5154423;
	Sun,  6 Apr 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YofjdEWw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A02AEF5;
	Sun,  6 Apr 2025 04:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743913624; cv=none; b=J7JcYFiNfGx24uUpjruR2odbD0Rt1V5vHgAFXKMIzs7FgC0KYs6dJpUHE0sd5OX4NQNSz8Ud0TqBRknpKpc9f8csHGi2DeR5DGOMvrJ7rGeyR8G0PpzcQT3TZHfQEoCC/BttsXfcXW1YSEJ1D+T3tIUejhOsW3ysKZ8QB5Fq34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743913624; c=relaxed/simple;
	bh=+RqTH+WwDC/q3Tesjnz+n8In0t2ukkDocy2CyRC65Zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAd19fdoz69tJaEhwOYpGI8gg9TsPrk86JNLQpSh0uAHmMurxHBW0epja56xKUTbYGFVDaXrbP3S68Fq/ugaE3H5EeIxDUgtwHgSKSLGjwCxJ7yCupQbJ5wx3t2XtnQhHfr/PqNgZPCg5Gil55x/Di58Jfp/0aCG1SW4l56jPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YofjdEWw; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743913623; x=1775449623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8jroJ36qQUTrzsnbdQAdnYICUTvU857L8wJQ/dSBCA=;
  b=YofjdEWwV+JAqxaVyRolKmV/NqANEssLfmbrRk2rN3dlervODgejevEp
   kt0xyYyT8p0D009bTk2pdN7NJoF44gL2e79D3hj4QjSUTdor0usIZrrZ4
   KK0VcGCOCoHBGwJ1ow/XNjoaj5tAGGayGNoB6qy8w2vhgA4hllOLACygG
   M=;
X-IronPort-AV: E=Sophos;i="6.15,192,1739836800"; 
   d="scan'208";a="733225926"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 04:26:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:33208]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 5d617adf-83b7-4a91-bb31-67a1b4467eca; Sun, 6 Apr 2025 04:26:57 +0000 (UTC)
X-Farcaster-Flow-ID: 5d617adf-83b7-4a91-bb31-67a1b4467eca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Apr 2025 04:26:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Apr 2025 04:26:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] possible deadlock in ipv6_sock_ac_close (4)
Date: Sat, 5 Apr 2025 21:26:42 -0700
Message-ID: <20250406042646.72721-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67f08cd7.050a0220.0a13.0228.GAE@google.com>
References: <67f08cd7.050a0220.0a13.0228.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com>
Date: Fri, 04 Apr 2025 18:52:23 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e48e99b6edf4 Merge tag 'pull-fixes' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12afa7cf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
> dashboard link: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140a294c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1486994c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b03407c4ab24/disk-e48e99b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/03f6746c0414/vmlinux-e48e99b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4b3909ad8728/bzImage-e48e99b6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com
[...]
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash

#syz test

diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def..87e7d8043322 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -235,7 +235,7 @@ static struct lock_class_key af_family_kern_slock_keys[AF_MAX];
   x "AF_RXRPC" ,	x "AF_ISDN"     ,	x "AF_PHONET"   , \
   x "AF_IEEE802154",	x "AF_CAIF"	,	x "AF_ALG"      , \
   x "AF_NFC"   ,	x "AF_VSOCK"    ,	x "AF_KCM"      , \
-  x "AF_QIPCRTR",	x "AF_SMC"	,	x "AF_XDP"	, \
+  x "AF_QIPCRTR",	x "43"		,	x "AF_XDP"	, \
   x "AF_MCTP"  , \
   x "AF_MAX"
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3e6cb35baf25..3760131f1484 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -362,6 +362,9 @@ static void smc_destruct(struct sock *sk)
 		return;
 }
 
+static struct lock_class_key smc_key;
+static struct lock_class_key smc_slock_key;
+
 void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 {
 	struct smc_sock *smc = smc_sk(sk);
@@ -375,6 +378,8 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 	INIT_WORK(&smc->connect_work, smc_connect_work);
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
 	INIT_LIST_HEAD(&smc->accept_q);
+	sock_lock_init_class_and_name(sk, "slock-AF_SMC", &smc_slock_key,
+				      "sk_lock-AF_SMC", &smc_key);
 	spin_lock_init(&smc->accept_q_lock);
 	spin_lock_init(&smc->conn.send_lock);
 	sk->sk_prot->hash(sk);

