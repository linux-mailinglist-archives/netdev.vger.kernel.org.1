Return-Path: <netdev+bounces-46586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38F7E52D5
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 10:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E72812CB
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08600101D2;
	Wed,  8 Nov 2023 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C2101C7
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 09:48:40 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328FB199;
	Wed,  8 Nov 2023 01:48:38 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vvxn8v0_1699436910;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vvxn8v0_1699436910)
          by smtp.aliyun-inc.com;
          Wed, 08 Nov 2023 17:48:36 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net v1] net/smc: avoid data corruption caused by decline
Date: Wed,  8 Nov 2023 17:48:29 +0800
Message-Id: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

We found a data corruption issue during testing of SMC-R on Redis
applications.

The benchmark has a low probability of reporting a strange error as
shown below.

"Error: Protocol error, got "\xe2" as reply type byte"

Finally, we found that the retrieved error data was as follows:

0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2

It is quite obvious that this is a SMC DECLINE message, which means that
the applications received SMC protocol message.
We found that this was caused by the following situations:

client			server
	   proposal
	------------->
	   accept
	<-------------
	   confirm
	------------->
wait confirm

	 failed llc confirm
	    x------
(after 2s)timeout
			wait rsp

wait decline

(after 1s) timeout
			(after 2s) timeout
	    decline
	-------------->
	    decline
	<--------------

As a result, a decline message was sent in the implementation, and this
message was read from TCP by the already-fallback connection.

This patch double the client timeout as 2x of the server value,
With this simple change, the Decline messages should never cross or
collide (during Confirm link timeout).

This issue requires an immediate solution, since the protocol updates
involve a more long-term solution.

Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index abd2667..5b91f55 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -599,7 +599,7 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
 	int rc;
 
 	/* receive CONFIRM LINK request from server over RoCE fabric */
-	qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
+	qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
 			      SMC_LLC_CONFIRM_LINK);
 	if (!qentry) {
 		struct smc_clc_msg_decline dclc;
-- 
1.8.3.1


