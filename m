Return-Path: <netdev+bounces-104720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764C790E1C0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 04:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A512844B7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526414D8DD;
	Wed, 19 Jun 2024 02:55:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F575227
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765749; cv=none; b=KbNhUQvgpoQZzRrvlGOxf//TprTf4QbdgL2/G95su1sEweEz+e1WPQ6BFfmCrA/SBCpMC5Zd7ng8lLDPbjRcwoZKmsJwdofSnHCPCuihTqqW7X5/s/RLrarL36uzf5p6iyOd0ge6nvlKE0EI5u1eSqy5nb+XtPyMHsr1Mbh3dFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765749; c=relaxed/simple;
	bh=wGJOMI9F3HjDPA9CT6zl3UIl0vsv1PL8ihKpH1anPFw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CzKeUA+l84DNgjQF/feYps/SURwtUvRdLOl3izkb+ZOjag246ogmaWH7wvHV3bwzdhfD8hjo4LB8HoFj89StzrQ801FQJKNKpFsJwpcicBdZOl0RWBn1sO2p6oc2nwXNQqJK/WpNDJ0danun5bKziCrM6t+h1OT892kSMeqfWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 1343E7F0004B;
	Wed, 19 Jun 2024 10:55:35 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hengqi@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Date: Wed, 19 Jun 2024 10:55:29 +0800
Message-Id: <20240619025529.5264-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This place is fetching the stats, so u64_stats_fetch_begin
and u64_stats_fetch_retry should be used

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/virtio_net.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d1..b669e73 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	struct dim_sample cur_sample = {};
+	unsigned int start;
 
 	if (!rq->packets_in_napi)
 		return;
 
-	u64_stats_update_begin(&rq->stats.syncp);
-	dim_update_sample(rq->calls,
-			  u64_stats_read(&rq->stats.packets),
-			  u64_stats_read(&rq->stats.bytes),
-			  &cur_sample);
-	u64_stats_update_end(&rq->stats.syncp);
+	do {
+		start = u64_stats_fetch_begin(&rq->stats.syncp);
+		dim_update_sample(rq->calls,
+				u64_stats_read(&rq->stats.packets),
+				u64_stats_read(&rq->stats.bytes),
+				&cur_sample);
+	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 
 	net_dim(&rq->dim, cur_sample);
 	rq->packets_in_napi = 0;
-- 
2.9.4


