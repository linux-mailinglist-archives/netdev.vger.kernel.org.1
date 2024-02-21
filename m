Return-Path: <netdev+bounces-73500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2403785CD13
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F07286948
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5A1FDD;
	Wed, 21 Feb 2024 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVUrqLzD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5779522C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476660; cv=none; b=fe+1m2fUh/HwA0fwlzTL4yjapgNXQXzzZLKLUkStUuT4S0eGey47b/T81UmdfX3BrecpGK4N1dyErUi4NECyeRMBc7NpXAEdwOhBKsItMo1pXLlZi4saZ0JZXLgN0viZ614GFSwJ9XVWCFBmLOitl5azJlMEStCmEYBA1m6zbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476660; c=relaxed/simple;
	bh=9eIBb6bWagUzQQoX287zEEWkvYERQxEq7punHXUjISE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pibfXC0meixd234vFRkkMQyT3i5wN22gYLw6NbB1thn9aKrL0KCkpHaxrwwr2DAJwsB+dtq+CEMy3CP9R7hKEQUTEbE9YnA9ZVpcdvJn4LRVVdSzClld49tFAifq3X7SEcOjkwOI0lt/xVWPfrQb2LZgn+cqBeqPAZFUVwNDHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVUrqLzD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708476659; x=1740012659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eIBb6bWagUzQQoX287zEEWkvYERQxEq7punHXUjISE=;
  b=WVUrqLzDPC6OCEz+ufxjmJsbtFrOZsEX/1ZiZmfmfn6fP5rY95f82imR
   GxiaTTqQWMtkZMOY6wenq2og+vQsqLFer58SeqFwlO1KAjk6K6Dv+Wd6e
   9hVtlLYMUV/bGiPTZQsRDh6gs7hdL8wEyQk0jSZjzrtw20RzyfGlakaVJ
   4dHyulmxEUjUr4w5Fg3PaN9mttLS7Ti6M0170icUy9t79EEiyrVaDj9OC
   TmNSznIMD/8Xa9S1mzX0dohwFLoAttr9v2rrzEe6Ivho9wD+9SlmwK5RB
   NTntMb3oHZvzmvdDTAzb3zicSuyuU/6nYoYUzPbiK3KNd+OeIGAQIZOuw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2500811"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2500811"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9551000"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2024 16:50:58 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v5 09/10 iwl-next] idpf: fix minor controlq issues
Date: Tue, 20 Feb 2024 16:49:48 -0800
Message-ID: <20240221004949.2561972-10-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221004949.2561972-1-alan.brady@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we're here improving virtchnl we can include two minor fixes for
the lower level ctrlq flow.

This adds a memory barrier to idpf_post_rx_buffs before we update tail
on the controlq.  We should make sure our writes have had a chance to
finish before we tell HW it can touch them.

This also removes some defensive programming in idpf_ctrlq_recv. The
caller should not be using a num_q_msg value of zero or more than the
ring size and it's their responsibility to call functions sanely.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index c7f43d2fcd13..4849590a5591 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -516,6 +516,8 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 			/* Wrap to end of end ring since current ntp is 0 */
 			cq->next_to_post = cq->ring_size - 1;
 
+		dma_wmb();
+
 		wr32(hw, cq->reg.tail, cq->next_to_post);
 	}
 
@@ -546,11 +548,6 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	int err = 0;
 	u16 i;
 
-	if (*num_q_msg == 0)
-		return 0;
-	else if (*num_q_msg > cq->ring_size)
-		return -EBADR;
-
 	/* take the lock before we start messing with the ring */
 	mutex_lock(&cq->cq_lock);
 
-- 
2.43.0


