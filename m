Return-Path: <netdev+bounces-34197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA57A294B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8869B1C20A32
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EC1B297;
	Fri, 15 Sep 2023 21:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068221B279
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 21:23:04 +0000 (UTC)
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1DD3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4ZQR1fq7tIXZDlYOGYH8o3IMmD3Bd7H3/OnDHDzmI8M=; b=oCh84xDjKmiSApNxXcX4vaLh/9
	vw6coxPxVs+jnMk8ElXdw2g/rFrgV/UzbsEmn9tPRHxjfZCvbKru91Efw1x5kwrWl/DVGYQQXXGYm
	7wYWSTtOil/a2wo2qjJyLKIoiORG3+NOSq6QPWrEokBA0XeHpnZON7pIyvFsUcoedGBE=;
Received: from 88-117-56-237.adsl.highway.telekom.at ([88.117.56.237] helo=hornet.engleder.at)
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1qhFwg-0006X1-0w;
	Fri, 15 Sep 2023 23:01:46 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 3/3] tsnep: Fix NAPI polling with budget 0
Date: Fri, 15 Sep 2023 23:01:26 +0200
Message-Id: <20230915210126.74997-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915210126.74997-1-gerhard@engleder-embedded.com>
References: <20230915210126.74997-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

According to the NAPI documentation networking/napi.rst, Rx specific
APIs like page pool and XDP cannot be used at all when budget is 0.
skb Tx processing should happen regardless of the budget.

Stop NAPI polling after Tx processing and skip Rx processing if budget
is 0.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 0cdf0de555ed..8b992dc9bb52 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1734,6 +1734,10 @@ static int tsnep_poll(struct napi_struct *napi, int budget)
 	if (queue->tx)
 		complete = tsnep_tx_poll(queue->tx, budget);
 
+	/* handle case where we are called by netpoll with a budget of 0 */
+	if (unlikely(budget <= 0))
+		return budget;
+
 	if (queue->rx) {
 		done = queue->rx->xsk_pool ?
 		       tsnep_rx_poll_zc(queue->rx, napi, budget) :
-- 
2.30.2


