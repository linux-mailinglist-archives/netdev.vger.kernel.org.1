Return-Path: <netdev+bounces-211810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66FB1BC2E
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179F64E2BD0
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853C25A340;
	Tue,  5 Aug 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4uauYss"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118D279DA4
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430752; cv=none; b=lUsVJrgPw4JXcyBu1efLuFobIKPFJNljg7yYTnLFevKWA6/XtzH7ZWVWUHAVSWcB+VUmU8B6lBGDlMYh0gOCXZFYptq0tyhwSamBQtcdxnYCtKWKRK1YKz4X535yYNKyycx7FaLuZZL/oxv89RgJQC5TAM5EXP46eOEXY16hbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430752; c=relaxed/simple;
	bh=dmhjz6AYFcmGmXUW1WU+OajjslpzlF8I0HW+6P9GgfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyHuFhytFO1A5VMbIflufNA0K/HJKXW6MNm/JOi2SNRG9mlE/ws189gCNPrbzU4C6+MpmE6PGYFnKXh9NwqhbDBLk6UbGEEG31JBFWcpFK3e1+8c6ttjiKzlQFWvjXuV4+4C+Z+Kby6w5JNnCtUR1k4wsb/+Vc8UBcbsZzsIp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4uauYss; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754430749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y0r510Eq1JEOqtTQcbgddJD4OWKxfmktRwy8IW7tTE=;
	b=i4uauYssy9OZt35KTYT7T+fHUa1U/Ro2fPQmhSLfMq+x0qlAVi8TIo7SKSfdZiGM7CmFnM
	y4F3IBVLq5Mjl3DAIhnj+ToMs3PRAnMpN92uE9Lh/R1KAJtUEkprVYHRw4/jSQmyVcT/tf
	SrZnHQ/v7jedn1ABJUS5beo8HtknLHE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-0Xsngo9cOaC-OVqufLglHA-1; Tue,
 05 Aug 2025 17:52:25 -0400
X-MC-Unique: 0Xsngo9cOaC-OVqufLglHA-1
X-Mimecast-MFC-AGG-ID: 0Xsngo9cOaC-OVqufLglHA_1754430744
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40F5419773EC;
	Tue,  5 Aug 2025 21:52:24 +0000 (UTC)
Received: from lima-lima (unknown [10.22.80.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 769023000199;
	Tue,  5 Aug 2025 21:52:22 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: netdev@vger.kernel.org
Cc: dechen@redhat.com,
	dchen27@ncsu.edu,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next 1/3] netdevsim: Support ethtool stats
Date: Tue,  5 Aug 2025 17:33:54 -0400
Message-ID: <20250805213356.3348348-2-dechen@redhat.com>
In-Reply-To: <20250805213356.3348348-1-dechen@redhat.com>
References: <20250805213356.3348348-1-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Kamal Heib <kheib@redhat.com>

Add support for reporting the netdevsim stats via ethtool.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/netdevsim/ethtool.c | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index f631d90c428a..33d39dfdd6d9 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -7,6 +7,26 @@
 
 #include "netdevsim.h"
 
+struct nsim_stat_desc {
+	char desc[ETH_GSTRING_LEN];
+	size_t offset;
+};
+
+#define NSIM_STAT_ENTRY(s) { \
+	.desc = #s,  \
+	.offset = offsetof(struct rtnl_link_stats64, s) }
+
+static const struct nsim_stat_desc nsim_stats_desc[] = {
+	NSIM_STAT_ENTRY(tx_packets),
+	NSIM_STAT_ENTRY(rx_packets),
+	NSIM_STAT_ENTRY(tx_bytes),
+	NSIM_STAT_ENTRY(rx_bytes),
+	NSIM_STAT_ENTRY(tx_dropped),
+	NSIM_STAT_ENTRY(rx_dropped),
+};
+
+#define NSIM_STATS_LEN	ARRAY_SIZE(nsim_stats_desc)
+
 static void
 nsim_get_pause_stats(struct net_device *dev,
 		     struct ethtool_pause_stats *pause_stats)
@@ -182,6 +202,41 @@ static int nsim_get_ts_info(struct net_device *dev,
 	return 0;
 }
 
+static int nsim_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return NSIM_STATS_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void nsim_get_strings(struct net_device *dev, u32 sset, u8 *data)
+{
+	int i;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < NSIM_STATS_LEN; i++)
+			ethtool_puts(&data, nsim_stats_desc[i].desc);
+		break;
+	}
+}
+
+static void nsim_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats,
+				   u64 *data)
+{
+	struct rtnl_link_stats64 rtstats = {};
+	int i;
+
+	dev_get_stats(dev, &rtstats);
+
+	for (i = 0; i < NSIM_STATS_LEN; i++)
+		data[i] = *(u64 *)((u8 *)&rtstats + nsim_stats_desc[i].offset);
+}
+
 static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
@@ -199,6 +254,9 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_fecparam			= nsim_set_fecparam,
 	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
+	.get_sset_count			= nsim_sset_count,
+	.get_strings			= nsim_get_strings,
+	.get_ethtool_stats		= nsim_get_ethtool_stats,
 };
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
-- 
2.50.1


