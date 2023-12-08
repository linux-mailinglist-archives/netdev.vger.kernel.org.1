Return-Path: <netdev+bounces-55221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F302809E10
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D3DB20B35
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A511193;
	Fri,  8 Dec 2023 08:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 621 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 00:23:43 PST
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0E1B10E6;
	Fri,  8 Dec 2023 00:23:43 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [125.119.254.181])
	by mail-app3 (Coremail) with SMTP id cC_KCgA3ro1_0nJla0uWAA--.20728S2;
	Fri, 08 Dec 2023 16:23:28 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Jie Yang <jie.yang@atheros.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ethernet: atheros: fix a memleak in atl1e_setup_ring_resources
Date: Fri,  8 Dec 2023 16:23:14 +0800
Message-Id: <20231208082316.3384650-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgA3ro1_0nJla0uWAA--.20728S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1ruw4kGF17GrWDtF48tFb_yoWDZFbEgw
	s2gw18Wanxtr1jkw42yr4ru3yqk34kWws3Ga97KFW3Zw47Aw1UZ34vgrn3Xr1I9r4fAFy3
	Ar1aqF18Aa4DKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
	6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In the error handling of 'offset > adapter->ring_size', the
tx_ring->tx_buffer allocated by kzalloc should be freed,
instead of 'goto failed' instantly.

Fixes: a6a5325239c2 ("atl1e: Atheros L1E Gigabit Ethernet driver")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---

Changelog:

v2: Setting tx_ring->tx_buffer to NULL after free.
---
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 5935be190b9e..1bffe77439ac 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -866,6 +866,8 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
 		netdev_err(adapter->netdev, "offset(%d) > ring size(%d) !!\n",
 			   offset, adapter->ring_size);
 		err = -1;
+		kfree(tx_ring->tx_buffer);
+		tx_ring->tx_buffer = NULL;
 		goto failed;
 	}
 
-- 
2.34.1


