Return-Path: <netdev+bounces-227955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C10BBE0BF
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C268034A209
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274D27F754;
	Mon,  6 Oct 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gtsklhd+"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36E2459F8
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754305; cv=none; b=bb2yHaTV/palMYOOHA2p+LRmtWhtZmVJBqSSbfjFHN6EmtQKM2sW3sDfwGmgK314wls95HCaf6kXtfrexb9ka/OBfZ4UvLROj+vmWhmozZLTzko0G3sZKAPM0TamMx/xOwtl2454wYXPuCJt45HGlw6XZcfoyWXsl/d0U9BHUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754305; c=relaxed/simple;
	bh=l3JmqtFWmGFBl7drRumDMdwimLXidtMh3AFwKCSPUzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fz00aO+Ln8vGaP/ZhwYIaXdmOr0syAqgkTvlIwJKSAO0mOftrT6NEB+a5ZLfbc/PIsb3T6MXLGMQUUbU9Jm8YFlrUUCuOeT66hjs9ON/snQAqiJ6/ZZVSPKsxOSGtLxdAFojvGPpw7Oo7Lttb+5SNoiZEpR9faozbn409Q4K4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gtsklhd+; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759754303; x=1791290303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YG9e/0v+fYu3UiekrrDI0YP0FDkXWAEUGnUqxPOjvLg=;
  b=Gtsklhd+juvoG652Ra/lQ9XFq3RxmJRbIfxHMJoQOXV/6pO2a5EvOhjz
   ajT6Amt8BjA+vECBmxJy6QOUiIvmu7YzhLw4chwa+Ud4nIjuHmFSdGaZS
   ggYTicorj7rSDMVSFONGlcMeTQDw4wQ2yeSYgI34PuLIiYCGfmnpSyQQ0
   khvGonCj+4qFcsbCR/XUt6aepKjLJVZDL0JEfRA/BazRiAJkbyUL6WPXt
   RzEheZKDgayBQZ18CFiBPVUNB/b7tePEZtkzYaPLi2KLZoiwQ3s4ZWjEw
   BGkXx2t2KjSZeAN2pxLVcQaAWl3vm8WqgdJhQmdTPDxw8BFy8qzyImyC2
   g==;
X-CSE-ConnectionGUID: nXhKJ3QOTequsnyGVdt/7w==
X-CSE-MsgGUID: FpuhatAATfCfYtrre7QXMA==
X-IronPort-AV: E=Sophos;i="6.18,319,1751241600"; 
   d="scan'208";a="4177589"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 12:38:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:16972]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.215:2525] with esmtp (Farcaster)
 id 96070aa0-62ba-4d12-8db9-4c20b3e74c89; Mon, 6 Oct 2025 12:38:21 +0000 (UTC)
X-Farcaster-Flow-ID: 96070aa0-62ba-4d12-8db9-4c20b3e74c89
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:38:18 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:38:15 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Auke Kok
	<auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@redhat.com>, Sasha Neftin
	<sasha.neftin@intel.com>, Richard Cochran <richardcochran@gmail.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-net v1 1/3] igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
Date: Mon, 6 Oct 2025 21:35:21 +0900
Message-ID: <20251006123741.43462-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251006123741.43462-1-enjuk@amazon.com>
References: <20251006123741.43462-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

igb_get_sset_count() returns -ENOTSUPP when a given stringset is not
supported, causing userland programs to get "Unknown error 524".

Since EOPNOTSUPP should be used when error is propagated to userland,
return -EOPNOTSUPP instead of -ENOTSUPP.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f8a208c84f15..10e2445e0ded 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2281,7 +2281,7 @@ static int igb_get_sset_count(struct net_device *netdev, int sset)
 	case ETH_SS_PRIV_FLAGS:
 		return IGB_PRIV_FLAGS_STR_LEN;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.48.1


