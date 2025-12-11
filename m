Return-Path: <netdev+bounces-244350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B3CB554E
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EB6830010EA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAD283FE3;
	Thu, 11 Dec 2025 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qeja38MM"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64D270ED2
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444656; cv=none; b=ViYOCW446yAN6lsrqcYZqBZ0puGlivJ/IgQXz5z3HIYu8h6R0cltuz2XtAo+WWcp7bGkqhSDq1A0BiQQmFg9PmtXl6/kPSsFGf/6rYhxeiYF/nb+Mch+vgWaq35Tw7qRCJcUARmkzxP/Qj4Gu02iXHhIw4EEgQQshZzM5ubRSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444656; c=relaxed/simple;
	bh=Teuia2mbwPmFnGfcJFyy+Oekt4ldjzV0uN9/4YhTRMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6YymUo11yJRjLdokSap6+tMfxn1cPPdDcHuDonWCjdVBbZOLfDfTlosye8SDt+/vy9W+MbiYey/XC6OXHtuSjuVOKgOjt0pTMC9DJnkFTd0wgsjBvzfu3W9dZAnqxysqJfSDe5gJjETQUo1aXJ/+s9+9XcEjvcX8KYtSY7xhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qeja38MM; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765444654; x=1796980654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ReqNWw9x529uqIp1UH466ezxJx1+9i30DT5W+DPOXo=;
  b=Qeja38MMvSolHJ38RvPwZx32dEl9iRD+CdqhjqukLZMrBmxbfOIRBMJn
   qIs/QrcpOEFHvgmQYs3NsdP89g5TSCQNuodJWbF6skbzTzgxgvdq2kF1p
   vtViEhJgyEwVmmVsCpZScGbQif0lyGk0AmXP22xPocFDyi0B6Kb/Vk3wU
   MHYOPwqoGHdSBuNHYUxglyfNHf2z0inEqdrkDJOJpPBSsY4waQnHH0UQ1
   zFaIp2E1Ry0qWGwudGNWfLyjWF47Dg7IqsDcDutnfifa387EENSiBdDxL
   ocBhqPzEjKIdyMA6GVmz9/GYhf2fpH8+VeiO/jxTc2XrO9MjcF9H1UZa1
   g==;
X-CSE-ConnectionGUID: 7z5XtcuTTRSg6iIjsF34pA==
X-CSE-MsgGUID: SKEt8UE5SbuJPSS13CiTtA==
X-IronPort-AV: E=Sophos;i="6.20,265,1758585600"; 
   d="scan'208";a="8684372"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:17:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:1900]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.136:2525] with esmtp (Farcaster)
 id 08176fd1-36c7-465b-b25b-070a1a1e8fbd; Thu, 11 Dec 2025 09:17:33 +0000 (UTC)
X-Farcaster-Flow-ID: 08176fd1-36c7-465b-b25b-070a1a1e8fbd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 09:17:32 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 09:17:29 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Stefan Wegrzyn
	<stefan.wegrzyn@intel.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <kohei@enjuk.org>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-net v2 2/2] ixgbe: don't initialize aci lock in ixgbe_recovery_probe()
Date: Thu, 11 Dec 2025 18:15:32 +0900
Message-ID: <20251211091636.57722-3-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251211091636.57722-1-enjuk@amazon.com>
References: <20251211091636.57722-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

hw->aci.lock is already initialized in ixgbe_sw_init(), so
ixgbe_recovery_probe() doesn't need to initialize the lock. This
function is also not responsible for destroying the lock on failures.

Additionally, change the name of label in accordance with this change.

Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/aTcFhoH-z2btEKT-@horms.kernel.org/
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 85023bb4e5a5..b5de8a218424 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11476,10 +11476,9 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 		return err;
 
 	ixgbe_get_hw_control(adapter);
-	mutex_init(&hw->aci.lock);
 	err = ixgbe_get_flash_data(&adapter->hw);
 	if (err)
-		goto shutdown_aci;
+		goto err_release_hw_control;
 
 	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
 	INIT_WORK(&adapter->service_task, ixgbe_recovery_service_task);
@@ -11502,8 +11501,7 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 	devl_unlock(adapter->devlink);
 
 	return 0;
-shutdown_aci:
-	mutex_destroy(&adapter->hw.aci.lock);
+err_release_hw_control:
 	ixgbe_release_hw_control(adapter);
 	return err;
 }
-- 
2.52.0


