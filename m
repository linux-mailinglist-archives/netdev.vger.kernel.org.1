Return-Path: <netdev+bounces-219693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BA4B42AD1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE96583075
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F83054EA;
	Wed,  3 Sep 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqMrF+T3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FC2E1731
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931144; cv=none; b=UuvrqSe/IPKkc8ypWWgy1az5bfIYFZm7n7vJIpbx8KQvHfKuWF2VvZyjZk2UJw2WuDW3z1bP2yrhhQywweDSGgTf2lPDNofAMMrh2qUXm9GDDAVmyDzeUBOs40DBbT6adEs3wzgyC/ELccQAkqAgR4y2Iyi2B10XX3LFhKJ1HtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931144; c=relaxed/simple;
	bh=dqjiXVCyE7eB9GaUlYMmOBFtbHo49OjpxpRRGyXvgE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI236tlat1Rog+4S50KDEyKpWoPg0kquLaSVhqXfOPFBALdxF/dqeeuQSeUXkqsiQTRDkAS1Nia/+s+TnqcaNOr7vufo122F+MpFRVykima5uWfpbtQQyQZfFm6xGww401Mh3ZcoMZzjSdW02BsiCdC0jSZJYLXlEXqY+33HI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqMrF+T3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931143; x=1788467143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqjiXVCyE7eB9GaUlYMmOBFtbHo49OjpxpRRGyXvgE0=;
  b=hqMrF+T3dcsxAO5vFj+7qSs2SxT+1oilwYIz+t1wLvMlzwS9XrSWzt+H
   8oT85HbM+L8k2VFcFSW0B+9bhOCwDOGSl+tNiMKNZZETstdD0RB28635s
   v9MFdPTbrLXpDrmg0fZydNW8BJDt5liyk9iN/moRXkFwL4RjxLLdPtAtq
   jm7PFT8q4b6OJWFz5cTt9hWO7Rq/bl667OU6CDraXaVaz+bdEcFRFLVKg
   PUTYtBH2N21fIYDej7kndVh4U/3Fktfe5PLlfvG/um5ezpx28pQdiXNJb
   sPheZTir0XkZaFD3QSIMsXSqdhx24e4SAKifFqnTvVFQh24qbh5f7ZYgf
   Q==;
X-CSE-ConnectionGUID: txIMgckBS3mqmuVlTNibLw==
X-CSE-MsgGUID: eY1xyeJ+ScCC4Vx59xKOWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173020"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173020"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: MCvMexpISumXTAOuj27udQ==
X-CSE-MsgGUID: 9d6kNCisQfC/4zatB22lPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823448"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 3/9] igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
Date: Wed,  3 Sep 2025 13:25:29 -0700
Message-ID: <20250903202536.3696620-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
Packets/Octets loopback Count), but doesn't show the TX-side equivalents
(lbtx_packets and lbtx_bytes). Add visibility of those missing
statistics by adding them to ethtool statistics.

In addition, the order of lbrx_bytes and lbrx_packets is not consistent
with non-loopback statistics (rx_packets, rx_bytes). Therefore,
align the order by swapping positions of lbrx_bytes and lbrx_packets.

Tested on Intel Corporation I350 Gigabit Network Connection.

Before:
  # ethtool -S ens5 | grep -E "x_(bytes|packets)"
       rx_packets: 135
       tx_packets: 106
       rx_bytes: 16010
       tx_bytes: 12451
       lbrx_bytes: 1148
       lbrx_packets: 12

After:
  # ethtool -S ens5 | grep -E "x_(bytes|packets)"
       rx_packets: 748
       tx_packets: 304
       rx_bytes: 81513
       tx_bytes: 33698
       lbrx_packets: 97
       lbtx_packets: 109
       lbrx_bytes: 12090
       lbtx_bytes: 12401

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 773895c663fd..c6defc495f13 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -30,8 +30,10 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
 	{ "rx_bytes", IGBVF_STAT(stats.gorc, stats.base_gorc) },
 	{ "tx_bytes", IGBVF_STAT(stats.gotc, stats.base_gotc) },
 	{ "multicast", IGBVF_STAT(stats.mprc, stats.base_mprc) },
-	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
 	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
+	{ "lbtx_packets", IGBVF_STAT(stats.gptlbc, stats.base_gptlbc) },
+	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
+	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
 	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
 	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
 	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
-- 
2.47.1


