Return-Path: <netdev+bounces-207771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C53B08829
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5350A3A1106
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239927A445;
	Thu, 17 Jul 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="R63hDWmN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AD1C7009;
	Thu, 17 Jul 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741990; cv=none; b=vAApc/hmh8Jktj+v7NAvJ0Y1brZ+z51FpkyUnRjwxG6Xj/NB3uVGg5N941vyrVNcgnYMTvJ1rhqdWNDxZOCLbnygwC+1LTeHAyTJjOM1SEcxwcC+otUUcWHDZ4ijLmpTv2jsbYDYeNG/sx6EL12kKlqj40FvfrK9Gwgz8ZgcvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741990; c=relaxed/simple;
	bh=Pwv7hpTrCaFl+8csMNN2qZE1lZ5voOjoFhxVykz4+3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0xsDUz+FjCDEaSFZCsYUWBSf0PT5FA9zVsh8pngcB8zU4IAtQo6tlmw02jg955QVGxV0wwhApwgBD7dwizktrNbmhqho4s/9CHRwj1TH6XrQTfJbwm4+V8NG8Nv63d2ja0wfAWuHqxezjhPKZmpQVNuKTVulH6TIc2ppIKX/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=R63hDWmN; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752741988; x=1784277988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+kL74j0ExtZ4wXNLIEglOejI1+Gx7vp0SMgGWBrNx0=;
  b=R63hDWmNEnxfPBV+KYwWvgJuBqAwLw1rU1UCMJkhkXCSXttf/HQAG4dT
   jXuMsO73wbfPvGCPbPp8ol6x5tOATJDGM6MyHRICgOpZ2RuLC7ny0JA9w
   sYvDqIypavDzl9tYNbO6j13gDH6KGF7v0pBrXI4Jw97NqMW4uxA4Cl67o
   RJ1doTjSddjnRAtDuekJ0AwRvfoK6GYDVUSTDouV9OGIVQiXAV7yHPesc
   JdmYryO/MDdqVBYX25D5ZpDeYkNewaaVb2gKCn9W+I0rra9ddI4xMzSbJ
   peiUGnWFuAGFjJZSbKMHzrHwj3JzcDEKDD4eoFy2lwnI0VNJ7e/8s/U9l
   g==;
X-IronPort-AV: E=Sophos;i="6.16,318,1744070400"; 
   d="scan'208";a="424163580"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 08:46:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:55971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.115:2525] with esmtp (Farcaster)
 id f061f135-2222-43bd-98f0-87d97b004775; Thu, 17 Jul 2025 08:46:23 +0000 (UTC)
X-Farcaster-Flow-ID: f061f135-2222-43bd-98f0-87d97b004775
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Jul 2025 08:46:22 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.17) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Jul 2025 08:46:20 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH iwl-next v1] ixgbevf: remove unused fields from struct ixgbevf_adapter
Date: Thu, 17 Jul 2025 09:46:09 +0100
Message-ID: <20250717084609.28436-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove hw_rx_no_dma_resources and eitr_param fields from struct
ixgbevf_adapter since these fields are never referenced in the driver.

Note that the interrupt throttle rate is controlled by the
rx_itr_setting and tx_itr_setting variables.

This change simplifies the ixgbevf driver by removing unused fields,
which improves maintainability.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 4384e892f967..3a379e6a3a2a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -346,7 +346,6 @@ struct ixgbevf_adapter {
 	int num_rx_queues;
 	struct ixgbevf_ring *rx_ring[MAX_TX_QUEUES]; /* One per active queue */
 	u64 hw_csum_rx_error;
-	u64 hw_rx_no_dma_resources;
 	int num_msix_vectors;
 	u64 alloc_rx_page_failed;
 	u64 alloc_rx_buff_failed;
@@ -363,8 +362,6 @@ struct ixgbevf_adapter {
 	/* structs defined in ixgbe_vf.h */
 	struct ixgbe_hw hw;
 	u16 msg_enable;
-	/* Interrupt Throttle Rate */
-	u32 eitr_param;
 
 	struct ixgbevf_hw_stats stats;
 
-- 
2.47.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




