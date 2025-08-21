Return-Path: <netdev+bounces-215453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B4B2EB44
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8413D5E4D30
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55C24A06D;
	Thu, 21 Aug 2025 02:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC036CDF2
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743738; cv=none; b=k3IbPWpflUEo7yHY6SnxhJ+YRgqZ51/nld2qrgYyTL9/xeEflvmi7jGSsGRBBlwxEUzWksglEmj+PCOckXnKgQKRWHC8YuvERnMx1rG7NtY2H0I76v+x1oYIA4OtZqXmm7+nZmu1ws8VSQqAC/pw5/TYMa900s5FSo8qW4ly93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743738; c=relaxed/simple;
	bh=kRVV9ZOEFlcTJZOfuiXpOGsr/bIL0jdjn4+3nA/iGXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVzaaaLAlqMt8dPslNs5cH6P3cUO/Iq/jGTibmg7mU+4sTB4gNOcgqoJaWNqk5JusJstaNI25KgZM5rTVug64tMf+RbfdbxNHNemnU2Wvz2brHQQ2QdbA3yBX6puETUrcWArbMmLkPXae2e/fb3KikAc1TeEA0+jgxmXLT5vYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1755743666t18ca9711
X-QQ-Originating-IP: jDs2tQaF4QCePkX/OyRdWGkxk8btpmff2iccVkDirYo=
Received: from lap-jiawenwu.trustnetic.com ( [122.233.175.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:34:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4977194993655520926
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 0/4] net: wangxun: complete ethtool coalesce options
Date: Thu, 21 Aug 2025 10:34:04 +0800
Message-Id: <20250821023408.53472-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OSUW9vQLVhiZqIpdLkKP4l3ajiGrP86isMc2uxaCkpra8LuHWZLFJmUi
	cMIiUzcrvZ41uAT3NHd0nZ3sB7MHIO+JEe4eUyRPd/ArvypuXo4+9EvJImcfP49d4sUlfGb
	x5Vc21snDUxNs12AR3y/DSZVCDX6qUslaGPKwwOVGtxrQWsQSG5T9s003QtRBrF/SXrSnTe
	45I3qkVWXYR6GOYpq8UNVtWwHjqbaAwOAEXPYE2en/LwiWDgPGnd30b1U16qpC+Pi+Fy5K8
	FhMGz6MnMy4Sye9yfHkdVf3QHVxgf7A2gdgAhBVB2tWuuhjNj0qjU/xdtHKk1T08yAWTrzM
	lYEDSOTzVu78flv7nSb3RtCPNTJVKekqeqAatzIjYH0I8IJzA1J3KkG4219piUHIgFTciyh
	PlFnOWzwUNbU4BPllEuvIXio2FcTHpAAaKJ/W/YE2JrLd+fDlUxJx1qZCuzw3tMIe2p9NOA
	Jos2kPAcVzM0VSWtOFMH4kGtmR6DGP4pon5vWbFjpQVnDMqnADTXb6VFg7WOoUjJQDLC4cY
	DhTVnkhNXuleBTE7Y/zop1zEOM797Bk9u8NvvGX4D6GBrpeJ/285/+kkYfWlQTZyEcpC5X6
	8Mv5ecMGbxQ1QDQJHfcAgvPk8WtXdBm6z+vGQ89zkaxAgfqOvMQKiLZGog0VUGm8+lT0SEw
	0GYULNSocOMu28wfzRd204CodhGtzPgO70UFUSpcQmyw2RDJjtFHrabKzre1w+Qx2QynoPC
	u5M0JvctzmegyhEij+zFoouAajSaTzKtcgmNMdSCqzpjOxs36E1/+NRK2RU+Rw8m5Va3eFd
	Th5AIWIfvTFxTNWJoklM3//DEI7Fcedpn4f6ZLbLAL920uSMSGGJEMbKPX3NrlZ0GNAU5we
	B4G6NDO7H7rZ5L3VVoaUAU0Wrx07TTG6JOelpj6o8f7RUCFuWTxVMGaI7fwxeMLVrgT6864
	x7Zu2N4m3UNJlQJmlh6I2hKWLPxpEcornvhJbCkWaf0nEqnaJlVjQpTk5a0vnDu9RgIPTh5
	4XU5Gz6jtK5fRfs3v2w1bCSLMJ8zcOV60/FDqJjZHGYqClqeVxh9U41fsUOkmuD2FuhJgq9
	Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Support to use adaptive RX coalescing. Change the default RX coalesce
usecs and limit the range of parameters for various types of devices,
according to their hardware design.

---
v5:
- use disable_work_sync() to avoid racy work

v4: https://lore.kernel.org/all/20250812015023.12876-1-jiawenwu@trustnetic.com/
- split into 4 patches
- add performance test result for NGBE changes
- use U16_MAX instead of self-defined macro
- add adaptive-tx coalesce for DIM tx work

v3: https://lore.kernel.org/all/20250724080548.23912-1-jiawenwu@trustnetic.com/
- detail the commits messages
- support DIM algorithm

v2: https://lore.kernel.org/all/20250721080103.30964-1-jiawenwu@trustnetic.com/
- split into 3 patches
- add missing functions
- adjust the weird codes and comments

v1: https://lore.kernel.org/all/3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (4):
  net: ngbe: change the default ITR setting
  net: wangxun: limit tx_max_coalesced_frames_irq
  net: wangxun: cleanup the code in wx_set_coalesce()
  net: wangxun: support to use adaptive RX/TX coalescing

 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  55 ++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 103 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   5 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   6 +-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |   1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |   1 +
 12 files changed, 155 insertions(+), 27 deletions(-)

-- 
2.48.1


