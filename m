Return-Path: <netdev+bounces-273374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJy+L78By2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355773623EB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B5A33047DEE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621483C1989;
	Mon, 30 Mar 2026 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmpDHHgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDBF3E0250
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911782; cv=none; b=BFfmF+mRLF7P8YrTMOKoc1XcmeeVIhrsr4C1Z0ihC/Gi4911ueyxj3SCt+sfWaQm7oFp6LX6gpuer5EwrRMGUWZ35atH6kohnAh1QN12Fs+DhYVcBwWEDhrLJgu0FpumfjZDNAG2o2Uywo5MHg8z/VziwBSXxX5Ila0ZyJDKKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911782; c=relaxed/simple;
	bh=DI3jb6UAacj+TZV+xAUCThJVcD0SCxrhAS8B5wA/V3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSXaLHMnOdoM2vFLxi6fjNTmwytVL6yjN+Nf+a6HxCeeG7H/yeeRO3raPJYyGIAC/Y8gPHUJu8NYSkIVcCymPoB/jOagETTKgRIOPePO+dDaKhjkOnbIvnwcezYMebk0LNgbnY9JPBiXB3CJcNC5eqZh+658Z/pCzbzG8XSyVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmpDHHgJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911781; x=1806447781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DI3jb6UAacj+TZV+xAUCThJVcD0SCxrhAS8B5wA/V3M=;
  b=mmpDHHgJtue7OHFMVVk/LiZQiiJJc1XVb7h8QCH6o3sce2a2UEnEp+UB
   KPNnJk6eeHBc8X2GNY7ANSLscBshe4uIZBFkj9Y0sMD4ia0Mh3COvmFN7
   O/i+3gMA9zO44s9w5pWtMctLTSCl4VQ2rzj6jfxqd5mAIdBkqZ32wVESa
   VEi9YaRHIN26flqe4cgd4esb8JGSAgYVJReUCmpAjRAkHWIHJiGS60nLx
   FaAySnQ/cnGTnOAdKxP0aoNt93gbBgMmHS49DU9drCLpQsQQfFPKi4Y+i
   IcT/qpf7+08zFDvbRwP0yVp1ZgAjmyyLqEjEyfLxReemjulMOkNHlTzg7
   g==;
X-CSE-ConnectionGUID: UZtESdvrR8CfyY/YaUpJXg==
X-CSE-MsgGUID: 2TWq+K1nSWmX2GASCHFYwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297637"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297637"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:54 -0700
X-CSE-ConnectionGUID: fmfoaECER2KNAYNv9WD4hg==
X-CSE-MsgGUID: 6ZXjEdLsR/yZCVRv1awAuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687740"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maximilian Pezzullo <maximilianpezzullo@gmail.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next 12/15] igc: fix typos in comments
Date: Mon, 30 Mar 2026 16:02:41 -0700
Message-ID: <20260330230248.646900-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273374-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,dama.to];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 355773623EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
 - igc_main.c: 'revisons' -> 'revisions' (two occurrences)

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244ee70..031561fdce49 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -172,7 +172,7 @@ bool igc_link_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	/* add delay to give enough time for autonegotioation to finish */
+	/* add delay to give enough time for autonegotiation to finish */
 	ssleep(5);
 
 	link_up = igc_has_link(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ebd831a4ff53..cad5a26cc84d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1794,7 +1794,7 @@ static const enum pkt_hash_types igc_rss_type_table[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = PKT_HASH_TYPE_L4,
 	[10] = PKT_HASH_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = PKT_HASH_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = PKT_HASH_TYPE_NONE,
 	[14] = PKT_HASH_TYPE_NONE,
 	[15] = PKT_HASH_TYPE_NONE,
@@ -7040,7 +7040,7 @@ static enum xdp_rss_hash_type igc_xdp_rss_type[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX,
 	[10] = XDP_RSS_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = XDP_RSS_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = XDP_RSS_TYPE_NONE,
 	[14] = XDP_RSS_TYPE_NONE,
 	[15] = XDP_RSS_TYPE_NONE,
-- 
2.47.1


