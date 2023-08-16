Return-Path: <netdev+bounces-28222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31C77EB24
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAACF281C39
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09F1BF03;
	Wed, 16 Aug 2023 20:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DD1BEFD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83716270A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219276; x=1723755276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kRCz1wgg5LpVr63RWYjUqVhQrJjf9ztmo7RfdYJVck=;
  b=Oz1JiqzYZXfxXuxb4CRD1q7P9XmZfHo8+yuLrpeM5KMZHB4lyTXPohSK
   5g3wQmbJoi5LLtR4OJZds5cL4rTWpNSVoFouGSELO3uQItMvgbQEPX7Ge
   mx/R6qkCxIC4gbge9myzIZMcAx7PX4wyGgL+4x1Q85klbAN7U0iLSRuGx
   CN0oEZe3KSvUQ5fWekeEieIP2uYRGhfMr9YILIhO4zaz/2Up51Y6wne3I
   KNSBbvrz3zjC822JT21dbU/LIlpHo+S2+i8iAAwxg7POnP9lzxEMInWah
   u9aO4GfnrHW5InvozVuY0puSiErkofsGR7G6b5QE7Kg5gMIsAsbxFIcKq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604821"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626409"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626409"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 12/14] ice: ice_aq_check_events: fix off-by-one check when filling buffer
Date: Wed, 16 Aug 2023 13:47:34 -0700
Message-Id: <20230816204736.1325132-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Allow task's event buffer to be filled also in the case that it's size
is exactly the size of the message.

Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0f04347eda39..872bd5572294 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1357,6 +1357,7 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 				struct ice_rq_event_info *event)
 {
+	struct ice_rq_event_info *task_ev;
 	struct ice_aq_task *task;
 	bool found = false;
 
@@ -1365,15 +1366,15 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
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
2.38.1


