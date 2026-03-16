Return-Path: <netdev+bounces-268233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOAkJjFDuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:51:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF229E8DC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35EE6308C749
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CE33A9F8;
	Mon, 16 Mar 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC0Zw45Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB933BBAF;
	Mon, 16 Mar 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683202; cv=none; b=XqdjoFhxGAjFGcVxa6407jxRf5iZN1rYHgrz5yA61/DnP99S42O1SHODsoDZ5+deke3w5ZZZAUcVn+fzl1HgHKTkhQP6qkVhRiKtjClV1AnsZWEiacA7JBdM8rciT8hMdTv+YQCxmO2LkVNyQ6Uz5dlDm/1W2P5OkvzmGb141Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683202; c=relaxed/simple;
	bh=GSNjTvX6rPE2U6QE5SmWIoplG6IQUGCakMAmfogFQUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCgJLE7VAWTG7Gld9x9lIyiNDVVta5yEc3t/NPicOH08UlH3gGZUnBo9eq6UTY6IDlgTBnZ8YCCGsOdwXI9uFUut59X/IAoY+/XSLnko56y+2R+K9xK9x3D9K6qVfnqg8RYNqyH7q6asPX1dVkHRD0Jph2NgNzswqnaTjNORinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC0Zw45Q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683201; x=1805219201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSNjTvX6rPE2U6QE5SmWIoplG6IQUGCakMAmfogFQUo=;
  b=FC0Zw45QU7qfOWO7luFeux18ek8V/26DSTAg+HVx3bG2XZki69CZjq5/
   U/zLbbLRL7H2y36bMZCcPexqIPd5dgYpPgb/sg6bqjCNbk9EHFhUNOu06
   P2JxfpGkD0O009kGt9WB0jPinzNvjMFK0zxZ0nerS41bh8z1KhN+h84p9
   6BECUlo4P6/SiwMLsuNZN34ZjxmceITolf9nGrD7EEZZ7Yfi1ckgzx3oE
   p0C8h/z9xC30TKK21ynUc0Gt2JvH8WeQG/ii3G6GPsbB919oTj3I9/9DS
   q8LjW9S4ZWIYrJju+kvka3+xGCZGiVTEqHeu5GjWFUPwT+uztT9Z09BAZ
   w==;
X-CSE-ConnectionGUID: xbD7L3XjS2uBCSSJ8fHQZA==
X-CSE-MsgGUID: 5vcxNw27QU2b+mI/1tbovA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275711"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275711"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:40 -0700
X-CSE-ConnectionGUID: tjUsOBb3SaeMsgwrWcs3GA==
X-CSE-MsgGUID: Yd4u7mUcRVSTic6twFEGaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075742"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:37 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 3/6] i40e: do not round up result of dbuff calculation for xsk pool
Date: Mon, 16 Mar 2026 18:45:47 +0100
Message-Id: <20260316174550.462177-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268233-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 0FDF229E8DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When programming dbuff on rx queue context, avoid division round up as
it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
example based on 4k chunk size when xsk pool pointer is valid on given
rx ring:

chunk_size = 4096
headroom = 256
tailroom = 320

ring->rx_buf_len = 4096 - 256 - 320 = 3520

rx_ctx.dbuff = DIV_ROUND_UP(3520, 128) ->
3520 / 128 = 27.5 -> round up results in 28

dbuff programming unit is 128. If we give 128 * 28 = 3584. So HW will
corrupt 64 bytes from tailroom. Doing plain division will floor the
result and would not exceed reserved space at the end.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 926d001b2150..f37cf6ab4461 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3621,9 +3621,11 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 skip:
 	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
 
-	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
-				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
-
+	if (ring->xsk_pool)
+		rx_ctx.dbuff = ring->rx_buf_len / BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT);
+	else
+		rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
+					    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
 	rx_ctx.base = (ring->dma / 128);
 	rx_ctx.qlen = ring->count;
 
-- 
2.43.0


