Return-Path: <netdev+bounces-29879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F978505D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509B31C20959
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815A1FDD;
	Wed, 23 Aug 2023 06:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C91FA5
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:09:40 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407AE5A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:09:18 -0700 (PDT)
X-QQ-mid: bizesmtp73t1692770833tghq1j2y
Received: from wxdbg.localdomain.com ( [60.177.96.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Aug 2023 14:06:56 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: cbck7jzG4wYQsGzU9W0ao7F2vBm1BeqOf3LuAW07Zyj8nH0fxCrZnvdUTQSPY
	6qoMIwsyLbDO9sWCS7nU+gs493bl1CZNpdtM6KzEtwXhgU2AaV5Sl4EmT50wVZecBsdaull
	DWYFqd9DnoHU//HbQyYyE9Ej8USF4yG6oyNmFz5frj14IvBLPKM6E9FRpOzzCs79eZ+dGXG
	KorUyYPnPZ/UdkUgQhc83N98JGRsRR7SjEZoQikbh1iBjiiBrBb5Cniqy6mgOmZTh/z6e7Z
	qj77UQSgl1YDYFN4aqXCsRnMw9CU3dwNsfyrIT4h/31uH+fgh6TJvQV4IO73D4FfpcsTDCp
	XthmkB+6tkoIE4iGo1UbZV31ciGxiiyVAppN+H+wHWDdmKZfFs=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10256503357037688191
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/8] support more link mode for TXGBE
Date: Wed, 23 Aug 2023 14:19:27 +0800
Message-Id: <20230823061935.415804-1-jiawenwu@trustnetic.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are three new interface mode support for Wangxun 10Gb NICs:
1000BASE-X, SGMII and XAUI.

Specific configurations are added to XPCS. And external PHY attaching
is added for copper NICs. 

v2 -> v3:
- add device identifier read
- restrict pcs soft reset
- add firmware version warning

v1 -> v2:
- use the string "txgbe_pcs_mdio_bus" directly
- use dev_err() instead of pr_err()
- add device quirk flag
- add more macro definitions to explain PMA registers
- move txgbe_enable_sec_tx_path() to mac_finish()
- implement phylink for copper NICs

Jiawen Wu (8):
  net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
  net: pcs: xpcs: support to switch mode for Wangxun NICs
  net: pcs: xpcs: add 1000BASE-X AN interrupt support
  net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
  net: txgbe: add FW version warning
  net: txgbe: support switching mode to 1000BASE-X and SGMII
  net: txgbe: support copper NIC with external PHY
  net: ngbe: move mdio access registers to libwx

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  28 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  84 +++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 --
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  41 +++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  56 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 176 ++++++++++++++-
 drivers/net/pcs/Makefile                      |   2 +-
 drivers/net/pcs/pcs-xpcs-wx.c                 | 209 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    | 112 +++++++++-
 drivers/net/pcs/pcs-xpcs.h                    |  17 ++
 include/linux/pcs/pcs-xpcs.h                  |   8 +
 14 files changed, 661 insertions(+), 95 deletions(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-wx.c

-- 
2.27.0


