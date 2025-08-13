Return-Path: <netdev+bounces-213241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD21B24348
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8885612FC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3E2EA157;
	Wed, 13 Aug 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qBWbyimW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1D2E9EAB;
	Wed, 13 Aug 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071565; cv=none; b=gxmH06rKZ7pvZt3T8IjyU/2lwJEnDMd2P0XvBkit6qpUCJuIS95Myc22kq4PCVhSwJ2AmclWUR+l8o1+wzwebFlrtroCZjiJddqaYntEUYlrt1tWaOtEWfUAQB7n9mrerxM0n0ijUSeDiO9x5cWwleCWhNNEz/JyR3KcKJauCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071565; c=relaxed/simple;
	bh=KFmtBpqIS/gas15j2ubFbyJ7spXHzf2NK9I0R5ErOjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nid/HFMBSPJ3ufprDfwSwO3cBBq2w7mEWt3c7nVWfttx3HRyJNkgCXndXE6YydjrOq6x5hhPXBtJ+sDzjvfxqSEIxRp5yAHKRH0x3uFNlYgq18tRh2KxnEbMz5A/EUMSzYFSDeFiw0y3OS4JU0DyA2B9rEdZMbw1glmRUL5K0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qBWbyimW; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755071564; x=1786607564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tluNgAk0CYLsM7ZvS5LjeDUB61MgUfMGZZtsKFZxYc=;
  b=qBWbyimWn3JE5LYVgkN5JfXtcmzN3IF+SVypsFSXaGLhquWWJGxvVNAt
   OiM9tEDzweOXB3wddUg+sCRSoC6kZJGvZagfvY1jEnY6eSuvnUae1jkkh
   dTdVRni/MjQMPaaBZo4h9XDP2pI2yfi5VxHLBgU9lltJAmGLe/mQof/bI
   iARca+GtWkv3FGPxm8tmzZPj2lC2M5592RrC+ABVvjstY1YwOhnLCqXI6
   zyKBKPWlxD51sudxi5n4uPsK+C+BVk3KmIt7p9jf5YmxYvB0B3QE54shs
   mM8ygagXa3WErgvCyn/h6WJ+2d+yLJ85ByzP7Dc8VmgpaxWMOKKwB1bEs
   Q==;
X-IronPort-AV: E=Sophos;i="6.17,285,1747699200"; 
   d="scan'208";a="224790435"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:52:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:13498]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.54:2525] with esmtp (Farcaster)
 id 28d6fb3a-6f70-44b1-adb1-5c55fb937a18; Wed, 13 Aug 2025 07:52:42 +0000 (UTC)
X-Farcaster-Flow-ID: 28d6fb3a-6f70-44b1-adb1-5c55fb937a18
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 13 Aug 2025 07:52:41 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Wed, 13 Aug 2025 07:52:39 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v1 iwl-next 1/2] igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
Date: Wed, 13 Aug 2025 16:50:50 +0900
Message-ID: <20250813075206.70114-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813075206.70114-1-enjuk@amazon.com>
References: <20250813075206.70114-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
Packets/Octets loopback Count), but doesn't show the TX-side equivalents
(lbtx_packets and lbtx_bytes). Add visibility of those missing
statistics by adding them to ethtool statistics.

In addition, the order of lbrx_bytes and lbrx_packets is not consistent
with non-loopback statistics (rx_packets, rx_bytes). Therefore, align
the order by swapping positions of lbrx_bytes and lbrx_packets.

Tested on Intel Corporation I350 Gigabit Network Connection.

Before:
  # ethtool -S ens5 | grep -E "x_(bytes|packets)"
       rx_packets: 135
       tx_packets: 106
       rx_bytes: 16010
       tx_bytes: 12451
       lbrx_bytes: 1148
       lbrx_packets: 12

After:
  # ethtool -S ens5 | grep -E "x_(bytes|packets)"
       rx_packets: 748
       tx_packets: 304
       rx_bytes: 81513
       tx_bytes: 33698
       lbrx_packets: 97
       lbtx_packets: 109
       lbrx_bytes: 12090
       lbtx_bytes: 12401

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igbvf/ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 773895c663fd..c6defc495f13 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -30,8 +30,10 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
 	{ "rx_bytes", IGBVF_STAT(stats.gorc, stats.base_gorc) },
 	{ "tx_bytes", IGBVF_STAT(stats.gotc, stats.base_gotc) },
 	{ "multicast", IGBVF_STAT(stats.mprc, stats.base_mprc) },
-	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
 	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
+	{ "lbtx_packets", IGBVF_STAT(stats.gptlbc, stats.base_gptlbc) },
+	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
+	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
 	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
 	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
 	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
-- 
2.48.1


