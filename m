Return-Path: <netdev+bounces-166407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31196A35F45
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B3166A4A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77041264A97;
	Fri, 14 Feb 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tfe42rLE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB67264A84
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539831; cv=none; b=T71lxObkN8dofLJincQ47fabIJQOaVdvemtSmj/t18d+KunrCuHxGam55OqBpSw8+fzUhqpiYTSNRwYFzwjWMotQHkJ9r+ItQb3gWbX323BxMzd54LaTgT5kcgpW+QoavNzlUfBKYaLmFTFLQZBok+E8A1NK/uJuoRCk9em9TEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539831; c=relaxed/simple;
	bh=hJhmGrRCE4BroX1OnJa+3A/+mjS9ayraqChALrdsUIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLtmgJXUMl4UrlwodApev/vMNcONayAg0GytVlY0gefJ83E56ifhdP5MKelkqTngmnsw3952i0SBhgV+BNChLefDYo9Y7Iblq8z2hxwQu9F3MCORGmuUiHFjnlt3fyUnBy9B0bgNhUkIh+cwPuacZq2DtxUoZHbOeckDJSXPjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tfe42rLE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539830; x=1771075830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJhmGrRCE4BroX1OnJa+3A/+mjS9ayraqChALrdsUIo=;
  b=Tfe42rLEb/o9AW61vEkTlKBI50PQVKF82Y+Skepbii3qk7Yc46pPOdkd
   yngf5fVVx66L5kIs4ZDjVPFI++HG60vw5cxi2Odwowl1x+R3E/qcNAYA3
   CwA4ydhuMUUa3qWxOZqVoyOVN+yXgQWqBn5NAtS358eNy75eofzHoccF2
   JC5Nr18ccHkme2Klq+J82h1VvM08CSAsHADlN+wqQ2f4zJV0oY/DT7fv1
   bzTJCEeBrSHnXOS2rUdSs5obu+VS/L4MuF+BTp22c3M6WiHt4dzubgyXm
   Zjyqqq/D4dRzJKbmxKiO7zBvCheWVmQFm7NQM2RWm/E+x5Y5MkBI027cE
   A==;
X-CSE-ConnectionGUID: KfBnZ4s5QJGdwM0vHSTIkA==
X-CSE-MsgGUID: /0MeTl0LSOuGHIiL72VI7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40159282"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40159282"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:30:29 -0800
X-CSE-ConnectionGUID: c6ukSG9ZR7q7wtCcCWuPUA==
X-CSE-MsgGUID: mi9XpYG4RuS7O/HfIcAHoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="114094306"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2025 05:30:27 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	"mailto:przemyslaw.kitszel"@intel.com, jiri@nvidia.com,
	horms@kernel.org, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 01/15] devlink: add value check to devlink_info_version_put()
Date: Fri, 14 Feb 2025 14:16:32 +0100
Message-Id: <20250214131646.118437-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250214131646.118437-1-jedrzej.jagielski@intel.com>
References: <20250214131646.118437-1-jedrzej.jagielski@intel.com>
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


