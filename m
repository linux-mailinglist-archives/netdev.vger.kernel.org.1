Return-Path: <netdev+bounces-54341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74896806B12
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA67DB20CE9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A21A725;
	Wed,  6 Dec 2023 09:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 97236 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 01:52:01 PST
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E5B9
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 01:52:01 -0800 (PST)
X-QQ-mid: bizesmtp90t1701856252tl7hy36d
Received: from dsp-duanqiangwen.trustnetic.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Dec 2023 17:50:50 +0800 (CST)
X-QQ-SSF: 01400000000000D0E000000A0000000
X-QQ-FEAT: np1AzCldIqFKRGpuWr7VSKNtYQB0NbIuyjelGrJutp/oZyovYwfLIX6NqH7dP
	QD/t1fQtN6k1xJ0ErKWuboucKm2iXxTc0iZlRX4bQRXF7AjnI2rg82JXopIhErSKeqh6Ugn
	naizoZhXuB9MSulI5aEuc3SGOgNPQdblYqAaQomCSeLd9o9QkZ6+PBEITBcMyUyyg5W+ky0
	b80MsdjUWUpsMMEJIFaPfQ+bacKV7lskNFx5MNrPeKMPERXoL2IXq+TrMEM+d83+X/YOJTb
	67VfxK6YOJ3RUrcNoL+XwJA9IPrKEj94C9eIP31nzxpvH/zrdtCc4dCl3OVZXEhcFGiGYc/
	MY9rArlufdupKrlokXtuNjeBWaPeVjqJ6O0KSeDxAcnkLvCx65QgE8wWp7PQjsVmrq2WTnA
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4584648233011343514
From: duanqiangwen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	mengyuanlou@net-swift.com,
	jiawenwu@trustnetic.com,
	davem@davemloft.net,
	andrew@lunn.ch,
	bhelgaas@google.com,
	maciej.fijalkowski@intel.com
Cc: duanqiangwen <duanqiangwen@net-swift.com>
Subject: [PATCH net] net: wangxun: fix changing mac failed when running
Date: Wed,  6 Dec 2023 17:50:44 +0800
Message-Id: <20231206095044.17844-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.12.2.windows.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

in some bonding mode, service need to change mac when
netif is running. Wangxun netdev add IFF_LIVE_ADDR_CHANGE
priv_flag to support it.

Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")

Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8db804543e66..a5c623fd023e 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -582,6 +582,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 526250102db2..a78da2309db5 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -638,6 +638,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
-- 
2.12.2.windows.1


