Return-Path: <netdev+bounces-218501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44374B3CDCA
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC6F1BA2323
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF68B253359;
	Sat, 30 Aug 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OXR6x/+x"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9E10F2
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573634; cv=none; b=feFyRbZ9vEUuryckwayBMpLQhnFkJKl6RrU4qTgU7121poRBZRcykvKg+i8+Fy/7E9b1olhzpjVrI6ZDU2gTzkKKLdaFWYFuAsgHfiw0RnoZfT738JF8I/92/WNyZV8Kbx5nYTB/0f6gbHBYZ39tgx8GMKy+6q1Giqh/dXmluB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573634; c=relaxed/simple;
	bh=N9tJRz5XsXgh7My06wwbviJr15zF1p3ehWyVNFEYpP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJ/PDzXzrubdplmIdHjanl7BDqtr/n2rcO1yGo443IX7vFe6paMs+O+fh3gbIL8qaEUciLbLBB9uAusSGzq3uSV+IQYVfOXm59nV2/XXrUnOVbBT4N3oyj194eGG6czPC4oenCWQ4/OjRpAr1yGIKz79qDOQ9oAGk+74DGme39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OXR6x/+x; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756573633; x=1788109633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vtoHwbnjMYaKkuefkVMlJvs69QCPincUUUT1mwg3QrU=;
  b=OXR6x/+xc7aEuouicjdl7B378R3zm0phESHOpYJzhjhBWrazUCH6+oWZ
   MuE+hwhp097ikCYc2pOqPh44gQpjGZvgwcXL5rT2t/nkuwlCPziyTr08H
   LPl5r2WI4Jddd9eZFXIwHPKX0XFbSSr9KR+yNfU1+ZpBIFSxavj2ibJHq
   e4imuo8CeK90TMXvKDvwiEsFFeLmp2u/aWNXEJDoIPoQ73vtnVh0tneVB
   QoOJIYUc9ysKq9YrJrq20WwOXrGQdusb16YzVa5woTuDM0VmtI7sKV8Vq
   xCbFLUJhC00FBIuAfIFlu0NxrjxDsTpPLl2P6ReKSvOUxO98WWuq2Qp8m
   A==;
X-CSE-ConnectionGUID: bAQNkEFQSbyErR0aiQQYcg==
X-CSE-MsgGUID: YnHDzTZTRXWeWZSoEZ8kmA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751241600"; 
   d="scan'208";a="1976103"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 17:07:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:61962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.142:2525] with esmtp (Farcaster)
 id 702d1bac-376b-4f8e-b9ff-04c77493302d; Sat, 30 Aug 2025 17:07:11 +0000 (UTC)
X-Farcaster-Flow-ID: 702d1bac-376b-4f8e-b9ff-04c77493302d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Sat, 30 Aug 2025 17:07:10 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 30 Aug 2025 17:07:08 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vitaly Lifshits
	<vitaly.lifshits@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH v1 iwl-net] igc: power up PHY before link test
Date: Sun, 31 Aug 2025 02:06:19 +0900
Message-ID: <20250830170656.61496-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The current implementation of igc driver doesn't power up PHY before
link test in igc_ethtool_diag_test(), causing the link test to always
report FAIL when admin state is down and PHY is consequently powered
down.

To test the link state regardless of admin state, let's power up PHY in
case of PHY down before link test.

Tested on Intel Corporation Ethernet Controller I226-V (rev 04) with
cable connected and link available.

Set device down and do ethtool test.
  # ip link set dev enp0s5 down

Without patch:
  # ethtool --test enp0s5
  The test result is FAIL
  The test extra info:
  Register test  (offline)         0
  Eeprom test    (offline)         0
  Interrupt test (offline)         0
  Loopback test  (offline)         0
  Link test   (on/offline)         1

With patch:
  # ethtool --test enp0s5
  The test result is PASS
  The test extra info:
  Register test  (offline)         0
  Eeprom test    (offline)         0
  Interrupt test (offline)         0
  Loopback test  (offline)         0
  Link test   (on/offline)         0

Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
This patch uses igc_power_up_phy_copper() instead of igc_power_up_link()
to avoid PHY reset. The function only clears MII_CR_POWER_DOWN bit
without performing PHY reset, so it should not cause the autoneg
interference issue explained in the following comment:
    /* Link test performed before hardware reset so autoneg doesn't
     * interfere with test result
     */
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f3e7218ba6f3..ca93629b1d3a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -2094,6 +2094,9 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
 		netdev_info(adapter->netdev, "Offline testing starting");
 		set_bit(__IGC_TESTING, &adapter->state);
 
+		/* power up PHY for link test */
+		igc_power_up_phy_copper(&adapter->hw);
+
 		/* Link test performed before hardware reset so autoneg doesn't
 		 * interfere with test result
 		 */
-- 
2.48.1


