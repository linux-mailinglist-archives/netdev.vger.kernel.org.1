Return-Path: <netdev+bounces-158287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B3A11539
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E711B1883FEE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B11D5143;
	Tue, 14 Jan 2025 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlY1wm8O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A11E4AE;
	Tue, 14 Jan 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896711; cv=none; b=LwCpOw9Rc+H+IqUDVsKFUmP//odFovMY5pQa2USZmeA2uSY4WaTwQWkHgDbVgrfcgUY/79IY0kujBAFdUEsQ2nN0LAk+S11T73lXcNukiGRxKJEvDLd7La/k3xCC7zCEex2SKXvtROoRv4k63dzvnMQnQkaYxxch6kNrmneYvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896711; c=relaxed/simple;
	bh=DeQxjHBk4IBUkeU6pTbydiFb7KZTGq6XP6rGHm950KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sxx2sYY4q4sELLO9CPZXWCfxW9HDytiQM3BBVUQ51q2F4Ya3Emy/stuIgjV6kCmBqp5c2BUYshJzgG34WTMe7qP8BWJlvh+C7DrQ+/FK7BscVt7YNZV6sd01DGsz2MF9Y/oR586IQVCY6m7if9kVRmDQVYeWQsv8tgatuwnwVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlY1wm8O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736896710; x=1768432710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DeQxjHBk4IBUkeU6pTbydiFb7KZTGq6XP6rGHm950KE=;
  b=MlY1wm8O7Cz1Xq3pyd6eQbNVz7hpxbeJdtj3onEAiWtadPAaTPyJryBP
   1d43kWFwFEZhkzF9NYTJwC23Gqa17s8PbWUs3LfgD1l3T808CrnjIzXKX
   yT+HyFnzyFtr0vGt91JNgEiTLcpbDkVlgDWwodv3BPv/usITq6q/slzy7
   N/Vh20IeuJFozrVYfaB7H7H6S77y8zJIoMzTklZOT0cjZoK5/PdkMTgwY
   UysVINOPCi42vvu9lNqzRWallJxdN5ukft9PAnFUPOldfTajBbzwIsc+u
   DoxbgHuyV1NAv2jJzv9EJ2zYMpC3b530LFdMo7pHq4Pe+FupCjCktgYC0
   A==;
X-CSE-ConnectionGUID: cvWIod+fQSKbjmVwu0ph5w==
X-CSE-MsgGUID: /J1nEJtRTC+aLeZWcVmEgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36911044"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="36911044"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:18:28 -0800
X-CSE-ConnectionGUID: jkWNoME/R4CEcxvBTqTJqw==
X-CSE-MsgGUID: 11erSqDASgWkH3VZqQtjFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="105034110"
Received: from p2dy149cchoong.png.intel.com ([10.107.243.50])
  by orviesa006.jf.intel.com with ESMTP; 14 Jan 2025 15:18:26 -0800
From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/1] net: ethtool: mm: Allow Verify Enabled before Tx Enabled
Date: Wed, 15 Jan 2025 14:59:31 +0800
Message-ID: <20250115065933.17357-1-chwee.lin.choong@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current implementation of ethtool --set-mm restricts
enabling the "verify_enabled" flag unless Tx preemption
(tx_enabled) is already enabled. By default, verification
is disabled, and enabling Tx preemption immediately activates
preemption.

When verification is intended, users can only enable verification
after enabling tx_enabled, which temporarily deactivates preemption
until verification completes. This creates an inconsistent and
restrictive workflow.

This patch modifies ethtool --set-mm to allow users to pre-enable
verification locally using ethtool before Tx preemption is enabled
via ethtool or negotiated through LLDP with a link partner.

Current Workflow:
1. Enable pmac_enabled → Preemption supported
2. Enable tx_enabled → Preemption Tx enabled
3. verify_enabled defaults to off → Preemption active
4. Enable verify_enabled → Preemption deactivates → Verification starts
                         → Verification success → Preemption active.

Proposed Workflow:
1. Enable pmac_enabled → Preemption supported
2. Enable verify_enabled → Preemption supported and Verify enabled
3. Enable tx_enabled → Preemption Tx enabled → Verification starts
                     → Verification success → Preemption active.

Fixes: 35b288d6e3d4 ("net: ethtool: mm: sanitize some UAPI configurations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Reviewed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/ethtool/mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 2816bb23c3ad..8a66ea3148d1 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -214,8 +214,8 @@ static int ethnl_set_mm(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -ERANGE;
 	}
 
-	if (cfg.verify_enabled && !cfg.tx_enabled) {
-		NL_SET_ERR_MSG(extack, "Verification requires TX enabled");
+	if (cfg.verify_enabled && !cfg.pmac_enabled) {
+		NL_SET_ERR_MSG(extack, "Verify enabled requires pMAC enabled");
 		return -EINVAL;
 	}
 
-- 
2.34.1


