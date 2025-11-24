Return-Path: <netdev+bounces-241118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA6C7F6C4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C38B3A627E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FCF2F28F6;
	Mon, 24 Nov 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYuDI4Ag"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E522F12BD;
	Mon, 24 Nov 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974109; cv=none; b=JKvg8c5NDLp8S/X0E3p8WxZejgo42hLjCSDS9fsCYFCiyLe//2bWOMdMGaHRRXBTzR17gVQVkVEs0/dF/AKbU+vUqPAptH2Pl5wf3GdJY2cm3jt07lC0u1Zi/VF1Tzhsr3j32709fJ18i6sjEcIFayieqHw1drycftvwCkZcZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974109; c=relaxed/simple;
	bh=16jY6OH6luP8crDYCxHQBYhqJL6CLIweYFPaai388f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eg3bgIoJP8SEdFPLE/1u7RuD4tB9f02YqGSzoYsB8uUmHb8mGxEVcN5oToEGsi29PwmQJ6d4bdYWs5tseScYnk8aAjXEVUv+I06k89oc4Iy7dqZrlz5drSJOrx+D0e9lWvp3DmsgWCg13iQqcKY3ezwvRT6+dKARLqLi3M2SDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYuDI4Ag; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763974107; x=1795510107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=16jY6OH6luP8crDYCxHQBYhqJL6CLIweYFPaai388f8=;
  b=UYuDI4Agge+Zu+MwEITRCD8fD+IqAYT+TJ2ZiRDx/NYEydfl5udm8wKE
   v0g8m8armeLiU1E729DRykaHJgiN230zeCtSn03uqmyZmLXOD9aBq84VI
   qD5ofmY70T0n5TrEoaLg5FFeiPhFVcB8aqnZH3KNPgW0p+BavuLC39UKL
   Ka6VdbzhBgmacXt5Mesqbc5H3KOHb58fOOKUzG9ezLPGhpult112ViBRj
   ImIjq/SHKGJqQ8u6hmYt6CnD59QMrxwPsusvnx0/3ZxWgudrC4mugomjh
   I177MBrxhQmUbkb1IqLSh8EZqTIH/9T95jfIDLZGKRZ6Av4Nx9oP9lSDq
   A==;
X-CSE-ConnectionGUID: ZstoqgkyRSKdSiiOlprwgw==
X-CSE-MsgGUID: X4Da5icGQ0+pBh0eNDkcBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65918449"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65918449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:48:21 -0800
X-CSE-ConnectionGUID: QN3BxsBXQ46vjVZcZaW1iw==
X-CSE-MsgGUID: ELISTBZhRdy6cWL7ioSUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="196729229"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 24 Nov 2025 00:48:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D91289A; Mon, 24 Nov 2025 09:48:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 3/4] ptp: ocp: Apply standard pattern for cleaning up loop
Date: Mon, 24 Nov 2025 09:45:47 +0100
Message-ID: <20251124084816.205035-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
References: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while (i--) is a standard pattern for the cleaning up loops.
Apply this pattern where it makes sense in the driver.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 1fd2243e0f9f..63c73a5909f2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4818,8 +4818,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 out_dpll:
-	while (i) {
-		--i;
+	while (i--) {
 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
 		dpll_pin_put(bp->sma[i].dpll_pin);
 	}
-- 
2.50.1


