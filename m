Return-Path: <netdev+bounces-124653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B296A61F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD02280FA4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7318E741;
	Tue,  3 Sep 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBJrJ7D1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0AF9DF
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386720; cv=none; b=XamleO9Km85QfGJnM/tSUWOLBLrZp8sW4Oafoea5y7r4RXgLSojFKC2E1bQLeVcB51Dbz6CWT/oJbOlNr/1GQUQf5Uxs1OyHF1tZw8PmP4ZbyjKJu84aX0giLcPagTr/BqKB94wEmKh1i02Ryf19tzQFQKsDxBxSzORDH9TkE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386720; c=relaxed/simple;
	bh=JNB7eVi/plSuaPSjON6V8FY+DiIBoUooLerZoJuOrMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IVyCjB7fOfdAXO5H9cyhQB4lzb5evzLm39B+QNyA1D8X83ExoXUFvTcfEwAICF5e5eAUfc/oYgv65cSs2V8aKRO2cwYVGFW50GCMgUNG5yz5INnVZ2mKsYen79YtvmQf4suEJA4MrVgXKZgBRLSkXxAET+yjkvUPSHXJjlV+Iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBJrJ7D1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386719; x=1756922719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JNB7eVi/plSuaPSjON6V8FY+DiIBoUooLerZoJuOrMc=;
  b=fBJrJ7D1ZvVUZpOoVpOUqxFomLzpVlbriFHTlzYbsB9HInqDzm0UKHr5
   SxjyBLAlYoyg/pxzi/0C9GpTxjF2VdYk46O2tbcFZ3KeTXC40yKTlCmcb
   r7sxgNFEjPnJMd7ObKb58enHN4wJlL+8/fM2ehmwI7F7553Uc0cdVtbLe
   /ST2lqSNe3EsTCHZidcMJ7FaArEHG4g14E2LT9KV1wfrnrpf3XG15SuZL
   fFbL3UhITkJpekWDG3Abxfc70M1bRsjdz6yERDXqg4tRvvwHFJHSoBtOg
   9Su47uaod79MjRu+BdQOzrZmYk35DeIGYaAY11c/Yrn2ueouI7iPaTILJ
   Q==;
X-CSE-ConnectionGUID: YivTt1dRQFObcRYdCrtSfA==
X-CSE-MsgGUID: +W9Gfo4rQ/qhu2eNo57N+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27800360"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="27800360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:05:18 -0700
X-CSE-ConnectionGUID: CQS2bXf9RHeqQ2lsClI6MQ==
X-CSE-MsgGUID: UsJ0wBtDR4GJWgLTsC86iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64813358"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 03 Sep 2024 11:05:17 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Dries De Winter <ddewinter@synamedia.com>
Subject: [PATCH iwl-net] ice: xsk: fix Rx allocation on non-coherent systems
Date: Tue,  3 Sep 2024 20:05:11 +0200
Message-Id: <20240903180511.244041-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases when synchronizing DMA operations is necessary,
xsk_buff_alloc_batch() returns a single buffer instead of the requested
count. Detect such situation when filling HW Rx ring in ZC driver and
use xsk_buff_alloc() in a loop manner so that ring gets the buffers to
be used.

Reported-and-tested-by: Dries De Winter <ddewinter@synamedia.com>
Fixes: db804cfc21e9 ("ice: Use the xsk batched rx allocation interface")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 240a7bec242b..889d0a5070d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -449,7 +449,24 @@ static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
 	u16 buffs;
 	int i;
 
+	if (unlikely(!xsk_buff_can_alloc(pool, count)))
+		return 0;
+
 	buffs = xsk_buff_alloc_batch(pool, xdp, count);
+	/* fill the remainder part that batch API did not provide for us,
+	 * this is usually the case for non-coherent systems that require DMA
+	 * syncs
+	 */
+	for (; buffs < count; buffs++) {
+		struct xdp_buff *tmp;
+
+		tmp = xsk_buff_alloc(pool);
+		if (unlikely(!tmp))
+			goto free;
+
+		xdp[buffs] = tmp;
+	}
+
 	for (i = 0; i < buffs; i++) {
 		dma = xsk_buff_xdp_get_dma(*xdp);
 		rx_desc->read.pkt_addr = cpu_to_le64(dma);
@@ -465,6 +482,13 @@ static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
 	}
 
 	return buffs;
+
+free:
+	for (i = 0; i < buffs; i++) {
+		xsk_buff_free(*xdp);
+		xdp++;
+	}
+	return 0;
 }
 
 /**
-- 
2.34.1


