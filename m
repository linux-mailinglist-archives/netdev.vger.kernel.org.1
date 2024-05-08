Return-Path: <netdev+bounces-94685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5312B8C0332
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A67B24F33
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333D12BEBC;
	Wed,  8 May 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coJ7KI36"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822012AAEC
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189634; cv=none; b=eulkVUvCWyZ7AlQR+ZEkiwyGP+QuthD6ScS6xzOdNEA63k/69OW+gEmFpBJ9u6xaR0PI9tnHGd+HSd63zPYLlBUT8pQQwZWJ4JR8q04k8KemRvd/59ogc1HOUiwbDt0YpJMTG2OIkiROfHzrg0NfTiEjZV2kxXfBny2ksBE0/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189634; c=relaxed/simple;
	bh=WBiSsgbBUNtAglsHoC5hNdDSuNKpU1nH1GioWhG2ma4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueScAloCwMSAWeXx7NuPcXrXWJ7VRRO9ycjJtjUoBMYK+PQp58y6AOlkjNnoD9SMk7tbEasse7A5UERM/W/fNQX8dx6PeLKGk+ub1JUAbZ7Dz1nvtMAKON0J7OXFXTA+ydW7GdxQ2mSmN+05b9dGm/mXqjCRVkuh9CcVLAwrROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coJ7KI36; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189633; x=1746725633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WBiSsgbBUNtAglsHoC5hNdDSuNKpU1nH1GioWhG2ma4=;
  b=coJ7KI36Pdc9Em8esvO6VCrfJgekuA3o3cAoHLdBIn5YO0d1c8s2543G
   zVRgACsqHw4qt5Y5d+PaiKAnNOX8MkGtL5VwCtLclYiSDRdMx42ql9Uw2
   Sz/aAVtaJg1BnMqwy4r+WiQPn+o7vQv8hAoF1H68AohDs4EJspCRxI11N
   YO8eUe8GNQmNf8ixiFJh+EhoEy/HVJlfxz87Efg7sBm1uS2KQ9wdSM8a5
   e0xqMqAcLcfLVMVMa+iBcfzTbQMGoSCxig/AUNvGJtZdpjmyi7GroOIDD
   JAKbrc8b2dj52qL3mX85GpKIpT+SNwnoLcDO0BmXT/Mb4XeSy1YbOfIxJ
   w==;
X-CSE-ConnectionGUID: gyJjQqViT5OC+/MXpebrHg==
X-CSE-MsgGUID: 3pURlmNTRECG5mpEq5loTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938947"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938947"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:51 -0700
X-CSE-ConnectionGUID: PwELXY4zT2GWgMYtJykBjQ==
X-CSE-MsgGUID: C9pAzyd3Sd+jtVOEVAaPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843710"
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
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 2/7] iavf: flower: validate control flags
Date: Wed,  8 May 2024 10:33:34 -0700
Message-ID: <20240508173342.2760994-3-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d4699c4c535d..c6dff0963053 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3757,6 +3757,10 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.41.0


