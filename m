Return-Path: <netdev+bounces-43637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D67D40E0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826D6B20E99
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CD23752;
	Mon, 23 Oct 2023 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyGHB2rc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6122F10
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 20:27:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB5D78
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698092827; x=1729628827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=giXe07yhQ/sA6YwiclzNcgpKVmIa2fDymw1MBooMNiw=;
  b=DyGHB2rczQjcqmnVx9Pj7zwjqQCch5mBD3pQUknfPkqMb2DEVsouYH/6
   Qg1KsoYFGt3bGfnnPJQ9YJYPW4nPRPkFjnF8LbPfYFF/l7ay0FXEwoC5Q
   klqQDLsQTE6XzP9sd/Ugcyq9zju/h4/ryRZxgTr1G5MWjkXLxt5pmo5eb
   YnqSHZlnVWQZ7i6AihWjlwHMjuTa6xxn+Qzl9fCfBKj0SwQexVR/QGyby
   kw8NJbx2lfE4G0nZ5gVwBRAYngbhjWgmoaw/bQSxIuFhBeZ3c398Wk2AC
   2v4x/LxZ7w8K4vkjRaR4CpUZmvkvm3qImjml0o0KcxkJAn3kcu9YZIF5t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386732581"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386732581"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="874813971"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="874813971"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:27:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 2/2] idpf: cancel mailbox work in error path
Date: Mon, 23 Oct 2023 13:26:55 -0700
Message-ID: <20231023202655.173369-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023202655.173369-1-jacob.e.keller@intel.com>
References: <20231023202655.173369-1-jacob.e.keller@intel.com>
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
Changes since v1:
* corrected subject line

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


