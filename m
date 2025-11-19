Return-Path: <netdev+bounces-239825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C4C6CA41
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14C1835055F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC223D7FB;
	Wed, 19 Nov 2025 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ej3+GK6H"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C622D4DD;
	Wed, 19 Nov 2025 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523689; cv=none; b=APn9FcAahuEqrtOyCx3pWYXQTGeJtAmcrL5OYsSIRv0iAzVH08gct3vvmvbdehal++VlLXnyxHwE0dxDiWSLHTxv5rvzC5yyHf7mwS9xOiIiIYuwMgxIvYioJwCNvHW5IjQAy6K4ngStOAXaMueDiB5y5Ix4C+KKsfdEFFuFpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523689; c=relaxed/simple;
	bh=96e2DZg5qkbEeMdYACgFxoT8iVrER3FKyJfTpOMAJOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iyh8YEfjBjGzv7HtoQ2ZkDGzmxEego7WeA4ahaLApquQdnFVGWRm3RxMjPunSLcj/GXwRni9D7bOA9RX0HJ/WuMgC+ja/5RmswyztCJY3XJrlgjf1vL3lbjtJXML2vxQGNGOoLZ99eWbP9LBeptbABjpEc9eF3D4Hdv5RPCHk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ej3+GK6H; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G7
	ktBLapi4WYq3AgaOQl07RKxAd2Ezai0vnmbghINj8=; b=Ej3+GK6HMIFjt3HJs4
	nNbZgD0MU2zVnGsSGd3peV81o0nyx8IZrjD2eVz+oUo1qY6a4gltjfsPLZ9GR0Ta
	RLQBupUA8i3LzAGBuv42O3KmsyKdBSB3pBPhAdERWDsuG6AAj/AaUIb9lOTkDAiw
	3E3nLPaxxu77mJtb8fms7qfnc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBHewTqOx1pcD0SBQ--.3650S2;
	Wed, 19 Nov 2025 11:39:24 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mani@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] net: wwan: mhi: Add network support for Foxconn T99W760
Date: Wed, 19 Nov 2025 11:39:17 +0800
Message-Id: <20251119033917.7526-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHewTqOx1pcD0SBQ--.3650S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr45tF13Wr1xtryxGrW3ZFb_yoWDArcE9r
	1kXF9rJr4jgFyjkr1kKF43ZFyfGwn7XF1vvFsav398AFykX3WrWrWrZFyaq3429wnrJFsr
	urnrZF1Yv3yxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKeOJUUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRQLZGkdNw6RjwAAsx

T99W760 is designed based on Qualcomm SDX35 chip. It use similar
architecture with SDX72/SDX75 chip. So we need to assign initial
link id for this device to make sure network available.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index c814fbd756a1..a142af59a91f 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -98,7 +98,8 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 {
 	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
-	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
+	    strcmp(cntrl->name, "foxconn-t99w515") == 0 ||
+	    strcmp(cntrl->name, "foxconn-t99w760") == 0)
 		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
 
 	return 0;
-- 
2.25.1


