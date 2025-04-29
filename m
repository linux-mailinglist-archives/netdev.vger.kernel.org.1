Return-Path: <netdev+bounces-186893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FFAA3CE0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707A04A365E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0322244686;
	Tue, 29 Apr 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdVV8jnK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF123183E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970423; cv=none; b=rDqByTf0YFL99ExBANWxjnOoJ5mYN8bRRKOvr2FEF6iARdVfOQWvYMZz4I9S+F2Vs74NZ5vweGBAdp5ZsFpB2wNmczUj3u+s7wtwRv4il0aavuGj+OYn4DDZ0tUxvVynbynsehfdlqJx+dkPaBYAmoacMj1K6X4616hBt7Hb4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970423; c=relaxed/simple;
	bh=nhuxePoOWZKzL/6U4xare8jV366iJaHqVVVbvwE0KbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlSCudtorvIvAiMcsBdDzsjwicFhKtbFkTvLN0vUHa6CuhTr7QBttRvtIZOCFEU2O/byMqI96kDoY+m7NOWwdOI40Phsaq9lM/XWY/+Vu92vfyhmHH/HyGkIdAN2/YWxUVAlEKjyAXLzsy2OoqxXrtIkyRAje+WAuuBtwxEJtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdVV8jnK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970423; x=1777506423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nhuxePoOWZKzL/6U4xare8jV366iJaHqVVVbvwE0KbY=;
  b=OdVV8jnKX+s6rtijNYhpg/vYyhcBOPRAGnyZ9sQniMu9a1HBhc/AII9/
   3HST/4UrNTrOiDeXimcpQhm8O8MD/lD3w+TRKTEhYeRAYTklEuZoq/f0I
   tnEEoWd7zBXQ0pYadmLbEcBACDQfGjk4k/1jZixwSI6D/phNJRJKcAYiN
   46M8SeTQKrpUxwEh98pTXyPqM8clp9IipS4zWt2m71VG0utcRLBh30o1w
   hPUcMdaWfKLy4LLsJEw/f/vpw6lObtvnJRadHAOUUqryFDlivxaeefkye
   tDvRSAAjwKlC7hNGAr4pnMkerdKal22PFTYh/u3DUSW+2eiQDZbxKcm27
   w==;
X-CSE-ConnectionGUID: fK4+aeOwTV6iUAFhZsue0w==
X-CSE-MsgGUID: wcDUzMtfSMyMW+RrnxH3dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990075"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990075"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:01 -0700
X-CSE-ConnectionGUID: cwQ/ZVx3T8uuA15AJoD7mg==
X-CSE-MsgGUID: PufpITjqRUOqjWt6vqgO/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979614"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	bigeasy@linutronix.de,
	gerhard@engleder-embedded.com,
	jdamato@fastly.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 03/13] igb: Add support for persistent NAPI config
Date: Tue, 29 Apr 2025 16:46:38 -0700
Message-ID: <20250429234651.3982025-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

Use netif_napi_add_config() to assign persistent per-NAPI config.

This is useful for preserving NAPI settings when changing queue counts or
for user space programs using SO_INCOMING_NAPI_ID.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0535cc72b11b..d9205573886e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1197,7 +1197,8 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 		return -ENOMEM;
 
 	/* initialize NAPI */
-	netif_napi_add(adapter->netdev, &q_vector->napi, igb_poll);
+	netif_napi_add_config(adapter->netdev, &q_vector->napi, igb_poll,
+			      v_idx);
 
 	/* tie q_vector and adapter together */
 	adapter->q_vector[v_idx] = q_vector;
-- 
2.47.1


