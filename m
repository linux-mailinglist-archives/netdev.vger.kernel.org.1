Return-Path: <netdev+bounces-32687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D10799595
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 03:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2E91C20A0C
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 01:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1A110A;
	Sat,  9 Sep 2023 01:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505D1101
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:26:54 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D61FE9
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:26:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qemF1-00CEWY-Rm; Sat, 09 Sep 2023 08:54:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 09 Sep 2023 08:54:30 +0800
Date: Sat, 9 Sep 2023 08:54:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] xfrm: fix a data-race in xfrm_gen_index()
Message-ID: <ZPvCRpBwUVEN1GyU@gondor.apana.org.au>
References: <20230908181359.1889304-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908181359.1889304-1-edumazet@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
> ---
>  include/net/netns/xfrm.h | 1 +
>  net/xfrm/xfrm_policy.c   | 6 ++----
>  2 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

