Return-Path: <netdev+bounces-227956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F620BBE0CE
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87C93BB9EA
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD127FB1C;
	Mon,  6 Oct 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hmnPZ76Q"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517227F754
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754325; cv=none; b=pXlwwTRURV/Ujuftu5GozgdlsroEjP0blVaOCm4ysDFnKhu6PjI9+26domrokOmFyDg7/FivfGH64W2gCW4gYUfhY7MZ1c4z5OWy36hDkzwyLDMeUNOL3+R1kw6+CQ5po778r0cy4Js9pFRroYyEN9RE+8EqJu/zqMNB7BanJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754325; c=relaxed/simple;
	bh=di6SRw3pHI6cEOOzuOxZ7aEEJ/SP2Q899SyuBmwNHWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/83nwEG20M2+hF6ah+IpHnJpZFUGp7EEGT0/l47dQzUXptxyN574B9uVcxBKIEFLEZrMoToPrTSLlXwyvLpc9VT52fRN6ffrX/kDP3480TVCpfSApRuYHMl1Qk5UBNa1YByK4y1TCpTVMZMWiisQ7zbQtWp3QPGBUDKhlscjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hmnPZ76Q; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759754323; x=1791290323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w1ho3AKsusw0YaB2Mzcv5sgobas24QH5Pr9I5YKB0Us=;
  b=hmnPZ76Qbm3RKPhi87gaQOUq3gtRvi27MegW4vL+FSNYTTi3GzTtRrdW
   fqH8ayiN/UZu3b2HQHz+H8zs3uOh9Bpw6UClT7N5lp3rPGFDPdp6w2u+p
   C/BEnSaROx6dpwxRckCk1lEr5Cpo9ENv685Pth0E5EbeOqfQNOdjc7DVL
   hM65xBgJdpvgI/HjnKdb7PhpmOgFfM9sgfHB8MVpsAgkk2GaMNLyowPo6
   MzyDFIo/XKSwxQZ99Z4Od4+T/Jfb1rQGifDMdwRrczKdOH3aVOXrG8vXK
   94N8J6zPfMzga1w371sWFjhoGCA6DMZxFNnipRV/bWii+Y6Ij47DPxL70
   A==;
X-CSE-ConnectionGUID: CoxzmejuQUGvLrDzsDTnEg==
X-CSE-MsgGUID: CyiQNdvwRD6PJF8ZbH1JKg==
X-IronPort-AV: E=Sophos;i="6.18,319,1751241600"; 
   d="scan'208";a="4182878"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 12:38:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:59160]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525] with esmtp (Farcaster)
 id 034f4a92-bb00-487b-b42c-23a385aa2101; Mon, 6 Oct 2025 12:38:43 +0000 (UTC)
X-Farcaster-Flow-ID: 034f4a92-bb00-487b-b42c-23a385aa2101
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:38:43 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:38:40 +0000
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
Subject: [PATCH iwl-net v1 2/3] igc: use EOPNOTSUPP instead of ENOTSUPP in igc_ethtool_get_sset_count()
Date: Mon, 6 Oct 2025 21:35:22 +0900
Message-ID: <20251006123741.43462-3-enjuk@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

igc_ethtool_get_sset_count() returns -ENOTSUPP when a given stringset is
not supported, causing userland programs to get "Unknown error 524".

Since EOPNOTSUPP should be used when error is propagated to userland,
return -EOPNOTSUPP instead of -ENOTSUPP.

Fixes: 36b9fea60961 ("igc: Add support for statistics")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index ca93629b1d3a..bb783042d1af 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -810,7 +810,7 @@ static int igc_ethtool_get_sset_count(struct net_device *netdev, int sset)
 	case ETH_SS_PRIV_FLAGS:
 		return IGC_PRIV_FLAGS_STR_LEN;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.48.1


