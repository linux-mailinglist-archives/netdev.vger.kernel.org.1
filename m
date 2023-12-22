Return-Path: <netdev+bounces-59874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719781C80F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599021C24FDB
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269B12E7B;
	Fri, 22 Dec 2023 10:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392C125BE
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1703240512t7vdrf0d
Received: from wxdbg.localdomain.com ( [125.119.246.92])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Dec 2023 18:21:42 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3i6xiiU4p2dD+B75Kdammuixt83iA86vTE2bEh9E20pXBTvvM5dd
	zNJBAVTOXIKv6cH3LMYGnRmd+igstdZnTTX7uH93PaqCDArfLS9qIBmMegLeNmZC69VIppC
	AgHxpt/oRBikiCbXdR+1jQz/9q/j4lwvXrQ+aKkTf0GHMSSY/WX8WqZxhZxULvrNA27lXiZ
	h2WGc+fOOtmLzIYzKKFNkE0jVvSFqOAq6PgIeb14zCPeVRNsjUkv0FhA1yezEBKN9Dcmab8
	TE6KdnXdqUiElndNH9sBs15jm/edobfMVhO+V7u06qkM4JUgsi4VbWdhsLDhcORlo0Zy0NT
	OsuZJPH32K2DsW7+rAXMNqq+Lp3LimBHYQ4o+xl/6ePllMHPlbCMbJGes+QSA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11629371763147510632
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
Subject: [PATCH net-next v6 0/8] Implement more ethtool_ops for Wangxun
Date: Fri, 22 Dec 2023 18:16:31 +0800
Message-Id: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
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


