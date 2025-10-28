Return-Path: <netdev+bounces-233643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB69C16C44
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B8CF4F606A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D275334681;
	Tue, 28 Oct 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdAbIbO5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF802D24BF
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683129; cv=none; b=fJD57gSHltC3k09KRMGhlQt1/stlTQhqkhz2if8NYQW7g9/6IVqqe+tdEA76C0BI42ddt0ZhkeAs42IXIVML8e0uuwL6XaPuq23ywX9F0Mem3xpviiI6ypBYkxKFTFZM4BylJKkASFOsCMiNvkBWMlIutfHQw4SVYvAnLuUy8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683129; c=relaxed/simple;
	bh=znpOwpW6QA9VpVNnM9A+u47sT36G1/NXv58d4WCJsRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UquGoZeEbtpqXhPMkdvbUZlCkPqbHKPhE1Ke480CKEvWZIo03+REhxGKjaf6lbeJGATccNF2q4fdE/684iXvAMESbuLRTRamA8Oiw38QMblpmL9B6YEenL5erGGQzgb7/wA06w+KK9ZYr/KXFTZFzJklZhBZmDJF443MtAYziik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdAbIbO5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683128; x=1793219128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znpOwpW6QA9VpVNnM9A+u47sT36G1/NXv58d4WCJsRQ=;
  b=MdAbIbO5iMKeB09yqMUUJpTmAo5JB7hlRC2oNcvo5jukL12RqzAVj7VJ
   H1+mMMcGXDVmpigG9ux4fy5zQrIU7tFctmWljwyg4RriTn9DROzCd5jNr
   ax16Cte8CKbKfQ+JSP/4hBfldWOYeOr5kBiEpu5Ipu8nK7SV+PIVGCODW
   JdLBASs0zvDvgWParEt7V50/ca6GB253hLnduLSp6K8Wa5+e4y2+JZjV1
   kKZ+AQD22gv2OPSG6aiDL1JXjzwrgg6Mlxv5AcLTkArIfCxPpT+jDACo/
   s9zi+IxYlj1JqpHJhjlWJEGNc335UAbKL7G6qsmkMqietv1dt1Qe+xBpb
   Q==;
X-CSE-ConnectionGUID: eXQ5iv12TCWtV8dfNCokLQ==
X-CSE-MsgGUID: hIlaxAaBQFOsLS/2uEZQVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825152"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825152"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:25 -0700
X-CSE-ConnectionGUID: emC8QyKeQcai1BKur4vR7Q==
X-CSE-MsgGUID: nN+D9zXHR6mmUMYf+mlwAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790179"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:25 -0700
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
	richardcochran@gmail.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	jgarzik@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 7/8] igc: use EOPNOTSUPP instead of ENOTSUPP in igc_ethtool_get_sset_count()
Date: Tue, 28 Oct 2025 13:25:12 -0700
Message-ID: <20251028202515.675129-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
References: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

igc_ethtool_get_sset_count() returns -ENOTSUPP when a given stringset is
not supported, causing userland programs to get "Unknown error 524".

Since EOPNOTSUPP should be used when error is propagated to userland,
return -EOPNOTSUPP instead of -ENOTSUPP.

Fixes: 36b9fea60961 ("igc: Add support for statistics")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index ca93629b1d3a..bb783042d1af 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -810,7 +810,7 @@ static int igc_ethtool_get_sset_count(struct net_device *netdev, int sset)
 	case ETH_SS_PRIV_FLAGS:
 		return IGC_PRIV_FLAGS_STR_LEN;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.47.1


