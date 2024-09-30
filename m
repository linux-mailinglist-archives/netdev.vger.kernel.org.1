Return-Path: <netdev+bounces-130643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A182F98AFF7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CB21F21DFE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CD1A0BC7;
	Mon, 30 Sep 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4aaStZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E441946A9
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735772; cv=none; b=I6/ca8HbD6n+mt9FShEcCIK3I2e5eh6RuQz/COd2c073Nol4RKSuXIEl7UEe+Ajan610W7T5stq6nym7nkaho++qJGODcMMUIvdlCiLYZzVtwWqLMUKh611Xmct2yV0Sm+jcCxlVvemVhzxdVsln3i0mM6HLbtzPlPcQzC9tCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735772; c=relaxed/simple;
	bh=a98lEoJCvRiHq1dJDmAHiDNwEAUann7GHB0f2aYjLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPgwCPiebWZFPPQFPpUsTps4Kc0SVbPxYyjSb8NNrkO+jbCFl0vU489SoSEuCniwydE+Tl7pY4oo6ZRiab1B6KDPbeQqOxUL2ZtuOdHaHxrs974+xGhUQgJdItBolrNfTXmVVxRl6xZpQPu0FHbDyEBZWsYstc45Zw71FVgtguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4aaStZ/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735770; x=1759271770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a98lEoJCvRiHq1dJDmAHiDNwEAUann7GHB0f2aYjLoc=;
  b=K4aaStZ/RtRnuzYEKizNlulovBAMx0hlnf1hRYTZslhoJIpwA7a81jTK
   tEw7Ch5Uv4PQEEUoculqWRPJCy7e2RX3D3VeReWFFV54wrvyO+VZYRFPM
   L6iu5uhFFCXWXu+t0rJsQNUjEEcbLbZ8G5sHqCL2eiaolMul/HdXBoD/U
   BVE/Z/pYS4hD6NRGMa/nXT/mBAjxgEYXEvBUN0O/pUIhCRsxMDo8N1NUH
   kX16XqPJk4LkyJfvi64CXW5N93NpZ+029SfqXe9DzXtXbZ6ALpyBlZSrN
   fiRMVDwthMDD+Oj1Jlokuw7hr1/x2IWj9IVPSnYwyJ2qzitcD8GR9jgA5
   Q==;
X-CSE-ConnectionGUID: neZvA1keSpysTBFAD6cYmg==
X-CSE-MsgGUID: nJ0lN4osSsGDTD4al5vaqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734882"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734882"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:06 -0700
X-CSE-ConnectionGUID: hmJmE5B2QmCuUH38SVhxGg==
X-CSE-MsgGUID: A2IT3aRgRmOPQe+mnp8drA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496623"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:07 -0700
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
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 06/10] ice: disallow DPLL_PIN_STATE_SELECTABLE for dpll output pins
Date: Mon, 30 Sep 2024 15:35:53 -0700
Message-ID: <20240930223601.3137464-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Currently the user may request DPLL_PIN_STATE_SELECTABLE for an output
pin, and this would actually set the DISCONNECTED state instead.

It doesn't make any sense. SELECTABLE is valid only in case of input pins
(on AUTOMATIC type dpll), where dpll itself would select best valid input.
For the output pin only CONNECTED/DISCONNECTED are expected.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 8b6dc4d54fdc..74c0e7319a4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -656,6 +656,8 @@ ice_dpll_output_state_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_dpll *d = dpll_priv;
 
+	if (state == DPLL_PIN_STATE_SELECTABLE)
+		return -EINVAL;
 	if (!enable && p->state[d->dpll_idx] == DPLL_PIN_STATE_DISCONNECTED)
 		return 0;
 
-- 
2.42.0


