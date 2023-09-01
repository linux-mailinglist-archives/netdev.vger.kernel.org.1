Return-Path: <netdev+bounces-31696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0778FA01
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 10:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12434281852
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849B3D65;
	Fri,  1 Sep 2023 08:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6921FCE
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 08:34:45 +0000 (UTC)
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 01:34:43 PDT
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC5E54;
	Fri,  1 Sep 2023 01:34:43 -0700 (PDT)
Received: from 4d92782a4194.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAD3EAiMoPFkMvj9CA--.33451S2;
	Fri, 01 Sep 2023 16:27:56 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: mailhol.vincent@wanadoo.fr,
	wg@grandegger.com,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arunachalam.santhanam@in.bosch.com
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] can: etas_es58x: Add check for alloc_can_err_skb
Date: Fri,  1 Sep 2023 16:27:55 +0800
Message-Id: <20230901082755.27104-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3EAiMoPFkMvj9CA--.33451S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1kZr4xtF48Cr1UJry3twb_yoWfJwb_C3
	9avry7WF1UCryDK3WDuFnFqryYyr1DZrWxWwsYvFn8JrWUAr1xJr1jvFs3CrnrWFWS9FZ8
	XwnFyFs8u3y09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjNJ55UUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add check for the return value of alloc_can_err_skb in order to
avoid NULL pointer dereference.

Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 0c7f7505632c..d694cb22d9f4 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -680,6 +680,8 @@ int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
 	}
 
 	skb = alloc_can_err_skb(netdev, &cf);
+	if (!skb)
+		return -ENOMEM;
 
 	switch (error) {
 	case ES58X_ERR_OK:	/* 0: No error */
-- 
2.25.1


