Return-Path: <netdev+bounces-221814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE21B51F00
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8371E178346
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F09324B02;
	Wed, 10 Sep 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QmEk60qS"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAC31D738;
	Wed, 10 Sep 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525527; cv=none; b=RIO/DfL1yrXYfj//oCqgq3l1hDnbUwPkuTOtZODrK3Bec1X3qv1rNItTFyP9w93CPhafme51uXPFM3kfHSmJAUqGzCK2RdurR53SHqpUMGAmgyY6QafTf9jn5nrSClz7WqhXiUySBw0uGJoMIiBQsV/TI4+cCitgHMckPMwowhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525527; c=relaxed/simple;
	bh=yuKQ0lR26nVX8L5krMe10RNzdx00wJz/Brrp083carQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=euYvMmGxH3tOV0Y0OWxfopA7ZJOnrM0HH9LPVt49bs9UCVnhJyXNUDDtRuDOKt5LOLf+EICeZftrt3+LZkMFqIvbi8POjNzLWFvNEBCpEBaEgrANKcS66b7K0+iI5m4yC+2EjYCIT2QK+YkbEYoGiF1zlG2WaN943JrYrn9nM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QmEk60qS; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757525525; x=1789061525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qEzZnMkfHtDYjGZWSxfigRLQrGxze7DhIG2nwdyJImk=;
  b=QmEk60qS5FogFKjvP2Xu98G2CH8YQ9PxSMPGjY5KlBr6uir4yQX4zn6B
   gGqAESb8RZCBHcoj10IxiD5GCuzcPWl1suH52Y3tD759zEuG3rLf7PcPu
   VeQYEElM5CzXqM/oQ2rZPNFwObmabM3lUbLxrdIVYgfA1XiOFbEJiyDqX
   WbqjWuACoySiAP4I56s6vZxg3st6SHAZdji0kEnizTWvs8iT24p0u6fmv
   K0ahDgy+4lidPMZcZ/W9M7iqazXjFTuBoBNfjLNAz2zZ/1Jp19Bl22ZLD
   pEC2w9XIQDGkeECpRk7V569sa0NbUBIFHwssfhz0HMyYVe+Y9hGwbivyh
   Q==;
X-CSE-ConnectionGUID: Lc2tOsb3TWq+ntSm2bVkIg==
X-CSE-MsgGUID: q9x5CrNLRy2f7iQB9yZp/g==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1819311"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 17:31:54 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:11338]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.31.196:2525] with esmtp (Farcaster)
 id ab7880e5-12d4-449e-bd34-c2b22e1c2731; Wed, 10 Sep 2025 17:31:54 +0000 (UTC)
X-Farcaster-Flow-ID: ab7880e5-12d4-449e-bd34-c2b22e1c2731
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 17:31:53 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 10 Sep 2025
 17:31:50 +0000
From: Eliav Farber <farbere@amazon.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <vitaly.lifshits@intel.com>,
	<gregkh@linuxfoundation.org>, <post@mikaelkw.online>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <farbere@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow checks
Date: Wed, 10 Sep 2025 17:31:38 +0000
Message-ID: <20250910173138.8307-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

Fix a compilation failure when warnings are treated as errors:

drivers/net/ethernet/intel/e1000e/ethtool.c: In function ‘e1000_set_eeprom’:
./include/linux/overflow.h:71:15: error: comparison of distinct pointer types lacks a cast [-Werror]
   71 |  (void) (&__a == __d);   \
      |               ^~
drivers/net/ethernet/intel/e1000e/ethtool.c:582:6: note: in expansion of macro ‘check_add_overflow’
  582 |  if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
      |      ^~~~~~~~~~~~~~~~~~

To fix this, change total_len and max_len from size_t to u32 in
e1000_set_eeprom().
The check_add_overflow() helper requires that the first two operands
and the pointer to the result (third operand) all have the same type.
On 64-bit builds, using size_t caused a mismatch with the u32 fields
eeprom->offset and eeprom->len, leading to type check failures.

Fixes: ce8829d3d44b ("e1000e: fix heap overflow in e1000_set_eeprom")
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 4aca854783e2..584378291f3f 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -559,7 +559,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	size_t total_len, max_len;
+	u32 total_len, max_len;
 	u16 *eeprom_buff;
 	int ret_val = 0;
 	int first_word;
-- 
2.47.3


