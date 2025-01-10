Return-Path: <netdev+bounces-156945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8CA085B8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A303A9F36
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483B1E1C3A;
	Fri, 10 Jan 2025 02:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940051E0DF6
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477820; cv=none; b=m2TU6QlKSD/D/7INk8sKFiwRzK8RkQMFbyaS42gOfxUermnvSYQAfgLcQwnAhK9rPqHJA1zxg/+6rOvfNaoJOupzrwUkv97nlHA3j9Lws/bv44FQvdMvqjvEs5WVl9q9b/XkEXYTWutDWaGdqoxc3km6i7MpC/q3+ogGsjV73DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477820; c=relaxed/simple;
	bh=EqAXpSTba88t7/f4eE+0DY6Erk3S6gYtGNlxjWCgRNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GWXDibZH2WBYx/V2vGHj8cEO4nM2lWbuR6kBtqtYSZlyO4lHuEZ76Z/labR9L5zMVPH3omJUHMOfkWB5DQLpXCN2vcbSLPS5Q62E3nBxi0980+zTM6uYcPGXsILvgAmarvqRjcpFuYHiTDJPBwFjHjRADRbEjHmPTu6B7QE1IjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz4t1736477790tv3445s
X-QQ-Originating-IP: s7uppSCUMka7YVJGpFuwS6mmghL2M/BfDMjqssol4xc=
Received: from wxdbg.localdomain.com ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 10:56:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16333353045298240945
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
Subject: [PATCH net-next v3 0/4] Support PTP clock for Wangxun NICs
Date: Fri, 10 Jan 2025 11:17:12 +0800
Message-Id: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OfaQ+Y0DiXSPww0jL9eUKxznda9g6G2KbX/tK5zfwuvBkkhnWfatsrXI
	KG+jvQMnwn2yTmvXG3y2PyjWKj06oxyxXFLDn/ZKfeVwy1uR16Ipo640pIROcUepT4WKNku
	OIdGS2mNuVA7RTup9iHLp2kLBv6ZVjRZD2Z+smnM+9z6pBJrTPwGS5U9/LVxDPksEEu9dWZ
	E+EydlvDzCsDfOVPc/Vx8BgSiLkY6dE/ja9JBGSGNd9YGdMEnZNzx7YoguqYkzUCOA4lAyn
	t4byQW9nwTkOKSU5JtXhUFQDY7bGeLpyCNVOSsDj3ybWmYFXhYPUgQjIFy/rhFC4ZKxJIzz
	RlTf+AKgvZRm8gdFOzYcXNzOOlSO2VApS7nkTw/PvjULeJB8JXeiTUY9OVlMsFT+yHIY7Vp
	pE2gSGC17ydpj9aQ1U5kG++uOCWxp9BVkYVsrjiqT+fiK8Jv0O4ger2VTVAVnMds0EW+Ogv
	1GEX7pgz1+8+xA/yxZ+dqjU/t51S1Jk7wTOvUUjzXFcxw0BPzqjIDbS8jzUMl+C1DfYlwTA
	vL4BszrZ4MyDEmjimVGK0NIjZJkyY1366j/t2dhRaoWZjUwv45GodzUR+6/pr2vCbeZw7+R
	q8lj1QdtH9e9uh7+bdT4fvnsa97pq568Qlz38kRPAKroLoKHdkyfkKp6+ZTb9qO2zWrRX3B
	9tvtWo8uqgTwxLyoPPV8dBxUjqkBGip5yHDUEsUofPyB8L3kaqbkn4Hp1z0RYRlCBhwEZ+f
	0DykecaUK0CwlW41312aQR9qc11sLI39lGQj9ogYXYBJb3TZ3L97KIQeQt47h59FOW576iy
	vzJy2Uyg7HA/B9Uh90dH8+yBvKdHuIM0V2U0lgdBHpTr6C4rbcIxn2KnG4i6REbBrogR9r1
	Kh1enZpv4OLwnvCv8Mk4m2qIwMRlOz/uvMPC5ixz+CnyDMcEbfr0yaghKAwtFwd3MqGwG1Q
	x6POFuJUyuXzswwNCSd6+u05dU1KWY2QJt9XQr2S+hx1WbisdnJFWbJniS8wI/3xHQ/7H5I
	slDhEYMLxTmz6aL0bZ
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

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

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   52 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   51 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 1031 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  105 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |    2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   10 +
 16 files changed, 1339 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


