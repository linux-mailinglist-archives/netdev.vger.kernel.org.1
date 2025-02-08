Return-Path: <netdev+bounces-164273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2776A2D33A
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1753ACA45
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31588148FE6;
	Sat,  8 Feb 2025 02:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AEC14F90
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738982916; cv=none; b=uFCq31UIEjeq55RyNWdpFADZwXZvxi5ulaexc+c1LkCdKy66DKRBia+OzhlLL3q48xDKmN9ytqSQpkjgdisDoKcbD/EBjItnkKMfARdow7tXIu30VkBaZ8oSEka5fyX6V4n1SJwIJ99uYaz239DgXzE3eJhDZ4nH2CyO46pEtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738982916; c=relaxed/simple;
	bh=CuO4sMLRNu0w4gzwmF3nm1w7ffx/KnIN9Sxf30Dn6mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnmXdFrx59zDVTog4Qxpnm7NUTo9C8bTqQlj4ykb2yhLlVjYfHcvGF/QJUg9Snc/f4Z3yWGyZOGueSl09WT17ybTfcgXhNJSTQOUPKhqep/6Fx2CNR3qv0O96WHxqc9tkqMwqFhNSsA2K7hpIiCVcrqhjXneOqrumxHz4AK3cbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz12t1738982901t4ke91
X-QQ-Originating-IP: Dl4imzVFAdr2bFmJcE8EfjR3gYXl7npXy+rorH4LAyg=
Received: from wxdbg.localdomain.com ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 08 Feb 2025 10:48:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16339831384622441020
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
Date: Sat,  8 Feb 2025 11:13:44 +0800
Message-Id: <20250208031348.4368-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OatzRg8pHEjphw6SIo2fEHG21FzFspAZdKhIE3v03d1+gTgjFCOb4Pmy
	xjyjbWl7mYK3qZXiK+Prf1ZEGMelQ9jUgHIg0XRjcZcImeAHhnp/dLOjqLCJQE5q+M44LNl
	HqfMB9o5wSXbl0ttz8MDp6uDHR0W7Cnx2cWBAnB4hYK3VU2Wk5vP3ZBPQdwrpUySAes89N/
	WWkE9o7eLYBHXqQLc+QRqpExi0yLWPSRdD94i1mvH6w+fzZsQMqYCTfLp3kuZTt2NU8ZVyv
	+C9gO3bMf2vaSXPBFouL+QubQyFeD9lcY524aWSfr7Eqjn1MgTc5zJJQSXW6oi3Rjdeyp8N
	KSt0BOmNmAkgpj1iVMvMIpWGgD6QMqHKvhQoYmTlrOHEVKzPA3MjoLoA1gp+8ajo9k70kZe
	+W66SMMlrtONWG5irk8E8xLT6l3KtHbl5nTJfSiFa9Shz30DvgnZJP6tii5YXLSVIl3Ftlm
	8LR+YEtJ6RXvEscGXMzhsNbjS8X/SWCde8990TIroxQ2tePdkp7vwS7s9LB3yM7j6QCRdVO
	+z6NcmDeGlwgKilb/xleIobTBWN/36WMHiuGUx3Ta9L9n062iyl01f4XcLA451/uTu+FYrw
	vjhZ3hqdOGbTyQajsFc68U5m/3EOkU3f6/c9AdRuRzR88UUizee8kSP5NbO8S7t+nxhzaNu
	PGrFFx7DdBdwPTaU31IB4uZ6NY17Ml2u5QFPFBaN97e4gdr/yhVP8Uyrz7DEvD1yUBt4+x9
	shai24abLzE11FRBEScByuVW2WDx458Ok5m7Ct13YL3O94QzfStyQuWp1yk5vbNQyzPTgl4
	No1DDQ1s595j3k7HE/xZ+WvFo4cPcbpM1jD1pPiktL4hRWSt5dQImXMtxuX9BZqmrfBr/yn
	sFy3o3mQ8OyFEv7xbWj0jk35MVXYpxOtHA0/wq+wOwMyormrJfHQSpKM4aaDGzKA/00QKc5
	6OpVctCJsnEQhGs8EAYGQX3e0QYuMX2pLrmG8gWO6hEdrbw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


