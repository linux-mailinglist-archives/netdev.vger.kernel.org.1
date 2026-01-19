Return-Path: <netdev+bounces-251004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0AD3A1F8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD1F13006E11
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755134A791;
	Mon, 19 Jan 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nkdNVZrr"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB2349B03
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812342; cv=none; b=EOQmWB/h3sXZEsNUkThSYvZj170Jd7MxT2f+NDXSZYLIjgf3J/vI1Dy4aq4uEirZBK/BivifvhrVLd9759ZlsRM+eFTRUa+LisfzbGHX65/m2N7WLmvMb/qohfWUZiaBDoEmtBV+OYzkRZbPw7gaAfcAz11MqFMy6XgSLeq5U7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812342; c=relaxed/simple;
	bh=JTcG8tMZrg5sxsoEdtWyDI8lsd2AMg1Ibk862sQjXWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVGpM0lSEeZVnUVKJG/VK5sVnkmG+vu1KHjQ0kvvl0/Z4Ht/hUcg6AHiTpijUlThyFh2PdPwk8UZcw3iB0SoaceHmvAQDOMkdeN76nSGk9lyvmTp8CLNnybXUNYU+OnUu8ONwQjmathK9OdUoRl/dALJGj434VdGdZpmvBvGe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nkdNVZrr; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768812338; x=1800348338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6JmUUKk0HTARz9c+4hGfaS02e7Ca3f+gSvgSBa28ns=;
  b=nkdNVZrr0mW2Tqn8dl+uaCaBmduQ3a3osBqtWh+ZXwlxx+7CXQrQmV6L
   1tPYAiKXw3cKWH7u6Y5XPz46jg36649WiiS80jC7xcw3Nvn7AWHyHqzUl
   a2CgimXe1H/DD+rK9xxs6elUPSWRMdL2q2RNglQZp9n9YnZpIq2YfqbJD
   DziWNu+BIfTX/3Hvd15WLQNINTdaCTRVtzaZV57kQroZL4Z8zx5ZH/V5X
   mFaQOZmOpSELdLtWbHaRL2y04Cy7xAtg7pjMqXOLJYJ+2GbI77S4zHvAn
   U3n0Vvim1rLK7077OUIsbKAuc2CgPJA/0kfr2gMRErXMCDS1D6gzmRpIK
   Q==;
X-CSE-ConnectionGUID: V9Qlg45FQN+EEUnoYnS2wQ==
X-CSE-MsgGUID: g8COJbzoQfeUUmqTbo2o6Q==
X-IronPort-AV: E=Sophos;i="6.21,237,1763424000"; 
   d="scan'208";a="11116669"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 08:45:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:13357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.220:2525] with esmtp (Farcaster)
 id ccab0b88-a479-47a8-9391-42f0ea8bc247; Mon, 19 Jan 2026 08:45:34 +0000 (UTC)
X-Farcaster-Flow-ID: ccab0b88-a479-47a8-9391-42f0ea8bc247
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 19 Jan 2026 08:45:32 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 19 Jan 2026 08:45:30 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, Takashi Kozu
	<takkozu@amazon.com>
Subject: [PATCH iwl-next v3 0/3] igb: add RSS key get/set support
Date: Mon, 19 Jan 2026 17:45:04 +0900
Message-ID: <20260119084511.95287-5-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds ethtool get/set support for the RSS hash key in the igb
driver.
- `ethtool -x <dev>` to display the RSS key
- `ethtool -X <dev> hkey <key>` to configure the RSS key

Without patch:

# ethtool -x $DEV | grep key -A1
RSS hash key:
Operation not supported
# ethtool -X $DEV hkey 00:00:00:00:00:00:00:00:00:00:00:00:000
Cannot set RX flow hash configuration:
  Hash key setting not supported


With patch:

# ethtool -x $DEV | grep key -A1
RSS hash key:
86:5d:11:56:bd:6f:20:38:3b:f8:bb:df:00:3a:b0:24:95:9f:f9:f4:25:a3:01:3e:4a:15:d6:7c:4d:af:39:7e:4a:95:f2:fd:f6:b6:26:f7

# ethtool -X $DEV hkey 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
# ethtool -x $DEV | grep key -A1
RSS hash key:
00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00

<Changelog>

  v3: 
      - add ASSERT_RTNL() to explicitly show that an rtnl lock is being used
      - Move netdev_rss_key_fill() function from igb_setup_mrqc() to igb_sw_init()
      - Add kernel-doc header to igb_write_rss_key()

      <Test>
      - tools/testing/selftests/drivers/net/hw/rss_api.py is successful
      Run the following command

      # NETIF=enp0s3 python tools/testing/selftests/drivers/net/hw/rss_api.py | grep -v "# Exception" 

      Then, I checked the diffs before and after applying the patch

      $ diff beforePatch.txt afterPatch.txt 
      9c9
      < not ok 6 rss_api.test_rxfh_nl_set_key
      ---
      > ok 6 rss_api.test_rxfh_nl_set_key
      16c16
      < # Totals: pass:4 fail:8 xfail:0 xpass:0 skip:0 error:0
      ---
      > # Totals: pass:5 fail:7 xfail:0 xpass:0 skip:0 error:0

      The failing tests originally fails due to hardware.

      - tools/testing/selftests/drivers/net/hw/toeplitz.py is untested since there is no actual hardware, but since the logic around wr32() is preserved as it is, key writing to the device remain the same.
      

  v2: Fix typos (igc_* → igb_*) 
      https://lore.kernel.org/intel-wired-lan/20260108052020.84218-5-takkozu@amazon.com/T/

  v1: https://lore.kernel.org/all/20251205082106.4028-5-takkozu@amazon.com/


Takashi Kozu (3):
  igb: prepare for RSS key get/set support
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igb/igb.h         |  4 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 86 ++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_main.c    |  9 +-
 3 files changed, 69 insertions(+), 30 deletions(-)

-- 
2.52.0


