Return-Path: <netdev+bounces-13260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313873AFB7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05531C20E03
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C738D;
	Fri, 23 Jun 2023 05:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794C642
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 05:11:55 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160D1FE1;
	Thu, 22 Jun 2023 22:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687497113; x=1719033113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWj1VSHjeQifGegDV6SwXxM3IwTPiL+2f0IbuRC5FmI=;
  b=BOm/Y9VP8j83tSpDB1+ZqUn4azyckgJJi5kw3VNoHWGytbUMqAO3qZHA
   7lVqV7JozlIbW0CK10VIKk5sFXd2be4MaPj76j310EhXPa3T3gxdWPbmp
   /X2ESiIpJbsg+ncq8QkxHL8qHiwiFmAFoTfN/3DMBfVOOO9Eqh94FlfDZ
   a+zJyp2F52zLMHroCjXrBOoYDsaz5oP98Nc3mjdL4v9PuXG9zcXSfIDUe
   X8QLzQRIKfPfNoerZU5CsGCD/LgBRkhLKapcZjdaQnKw1HJGUr/uccb2O
   4bRmkztZaMEnVFDyRntdgwGE/kL/NeWzNIaQkL8MhJfXfD5uYlHbwEGoT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426671641"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="426671641"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 22:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="665353763"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="665353763"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2023 22:11:49 -0700
Received: from inlubt0246.localdomain (inlubt0246.iind.intel.com [10.67.198.165])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 4A5F715B53;
	Fri, 23 Jun 2023 10:41:48 +0530 (IST)
Received: by inlubt0246.localdomain (Postfix, from userid 12088949)
	id 3E86D5F772; Fri, 23 Jun 2023 10:41:48 +0530 (IST)
From: Kumari Pallavi <kumari.pallavi@intel.com>
To: rcsekar@samsung.com,
	wg@grandegger.com,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mallikarjunappa.sangannavar@intel.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kumari Pallavi <kumari.pallavi@intel.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH 1/1] can: m_can: Control tx and rx flow to avoid communication stall
Date: Fri, 23 Jun 2023 10:41:24 +0530
Message-Id: <20230623051124.64132-1-kumari.pallavi@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In bi-directional CAN transfer using M_CAN IP, with
the frame gap being set to '0', it leads to Protocol
error in Arbitration phase resulting in communication
stall.
Discussed with Bosch M_CAN IP team and the stall issue
can only be overcome by controlling the tx and rx 
packets flow as done by the patch.

Rx packets would also be serviced when there is a tx 
interrupt. The solution has been tested extensively for
more than 10 days, and no issues has been observed.

Setup that is used to reproduce the issue: 

+---------------------+		+----------------------+
|Intel ElkhartLake    |		|Intel ElkhartLake     |		
|	+--------+    |		|	+--------+     |
|	|m_can 0 |    |<=======>|	|m_can 0 |     |		    
|	+--------+    |		|	+--------+     |		 
+---------------------+		+----------------------+           

Steps to be run on the two Elkhartlake HW:

1. ip link set can0 type can bitrate 1000000
2. ip link set can0 txqueuelen 2048
3. ip link set can0 up
4. cangen -g 0 can0
5. candump can0

cangen -g 0 can0 & candump can0 commands are used for transmit and 
receive on both the m_can HW simultaneously where -g is the frame gap 
between two frames.

Signed-off-by: Kumari Pallavi <kumari.pallavi@intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..94aa0ba89202 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1118,7 +1118,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
-
+			m_can_write(cdev, M_CAN_IE, IR_ALL_INT & ~(IR_TEFN));
 			if (netif_queue_stopped(dev) &&
 			    !m_can_tx_fifo_full(cdev))
 				netif_wake_queue(dev);
@@ -1787,6 +1787,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		}
 	} else {
 		cdev->tx_skb = skb;
+		m_can_write(cdev, M_CAN_IE, IR_ALL_INT & (IR_TEFN));
 		return m_can_tx_handler(cdev);
 	}
 
-- 
2.17.1


