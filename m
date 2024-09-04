Return-Path: <netdev+bounces-125183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983596C307
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F68B26B75
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F21E1A01;
	Wed,  4 Sep 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+elsgxS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E91E1A22;
	Wed,  4 Sep 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465090; cv=none; b=f8paEtTHRBPi7py+FY+k1JM0Rk/zXUn0p80qEguttxstJwGH+wM3J1Qr0/5+fyqoAWtPf2IaHbOnT4XCYfuSED+qoAuA7pXuSD/anDOgiujlvEiDSTn2fFiJeJJGFq5PwTml0e71rXtVZQV+AtvZbOZXOwRMwY716SJ5UK8y/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465090; c=relaxed/simple;
	bh=jmwK4yTCSx8cWzeawW0xhX1HJ78yUrwNll7xu4Sspw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQDlOw7N0PUcyvsKW/Gq3W8WGjUnDr4VMwYtZ8Wvr278EaHtUt/OnT9AYoX+9i+etr03oWEmR5xKm0T07QrunKyKeQVwxRumeYRz9RylN7bmYX9xG3IqaQQ49TJsHeFkriIM8Y0FEuIJceXDzHHjX9x3P+CjIqoP+9GxPT47zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+elsgxS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725465088; x=1757001088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmwK4yTCSx8cWzeawW0xhX1HJ78yUrwNll7xu4Sspw4=;
  b=M+elsgxSiUSAbgDSsVscXnj39YDb2EWSQRAYT6QKD56cMmbR46FAB+3H
   0qKpWLjS1H/o0EHrwICoPgSz/mAHRwbvhGHpHu8znj79+VD7mCjXIH3OP
   +WflPDFN6zjN7AwJ8UtGmr8fLIG4ieo1LETzZSofLlsCXJTWcOnbASGOF
   rMMCE2p1mHK2pYAheC+XEbO00LChQErPsHtisco90FCRegeIejWbM7zc6
   MUBqMwRhQsSIxgTo/gxHxjeH6KKGrMO2vkldlP6qrXPDuVozSbO81wVZc
   9guYULL/+mVnRVhnIEhzoq6WGo9R+CWbPC87g+Z6IQF7EqEKjBWyKHxPK
   g==;
X-CSE-ConnectionGUID: InvGznXHQ5irg+ry9wy0WQ==
X-CSE-MsgGUID: AY+uVKYHT5Ss2QRQvnwHfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34737146"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34737146"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:51:28 -0700
X-CSE-ConnectionGUID: pxtbhhcRTP+9Q15MkLb2DA==
X-CSE-MsgGUID: 7lnaK++/S6GXMqsvJ986HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="66041870"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2024 08:51:26 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 3/6] netdevice: add netdev_tx_reset_subqueue() shorthand
Date: Wed,  4 Sep 2024 17:47:45 +0200
Message-ID: <20240904154748.2114199-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
References: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a shorthand similar to other net*_subqueue() helpers for resetting
the queue by its index w/o obtaining &netdev_tx_queue beforehand
manually.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4d6fb0ccdea1..4f37b01b3d5a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3599,6 +3599,17 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
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
@@ -3608,7 +3619,7 @@ static inline void netdev_tx_reset_queue(struct netdev_queue *q)
  */
 static inline void netdev_reset_queue(struct net_device *dev_queue)
 {
-	netdev_tx_reset_queue(netdev_get_tx_queue(dev_queue, 0));
+	netdev_tx_reset_subqueue(dev_queue, 0);
 }
 
 /**
-- 
2.46.0


