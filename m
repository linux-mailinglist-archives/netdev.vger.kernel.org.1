Return-Path: <netdev+bounces-227074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EDBBA7F32
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D48C3C1CDA
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 05:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F511F4C99;
	Mon, 29 Sep 2025 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DyqJ9dX3"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FD625
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759122184; cv=none; b=OwTZDhzPPFoxTovJNj1QXkcaOubeqyqfWF402LQp5JsLyLtQqQfZcQbc1n1MSVFdRZjaPNwrqO2qLMGytswfb4aG4sXSJroV8u20RsfrEXhuUnMxW1a4RUcfTDJG0dZEJP4juCqY3hwZnnkgY47sfceVX3QoSXln8gHGpFcXXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759122184; c=relaxed/simple;
	bh=9RtmrqLl4OsG5OfVurd6x+pTP4CwV48jW9053XidXzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PSpYzCkg1XiWNrK9g7aA+TM2AFOiXuU9315BxQ2BR+Axp5hh/u+rTtIXT3YUBReYEYHffGj6Z9qf264Vg6TrMFHvVqrVd4a7I+6NKV6IDpgkedTit/ajKyeiAmXGcoQuSia2hwSNtYIZ8rzcX37bheBswlsN2JHN/D5w3mWGNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DyqJ9dX3; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759122183; x=1790658183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gux8W3ZBN+MYVxb+id5CwdVsDMzRv/bmekYOhi19hos=;
  b=DyqJ9dX3+fL8i66IXAu2E/E95F462kQIervh6PVpC0BIwWIPxi/99ogj
   yzkSvgRz0HP32Q2AZRQUN1L8Goels84hjE2Loyc5J6wnzEKxNRC06R+bq
   ESG7vXONEOwkXNv65k2laywMks9BDu5XlRYt4wIH2T5L0DwvQ1uDGHPxR
   1ikyd5AW6kVqUeJ7ABwK1ZhtySu7JyfrshkRVSHz5U1jO4fyScWDbYRVm
   X1QF41tyBmwIVw+TXXCQJLbA+wylS6HbUqyvbELaIy38STTzbdkiRpIUf
   svZT1XHNe6XkQ6HL2DPKtztQKd3hjhGFzpzIPMob+GnZ8FtXwB9WKmRnL
   g==;
X-CSE-ConnectionGUID: /wAOxDc/TsacZPWxLE2DxA==
X-CSE-MsgGUID: lbKaKWU8S2eqA3XjIgtfaQ==
X-IronPort-AV: E=Sophos;i="6.18,300,1751241600"; 
   d="scan'208";a="3792729"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:03:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:61829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.83:2525] with esmtp (Farcaster)
 id 62fbb8f5-e843-44e7-9630-3542c2b5b895; Mon, 29 Sep 2025 05:03:00 +0000 (UTC)
X-Farcaster-Flow-ID: 62fbb8f5-e843-44e7-9630-3542c2b5b895
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 05:02:58 +0000
Received: from b0be8375a521.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 05:02:56 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>
CC: Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
	<akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Saeed Bishara
	<saeedb@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rosen Penev
	<rosenp@gmail.com>, Kohei Enju <enjuk@amazon.com>, Sameeh Jubran
	<sameehj@amazon.com>, <kohei.enju@gmail.com>
Subject: [PATCH net v1] net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable
Date: Mon, 29 Sep 2025 14:02:22 +0900
Message-ID: <20250929050247.51680-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In EC2 instances where the RSS hash key is not configurable, ethtool
shows bogus RSS hash key since ena_get_rxfh_key_size() unconditionally
returns ENA_HASH_KEY_SIZE.

Commit 6a4f7dc82d1e ("net: ena: rss: do not allocate key when not
supported") added proper handling for devices that don't support RSS
hash key configuration, but ena_get_rxfh_key_size() has been unchanged.

When the RSS hash key is not configurable, return 0 instead of
ENA_HASH_KEY_SIZE to clarify getting the value is not supported.

Tested on m5 instance families.

Without patch:
 # ethtool -x ens5 | grep -A 1 "RSS hash key"
 RSS hash key:
 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00

With patch:
 # ethtool -x ens5 | grep -A 1 "RSS hash key"
 RSS hash key:
 Operation not supported

Fixes: 6a4f7dc82d1e ("net: ena: rss: do not allocate key when not supported")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
I considered two possible commits for the Fixes: tag:
- 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
- 6a4f7dc82d1e ("net: ena: rss: do not allocate key when not supported")

and then chose 6a4f7dc82d1e as it introduced the condition where
rss->hash_key could be NULL. However I'm not so attached to the choice,
so please let me know if you prefer a different approach.
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index a81d3a7a3bb9..fe3479b84a1f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -865,7 +865,10 @@ static u32 ena_get_rxfh_indir_size(struct net_device *netdev)
 
 static u32 ena_get_rxfh_key_size(struct net_device *netdev)
 {
-	return ENA_HASH_KEY_SIZE;
+	struct ena_adapter *adapter = netdev_priv(netdev);
+	struct ena_rss *rss = &adapter->ena_dev->rss;
+
+	return rss->hash_key ? ENA_HASH_KEY_SIZE : 0;
 }
 
 static int ena_indirection_table_set(struct ena_adapter *adapter,
-- 
2.48.1


