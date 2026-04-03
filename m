Return-Path: <netdev+bounces-274887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJgVKAJTz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:41:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB2391258
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D1530603D4
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C373537C3;
	Fri,  3 Apr 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvmInz+U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A308B359A8D
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194839; cv=none; b=i3jJ0szV0xYPlZPtWaZ0pH9MS3txC0BYedjItoVAh5OAOWJ0sE8sSik0onjMnOFgT7NWDXyCFWn5o3ETdVCQnuc3Q4w4bNvAEKOzvVUFY/1MzgHKabR3niTT1ZtQYhvnhgzcy9WfkngFqlSN8zCdlw/2b6Uo3D9AuJeDAASgmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194839; c=relaxed/simple;
	bh=cNgq/FSRIyz8iw9SOUsHg7NMCtnTH4UFHNADfQywo0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+bHlC7HnlKc0xUvy+4vSpeRQcPld/5oiwoWaWHZhF+lbxjU89ZOT1IQhn+DMxiPqTpbvYGTvQZdMWTamanrESxOuRtmLAeHQNa055/ow8kTCDpphT1HYITL7i9zVvY6VFXPBHwHcO5BM5DDCOdYsk7V45PsfvjOK1hp6RPBUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvmInz+U; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194839; x=1806730839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNgq/FSRIyz8iw9SOUsHg7NMCtnTH4UFHNADfQywo0A=;
  b=MvmInz+U8t21SNF0QhpehiQQLPZFMKxONKOWZZyPtT7aH3HJAaobJdfU
   yIFd9gMSI66FPhMcqxAl3IOEFZhYgUPJpJKz2u5N/+Rnw8MkZKvM7W/p1
   cu/0bBoJd/c92dDM83TwCevJFKzUvv0hV9/Nve2o9LKG3qQp3bcu/yejW
   y5KyhUomqde2d1R7irsETlw7EC4T7T1BCBEnbRIUKsjTlCgr/dJCmTv2A
   xDYFhPQ6vnqnmbX1SPF0cWpgeeNTcXPaWg3zwzKIb8PMmbcWp1p0BelPS
   oirDrN8wG59LJzwyaCrDsqasfR8YhlOo2iGLwjGgUsbTq9d78MyxXrCcH
   w==;
X-CSE-ConnectionGUID: f3P4WEy4SbKuXnAsTHdTww==
X-CSE-MsgGUID: Y+ZkgYSLRCCwXkExsAV9CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981748"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981748"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:39 -0700
X-CSE-ConnectionGUID: aZuhjzIFRbuEa1isqLOFZg==
X-CSE-MsgGUID: 53dlZlWcTQ6WWvXzF1NT0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904930"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Voon Weifeng <weifeng.voon@intel.com>
Subject: [PATCH iwl-net 5/10] ice: add 10000baseCR_Full to advertised link speed map
Date: Fri,  3 Apr 2026 07:40:23 +0200
Message-ID: <20260403054029.3789616-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274887-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 1AEB2391258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a user attempts to set autoneg advertised link speed to
10000baseCR/Full via ethtool, the request is silently ignored
because 10000baseCR_Full is not in ice_adv_lnk_speed_10000[].
Add the missing bit so that the mode is recognised and the
driver correctly programs the PHY.

Fixes: 982b0192db45 ("ice: Refactor finding advertised link speed")
Cc: stable@vger.kernel.org
Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 301947d..49b9376 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -367,6 +367,7 @@ static const u32 ice_adv_lnk_speed_5000[] __initconst = {
 static const u32 ice_adv_lnk_speed_10000[] __initconst = {
 	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
 };
-- 
2.52.0


