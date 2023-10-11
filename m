Return-Path: <netdev+bounces-40184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A77C6123
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6558282739
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5A2B75C;
	Wed, 11 Oct 2023 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMXCXzRR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174C2B74E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:33:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2FA9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697067228; x=1728603228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwxuWhk/VcZXZGTwlxdMH4oYJGSOcB0LdUFkcvXEoCI=;
  b=hMXCXzRRDVRCEn8G61DV85JdVvqJGbXZJf2MlwdDJP0ChbyY9jodC4j6
   HQstetraszeJPzMXXJEZGAvuQ9FuPilqTTGt7b0zmFz0MUg47Oz0IrEjd
   bkzwIoN1LJzXeWfAUOS3WCKzU/kMaiFYI1IJ9GZulHuRYruCIY/L5AZqO
   mmEB/WE/wFb0aWWV1vLVb8h7T1rek2rmLxk4sRWviBMwQeRIUOGcha7mZ
   P0LqFl1cZ7Q73H7AwDFg0HnfCdmSEIHidVr0akH1R3/ZcUOybu+JR6gbE
   ZTb336nDrxznMVKPzFnMWP0VmKM/0a6OJP+AyhB5TAMiLydsspTRBuYU2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388652586"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="388652586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824359287"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="824359287"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/3] i40e: prevent crash on probe if hw registers have invalid values
Date: Wed, 11 Oct 2023 16:33:32 -0700
Message-ID: <20231011233334.336092-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011233334.336092-1-jacob.e.keller@intel.com>
References: <20231011233334.336092-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Schmidt <mschmidt@redhat.com>

The hardware provides the indexes of the first and the last available
queue and VF. From the indexes, the driver calculates the numbers of
queues and VFs. In theory, a faulty device might say the last index is
smaller than the first index. In that case, the driver's calculation
would underflow, it would attempt to write to non-existent registers
outside of the ioremapped range and crash.

I ran into this not by having a faulty device, but by an operator error.
I accidentally ran a QE test meant for i40e devices on an ice device.
The test used 'echo i40e > /sys/...ice PCI device.../driver_override',
bound the driver to the device and crashed in one of the wr32 calls in
i40e_clear_hw.

Add checks to prevent underflows in the calculations of num_queues and
num_vfs. With this fix, the wrong device probing reports errors and
returns a failure without crashing.

Fixes: 838d41d92a90 ("i40e: clear all queues and interrupts")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index eeef20f77106..1b493854f522 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1082,7 +1082,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 		     I40E_PFLAN_QALLOC_FIRSTQ_SHIFT;
 	j = (val & I40E_PFLAN_QALLOC_LASTQ_MASK) >>
 	    I40E_PFLAN_QALLOC_LASTQ_SHIFT;
-	if (val & I40E_PFLAN_QALLOC_VALID_MASK)
+	if (val & I40E_PFLAN_QALLOC_VALID_MASK && j >= base_queue)
 		num_queues = (j - base_queue) + 1;
 	else
 		num_queues = 0;
@@ -1092,7 +1092,7 @@ void i40e_clear_hw(struct i40e_hw *hw)
 	    I40E_PF_VT_PFALLOC_FIRSTVF_SHIFT;
 	j = (val & I40E_PF_VT_PFALLOC_LASTVF_MASK) >>
 	    I40E_PF_VT_PFALLOC_LASTVF_SHIFT;
-	if (val & I40E_PF_VT_PFALLOC_VALID_MASK)
+	if (val & I40E_PF_VT_PFALLOC_VALID_MASK && j >= i)
 		num_vfs = (j - i) + 1;
 	else
 		num_vfs = 0;
-- 
2.41.0


