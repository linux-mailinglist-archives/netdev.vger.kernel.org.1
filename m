Return-Path: <netdev+bounces-25223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD2773632
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6957C28163E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C337E;
	Tue,  8 Aug 2023 02:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AACA53
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:06:58 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFD2138
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:06:56 -0700 (PDT)
X-QQ-mid: bizesmtp73t1691460265tjcoc2ye
Received: from wxdbg.localdomain.com ( [115.195.149.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Aug 2023 10:04:00 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: C46Rb8GPIEdTPJ4ttKDJhyd2N8MxHYSpgUMdrbNV46SZATBhUoNCM/diEGOgE
	89phebOo6fImoR8j3mytDDHZ4ks3khuYlqZebv0ssJrNSQh3qjH2f6FX/8lfi3N4eIDHMPh
	PUAo5kpFNqWkm35Ws7koHylZVZayjCThA2xscW44oMS6MLVjAoe89oBdrf0nx/BXbVTKwgt
	HDqTlk78hofQwzG+cOgMSi5QAoIGRr8IYxGVP7fvDg/9x6+eDru4cswaKX1xfFNS8gwqwEJ
	P5go3N0St/yiaKTFkMdinwwVIp55EACqwoJrEb7W6J/CxSCiVVGF8TblPJb7FELuOhg+Tco
	qEi+tUYXacPZmUt0r5095yzlbUcV2g5xAt8CeN5i6JF1cW+RJA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10118867861635307495
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
Subject: [PATCH net-next v2 0/7] support more link mode for TXGBE
Date: Tue,  8 Aug 2023 10:17:01 +0800
Message-Id: <20230808021708.196160-1-jiawenwu@trustnetic.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are three new interface mode support for Wangxun 10Gb NICs:
1000BASE-X, SGMII and XAUI.

Specific configurations are added to XPCS. And external PHY attaching
is added for copper NICs. 

v1 -> v2:
- use the string "txgbe_pcs_mdio_bus" directly
- use dev_err() instead of pr_err()
- add device quirk flag
- add more macro definitions to explain PMA registers
- move txgbe_enable_sec_tx_path() to mac_finish()
- implement phylink for copper NICs

Jiawen Wu (7):
  net: pcs: xpcs: add specific vendor supoprt for Wangxun 10Gb NICs
  net: pcs: xpcs: support to switch mode for Wangxun NICs
  net: pcs: xpcs: add 1000BASE-X AN interrupt support
  net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
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
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  53 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 176 ++++++++++++++-
 drivers/net/pcs/Makefile                      |   2 +-
 drivers/net/pcs/pcs-xpcs-wx.c                 | 209 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  85 ++++++-
 drivers/net/pcs/pcs-xpcs.h                    |  16 ++
 include/linux/pcs/pcs-xpcs.h                  |   5 +
 14 files changed, 630 insertions(+), 92 deletions(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-wx.c

-- 
2.27.0


