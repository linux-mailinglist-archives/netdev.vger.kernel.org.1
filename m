Return-Path: <netdev+bounces-118568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC0952147
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9611C2160A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D01BD510;
	Wed, 14 Aug 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m12q4aC7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B61BC082
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656810; cv=none; b=gbAT3WyzC7QssnxgaBXwZHxN/3K+4AsHI7LqHXZky9OOYE7MhTXz33wHcvGvcCFytYBGw1VIU/nHyWqTOvig+BUjRlQC9ECxirFr1/6/Ir8f5NMHBC8/YO7ogq2khB1Jm4SGBUsjaJKyYXGXlmP7gYoLjxY/APJyRyYDWoTRD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656810; c=relaxed/simple;
	bh=MlMJb7WAAxplxBe6mJau3hFn2/sgn0iRYXW1tHGq37Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA+cwZrDvYpQ1uRFpNXAT2O2CXKoTPvw8A4nP20HM3S5t9jetYq+QTlUXeU4f4GIUdWI8uU3PwgABsf8CC8jknc1vtDv7kyWB91sPmCK2ztLS+4bm3wRxGnoKPUEPPqpl1YfIRjZq88yfj4Fk6yzAzOEqpPPR4G1OMzWiuiS16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m12q4aC7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723656809; x=1755192809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MlMJb7WAAxplxBe6mJau3hFn2/sgn0iRYXW1tHGq37Y=;
  b=m12q4aC7feooRCNN4gOF1YQgozTvUY2r589ankiULRkil0fNpkIhWQul
   K1qQ/+l23rg3H3kvpXUHxxmHnRtHPOxEDZ7BAJHJ3NiN+neTb3MQb9aoZ
   ScpswFrvcY9V5ogI6J/n8mg2wH1yi062zkwnd4GN4zw5qXk0d8ZPAL4EI
   by8kxCdS2YvZ/4Lho0lc8Kgs4CUthU+pup9URr7AZVYhWUTQCH3C12CAY
   8EnV5kHHcp8Tq0Y5LOb6bOWSd/sTVAESNxnd/3O8p7txP+vzD1tkvZ0kR
   XhNqJwGx707IRNVvNhD2qIKJYbbDp4S3U8tB+kK2ThndrrIayZBKdE+ly
   Q==;
X-CSE-ConnectionGUID: O2MU8ge5TTiBewM7WysozQ==
X-CSE-MsgGUID: +9cRPEGNQE2LFI2i8NJNMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21860584"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="21860584"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:33:25 -0700
X-CSE-ConnectionGUID: F1wHqG5LTYW9gC9bPQi1tQ==
X-CSE-MsgGUID: j/XkDPceT5C12xCYfz2Qyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59233871"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 10:33:25 -0700
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
Subject: [PATCH net-next 5/9] netdevice: add netdev_tx_reset_subqueue() shorthand
Date: Wed, 14 Aug 2024 10:33:02 -0700
Message-ID: <20240814173309.4166149-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
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


