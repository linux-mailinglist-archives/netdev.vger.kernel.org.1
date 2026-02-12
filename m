Return-Path: <netdev+bounces-258492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ABBLtMkjmlrAAEAu9opvQ
	(envelope-from <netdev+bounces-258492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:06:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDD1308DD
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3496F30F62E8
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0A3570D6;
	Thu, 12 Feb 2026 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jm5m4xbw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FA344D8D;
	Thu, 12 Feb 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923009; cv=none; b=HgMADknr0YMl1kw1zDZ1YNfy3sIhoiWEI4Mcqo0q0AVUfs7WnkSVX3ad5YEn4V0vBzmtnNswisvjJ7A7viBX2jrQ2Ne/ZXht/KLXy8Ml5BwU8blUWyvGNwI4YZXlqohF1cVAxhkSSM6JPDDTWHV/0Tl53guLW5R5z+hZh+lO93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923009; c=relaxed/simple;
	bh=JE0C6b7Po6nb+SOJSwLm3q0OgKRucrNQZcdmHovdwT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsvLxDxaQR9QAoSgAeYvegix3jOJEAsWX3xLmlluy+8ZXorycr432Gv3EmFGPijkrLKxVBhkZfAe8iKi65M/pRQImzyqNPawv595iuOV0Qg2Qr2/xQLWWd868sntwPAVTeLjsFH1VesM581Tfcye6HMfnRHpXe94CeURRCdHv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jm5m4xbw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770923009; x=1802459009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JE0C6b7Po6nb+SOJSwLm3q0OgKRucrNQZcdmHovdwT0=;
  b=Jm5m4xbwnQIFWtchVb9xOY/YZm2+aSY2/nHLpC9dZ5HtHznT851VtYUT
   P++ly18pUy5GzK3q2asslOPFhcSgs6GFS4VmHeScB2/8gD5ejFGImrE5G
   yEGZWhCkaYXMZmtL0k8E2QhIX4Qru71yB7lUlrBfoKLvL7t4XioMJXZCx
   vrF+Q2NQQujvrTTQN1elBLw74vkMYFiaGYTIKtIgOJKBmb169/H0HfBgt
   MX8xhFx4SCKl+r5PGzYAU+qD/vs9tE1L4xaL0t/7L3kAZnDNheiJX2RCp
   LQMCbV7Opq9hf1dLh+YkJRZteFSSKP+/bkA859ow1pf18ecBO6NkELbIr
   Q==;
X-CSE-ConnectionGUID: YmN8cZwuTaKrbm0X0VnV+Q==
X-CSE-MsgGUID: hrvWIIz8QpClTzvqmHo1Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="94746030"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="94746030"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 11:03:28 -0800
X-CSE-ConnectionGUID: YCiwgCQ4TmGUPWUxmGdPHw==
X-CSE-MsgGUID: fHKWl1iOS2uNELrZbKjFzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211921998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2026 11:03:21 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D9BB932C94;
	Thu, 12 Feb 2026 19:03:17 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH bpf v2 6/9] i40e: use xdp.frame_sz as XDP RxQ info frag_size
Date: Thu, 12 Feb 2026 19:33:21 +0100
Message-ID: <20260212183328.1883148-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212183328.1883148-2-larysa.zaremba@intel.com>
References: <20260212183328.1883148-2-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-258492-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 34CDD1308DD
X-Rspamd-Action: no action

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size instead
of DMA write size. Different assumptions in i40e driver configuration lead
to negative tailroom.

Set frag_size to the same value as frame_sz in shared pages mode, use new
helper to set frag_size when AF_XDP ZC is active.

Fixes: a045d2f2d03d ("i40e: set xdp_rxq_info::frag_size")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index eaa5b65e6daf..f91157774f1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3563,6 +3563,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	u16 pf_q = vsi->base_queue + ring->queue_index;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_rxq rx_ctx;
+	u32 xdp_frame_sz = 0;
 	int err = 0;
 	bool ok;
 
@@ -3579,11 +3580,12 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
+		xdp_frame_sz = xsk_pool_get_rx_frag_step(ring->xsk_pool);
 		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3596,10 +3598,11 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 			 ring->queue_index);
 
 	} else {
+		xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3610,7 +3613,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
-- 
2.52.0


