Return-Path: <netdev+bounces-267416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIYIK6nzs2nYdgAAu9opvQ
	(envelope-from <netdev+bounces-267416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:23:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B92822FD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B44CF3066E4D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D233845B5;
	Fri, 13 Mar 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUmbEiNk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313519D093;
	Fri, 13 Mar 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400784; cv=none; b=QtB6l2FHbj+j7Y31ILAV9xsXoVMq15R0eLWsXjqdv71mQE/P33BL8wVWroS1ogvtLkkSezXgk7LrtXpvNi4I1uyG7MsPpd2Ok46it5eE/jZbu8nnbbHjYd/I1RupL79H8Jmg7e705CydKc6RkrvWNy2i9iMJJ2VZlCw2HB59qOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400784; c=relaxed/simple;
	bh=2bKNUHKO9OVnDiP4Hey8zgOy5NyoxQZu+h+aV1L5+kM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OaFPHrM+pZ2yP4zEuLp+pOnqSMNCSsqFzHa3ety8bDVOLJFx1MwpaFyEAKxWLB74cN9o6L+p0Ckq2lA1HRpxOfvazoSy+D2nI2rcLNvuRHQw6oY4QBGUlNgt8Z3rsr/7uIsVeKCkIHhdRPHzCA8S2Wdyok4t0AOJqcOxrxQF2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUmbEiNk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773400783; x=1804936783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2bKNUHKO9OVnDiP4Hey8zgOy5NyoxQZu+h+aV1L5+kM=;
  b=IUmbEiNkO4Ey67QWmuZC5ppwq8bL8BYIIARjxyuUVG/xgAla9AFCL14z
   QaATciJOZ/zaJXIOdSJ2ZP5/WeF4B40SgmU/062LUsW/1KP81NYXyo0XJ
   65PiE0xtutbQmH6woHvS7tQLqAC0LBtrG/Wi8hnTOlP6tCyjkak+1GuLt
   cfmAl7FGKr8Vckp0u6QrEoT21TzRNQqXGUh5RmAlSl7JsCE4YvVWZ3R3l
   0IcdpCpjC4a88Ep5akKgbf5na9j9b1ieB8M+eh0uz/YB0FrqsuVJa3TIp
   okQbUfI88074TdAHNih7BzHGv3Gx5xDQOyWg64+BhxxcDDF0/k2I1tJiP
   w==;
X-CSE-ConnectionGUID: U4upy9rRRRKuFqqXqjlYwQ==
X-CSE-MsgGUID: 4NIXrUYlQ1uKkcZYajZXIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78396710"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="78396710"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:19:42 -0700
X-CSE-ConnectionGUID: p0y83sdjTRuiB4PuOvBFdw==
X-CSE-MsgGUID: 0k3ON2bTTo6WvrMh8jNhQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="221347191"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2026 04:19:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net-next] xsk: remove repeated defines
Date: Fri, 13 Mar 2026 12:19:31 +0100
Message-Id: <20260313111931.438911-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267416-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 145B92822FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Seems we have been carrying around repeated defines for unaligned mode
logic. Remove redundant ones.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2: remove another repeated define (Stan, Paolo)
---
 include/net/xsk_buff_pool.h | 7 -------
 net/xdp/xsk.h               | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 0b1abdb99c9e..ccb3b350001f 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
 	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
 }
 
-/* Masks for xdp_umem_page flags.
- * The low 12-bits of the addr will be 0 since this is the page address, so we
- * can use them for flags.
- */
-#define XSK_NEXT_PG_CONTIG_SHIFT 0
-#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
-
 static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 						 u64 addr, u32 len)
 {
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index a4bc4749faac..7c811b5cce76 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -4,13 +4,6 @@
 #ifndef XSK_H_
 #define XSK_H_
 
-/* Masks for xdp_umem_page flags.
- * The low 12-bits of the addr will be 0 since this is the page address, so we
- * can use them for flags.
- */
-#define XSK_NEXT_PG_CONTIG_SHIFT 0
-#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
-
 struct xdp_ring_offset_v1 {
 	__u64 producer;
 	__u64 consumer;
-- 
2.43.0


