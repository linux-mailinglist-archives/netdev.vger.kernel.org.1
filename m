Return-Path: <netdev+bounces-268234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE2AI0BDuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E129E8F4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C3E4308FF0B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3A332EDE;
	Mon, 16 Mar 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9nIBfdA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A833AD8A;
	Mon, 16 Mar 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683204; cv=none; b=p3arKwtX51njlQ47+iO5tsSwhgmhltJvD/E0PzOEyYyHuUeFdT2hgkr7XVc5doMZGlZ3FXkhrPy9GIVe5ySAGt2c08e1ryKEyUaJ50to75UMDcYOuueBC5l1YxR/KFQMlT5TkRD3CJPnnhbCwFTLaITuM4EouJLCTAa36ew9RyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683204; c=relaxed/simple;
	bh=mUaN9OyVf9HbCRicI/4FWvNTeCTlSydlvJ4GVQj7bGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVYCy0u7FEVNk+7B1KPMO/R0CRaFpuZZCbN/LwkAVdd6Q2bf/PVmjKGFrQkB1hhxI6T1u1nB4RU7AifNhIgltctMLijJL3/4oUOEbzoM+lSTTZTcXmgbrQMFQZm1RpkeAWscLJlMlwPG68DnnXp2hmJTZsOZQ9p3CR41NXHDt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9nIBfdA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683203; x=1805219203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mUaN9OyVf9HbCRicI/4FWvNTeCTlSydlvJ4GVQj7bGg=;
  b=N9nIBfdA5eTOnIo2ybZPu0jKt47wtfe2Y01cz1U79lPQy7iGM3Z2AtLP
   OK88nqZWgYwWH5e0yhY54/m70JTbldy/Kom5pyJnRRXA87Ko1RZK1kq9D
   iTe0YHetiOjeqnkx+tWx0sMXU7uBCEYW6oDNDUGorf302P0jGpcf32ibo
   GHr68RfrxZn2XX7YefWt0/i8irqMh9sKLgC5Vz2FmZQ98IpMKB7LQh6x4
   oDBHgB3Dhj7lD+2japmdrkyl97a3PXyFQaMDXZqskO4b1RuifLb+fo4rd
   IwzwvQ5OAsAMbRGKXLLMahzbFoOZEgSuEqfBlzwb1/a0pkQ3yRBOvzCRG
   g==;
X-CSE-ConnectionGUID: /qHtbq0RR+u3C6co0cQYEg==
X-CSE-MsgGUID: Wn7P1qG9SV2LPkhwKSPjww==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275721"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275721"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:42 -0700
X-CSE-ConnectionGUID: uBqSR16yRUyCepRJfYKn8g==
X-CSE-MsgGUID: uZAy85NtTji1O+vE+imavw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075747"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:40 -0700
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
Subject: [PATCH net 4/6] xsk: validate MTU against usable frame size on bind
Date: Mon, 16 Mar 2026 18:45:48 +0100
Message-Id: <20260316174550.462177-5-maciej.fijalkowski@intel.com>
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
	TAGGED_FROM(0.00)[bounces-268234-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0B5E129E8F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AF_XDP bind currently accepts zero-copy pool configurations without
verifying that the device MTU fits into the usable frame space provided
by the UMEM chunk.

This becomes a problem since we started to respect tailroom which is
subtracted from chunk_size (among with headroom). 2k chunk size might
not provide enough space for standard 1500 MTU, so let us catch such
settings at bind time.

This prevents creating an already-invalid setup and complements the
MTU change restriction for devices with an attached XSK pool.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 2cfc19e363e3..0a6d76df97dc 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
+	bool mbuf = flags & XDP_USE_SG;
 	bool force_zc, force_copy;
 	struct netdev_bpf bpf;
 	int err = 0;
@@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		return err;
 
-	if (flags & XDP_USE_SG)
+	if (mbuf)
 		pool->umem->flags |= XDP_UMEM_SG_FLAG;
 
 	if (flags & XDP_USE_NEED_WAKEUP)
@@ -200,11 +201,19 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
+	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
 
+	if (!mbuf) {
+		if (netdev->mtu + netdev->hard_header_len >
+				xsk_pool_get_rx_frame_size(pool)) {
+			err = -EOPNOTSUPP;
+			goto err_unreg_pool;
+		}
+	}
+
 	if (dev_get_min_mp_channel_count(netdev)) {
 		err = -EBUSY;
 		goto err_unreg_pool;
-- 
2.43.0


