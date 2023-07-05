Return-Path: <netdev+bounces-15651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4A748EE7
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF31C20BEB
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201FD15AC7;
	Wed,  5 Jul 2023 20:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4015AF6
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:24:48 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B662198B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588686; x=1720124686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BdRcGuXYsGzQLDGNxDcP+aU5Y0uMT2vl+4OKEa9nE2g=;
  b=jAsnxamuHpO6pzgGVmLCA0YgJ4VMBCqZ/x55chCuo1ARdF0efR1y5VZw
   GZjJI+VvHZAm7EiVvvhzE6KeC0fdZSUuU8kDxfowuFwBlbZcL8k2Z5a0I
   CyJUO6sYjc4D0SVMZ7wC6pR2esoCf7E1skGLO+x5l28+5d5vbfn92wh+y
   cu1inHvBfko4CeCUX8PJVX86K0vgSMJ0R3/1MWapgataJ9HTt2wS8f5jp
   +Fv0LpaFYt1bFGtaOQpH1A3TYRHUTqrGafgQsLhQ7UB1PRXd2gIHiDqsg
   zXfzQHKQ/wikQt04MMuXrTapOXzLZav2xH5U4boSxCBPGwf3hXMjoKeZ0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362303256"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="362303256"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809380450"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="809380450"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 13:24:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	christopher.s.hall@intel.com,
	richardcochran@gmail.com,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 6/6] igc: Handle PPS start time programming for past time values
Date: Wed,  5 Jul 2023 13:19:05 -0700
Message-Id: <20230705201905.49570-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>

I225/6 hardware can be programmed to start PPS output once
the time in Target Time registers is reached. The time
programmed in these registers should always be into future.
Only then PPS output is triggered when SYSTIM register
reaches the programmed value. There are two modes in i225/6
hardware to program PPS, pulse and clock mode.

There were issues reported where PPS is not generated when
start time is in past.

Example 1, "echo 0 0 0 2 0 > /sys/class/ptp/ptp0/period"

In the current implementation, a value of '0' is programmed
into Target time registers and PPS output is in pulse mode.
Eventually an interrupt which is triggered upon SYSTIM
register reaching Target time is not fired. Thus no PPS
output is generated.

Example 2, "echo 0 0 0 1 0 > /sys/class/ptp/ptp0/period"

Above case, a value of '0' is programmed into Target time
registers and PPS output is in clock mode. Here, HW tries to
catch-up the current time by incrementing Target Time
register. This catch-up time seem to vary according to
programmed PPS period time as per the HW design. In my
experiments, the delay ranged between few tens of seconds to
few minutes. The PPS output is only generated after the
Target time register reaches current time.

In my experiments, I also observed PPS stopped working with
below test and could not recover until module is removed and
loaded again.

1) echo 0 <future time> 0 1 0 > /sys/class/ptp/ptp1/period
2) echo 0 0 0 1 0 > /sys/class/ptp/ptp1/period
3) echo 0 0 0 1 0 > /sys/class/ptp/ptp1/period

After this PPS did not work even if i re-program with proper
values. I could only get this back working by reloading the
driver.

This patch takes care of calculating and programming
appropriate future time value into Target Time registers.

Fixes: 5e91c72e560c ("igc: Fix PPS delta between two synchronized end-points")
Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 32ef112f8291..f0b979a70655 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -356,16 +356,35 @@ static int igc_ptp_feature_enable_i225(struct ptp_clock_info *ptp,
 			tsim &= ~IGC_TSICR_TT0;
 		}
 		if (on) {
+			struct timespec64 safe_start;
 			int i = rq->perout.index;
 
 			igc_pin_perout(igc, i, pin, use_freq);
-			igc->perout[i].start.tv_sec = rq->perout.start.sec;
+			igc_ptp_read(igc, &safe_start);
+
+			/* PPS output start time is triggered by Target time(TT)
+			 * register. Programming any past time value into TT
+			 * register will cause PPS to never start. Need to make
+			 * sure we program the TT register a time ahead in
+			 * future. There isn't a stringent need to fire PPS out
+			 * right away. Adding +2 seconds should take care of
+			 * corner cases. Let's say if the SYSTIML is close to
+			 * wrap up and the timer keeps ticking as we program the
+			 * register, adding +2seconds is safe bet.
+			 */
+			safe_start.tv_sec += 2;
+
+			if (rq->perout.start.sec < safe_start.tv_sec)
+				igc->perout[i].start.tv_sec = safe_start.tv_sec;
+			else
+				igc->perout[i].start.tv_sec = rq->perout.start.sec;
 			igc->perout[i].start.tv_nsec = rq->perout.start.nsec;
 			igc->perout[i].period.tv_sec = ts.tv_sec;
 			igc->perout[i].period.tv_nsec = ts.tv_nsec;
-			wr32(trgttimh, rq->perout.start.sec);
+			wr32(trgttimh, (u32)igc->perout[i].start.tv_sec);
 			/* For now, always select timer 0 as source. */
-			wr32(trgttiml, rq->perout.start.nsec | IGC_TT_IO_TIMER_SEL_SYSTIM0);
+			wr32(trgttiml, (u32)(igc->perout[i].start.tv_nsec |
+					     IGC_TT_IO_TIMER_SEL_SYSTIM0));
 			if (use_freq)
 				wr32(freqout, ns);
 			tsauxc |= tsauxc_mask;
-- 
2.38.1


