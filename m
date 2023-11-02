Return-Path: <netdev+bounces-45671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F17DEED2
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443F01C20E3E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C61170F;
	Thu,  2 Nov 2023 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CF11701
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:27:17 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE7C2181
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 02:27:15 -0700 (PDT)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 69DDC7F0003D;
	Thu,  2 Nov 2023 17:27:12 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path when possible
Date: Thu,  2 Nov 2023 17:27:12 +0800
Message-Id: <20231102092712.30793-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
X-Spam-Level: *
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

these is less opportunity that conn->tx_pushing is not 1, since
tx_pushing is just checked with 1, so move the setting tx_pushing
to 1 after atomic_dec_and_test() return false, to avoid atomic_set
and smp_wmb in tx path when possible

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/smc/smc_tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3b0ff3b..72dbdee 100644
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
+		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
 		goto again;
+	}
 
 	return rc;
 }
-- 
2.9.4


