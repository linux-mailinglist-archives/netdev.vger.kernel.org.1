Return-Path: <netdev+bounces-240993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF51C7D24E
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 15:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83AA2347824
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24028231A3B;
	Sat, 22 Nov 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WECacEEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A71D5CE0
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763820526; cv=none; b=GKvWuWmc0FCFxmqEynG17Z0T8AvQMDuVVRES95xz2gIYV9bbyEorFrw9ajdPeCtfLbJUrml9HtpsCyjD/kR5PSVKVcydtA14/7m0rJtOCauk9gvmXSOUfVJEvjGqmHTOkcWu+WZ4g3xIFM+v+cyWJSHScy5r6ZI/X/f3wblmriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763820526; c=relaxed/simple;
	bh=hjk+o8o80paPyWfwSKG+PHyDrg8KCIKeJ6mVpIFxuBQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b0AiPtv/UhCXTiAhTy6aHvJGKpkxm+Jzg2BJUNhp5Z+SprGwem9hucZGnfiTU2V89qOjz+2XXgLsUjz/2NZwhuhYtWVhC21Uku+eM5AuJTL9eSs34TrkCxnSQDx+2t4J7BQv9ru+oON6buCd5tqVYZQLiqgiC3NgEpLaWQOMIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WECacEEM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc4e9808b63so2369319a12.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763820524; x=1764425324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CiKyvEObttkjdlU/HxkVL5YvXx0AELKfdJVDLDR7O7E=;
        b=WECacEEMvpACJj1iZ1j9kiJjXGZMbceExB3OZXFmrGz++Y8WGiOYOudcu8OIXL6dyf
         Tf+fmq1TRy06HUvhNU/axnSer/oN9tRckpjJRHWUefzvh84mKzzQecmCLo8jwCXztA2P
         TaH9568eX5afkipEBfNjmPFp31qAohrXuFTWVWI0LaAtiadFz4R2lnBlvHCgcS3pX+5d
         NNhBCO7cQMIuO6cWOEh15oX4BFzuXly6TPv7mvYEExzstZ2lpUUbKZgdBbLUI8mJd/Ri
         k0j9PBt7HnovU+MIsx6H7z3C3FDpW0NiG8wQrgBE9wC89uoO7qpOn4xiMpKAYPuF9RNM
         H5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763820524; x=1764425324;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiKyvEObttkjdlU/HxkVL5YvXx0AELKfdJVDLDR7O7E=;
        b=DLnTm5Velz1X8n5kSgDeKMIKdk1TWr9Dmo0Ul20772XH6IkFZ/45LdoXJEUWtHBM6q
         3XP2pdNj36ggJpF8G4gzYgx6bV7nS7DAXqPptsr3Vx8HaXhP53xRRuMM/Jc+IkDdC2Yk
         vVwfemMhP7ACO6zxwbSqbOa6PDVosKq2JsOVUZhWA8NX+i4cTMUAPdEo+jH3+qc8QCYW
         qYrSrSVgCuF9I91ouv3TEme3/StD19ENOWCrx35wYGny2QrKf48+PIyD284Hh+ZG7WjQ
         usp0lLAtw/RC8exv+qOTIKdgEftsWBAbxHoA0Cp6lJwbsX2kv0kKxTKQhnNMOar2uGAZ
         SbuQ==
X-Gm-Message-State: AOJu0YziInhDGg8UaHm3leAhCeszrUC2USIG4KCIZGqOoQAUi1KyQCBZ
	8yi8OnEqpq933nhVloi+wvK5MpSZT1AaiA6xcBC9t5rk47vO7VpdKLatC2/MrG76PdTqhqyFGep
	erLVU7H1MqKDbPsx4jYQrDPTHpBzHgUyEgIssb2oNPViU4NkiIyB4Hy9TXasSwd0DRVOoyauGfl
	ygmkpUjYq3IYz2+Scm8airyN5P8svl0AmJ8lTpIeHpqDxxPvZw4b0TsMCwv1DK4u0=
X-Google-Smtp-Source: AGHT+IGiaUwHMiMte8op02BQ1Y7EuVvIJxvCeVDha4rnblhCSxc3V54Qj6e3HJk/7vwUWsfEzm3eiefI1xmjTS9oQQ==
X-Received: from dlbuy16.prod.google.com ([2002:a05:7022:1e10:b0:119:49ca:6b95])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4a6:b0:119:e55a:9c05 with SMTP id a92af1059eb24-11c9d864ef6mr3230515c88.33.1763820523481;
 Sat, 22 Nov 2025 06:08:43 -0800 (PST)
Date: Sat, 22 Nov 2025 14:08:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122140839.3922015-1-almasrymina@google.com>
Subject: [PATCH net-next v1] idpf: export RX hardware timestamping information
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
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The logic is similar to idpf_rx_hwtstamp, but the data is exported
as a BPF kfunc instead of appended to an skb.

A idpf_queue_has(PTP, rxq) condition is added to check the queue
supports PTP similar to idpf_rx_process_skb_fields.

Cc: intel-wired-lan@lists.osuosl.org

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 21ce25b0567f..850389ca66b6 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
 #include "xsk.h"
@@ -369,6 +370,31 @@ int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 				       idpf_xdp_tx_finalize);
 }
 
+static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
+	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
+	const struct idpf_rx_queue *rxq;
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	rx_desc = xdp->desc;
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	if (!idpf_queue_has(PTP, rxq))
+		return -ENODATA;
+	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return -ENODATA;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	ts_high = le32_to_cpu(rx_desc->ts_high);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*timestamp = ts_ns;
+	return 0;
+}
+
 static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			      enum xdp_rss_hash_type *rss_type)
 {
@@ -392,6 +418,7 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 }
 
 static const struct xdp_metadata_ops idpf_xdpmo = {
+	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
 	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
 };
 

base-commit: e05021a829b834fecbd42b173e55382416571b2c
-- 
2.52.0.rc2.455.g230fcf2819-goog


