Return-Path: <netdev+bounces-39580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EE7BFF2F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804501C20DEC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB81DFEE;
	Tue, 10 Oct 2023 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE024C9A
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:26:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DECE5AF;
	Tue, 10 Oct 2023 07:26:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614DBC15;
	Tue, 10 Oct 2023 07:27:21 -0700 (PDT)
Received: from e125770.cambridge.arm.com (e125770.arm.com [10.1.199.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85E93F762;
	Tue, 10 Oct 2023 07:26:39 -0700 (PDT)
From: Luca Fancellu <luca.fancellu@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	Rahul Singh <rahul.singh@arm.com>
Subject: [PATCH 1/1] xen-netback: add software timestamp capabilities
Date: Tue, 10 Oct 2023 15:26:30 +0100
Message-Id: <20231010142630.984585-2-luca.fancellu@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010142630.984585-1-luca.fancellu@arm.com>
References: <20231010142630.984585-1-luca.fancellu@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add software timestamp capabilities to the xen-netback driver
by advertising it on the struct ethtool_ops and calling
skb_tx_timestamp before passing the buffer to the queue.

Signed-off-by: Luca Fancellu <luca.fancellu@arm.com>
---
 drivers/net/xen-netback/interface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f3f2c07423a6..b71158967123 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -254,6 +254,9 @@ xenvif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (vif->hash.alg == XEN_NETIF_CTRL_HASH_ALGORITHM_NONE)
 		skb_clear_hash(skb);
 
+	/* timestamp packet in software */
+	skb_tx_timestamp(skb);
+
 	if (!xenvif_rx_queue_tail(queue, skb))
 		goto drop;
 
@@ -460,7 +463,7 @@ static void xenvif_get_strings(struct net_device *dev, u32 stringset, u8 * data)
 
 static const struct ethtool_ops xenvif_ethtool_ops = {
 	.get_link	= ethtool_op_get_link,
-
+	.get_ts_info 	= ethtool_op_get_ts_info,
 	.get_sset_count = xenvif_get_sset_count,
 	.get_ethtool_stats = xenvif_get_ethtool_stats,
 	.get_strings = xenvif_get_strings,
-- 
2.34.1


