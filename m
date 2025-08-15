Return-Path: <netdev+bounces-213979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B989B2792A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB09D3AA165
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1329E0E5;
	Fri, 15 Aug 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HvPGZnad"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73B221FC3
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239221; cv=none; b=EhpK7ceo1tSs/E4nl18K+U29sYSaUVGtyUAazFKoBNyjNGDLsG1HmKNoc+M/VHz61qTrqDxQRWpLFfzEttKzB/R+Q/HZ/ZhN/1cvsYXXhtk6mzQPR3HNbYVpf+J04X9LXA7l5F+Jb85rZYA7ynd/IMwxnXm0oXReF865fKa2ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239221; c=relaxed/simple;
	bh=q2rMhE0F4Dc/CTP4GoN3/Ce6SxrBRfkioc2AyISv+RU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1k4Q3F3qPr0oUENE1SEDW47R0W+76w0cUd2SJ9ACvasPfMvA/GI8VeYS1BPxN2/QogVCSEXQg1oEaGfCWiOPYAck05fnvM0kYN6SyCmPWX3PbCUk83wLTOzu1NpM+C43MFfBYFT6EIgsldj0ca/y2ojN7XB5dK9V2eFqqs4BcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HvPGZnad; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755239220; x=1786775220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W+4B1PE8JjAVZ4KWC2fx7ebRmgw7WuiLWGG2j2I/AbQ=;
  b=HvPGZnaduKnGXGRNTs7OugzSG6u2vodb7KedzwQeC4/nZFSdyvmP5j/o
   Oy/fLGzGr+kAvitCPAAroXVlQS2B0J54a0KrY0VJsQFKTL8uoqa1irlDm
   jmGI8MOR4R7JN1sJfB2M5zj2aqHH3/mlhd4CkZhzWRlww3ohFjVRPrwEa
   MEqOvX0ay+V4JUqcAFPIlxBIsKvypTh0kv1WeNhJ+3A9AFPf8cvzpwuHl
   lEQMwE1+PhVyfxTg0PX7CWSizy6CFEZIg/3ilN7/yichEzUUVD/mpcnt1
   Q/fG91ccb7COoI0sQ6fBKNZ4XnnqOXrZRH2oHVWbcdHoqeGGIppyl6Hfo
   w==;
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="322826890"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 06:26:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:10183]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.153:2525] with esmtp (Farcaster)
 id 6ae1a36c-b381-4393-8862-bb5b35eeb403; Fri, 15 Aug 2025 06:26:56 +0000 (UTC)
X-Farcaster-Flow-ID: 6ae1a36c-b381-4393-8862-bb5b35eeb403
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 15 Aug 2025 06:26:56 +0000
Received: from b0be8375a521.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 15 Aug 2025 06:26:54 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander Duyck
	<alexander.h.duyck@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH v1 iwl-net] igb: fix link test skipping when interface is admin down
Date: Fri, 15 Aug 2025 15:26:31 +0900
Message-ID: <20250815062645.93732-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The igb driver incorrectly skips the link test when the network
interface is admin down (if_running == false), causing the test to
always report PASS regardless of the actual physical link state.

This behavior is inconsistent with other drivers (e.g. i40e, ice, ixgbe,
etc.) which correctly test the physical link state regardless of admin
state.
Remove the if_running check to ensure link test always reflects the
physical link state.

Fixes: 8d420a1b3ea6 ("igb: correct link test not being run when link is down")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ca6ccbc13954..6412c84e2d17 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device *netdev,
 	} else {
 		dev_info(&adapter->pdev->dev, "online testing starting\n");
 
-		/* PHY is powered down when interface is down */
-		if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
+		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
-		else
-			data[TEST_LINK] = 0;
 
 		/* Online tests aren't run; pass by default */
 		data[TEST_REG] = 0;
-- 
2.48.1


