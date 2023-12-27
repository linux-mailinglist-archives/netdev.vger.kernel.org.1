Return-Path: <netdev+bounces-60404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D281F12D
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3041E282577
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF684778B;
	Wed, 27 Dec 2023 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwKSiD3j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01F46B9F
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703701549; x=1735237549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoDJK90vBUT90LY5lV71c5KOTj1KS1nzQQWjDqiiCmM=;
  b=bwKSiD3j3Pey/lXzPS7jSK37zVG2Mx7We6Xs5GT7ezknp+4A1gGuBNNQ
   SWiFXQNO6eGhkfVlk3ArYUiJW5rkCoblZtFNsztB80BkU7W6opvK1geT3
   aznzUtEIDQ3Iq4Jk11qXSjR+gfqnBXiWW3ns0PB3tFCqcrH19KkHpNQ2F
   TaEjYmBDXcWdcci5L6GngsOMIOFJ3eJ70Mf4f8KRU5zoiPAyEP7KxiKPB
   HgWc57Lh5axnTQ+CfLsyteH53/58RMm1LaeL3zUtLT0+aEUsYPJBbu9Mn
   Wqlqol7mXswtr97HXdm8UiiIu98UmdbGVqD/5tuV69AOPtrcIIzoXGUO5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3312835"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3312835"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868921426"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="868921426"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2023 10:25:46 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/4] ice: dpll: fix phase offset value
Date: Wed, 27 Dec 2023 10:25:32 -0800
Message-ID: <20231227182541.3033124-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
References: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Stop dividing the phase_offset value received from firmware. This fault
is present since the initial implementation.
The phase_offset value received from firmware is in 0.01ps resolution.
Dpll subsystem is using the value in 0.001ps, raw value is adjusted
before providing it to the user.

The user can observe the value of phase offset with response to
`pin-get` netlink message of dpll subsystem for an active pin:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
	--do pin-get --json '{"id":2}'

Where example of correct response would be:
{'board-label': 'C827_0-RCLKA',
 'capabilities': 6,
 'clock-id': 4658613174691613800,
 'frequency': 1953125,
 'id': 2,
 'module-name': 'ice',
 'parent-device': [{'direction': 'input',
                    'parent-id': 6,
                    'phase-offset': -216839550,
                    'prio': 9,
                    'state': 'connected'},
                   {'direction': 'input',
                    'parent-id': 7,
                    'phase-offset': -42930,
                    'prio': 8,
                    'state': 'connected'}],
 'phase-adjust': 0,
 'phase-adjust-max': 16723,
 'phase-adjust-min': -16723,
 'type': 'mux'}

Provided phase-offset value (-42930) shall be divided by the user with
DPLL_PHASE_OFFSET_DIVIDER to get actual value of -42.930 ps.

Before the fix, the response was not correct:
{'board-label': 'C827_0-RCLKA',
 'capabilities': 6,
 'clock-id': 4658613174691613800,
 'frequency': 1953125,
 'id': 2,
 'module-name': 'ice',
 'parent-device': [{'direction': 'input',
                    'parent-id': 6,
                    'phase-offset': -216839,
                    'prio': 9,
                    'state': 'connected'},
                   {'direction': 'input',
                    'parent-id': 7,
                    'phase-offset': -42,
                    'prio': 8,
                    'state': 'connected'}],
 'phase-adjust': 0,
 'phase-adjust-max': 16723,
 'phase-adjust-min': -16723,
 'type': 'mux'}

Where phase-offset value (-42), after division
(DPLL_PHASE_OFFSET_DIVIDER) would be: -0.042 ps.

Fixes: 8a3a565ff210 ("ice: add admin commands to access cgu configuration")
Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9a6c25f98632..edac34c796ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5332,7 +5332,6 @@ ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8 *ref_state,
 			   u8 *eec_mode)
 {
 	struct ice_aqc_get_cgu_dpll_status *cmd;
-	const s64 nsec_per_psec = 1000LL;
 	struct ice_aq_desc desc;
 	int status;
 
@@ -5348,8 +5347,7 @@ ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8 *ref_state,
 		*phase_offset = le32_to_cpu(cmd->phase_offset_h);
 		*phase_offset <<= 32;
 		*phase_offset += le32_to_cpu(cmd->phase_offset_l);
-		*phase_offset = div64_s64(sign_extend64(*phase_offset, 47),
-					  nsec_per_psec);
+		*phase_offset = sign_extend64(*phase_offset, 47);
 		*eec_mode = cmd->eec_mode;
 	}
 
-- 
2.41.0


