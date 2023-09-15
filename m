Return-Path: <netdev+bounces-34139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18707A246A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E62822C6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96A15EB3;
	Fri, 15 Sep 2023 17:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E215E98
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:14:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3110C7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694798048; x=1726334048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJuMMTWD/OOMRf6vSCknzHxOcLpGh2wPARSmI7yNsqY=;
  b=INg3z1UeeY4DnubS5yqPdH6j24tvdPLPZYXJE0AyP2N0M2slgdM/I5Fn
   FlKKfBx4KO1FQTD5iksX2zBFkDp0KTwODv9d8c6AxYPfwqC0vFLt+nIbj
   K3FYtkerWlr3LVXxoGQGh4HkAd19vGcxchca3Jia5WNDZSZC7xQGq4FJy
   oEAwxAH5HsrCaJ/jcRu0VypAfxSMtVtmlSnMcO/nQtpU1I1xqMdbpzEXG
   dC1fszQwcwoU492uBi2S7IE3qAc9HRWoe+Z61cH0yHmvQeaRKgUahzJmr
   SZTGiJB+KneF6VAMPIMlsN+trz8O7yVUlZkDv/bnm9945CmB0VTtezEtY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383132336"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383132336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="860244198"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="860244198"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2023 10:12:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/4] iavf: schedule a request immediately after add/delete vlan
Date: Fri, 15 Sep 2023 10:11:38 -0700
Message-Id: <20230915171139.3822904-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915171139.3822904-1-anthony.l.nguyen@intel.com>
References: <20230915171139.3822904-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Petr Oros <poros@redhat.com>

When the iavf driver wants to reconfigure the VLAN filters
(iavf_add_vlan, iavf_del_vlan), it sets a flag in
aq_required:
  adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
or:
  adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;

This is later processed by the watchdog_task, but it runs periodically
every 2 seconds, so it can be a long time before it processes the request.

In the worst case, the interface is unable to receive traffic for more
than 2 seconds for no objective reason.

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Petr Oros <poros@redhat.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4b02a8cd77e9..6a2e6d64bc3a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -821,7 +821,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		list_add_tail(&f->list, &adapter->vlan_filter_list);
 		f->state = IAVF_VLAN_ADD;
 		adapter->num_vlan_filters++;
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
@@ -843,7 +843,7 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
 		f->state = IAVF_VLAN_REMOVE;
-		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_VLAN_FILTER);
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.38.1


