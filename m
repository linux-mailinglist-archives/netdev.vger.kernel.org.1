Return-Path: <netdev+bounces-57207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8ED8125AD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8AB21550
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8AE111D;
	Thu, 14 Dec 2023 03:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94974D0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:01:29 -0800 (PST)
X-QQ-mid: bizesmtp68t1702522791tea6u6a4
Received: from wxdbg.localdomain.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Dec 2023 10:59:42 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 3VVObL39cqRzGAXzz2NX1Exs/k3O4VONGNf38bpLrq04TDIwLajcPUAC8Xj78
	oVPAsCz1KiNVqaIOSOoiw/6ETYY30ouiq081ubHsAk7znfpoO9jSwH720Z52CKQLfZGVNTm
	FwmNFtqZFt96ZvTd/LNwrAQlAnmZZyUeMa16s03vt0HeQ9Jplbt/Y7LWbQbn/UJbpfja7vu
	GXyZa1HCcFL4KBBt/9LGdXNRHKBdXNJpEeVdTcHjKWsnkkoFbf7cGVRqLYMMww2zVwnpVrr
	7xzvSU/Apiia9ZnV73WpMLrMOjJ0F9lD/i7UlBZm2PZ+s7sGM9sDc6KeKkBdH9st/U8NlzU
	PFAaHo5AQ8rf0xmkibEfDf5fygv/qKtlJwWZMN5kq4j4Fj0SzgAzzw4KmtiHA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14762305343442767752
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 0/8] Implement more ethtool_ops for Wangxun
Date: Thu, 14 Dec 2023 10:54:48 +0800
Message-Id: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Provide ethtool functions to operate pause param, ring param, coalesce
channel number and msglevel, for driver txgbe/ngbe.

v4 -> v5:
- Fix build error reported by kernel test robot.

v3 -> v4:
- Repartition the patches of phylink.
- Handle failure to allocate memory while changing ring parameters.
- Minor fixes about formatting.

v2 -> v3:
- Address comments:
  https://lore.kernel.org/all/ZW2loxTO6oKNYLew@shell.armlinux.org.uk/

v1 -> v2:
- Add phylink support for ngbe.
- Fix issue on interrupts when queue number is changed.
- Add more marco defines.
- Fix return codes.

Jiawen Wu (8):
  net: libwx: add phylink to libwx
  net: txgbe: use phylink bits added in libwx
  net: ngbe: convert phylib to phylink
  net: wangxun: add flow control support
  net: wangxun: add ethtool_ops for ring parameters
  net: wangxun: add coalesce options support
  net: wangxun: add ethtool_ops for channel number
  net: wangxun: add ethtool_ops for msglevel

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 236 +++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  27 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 275 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 154 ++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  94 +++++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  85 +++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  85 +++---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 114 ++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   7 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  85 +++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  62 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  57 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  15 +-
 16 files changed, 1116 insertions(+), 185 deletions(-)

-- 
2.27.0


