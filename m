Return-Path: <netdev+bounces-155259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28577A018A8
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 09:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836C218836F7
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2B13AD3F;
	Sun,  5 Jan 2025 08:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1A79C4
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736066468; cv=none; b=U+ijDNkJZssXOXEezczNBDnEcIO1Jj3SgL1HpUOm8zLsTGP5Nv6uF1r2yo9anmko9vcUbn0qzgssu9mji+8OyHU/p77OYxhrLrHgX0w93YOI7HeuVOHRxFzEZfnbbdLIn2VsSOuo1Q/6ilMEcJqH2+wjpg0zNb1fbInNTrX8wUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736066468; c=relaxed/simple;
	bh=LFEO6J1chGU/2vLegLduc2KJYvtS2ra557njKjEjXAg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bp7G//KvJ/8tVHCWgllPIXgU5c5fC7G84a22YVK6s7xrIq6NyNLG7ZP1LiJjHdjo5I3XUnjWYU2aWTVUQ+TgYSYO//60dRu1gVvFpmjLK010L5ebDg2Ytmy3fLPsS951MqNa+RavPazLDRG0shWFzRG2kwXHHkkFriTbGCY9tXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 485BE7F00043;
	Sun,  5 Jan 2025 16:40:55 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: netdev@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][Resend][net-next] net: ethtool: Use hwprov under rcu_read_lock
Date: Sun,  5 Jan 2025 16:40:52 +0800
Message-Id: <20250105084052.20694-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

hwprov should be protected by rcu_read_lock to prevent possible UAF

Fixes: 4c61d809cf60 ("net: ethtool: Fix suspicious rcu_dereference usage")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/ethtool/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2607aea..b200e53 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -869,6 +869,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
 			  struct kernel_ethtool_ts_info *info)
 {
 	struct hwtstamp_provider *hwprov;
+	int ret;
 
 	rcu_read_lock();
 	hwprov = rcu_dereference(dev->hwprov);
@@ -892,8 +893,9 @@ int __ethtool_get_ts_info(struct net_device *dev,
 		return err;
 	}
 
+	ret = ethtool_get_ts_info_by_phc(dev, info, &hwprov->desc);
 	rcu_read_unlock();
-	return ethtool_get_ts_info_by_phc(dev, info, &hwprov->desc);
+	return ret;
 }
 
 bool net_support_hwtstamp_qualifier(struct net_device *dev,
-- 
2.9.4


