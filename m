Return-Path: <netdev+bounces-20652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624876062E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BEB1C20921
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5F1876;
	Tue, 25 Jul 2023 03:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE520E1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:01:50 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83DBD173D;
	Mon, 24 Jul 2023 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Y7Db9
	CtYu9IW3X/wWavIFjW3pwP0JBOPHcat5DJxUPQ=; b=RIRF2W4aI3DUUx39z4OG9
	6v5Rz2dG6AjeONNuuML9MW2NRCODYyvWmVmZpNYpiZOWefl+5OT8yGrRKmgyEnac
	IRiTO13k/Aa8QajqA79MbT55ZwFSnhz38Bi55aelv5dFicALob56UF+FwOtBVUc6
	ORWNfK4LtN2IpIIIXTiSik=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
	by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wC3TZbMOr9kRW7dBA--.23188S2;
	Tue, 25 Jul 2023 11:00:29 +0800 (CST)
From: Zheng Wang <zyytlz.wz@163.com>
To: s.shtylyov@omp.ru
Cc: lee@kernel.org,
	linyunsheng@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	wsa+renesas@sang-engineering.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hackerzheng666@gmail.com,
	1395428693sheep@gmail.com,
	alex000young@gmail.com,
	Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Date: Tue, 25 Jul 2023 11:00:26 +0800
Message-Id: <20230725030026.1664873-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3TZbMOr9kRW7dBA--.23188S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1DZF48JrWrZryUtr1xGrg_yoW8Xry3p3
	9xKa4F9ws5J3WUWa1xJFs7ZFWrCw17Kr909FZ7Aw1rZ3Zay3WDXr1FgFy8Aw1UJFZ5t3Wa
	vrWUZ3Wxu3WDAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM4E_DUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBRw+3U2I0Ut2f+wAAsR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
If timeout occurs, it will start the work. And if we call
ravb_remove without finishing the work, there may be a
use-after-free bug on ndev.

Fix it by finishing the job before cleanup in ravb_remove.

Note that this bug is found by static analysis, it might be
false positive.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
v4:
- add information about the bug was found suggested by Yunsheng Lin
v3:
- fix typo in commit message
v2:
- stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
add an empty line to make code clear suggested by Sergey Shtylyov
---
 drivers/net/ethernet/renesas/ravb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4d6b3b7d6abb..ce2da5101e51 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pdev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
+	netif_carrier_off(ndev);
+	netif_tx_disable(ndev);
+	cancel_work_sync(&priv->work);
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-- 
2.25.1


