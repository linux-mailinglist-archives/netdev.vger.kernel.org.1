Return-Path: <netdev+bounces-73443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018685CA29
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001B81F22EE4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8C152DF0;
	Tue, 20 Feb 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAQeD4LL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6C151CF0
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465497; cv=none; b=c36pVglhx2Fk650XXM+qT3X3ns9UAdjNHDRsSDS4w0KqxfcepR4aT/uzv6/Qcp2RDrX6x+5eadYDk1MT+BWlYhP9PDUsCnSDuWrq+9BVQTRR6A8cv0Xkj2kGugtQ0yrGBq0HpcaPDb8LFC+2PNGoCpYRGMzT449xYFUoGubYy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465497; c=relaxed/simple;
	bh=3km5UB3DZsACt/MNbitE174G1LoN6YbLXLs5gLQw1/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTozyCUDX3Vk2817ZLqoV+iwKwtJFMzVqveaFgmqTAxmi4bK+GGRCYgIA7vtjTSsy15q1q1R/XdA2x+9DZQtfhUpOKOtvut9PDCQp5UgHbWWxzBiylcSwnbiLVSh829+e0KEbhLzH/2INlVvVxS21zkHOZhixtek1rrpAHTstmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAQeD4LL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465496; x=1740001496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3km5UB3DZsACt/MNbitE174G1LoN6YbLXLs5gLQw1/Q=;
  b=NAQeD4LL2ha5BHp7npVLBAp3CULnjeinrj2Ran/ZvGSkgUdXnKo8rE67
   41DUerBciii/6vDWJ4rir9AguVVZfwgSZqwXj8fKmmr4msx6z/kYU8nPR
   BNavrWY6w7+d9aH5aws9yWT8QtewhZkz115gwdWaYKxLUb32e3+s/+Xin
   wyynDUfp6dKd9ETFyHFu9pXlLgP4CNDq44JDqy4MJ2TA0nBSHMAIy4Adm
   fQFZYbCv8t9oaReTlnqfEWR4EEPbSxVKdbrS9nCk+H1qKbgd2ql24yYC0
   5M603dFHjcfChEfmpc6PsgjE83/gJqBwvv47UZJaoXIVwsekBiwS/RIR+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472720"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472720"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614936"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:53 -0800
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
	Alan Brady <alan.brady@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/6] ice: fix dpll input pin phase_adjust value updates
Date: Tue, 20 Feb 2024 13:44:38 -0800
Message-ID: <20240220214444.1039759-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The value of phase_adjust for input pin shall be updated in
ice_dpll_pin_state_update(..). Fix by adding proper argument to the
firmware query function call - a pin's struct field pointer where the
phase_adjust value during driver runtime is stored.

Previously the phase_adjust used to misinform user about actual
phase_adjust value. I.e., if phase_adjust was set to a non zero value and
if driver was reloaded, the user would see the value equal 0, which is
not correct - the actual value is equal to value set before driver reload.

Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
Reviewed-by: Alan Brady <alan.brady@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 9c0d739be1e9..2beaeb9c336d 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -373,7 +373,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	case ICE_DPLL_PIN_TYPE_INPUT:
 		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
 					       NULL, &pin->flags[0],
-					       &pin->freq, NULL);
+					       &pin->freq, &pin->phase_adjust);
 		if (ret)
 			goto err;
 		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
-- 
2.41.0


