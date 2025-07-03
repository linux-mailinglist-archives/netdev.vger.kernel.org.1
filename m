Return-Path: <netdev+bounces-203902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2499BAF7F52
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC958581C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5282F234E;
	Thu,  3 Jul 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQiYamDA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24515747D
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564591; cv=none; b=BKjooflHN2DnFt3Pchvk26TD0zUKQrk8GCil8eNn0GP8XPdYckB7s0ouwX0hcbuY3oEEeXbyLOH24w10G9PaB92RMkCD0P50YSmwldh5ybMDlbV3zRCrnPWeEzg1FWo04IwThtn3XADHy2PNb0nmXxd0d8271AiBvlc8qdVaAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564591; c=relaxed/simple;
	bh=czoEiFFborT7YHBdRz92JnTC5LUVD3m1ntDY8yfUGCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTp+msepRT6o5w+A4CdadZotR3GU3K0IdUFK/8uoVwVIK+dtlR3MMZrQfnuVRDpuuk+2ijsf8s8aPQ0nTc8uurdGDxc3wY8wkxKhnxJiYlWMEZduFhb6fTZWmgsKvbgzJJTM2QXLVBtLx11h9GDwn8OockkmgMR9K1eYqz9WIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQiYamDA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564591; x=1783100591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czoEiFFborT7YHBdRz92JnTC5LUVD3m1ntDY8yfUGCY=;
  b=OQiYamDAYvxrwH9THipknK6xHmOFb1aRqPREamyWXkG1nmS2vHIifCZl
   PaBve0Zv+sTmPlNcTwnHFLPsnmtvF8L+o42HsxmDwbRgZUlMT0wUDocFY
   5NzBNQxzCJAQBuRTPC9CZZ5naX8R99YJbR6IAoSwBLv3pZlS0FHNi4CW7
   xGWj4lBP+ufHArfRv/kfWzOhmoh/0TQ8QgToBD5V5VcyCai4GDrUgW6/w
   S8NgIb83CcWe5vlcX4tV14HzV9wmROpflByNRCzrTpmdBUtAwMGXMjdB4
   lEebiWcInWlLOz62xPesfsKa8h2f8VBqVMCCaH02nowv2XyGz/bHURFf9
   g==;
X-CSE-ConnectionGUID: hrks1sx1RIavXxyNN3YxRQ==
X-CSE-MsgGUID: 9OsKJrlOSKaeCFXrcPej6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767978"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:53 -0700
X-CSE-ConnectionGUID: tXwas5eSQG+HlHZkYu7mgA==
X-CSE-MsgGUID: FYqshOFSSIWl5Sch+Qztvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997934"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:52 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 12/12] igbvf: add tx_timeout_count to ethtool statistics
Date: Thu,  3 Jul 2025 10:42:39 -0700
Message-ID: <20250703174242.3829277-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

Add `tx_timeout_count` to ethtool statistics to provide visibility into
transmit timeout events, bringing igbvf in line with other Intel
ethernet drivers.

Currently `tx_timeout_count` is incremented in igbvf_watchdog_task() and
igbvf_tx_timeout() but is not exposed to userspace nor used elsewhere in
the driver.

Before:
  # ethtool -S ens5 | grep tx
       tx_packets: 43
       tx_bytes: 4408
       tx_restart_queue: 0

After:
  # ethtool -S ens5 | grep tx
       tx_packets: 41
       tx_bytes: 4241
       tx_restart_queue: 0
       tx_timeout_count: 0

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 83b97989a6bd..773895c663fd 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -33,6 +33,7 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
 	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
 	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
 	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
+	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
 	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
 	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },
 	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },
-- 
2.47.1


