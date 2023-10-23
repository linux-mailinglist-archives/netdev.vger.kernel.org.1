Return-Path: <netdev+bounces-43670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C597D430C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5E2817BB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFE2420F;
	Mon, 23 Oct 2023 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlf1r1EW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B260241ED
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18201D73
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102514; x=1729638514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hg/Un95h4KjqxNSkaGmdSN+G4PoVMmwPKFCQmqNQUXE=;
  b=nlf1r1EWjRQ6Tkhz01Fepr+oMuNF+SjgF7Kwt2N3RVLripza+S7lljz6
   07JhVFW1H81RhzwWrRsOHbXsrivbdFRAys+XwcDxH8XmhYhFy/MDfr7hS
   cwPFeHtik2b3AZYTefwdiApuhYP3038Sw4P0xa46dKZn7UmEGM6LZ9lFK
   GhKonvcdT6eYxwnfVfVyieB4WtQt8k1y4P0I+lBKOe1dIj2oGxBKDoAzH
   GDkyVR/t6zgnNGMdfHa+tlbEkLLF+kPQYlDsPQRhVBz3NOQJWzD/pQ4oK
   F7aIGAI+/cy4sncyrwR/Uiryu2uExBAPiLp3SajUbgJDJptzVUfUf9ZA1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573705"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573705"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288326"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288326"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 3/9] iavf: in iavf_down, don't queue watchdog_task if comms failed
Date: Mon, 23 Oct 2023 16:08:20 -0700
Message-ID: <20231023230826.531858-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023230826.531858-1-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

The reason for queueing watchdog_task is to have it process the
aq_required flags that are being set here. If comms failed, there's
nothing to do, so return early.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index da9cd53afc24..b30d703e26a1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1420,8 +1420,10 @@ void iavf_down(struct iavf_adapter *adapter)
 	iavf_clear_fdir_filters(adapter);
 	iavf_clear_adv_rss_conf(adapter);
 
-	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) &&
-	    !(test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))) {
+	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
+		return;
+
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
 		/* cancel any current operation */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		/* Schedule operations to close down the HW. Don't wait
-- 
2.41.0


