Return-Path: <netdev+bounces-245560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB34CD1C22
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 21:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B641302AFA4
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AA33BBCB;
	Fri, 19 Dec 2025 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOZrqCmD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B333B6F3
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176203; cv=none; b=QfIT4jRMwWDBPjA+DG+76hEGkM3t0PQ8XH73YnhfrTATi4T3XjRMTE0IfB/B/SzgfRU1J8yMbk38HjW+Kdu2KrffGjp6mhXoYdz/ZoGsgIrGbwUBMoFhvA09/0hfjMBKpDlUrqWR27VDEHIbtdvNmo47d3G7LnGIZwrLuGA6wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176203; c=relaxed/simple;
	bh=AK9s3g7olH8MG4EtHhTwdxUK+xOuSdA2bXOfBOgp6s4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LaysYDnGZ41c2i9IT7ESTp4iu515VZ+57ptgTPoo3WKkflk5gfg8qhl8+BVPXRTtlSMaVnNZwTQgiamrsS3V+KS3E0HMhs38zNT5JUpJXAHJras3He8gR5WPWxdZiJV0QJmnKdmLRzQ3lN9fXBU3AJHLBbu6wb28m/xZgGcn2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOZrqCmD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso3705031a12.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 12:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766176201; x=1766781001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHd0Ny6KDmA7/BvDV3C3X6zKg5S+EEhCYi1NRz/+6Xg=;
        b=MOZrqCmDl9+t0cA0o1e9Cvs/hVvZMnPih684S7CAWbmrVkMIvJHSB5mXBVkwASf65C
         HY48S8EeFP9CtixKqDDHvX9TDYxaOTgh1lBa1cp/uieoTX0ZgMdJs34X9zTXGkwT1O1h
         qyWHW/6h9Xz3nRh+qb7Ilo4THcJhyg7v/PuRF1XxZSx0ChImTGQh3OaaOR4hYZlnTMRR
         Kdl1xS5RPvZyeY69Z7u1tQhrUsbNLpTNydZqZvdNxnGhBhmVzryySUkxqtJiD1h6+ZGz
         Rk2pQX0QUT83MDvT1oSUe424zlIeDJBgq57jKGRk6yIEH0/y10RaevpxrtHFQxf8vQw+
         FKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766176201; x=1766781001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHd0Ny6KDmA7/BvDV3C3X6zKg5S+EEhCYi1NRz/+6Xg=;
        b=iOcPgYfafdo67YSkncAIk5ZwsbhRc3zAy9zOeUmLxa2JWiV15mslpaleR4vr+OoMVF
         ljhpHqR15yWikacOF2MnMP9xIdEjEl+YVJ/jm+ZtAOj+nslqzuangotEUEUZ8TQrC7Sq
         tIOJqKo7JT6JqH/OkJjkcQ8tvImTLcKVhqKeC6lQ6znCDCRYjj2wvZxsWGwme7QQeeK1
         uSpGPsV0XD09p6XkmihPuu2h23Wj4EEAhdG11EGqHMMnyTtD2mbVqHYQnEUzfckuYHOc
         4ptpZdBZmWMvH02YcQVrwmYp45TP1EjnbB1mAiO0cDvbxG3Vx+ErqB/kWy6Eo4MFpBBB
         77Ow==
X-Gm-Message-State: AOJu0YzrvkxI8sLbp9pX2C3MhaTy8AEs8tX3rRw3jfZoMnEht/P0RTUf
	OZktn803c0Fr/FtwJSZP6X0AtxRwTO47rcHzB6iDl8FUFgXdO+rni/KCtGHr8WWEJtP9u8UUrov
	88EPeAZTQ+l6e1r5+FsGsnvR2DMJHTT9dAEsOkeOyPjoy+Hk26mDmrjNr/NpnyJ1VjsOm9lmvJT
	mzzUMO5SoNQn6JdKyoB/3NrmEKeapXCVne4gcPqb8vzVfCUxPkO5uqy/yNe+kmWEQ=
