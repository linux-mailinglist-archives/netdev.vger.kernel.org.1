Return-Path: <netdev+bounces-179955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F2AA7EFDC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350233A92E2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D6223339;
	Mon,  7 Apr 2025 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFBNse3P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5F20897F;
	Mon,  7 Apr 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062690; cv=none; b=QPDgkpXv3bPTPtPR8tqDJaiXIZLAdR7ka3OEVbbLDZhZye5BNXl2fAieg7YcnBTSKFI3RdNR2Pp1iH6v9kICA2ZRaHmZqvlm4flOD4ezKvOM0syuVyi+Q42wWsKIs/26qbwxayOEVp/Zuq/8qzrnT4Pz3BRsispPeapKiqW7MzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062690; c=relaxed/simple;
	bh=VYvPCNsZaadYB1Z5mQ9xM9QJuSv4gfHhIC2AxjA4/0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrdT21eq5Nyw0k9I96P4jQ6yb/TP3ZXVXt0TRz0oo1P9RW3jYF4mQuR4NUbVfwIgFCnQIUPGdqXwl5YNim1r3Gxy/wxBvkNM+/JsueefbisTntCsR28ZYmuznGDiaamv4B8oHMZK+0wUgQajdJz+nQfIRdRozDKRUDYekKxYoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFBNse3P; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744062689; x=1775598689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYvPCNsZaadYB1Z5mQ9xM9QJuSv4gfHhIC2AxjA4/0g=;
  b=QFBNse3Pmdq8ZEe59wnxAkMi7XuoGjNOQxWlIaqhddws+1SVGNnz2pNS
   C8olILkcNK7F4lAiL6dDDSzT2PqbpHeNOlywGgGJCa1L9eVfHQNaFgDPI
   ZUCXmLSMxSBnUSk4RVjTs+vR5XOYV/wxIEaOoyNGAgPOyf5B8ax3R11Vc
   l8H83GpOxQoRStA0Z1VWaxlcVNxYD5WMMLZAjt2ZrK8N3eQ1LkrfqHIyh
   Zau0U/qR3cPyyAw5GFkRnngwSlTBOpeMmjHblqazMvcq99jpawmE3DQdf
   F6jTpX+aDgg2kXukF8wymeHOskHSJvfVtb6Q6fI/B526iKMeYjqMvm0yh
   g==;
X-CSE-ConnectionGUID: QOocfurXTGWLJaCcVQSmng==
X-CSE-MsgGUID: F3OEa7YlQQ6CIRQi4Y8yfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49268571"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="49268571"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 14:51:27 -0700
X-CSE-ConnectionGUID: /kNxFLP5RFqgNl7dmow8SA==
X-CSE-MsgGUID: MZXqLjnMTAWUZeXAObeMew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="133055741"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2025 14:51:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 01/15] devlink: add value check to devlink_info_version_put()
Date: Mon,  7 Apr 2025 14:51:05 -0700
Message-ID: <20250407215122.609521-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Prevent from proceeding if there's nothing to print.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


