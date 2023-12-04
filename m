Return-Path: <netdev+bounces-53418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DD802E77
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8849B1F203F8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64500168BC;
	Mon,  4 Dec 2023 09:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0DC3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:25:05 -0800 (PST)
X-QQ-mid: bizesmtp89t1701681820t87juxp4
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 17:23:31 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: mA5V8Pu2WCHHIdKaFSV17jjvrB8/JYycbxWOF8vs6B9uom7o6vmDJXSWJX984
	/vx8FdrHTcrcwxktPzYhAAd9e9gnKtY2p7q4vmJYat0DJx4d4+0+pNTeGbNyyOBopNHlnFy
	QmEcxx1Frc5sLNSBNUoOxHjW3aJMQJ+6vX9WXFFdyg06IGP7LrzEV5QupqdH6r77ks+P1I+
	mdasQQvqQsyTDko6wzzQRTAl5LPtLKcb/beT7BRjXLhxjz9neZ8rLi2FGkfSuoJr/UwTqK9
	qaQeCSFleDtZWlqevKGUc1D8VwsDc5NySYxe7I9o8rJdmrB1D4RuCF0vLdq5mOUquiPZ/5o
	Oq8VeY1pFKOrs+d3zUEByLtqs89aCD4pnp7dSOpzUJZ5UCElXI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9152533148110777110
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
Subject: [PATCH net-next v2 0/7] Implement more ethtool_ops for Wangxun
Date: Mon,  4 Dec 2023 17:18:58 +0800
Message-Id: <20231204091905.1186255-1-jiawenwu@trustnetic.com>
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

v1 -> v2:
- Add phylink support for ngbe.
- Fix issue on interrupts when queue number is changed.
- Add more marco defines.
- Fix return codes.

Jiawen Wu (7):
  net: ngbe: implement phylink to handle PHY device
  net: wangxun: unified phylink implementation in libwx
  net: wangxun: add flow control support
  net: wangxun: add ethtool_ops for ring parameters
  net: wangxun: add coalesce options support
  net: wangxun: add ethtool_ops for channel number
  net: wangxun: add ethtool_ops for msglevel

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 245 ++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  27 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 275 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 164 +++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  87 +++++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  77 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  94 +++---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 129 ++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   7 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  77 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  62 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  41 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  10 +-
 15 files changed, 1126 insertions(+), 172 deletions(-)

-- 
2.27.0


