Return-Path: <netdev+bounces-269788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLSrIQHWvGkk3gIAu9opvQ
	(envelope-from <netdev+bounces-269788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:07:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D926E2D5E80
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA87303D70E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935142F39B5;
	Fri, 20 Mar 2026 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5boiSxh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C68201004
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983152; cv=none; b=hoKD/I1ezg6H+4Zxr1gdcB7VpOEZ/N7sB6Hh8tbKn5yQfUO+gqCnYId/yO3PsmzhchgF6ZglDeua0O6kaLHeYQ5PUXTJua/n0i/C2h/5xo02/lou0IMWl4L7ID+Mn1ou0sXAcEBMeRvGE6kYJiG+nDVfWNPjhUb4O/EYgJ5OQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983152; c=relaxed/simple;
	bh=0nU37g/5iMAsd6cyW6ndANCuu/ZEAfLoUvjHbqnSUpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nm/PLTwOSfl1RBl1z+Fsq9sjMtoOqwKsvJgm3GkcTJPBFIuINSN/94JtfOJf4uKTEczpMHFJsZYQX+H0QhKmPSsGACqv+3sbh7ztdOHZ59LPWLNjXNncmypSYMobcL4K4MCXsSBOj9MswAlbLvUfP4fUJPxv/RRC+bpka/lAJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5boiSxh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983151; x=1805519151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0nU37g/5iMAsd6cyW6ndANCuu/ZEAfLoUvjHbqnSUpo=;
  b=R5boiSxhnvBJ2wWAVnsC3rKVCHDNJ7ArY3lIDnTLDLVV6sHvq/efqwpu
   zTKr7iUvyyW/rA7SrUQOLAej7Z40626uVI9domKhY0jN2Awz0PemIFVXK
   sNYR64jB4WBeBnjphI8ba0d/bBj6qfazg9Rx8UmqNo8bPvzIDFn1ADiCM
   MZrhAikG5xWzYjtYW6i1pcP8J7nmNWmztsXKKHhkbK/MLiCwSBiLXOfBq
   oU7hu01WVI/CVMkYZxCJbkrlRTam7MTyxTY1JA9CCLjJlXpuKZ+p/3z3M
   20fLiwoYghJSI7ZC8QJOFF2cG+vpLyrvRpLkSHYqaxKAL+GJvtmCEM8dd
   Q==;
X-CSE-ConnectionGUID: KDgnXv8IQY6OjdXCpFyFvw==
X-CSE-MsgGUID: cp/j6pz3TpeK8AZjtDkfyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75251817"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75251817"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:51 -0700
X-CSE-ConnectionGUID: PtRtYdMPQdqgQ98KdsNf9w==
X-CSE-MsgGUID: 4Y/peap/T/2MqjLHlVn9Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222399179"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa010.jf.intel.com with ESMTP; 19 Mar 2026 22:05:49 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next] ice: reduce loglevel to debug for 'Can't delete DSCP' message
Date: Fri, 20 Mar 2026 06:05:48 +0100
Message-ID: <20260320050548.422684-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269788-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D926E2D5E80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reduce netdev message "Can't delete DSCP netlink app ..." from error
to debug level when in FW (firmware) DCB mode.
This is not a real error and a kind of expected behavior. The device
is fully operational and error message might be wrongly interpreted by
the user.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a10c1c8d..bb5cc0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -872,7 +872,7 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
 	int ret = 0;
 
 	if (pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) {
-		netdev_err(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
+		netdev_dbg(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
 		return -EINVAL;
 	}
 
-- 
2.52.0


