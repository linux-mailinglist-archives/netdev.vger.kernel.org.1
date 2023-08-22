Return-Path: <netdev+bounces-29629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B12784181
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C0828100B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFC1C9E1;
	Tue, 22 Aug 2023 13:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99217F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:05:04 +0000 (UTC)
X-Greylist: delayed 1235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 06:05:02 PDT
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90304CD6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:05:02 -0700 (PDT)
X-SMAIL-HELO: pek-lxu-l1.wrs.com
Received: from unknown (HELO pek-lxu-l1.wrs.com)([111.198.228.11])
	by sina.com (172.16.97.35) with ESMTP
	id 64E4ADA400034095; Tue, 22 Aug 2023 20:44:21 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 91623012976469
X-SMAIL-UIID: 47881107A749403D8A56318B08C8CD75-20230822-204421
From: eadavis@sina.com
To: syzbot+666c97e4686410e79649@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ralf@linux-mips.org,
	syzkaller-bugs@googlegroups.com,
	hdanton@sina.com,
	Edward AD <eadavis@sina.com>
Subject: [PATCH] sock: Fix sk_sleep return invalid pointer
Date: Tue, 22 Aug 2023 20:44:19 +0800
Message-ID: <20230822124419.1838055-1-eadavis@sina.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <000000000000e6c05806033522d3@google.com>
References: <000000000000e6c05806033522d3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward AD <eadavis@sina.com>

The parameter sk_sleep(sk) passed in when calling prepare_to_wait may 
return an invalid pointer due to nr-release reclaiming the sock.
Here, schedule_timeout_interruptible is used to replace the combination 
of 'prepare_to_wait, schedule, finish_wait' to solve the problem.

Reported-and-tested-by: syzbot+666c97e4686410e79649@syzkaller.appspotmail.com
Signed-off-by: Edward AD <eadavis@sina.com>
---
 net/netrom/af_netrom.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index eb8ccbd58d..c84a4c65b3 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -732,23 +732,18 @@ static int nr_connect(struct socket *sock, struct sockaddr *uaddr,
 	 * closed.
 	 */
 	if (sk->sk_state == TCP_SYN_SENT) {
-		DEFINE_WAIT(wait);
-
 		for (;;) {
-			prepare_to_wait(sk_sleep(sk), &wait,
-					TASK_INTERRUPTIBLE);
 			if (sk->sk_state != TCP_SYN_SENT)
 				break;
 			if (!signal_pending(current)) {
 				release_sock(sk);
-				schedule();
+				schedule_timeout_interruptible(HZ);
 				lock_sock(sk);
 				continue;
 			}
 			err = -ERESTARTSYS;
 			break;
 		}
-		finish_wait(sk_sleep(sk), &wait);
 		if (err)
 			goto out_release;
 	}
@@ -772,7 +767,6 @@ static int nr_accept(struct socket *sock, struct socket *newsock, int flags,
 {
 	struct sk_buff *skb;
 	struct sock *newsk;
-	DEFINE_WAIT(wait);
 	struct sock *sk;
 	int err = 0;
 
@@ -795,7 +789,6 @@ static int nr_accept(struct socket *sock, struct socket *newsock, int flags,
 	 *	hooked into the SABM we saved
 	 */
 	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 		skb = skb_dequeue(&sk->sk_receive_queue);
 		if (skb)
 			break;
@@ -806,14 +799,13 @@ static int nr_accept(struct socket *sock, struct socket *newsock, int flags,
 		}
 		if (!signal_pending(current)) {
 			release_sock(sk);
-			schedule();
+			schedule_timeout_uninterruptible(HZ);
 			lock_sock(sk);
 			continue;
 		}
 		err = -ERESTARTSYS;
 		break;
 	}
-	finish_wait(sk_sleep(sk), &wait);
 	if (err)
 		goto out_release;
 
-- 
2.25.1


