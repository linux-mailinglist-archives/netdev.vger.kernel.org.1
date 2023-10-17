Return-Path: <netdev+bounces-41762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E37CBDD7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C564B1C20C31
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A443D397;
	Tue, 17 Oct 2023 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B33B7BB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:37:35 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD45B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:37:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 55AAF206B0;
	Tue, 17 Oct 2023 10:37:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AfexP6KKC1cu; Tue, 17 Oct 2023 10:37:29 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 71CDD20851;
	Tue, 17 Oct 2023 10:37:28 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 6FBEB80004A;
	Tue, 17 Oct 2023 10:37:28 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:37:28 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 17 Oct
 2023 10:37:27 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8917E3182AD2; Tue, 17 Oct 2023 10:37:26 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/7] xfrm: fix a data-race in xfrm_lookup_with_ifid()
Date: Tue, 17 Oct 2023 10:37:23 +0200
Message-ID: <20231017083723.1364940-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017083723.1364940-1-steffen.klassert@secunet.com>
References: <20231017083723.1364940-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>

syzbot complains about a race in xfrm_lookup_with_ifid() [1]

When preparing commit 0a9e5794b21e ("xfrm: annotate data-race
around use_time") I thought xfrm_lookup_with_ifid() was modifying
a still private structure.

[1]
BUG: KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_lookup_with_ifid

write to 0xffff88813ea41108 of 8 bytes by task 8150 on cpu 1:
xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

write to 0xffff88813ea41108 of 8 bytes by task 15867 on cpu 0:
xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
process_one_work kernel/workqueue.c:2630 [inline]
process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
worker_thread+0x525/0x730 kernel/workqueue.c:2784
kthread+0x1d7/0x210 kernel/kthread.c:388
ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

value changed: 0x00000000651cd9d1 -> 0x00000000651cd9d2

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 15867 Comm: kworker/u4:58 Not tainted 6.6.0-rc4-syzkaller-00016-g5e62ed3b1c8a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_send_worker

Fixes: 0a9e5794b21e ("xfrm: annotate data-race around use_time")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 99df2862bdc9..d24b4d4f620e 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3220,7 +3220,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 	}
 
 	for (i = 0; i < num_pols; i++)
-		pols[i]->curlft.use_time = ktime_get_real_seconds();
+		WRITE_ONCE(pols[i]->curlft.use_time, ktime_get_real_seconds());
 
 	if (num_xfrms < 0) {
 		/* Prohibit the flow */
-- 
2.34.1


