Return-Path: <netdev+bounces-130647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B598B002
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949B41F21F97
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD51A2645;
	Mon, 30 Sep 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cl4pFBxs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7E1A0BF1
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735775; cv=none; b=IhyLJUyIFItSG9GvwaqGRKRlZYUlIKt/A9ujstGDf/QV88/aAi3aODn/d8AHHF9GzmMVUEQLWY53qdNRENdtsjVm99JLr7r5jV9x410dZk2a1FK2YZatd7PSYBKQ3l/l03rZry26q7KSd1mF5XebS2+7ZeNlQg0mIKKWGjvybPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735775; c=relaxed/simple;
	bh=jTFrk3GXC6E7WD7EUPwBnIp9hXF7LXVwQkJv/eQOLAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA0GktuwjBQlSqiSDJx63NTctVdlQ1HhJhSJeshrx31cUKSlqJawWfjCIWWysjFFxAVjCQAIhBVdEx1JiqC2bV1V98y3z4e41eOqYoiO+HBeI2h+v4F5P4/X1stlyPrSWhk4MUmAPhUh7oBiPNyikBjVEHXbPHqGQXRZdNfZSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cl4pFBxs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735773; x=1759271773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTFrk3GXC6E7WD7EUPwBnIp9hXF7LXVwQkJv/eQOLAQ=;
  b=cl4pFBxso8ltn3a9Q/slAB+rvD4XK7+dAr0L8AeAolLz7PWGwv713vha
   VN7j1W7U1N8rmLZbWIa3LsDvxsoPZ9DqNxApcq46wndb0iZy5WZavm48m
   Es/w/q+eQa2WWIZRkwE4p7q6hdffNn/erX10pvVqFg/Tk69FpsbjRqypA
   6n1b+UwdpfvwqQic8ReC1eXHl+5XdzbSeiZ4YTjkrQCyws9RR+0rdS6a1
   brCciGBd3AnMl2BlA3cVbcFRtcU5WyoHd3QWBnJAO3xDXxBpy+AkQ6Ddr
   xKX5Qi4InYuRen7H9s36aQx8e7As9vFpbaLzqvHcSOqgUFC9oRdnUgWIJ
   g==;
X-CSE-ConnectionGUID: Apt+F6Z9Tj6gck+eVmP0+Q==
X-CSE-MsgGUID: 9569TSv/RGmTOxttMw3imQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734905"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:07 -0700
X-CSE-ConnectionGUID: seVfIK18T/2zDG8ShsRriw==
X-CSE-MsgGUID: usYCBkK/RgqQo76Wc6zU+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496639"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 10/10] idpf: deinit virtchnl transaction manager after vport and vectors
Date: Mon, 30 Sep 2024 15:35:57 -0700
Message-ID: <20240930223601.3137464-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

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
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3c0f97650d72..15c00a01f1c0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3081,9 +3081,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
+	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.42.0


