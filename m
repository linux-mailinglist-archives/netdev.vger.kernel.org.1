Return-Path: <netdev+bounces-34196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D17A2944
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DDA281CC8
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C331B290;
	Fri, 15 Sep 2023 21:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E281BDC1
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 21:22:52 +0000 (UTC)
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330DB8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s40IqmoLDP7tNWvQF6/FpnrF0CxKvF0Aw23bj+a1PiM=; b=FodY7Sx16l7JI3bKscYvgMrGWX
	NSx+CaCfMmP42YcebSRgTMxsyz3AiSyN2Y29GhZ+NCPzhQy7WjYF3GyFCKEZ6xTKwzxqwdBH+YjCh
	+Kqog5JgzXeKIsKkC8sD7m+3emuV8AGRPM61O7/oaCgnFAxkxtjbEv8wO5PMGy3D915c=;
Received: from 88-117-56-237.adsl.highway.telekom.at ([88.117.56.237] helo=hornet.engleder.at)
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1qhFwa-0006X1-1G;
	Fri, 15 Sep 2023 23:01:40 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 1/3] tsnep: Fix NAPI scheduling
Date: Fri, 15 Sep 2023 23:01:24 +0200
Message-Id: <20230915210126.74997-2-gerhard@engleder-embedded.com>
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

According to the NAPI documentation networking/napi.rst, drivers which
have to mask interrupts explicitly should use the napi_schedule_prep()
and __napi_schedule() calls.

No problem seen so far with current implementation. Nevertheless, let's
align the implementation with documentation.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index f61bd89734c5..0cdf0de555ed 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -87,8 +87,11 @@ static irqreturn_t tsnep_irq(int irq, void *arg)
 
 	/* handle TX/RX queue 0 interrupt */
 	if ((active & adapter->queue[0].irq_mask) != 0) {
-		tsnep_disable_irq(adapter, adapter->queue[0].irq_mask);
-		napi_schedule(&adapter->queue[0].napi);
+		if (napi_schedule_prep(&adapter->queue[0].napi)) {
+			tsnep_disable_irq(adapter, adapter->queue[0].irq_mask);
+			/* schedule after masking to avoid races */
+			__napi_schedule(&adapter->queue[0].napi);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -99,8 +102,11 @@ static irqreturn_t tsnep_irq_txrx(int irq, void *arg)
 	struct tsnep_queue *queue = arg;
 
 	/* handle TX/RX queue interrupt */
-	tsnep_disable_irq(queue->adapter, queue->irq_mask);
-	napi_schedule(&queue->napi);
+	if (napi_schedule_prep(&queue->napi)) {
+		tsnep_disable_irq(queue->adapter, queue->irq_mask);
+		/* schedule after masking to avoid races */
+		__napi_schedule(&queue->napi);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.30.2


