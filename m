Return-Path: <netdev+bounces-106318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B626915BCB
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067132836A6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260118637;
	Tue, 25 Jun 2024 01:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx312.baidu.com [180.101.52.108])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4523746
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279667; cv=none; b=L2zevOY+dYaA8LCOm2KiBvh3qXf9e2sTl1vivvEL5ylCkh6080IHjC4mPt96hNeHHDVhOB7f2hNiNmPDOMtnXE/kVs2p3NP2CHjZLqSMHEILkOvAyPdD2pDj9vMa9S+tR39C7RbqtVxjc0Hs1PpKb4MmRikL7adEJIFxNrR8e5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279667; c=relaxed/simple;
	bh=BJFFRbURwmLnxyNoAKch521/z5WmlXztOxF4bsbB1R8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kXY+7OuPqz45JEmao7qJNyo54zs/sfJJ+ihmknx8uMNW/Szix2yeoRGdsBFPt1evmqms+EqWEDxhEkYNLxiJD/vxXnNMrpDhc9Hnunx22Ejzvq0TipumbtkvCj5kW09k5eS8FAIz1Q5mhKPl72dueMuCqSVwiOGJXq22F2ylSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 4BAE37F00047;
	Tue, 25 Jun 2024 09:34:08 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: netdev@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH,net-next,v2][resend] virtio_net: Remove u64_stats_update_begin()/end() for stats fetch
Date: Tue, 25 Jun 2024 09:34:07 +0800
Message-Id: <20240625013407.25436-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This place is fetching the stats, u64_stats_update_begin()/end()
should not be used, and the fetcher of stats is in the same context
as the updater of the stats, so don't need any protection

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1f8b72..f212977 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2382,12 +2382,13 @@ static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue
 	if (!rq->packets_in_napi)
 		return;
 
-	u64_stats_update_begin(&rq->stats.syncp);
+	/* Don't need protection when fetching stats, since fetcher and
+	 * updater of the stats are in same context
+	 */
 	dim_update_sample(rq->calls,
 			  u64_stats_read(&rq->stats.packets),
 			  u64_stats_read(&rq->stats.bytes),
 			  &cur_sample);
-	u64_stats_update_end(&rq->stats.syncp);
 
 	net_dim(&rq->dim, cur_sample);
 	rq->packets_in_napi = 0;
-- 
2.9.4


