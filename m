Return-Path: <netdev+bounces-290651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCfgCQbGD2qJPgYAu9opvQ
	(envelope-from <netdev+bounces-290651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D25AE2FD
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0B69302D185
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F37311977;
	Fri, 22 May 2026 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUxY00w3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D992C375E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418627; cv=none; b=l/EwRiV2SMTId0zdAsMm9NgEOH+ZvVtx+b636Ic9+I1X+9FzbPa69nev8+4BNgNy69GS1MtaZgs8QlWW3jbfCvfrkTJs+g1iI8m3SWCyx5QwgXgUzZ63Z3dzZhxicUTYsgoD74e7rhQTnEtyxAU/Z9MMNWoW1Pv0rpcpUT6+y1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418627; c=relaxed/simple;
	bh=WRrEP0wxmuMbEtGGN8xgtXwm54c5/K1Y+jLf5Bs/DWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aC9jo8bQq1VALqeRbHIy38u3wGeniiBunYhMfTYgus1JW1p37t6f5Dp6Dd6VrXgPm23ABjT9v00PiMLXceR43ThR0+NSOoNBP+xzYqyVA8/2GImNBBeCWysBwy5LKoi3JF2jOXcDfkwDsEDZTCECC9t+Z8EvMiUho3d4eBOfPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUxY00w3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779418625; x=1810954625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WRrEP0wxmuMbEtGGN8xgtXwm54c5/K1Y+jLf5Bs/DWo=;
  b=EUxY00w3fIBooX91xItGUSSu1SFe7Ncfyrp7qH/ROMkfunjvdTvkwiCt
   yJMYGvXH6KhX58pejdV5mG7eMCz6NlDY0qNyQ0IgwRf11134eg7JQSzkd
   avfh/5ROxnA+RIAWsTzB/eeeny3qjV8HMB8ZPrgJLlfa9mon2v/BLnML1
   Ky8ZB6oy2c2PQk5gavbz8epzyKbcUtXqg+gN0zxEHuZQuL+M5eWaRmnQ/
   MybfxiCdcaVxtdq5+BOCUuu47Vuln+h39Nfc4InMGXmRQ9MYcRRnDul3e
   aUXNCYSnQohICAzaoGP8fMeeU6D87raFio54NccKzH9wArziU5s/p90XK
   g==;
X-CSE-ConnectionGUID: FUpHf1ebQ++lAdm5YS1f8g==
X-CSE-MsgGUID: 0u3TOqGeSV+UbYFR8X8G9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105811754"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105811754"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 19:57:04 -0700
X-CSE-ConnectionGUID: i/xnYFoWRaGDmZRVZEpRcw==
X-CSE-MsgGUID: 3UykpI8PSk2WNorjK0kOMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245035636"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 21 May 2026 19:57:05 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/2] iavf: two small logging improvements
Date: Fri, 22 May 2026 04:57:00 +0200
Message-ID: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290651-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 907D25AE2FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Assorted small logging improvements for iavf. Add a dev_info() forwarding
the PF's own diagnostic string when a cloud filter add fails, and print a
netdev_info() when the PF confirms the primary MAC address.

Improvements only, no fixes; suitable for net-next.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Aleksandr Loktionov (2):
  iavf: log PF diagnostic message on cloud filter add failure
  iavf: log primary MAC address confirmed by PF

---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 25 +++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.52.0


