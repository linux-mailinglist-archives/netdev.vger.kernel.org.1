Return-Path: <netdev+bounces-272416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHwDA+AyxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC4340784
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B82B30612AC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29373CD8AC;
	Fri, 27 Mar 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REHFJNi2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401534DB72
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596674; cv=none; b=Gt/6HxdCJEwsxMUS4AXL0EV54a5zSVMWy19PYextpjs1ErEsHRgeh/KehTnDG0YtxxNqQiLyEWD7S0SVnRSrkDZunXiuC99gPrVridjt5Qqzk+iEQS25DV7JhRK3fxYxZ08CZOpAqk5TCH+Ojmnq/Y2rZPqps+YdApwJaurm/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596674; c=relaxed/simple;
	bh=GhyhVUi9567WvHp2hgmGCYL2GTomIqZM8EX4xHVseAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6XubXncemDW8GG23T9kPg6XwXdpIYin9czfrA4Zp8SUlY5aRf3Msyouu3VCjRyaMvB6xmwjUp2RKBXhaBOsopO2VxUpE1fuhSAQChM0PyxfTEJ+f06A6xTnOHcFp9x/7lmpNdeM0Uy5Mh4LafovbpIqXKCt+NZsaYcc9J7FR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REHFJNi2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596667; x=1806132667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhyhVUi9567WvHp2hgmGCYL2GTomIqZM8EX4xHVseAk=;
  b=REHFJNi2GAO4nQCKOUvY8qff8dFZeNb7nmgH2iNwz+4le6L4jjO98rU1
   ecvtf86DwluDLdTL5Z+K6DoS9nlg+UpQK8aG+VfWD9m77qMBFUqXeJlCD
   QFlgQh9is2OaQn63bWh/E+s6QfgSsU2Jy4RR355rKjVYTqIpns3+3dEc5
   HYiKCrKdTb16K9Ix459NuzLEpYkGzq8FuV2b8EqUCku6Ho/0m/2F1Zy7J
   ejRIULtxl6Q5boiMoWG7U+dZxTTztIS0scFZVEGlcQ5POndzl9UA12hbi
   CZEAT4QQe9vlpHTjxlDOhfipChSL213FOWOrSHvy4GYTyp2mPwY60VpOn
   g==;
X-CSE-ConnectionGUID: wSaK0JuASH2vFvmSnOt4NA==
X-CSE-MsgGUID: v0c3k4KtTQCgtAGy2om/PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734322"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734322"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:30:57 -0700
X-CSE-ConnectionGUID: kQHlWfSpQc+Hkq5bXt/UQg==
X-CSE-MsgGUID: 499SjdDKSpKu7eVmtKmEOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740388"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: replace GFP_ATOMIC with GFP_KERNEL in ixgbe_fcoe_ddp_setup()
Date: Fri, 27 Mar 2026 08:30:41 +0100
Message-ID: <20260327073046.134085-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272416-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27DC4340784
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Basierski <sebastianx.basierski@intel.com>

ixgbe_fcoe_ddp_setup() is always called from process context (FCoE
offload setup paths) and never from an atomic context.  Using
GFP_ATOMIC is therefore unnecessarily restrictive and wastes memory
allocator headroom that is reserved for genuine atomic callers.
Replace the dma_pool_alloc() flag with GFP_KERNEL.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 011fda9..7fa0971 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -193,7 +193,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
-- 
2.52.0


