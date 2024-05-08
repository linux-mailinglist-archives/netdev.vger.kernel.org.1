Return-Path: <netdev+bounces-94687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE28C0334
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B4A1F22DEC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168A12C80B;
	Wed,  8 May 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq4wJkch"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB612BE9D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189635; cv=none; b=rsLY/v2tvKRsLuHHk9d/SStPsnbp/cpqQ7DnpAubCHgqUQLBvmuqchZiXF641h6URPv3TpxEvzlSr1cw/07JTcvq1Wt9sAIUSrES17R7HWgOURnal/wWOGEqvj0YUmu157WmHx2LRytmv+DT6X6lB+CV23an3emLXAyCoxBzfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189635; c=relaxed/simple;
	bh=i2rE7RB46M3I6tqFG9AwFsAkKlvwz1kxaqxYlQYQ8Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ8p3DvnjgJFWJX/j1hWjhM61wS1u88G9hkcfGq9bk/7+KKbWuWKxvtCfhPqZBQim8Qf9zKYSlXDRbTyDJu8qeZTOnNfH1RXWN+5bjINAgpGah53lY+sU66K40fSxNI9GB1hakPQntLZ49hIO7FaJX4i5DibkE4+aWTZ7siSQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq4wJkch; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189634; x=1746725634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2rE7RB46M3I6tqFG9AwFsAkKlvwz1kxaqxYlQYQ8Bg=;
  b=Tq4wJkchSWXn/Jpba2qhhnpm1k8/Xuo2TvzZV6cjeyxQXBIW6MZUqfyT
   xHHH+53fz9rOOsNI/gp9CQvip0EViHMnQTAewg0z2/HHObWyMKrWUwTnh
   cjoTZ39d41MwQR2p5c+lo+If2kp9+MqPmXr7fRPyRtSX1k1takP+4LAkF
   N9kc0le488OnQOw8SxSMN9DSrajdJEiTC6Zqh/KANOqOIJct/fb3t0q8Y
   tDlDbGz0UC6SaNZItHy6AIUjTNBzHLIsPP1M+NGM1xFBWveevVbf87lyH
   gozkbQeOA2YiIg4JCLre+nBT0s+bK+zoAnUM2H5Qs9ot/DoOz8yWIWj5L
   A==;
X-CSE-ConnectionGUID: e6P6UH6tSAauEecO2vY8EQ==
X-CSE-MsgGUID: 5ljq+R9BRFKI/veevrraRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938963"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938963"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:51 -0700
X-CSE-ConnectionGUID: ydxxWsgfTFGYdSR1s2u5Yg==
X-CSE-MsgGUID: NHB+mebTTJGSKnmGfh84fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843716"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 10:33:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 4/7] igb: flower: validate control flags
Date: Wed,  8 May 2024 10:33:36 -0700
Message-ID: <20240508173342.2760994-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
References: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

This driver currently doesn't support any control flags.

Use flow_rule_match_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_match_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7d9389040e40..fce2930ae6af 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2597,6 +2597,9 @@ static int igb_parse_cls_flower(struct igb_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct flow_match_eth_addrs match;
 
-- 
2.41.0


