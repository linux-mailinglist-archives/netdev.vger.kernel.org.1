Return-Path: <netdev+bounces-54350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04128806B37
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80207B20D12
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8928E04;
	Wed,  6 Dec 2023 10:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF1FA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:02:23 -0800 (PST)
X-QQ-mid: bizesmtp87t1701856747tpid685g
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Dec 2023 17:58:25 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: EKa9/5zJOSj6576XiTxORmjAsBz5d6RuEwt3O464u9wK+VcJZEmLtyxz+0ckV
	HJSiRKayFteBO7V/g687K/4OEIJp9rizNK08Pd7f2/LH62VYAqieI+bvwAuRrI+HPtD6mcq
	+tLBxkfdsfmE17rFXamwkCw6UuFAtcy8vLRDhFDsPiyBydcj61oIBEFzT8GZqLyHf4MrZV2
	3xBNUaRHg6Y8gkG+T4mcuz3bzlSjvDaybjS5jjFsSMgT6ELkI40wgGOL2OWs2qSRnBLNX9b
	aoTrsVYkUpjXO/Iuc0TZ5TbuVlog2r9gcFJb/5W6q8MwZEPGRSwXLGMbfHTAUpyFOeRYCZ6
	4JutTccWe8JDqu3DuF3gl68BS0p/eg89vz04QYZ2Rk5CdPKNcV5j8zBQx7WZfp5wa1rMzkd
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17527314948320089809
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
Subject: [PATCH net-next v3 0/7] Implement more ethtool_ops for Wangxun
Date: Wed,  6 Dec 2023 17:53:48 +0800
Message-Id: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
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

v2 -> v3:
- Address comments:
  https://lore.kernel.org/all/ZW2loxTO6oKNYLew@shell.armlinux.org.uk/

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
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  94 +++++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  77 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  93 +++---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 126 ++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   7 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  77 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  62 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  57 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  15 +-
 16 files changed, 1136 insertions(+), 188 deletions(-)

-- 
2.27.0


