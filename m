Return-Path: <netdev+bounces-241683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD88C87590
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74F4234412B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747933BBAB;
	Tue, 25 Nov 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DP5fVwwW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB333AD8B
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110202; cv=none; b=n3r1v8VK5aWznhJaow/nF+okEDNiKm0jcG9yESrtHwxCENhZiYD7NJvYA5xKAXc+kzumhjYUB0GP3t741n1u47/EzwgVDm82fFBAzNxLGkADmLywM1+R8zA+TcYbcMnX7Y4QZytoE8nBc4io6ntpXFuY1carfYxA2p14ANI1SkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110202; c=relaxed/simple;
	bh=wvOBF/0fmznr2S0z4152XsogkE4kE7i3gmv3kFtRh1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqgM5KxD5FhRnfmaMyb2tz6ZdqIg8OVBfo8qM8j+30TvxwyzVQHc78sZdTbzFcfbsbEVbsYjFIAdRsWJqMH9dgY+Y2Tl4h6jmusvLucUL0ygicWaaGyYQP05YXnwUcd95S/8BfGjeoDRgVYEeLnNapJYvSfBeLtce+2v304Z4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DP5fVwwW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110200; x=1795646200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvOBF/0fmznr2S0z4152XsogkE4kE7i3gmv3kFtRh1s=;
  b=DP5fVwwW1f1G0cb3wpUTXJezG3JrCGro0DoQaZyXO/bi63l1zl12jaOa
   Ybf4S+BVUYvUVlEekNMEVKky1WsG4my6wBwAKun/JNMlxtOapDE33dEdg
   +pCv41HkcO4D259gDVsOocEDw3PUOAFvfk+9vRGt4t1H4CzOZYIh71yWQ
   0Odj7Zdj5NyKGw4t2buQfG9RIoc5ZX42krzJc1gqTulL8gHT7cwVIz6SY
   yHZDl4w4RlMELdUK2ienuRjHY7rlnHAOyj90ADmFBTCZga1CXVvbb4fQ1
   ZK33yX1o+jlyL4255mjgah9sHR0MZ1gTwFK1mvxg0/U4Zc1TKPv0iCQyu
   A==;
X-CSE-ConnectionGUID: R49wmYAmQDC3bo67ZRXkFQ==
X-CSE-MsgGUID: Dty2X0WBR36kuO1ifRrw4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729890"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:39 -0800
X-CSE-ConnectionGUID: 3ilnoktgST2BbCvJwDvr6g==
X-CSE-MsgGUID: 2BRz/LDET/C/lEShiqduQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209555"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Natalia Wochtman <natalia.wochtman@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 04/11] ixgbevf: ixgbevf_q_vector clean up
Date: Tue, 25 Nov 2025 14:36:23 -0800
Message-ID: <20251125223632.1857532-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Natalia Wochtman <natalia.wochtman@intel.com>

Flex array should be at the end of the structure and use [] syntax

Remove unused fields of ixgbevf_q_vector.
They aren't used since busy poll was moved to core code in commit
508aac6dee02 ("ixgbevf: get rid of custom busy polling code").

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Natalia Wochtman <natalia.wochtman@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 039187607e98..516a6fdd23d0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -241,23 +241,7 @@ struct ixgbevf_q_vector {
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
-	struct ixgbevf_ring ring[0] ____cacheline_internodealigned_in_smp;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	unsigned int state;
-#define IXGBEVF_QV_STATE_IDLE		0
-#define IXGBEVF_QV_STATE_NAPI		1    /* NAPI owns this QV */
-#define IXGBEVF_QV_STATE_POLL		2    /* poll owns this QV */
-#define IXGBEVF_QV_STATE_DISABLED	4    /* QV is disabled */
-#define IXGBEVF_QV_OWNED	(IXGBEVF_QV_STATE_NAPI | IXGBEVF_QV_STATE_POLL)
-#define IXGBEVF_QV_LOCKED	(IXGBEVF_QV_OWNED | IXGBEVF_QV_STATE_DISABLED)
-#define IXGBEVF_QV_STATE_NAPI_YIELD	8    /* NAPI yielded this QV */
-#define IXGBEVF_QV_STATE_POLL_YIELD	16   /* poll yielded this QV */
-#define IXGBEVF_QV_YIELD	(IXGBEVF_QV_STATE_NAPI_YIELD | \
-				 IXGBEVF_QV_STATE_POLL_YIELD)
-#define IXGBEVF_QV_USER_PEND	(IXGBEVF_QV_STATE_POLL | \
-				 IXGBEVF_QV_STATE_POLL_YIELD)
-	spinlock_t lock;
-#endif /* CONFIG_NET_RX_BUSY_POLL */
+	struct ixgbevf_ring ring[] ____cacheline_internodealigned_in_smp;
 };
 
 /* microsecond values for various ITR rates shifted by 2 to fit itr register
-- 
2.47.1


