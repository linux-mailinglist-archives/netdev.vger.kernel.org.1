Return-Path: <netdev+bounces-277972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKauBbib3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3B3E844A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA1530166FC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4133939B9;
	Mon, 13 Apr 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myWNNXZx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8B33066E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065444; cv=none; b=Dwsyl8QPP9WEa2Y9aFMJuCPsd610wej6VKK9cGj6C3MGMcDWlOeGmTSZ3FDZedeiZlhEjKnRI2nqntdxBqSEnmOH2dTDWmy9kC/AKNNkUIVlGxiAG/edIFZKtV944KNxBAqKn+vweO6Yn1Qgk7DakcLGcF2+Pr1Jtm51msrXN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065444; c=relaxed/simple;
	bh=BEQZpYdie0qiN2xtDyQz59CbnPWVsowDYUJhO2NHgJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCpjZsPfEhhNm98TmWPza6b6HYPh4PKDrVVRXQAnIU3z+fdfwZ3N7A9pDzObEXIIoy3+c8E0H43Fr7mtlZjW36ZNDPq5BDW178eJyOF5bUgxMh2I003WFHu7GcX7bJf/mxQ1ix/Q5fhJupqN5ZJN3tKhM7F1ZxbCtxguHfx7EzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myWNNXZx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776065443; x=1807601443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEQZpYdie0qiN2xtDyQz59CbnPWVsowDYUJhO2NHgJ0=;
  b=myWNNXZxwgAF1tS3KrbQP8MqQkJUzxg9+/9oGPjT8pU4z37Tyg4N1g7b
   h+LH+RqwLdoqPl5iVqy+HNhmdThtSgnVMn4Bc2N5Q+7U0WoTQ/B7OaURp
   eC5lKo1kV7Tbx0ay7q6AxMN0XstSL4ZcJM8ywxG5ioyTCNj3+AcNImsdm
   yVvHlxavLO3WNvumIquNw1ouyd4v4wOR7Dvr6ntV3+GR4maFUkQArwT/5
   J7ovuKNBuJUd9MXBDUdv6Ja0SaEmShoyQBuewDV1Idq17NAw3bTVvtttL
   dACWO9D5Jh/ztkkk8FUyvIblGvoFRqrGv/f0dZP8Yc5iNEH9oXrcz1Ajd
   A==;
X-CSE-ConnectionGUID: 4vAzV2DQSOaZhSfXtJEBuQ==
X-CSE-MsgGUID: FhOzfFSLQkKj9C678HrRMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876633"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80876633"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 00:30:42 -0700
X-CSE-ConnectionGUID: OUEEpF2+TKa8ZrxWFrbaog==
X-CSE-MsgGUID: +/NwIoe9QEWOv7dHNLPQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="267700551"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Subject: [PATCH iwl-net 3/5] iavf: prevent VSI corruption when ring params changed during reset
Date: Mon, 13 Apr 2026 09:30:33 +0200
Message-ID: <20260413073035.4082204-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277972-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: E2D3B3E844A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>

Changing ring parameters via ethtool triggers a VF reset and queue
reconfiguration. If ethtool is called again before the first reset
completes, the second reset races with uninitialised queue state and
can corrupt the VSI resource tree on the PF side.

Return -EAGAIN from iavf_set_ringparam() when the adapter is already
resetting or its queues are disabled.

Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 1cd1f3f..3909131 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
+	if (adapter->state == __IAVF_RESETTING ||
+	    (adapter->state == __IAVF_RUNNING &&
+	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
+		return -EAGAIN;
+
 	if (ring->tx_pending > IAVF_MAX_TXD ||
 	    ring->tx_pending < IAVF_MIN_TXD ||
 	    ring->rx_pending > IAVF_MAX_RXD ||
-- 
2.52.0


