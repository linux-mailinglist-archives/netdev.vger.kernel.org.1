Return-Path: <netdev+bounces-94686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DE8C0333
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99D0B25072
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E912BF34;
	Wed,  8 May 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1ilIi5r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE812B156
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189635; cv=none; b=M8GMmXIXS9qV6bSfwwqaeuMLXlqF3NAI3RHDHBHlNEZYkQaIRt81Ma3wXsDbLCa2CiF9jh8UTo/S2h10t6ZSisSAZljOVQ1KqgsoMaKugG1FG64NxzyuUyYverC2TrHU65hexDVvZ0VzWfxxP9rQh/AT0iaIGbT/v/5C7xAfeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189635; c=relaxed/simple;
	bh=AJWQtHY/Gl5ou1kfkMv5lyL7Co1FgnX75ygFF9J1XsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f91kJ5UtTLCkdruR0BU77Bdmmz3tlreI4tfK3U3Xi+gQCvwBGp5e6HLo2FS6UIJG5mXWpUTBfAucYekqOPQlO3XpUKmrfD/GAAp9EO3kxronatsBqwiEgQL3SFOR2Y3Y6KJvVG2Gvplq2xSR50fNZImJ8j8osekoLp1V7NGXjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1ilIi5r; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189633; x=1746725633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AJWQtHY/Gl5ou1kfkMv5lyL7Co1FgnX75ygFF9J1XsA=;
  b=N1ilIi5rFat7SRFh0NT4Y81uunZQ/AISu73AWMSQehq/wgBDJLMU2r73
   VR04Rm+0OI9OJ4yEfOQfELxifPhCD1X/6bGTpzwxS5HYtGq2h3WCpYM4k
   aQzwdUAYtvaXr6epYimtR4iqSv/fcp1nC1a2F+klQVM4ezpJtojMlGgiH
   cTu9E9HqGb5aZqKElRgTBkds0S3UL8bcKAi5GmYmd301NdqfnJ44Logd7
   J4yhvnaIn7Ezw/M/Pq9HLRHLtm9ArV7igTfn2/Fc/rkKsU2rM5Btqh1gQ
   l+d3q//ABUu5NXBwsZtiS5EWfXFKC9AvFSvNjTDz4ohWk2Wlv8DJNyGVU
   w==;
X-CSE-ConnectionGUID: fEo7NETTTCitsxsqxQYFvA==
X-CSE-MsgGUID: su8PKgf/T1y3Ht17FwcnGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938955"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938955"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:51 -0700
X-CSE-ConnectionGUID: SrudjMmnTIuglTigTro5vQ==
X-CSE-MsgGUID: iwcOs3erSJaQHeqzxmUP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843713"
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 3/7] ice: flower: validate control flags
Date: Wed,  8 May 2024 10:33:35 -0700
Message-ID: <20240508173342.2760994-4-anthony.l.nguyen@intel.com>
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

Use flow_rule_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 8553c56dc95d..8bd24b33f3a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1658,6 +1658,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		flow_rule_match_control(rule, &match);
 
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						fltr->extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.41.0


