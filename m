Return-Path: <netdev+bounces-158022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F91A101F2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2263A8FB5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A4524634B;
	Tue, 14 Jan 2025 08:24:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB18243331
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843055; cv=none; b=JtAlMVB92MS1E5XfyyRdzo3l0cKdtI53CLqyCErzn6h/aqLnywD2CadHBj24/Rzqgc0hu7EAJ4myy+F29TH2py6Lw41d6WsFg6W3GCT3I6J8yRgpZZI0FBVGMYM5cotgeGbkFqHdrxPmTJTVAdfuf1KnzQV/B4YS19/TqTvqQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843055; c=relaxed/simple;
	bh=EOaxBxJJrVZot+BMD1AEAf/1OU1WMWf4ogwrcVb1Y84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fe/tYmfiorsf9K0AZ20w+eTId7I7oXCrdvQo3XfEQp7+nnWgf92tWtFDwUWVedxkrjU/pmhXDVxBoO+fNXitzTK+HotLQZl3XJ6U0GSuPBRQod/zb7hO5fI6q71tjvsQ7ZnY8/BjxzDf6TgAVuv42dldwakVTw6cLzU56uScFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz9t1736843032tgoms4p
X-QQ-Originating-IP: 2CuDdiTO5kr/Af+JqEyg7sUCbujK1X3eS30zjMIZ0OI=
Received: from wxdbg.localdomain.com ( [36.20.58.48])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 16:23:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8323603096353909375
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
Subject: [PATCH net-next v4 0/4] Support PTP clock for Wangxun NICs
Date: Tue, 14 Jan 2025 16:44:21 +0800
Message-Id: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M5znx2hx04lb4s7vlRDlLXd1+9za6m3rFgEAHaswizpbr0kY+Vdw8neR
	40+mprDfFBHk6/36RRwCkwoDcglo0qycINleJwngywIHowfOcj+kKSU8rBlLqmNrpC1di0k
	MY0J+obaLbHdKMCjvL4E7KSj4RsjRTKofNrOUn+GWz59D566gjNYyh10VwjDIZd+H6bL2wn
	MxBi/m6UKvz/sk/UteNcEmgQaSp74X/0Lmp15risayU9ZmLgfgbK8+7jr0rjtUJNX8n9zrZ
	cORxgfPDBhMVP+YRvpYwgBoEE1/XTSSoIX6wGhFjosZv3of1ZX4U0ULQ9MQiiduKSfKsI4s
	Pc9fnIq1wtBmBCdJtS/6jr8HmY6KwYvjke6wuV2mUoHR1+FWMFsxiTloNh0hC245Jaqq8vn
	/ij5TEOzD7GLi/V+5IEyhR3cLNSZPPethjPw6foPhRPZ7zTON8muxkQT/GkOf1MC9WvjFR2
	u3r5S+W7krurVCuIz8S/+e00Axz9r6Y4Fns2szP+QudOGonc7sjJSsaEC/p0wTXq1ooGaRy
	MVNG6VLtQ7c7AYUdM/AXDt/cAvr/K9w9/1/MZR/6A2TIQLmtlvMF6JGPLXht9gTxQfTrDEo
	YOasT0uUdIOUyslCHE5N70YPsS0N9KOLxOgUfZ8laI72CTQbpd9EcxqPwFIwmBZxcsVNKvX
	ENEvnB0Ywje1XZahQa9TcLrEd7J+gh9dyFLbzXoVZp9mdtc+CppIRJt69j+jtPu/dMAM415
	itN713PtwB7QVxukGpIVAYlZsfybPwwNVXh+kL66fhS1yD86G0pXKoys+uLXSoPpTDTNQMD
	LIiPbCuc1Zq+jyVnfXU/P9kk0CXHEcyHgdCHPABXMCXQR8UB5YctZtVtz1t9yjyc6sf35M/
	x5S7FcVYe/X6nTRMNoTSyeY7AbcuSCphwG4SI6s1sXSdHT5X6plDOLLZ/wmVzJ239qWfd3+
	mqRI+buJ4twSCSbeT3yK4VYCrcGNFFQ8iUQK8vUdBBXiyrY2S/ZdwRNV2fOrx1cyCxgg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

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

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  53 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  52 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 994 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 106 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  10 +
 16 files changed, 1305 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


