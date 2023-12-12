Return-Path: <netdev+bounces-56268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635080E58D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AB1F21502
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112101803C;
	Tue, 12 Dec 2023 08:11:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D1C2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:10:58 -0800 (PST)
X-QQ-mid: bizesmtp74t1702368571tw7opfny
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 16:09:22 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: EKa9/5zJOSijiSH9vcaF52ebMg1F7DNp7S+0MmttLVtX8Ea+feAUfZIVf5q6o
	n0qgX0NFm+7CMgh5t100wam4Cl6UsuI9AyjOb5VEYotBXPVu3XLkYh/wAPzMNG/clPXgs8J
	yAtHXFP0px32HhUyNQ2iESgk53e46c/BoJoyMViBepthjFjwVMSBjHEZzOEzk7sfWavlS3M
	4ulFAvfdYXJA376lavM1zqDAZcL1lBBxfy5ZHyImTB8ybQQYNnGQQ/W8c5Jqkzj2gcWP32O
	aFgPQaQU81zpssJP3rfLOGq2heVNhgdLC1exSAryiopc2UJlSwBynlIVlTMK1NW12F4DWpd
	jE7c7MUSlhaAibFjTXDNMBP+LwkkpMcdxs0V3u1NHjjmKvbAY37m9EdaBOuLArFvtNnNDcW
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 604578862222143399
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
Subject: [PATCH net-next v4 0/8] Implement more ethtool_ops for Wangxun
Date: Tue, 12 Dec 2023 16:04:30 +0800
Message-Id: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
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


