Return-Path: <netdev+bounces-13158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B073A85F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6921C211AF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE32069B;
	Thu, 22 Jun 2023 18:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527331E536
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:41:08 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430D11C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459267; x=1718995267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wVfcEfnuYAudal/gnqxjdeYMNr35Vt83HkP6i9ONdGc=;
  b=gdaTCXRXUgpF2NjShPi14s64W6afGq5X4fQG/cGeCuVhteRkKsBRmPW1
   vZlV4704TEAALHK1A3JRcF3D2Kjvw+4Ap9HmzW6Sp+ocuMDydC2cnzNnZ
   UxuKQVB7o/8//nDTVIuv1+zA7SUdMq3tNNizHCSujgCnyBA4PsUx1vi2F
   9m/jwtw06rOiRjkWeLuSH9Jr5ijQXfvOrvFlsv62Sv/TqaCa1rjxFpYxM
   pOYJUfIle39/1q1RC5Go1Xkk5ntgo7bLmbhe9qirE6SNO5Kz8m9HIgUSt
   I7uayX8tQA0Jq5GnCNg2AmXGPmpImPj1QpzKOufMjLOKyZmcv/FMDXpVp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340917771"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340917771"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961686982"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961686982"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 11:41:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/6] ice: reduce initial wait for control queue messages
Date: Thu, 22 Jun 2023 11:35:56 -0700
Message-Id: <20230622183601.2406499-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_sq_send_cmd() function is used to send messages to the control
queues used to communicate with firmware, virtual functions, and even some
hardware.

When sending a control queue message, the driver is designed to
synchronously wait for a response from the queue. Currently it waits
between checks for 100 to 150 microseconds.

Commit f86d6f9c49f6 ("ice: sleep, don't busy-wait, for
ICE_CTL_Q_SQ_CMD_TIMEOUT") did recently change the behavior from an
unnecessary delay into a sleep which is a significant improvement over the
old behavior of polling using udelay.

Because of the nature of PCIe transactions, the hardware won't be informed
about a new message until the write to the tail register posts. This is
only guaranteed to occur at the next register read. In ice_sq_send_cmd(),
this happens at the ice_sq_done() call. Because of this, the driver
essentially forces a minimum of one full wait time regardless of how fast
the response is.

For the hardware-based sideband queue, this is especially slow. It is
expected that the hardware will respond within 2 or 3 microseconds, an
order of magnitude faster than the 100-150 microsecond sleep.

Allow such fast completions to occur without delay by introducing a small 5
microsecond delay first before entering the sleeping timeout loop. Ensure
the tail write has been posted by using ice_flush(hw) first.

While at it, lets also remove the ICE_CTL_Q_SQ_CMD_USEC macro as it
obscures the sleep time in the inner loop. It was likely introduced to
avoid "magic numbers", but in practice sleep and delay values are easier to
read and understand when using actual numbers instead of a named constant.

This change should allow the fast hardware based control queue messages to
complete quickly without delay, while slower firmware queue response times
will sleep while waiting for the response.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 9 +++++++--
 drivers/net/ethernet/intel/ice/ice_controlq.h | 1 -
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index d2faf1baad2f..385fd88831db 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1056,14 +1056,19 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	if (cq->sq.next_to_use == cq->sq.count)
 		cq->sq.next_to_use = 0;
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
+	ice_flush(hw);
+
+	/* Wait a short time before initial ice_sq_done() check, to allow
+	 * hardware time for completion.
+	 */
+	udelay(5);
 
 	timeout = jiffies + ICE_CTL_Q_SQ_CMD_TIMEOUT;
 	do {
 		if (ice_sq_done(hw, cq))
 			break;
 
-		usleep_range(ICE_CTL_Q_SQ_CMD_USEC,
-			     ICE_CTL_Q_SQ_CMD_USEC * 3 / 2);
+		usleep_range(100, 150);
 	} while (time_before(jiffies, timeout));
 
 	/* if ready, copy the desc back to temp */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 950b7f4a7a05..8f2fd1613a95 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -35,7 +35,6 @@ enum ice_ctl_q {
 
 /* Control Queue timeout settings - max delay 1s */
 #define ICE_CTL_Q_SQ_CMD_TIMEOUT	HZ    /* Wait max 1s */
-#define ICE_CTL_Q_SQ_CMD_USEC		100   /* Check every 100usec */
 #define ICE_CTL_Q_ADMIN_INIT_TIMEOUT	10    /* Count 10 times */
 #define ICE_CTL_Q_ADMIN_INIT_MSEC	100   /* Check every 100msec */
 
-- 
2.38.1


