Return-Path: <netdev+bounces-18323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E848D7566CD
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C392813EE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F589253C0;
	Mon, 17 Jul 2023 14:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BBEBA27
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:50:32 +0000 (UTC)
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 07:50:31 PDT
Received: from localhost.localdomain (unknown [165.204.184.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37CA1E45;
	Mon, 17 Jul 2023 07:50:31 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id AE4DE36B5; Mon, 17 Jul 2023 09:34:46 -0500 (CDT)
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: siva.kallam@broadcom.com,
	prashant@broadcom.com,
	mchan@broadcom.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] tg3: fix array subscript out of bounds compilation error
Date: Mon, 17 Jul 2023 09:34:43 -0500
Message-ID: <20230717143443.163732-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix encountered compilation error in tg3.c where an array subscript was
above the array bounds of 'struct tg3_napi[5]'. Add an additional check in
the for loop to ensure that it does not exceed the bounds of
'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).

Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 4179a12fc881..33ad75b7ed91 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17791,7 +17791,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
 	rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
 	sndmbx = MAILBOX_SNDHOST_PROD_IDX_0 + TG3_64BIT_REG_LOW;
-	for (i = 0; i < tp->irq_max; i++) {
+	for (i = 0; i < tp->irq_max && i < TG3_IRQ_MAX_VECS; i++) {
 		struct tg3_napi *tnapi = &tp->napi[i];
 
 		tnapi->tp = tp;
-- 
2.41.0


