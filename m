Return-Path: <netdev+bounces-16301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6474C9A7
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 03:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67B81C2094D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065117C8;
	Mon, 10 Jul 2023 01:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA015DA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 01:39:34 +0000 (UTC)
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA894EC;
	Sun,  9 Jul 2023 18:39:28 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACnRvA8YatkKCUcCg--.56571S2;
	Mon, 10 Jul 2023 09:39:08 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	rmk+kernel@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] net: dsa: qca8k: Add check for skb_copy
Date: Mon, 10 Jul 2023 09:39:07 +0800
Message-Id: <20230710013907.43770-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnRvA8YatkKCUcCg--.56571S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxCr4rAr18Ar1DKF4fAFb_yoW3ZFcEg3
	W7XFWrZrWjkF1UKr4avr4fZ3sYy3Z5Zrn3WryIq3y3ZF98K34fJrykZr43Aws8u34rJrnr
	Ary2va48C348KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbLiSPUUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add check for the return value of skb_copy in order to avoid NULL pointer
dereference.

Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f7d7cfb2fd86..09b80644c11b 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -588,6 +588,9 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 	bool ack;
 	int ret;
 
+	if (!skb)
+		return -ENOMEM;
+
 	reinit_completion(&mgmt_eth_data->rw_done);
 
 	/* Increment seq_num and set it in the copy pkt */
-- 
2.25.1


