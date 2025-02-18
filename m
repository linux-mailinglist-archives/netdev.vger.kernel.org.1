Return-Path: <netdev+bounces-167169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC972A390A8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64703B2C87
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9C78F43;
	Tue, 18 Feb 2025 02:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B61BC41
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844587; cv=none; b=KqmslnKnmEqEbilxtDhGqV+a4GRB6Nn7Cb+qIwyHzfQ2P6qr//eA+c4d4gvEn0nUNjNDNx2RZgQjWTBZmVc1x0mrp151yyguwAHLhQzzyaEUsWSA4wqdpBZ6E3HqBlQ1t43qkNwu5d/RyvhyZa3IOuIE8ibKydkcXTZadmvaJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844587; c=relaxed/simple;
	bh=PwR26CIlZ/6RD0uMlR85PboCWoJshfw7sRsWZpbt9a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bDJIoNWjo4jrJ30VYMPtGCCs2+DJBNKmRyHVOo2TSE9QuuQwRyKcUHr8hLSIhTbVqcQozxGYlB934aWuBUKCMvzxLggWyyBbunAKwMcbFNLZdXo21Meu5OsyTj3KpEL8xwTEWarfcm9tGLVcReBX7iqhla8tZftlgeoTxr4KPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz5t1739844568t3gpk44
X-QQ-Originating-IP: K00LyHCpd6faOZWutc+rPx1VryhQGGKTqByQwdEFmbk=
Received: from wxdbg.localdomain.com ( [36.24.205.26])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 10:09:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4946844343877922781
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
Subject: [PATCH net-next v8 0/4] Support PTP clock for Wangxun NICs
Date: Tue, 18 Feb 2025 10:34:28 +0800
Message-Id: <20250218023432.146536-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OKhYnE1LzMsBy0oN1tOQOMlU1J4JPRNH/7kd/u45azG1nspKhbmUoMM5
	k2IEZNCinhx9Vx9PEzYOVdNDIID8nyDO2HRWSeBPCxJB5DsBmfa7jqqLkmaBVqmNemk850m
	FdomQgPWdXmXG3Nck9SlvCUlp9ONndh70UEzoZmNZyTJFvzqlwzr81BcQ91VgS5O/IMNFFy
	XGfhFXHPpK7Jqz2IMwkHLtoOqVA6aOb3Oqt9oYMrrI/0trIYV3+hmLaACeOp68QHBXVfrLv
	pSZCN4YMzZARATOk+xylT2ZMu1ZLSMdsrXWxnyJJ1xUzy3KnEecInZ4Yy8jEZqEGEqYm/4N
	ugmBVvZ0QYJBE/PVDquDUwMIrol5twBMqOTTOje31eU8GeoS3h/fY/jtjUTz1J4xZ7RiI3S
	Kw4qiIR9Wl0iUaNSrg/RKZs6jCaJX7Ufj9EpD0+64ooUQiQJfYkk+GoTDgGp8GD/tRsS55H
	HOGO2CYRthFqugFFHlOHWIth6A/WmXbmX1A/pB4D+ej64qOTJ8V6JW1I8CT0mLf4tPcgZus
	nIeRiLm7mQpMHDFtjLv0bPh9DCfBtHHdrJTgmqPSA9yutQ4XckCepuQx69ukn3iRsAcjVlM
	hzIhxWswDLe18gjL1XgjBf976QKvqfQE6pXXJOtGt4Y53t4BHQN6wa67kJPlTphIo2DucbD
	nooYXyITJD3KY5xOS0jYFbyU5nMqL7rXTDozMSTs/iPTL0kuKfaq1wlri+hs8N6EcYBccU+
	Ml6FatgdkKe0nf20OI09uW/JvtnqGD9wDy6ktg741j4RZhjtwgXcYoUZAZ2jQmBRPmcZ2af
	jckLp8+vuhUXCzRu5bk2Ls+Kqo5DU0MurZPqyFYuOvd4P7+sLq+wAKcKdqrdtdDkuShsSSy
	/wVq4G9bAS76sdldYT+DOTyiMB6+YJthpxbPIf5qiwMTXrwRO2gorBHT/cQL44WxT01N/aY
	Ih0ItFetKuEVduVs1mXvE3HxaaP82YVpQ/e/7UD6c78ehFdnDKNAsbHfq9MKakbOYVNY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

Changes in v8:
- Link to v7: https://lore.kernel.org/all/20250213083041.78917-1-jiawenwu@trustnetic.com/
- Fix warnings for kernel-doc check

Changes in v7:
- Link to v6: https://lore.kernel.org/all/20250208031348.4368-1-jiawenwu@trustnetic.com/
- Merge the task for checking TX timestamp into do_aux_work
- Add Intel copyright in wx_ptp.c

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
  net: wangxun: Add periodic checks for overflow and errors
  net: ngbe: Add support for 1PPS and TOD

 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  53 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  52 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 883 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 105 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  10 +
 17 files changed, 1194 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


