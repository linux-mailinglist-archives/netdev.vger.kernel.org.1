Return-Path: <netdev+bounces-262750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD58IwTApWknFgAAu9opvQ
	(envelope-from <netdev+bounces-262750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:51:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F681DD404
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C4A3031AE6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932042F54D;
	Mon,  2 Mar 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCG93sgd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34042F543;
	Mon,  2 Mar 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470190; cv=none; b=Fli1ePHkQQbHIDV4df1jFT87AIQE5ULcZWdOwqOuL1u2x7vpJAr4r3Lk3HveXxGquaJvRsoBSAvnJqWiuBHi719iAPPwHRIp9OmhmtMYeXa/6lVmdnBXeTVjuyB0tCLf/zLhhUMl3gsHYcH29dvY3opyBzcAIoWRrUrzarLTwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470190; c=relaxed/simple;
	bh=srGfWqzOgOXsB5J9nVetuXI137SO4keXEnnAar/4AWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgrRT1QCZbHDj3ltV/2dmw+1j6GBa17CRBWwkC854cGpKsmE4aKPz2c+D73ER0mM/TVBeG1FRSruScd4FsGUIqrY/YL9KJjeIwaFzf7ZxBppICaJ2R/WNFAAehYl4mleuUGmYOMw7qwVUo1h62fK6omklQA/Ypo2CeR8H4ihsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCG93sgd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772470189; x=1804006189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=srGfWqzOgOXsB5J9nVetuXI137SO4keXEnnAar/4AWw=;
  b=MCG93sgdAvCX8djoI3KfTIfzJC8meP+nYVALC0kshvGjc709uC32uAdA
   uaQTiIzCR0UGMHdoS9K3SViDjgPGVwtExvNfNhz3yrP6uHEzuFk4Llwq4
   esbko/SMUV8JIlfKaMPLOyILnqNNdDwuNL6h2PA9rod/TpAFEJHmvAgcW
   e7yRtKa/SVLUKWUj1PzoaZJjbT08j1aT5tjpjzuJ9xZiqBf1H3lF1ux6z
   sFL9GAGZ/whl5CG8a43CtvoZ9y6U2ibHMZSrrWKCOZYhDK5/BeVlQOUCg
   tAoD0zO7DzYD4sNdRTkTG07xumF9xvV0hD4rEPboP26lzSIIbNqnU2/5t
   g==;
X-CSE-ConnectionGUID: eYqwVbk3ReaytleDB0gSiQ==
X-CSE-MsgGUID: 8fmh92LISS20jRD5MqpQNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="76087647"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="76087647"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:49:48 -0800
X-CSE-ConnectionGUID: 5gGNQrJ+R4qwgOfZEfzqCQ==
X-CSE-MsgGUID: cM+9KMr4R7i/0c72Npdcrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="216946953"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 02 Mar 2026 08:49:40 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 13385312C7;
	Mon,  2 Mar 2026 16:49:37 +0000 (GMT)
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
Subject: [PATCH bpf v4 6/9] i40e: use xdp.frame_sz as XDP RxQ info frag_size
Date: Mon,  2 Mar 2026 17:17:19 +0100
Message-ID: <20260302161723.858616-7-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302161723.858616-1-larysa.zaremba@intel.com>
References: <20260302161723.858616-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50F681DD404
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262750-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
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
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 781ec5aa814b..1ef99ae819df 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3567,6 +3567,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	struct i40e_vsi *vsi = ring->vsi;
 	u32 chain_len = vsi->back->hw.func_caps.rx_buf_chain_len;
 	u16 pf_q = vsi->base_queue + ring->queue_index;
+	u32 xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
 	struct i40e_hw *hw = &vsi->back->hw;
 	struct i40e_hmc_obj_rxq rx_ctx;
 	int err = 0;
@@ -3585,11 +3586,12 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 
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
@@ -3605,7 +3607,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->queue_index,
 					 ring->q_vector->napi.napi_id,
-					 ring->rx_buf_len);
+					 xdp_frame_sz);
 		if (err)
 			return err;
 		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -3616,7 +3618,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
-- 
2.52.0


