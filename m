Return-Path: <netdev+bounces-13160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE373A863
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6FA280A74
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF75206BB;
	Thu, 22 Jun 2023 18:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022A206B8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:41:09 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D0311C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459268; x=1718995268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpfvINukSjyp3pCiZwY24xfUK+sP03QZwWfe8/SOYnU=;
  b=dukFRLg2LbOI3zWGG6wXJwuWAAF1HVp81Sp7BjbwewvOfvJ22O/B87wS
   fSAYds9CRrnji7uYUYIRSDKoSQFeJPLoXL7nHEU0RlYMi2SAtkZfJE8ab
   fYJtLvuTdF/ywPU/Fpj8J6QO6pCjQBIl/hi4uF49PI8LEPkv8OK0pqS4y
   6KGqibtCTPbUvqQvCX9lpbxBzWORl8zEOZCH/RHUiq4UFsDp6rtrts8P4
   ptpvDScYn0Wo3IfP8MmHsempODxE27GM0+NUeLWrv/ldkzNfC0yDeVNHQ
   HE588XPvFaHFwGRAece38WCCOTOEYLz6pqjKGLKEaSIRpQ8s01NGPt3Ha
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340917787"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340917787"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961687015"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961687015"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 11:41:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 3/6] ice: clean up freeing SR-IOV VFs
Date: Thu, 22 Jun 2023 11:35:58 -0700
Message-Id: <20230622183601.2406499-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

The check for existing VFs was redundant since very
inception of SR-IOV sysfs interface in the kernel,
see commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs").

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 2ea6d24977a6..1f66914c7a20 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -905,14 +905,13 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
  */
 static int ice_pci_sriov_ena(struct ice_pf *pf, int num_vfs)
 {
-	int pre_existing_vfs = pci_num_vf(pf->pdev);
 	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
-	if (pre_existing_vfs && pre_existing_vfs != num_vfs)
+	if (!num_vfs) {
 		ice_free_vfs(pf);
-	else if (pre_existing_vfs && pre_existing_vfs == num_vfs)
 		return 0;
+	}
 
 	if (num_vfs > pf->vfs.num_supported) {
 		dev_err(dev, "Can't enable %d VFs, max VFs supported is %d\n",
-- 
2.38.1


