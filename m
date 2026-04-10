Return-Path: <netdev+bounces-277296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ba+K7mr2GlPgwgAu9opvQ
	(envelope-from <netdev+bounces-277296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 326263D3960
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A41843024A2E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B53A4F34;
	Fri, 10 Apr 2026 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGinrlyO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BA3A4522
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807381; cv=none; b=aZfUEM+FrleFRYs49CnsRLysc/mM1gYcZNi91iN5mG+mvKNQcdWG11tsCeljZNhK6RggC2bm10daon3FRXGkGYy14gvRKtUuQqjA4L/E3fze/STVNc0fXhSg9rhNLuwoiqdFyQfQfgfgS74GRPzdcfxv1z/GfuKfadMhi7HN/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807381; c=relaxed/simple;
	bh=PNmvSsiYs6voba6SHGZCYMS5ecS2d3YIYMk9i1Eb4ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcSkacbO9oIz8/G2dJJv702aMHfL02E1/3tpAniTpMwpIqum0Ij/kZReGFw4uLGdGXeZumcN8D+4ee5vM/fcHSWVu0yP5xlSRx5VK3nFLkRvr6DkN/99qG6DpBncIPuaS3wf02S3T4BhRBrp1cKMo2IG7PDpTDNMMlhemlWhDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGinrlyO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807380; x=1807343380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNmvSsiYs6voba6SHGZCYMS5ecS2d3YIYMk9i1Eb4ws=;
  b=GGinrlyOSsnNCPiawLo9aXbPPLCMZWFwkpi3GNtVF/7+QopaUwVMsyjm
   YakjuNG5JFjQ3BPwX8JFcaHAhYxjqz4GF0bNwB6K8k5nH3Dp0xCmVcNmB
   I0qkW53cQVDs2zC4B0A7Fnk+2hp87EuhSioos0hcY601dgmwx3HyXAI8u
   cpb829gMlky3YfW7Y6WCnbwNU/D0vx6RrD/A6Nbjl21AiNFrsEknVE1Vl
   t6eGwKaHe7MQlJA/s1JdJ+W690wsi76lLRo3hqfc/YGwppSipzg+BnEcZ
   lGMc6f38FhgU2xuCg9rQbFN7Jrd8AqG2awvom27Awr9qAV41IFuqKieWc
   A==;
X-CSE-ConnectionGUID: B2CemfdLRuqt8KDhMXcNbQ==
X-CSE-MsgGUID: eKc9lgNMSmqsw4UtVzWv1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007950"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007950"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:40 -0700
X-CSE-ConnectionGUID: ZbZsCUP1S1C+llfhrU/NsQ==
X-CSE-MsgGUID: SJArTDoyT1CCCo9FeWjQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941914"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 10/10] ice: promote Tx FIFO drain timeout message from dev_dbg to dev_warn
Date: Fri, 10 Apr 2026 09:49:21 +0200
Message-ID: <20260410074921.1254213-11-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-277296-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 326263D3960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The message emitted when the Tx FIFO fails to drain within the
timeout period is currently at dev_dbg level, making it invisible
unless debug logging is enabled. Promote it to dev_warn so that
users and administrators can detect Tx timestamp path issues
without enabling extra logging.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 801a6e66..841c999 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1108,9 +1108,9 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 		port->tx_fifo_busy_cnt, port->port_num);
 
 	if (port->tx_fifo_busy_cnt == ICE_PTP_FIFO_NUM_CHECKS) {
-		dev_dbg(ice_pf_to_dev(pf),
-			"Port %d Tx FIFO still not empty; resetting quad %d\n",
-			port->port_num, quad);
+		dev_warn(ice_pf_to_dev(pf),
+			 "Port %d Tx FIFO still not empty; resetting quad %d\n",
+			 port->port_num, quad);
 		ice_ptp_reset_ts_memory_quad_e82x(hw, quad);
 		port->tx_fifo_busy_cnt = FIFO_OK;
 		return 0;
-- 
2.52.0


