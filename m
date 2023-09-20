Return-Path: <netdev+bounces-35232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C97A7D5A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B330328109D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74B02AB3B;
	Wed, 20 Sep 2023 12:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F42AB22
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:08:47 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78C93;
	Wed, 20 Sep 2023 05:08:44 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VsV5XW0_1695211715;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VsV5XW0_1695211715)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 20:08:41 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while closing listen socket
Date: Wed, 20 Sep 2023 20:08:34 +0800
Message-Id: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Consider the following scenarios:

smc_release
	smc_close_active
		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
		smc->clcsock->sk->sk_user_data = NULL;
		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);

smc_tcp_syn_recv_sock
	smc = smc_clcsock_user_data(sk);
	/* now */
	/* smc == NULL */

Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
since we only unset sk_user_data during smc_release, it's safe to
drop the incoming tcp reqsock.

Fixes:  ("net/smc: net/smc: Limit backlog connections"
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd97..b4acf47 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct sock *child;
 
 	smc = smc_clcsock_user_data(sk);
+	if (unlikely(!smc))
+		goto drop;
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
-- 
1.8.3.1


