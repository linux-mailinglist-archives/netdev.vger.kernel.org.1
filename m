Return-Path: <netdev+bounces-259045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHjLFIp0lGnVDwIAu9opvQ
	(envelope-from <netdev+bounces-259045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:00:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4D14CE62
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D95F6309E7AF
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E836E488;
	Tue, 17 Feb 2026 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8iCjyu0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDE36E466;
	Tue, 17 Feb 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336497; cv=none; b=huXsEVVYsMoadt3mWT1YXDKiIuzzvViTBSV+D4bku2S1BF8nGl4aha00RNUkyxSroZu9mc0PAshvlsZNQJBbmxFG2IvvyuwmK7+TPS7xf8Df6evLBqsqbIjv1DXnNwbMtGyxqB/O2lDSofaYZJAb5ET1HQr0n6KhA2qzHj2wMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336497; c=relaxed/simple;
	bh=0CKsXmjygWfgTfW6+ScFYR6A19xBLdaV5AkI9EKjkjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Foaxgwo9PU4/vdrSMmEYwxUrg24+vDmY/nkdkAe/iCRSph4tfUTfo7N6nW3HKPW16MjO81tqKXmn2Q/3ed2XF24X6m8Ed2EJEiE6KhV13wTGF++Zzuoaet1OXr8GCTt2ytosCyiNQdo1MabfJ4GSKqQ4Tq5756DkMyMdHK2Jl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8iCjyu0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771336497; x=1802872497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0CKsXmjygWfgTfW6+ScFYR6A19xBLdaV5AkI9EKjkjI=;
  b=I8iCjyu0HcRQwSQ2QtjkfThiCqzKAy36x/XozUbD/S2BrVkmC/lPDVZD
   WuiatTgWrftsSumt4MriZmLW4UA2BzGrjaZ2m83gV9KE+vKBC49+ISgY+
   lKolFAUVdQv7L/xu0hBDP1QqxsyjHl+zX5LgSj0qxhBL73iufnXWokO1x
   QWt81RCN95HGGsSg8MxyDepEaJCdwfTRWQgEWrzvPK95Fl+VGbSfwONri
   x/QVNvdJF/3vVpZbocwfX/w8QKWoW3isaX8EExornfsmkqrk+LQrMLaE0
   3ZcDUcGPQLkn3qqOXdVA4FVGdRqSAX2eSERYKtRGvFyCv/ovA9w7TdiIo
   g==;
X-CSE-ConnectionGUID: XeS2oKx3T/qYcNFxXtWmoQ==
X-CSE-MsgGUID: 6hZZh12NRCGNGqehpn8tuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72470502"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72470502"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:54:56 -0800
X-CSE-ConnectionGUID: DcAtXpXOSXCSBXD8zcmS6g==
X-CSE-MsgGUID: 8QTap2nWTwK2/ES9dO5soA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213904668"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 17 Feb 2026 05:54:48 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E7C7828791;
	Tue, 17 Feb 2026 13:54:44 +0000 (GMT)
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
Subject: [PATCH bpf v3 7/9] libeth, idpf: use truesize as XDP RxQ info frag_size
Date: Tue, 17 Feb 2026 14:24:45 +0100
Message-ID: <20260217132450.1936200-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217132450.1936200-1-larysa.zaremba@intel.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-259045-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 0AF4D14CE62
X-Rspamd-Action: no action

The only user of frag_size field in XDP RxQ info is
bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size instead
of DMA write size. Different assumptions in idpf driver configuration lead
to negative tailroom.

To make it worse, buffer sizes are not actually uniform in idpf when
splitq is enabled, as there are several buffer queues, so rxq->rx_buf_size
is meaningless in this case.

Use truesize of the first bufq in AF_XDP ZC, as there is only one. Disable
growinf tail for regular splitq.

Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c   | 6 +++++-
 drivers/net/ethernet/intel/idpf/xsk.c   | 1 +
 drivers/net/ethernet/intel/libeth/xsk.c | 1 +
 include/net/libeth/xsk.h                | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 958d16f87424..7d91f21174de 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -46,11 +46,15 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 {
 	const struct idpf_vport *vport = rxq->q_vector->vport;
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
+	u32 frag_size = 0;
 	int err;
 
+	if (idpf_queue_has(XSK, rxq))
+		frag_size = rxq->bufq_sets[0].bufq.truesize;
+
 	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
 				 rxq->q_vector->napi.napi_id,
-				 rxq->rx_buf_size);
+				 frag_size);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index fd2cc43ab43c..95a665cb2f33 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -401,6 +401,7 @@ int idpf_xskfq_init(struct idpf_buf_queue *bufq)
 	bufq->pending = fq.pending;
 	bufq->thresh = fq.thresh;
 	bufq->rx_buf_size = fq.buf_len;
+	bufq->truesize = fq.truesize;
 
 	if (!idpf_xskfq_refill(bufq))
 		netdev_err(bufq->pool->netdev,
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index 846e902e31b6..4882951d5c9c 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -167,6 +167,7 @@ int libeth_xskfq_create(struct libeth_xskfq *fq)
 	fq->pending = fq->count;
 	fq->thresh = libeth_xdp_queue_threshold(fq->count);
 	fq->buf_len = xsk_pool_get_rx_frame_size(fq->pool);
+	fq->truesize = xsk_pool_get_rx_frag_step(fq->pool);
 
 	return 0;
 }
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 481a7b28e6f2..82b5d21aae87 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -597,6 +597,7 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
  * @pending: current number of XSkFQEs to refill
  * @thresh: threshold below which the queue is refilled
  * @buf_len: HW-writeable length per each buffer
+ * @truesize: step between consecutive buffers, 0 if none exists
  * @nid: ID of the closest NUMA node with memory
  */
 struct libeth_xskfq {
@@ -614,6 +615,8 @@ struct libeth_xskfq {
 	u32			thresh;
 
 	u32			buf_len;
+	u32			truesize;
+
 	int			nid;
 };
 
-- 
2.52.0


