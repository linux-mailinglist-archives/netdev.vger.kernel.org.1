Return-Path: <netdev+bounces-141241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D79BA2A4
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B461C20DB0
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 22:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1115623A;
	Sat,  2 Nov 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="j04aiFAU"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F648614E;
	Sat,  2 Nov 2024 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730584914; cv=none; b=X+7tws8zoZ+x/I6ZlSHXs9EQ+TiPNbltd2H3u+kcD5PFoLHMh+S4fpl4WFJLb5fZs8yVSObLXqGlVB/LPjIl1Y6COE292fmhwZMCk+R7AUgPPfrtGiRJlqOmR5u6Luwxth1Rd6W4v9hNFamUq1cZNp7fzqMYrdcifKILWzMKNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730584914; c=relaxed/simple;
	bh=Sf7JXMx9xsS/c1EdJK3lN7rNnBDOmXkfcQN3U1G1LZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmp1B6oCC85v6Eygcszh+QLnom/9KYMGBwBEZIuQ8jhqJ0Gzu8Y1huM3yN+kkTOqjR0PqXFFwTfrhBSsuLfQ8QfVwtTgXfRec972DaXTbwBKjAzc+294WO+YpwKg/TSs5DMcbL67D90EQTTvXE2cNFWkeXjIU6mypWMH/ewiQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=j04aiFAU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Xz/xV9bgfMQiU18NYnrLyS6x4kS7JNrVV7Z9KqjoIw0=; b=j04aiFAUY2pbHAiJ
	2pFd0dgJMgr97bsSGA/xLCxLsXDiKxCa6lCCCt1apnTBthF/M4636rF5wLGuf6oDUEih9rTc9WiLj
	mKED0h9owzqjBUfOhRw3XeUDgW8mFpATcnOzb3WoZ1r1s6welMoPKr2pBgJ1kwWgFM7c5qjwj3lbK
	mLA/FKaJWL7jrEO6AWjGfszCkmhACcZxOJssbuNONnEigFdVj7pg6YSI8tbogRTzLjX8u1TKDLf8B
	CvBtdHVRyH3xKXaBley8ZXoCpF4JuOzqI/0AVopm6lOUuBVYsBLwJd9Rc2lUke06Nv92/Qnyy4DgM
	pohcqitwrmuNQNI8LA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7MBm-00F7uJ-09;
	Sat, 02 Nov 2024 22:01:46 +0000
From: linux@treblig.org
To: shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	ndagan@amazon.com,
	saeedb@amazon.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: ena: Remove deadcode
Date: Sat,  2 Nov 2024 22:01:42 +0000
Message-ID: <20241102220142.80285-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ena_com_get_dev_basic_stats() has been unused since 2017's
commit d81db2405613 ("net/ena: refactor ena_get_stats64 to be atomic
context safe")

ena_com_get_offload_settings() has been unused since the original
commit of ENA back in 2016 in
commit 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic
Network Adapters (ENA)")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 33 -----------------------
 drivers/net/ethernet/amazon/ena/ena_com.h | 18 -------------
 2 files changed, 51 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index d958cda9e58b..bc23b8fa7a37 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2198,21 +2198,6 @@ int ena_com_get_ena_srd_info(struct ena_com_dev *ena_dev,
 	return ret;
 }
 
-int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
-				struct ena_admin_basic_stats *stats)
-{
-	struct ena_com_stats_ctx ctx;
-	int ret;
-
-	memset(&ctx, 0x0, sizeof(ctx));
-	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_BASIC);
-	if (likely(ret == 0))
-		memcpy(stats, &ctx.get_resp.u.basic_stats,
-		       sizeof(ctx.get_resp.u.basic_stats));
-
-	return ret;
-}
-
 int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32 len)
 {
 	struct ena_admin_aq_get_stats_cmd *get_cmd;
@@ -2289,24 +2274,6 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 	return ret;
 }
 
-int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
-				 struct ena_admin_feature_offload_desc *offload)
-{
-	int ret;
-	struct ena_admin_get_feat_resp resp;
-
-	ret = ena_com_get_feature(ena_dev, &resp,
-				  ENA_ADMIN_STATELESS_OFFLOAD_CONFIG, 0);
-	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device, "Failed to get offload capabilities %d\n", ret);
-		return ret;
-	}
-
-	memcpy(offload, &resp.u.offload, sizeof(resp.u.offload));
-
-	return 0;
-}
-
 int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index a372c5e768a7..20e1529adf3b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -591,15 +591,6 @@ int ena_com_set_aenq_config(struct ena_com_dev *ena_dev, u32 groups_flag);
 int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 			      struct ena_com_dev_get_features_ctx *get_feat_ctx);
 
-/* ena_com_get_dev_basic_stats - Get device basic statistics
- * @ena_dev: ENA communication layer struct
- * @stats: stats return value
- *
- * @return: 0 on Success and negative value otherwise.
- */
-int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
-				struct ena_admin_basic_stats *stats);
-
 /* ena_com_get_eni_stats - Get extended network interface statistics
  * @ena_dev: ENA communication layer struct
  * @stats: stats return value
@@ -635,15 +626,6 @@ int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32
  */
 int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu);
 
-/* ena_com_get_offload_settings - Retrieve the device offloads capabilities
- * @ena_dev: ENA communication layer struct
- * @offlad: offload return value
- *
- * @return: 0 on Success and negative value otherwise.
- */
-int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
-				 struct ena_admin_feature_offload_desc *offload);
-
 /* ena_com_rss_init - Init RSS
  * @ena_dev: ENA communication layer struct
  * @log_size: indirection log size
-- 
2.47.0


