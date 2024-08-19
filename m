Return-Path: <netdev+bounces-119913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7195777B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C879B1F23ADA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70791DF687;
	Mon, 19 Aug 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmxxhH23"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45E1DD3B9
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106895; cv=none; b=Lq9N0HQcqaO6OYJ40nUC4XSvmqkvxgA6Kh8mKMbRvjIdGhAlSGp1uMUKYGinunCzBjVgbL3cqJn7hE8VnkTkYzSIN+LdbfgSVxUYEwr/JLCDKcH0TodBciUN3EXZaIA+X2ZFq9LVr6I5QbhZQk0HuSDGqOItFXw7TVHWqeMp/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106895; c=relaxed/simple;
	bh=MlMJb7WAAxplxBe6mJau3hFn2/sgn0iRYXW1tHGq37Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8gNNW6lA9WOY3Gs8mDrhR0CaS2nm1M+6Yfl+TSS2dsEdLgOSZG9FuP9BvutUOaFk4QUgIFUObWvDO+lG4MBKF1OyodkUQqFrRiYw08yYV5ZUA9Gd5eIBUV5EnorCr6nAehBOPMn5wYkOJ/YHwbRVlgaE2huqrXW+bahDhH9VsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmxxhH23; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724106894; x=1755642894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MlMJb7WAAxplxBe6mJau3hFn2/sgn0iRYXW1tHGq37Y=;
  b=gmxxhH23EurEXHEOJSq5qreuWxRj+q6oRwUZDyL8xy3C1mVfQOGdd5j1
   li3aKm1AU1VW4rbhbjdeLLTLEug/f815KlxYufSkNkFGKg675pVSbcT4i
   BGf74iQv/c9iSniTJKR7gu5CSKQhxX+A/MBTnyFSB9lqS2U5vYa91ZIIL
   +lkrmJREfIHVV8zH345eUT+xQgSmaZC4cuMPkn0owZ79XM/ZDV6U35kto
   gNM+Fq/U9gKsbebiBYHG9fuhoM/p75CIha1/eD0+GRXHoXVSRssuYpT8Z
   RKyETwDyCq/gpZVInPPiRk75wyby0wHbKIBW4NPkWwYLl2n4c+Q/M+Mpy
   A==;
X-CSE-ConnectionGUID: M6oKQiiMRDK35y5qJUwH9A==
X-CSE-MsgGUID: FT2kJoe4T++8fhw/oqkoDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33535171"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33535171"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:34:51 -0700
X-CSE-ConnectionGUID: 3U0tyaGHR32Dqj2QQtU51w==
X-CSE-MsgGUID: /QfOP+ynSSe/ezJ5YNvfFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64700531"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 15:34:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: [PATCH net-next v2 5/9] netdevice: add netdev_tx_reset_subqueue() shorthand
Date: Mon, 19 Aug 2024 15:34:37 -0700
Message-ID: <20240819223442.48013-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Add a shorthand similar to other net*_subqueue() helpers for resetting
the queue by its index w/o obtaining &netdev_tx_queue beforehand
manually.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/netdevice.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..22a4adff8bb2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3545,6 +3545,17 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 #endif
 }
 
+/**
+ * netdev_tx_reset_subqueue - reset the BQL stats and state of a netdev queue
+ * @dev: network device
+ * @qid: stack index of the queue to reset
+ */
+static inline void netdev_tx_reset_subqueue(const struct net_device *dev,
+					    u32 qid)
+{
+	netdev_tx_reset_queue(netdev_get_tx_queue(dev, qid));
+}
+
 /**
  * 	netdev_reset_queue - reset the packets and bytes count of a network device
  * 	@dev_queue: network device
@@ -3554,7 +3565,7 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
  */
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
-	netdev_tx_reset_queue(netdev_get_tx_queue(dev_queue, 0));
+	netdev_tx_reset_subqueue(dev_queue, 0);
 }
 
 /**
-- 
2.42.0


