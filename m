Return-Path: <netdev+bounces-25017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CCA772A01
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40BF28146E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E9111AC;
	Mon,  7 Aug 2023 16:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E911C8B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:01:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495BAE72
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691424103; x=1722960103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZaID7aLwkl9LbkHjZUcJBGMU6NP2yhhd2YR+WdtQz0w=;
  b=D3aTwkKjPck4KQhFVQiFJZtrdstXvndPW0tAIbMJ3coUIMRSe6lZpZXr
   snw/2q02nhkDu1cVcJmUpk2SKWVsNtXkTbjVO9fhhqcigI31LToYGXEDF
   bUgmjlFsega61xp+AHg88q+YZYOX/nSd6SbDwShi/xsdT5A4Jr9IE+7gu
   IhRHexZXWP/mYqg8FxS1xhu1lYx/ztNI33QNYXZ/CFobLDf3bsKd2RZ6X
   JeUMP20rOLOhHjGRWvio0nkIOj32hajF+bnP/zPnS0NZ3oyRfJULAxVoy
   OHT3lBDKgc+GcNuTX/kNFm9gK2x80/7j+0RAZyUc0EBcPP9oWpvoze4+y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401553924"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="401553924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 09:01:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977492980"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="977492980"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2023 09:01:40 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C9875312D4;
	Mon,  7 Aug 2023 17:01:39 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 1/3] ice: ice_aq_check_events: fix off-by-one check when filling buffer
Date: Mon,  7 Aug 2023 11:58:46 -0400
Message-Id: <20230807155848.90907-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
References: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow task's event buffer to be filled also in the case that it's size
is exactly the size of the message.

Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a73895483e6c..f2ad2153589a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1357,7 +1357,9 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 				struct ice_rq_event_info *event)
 {
+	struct ice_rq_event_info *task_ev;
 	struct ice_aq_task *task;
+
 	bool found = false;
 
 	spin_lock_bh(&pf->aq_wait_lock);
@@ -1365,15 +1367,15 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 		if (task->state || task->opcode != opcode)
 			continue;
 
-		memcpy(&task->event->desc, &event->desc, sizeof(event->desc));
-		task->event->msg_len = event->msg_len;
+		task_ev = task->event;
+		memcpy(&task_ev->desc, &event->desc, sizeof(event->desc));
+		task_ev->msg_len = event->msg_len;
 
 		/* Only copy the data buffer if a destination was set */
-		if (task->event->msg_buf &&
-		    task->event->buf_len > event->buf_len) {
-			memcpy(task->event->msg_buf, event->msg_buf,
+		if (task_ev->msg_buf && task_ev->buf_len >= event->buf_len) {
+			memcpy(task_ev->msg_buf, event->msg_buf,
 			       event->buf_len);
-			task->event->buf_len = event->buf_len;
+			task_ev->buf_len = event->buf_len;
 		}
 
 		task->state = ICE_AQ_TASK_COMPLETE;
-- 
2.40.1


