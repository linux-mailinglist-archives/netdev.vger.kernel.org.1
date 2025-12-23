Return-Path: <netdev+bounces-245894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F2CDA6A6
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9FE3098300
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7034B438;
	Tue, 23 Dec 2025 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNtAp4R4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0041288522
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519217; cv=none; b=rAbgBN5m0Fvkp3RZOujG/wYXYb6o0pHJJjCZuVIum+aonwmn+feZSKOXq6lBjkI2tKn55q3RNf8j2XFTZGdp3Um2iGgKmnend+ao7AxXM0w5uwLQBtpdVnW84JmOhbj0yiOBu9+bI8bMH3i2ojaP4Vkx7cKXyLcYMWq2Ypwt9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519217; c=relaxed/simple;
	bh=kKaH5TI9H57dhaFvYsDSpKcrupT9XXs5S87wxyfBwwA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RhmdG2WCsO9hGuUMhWZ21mOLphWKwVgjgh0mbtUi/68ihvCPbn0bUQOK0qUjeM8FKmHqSBAM7WXrkDCf1onm+zaexF7E6savjuLCY3CQBRNMBzZV5NIhAcDyuR6OZbUdDHPfZl23XPaV9RJcQmxT6B1FQgOt5E24N8LweBLdNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNtAp4R4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bddf9ce4931so8997496a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766519214; x=1767124014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbB5fUieYbbC54wlKkzCPogs80Zc6SurLe7o2Jqsn5A=;
        b=SNtAp4R4uyXLIsGx6HINs7OOnN741fFKMSKu+3Y2tP3fRGCQbGgs2po/mCOwHOghh1
         f3G/2htRcxvKCb+7uSFC8YeFrS4TZ0kP2uHqi1sATHCS5kgvPD9cKC9GE92d4wxoj/4x
         yM0/Wup5NpCvX7+HLG55y37rftGniDX6ltv6rXCbrD2REl6EgByRgYWJQItBQC2qoBaF
         ohlskmnjQewuxH96zfQttGN5MlqolVifUD/sCla10cKu8Q1VxweDXjRDEVmPjGaRFLB4
         plvJAmP3ZN8v6kNtaAGX3FKAmaDWGjbEid82opujLXF1d/86buRtKkF3KoGkLrVdrL+4
         ZmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766519214; x=1767124014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbB5fUieYbbC54wlKkzCPogs80Zc6SurLe7o2Jqsn5A=;
        b=GlToegZrGfTLNrW+g09HlQ/r2Fy6Q4G5UpKwTGaMbrQCuvylvbGv4po/ZqGl5vY8FN
         uYjggbLMfmUvpqMrHtviAcC2rZZhT9WnSPm3eCFltZ+DdQogTZB1YqXVJnDsY202B82T
         ZOBeknMfHkAV1bCrFdSUY+P1ajOQoEyyEI+pb7mpKxX6xGSwZtH4wtK5OkIva9dwuLtE
         QTVI0EogjdP1MXqEN5yG/FR+gcsWto1LQPjaMpZIJn7QmLZaaVdsmyZK/vENIUvOA8o7
         3dktErfvI2pQvodD/nTK3vnuA9JDdIUIiy2ZO14TdcbIe1Mawf7VoldNbHVdSmdPanSr
         EnPg==
X-Gm-Message-State: AOJu0Ywjm2DlDRcRvA3uA8DIrIWBweFPI1pi7veAsCb+ooqRjPABax9O
	qNMVuXM36g2w12nVl3tqRa8UDBd88c4a5Z+hoBleYWtB/oIAtqKBSEaUtkVlNO8JBJgI1/PZW+T
	YK74tvZxoQHF+i+lDd2ULsfTmwC+iaUZuSuZhpKEMyNcEl5OTYJWnBnPdoqd1jSMNQrFEi3e308
	h+AKy8JsmGvG0tOCI1yVg6JnWaSkKWVO1YA/Ee6hyMO1qFDItSpEUbaBQKutGRpJM=
X-Google-Smtp-Source: AGHT+IEh1TfXoem2rb5nypJkE6ogSfqwPsTdfFfptU3SHsuL6LuN7SgwxjclA75NJmfB/kBCOkuzh1nebLdLVZ71NQ==
X-Received: from dycuf3.prod.google.com ([2002:a05:7300:103:b0:2a4:7587:4d39])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c393:b0:2a4:6bb6:c84a with SMTP id 5a478bee46e88-2b05ebdd512mr14772248eec.6.1766519213635;
 Tue, 23 Dec 2025 11:46:53 -0800 (PST)
Date: Tue, 23 Dec 2025 19:46:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251223194649.3050648-1-almasrymina@google.com>
Subject: [PATCH iwl-next v4] idpf: export RX hardware timestamping information
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
as a BPF kfunc instead of appended to an skb to support grabbing
timestamps in xsk packets.

A idpf_queue_has(PTP, rxq) condition is added to check the queue
supports PTP similar to idpf_rx_process_skb_fields.

Tested using an xsk connection and checking xdp timestamps are
retreivable in received packets.

Cc: intel-wired-lan@lists.osuosl.org
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

---

v4: https://lore.kernel.org/netdev/20251219202957.2309698-1-almasrymina@google.com/
- Fix indentation (lobakin)
- I kept the (u64) casts for all bit shifted bits in idpf_xdp_get_qw3
  and friends as I see all idpf_xdp_get_qw* functions do the cast in all
  bit-shifted variables.

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
 drivers/net/ethernet/intel/idpf/xdp.h | 20 +++++++++++++++++
 2 files changed, 51 insertions(+)

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
index 479f5ef3c604..1748a0d73547 100644
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
@@ -149,6 +153,9 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
 	desc->qw1 = ((const typeof(desc))rxd)->qw1;
 #else
 	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
+		    ((u64)rxd->ts_low << 24) |
+		    ((u64)rxd->fflags1 << 16) |
+		    ((u64)rxd->status_err1 << 8) |
 		    rxd->status_err0_qw1;
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
2.52.0.351.gbe84eed79e-goog


