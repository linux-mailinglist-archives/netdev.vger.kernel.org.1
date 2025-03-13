Return-Path: <netdev+bounces-174623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A96A5F978
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1193BB2A8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F86268C7E;
	Thu, 13 Mar 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJUASGXU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A9268FC8
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879082; cv=none; b=p7jTyAmK94cukbacTw+vJWHgEOK4haeCTPbgBKNlZM+eO7E6p2TUf3spokvugaoaWsIj3nXQ6ButANJdfMrtW7THsE5+6eHGdVwQ/h4S9b9MuQmv+05B43fh5x8tC+7om20wUe/+xOidP9yV9NmKot1pHoeyRlHnkS4TnlZCSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879082; c=relaxed/simple;
	bh=Uo8WE5HynnA8wtxGTIBIqPd/UrNvxCk0dLM26vDYZuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWjzqHrNS5W1+qDAXontlaRWIr5NTmVOMjqz7cvx0mZG2aXfy2CKEvRNVDRBGEfxMF0zgpBDmKGJHW5suHAEBjgg2Mlil1Fy1k30PM6WtOjSXK2Ev9cbL61lkzh1lxeRHhO2YqKq5JJJMA/Eg7t3PjGlmLtW1rquH/41iIYSaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJUASGXU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741879080; x=1773415080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uo8WE5HynnA8wtxGTIBIqPd/UrNvxCk0dLM26vDYZuw=;
  b=LJUASGXUaH/++pf6M1/xzHm1dnDZrBBgJF05Xnyywczsy8H0lGebmVn6
   l+f+aL3yRc+ma4ZLGER5lPPnh+JjfxMfTDVHARPsb0+fYAbWLWSXh47Vz
   78w746bXs4S/P9t1mFKcO4W8WTyOvZY1203vlPXfsC1udU1ChPQHlMuBw
   YOWbYrp1UVQsDlqRsfdj4QR9wZcCbiegAkTgK6psB9H6VKoLKNY7znNqT
   8t48XIM7afpGCQGIz7edXCxzx6wM0Gyw5dENcT/M00KBPtt+faiREqi+y
   oBlZGwHNi6iTSmOdTkbAPIFyp6OI3IAYtCHzjJhivNRbIpzl+2xKpAtWs
   g==;
X-CSE-ConnectionGUID: N0Wgw9mTQA2ExsjAoVP1sQ==
X-CSE-MsgGUID: 0R39NgzKR02CXgBTk3zJIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43104802"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43104802"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:18:00 -0700
X-CSE-ConnectionGUID: zGCdisPsSa+/nup2KZmayg==
X-CSE-MsgGUID: WPacmbV/RUOoOdpn4UQCjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121917844"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 13 Mar 2025 08:17:58 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH iwl-next v8 01/15] devlink: add value check to devlink_info_version_put()
Date: Thu, 13 Mar 2025 16:03:32 +0100
Message-Id: <20250313150346.356612-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313150346.356612-1-jedrzej.jagielski@intel.com>
References: <20250313150346.356612-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent from proceeding if there's nothing to print.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/devlink/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..02602704bdea 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -775,7 +775,7 @@ static int devlink_info_version_put(struct devlink_info_req *req, int attr,
 		req->version_cb(version_name, version_type,
 				req->version_cb_priv);
 
-	if (!req->msg)
+	if (!req->msg || !*version_value)
 		return 0;
 
 	nest = nla_nest_start_noflag(req->msg, attr);
-- 
2.31.1


