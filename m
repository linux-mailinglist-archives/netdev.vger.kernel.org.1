Return-Path: <netdev+bounces-19240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1775A059
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23571281116
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06822EF1;
	Wed, 19 Jul 2023 21:09:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826691FB25
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:09:03 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E26A1BF0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689800943; x=1721336943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLNiGM11K2K1HCO2weFDCpExzeMXR5fOBfUbc0RRoV0=;
  b=oz8B/x0JgQ0+RqPXgnjzFZ0KmRR8v60J/oBAwMwGzZO3DO9b8xAecIgb
   tgm1kezbH06VOPyeJ9yFR66KvGuEK1BeU3/BjnnWBu1GIW/zY86CWYnKR
   Qbvu/8xxVCyMeXd5rXK+T2ls+FicuWFpqB2f7EETj5LeAqSaWJoX1F1Jf
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="340640634"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 21:08:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 477098A9A1;
	Wed, 19 Jul 2023 21:08:57 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 21:08:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 19 Jul 2023 21:08:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gustavoars@kernel.org>,
	<keescook@chromium.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<leitao@debian.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
Date: Wed, 19 Jul 2023 14:08:41 -0700
Message-ID: <20230719210841.61515-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230719185322.44255-3-kuniyu@amazon.com>
References: <20230719185322.44255-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 19 Jul 2023 11:53:22 -0700
> syzkaller found a warning in packet_getname() [0], where we try to
> copy 16 bytes to sockaddr_ll.sll_addr[8].
> 
> Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
> by struct in6_addr.
> 
> The write seems to overflow, but actually not since we use struct
> sockaddr_storage defined in __sys_getsockname().
> 
> To avoid the warning, we need to let __fortify_memcpy_chk() know the
> actual buffer size.
> 
> Another option would be to use strncpy() and limit the copied length
> to sizeof(sll_addr), but it will return the partial address and might
> break an application that passes sockaddr_storage to getsockname().
> 
> [0]:
> memcpy: detected field-spanning write (size 16) of single field "sll->sll_addr" at net/packet/af_packet.c:3604 (size 8)
> WARNING: CPU: 0 PID: 255 at net/packet/af_packet.c:3604 packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> Modules linked in:
> CPU: 0 PID: 255 Comm: syz-executor750 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> lr : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> sp : ffff800089887bc0
> x29: ffff800089887bc0 x28: ffff000010f80f80 x27: 0000000000000003
> x26: dfff800000000000 x25: ffff700011310f80 x24: ffff800087d55000
> x23: dfff800000000000 x22: ffff800089887c2c x21: 0000000000000010
> x20: ffff00000de08310 x19: ffff800089887c20 x18: ffff800086ab1630
> x17: 20646c6569662065 x16: 6c676e697320666f x15: 0000000000000001
> x14: 1fffe0000d56d7ca x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 3e60944c3da92b00
> x8 : 3e60944c3da92b00 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff8000898874f8 x4 : ffff800086ac99e0 x3 : ffff8000803f8808
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
> Call trace:
>  packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
>  __sys_getsockname+0x168/0x24c net/socket.c:2042
>  __do_sys_getsockname net/socket.c:2057 [inline]
>  __se_sys_getsockname net/socket.c:2054 [inline]
>  __arm64_sys_getsockname+0x7c/0x94 net/socket.c:2054
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
>  el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/packet/af_packet.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 85ff90a03b0c..5eef94a32a4f 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3601,7 +3601,10 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	if (dev) {
>  		sll->sll_hatype = dev->type;
>  		sll->sll_halen = dev->addr_len;
> -		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
> +
> +		/* Let __fortify_memcpy_chk() know the actual buffer size. */
> +		memcpy(((struct sockaddr_storage *)sll)->__data +
> +		       offsetof(struct sockaddr_ll, sll_addr), dev->dev_addr, dev->addr_len);

Sorry, this offset was wrong and needs minus
offsetof(struct sockaddr_ll, sll_family).

Will fix in v2.

pw-bot: cr


>  	} else {
>  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
>  		sll->sll_halen = 0;
> -- 
> 2.30.2


