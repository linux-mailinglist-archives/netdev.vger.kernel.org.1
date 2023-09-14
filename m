Return-Path: <netdev+bounces-33737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3179FD60
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F75B20A9E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514178835;
	Thu, 14 Sep 2023 07:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAF62C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:42:32 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A61BF6
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 00:42:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 34DC2205CF;
	Thu, 14 Sep 2023 09:42:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcEWIdDnn5PQ; Thu, 14 Sep 2023 09:42:28 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D4015204D9;
	Thu, 14 Sep 2023 09:42:28 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id CFEB180004A;
	Thu, 14 Sep 2023 09:42:28 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:42:28 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 14 Sep
 2023 09:42:28 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E3F823182B09; Thu, 14 Sep 2023 09:42:27 +0200 (CEST)
Date: Thu, 14 Sep 2023 09:42:27 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] xfrm: fix a data-race in xfrm_gen_index()
Message-ID: <ZQK5YzYsPa0FuJ94@gauss3.secunet.de>
References: <20230908181359.1889304-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230908181359.1889304-1-edumazet@google.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Sep 08, 2023 at 06:13:59PM +0000, Eric Dumazet wrote:
> xfrm_gen_index() mutual exclusion uses net->xfrm.xfrm_policy_lock.
> 
> This means we must use a per-netns idx_generator variable,
> instead of a static one.
> Alternative would be to use an atomic variable.
> 
> syzbot reported:
> 
> BUG: KCSAN: data-race in xfrm_sk_policy_insert / xfrm_sk_policy_insert
> 
> write to 0xffffffff87005938 of 4 bytes by task 29466 on cpu 0:
> xfrm_gen_index net/xfrm/xfrm_policy.c:1385 [inline]
> xfrm_sk_policy_insert+0x262/0x640 net/xfrm/xfrm_policy.c:2347
> xfrm_user_policy+0x413/0x540 net/xfrm/xfrm_state.c:2639
> do_ipv6_setsockopt+0x1317/0x2ce0 net/ipv6/ipv6_sockglue.c:943
> ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
> rawv6_setsockopt+0x21e/0x410 net/ipv6/raw.c:1054
> sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
> __sys_setsockopt+0x1c9/0x230 net/socket.c:2263
> __do_sys_setsockopt net/socket.c:2274 [inline]
> __se_sys_setsockopt net/socket.c:2271 [inline]
> __x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read to 0xffffffff87005938 of 4 bytes by task 29460 on cpu 1:
> xfrm_sk_policy_insert+0x13e/0x640
> xfrm_user_policy+0x413/0x540 net/xfrm/xfrm_state.c:2639
> do_ipv6_setsockopt+0x1317/0x2ce0 net/ipv6/ipv6_sockglue.c:943
> ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
> rawv6_setsockopt+0x21e/0x410 net/ipv6/raw.c:1054
> sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
> __sys_setsockopt+0x1c9/0x230 net/socket.c:2263
> __do_sys_setsockopt net/socket.c:2274 [inline]
> __se_sys_setsockopt net/socket.c:2271 [inline]
> __x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x00006ad8 -> 0x00006b18
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 29460 Comm: syz-executor.1 Not tainted 6.5.0-rc5-syzkaller-00243-g9106536c1aa3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> 
> Fixes: 1121994c803f ("netns xfrm: policy insertion in netns")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks a lot Eric!

