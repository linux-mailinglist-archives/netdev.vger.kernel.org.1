Return-Path: <netdev+bounces-251413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689DD3C439
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53B54547E2B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005C3E95B1;
	Tue, 20 Jan 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gbR5dbee"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF123D669A
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901698; cv=none; b=rRYGtB8i1qjvgZN2w2RH2zlfXjD+fbg7cVHxAQZMKoFKE3dlEQcp9se4IEzXZKA9vZ9vyFNR0Ft2aO/ShZuVcqYsyFFYAfhmAnsboijAcDuZ7be+NbbQ2ITFLQwn8wmsSA71rYayTqrL+2Gig+hFwReCKQ/DV8NonpyWuhxwPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901698; c=relaxed/simple;
	bh=Dfd+jxj7LcW33ePC6v21142p1t602mHVj0fWLL0UW7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6LZ/jHgW+EtpzkvMP90SGjaU4oAnFCLHaE7UgUvv3P6+kAMnTKvfU+JgZTrFvm7jdq4/JFQ9Los7YdEZ+F4hLVjkszU8T93tZ53UmVAztQ0oWN4pVEDus1yV8u6/sgD3x3yV3QRI2e4qWpngAIXStrnx2BQRILiZc9Q3aaRNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gbR5dbee; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768901696; x=1800437696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xOTRJDjlbK2HDPXI2qW3j9y8/qH4C71a3aPXSATt7xY=;
  b=gbR5dbeeR5VdunOGfxHK/KFW0zs9eW6iPlmlhAMI5qVA9WTcTFwzQLtx
   jZwpvADl06WLjIFxtsv69coqA4VyuwUgX6vch6AP7SH/4R3gViOg3pZgn
   FF6ZDo8MKy9e4FqruxpJLIGAi2bREFOE8wjzA01qkhd7j9qDT9qMk3JnW
   pHuXjqCC+F6dVjkq0SnT0n4dDrFVFjLBNEozdx2SNXv9vOoze5++VGgzm
   rTK1LE/8sW9Iyt8K0EJGFqcI3ZAAxrH//FYXVelDlBqZySiCAUOQAJBTy
   qanEJcywTFrLB2iC458l51AJtCKrXKcZN6BEQ+DmOuhDCzBExhETjuuW0
   A==;
X-CSE-ConnectionGUID: uKUR499aRZ+HudH4dc5WMw==
X-CSE-MsgGUID: cbRWkT0wSYKaGCIACE36Cg==
X-IronPort-AV: E=Sophos;i="6.21,240,1763424000"; 
   d="scan'208";a="10968869"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:34:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:9157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.244:2525] with esmtp (Farcaster)
 id 4663bcf1-7421-44bd-9c5f-0abee9b6f853; Tue, 20 Jan 2026 09:34:53 +0000 (UTC)
X-Farcaster-Flow-ID: 4663bcf1-7421-44bd-9c5f-0abee9b6f853
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 09:34:53 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 09:34:51 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
	Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v4 0/3] igb: add RSS key get/set support
Date: Tue, 20 Jan 2026 18:34:37 +0900
Message-ID: <20260120093441.70075-5-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
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
  v4: 
      - modify the position of the declaration in the igb_write_rss_key() so that it is at the start of the block.

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


