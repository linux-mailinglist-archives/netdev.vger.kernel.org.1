Return-Path: <netdev+bounces-124973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64F96B780
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523BEB21586
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B631A42D2;
	Wed,  4 Sep 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4pfLUo3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D91CCEE9;
	Wed,  4 Sep 2024 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443687; cv=none; b=PMceOPdj1t8kpMhA2r4bN3y8SwT/gpocqCPV4JJwusoYEJK36GUXAoRR8Whvjc6aQfdIoVLTkyQgX6zoDRvIdBGg6pNo/jbTdsq0/c+QQXZ8+GnvSGAb7Td6d7mMe3E7nF+t6TpG6+SQoWw7nj9YUVN7Pbo5D8NaeUkxSl3uOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443687; c=relaxed/simple;
	bh=A8jBBEU4JmlCS2iIUWpGULpUfjnILI4ZQFsy022HtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/Ebavk3h5hxJD9f2tWDK2nlOI9Kqafc+SWqeu5uBeBNiL4wyxLFaBnz+sW3TpWDA5x2fVrAQksxqaoO+UqCSd6gTSOHBfW17V9e62ovaMP3ZUcnddKOYgIMF0A1ed4R5dl4SEsC2YjnHRK8BKpWQjEs/Pm+c51zqqAdqAN4v2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4pfLUo3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725443685; x=1756979685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A8jBBEU4JmlCS2iIUWpGULpUfjnILI4ZQFsy022HtJM=;
  b=T4pfLUo3lEc3LqO4/rgnpu43xjvyO+zaLIvWh/pPD2GXBJepWHv38HMw
   xlJl8uzwkUFNRol7CnxPkm0f+NKnuMw1beE7A/svPdhuzZFCGVVWcFcpk
   ao5MLxcQ6v8uoK+hf6bIB1FApK1eMYS5jY1u9HPKkhYptZe6QjQtkfDDM
   W6No0af0v1UVZeCMcURNbFtoXiKYKyzHpTAtgtP0CaZ26tyuBrKc0gRdV
   wqJRGXKIv0yz9mBThOvaPvjId/Z7DjjzfH0KavsdzrRSKhkyZF7RwXJyU
   cGnDH2eL/tJhyi3H6HV9f/23+3gI+q5NlKpr8tUOHJTux+y+B+aElHHZY
   g==;
X-CSE-ConnectionGUID: FnigzqCTRQyBcWxzZ2a11Q==
X-CSE-MsgGUID: W07t5m9oR0eP2QgC0BzPPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34664469"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="34664469"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:54:44 -0700
X-CSE-ConnectionGUID: YwwdvXlxSQu8VWPsqwJ44Q==
X-CSE-MsgGUID: 2cjHcJE3RoOhPTSsDAyR3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69618113"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 04 Sep 2024 02:54:41 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D6B0427BD9;
	Wed,  4 Sep 2024 10:54:39 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] idpf: deinit virtchnl transaction manager after vport and vectors
Date: Wed,  4 Sep 2024 11:54:17 +0200
Message-ID: <20240904095418.6426-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device is removed, idpf is supposed to make certain virtchnl
requests e.g. VIRTCHNL2_OP_DEALLOC_VECTORS and VIRTCHNL2_OP_DESTROY_VPORT.

However, this does not happen due to the referenced commit introducing
virtchnl transaction manager and placing its deinitialization before those
messages are sent. Then the sending is impossible due to no transactions
being available.

Lack of cleanup can lead to the FW becoming unresponsive from e.g.
unloading-loading the driver and creating-destroying VFs afterwards.

Move transaction manager deinitialization to after other virtchnl-related
cleanup is done.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a5f9b7a5effe..f18f490dafd8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3040,9 +3040,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
+	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.45.0


