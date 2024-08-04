Return-Path: <netdev+bounces-115531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E867E946EBB
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C811C20E6F
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EF03A29F;
	Sun,  4 Aug 2024 12:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A81DFF0
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775754; cv=none; b=g95g/ZI80RuEuCodhzf81+r+g8Q8vx4E/QFVAlETU7pB4WcJCYR8lucGYaFBpiLIn1HscH6xr8bFkjVoJMwCq1G++tYgNaytz9PlHzWALaAqEnx/khHt8aQCXR13TnI9O2QYxgdOTN4tton4k3+74iFUo0YVl36d4vYBVSrk/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775754; c=relaxed/simple;
	bh=cd+ITROtoO5U44RHQFFR4YDzLcpLhjGI7Gs8fuL00O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdCaZOTSBiedHTd2peW4BXoAb8H+0rU2KlvLatCk2WKU36cfY8YJ/Cd/TnL21retY1LrTw5kO83xpzPNNs3DH1zORWKbj0QYenss5nCP8H3k8hJm0xECfc+Tchjh1eo7GiIXMpN1DzBIUIM1ueEN645w4bUNMwN5zZiira02L8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1722775733t9nbkq2z
X-QQ-Originating-IP: UmT4PSnoKq3TdvKU+7y6RGzDvK4/cEJtjmCXR2lO69Y=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Aug 2024 20:48:44 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4121438544856459877
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 00/10] add sriov support for wangxun NICs
Date: Sun,  4 Aug 2024 20:48:31 +0800
Message-ID: <598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Add sriov_configure for ngbe and txgbe drivers.
Reallocate queue and irq resources when sriov is enabled.
Add wx_msg_task in interrupts handler, which is used to process the
configuration sent by vfs.
Add ping_vf for wx_pf to tell vfs about pf link change.
Make devlink allocation function generic to use it for PF and for VF.
Add PF/VF devlink port creation. It will be used to set/get VFs.

v5:
- Add devlink allocation which will be used to add uAPI.
- Remove unused EXPORT_SYMBOL.
- Unify some functions return styles in patch 1 and patch 4.
- Make the code line less than 80 columns.
v4:
https://lore.kernel.org/netdev/3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com/
- Move wx_ping_vf to patch 6.
- Modify return section format in Kernel docs.
v3:
https://lore.kernel.org/netdev/587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com/
- Do not accept any new implementations of the old SR-IOV API.
- So remove ndo_vf_xxx in these patches. Switch mode ops will be added
- in vf driver which will be submitted later.
v2:
https://lore.kernel.org/netdev/EF19E603F7CCA7B9+20240403092714.3027-1-mengyuanlou@net-swift.com/
- Fix some used uninitialised.
- Use poll + yield with delay instead of busy poll of 10 times in
 mbx_lock obtain.
- Split msg_task and flow into separate patches.
v1:
https://lore.kernel.org/netdev/DA3033FE3CCBBB84+20240307095755.7130-1-mengyuanlou@net-swift.com/

Mengyuan Lou (10):
  net: libwx: Add malibox api for wangxun pf drivers
  net: libwx: Add sriov api for wangxun nics
  net: libwx: Redesign flow when sriov is enabled
  net: libwx: Add msg task func
  net: ngbe: add sriov function support
  net: txgbe: add sriov function support
  net: libwx: allocate devlink for devlink port
  net: libwx: add eswitch switch api for devlink ops
  net: txgbe: add devlink and devlink port created
  net: ngbe: add devlink and devlink port created

 drivers/net/ethernet/wangxun/libwx/Makefile   |   3 +-
 .../net/ethernet/wangxun/libwx/wx_devlink.c   | 211 ++++
 .../net/ethernet/wangxun/libwx/wx_devlink.h   |  13 +
 .../net/ethernet/wangxun/libwx/wx_eswitch.c   |  53 +
 .../net/ethernet/wangxun/libwx/wx_eswitch.h   |  13 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 301 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 128 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 175 ++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  86 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 966 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  15 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 111 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  73 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  21 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  41 +-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   8 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   4 +-
 20 files changed, 2208 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_devlink.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_devlink.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_eswitch.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

-- 
2.45.2


