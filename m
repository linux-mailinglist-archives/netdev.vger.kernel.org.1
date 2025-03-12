Return-Path: <netdev+bounces-174200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C731DA5DDA0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE523AD128
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC924EF69;
	Wed, 12 Mar 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfeR1rDS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C042459F0
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785178; cv=none; b=LLuKxCds9uG4pjp3ykll9ehVknRcfb8T6DmkmywRMl/Y18L4+Xou4QQADX+CfzwXqOc0KelYoZqBaN8TofvcmiYtBPGXUxtM4DOW8SsMxqL1lVIVkq3T1gTnP+beOVgG1G1gGmVGNNSXNcJdr2N3tA3dNuQ2U0jYkm613Ygcaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785178; c=relaxed/simple;
	bh=Uo8WE5HynnA8wtxGTIBIqPd/UrNvxCk0dLM26vDYZuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1Syz6w/haUh+DPpUmJEkSSBPYjURb9pPf+cNQbNv+UONArPD/ze5GtrGqLS7bn3fZ69terFCYrcqGoKUbGhmqluTXkr1vVA43PBCQha8sLHbYRsLXfxyAG6wCqqVKqWW8FoKbft+dARQeanSw6kExUrTGtcaOMR7odv+dxO8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfeR1rDS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741785177; x=1773321177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uo8WE5HynnA8wtxGTIBIqPd/UrNvxCk0dLM26vDYZuw=;
  b=gfeR1rDSYz3Ju1XyC1xFJAhL92PwCgtDCr77PdQ90itT9jIi9HufIx37
   HClcNyPHjWFYNr9x96dkK8M7gHcqz4bqQmvd595Pg5uwQUXW4G5dycFAx
   0PQbdiY+D3iravGY6vcEtchW5J5m4VBl65V+Jq7nLzhCDPKdtSQKW1Lyr
   G96T0tOcJOKp2k03YL6bj2aAimPgdYVjiCnhRzOBZMXPIpGi+LIkRZnnU
   NI9tLAtUWNt8Qu2Wb+GsJwsXHY3rWAGJJrihqmN+HOi506OeWeTBCQ6dM
   u9m2C9aLnYauTA/pBrd/BKGCMVDPw62TDMsvF5FVeHnXQAgwH++7Hh+Ls
   A==;
X-CSE-ConnectionGUID: Wb4sFDuFRa6aOkFWsGfKjQ==
X-CSE-MsgGUID: R+yTmDzQSKCiiesO7mbdfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53510662"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53510662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:12:56 -0700
X-CSE-ConnectionGUID: zX2oIiUQRBSHdPYmJo6rPg==
X-CSE-MsgGUID: F0JCe90MTVam3jgoxbqeDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121542053"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 06:12:54 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH iwl-next v7 01/15] devlink: add value check to devlink_info_version_put()
Date: Wed, 12 Mar 2025 13:58:29 +0100
Message-Id: <20250312125843.347191-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
References: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
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


