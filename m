Return-Path: <netdev+bounces-113168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03A93D0C8
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABA9282378
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D1173332;
	Fri, 26 Jul 2024 10:03:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D57176AB8
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988212; cv=none; b=hyNfn49GzX5cQPnYJmig3pO7Hr/hLUifUGLSJcWQ26C7Ut+tUxwpb/tBWVwZx04nWtUsHURBUGFg3dxVoAcBQKLash6kBAz1Zi8ee5xzl9jSYbsNquxQaLKTQVZ68BWmtSX5CKu3T8H3xCZA8CsWC6ztgQSvk5LTK28RDhL4QBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988212; c=relaxed/simple;
	bh=WUCC/VLycP20xTCzjnM5OIlwYCb3oWUo9ZH5I6Ckpn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4O8R8vOSdgr9lYuBlWbGh8ZE/G6aTvhhrRJeOk1PYSQ1UFLd/wjvV6LwMBob62Isg+KpyKJLm1crM0vzrn54P5fYaGjxWOB7anXtFJsOdriy5tpmunz4ykCelOT5K+NQ5sXL+Up8XWfXQFTfjirCsvMWSVIdtHu8f5UvnK1vkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1721988198t062qli3
X-QQ-Originating-IP: 8inRHOsWC+RaGI0vnyEUU4Fa+gZIx7gnHAvPdvvqZZE=
Received: from localhost.localdomain ( [122.231.252.211])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jul 2024 18:03:05 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6920932137853016775
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RFC PATCH net-next v5 00/10] add sriov support for wangxun NICs
Date: Fri, 26 Jul 2024 18:02:51 +0800
Message-ID: <F168CB0E42CFF012+20240726100301.21416-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
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
2.43.2


