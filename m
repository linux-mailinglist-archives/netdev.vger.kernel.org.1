Return-Path: <netdev+bounces-233642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A621C16C33
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0321F3561E0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9562D7DF1;
	Tue, 28 Oct 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEbGUxag"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BEC2D0C9B
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683128; cv=none; b=VccFtOFld7Duzp5KreORByLa6xpvXq0va4q1W8SesNbUfF0Cfi7Kb/TKWWqVVUPh1asHLRSFja2QpwFG1EpaFpcsWZ+Ogg0ph5oshwljuWE9LKQPnjgqpBKkPVg2FAVRp2Hzr2+Ib4+8ky822A8AbZQQpPdKgROOcSPMoR7Bmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683128; c=relaxed/simple;
	bh=71IeN3czG936WssV/k9ogNS6GxDLt1nMmUv8ElDG+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr0kwSqqELv3vnvp9i6wGaf2rFs8HQgYY/N9/odH9LI4xzPYSGgT3F44qmTVnmr9NLxyh50PQgfXAheBwmXkCWN3LRYn2Fcb3MT4/39pdfkFH+QLVXFi8O1t1DPuLwaSzFb0/gRUyuLhBdCTN2qSmmifoo3IP/BXN45WrIRq/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEbGUxag; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683127; x=1793219127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71IeN3czG936WssV/k9ogNS6GxDLt1nMmUv8ElDG+Sc=;
  b=PEbGUxagqIUZ+8K/Na2ygBQyQ55Yf3211RN4SYqPKFTOUUyISKoDslOD
   QwDLygRIahliPdK70zP0BMLg3zhPKBsv2A9r48iWLXLTx2vHfNiuFqP2s
   NHrYBpgS7NtMWtlcN6PtZivnaMLvgXHG765tUhWhaJj/DjrBySNqZSR8Q
   ZTtYaLhazzj6k+AAdc0sAmlM7e82UOjp+zv5kfFk7mJhhCehowKcR24oW
   kaPsPfCTOVOYFWfyoz3/hfS8RxhJQXEvF+ycbtK6kq/pr5DNU2gSUuO7G
   0NCua4Xy8C87JqbSp8/H4PfzEOzOjKahKgnNQKHY0p2RoC5ELgfPswSaC
   w==;
X-CSE-ConnectionGUID: aezvXR9/T6CIt9O4HTEsBQ==
X-CSE-MsgGUID: CU/XtwAsRduSk1owgfpJRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825151"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825151"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:25 -0700
X-CSE-ConnectionGUID: SvrzYA9LQ7iiMp+GkGl7Rg==
X-CSE-MsgGUID: CAruWNc8TUqtzW0F/Hq6fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790174"
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
	jgarzik@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 6/8] igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
Date: Tue, 28 Oct 2025 13:25:11 -0700
Message-ID: <20251028202515.675129-7-anthony.l.nguyen@intel.com>
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

igb_get_sset_count() returns -ENOTSUPP when a given stringset is not
supported, causing userland programs to get "Unknown error 524".

Since EOPNOTSUPP should be used when error is propagated to userland,
return -EOPNOTSUPP instead of -ENOTSUPP.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f8a208c84f15..10e2445e0ded 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2281,7 +2281,7 @@ static int igb_get_sset_count(struct net_device *netdev, int sset)
 	case ETH_SS_PRIV_FLAGS:
 		return IGB_PRIV_FLAGS_STR_LEN;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.47.1


