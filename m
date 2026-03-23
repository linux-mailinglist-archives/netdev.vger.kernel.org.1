Return-Path: <netdev+bounces-270697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GATaE7SUwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6F2FC487
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E498B30A34C2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0623947BD;
	Mon, 23 Mar 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9FMTKFc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B739478B;
	Mon, 23 Mar 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293934; cv=none; b=oRZOxh+IYKBpFxZslgqP8u8ImbS2Ng0W2Y+B6/k7i7c70+1hzikuoLp4QrwtNQ9XDbHc7r3nKl6Ib+xz+sTsJ+MRlVs48pA/S1bXfjp/rv9myKDZvhElSwqzlWjN7nOL2Q/O4d+ezGI+vtWzwwZciUdJd1O4juheJz8cEPHBfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293934; c=relaxed/simple;
	bh=oluwlQFzzCfiu8mfA4R0GeAYSOqtZbYrzFHAiZhWfA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4wCwTh8HO9MdRQg0dO6ihhWDrkvrRiOBrJK2PiQSwDQXzLf4QpxOQbKJfgA6/l2dZy/GFTewGEALbI47NjSTi9PfXHX9iVWNGeMp6mqYDF5FC878ItIsRyBEdavrj55CBnl6EupO6TxVSPNvHVApAf7KE0lnywbgDjxgfk/Cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9FMTKFc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293933; x=1805829933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oluwlQFzzCfiu8mfA4R0GeAYSOqtZbYrzFHAiZhWfA0=;
  b=J9FMTKFcD7cp25bcwb4zsldT5zfzhKwRc8fOd9bFtM6Yk2W/GobIJ+p7
   kVen4vwWcmbs6CtKwQmL1BaWIMgrSRKm7plcCKLwa79PbpslQF6za0Fkw
   dGoprtAztFgP9NZ2L11TfBKDCfFeWVtmpiUYV7T2XWNok0dW0eK+S/4Xd
   BmGKC+ion8Nfv8ANjEZJhi4mq+8/w0oQLtcPZiEl6EP0KAfo3aeWyj/Uo
   vFL4a9XqgDpRNO5A/m0LIW8/Ws4X73WtI/bTkmDMkvigda1YoAniLkMz/
   GlOFNa8wTjMMoqtdO1fEnx/TKTZoxqnc9wAyr20boO78HJwfY/vzar3eg
   Q==;
X-CSE-ConnectionGUID: wZkOrJfhRwuTBdkwCGe7sQ==
X-CSE-MsgGUID: eAsS0qBFRuCtr2ezocgRvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013364"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:33 -0700
X-CSE-ConnectionGUID: qxUpo48NTT6elE5JhhKW3g==
X-CSE-MsgGUID: 04qp6Xz6QqmcVeDVpt+ecQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187928"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:31 -0700
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
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 8/8] idpf: remove xsk frame size check against alignment
Date: Mon, 23 Mar 2026 20:24:57 +0100
Message-Id: <20260323192457.504631-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
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
	TAGGED_FROM(0.00)[bounces-270697-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: BFD6F2FC487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We provide alignment within xsk_pool_get_rx_frame_size() now, so this
validation is redundant.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/idpf/xsk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..a5b6177fd44c 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -558,16 +558,6 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 	bool restart;
 	int ret;
 
-	if (pool && !IS_ALIGNED(xsk_pool_get_rx_frame_size(pool),
-				LIBETH_RX_BUF_STRIDE)) {
-		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
-				       "%s: HW doesn't support frames sizes not aligned to %u (qid %u: %u)",
-				       netdev_name(vport->netdev),
-				       LIBETH_RX_BUF_STRIDE, qid,
-				       xsk_pool_get_rx_frame_size(pool));
-		return -EINVAL;
-	}
-
 	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
 	if (!restart)
 		goto pool;
-- 
2.43.0


