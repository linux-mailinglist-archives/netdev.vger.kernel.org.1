Return-Path: <netdev+bounces-146467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388609D38DB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5665B28BD0
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB91A2541;
	Wed, 20 Nov 2024 10:56:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5A1A0715;
	Wed, 20 Nov 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100214; cv=none; b=kK6B9/f0EA/MNmsB8fLrmRT8wYhQ4zWaw6zVRWd2rF/e55CP/PXF/y04JFb/Toef/Es2LjgHzqwTAn+Aj72yRTw26VtQR8WMoLUetc/kjirW9lNR/j/avhYlFpjVNoImKAtZEvdRrIzkZzB+VNQMVuoQRQPLTqywK3mOttWm/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100214; c=relaxed/simple;
	bh=zyLEPwcrNI/SUqSQ8t+WZoAkPWPx0+dHSrV+zOjgPK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Sw3fxOtjmoMY5gAA5M2bicu1+eV0K6sTDXyPaQCVhaNlrjWo8cL4jIZyBxbtXsBtBb08SsLHTMOvgytdqoE/LQQsyVKwaMYwXVq7rBiUXHJqNqmD0qaLiA8O8DqgeaCYrvq8n9gcGHpLB+GJxKfP/5LyGAUzvh0SBoDAf12CELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppAb_1732100186 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:39 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 00/21] net:yt6801: Add Motorcomm yt6801 PCIe driver
Date: Wed, 20 Nov 2024 18:56:04 +0800
Message-Id: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series includes adding Motorcomm YT6801 Gigabit ethernet driver
and adding yt6801 ethernet driver entry in MAINTAINERS file.

YT6801 integrates a YT8531S phy.

v1 -> v2:
- Split this driver into multiple patches.
- Reorganize this driver code and remove redundant code
- Remove PHY handling code and use phylib.
- Remove writing ASPM config
- Use generic power management instead of pci_driver.suspend()/resume()
- Add Space before closing "*/"

Frank Sae (21):
  motorcomm:yt6801: Add support for a pci table in this module
  motorcomm:yt6801: Implement pci_driver shutdown
  motorcomm:yt6801: Implement the fxgmac_drv_probe function
  motorcomm:yt6801: Implement the .ndo_open function
  motorcomm:yt6801: Implement the fxgmac_start function
  motorcomm:yt6801: Implement the poll functions
  motorcomm:yt6801: Implement the fxgmac_init function
  motorcomm:yt6801: Implement the fxgmac_read_mac_addr function
  motorcomm:yt6801: Implement some hw_ops function
  motorcomm:yt6801: Implement .ndo_start_xmit function
  motorcomm:yt6801: Implement some net_device_ops function
  motorcomm:yt6801: Implement .ndo_tx_timeout and .ndo_change_mtu
    functions
  motorcomm:yt6801: Implement some ethtool_ops function
  motorcomm:yt6801: Implement the WOL function of ethtool_ops
  motorcomm:yt6801: Implement pci_driver suspend and resume
  motorcomm:yt6801: Add a Makefile in the motorcomm folder
  motorcomm:yt6801: Update the Makefile and Kconfig in the motorcomm
  motorcomm:yt6801: Update the Makefile and Kconfig in the ethernet
  ethernet: Update the index.rst in the ethernet documentation folder
  motorcomm:yt6801: Add a yt6801.rst in the ethernet documentation
    folder
  MAINTAINERS：Add the motorcomm ethernet driver entry

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/motorcomm/yt6801.rst             |   20 +
 MAINTAINERS                                   |    8 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/motorcomm/Kconfig        |   27 +
 drivers/net/ethernet/motorcomm/Makefile       |    6 +
 .../net/ethernet/motorcomm/yt6801/Makefile    |    9 +
 .../net/ethernet/motorcomm/yt6801/yt6801.h    |  617 +++
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   |  638 ++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |   39 +
 .../motorcomm/yt6801/yt6801_ethtool.c         |  907 +++++
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 3383 +++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 2908 ++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.h    |   32 +
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  191 +
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 1398 +++++++
 17 files changed, 10186 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
 create mode 100644 drivers/net/ethernet/motorcomm/Kconfig
 create mode 100644 drivers/net/ethernet/motorcomm/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

-- 
2.34.1


