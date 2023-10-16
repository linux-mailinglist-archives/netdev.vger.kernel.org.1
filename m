Return-Path: <netdev+bounces-41132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960EE7C9F16
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937DD1C208B7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 05:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D318836;
	Mon, 16 Oct 2023 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD1C8C0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 05:45:39 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB49D6
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 22:45:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 83F4E205DD;
	Mon, 16 Oct 2023 07:45:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CT-8X4LgIxiJ; Mon, 16 Oct 2023 07:45:33 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 47BD7201C7;
	Mon, 16 Oct 2023 07:45:33 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 402C580004A;
	Mon, 16 Oct 2023 07:45:33 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 07:45:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 16 Oct
 2023 07:45:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 495B33180097; Mon, 16 Oct 2023 07:45:32 +0200 (CEST)
Date: Mon, 16 Oct 2023 07:45:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] xfrm: fix a data-race in xfrm_lookup_with_ifid()
Message-ID: <ZSzN/Gppt9qkHy+v@gauss3.secunet.de>
References: <20231011102429.799316-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011102429.799316-1-edumazet@google.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:24:29AM +0000, Eric Dumazet wrote:
> syzbot complains about a race in xfrm_lookup_with_ifid() [1]
> 
> When preparing commit 0a9e5794b21e ("xfrm: annotate data-race
> around use_time") I thought xfrm_lookup_with_ifid() was modifying
> a still private structure.
> 
> [1]
> BUG: KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_lookup_with_ifid
> 
> write to 0xffff88813ea41108 of 8 bytes by task 8150 on cpu 1:
> xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
> xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
> xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
> ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
> send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
> wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
> wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
> wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
> wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
> worker_thread+0x525/0x730 kernel/workqueue.c:2784
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> write to 0xffff88813ea41108 of 8 bytes by task 15867 on cpu 0:
> xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
> xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
> xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
> ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
> send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
> wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
> wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
> wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
> wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
> worker_thread+0x525/0x730 kernel/workqueue.c:2784
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> value changed: 0x00000000651cd9d1 -> 0x00000000651cd9d2
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 15867 Comm: kworker/u4:58 Not tainted 6.6.0-rc4-syzkaller-00016-g5e62ed3b1c8a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> Workqueue: wg-kex-wg2 wg_packet_handshake_send_worker
> 
> Fixes: 0a9e5794b21e ("xfrm: annotate data-race around use_time")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Applied to the ipsec tree, thanks a lot Eric!

