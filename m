Return-Path: <netdev+bounces-219694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E021AB42AD3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564A3582F83
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0F362071;
	Wed,  3 Sep 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGSM/Y+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880032E3716
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931145; cv=none; b=D8nmA/L8Ab7mq1exvQbsT0pDlpwek/pAlsMVnOAjT9BQeWBANKWUQ5esDLaAaVNJBh48fkJ5t1SoZN0KpXRDXb3phmhNdUgf9giRBOdrjnk8ju8zMMifQrNd84LOB0XP/hEObm/b2QYHvqYV+KiafiljOQIOXa0mfBxwqzswMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931145; c=relaxed/simple;
	bh=qh8YYaFIie+dEZfq0SQzpdmevlfVJYigB55tjQmuoOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dieen1rq/NxzdPeSIZt8BQ/BrTAXm4oL3ldOhVRH4ij0TYWRhb+xTn9Q4aAl2dcxBxysagjBcUB6ITn8Xhe4hl1ETibEUbLmvhF/54GwhSW3yFmEzQR55m2w4Re/jADRK/+ySS1mnswRKS77YkkUgaLeMxgH9Ev86T/82A+F/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGSM/Y+Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931143; x=1788467143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qh8YYaFIie+dEZfq0SQzpdmevlfVJYigB55tjQmuoOk=;
  b=RGSM/Y+ZEv9HzWVcL7HWv7s2W/bSsG5fUWA8Kyiewm5bnuRfob/i55gi
   33+ZHIj6VOuDWBFWjyY8ERxEFz+rnVMwxaHk7EJB8QHoiCOHit4Q3CTm9
   N+20AduUu+EY5TItfymtnG4Pzwdm4uc9hJ6VnyP5Dky+ooe95X1PryIqg
   fsXY9P8eYLzWIjRW3L1RxIuVKB/Y0dDt7KXvIZNteSwd3FBj4o9dY3uyG
   0Y5mHhi3iW1kBNJmgpBm3FWZzF2fTltuED9owqhS9J14mF0d8XVzW8v08
   l6MwJJzH7GxIiLhOXowF6/OZktYzUIMqdcPbEEp3LQX/JU99CzQB47uTu
   g==;
X-CSE-ConnectionGUID: ah+InS+QQhuAvXl8fB/Vyg==
X-CSE-MsgGUID: SX3U9WDBSC29cu8OYG32/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173029"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173029"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: KY614PDWTpmqU4+dw/diYA==
X-CSE-MsgGUID: YoQrHUFaTNmSEmnfEOsTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823452"
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/9] igbvf: remove redundant counter rx_long_byte_count from ethtool statistics
Date: Wed,  3 Sep 2025 13:25:30 -0700
Message-ID: <20250903202536.3696620-5-anthony.l.nguyen@intel.com>
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

rx_long_byte_count shows the value of the GORC (Good Octets Received
Count) register. However, the register value is already shown as
rx_bytes and they always show the same value.

Remove rx_long_byte_count as the Intel ethernet driver e1000e did in
commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").

Tested on Intel Corporation I350 Gigabit Network Connection.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index c6defc495f13..9c08ebfad804 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -36,7 +36,6 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
 	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
 	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
 	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
-	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
 	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },
 	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },
 	{ "rx_header_split", IGBVF_STAT(rx_hdr_split, zero_base) },
-- 
2.47.1