X-Google-Smtp-Source: AGHT+IGmgbM0XudpJcpiXGRPuXw6UTKfKP2tpvG3JOdbqKaPKFoWMNG1e8WaCbFXC3+5Y53tESIYxz7+RDX3yTy+iA==
X-Received: from dlbbk38.prod.google.com ([2002:a05:7022:42a6:b0:11d:cd2a:4c1b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6291:b0:11e:3e9:3ea2 with SMTP id a92af1059eb24-1217230eeafmr5221570c88.49.1766176201087;
 Fri, 19 Dec 2025 12:30:01 -0800 (PST)
Date: Fri, 19 Dec 2025 20:29:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219202957.2309698-1-almasrymina@google.com>
Subject: [PATCH net-next v3] idpf: export RX hardware timestamping information
 to XDP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, intel-wired-lan@lists.osuosl.org, 
	Mina Almasry <almasrymina@google.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The logic is similar to idpf_rx_hwtstamp, but the data is exported
as a BPF kfunc instead of appended to an skb.

A idpf_queue_has(PTP, rxq) condition is added to check the queue
supports PTP similar to idpf_rx_process_skb_fields.

Cc: intel-wired-lan@lists.osuosl.org

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

---

v3: https://lore.kernel.org/netdev/20251218022948.3288897-1-almasrymina@google.com/
- Do the idpf_queue_has(PTP) check before we read qw1 (lobakin)
- Fix _qw1 not copying over ts_low on on !__LIBETH_WORD_ACCESS systems
  (AI)

v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina@google.com/
- Fixed alphabetical ordering
- Use the xdp desc type instead of virtchnl one (required some added
  helpers)

---
 drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.h | 22 ++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 958d16f87424..0916d201bf98 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
 #include "xsk.h"
@@ -391,8 +392,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 				    pt);
 }
 
+static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
+	struct idpf_xdp_rx_desc desc __uninitialized;
+	const struct idpf_rx_queue *rxq;
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	if (!idpf_queue_has(PTP, rxq))
+		return -ENODATA;
+
+	idpf_xdp_get_qw1(&desc, xdp->desc);
+
+	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return -ENODATA;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	idpf_xdp_get_qw3(&desc, xdp->desc);
+
+	ts_high = idpf_xdp_rx_ts_high(&desc);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*timestamp = ts_ns;
+	return 0;
+}
+
 static const struct xdp_metadata_ops idpf_xdpmo = {
 	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
+	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
 };
 
 void idpf_xdp_set_features(const struct idpf_vport *vport)
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 479f5ef3c604..9daae445bde4 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
 	aligned_u64		qw1;
 #define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
 #define IDPF_XDP_RX_EOP		BIT_ULL(1)
+#define IDPF_XDP_RX_TS_LOW	GENMASK_ULL(31, 24)
 
 	aligned_u64		qw2;
 #define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
 
 	aligned_u64		qw3;
+#define IDPF_XDP_RX_TS_HIGH	GENMASK_ULL(63, 32)
 } __aligned(4 * sizeof(u64));
 static_assert(sizeof(struct idpf_xdp_rx_desc) ==
 	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
@@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) ==
 #define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
 #define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
 #define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
+#define idpf_xdp_rx_ts_low(desc)	FIELD_GET(IDPF_XDP_RX_TS_LOW, (desc)->qw1)
+#define idpf_xdp_rx_ts_high(desc)	FIELD_GET(IDPF_XDP_RX_TS_HIGH, (desc)->qw3)
 
 static inline void
 idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
@@ -149,7 +153,10 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
 	desc->qw1 = ((const typeof(desc))rxd)->qw1;
 #else
 	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
-		    rxd->status_err0_qw1;
+			((u64)rxd->ts_low << 24) |
+			((u64)rxd->fflags1 << 16) |
+			((u64)rxd->status_err1 << 8) |
+			rxd->status_err0_qw1;
 #endif
 }
 
@@ -166,6 +173,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
 #endif
 }
 
+static inline void
+idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
+{
+#ifdef __LIBETH_WORD_ACCESS
+	desc->qw3 = ((const typeof(desc))rxd)->qw3;
+#else
+	desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
+		    ((u64)le16_to_cpu(rxd->fmd6) << 16) |
+		    le16_to_cpu(rxd->l2tag1);
+#endif
+}
+
 void idpf_xdp_set_features(const struct idpf_vport *vport);
 
 int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);

base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
-- 
2.52.0.322.g1dd061c0dc-goog


