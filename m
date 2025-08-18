Return-Path: <netdev+bounces-214654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7FB2AC9F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A445F1965FAD
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75484256C76;
	Mon, 18 Aug 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VDnSxP6d"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD32566D3;
	Mon, 18 Aug 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530359; cv=none; b=DaEV8mfGORxFp7TqRHpEqODPHOI7nz+ZYkvncm9K9leHVQl6amMSZqHerjn2CI4ehpC6XMyiEv5cc3gWJpaYtFdgJJqJMPZ1G+kizhY2mpu8uAao3WgjLfFS5aY0dLwYWAytTW/NmBf4e7i5zwPe3lcXakLu+fYjr0kJrlOEwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530359; c=relaxed/simple;
	bh=+4Fs7Qy+5QfQkhCW1ldMCRWSp1qeb+vgo9mEqV61/wg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2KCwygRaOOHF9DX+wDAku0k0wodt59RGb1//hAxzVS9J/72jbahN8QMsmG8m7p0sxkh6Xj+0++UFEe/4QMd9GWVknLtD6whTF+TiiiewOCNxAtqZcITxy5LMsU2JpAiLCvTXDSF+4pM5kEqKdYzbYjsnwzmQ+A+Of9pkMfbLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VDnSxP6d; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755530357; x=1787066357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6yuSU9QtOrPsASctmh4Lb/blPVMIH5637/TpUeKDT48=;
  b=VDnSxP6dRJlRaLIriXtwjG6bEXLYJbe/AhZZV813fDLwhN7hxE2+GJLq
   D4bHhEKstvwHlu++xy/+we5fPPpt62P9pFSlwjEtCf2g6M0t9MEwLQ1SE
   Bx72UG0XYeT45TnPrf9e2LY4uFXr9Bs+MrIBNv5Nm9stPMuOMgVB7NA1n
   Blqx1CsMU9TwH3mC1ulypQTbB5lKOsMpfg4rDF/7cziVHCRChdaOa7T5w
   aGdLjekQJUNFlWO1dwizNBdumS2+URPpSgeT2FbIYAq3GoRzigAj+9lSG
   mzy3B4mM7XWXFJoDkEmAaV9/KOzDg0a/vHAcZIO7HxrRMg321ojlxg6uU
   w==;
X-CSE-ConnectionGUID: 0d1gPxN4RMO49u0YWCL96w==
X-CSE-MsgGUID: bXrj//2bTay4wpr6HK24Vw==
X-IronPort-AV: E=Sophos;i="6.16,315,1744070400"; 
   d="scan'208";a="1194597"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 15:19:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:29098]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.64:2525] with esmtp (Farcaster)
 id fb48a1f8-a8bf-4ec8-b8a9-149eebf8bd5a; Mon, 18 Aug 2025 15:19:15 +0000 (UTC)
X-Farcaster-Flow-ID: fb48a1f8-a8bf-4ec8-b8a9-149eebf8bd5a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 15:19:15 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 15:19:12 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v2 iwl-next 0/2] igbvf: ethtool statistics improvements
Date: Tue, 19 Aug 2025 00:18:25 +0900
Message-ID: <20250818151902.64979-4-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series contains:
1. Add missing lbtx_packets and lbtx_bytes counters that are available
in hardware but not exposed via ethtool
2. Remove rx_long_byte_count counter that shows the same value as
rx_bytes

Tested on Intel Corporation I350 Gigabit Network Connection.

Changes:
  v1: https://lore.kernel.org/intel-wired-lan/20250813075206.70114-1-enjuk@amazon.com/
  v2:
    - Remove Tested-by: tag
    - Add Reviewed-by: tag
    - s/duplicated/redundant/ in commit message of the 2/2 patch

Kohei Enju (2):
  igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
  igbvf: remove redundant counter rx_long_byte_count from ethtool
    statistics

 drivers/net/ethernet/intel/igbvf/ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.48.1


