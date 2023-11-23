Return-Path: <netdev+bounces-50314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEAC7F5583
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C88B2815F6
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 00:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10DEBE;
	Thu, 23 Nov 2023 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MJHp2fxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81F18D;
	Wed, 22 Nov 2023 16:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700700534; x=1732236534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmZdOEoSh54Tr4/Iw1S4mJwwzSQVqWEFdKjcVkgDJF0=;
  b=MJHp2fxjVH07BlY2RJcOcCyW+L4IfRywBd+YQi44Ng2D/k1mdJ3jTgG0
   iHLs5Rr2GzgcebgyZJihrAqupdiLXUv2ybBYvdPC3lALpcXwxp9yJRLVS
   9hmJAB5ALzm40qUzlVfEo2VlO/Ja1v25gBknN/CYJB7pVdzFWeF/K6SIq
   A=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="45754520"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:48:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id AC08EC1BBB;
	Thu, 23 Nov 2023 00:48:47 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:58429]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id 96d8e617-d220-4c49-8946-55b7f5d104c9; Thu, 23 Nov 2023 00:48:47 +0000 (UTC)
X-Farcaster-Flow-ID: 96d8e617-d220-4c49-8946-55b7f5d104c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 00:48:45 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Thu, 23 Nov 2023 00:48:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <martineau@kernel.org>,
	<matthieu.baerts@tessares.net>, <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
Date: Wed, 22 Nov 2023 16:48:34 -0800
Message-ID: <20231123004834.58534-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000545a26060abf943b@google.com>
References: <000000000000545a26060abf943b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
Date: Wed, 22 Nov 2023 07:43:23 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c2d5304e6c64 Merge tag 'platform-drivers-x86-v6.7-2' of gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1536e3d4e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
> dashboard link: https://syzkaller.appspot.com/bug?extid=b834a6b2decad004cfa1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11469724e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13934aaf680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/23ea827adf3b/disk-c2d5304e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0f964ac588f5/vmlinux-c2d5304e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b061be889285/bzImage-c2d5304e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in mptcp_incoming_options+0xc93/0x3a80 net/mptcp/options.c:1197

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c2d5304e6c648ebcf653bace7e51e0e6742e46c8

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd15ec73073e..01066aa7e67d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -370,6 +370,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 
 	/* initialize option status */
 	mp_opt->suboptions = 0;
+	mp_opt->use_ack = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);

