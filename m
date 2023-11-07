Return-Path: <netdev+bounces-46303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B697E3249
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CB61C209A4
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6D385;
	Tue,  7 Nov 2023 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSW+OyWj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BFC8CA
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:36:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3BD57
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317367; x=1730853367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRi3hAFYf9aFMY2tuKtuxoGpCjQfXdXqSoV1wHxpNM0=;
  b=nSW+OyWjtp5SQIkKZ7nljqixMVp2ghKv+ZmatK3N+XOW7U4pvXGXjUjr
   HwR78TbIX6HdfWAjEyDuck4fghAi3/WES22YvRsmg2xF+xTQIOy4d/ITU
   dsH6gUD8WVadqq1AtR6LtJnyQ3I+oSfQHjOxxllv95XiofaQ1vFVp1fIH
   jt1M6+jC8kAzTTYNH/cxAjtCRRRSR+x/oS+wznukHcX5cJT9y5jr7uOoz
   /cdjtU2pUJo9MGpio/HIFvib2Nidsh/ix5rUSmLpdKPLKso+F6VWpd586
   d8T4AcnRvagSjDP0NQ7FRrQbjdBq6xZJKyxsciFtSveRcdrnBJX2WryVI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420508351"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="420508351"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="756011256"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="756011256"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2023 16:36:06 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Jiri Pirko <jiri@nvidia.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/2] i40e: Do not call devlink_port_type_clear()
Date: Mon,  6 Nov 2023 16:35:58 -0800
Message-ID: <20231107003600.653796-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107003600.653796-1-anthony.l.nguyen@intel.com>
References: <20231107003600.653796-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Do not call devlink_port_type_clear() prior devlink port unregister
and let devlink core to take care about it.

Reproducer:
[root@host ~]# rmmod i40e
[ 4539.964699] i40e 0000:02:00.0: devlink port type for port 0 cleared without a software interface reference, device type not supported by the kernel?
[ 4540.319811] i40e 0000:02:00.1: devlink port type for port 1 cleared without a software interface reference, device type not supported by the kernel?

Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 74bc111b4849..cc4e9e2addb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -231,6 +231,5 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
  **/
 void i40e_devlink_destroy_port(struct i40e_pf *pf)
 {
-	devlink_port_type_clear(&pf->devlink_port);
 	devlink_port_unregister(&pf->devlink_port);
 }
-- 
2.41.0


