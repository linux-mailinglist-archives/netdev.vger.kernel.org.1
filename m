Return-Path: <netdev+bounces-244348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0ECB553E
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 591DA300B6B2
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF7233136;
	Thu, 11 Dec 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QLT6xvxr"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA6381C4
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444618; cv=none; b=HZ4hcF/HQOXETATP9r/tJ4zoCVkyfVnockeN6pha3/P5NxqrOPov7Az4JWmN3Q0jO6xo3flqF5q89oNwA87PbHrCDTZodu9gspwJ7Mkzbx2l92gNYQpMHLuJG/3wVfrB2K59WfWINxWbJQIBgl0oBJfEfGCQ+nwfXx750ZbgNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444618; c=relaxed/simple;
	bh=Z93OVyhZ68fI0HZQw0pqV0spCh3LpuId1s3A3wU5jW0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mmfmCOoA5UfUF7opGCyp70sm/CptmT0v9vDeimgBS6yjM2Rsq1rhelXKGb6UaxQI1ZO7WBb/+aTCVHwLJllXVGPB1IS+NotDJEiqqnCLO0RPSrfakGspZSjBrr4OJJbwTST2Rpf4CsEFu8Qy3M/DwtzL/D4p0BsJpJTwYL4SW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QLT6xvxr; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765444616; x=1796980616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uNg4F6k/RPBTY81QVwC0LvyuJ4LEYcF026qfDZof6vc=;
  b=QLT6xvxriv9jDcqK9uy7dMi2n9dt1z5lRN+RvwzY6MzjGXdfynJq5vhJ
   xtxYEXCCTm8as4ECBgoMaMLNw9rNXNcoiDcS6OAU7/4DmziFO/NeSAkl2
   lWTdbjZUEUp7lvWc7Zn9YlDv50vFDDr31zjabwRIpryfBg14whWEofcKw
   4RE8HnMHT5FdJPLnmryKY7pZhrCJd17XoG2eM7X+QVuNvIYbGDUowHmFc
   51jee47qZYMOBheDc5cjm9MwyO5MTab0rcSZ53rlOg/BqO7xxNOxkDiv3
   1Rdncs6CUhFJ4TfdhUdj2HyY4P1Z7/JHWAjkcdBmFdGaTKcoqdfWYVrIn
   w==;
X-CSE-ConnectionGUID: QlD+MqTGRSK10CPQW1szGw==
X-CSE-MsgGUID: rhJr8kBrQL6HS8tWaynf+w==
X-IronPort-AV: E=Sophos;i="6.20,265,1758585600"; 
   d="scan'208";a="8701028"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:16:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:32106]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.230:2525] with esmtp (Farcaster)
 id 02d555f5-35a8-4aa8-b756-0cb42fc2d65d; Thu, 11 Dec 2025 09:16:53 +0000 (UTC)
X-Farcaster-Flow-ID: 02d555f5-35a8-4aa8-b756-0cb42fc2d65d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 09:16:53 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 09:16:51 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Stefan Wegrzyn
	<stefan.wegrzyn@intel.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <kohei@enjuk.org>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-net v2 0/2] ixgbe: fix issues around ixgbe_recovery_probe()
Date: Thu, 11 Dec 2025 18:15:30 +0900
Message-ID: <20251211091636.57722-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

ixgbe_recovery_probe() and codes around this function have two bugs:
1. resource freeing up is not complete, resulting in memory leaks
2. mutex lock (hw->aci.lock) is initialized twice

Fix these issues.

Changes:
  v2:
    - let ixgbe_probe() to clean up, instead of ixgbe_recovery_probe()
    - don't initialize aci lock twice
  v1: https://lore.kernel.org/intel-wired-lan/20251206155146.95857-1-enjuk@amazon.com/

Kohei Enju (2):
  ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
  ixgbe: don't initialize aci lock in ixgbe_recovery_probe()

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 +++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

-- 
2.52.0


