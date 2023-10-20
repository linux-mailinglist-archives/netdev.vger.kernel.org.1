Return-Path: <netdev+bounces-43081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537B7D1540
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D061C20B28
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B69208BB;
	Fri, 20 Oct 2023 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtYL1jP+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEB208A6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:56:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F367D51
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697824570; x=1729360570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3xvzO1I/7D7XokUIhjcDmi5gd8LjFo+Y2LYucZAzno=;
  b=VtYL1jP+meDGkSuWqJW80GwcmZDX3ZJkjLKtp2ILXy8rwRS9nCcRsN/O
   erA1Ymksy/c+MYyJxJ0jqtbOBeXNOfAIdx9ELchk7Ok6rW7k+KipG/zVw
   dn/fTSG9OqzwtD++Oa2MtP736thtMW7J9W3YQhnh9bLwuACXFaiDw6zzf
   RMQBzZ+Lq3QEW1Q5DN4zJzzeRZUxDFF8KlHgtf0NRroBanwgE1DsedxD6
   rgVyQB5ijGms+D9WOZowFRvHTmg/Dnr+swSGRxbSDwN1uUO0hMGtaeB5E
   EqzziPOCC5hDhFb6FSJ8NWtY5e+86hlpH8lc2Ju+ATo2L5Yb+PcYDh1P1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="386357492"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="386357492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="750997540"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="750997540"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:56:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH next 2/2] idpf: cancel mailbox work in error path
Date: Fri, 20 Oct 2023 10:56:00 -0700
Message-ID: <20231020175600.24412-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020175600.24412-1-jacob.e.keller@intel.com>
References: <20231020175600.24412-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

In idpf_vc_core_init, the mailbox work is queued
on a mailbox workqueue but it is not cancelled on error.
This results in a call trace when idpf_mbx_task tries
to access the freed mailbox queue pointer. Fix it by
cancelling the mailbox work in the error path.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e276b5360c2e..2c1b051fdc0d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3146,6 +3146,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 
 err_intr_req:
 	cancel_delayed_work_sync(&adapter->serv_task);
+	cancel_delayed_work_sync(&adapter->mbx_task);
 	idpf_vport_params_buf_rel(adapter);
 err_netdev_alloc:
 	kfree(adapter->vports);
-- 
2.41.0


