Return-Path: <netdev+bounces-186902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B953AA3CF2
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4DB1BC5861
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3A255F5A;
	Tue, 29 Apr 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eK68T582"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B3255F3F
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970429; cv=none; b=mqJ22swZ1qB4/7fN0VIuTdcu4akK4bwqEDcRlMnJs3c7o6nFbP+QLkR7idVmF64aleZS7URXUroxGGQtD4Ow0JxtxwUjLUqo6uoDCwDufaTtJFUXoB2piBp11CPB//Slxjheu06Geu+7+8EtEXGXGwQQHLpcyKTFFQBE8+G/68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970429; c=relaxed/simple;
	bh=g2dKvfrJFC1BFYmFf6LJPoLxwKOI/IJ+/medVNV+fJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWqQOmsLkUGzgldhU2try3Ht9d0L/4C/HJW300S+XqkHIp6KudsGb3kGjfb22otafB0KEUaAYPSpMZSVBjJScPNFMeetw9EXPFtRgaqSDjVinygMpEusYcftbREyIHw+2TvHzjEm7vBxhff6/MqfXTklgGI4cM+1U0ttCYbtmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eK68T582; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970429; x=1777506429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g2dKvfrJFC1BFYmFf6LJPoLxwKOI/IJ+/medVNV+fJ8=;
  b=eK68T582JM9OWKstZ3irDrykmLFxhpKiaIes1W0wr5uUm2xoxOBeinSh
   j7h5lCFc+32DernvyvVueEawXcM3FtAzv7O/af+T9AY4jouAPd74/Iv/8
   9lkOjcax9ZjL8TZWBmxsSUqhF6mH+YDFyMSu76ve3s7nYmVg/yUYIDyLJ
   Ykvyj5f/iT95Bsz0Yngo+i2CDUwDIdOfR7Onc558dLf0C7LEzZ6j4JDBO
   kr29B10KStY58gigtXB0TpFz2w5bOzNAtxHgV7NypoOySvXijmFqIQTr6
   USnYG+pq8vdDiae9OHgQjZCqhnmUGIRoaBzyZKwjutA6yT3vhBI4UL+fa
   Q==;
X-CSE-ConnectionGUID: AKlBJdseShqrN7pXbO3psw==
X-CSE-MsgGUID: 5VrOuDdnSWWKTMAI5saQPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990149"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:05 -0700
X-CSE-ConnectionGUID: w25lEXyTTE2MtYs6i4L6Kg==
X-CSE-MsgGUID: YRw61LF8SEKnaDn2Ug3fHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979656"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 13/13] idpf: remove unreachable code from setting mailbox
Date: Tue, 29 Apr 2025 16:46:48 -0700
Message-ID: <20250429234651.3982025-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Remove code that isn't reached. There is no need to check for
adapter->req_vec_chunks, because if it isn't set idpf_set_mb_vec_id()
won't be called.

Only one path when idpf_set_mb_vec_id() is called:
idpf_intr_req()
 -> idpf_send_alloc_vectors_msg() -> adapter->req_vec_chunk is allocated
 here, otherwise an error is returned and idpf_intr_req() exits with an
 error.

The idpf_set_mb_vec_id() becomes one-liner and it is called only once.
Remove it and set mailbox vector index directly.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index aa755dedb41d..0e428dc476ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -143,22 +143,6 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	return 0;
 }
 
-/**
- * idpf_set_mb_vec_id - Set vector index for mailbox
- * @adapter: adapter structure to access the vector chunks
- *
- * The first vector id in the requested vector chunks from the CP is for
- * the mailbox
- */
-static void idpf_set_mb_vec_id(struct idpf_adapter *adapter)
-{
-	if (adapter->req_vec_chunks)
-		adapter->mb_vector.v_idx =
-			le16_to_cpu(adapter->caps.mailbox_vector_id);
-	else
-		adapter->mb_vector.v_idx = 0;
-}
-
 /**
  * idpf_mb_intr_init - Initialize the mailbox interrupt
  * @adapter: adapter structure to store the mailbox vector
@@ -349,7 +333,7 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 		goto free_irq;
 	}
 
-	idpf_set_mb_vec_id(adapter);
+	adapter->mb_vector.v_idx = le16_to_cpu(adapter->caps.mailbox_vector_id);
 
 	vecids = kcalloc(total_vecs, sizeof(u16), GFP_KERNEL);
 	if (!vecids) {
-- 
2.47.1


