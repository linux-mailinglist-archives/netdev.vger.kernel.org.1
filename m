Return-Path: <netdev+bounces-214655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A0B2AC9D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7254D164FA3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33D2571B3;
	Mon, 18 Aug 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cEZLehSv"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C8256C76;
	Mon, 18 Aug 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530389; cv=none; b=AxZtYetzZ1RNuxBBrO7LElK+Two3gq6EWCR5uZwGIdwJXhtcxFlvqSEDGq+qVagB5QH9Z6mfuy59IkFuGBOOpYZOq6iNeGjLNk+vNlRquKCocOhbdfEf7ysIR5AnkUKx80fLglqoUsn5L48dF3lYEtq5u78sS8iadtZgSBS/yDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530389; c=relaxed/simple;
	bh=3NrP+QWpDp0DSerzYr7RNFwrzciw2PBj/acp0EGZ1Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ln4DpOWWtU99JjIEwPfhYHAkwL7oj8Zl5zaLZZB8mal2GAqkxdTyYUdrHf9O7Zs5qXB6BbCbECCOyZkQmoxzIETf8AX3GdDy2LJegFfjG2ZsKgUXw/iLz++TgLxnRu/fo3W2180PC0ESCFBTwH+JCHtGJTQGvAQjscm/Cm4gj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cEZLehSv; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755530388; x=1787066388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DOhBWZFo7LzCg4UtaYsUCZFroWpoYt3Mk9YSL3IWDZI=;
  b=cEZLehSv/uH3Mxf3XdxhyIaYS4oJjK7Gb/iYwJiz47XVbn2VJREQCbmp
   ebU1G//ZN8n8xZ8SnIhMdfc/3SuOpJqSWHIt9JyhR0gsbMLKzkfrxPx6n
   QE2BCjm42slry3zyMUKomfgyszt842+AKibEAo1rjcEOYBed582BQjjGp
   E9yuNbiLQNPPZ75NjMa6nQVnMgCuDiGSO7pMGH2slP3d4tb5SI1o4ov5y
   UFaES3veGAilpaBtVSnOulR+AETXM6Gp1c8L/OLvuRmuJS5YKDu7XbWTr
   rDbHV7jGgIBH9/IFAQQFQ2cO3ONg31v9GyRSy1nZBdsD9w9jeZ14gJvKc
   A==;
X-CSE-ConnectionGUID: CWbWVxBeRvCbeBS5jVW+Lw==
X-CSE-MsgGUID: PjatYlaPS0Sqc/7KbI86uQ==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="1194046"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 15:19:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:37552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.153:2525] with esmtp (Farcaster)
 id 9580e680-4300-449d-87a2-3ccb291c079f; Mon, 18 Aug 2025 15:19:45 +0000 (UTC)
X-Farcaster-Flow-ID: 9580e680-4300-449d-87a2-3ccb291c079f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 15:19:45 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 15:19:40 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: [PATCH v2 iwl-next 1/2] igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
Date: Tue, 19 Aug 2025 00:18:26 +0900
Message-ID: <20250818151902.64979-5-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818151902.64979-4-enjuk@amazon.com>
References: <20250818151902.64979-4-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
Packets/Octets loopback Count), but doesn't show the TX-side equivalents
(lbtx_packets and lbtx_bytes). Add visibility of those missing
statistics by adding them to ethtool statistics.

In addition, the order of lbrx_bytes and lbrx_packets is not consistent
with non-loopback statistics (rx_packets, rx_bytes). Therefore,
align the order by swapping positions of lbrx_bytes and lbrx_packets.

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

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
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


