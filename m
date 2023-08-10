Return-Path: <netdev+bounces-26513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D9777FD1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5281C21488
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811422EF0;
	Thu, 10 Aug 2023 17:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80B22EEC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:59:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8510D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691690385; x=1723226385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXPIyMi0Coz+KLcaHtGbTo9WiY6OV+F9PiFwDWOV0Do=;
  b=BB+oYugJiW9nkEABtLyCpxXSkJSHz4ktD2o+nXJiCi8ezku8naonYVtl
   sCC71NGN6XivllASduw1DCdK/6HNKEDxksdJpHzTyYgWVhiGQ5WwPgi0M
   +ZgsmlJ2AV+sgdnVm2lut/8j6NqIMFiZOVnJRUgns5135YPVoYLribXcB
   shWQSg4yzVa3ZXcndKk3KvH5w51uYLoVzHveo5EpSNbIzaTzGdhwfVitJ
   UNysXkUCXwf89Fmsnh+8TeDu8dnVT6VSGQ0og2zxbFx5Cm2OUldpk/0sx
   0x7gwJqjpF/RFFZBs2sGjYpJwv0Za8CuAII/gngm971vXR8NumWb/ZSVO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437825468"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="437825468"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="725933343"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="725933343"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 10:59:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH net-next 2/4] i40e: Replace one-element array with flex-array member in struct i40e_profile_segment
Date: Thu, 10 Aug 2023 10:53:00 -0700
Message-Id: <20230810175302.1964182-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
References: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_profile_segment with flexible-array
member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 08ad83ee4a43..6cbc3dbf9b03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1486,7 +1486,7 @@ struct i40e_profile_segment {
 	struct i40e_ddp_version version;
 	char name[I40E_DDP_NAME_SIZE];
 	u32 device_table_count;
-	struct i40e_device_id_entry device_table[1];
+	struct i40e_device_id_entry device_table[];
 };
 
 struct i40e_section_table {
-- 
2.38.1


