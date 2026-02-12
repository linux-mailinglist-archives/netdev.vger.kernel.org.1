Return-Path: <netdev+bounces-258490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gk7K40kjmlCAAEAu9opvQ
	(envelope-from <netdev+bounces-258490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C075130893
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A74E30D1367
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59529BDAB;
	Thu, 12 Feb 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1gl3ybw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C582299947;
	Thu, 12 Feb 2026 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923005; cv=none; b=Nd56dyEFIBgmC4MLoq0mrR3ZyktrkYSTbf07V+gzhTOc760bpFvNMulwiS5iOk0c3qOsYeINns2BOwU7Vq2GH8q9bKHOgkKfNX2HnX6yFRGVUYLGxLJtYQI5djzYEfn07EX9AhACe39Hy5r+lI3H1oW5kkAnf9ZGKZ/OA5I31yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923005; c=relaxed/simple;
	bh=+d8WDBcFClym1+STD9kyxUVm17WuGAI9hhyzjvkmAQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxJYjnkI7c02wAzs27wRwuYtYOayAnl5mSIJjdQ5AH1ZtphLtxaNMehJ/0rqbHQct/b7mJ9ZArc1zf6p7I0ivIUV7lXIbnuXyiAd908eK73+O3EnWwFRtwqv+zPu2pOKbipiOP4SRjzXpTus0X82FeTHxkaz+LKuArNu2lHnnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1gl3ybw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770923003; x=1802459003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+d8WDBcFClym1+STD9kyxUVm17WuGAI9hhyzjvkmAQ0=;
  b=h1gl3ybwryrUOHnTRTDFnQbq56L3g81ThrUfF7iSjuqblTAiI8etQ0a8
   S/AzOT//yzZwZVoNpW9c0rxnV0nYuioT4meI06n2RIp4yDhHyhSRgDoXi
   tNb1BLU0p5IBRYpKHXjGNzHPquFiFA3Sd5By+PV8zedo7ZtSiYC3kMSNS
   w64ddbYlMSiFTxLtMsVg6gYNbxVsYGkIutomoDlpBbGmbjZuGFJZ/WXaZ
   fMN9zWo/yyTFaexiF8r/qISEMFL+gAqC41CwT8lfF5gZbUfMp+4l1TNSu
   y6PVO9ojXos8qzseyS8XH9QyN5DM3LUj9jEUCNsFAlU6CmRd15+wzYwKS
   Q==;
X-CSE-ConnectionGUID: WpEh3bWTTxi9y0iWThkVGw==
X-CSE-MsgGUID: Qx1Osk0pQG2iBiwlymJ/Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="94745992"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="94745992"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 11:03:22 -0800
X-CSE-ConnectionGUID: 2JzDHTqcRzevG2ggyxsbtg==
X-CSE-MsgGUID: kQpjpgdnSO6JbxcU5dOUbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211921989"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2026 11:03:14 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 99D6B32C92;
	Thu, 12 Feb 2026 19:03:11 +0000 (GMT)
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
Subject: [PATCH bpf v2 4/9] ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
Date: Thu, 12 Feb 2026 19:33:19 +0100
Message-ID: <20260212183328.1883148-6-larysa.zaremba@intel.com>
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
	TAGGED_FROM(0.00)[bounces-258490-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2C075130893
X-Rspamd-Action: no action

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects whole buff size instead
of DMA write size. Different assumptions in ice driver configuration lead
to negative tailroom.

This allows to trigger kernel panic, when using
XDP_ADJUST_TAIL_GROW_MULTI_BUFF xskxceiver test and changing packet size to
6912 and the requisted offset to a huge value, e.g.
XSK_UMEM__MAX_FRAME_SIZE * 100.

Due to other quirks of the ZC configuration in ice, panic is not observed
in ZC mode, but tailroom growing still fails when it should not.

Use fill queue buffer truesize instead of DMA write size in XDP RxQ info.
Fix ZC mode too by using the new helper.

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 511d803cf0a4..37ac5cbc7bcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -669,12 +669,14 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			return err;
 
 		if (ring->xsk_pool) {
+			u32 frag_size =
+				xsk_pool_get_rx_frag_step(ring->xsk_pool);
 			rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 rx_buf_len);
+						 frag_size);
 			if (err)
 				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -694,7 +696,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
+						 ring->truesize);
 			if (err)
 				goto err_destroy_fq;
 
-- 
2.52.0


