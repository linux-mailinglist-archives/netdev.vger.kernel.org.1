Return-Path: <netdev+bounces-241269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F010C82130
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659403AB337
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4831C57B;
	Mon, 24 Nov 2025 18:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E031770F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008360; cv=none; b=PyoE92Hzih3k4JTR8LSm8nny8nW3xCKa8OYaXsL6wQLnFWXVgBFbtGS5uSemwvqjBauUl3anhycFZLXQbHqtaUGVv2rRe6b/5+HYlcUN2vHIZB4WXbZTf5fs8VAxiPNScTfNlxLXKvANmI2RRwlU8DD/ASHbrboNrPsOVtatCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008360; c=relaxed/simple;
	bh=r7kjPpO3EmMUKZOQEZlWjxTq3oyKJiuHGfOq2mFvYMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2NljbdzUtVeBRwciyjEEfi4wlmkeykoy5uXFdgjEaNxBgbGn2MXl6lI4D+oraC52Vr5RAtN6R8U4BeipTDWDhRcw3cMBz1ybGg8aduzM4u+NcmLJ9x31u91P1kypizcsw8OE3PdfPfDxEEKbQKwvnEnqM3WYDynveMTPicD6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3ec4d494383so2792746fac.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008358; x=1764613158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XdOK/+JSUKsUAuFyuE3vjj9D8Qk2MEeTKmCgASJ6/Kc=;
        b=d/QU/BdU4++8Gnp3SiwbesnUff/DlEvK0eapeWgOKUi3N5yLWIpht2XctpesnGx1wJ
         4V07JRlGZNlHacwnrtaCAH2cjYfo+7/O23rV/Z6d7Jx4XFGfbKjxd0iNT9PZihvp+tjC
         qz7fEpAY0sBzdWJdxwfXj43CzYNqKl13u8YgoFhXKkBwPgTjj1cRjl9viAmO1iebz+Ty
         ljqnn7CUjXBOWh++lUSF9vixKvbQzv/CL+WFwddknI8Bm0/ybX8L0dJj9cgABKupb4la
         GuDHRArTcMh5qnNUfqv5wmqbPyu8v0CboQktJZVJCfuyrwXJf+XFtfsYgHCiZBbqKFhS
         FMwA==
X-Forwarded-Encrypted: i=1; AJvYcCUwZHxvVdV7pVOI1hvuj8Mg16SSIIqD/5kiwhBNXzZbga7NWrCQKYlyR2yXVLajTtX6cY3IpfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ze17FAXwPFk68xvQ2p632vPp/O4d18fqto0JIgYf7e39NDoK
	JChr6WnKnj3uWhyP4skTMH5bNoC/oDPVMZeMxSMJ660liectiT3QcfL7
X-Gm-Gg: ASbGncsPRxmyMfU7uOBiJMSaDyGA3l+WE+aJyOGFwQB2wb9PWRnCBMOeY80W9ArvGL3
	cfpvcux3bnXNNzeNny1E4UnE3xwWB4a2x8775KY2AlW133YRaEColLkyzlc36CK8lznC2bI4otF
	X4LGMrk8jz8snx1yJcjmTWU0v+l4hux61Fesiff+5iapif2KQOYTGRZiQQ1+WRqntUGeKsPByDV
	1p6EK3A1r0JFD6saFMJQbzb0q9bl12mwnDjx8Xxieav36zqQ1JgMTxDxcINZmfoHb7BVov7+IhF
	NTBgrsAeM46xSLxvk2ZsL+V/AZbbb7rOTQORM3irU0Nqd5PLRlQqFR52svAp+39H1nIehR1RmyM
	j/MqJO7CC9e2Uo9PsyPoj+T2snCR82+qBeLR01cqVAKLsA5o/5Gyp57gSyxP0i0qRbNtUBOxDEQ
	MWreaqErYF2ug9Bw==
X-Google-Smtp-Source: AGHT+IFsMYMZsraWZeN3BUvD1HXeX+FpLoZiZgRtlLXlHtafV46HeiFiZHENmrqbuDEprBt45CmkCg==
X-Received: by 2002:a05:6870:a2d1:b0:3e7:e20a:39fb with SMTP id 586e51a60fabf-3ed1fd4ff6cmr52374fac.11.1764008357879;
        Mon, 24 Nov 2025 10:19:17 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dc8e103sm6508744fac.19.2025.11.24.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:10 -0800
Subject: [PATCH net-next 6/8] igc: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-6-89be18d2a744@debian.org>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=leitao@debian.org;
 h=from:subject:message-id; bh=r7kjPpO3EmMUKZOQEZlWjxTq3oyKJiuHGfOq2mFvYMA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdKv15ipu1j1gMS0Jhfn4ft7Ly7jrvTdWd7
 8Q8gdOtGemJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bZXdD/9kWqQNyNoVCNuwu1DAB8IoqQYDXO4gblgkYeyAIwCF/DUfqZrg2iDMn9NHesx6ez06K6C
 M7wn38DzZvlSqJrfMIrYg6xL73sziCXQiH3hM1ltLbzw+q9AYTeyCygU1+iPTBvK7LeGOl34Toe
 d3JTPQt5UvVZAbvPAB5AKdxPYyvwRmLfx53TLQZ0eB7ax9HF6HJZpJhSeq3ltsZ+QeXG21Loz2e
 lVGA5pO53PT+o2NnOEUu82x2yXl6PbDwiMhvBh9y1PEYrJ8ZsfsG+vUTEhsVIUgCByfZURwbyKK
 tweLnG8+7BJK7PmNr69HoIiOPS0QKy/v2D6JBaLkDJvULUj+qX2f2fgw+YnxwTWUV3NMHP5X74s
 c8wdVpFdmvJ2K5rVpgAF7LrLszl5E4arCAM/gTLAIvw5PBm7Jh0Qh1s6RGJKStuwbDeD0SV/O7x
 mVUOcHYDJsRuNw+57hNhso1Nj3Egq49AG6ib6/qpU7C8LdwKOovDoZSFqufrpn3s1K0LWmyaJis
 8gYTMHTFYxZMG2gYceACrWq85RHj1FVmgG7aWS4rTR/y/yj5djXjMV7l2aaOId+/1o5XqSacFyv
 P1MyNAswjYdYpGQpB3S+E/Z/pOcLkRNdumq5dCRm66Z+OcW95Z5fehVxmtoCH8vrl6O1kQItFqO
 3BFnOwlIYyUIs8g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns igc with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index bb783042d1af..e94c1922b97a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1091,15 +1091,19 @@ static int igc_ethtool_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
+static u32 igc_ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	struct igc_adapter *adapter = netdev_priv(dev);
+
+	return adapter->num_rx_queues;
+}
+
 static int igc_ethtool_get_rxnfc(struct net_device *dev,
 				 struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->nfc_rule_count;
 		return 0;
@@ -2170,6 +2174,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_coalesce		= igc_ethtool_set_coalesce,
 	.get_rxnfc		= igc_ethtool_get_rxnfc,
 	.set_rxnfc		= igc_ethtool_set_rxnfc,
+	.get_rx_ring_count	= igc_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= igc_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= igc_ethtool_get_rxfh,
 	.set_rxfh		= igc_ethtool_set_rxfh,

-- 
2.47.3


