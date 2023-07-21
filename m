Return-Path: <netdev+bounces-19919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C505A75CD25
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021CE1C216E8
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA01F957;
	Fri, 21 Jul 2023 16:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D61ED4B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:06:40 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527762D47
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689955598; x=1721491598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oTVzimK/uNJTPfPh+FNQH17HOpcu1FYXfqjzbHUjYZk=;
  b=OcIxBNnl9y0owTCdPgQAYKgz2RNQhY/LUJzaCDyV37Hh7gd0q1Vix30S
   sFgtapvK/iH9Y+tvad+lLoFBJgeUVlKupyAourzwPY3Z8nopuTsT1proF
   XLRKCcEAkGFsteMGBc9fp83BmVbQjYsh6/DmI434A2wFdhlJ9RmQKws0H
   +B6DI/gOxujc/Y1OWpTpSXCj5sPkO2hBcLD9E/gdqNHZr+Z1dNMMUy0jD
   ecjQxN2vvO+o4MkBRAZLBwnb4QrsrbBeEAYBMCX3tIpIKsIwtzLObtLKm
   22mjEr2h2DodslehMZwhydY861YpHfKk0aeZMB8C1V1C897mv5x/rDqV/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357047109"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357047109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868279412"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 09:04:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/3] iavf: fix potential deadlock on allocation failure
Date: Fri, 21 Jul 2023 08:58:11 -0700
Message-Id: <20230721155812.1292752-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
References: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

In iavf_adminq_task(), if kzalloc() fails to allocate the event.msg_buf,
the function will exit without releasing the adapter->crit_lock.

This is unlikely, but if it happens, the next access to that mutex will
deadlock.

Fix this by moving the unlock to the end of the function, and adding a new
label to allow jumping to the unlock portion of the function exit flow.

Fixes: fc2e6b3b132a ("iavf: Rework mutexes for better synchronisation")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3a88d413ddee..939c8126eb43 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3264,7 +3264,7 @@ static void iavf_adminq_task(struct work_struct *work)
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf)
-		goto out;
+		goto unlock;
 
 	do {
 		ret = iavf_clean_arq_element(hw, &event, &pending);
@@ -3279,7 +3279,6 @@ static void iavf_adminq_task(struct work_struct *work)
 		if (pending != 0)
 			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
 	} while (pending);
-	mutex_unlock(&adapter->crit_lock);
 
 	if (iavf_is_reset_in_progress(adapter))
 		goto freedom;
@@ -3323,6 +3322,8 @@ static void iavf_adminq_task(struct work_struct *work)
 
 freedom:
 	kfree(event.msg_buf);
+unlock:
+	mutex_unlock(&adapter->crit_lock);
 out:
 	/* re-enable Admin queue interrupt cause */
 	iavf_misc_irq_enable(adapter);
-- 
2.38.1


