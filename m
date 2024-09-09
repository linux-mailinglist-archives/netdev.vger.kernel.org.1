Return-Path: <netdev+bounces-126705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F09723FB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E79282249
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7018B494;
	Mon,  9 Sep 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7Tmn6j2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B218B464
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915216; cv=none; b=Os1MSQ16WDB36ZElmTgQgaASOF4wA2ER7spAmUFv4Cg22bZy7MLjv+nu0sAKAsgWUeOXU9FuCYq67P9ap43XTN+/eBrlyKwxOKdFXuSb11WenJx79+WR+IvzLGh6WqmXV++rDnMkM50rjg+tt9zewgK/8vj56QDYu3wHNS+wF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915216; c=relaxed/simple;
	bh=ELIaF5ZqfuM/1b2T0XSmiHpSMM32qI5oYl5NaAHIp1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln0bBZDr5q5YVcTX01CA+cLOgeF8ZMvzt8POTchoPxBSfk/NhPzFiQeg/XdvxqtLgg5ohs2sTtbU0GjxsAtX4KcwrTO1q45yjZQOEBjVRrIIbaa+QWz87kx25NKCqxS2FQKpSfb4jt7X0mOSfo2m50sxU26X9RlOLiXykUVJgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7Tmn6j2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725915215; x=1757451215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELIaF5ZqfuM/1b2T0XSmiHpSMM32qI5oYl5NaAHIp1w=;
  b=c7Tmn6j2VvqexviYa3QIaP/W6C0NVoAUk4m8fR8jLilB1eirkzUcPcxy
   2hQ5VLx3fROPtU+igOC7ta7ac4fGieVXT6mKCdYsZKgb59vgmmb0mVkgJ
   Ak6iNRBr9oTE8wYLUtWdpXcd5Sg1H3FTqVBBvB6e9IfiNsLbgQ118FA4T
   oVhTF2XIqs7nF492p8W3EmctFDEDltjkRmrWs3mzLbyEkZtuiu7NhQlj0
   YRVF7uzbTpxqBzGfPsFmbgzJq4RRsnsJApczroBOSU1dyxskGEisKEHfC
   8qGVEBVyWL3nfKpTmBshhZpI6HRaITAO32b5YQs/PpixkH9SNoi1iA0Yz
   g==;
X-CSE-ConnectionGUID: YwUMs+qoTQ6MYyQppWp0XQ==
X-CSE-MsgGUID: 3XpqAaJ4RkGlYODA5kz62g==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42151253"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="42151253"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:53:33 -0700
X-CSE-ConnectionGUID: LpBuI6jJSBORYK39YtHOgg==
X-CSE-MsgGUID: fELc3Gb6RICenekXCiDSJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71194499"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Sep 2024 13:53:33 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	willemb@google.com
Subject: [PATCH net-next v3 3/6] netdevice: add netdev_tx_reset_subqueue() shorthand
Date: Mon,  9 Sep 2024 13:53:18 -0700
Message-ID: <20240909205323.3110312-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
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
index b47c00657bd0..44d1dbb54ffe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3568,6 +3568,17 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
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
@@ -3577,7 +3588,7 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
  */
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
-	netdev_tx_reset_queue(netdev_get_tx_queue(dev_queue, 0));
+	netdev_tx_reset_subqueue(dev_queue, 0);
 }
 
 /**
-- 
2.42.0


