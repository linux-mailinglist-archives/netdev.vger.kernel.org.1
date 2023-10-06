Return-Path: <netdev+bounces-38549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17E7BB611
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A21C209A2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320191C2AF;
	Fri,  6 Oct 2023 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLoyqbf7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532E125B7
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:12:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80260DE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696590765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zdojGdWffE+9Cjf10X0GBcdJQoHBIFt/nxLMEOIXvf4=;
	b=TLoyqbf7kU9OMCImwX9400DK64zDwLljX032QgbZfrKiUO3q85dBOL9NZB/wTYj7utIn6P
	036wb6XpW+l4UDppfj8mcMwXKtSmF6kRcHyMDipEOvCGLgkGlSmdlWUXRCPMBmQCGH2Y2k
	hEdGiAVaS/5ELgHY6s/FFkYrorDn8Cw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-cq16Oen1MAqn3zhjzEFw0w-1; Fri, 06 Oct 2023 07:12:27 -0400
X-MC-Unique: cq16Oen1MAqn3zhjzEFw0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F410E3C11C64;
	Fri,  6 Oct 2023 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEE42027045;
	Fri,  6 Oct 2023 11:12:25 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net] i40e: prevent crash on probe if hw registers have invalid values
Date: Fri,  6 Oct 2023 13:11:39 +0200
Message-ID: <20231006111139.1560132-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


