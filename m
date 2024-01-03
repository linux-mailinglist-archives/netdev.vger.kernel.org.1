Return-Path: <netdev+bounces-61094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7418226D3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 03:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650D91C21D07
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 02:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23256468C;
	Wed,  3 Jan 2024 02:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0C4A14
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp63t1704248078tdoex92n
Received: from wxdbg.localdomain.com ( [36.20.47.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jan 2024 10:14:22 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 7+I9kD+SDZuiubvK06GR9KS8kKplY6ksQkpQ4Vmzn0qS7eaOeqb9gnzRVPBYR
	L5tpfZQR8kuDPx9Ro/8mEVaoNgWymLT/FVDZZrn+fHBMMHmOiIjt5Dh+5cXBEkJ+471qjZ5
	sb096PqaRB2gZ/CmE21ShHSKEJJnCDi3eR6bVfi4S3ocheLpiKWBuMdowmQAn4J8OMU0HEh
	FpklizcEwn8sSm644mGMLIu7NSfFDvxSs6PF1gCzD6+dA50wuj8o0Ev++So+Qi2q3CrIQ0K
	LYJurY52oL3UXEtLskzNIievSUyUajjwcHlY+im0bUU02TrjE1TvpEjR3ZaCmzAD8yFndSF
	hmKpdcH8BY5Oi2SyzrpDtXsWAObEkgVREVyNllGyO7QlVT+ywHUC9OQUhBY5g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16524459282623691071
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
Subject: [PATCH net-next v7 0/8] Implement more ethtool_ops for Wangxun
Date: Wed,  3 Jan 2024 10:08:46 +0800
Message-Id: <20240103020854.1656604-1-jiawenwu@trustnetic.com>
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

v6 -> v7:
- Rebase on net-next.

v5 -> v6:
- Minor fixes address on Jakub Kicinski's comments.

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
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  82 +++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  85 +++---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 114 ++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   7 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  82 +++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  62 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  57 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  15 +-
 16 files changed, 1110 insertions(+), 185 deletions(-)

-- 
2.27.0


