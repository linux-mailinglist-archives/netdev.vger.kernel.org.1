Return-Path: <netdev+bounces-197106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC077AD77E5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F17B27C3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8441E5B68;
	Thu, 12 Jun 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bHHBK51l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC95298CB2
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745012; cv=none; b=JygiZORjNGnPZqnRpHOOqVB2B9yFYbA23gUKE2OeebucTtUQcUq540I/H7wbe8Wbms6UbEXpJtyWCuhpU+uUZeBFlm2LOqe9S/ycBXzOtYdOWTMw763IgoprG/UHUq327uHgi+sHoUFXJk/pRwu2TfDp9aCeQkOastPdYgcAYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745012; c=relaxed/simple;
	bh=3QY5lvQ8Vb+Zfl9VUBqY+1YhAz0cEuRfEBmfww8HNjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WAe+Iki+6Q9PllJcvuH1yfiwJ+a8K7H6wGlaVLx3h5TAoaCVzQNeZpAGTO0p1EHpAR5i5lUls0FqRDjHPdOEd+B82ujnGtyUsdFLJFXqkrXJFYQlWCiCqJnlhtwoFN6/GZXAZtBwV93/WVrwkvhVRgBdYlS3TylOxxQLGGHbZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bHHBK51l; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749745011; x=1781281011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PwA1gK3ywNpEqJYR5IfEz0DnydqoK8nP+fxiaxpfICE=;
  b=bHHBK51lSlU0OkRbiPuIK72Fg56Ex5ZGURy9fj1/MQNURXMVF6peZ0xN
   +eqCMuWeQgYmF4lYTuW7ZP6BoaOe3IzCotaASOtwzoT62VvFE7luoixEt
   sEgPzUlb3RTGUD9PDtslUHtFzQTGagoMMxsWXQBIYjAL4pn0nRPNddVvb
   GluGUp5wDrEvrd2wTjtOZE10kho/N5I3gHLg0rpMaPl8bOC+kYXSejRLH
   gno2i7/eV7VA/PVFEYXqJ7Alm6ldyrgucJBPsFqBWP4A/KAFNKFRPlITA
   3U4ht1luxStao20Nx6FCEhvoVrkLh0YVvvdWopK97NYj917pFbEGsEzgQ
   A==;
X-IronPort-AV: E=Sophos;i="6.16,231,1744070400"; 
   d="scan'208";a="103514933"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 16:16:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:11930]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.42:2525] with esmtp (Farcaster)
 id e9fa0be0-c8a7-44d3-b95f-f3e7bfff92f5; Thu, 12 Jun 2025 16:16:46 +0000 (UTC)
X-Farcaster-Flow-ID: e9fa0be0-c8a7-44d3-b95f-f3e7bfff92f5
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 16:16:44 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 16:16:40 +0000
From: Kohei Enju <enjuk@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kohei Enju <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v1] igbvf: add tx_timeout_count to ethtool statistics
Date: Fri, 13 Jun 2025 01:16:26 +0900
Message-ID: <20250612161630.67851-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

Add `tx_timeout_count` to ethtool statistics to provide visibility into
transmit timeout events, bringing igbvf in line with other Intel
ethernet drivers.

Currently `tx_timeout_count` is incremented in igbvf_watchdog_task() and
igbvf_tx_timeout() but is not exposed to userspace nor used elsewhere in
the driver.

Before:
  # ethtool -S ens5 | grep tx
       tx_packets: 43
       tx_bytes: 4408
       tx_restart_queue: 0

After:
  # ethtool -S ens5 | grep tx
       tx_packets: 41
       tx_bytes: 4241
       tx_restart_queue: 0
       tx_timeout_count: 0

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igbvf/ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 83b97989a6bd..773895c663fd 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -33,6 +33,7 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
 	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
 	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
 	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
+	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
 	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },
 	{ "rx_csum_offload_good", IGBVF_STAT(hw_csum_good, zero_base) },
 	{ "rx_csum_offload_errors", IGBVF_STAT(hw_csum_err, zero_base) },
-- 
2.49.0


