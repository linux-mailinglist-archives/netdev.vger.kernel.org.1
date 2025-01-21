Return-Path: <netdev+bounces-159918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DAA175ED
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8562716AC87
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE16433A8;
	Tue, 21 Jan 2025 02:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190F33F7
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426073; cv=none; b=f6jXEs//9uwX3vD+ra0ORbTj1zWgoLGNzn8MUrIE5E24PA3NkKaA9MeIOJGtO+vp/FBYugYqF0F/CfG5YhFH//RxX8LqmTCfE5macXR9iCJyxc3zDccoAuEg3m29PW3iPB2QAyOqzj4oEnXNlJmiPI2ePa94xqxiJpimtAQQNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426073; c=relaxed/simple;
	bh=CuO4sMLRNu0w4gzwmF3nm1w7ffx/KnIN9Sxf30Dn6mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkTotDeVFBbJStWTvzpS8M/2jGniwvF7XIZN5pGgh3UUougiBWNFF6AkhBKkzmnp7//Zp35e0Ph39AuDqTqAiTZJPblFb0/Fw9+wPRfmF1awV8owu0MWYb/AQVjIivNaXQZzYDqtlDZ+iwJ0O1lBOIpmDZawic9HPhYBOYTq+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz7t1737426059t905onh
X-QQ-Originating-IP: UeCzlNfsBpuA/5Io+T51Vwhm+HQRVF5RmEMWlvAS0+I=
Received: from wxdbg.localdomain.com ( [115.197.136.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jan 2025 10:20:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13450581408083396056
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 0/4] Support PTP clock for Wangxun NICs
Date: Tue, 21 Jan 2025 10:20:30 +0800
Message-Id: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OccmtviHNKX22KWLF/Qbo7OA1126/A/WTnGw5oa4sNKW5QEyGOcqimYK
	Ee67okDbBoX9NsPvAPT1w8N28SVl+TpOUe+D5Bw6oC7h5mDn4K9LM3AUXmVgiyp1yRxWFrY
	zDrsiDOGm6ckIvvsD4Lpe3yLI61q4KxYbWU4uZ/G7RNQY95zMi7Twj/dky42wj1waRof0n+
	CNqrNI1cwoR1Y6hoGIOLGMykcOFzLs58GdZD7JqthcjXIJuEQq5/cud8RxyJ2QGBP4xD5gC
	bTpqwlEiiRDzYlRTpFW6EAjsEZ5pYXfItmjrmx3s4w6v9ATmexosQrjloKWjSafOQ0PC1sk
	pNcdj58fQFl/7VbXaYXMPTbZPjhTwou1/91YI7OOI276OAo6ikcnY2uwbZXDoVnNUsMA1jG
	vxMttbOSHfCYtwksLSZE1i+2x5f9LHxoo5SRjf821lDebp7TSEe8oI/+T9cKfGPs13JUJfR
	skYzUjaPSqBqsO62NfEmMzzlKgDL7qqZ749xLFeUK9TdACEZ/0J2TbNrOfEzxOS1EM2j0o1
	Udcngok+IEickr1ZATN5r+qoE/9CBncn4BgEV7CM8xbvh66XChXbfv1MepVRMZahI9PlqxX
	sRt0rLUisIgJSNaAVTnJtGq3KoiNh6rJ+X4TAk9UYRgZKe2A7mlPUgEt0SE3Shu9mxffHPe
	jPnZlNwKCIz8GXwkcV1//oJ9HG4WnV1dMEiVUG7zu2ggUT7xk4Q/UYudKvV6Z5LhZ8mcSuU
	rBi13+sSyg2zmcjTYAuAwLQCu+0Lhh+skOD4Qs/c+20GZytzz8P89TACm2g6/GY9RWFjbvm
	e3z+dDEf0gwDMBUzWwitxR4rxwfsLbSP2o1r3rc2eC+h+rsmcJcHbUn+Bp4LVSsXY0eKDj4
	asV0D4TIDvFhxPVml2n18FL3prDBwSAl/qwvfg2XTUpQTwz6yfnVITtFHaLgiN+F2uFSwQY
	aIJlD/tw9S4T5CHOOoWnji3n/AjeqDx1wDkGTuFYWls1ytA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

Changes in v6:
- Link to v5: https://lore.kernel.org/all/20250117062051.2257073-1-jiawenwu@trustnetic.com/
- Add "depends on PTP_1588_CLOCK_OPTIONAL" in Kconfig to fix build
  errors

Changes in v5:
- Link to v4: https://lore.kernel.org/all/20250114084425.2203428-1-jiawenwu@trustnetic.com/
- Use reading template for timecounter_cyc2time()
- Move the same piece of codes to the functions
- Fix read sequence for time registers
- Remove skb_shared_hwtstamps zero out
- Pass duty cycle for the pulse width

Changes in v4:
- Link to v3: https://lore.kernel.org/all/20250110031716.2120642-1-jiawenwu@trustnetic.com/
- Add tx_hwtstamp_errors to record errors of DMA mapping
- Remove flag bits clear for default case in setting TS mode
- Change to use seqlock_t hw_tc_lock
- Add ptp_schedule_worker in wx_ptp_reset()
- Remove perout index check
- Refactor the same code into a function

Changes in v3:
- Link to v2: https://lore.kernel.org/all/20250106084506.2042912-1-jiawenwu@trustnetic.com/
- Clean up messy patches
- Return delay value in wx_ptp_do_aux_work()
- Remove dev_warn()
- Implement ethtool get_ts_stats
- Support PTP_CLK_REQ_PEROUT instead of PTP_CLK_REQ_PPS
- Change to start polling Tx timestamp once descriptor done bit is set

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20250102103026.1982137-1-jiawenwu@trustnetic.com/
- Fix build warning
- Convert to .ndo_hwtstamp_get and .ndo_hwtstamp_set
- Remove needless timestamp flags
- Use .do_aux_work instead of driver service task
- Use the better error code
- Rename function wx_ptp_start_cyclecounter()
- Keep the register names consistent between comments and code

Jiawen Wu (4):
  net: wangxun: Add support for PTP clock
  net: wangxun: Support to get ts info
  net: wangxun: Implement do_aux_work of ptp_clock_info
  net: ngbe: Add support for 1PPS and TOD

 drivers/net/ethernet/wangxun/Kconfig          |    1 +
 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   53 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   52 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 1021 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  106 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |    2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   10 +
 17 files changed, 1333 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


