Return-Path: <netdev+bounces-118576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0F9521AF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AFF1F215BD
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E31BCA03;
	Wed, 14 Aug 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0fSostZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6591BD504
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658352; cv=none; b=myX+rxAmHOoDIT26T9iPSfg4CPvfESZlJely4eHMLhYNPquZjCe8AxvpQqfMkHdfKUirr7raubQA7rNwY93yyz3NQbPjfFc0cchpjKE+FxL9jjoR7PJv4b5ibt/4mvSVXlftga8rGrbtCqqJQ90882bKtoB7mdSMOem0B5/3YGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658352; c=relaxed/simple;
	bh=1YEpXZctt4eUv/8YCRkvSvKVTV9FrORWoVuPyLl1bOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xc0vLy9Ob7bw4e6q789JXTDVw7Gs+Ad4AFn+8WkmHH/pdFr3PCBTL1bqpg0wrJnH96bi8pGOUw791kSTZw3Av6UcWbYbP+ckBw2cHRdUWnf98+/zeq9L0o6tUgW2Js2KTSGLa3zO8o6dA8HgtDuek41eOJLdqf2sy7Fcf2YO94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0fSostZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723658350; x=1755194350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1YEpXZctt4eUv/8YCRkvSvKVTV9FrORWoVuPyLl1bOg=;
  b=j0fSostZRiV4pNhiAbrXDfgBHiV9leXTAzPEl62F8mqFtFAgCwTZDlxx
   +36l63Wn2WzvUxF8TmfL+Xg18ipQHCkTtb5hl43nsz7aS8sfFW+6fcU2n
   +/ui6udHMsXlmose6fgpLbq7ohY/XTrF5/nLrVmy4m+xSu7e8Ugq2I7tY
   mE1LP+ChQdTM8lNlw29s+GLFQT4tt4OB6B/1i9y5MfAwbZ2PEjcKSemPK
   ou8rcVf6P0UE2ACX/tF2T3rUbzvTt7L5LAK9Ke8DjJzTUjhQGi3qzBhrO
   Pa1UVMEfXwJPq/IgkpkPiAaW+R1eF+OqdG4/xFPNzaDQKaAFHjZ4ZpzTM
   A==;
X-CSE-ConnectionGUID: P0lxjlfXQjS+0ZsiBXax1w==
X-CSE-MsgGUID: yYHf1xpxRtSKo4Hh1ZvxPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32523054"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="32523054"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:59:08 -0700
X-CSE-ConnectionGUID: kdKpm6egQEOyM/Bcd13eQg==
X-CSE-MsgGUID: tbg/5QjjQiCku3ycxuhXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="89887889"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 14 Aug 2024 10:59:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	anthony.l.nguyen@intel.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net] idpf: remove redundant 'req_vec_chunks' NULL check
Date: Wed, 14 Aug 2024 10:59:02 -0700
Message-ID: <20240814175903.4166390-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

'req_vec_chunks' is used to store the vector info received
from the device control plane. The memory for it is allocated
in idpf_send_alloc_vectors_msg and returns an error if the memory
allocation fails.

'req_vec_chunks' cannot be NULL in the later code flow. So remove
the conditional check to extract the vector ids received from
the device control plane.

Smatch static checker warning:

drivers/net/ethernet/intel/idpf/idpf_lib.c:417 idpf_intr_req()
error: we previously assumed 'adapter->req_vec_chunks'
could be null (see line 360)

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/intel-wired-lan/a355ae8a-9011-4a85-a4d1-5b2793bb5f7b@stanley.mountain/
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
iwl: https://lore.kernel.org/intel-wired-lan/20240724212940.2819-1-pavan.kumar.linga@intel.com/

 drivers/net/ethernet/intel/idpf/idpf_lib.c | 23 +++++-----------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 0b6c8fd5bc90..4f20343e49a9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -357,24 +357,11 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 		goto free_msix;
 	}
 
-	if (adapter->req_vec_chunks) {
-		struct virtchnl2_vector_chunks *vchunks;
-		struct virtchnl2_alloc_vectors *ac;
-
-		ac = adapter->req_vec_chunks;
-		vchunks = &ac->vchunks;
-
-		num_vec_ids = idpf_get_vec_ids(adapter, vecids, total_vecs,
-					       vchunks);
-		if (num_vec_ids < v_actual) {
-			err = -EINVAL;
-			goto free_vecids;
-		}
-	} else {
-		int i;
-
-		for (i = 0; i < v_actual; i++)
-			vecids[i] = i;
+	num_vec_ids = idpf_get_vec_ids(adapter, vecids, total_vecs,
+				       &adapter->req_vec_chunks->vchunks);
+	if (num_vec_ids < v_actual) {
+		err = -EINVAL;
+		goto free_vecids;
 	}
 
 	for (vector = 0; vector < v_actual; vector++) {
-- 
2.42.0


