Return-Path: <netdev+bounces-48648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE137EF186
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8252C1F267C3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A412E51;
	Fri, 17 Nov 2023 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx315.baidu.com [180.101.52.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 603C7130;
	Fri, 17 Nov 2023 03:16:59 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 882297F00045;
	Fri, 17 Nov 2023 19:16:57 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.co,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	dust.li@linux.alibaba.com
Subject: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the tx path when possible
Date: Fri, 17 Nov 2023 19:16:57 +0800
Message-Id: <20231117111657.16266-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

There is rare possibility that conn->tx_pushing is not 1, since
tx_pushing is just checked with 1, so move the setting tx_pushing
to 1 after atomic_dec_and_test() return false, to avoid atomic_set
and smp_wmb in tx path

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff v3: improvements in the commit body and comments
diff v2: fix a typo in commit body and add net-next subject-prefix
 net/smc/smc_tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3b0ff3b..2c2933f 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 		return 0;
 
 again:
-	atomic_set(&conn->tx_pushing, 1);
-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
 	rc = __smc_tx_sndbuf_nonempty(conn);
 
 	/* We need to check whether someone else have added some data into
@@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 	 * If so, we need to push again to prevent those data hang in the send
 	 * queue.
 	 */
-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
+	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
+		atomic_set(&conn->tx_pushing, 1);
+		smp_wmb(); /* Make sure tx_pushing is 1 before send again */
 		goto again;
+	}
 
 	return rc;
 }
-- 
2.9.4


