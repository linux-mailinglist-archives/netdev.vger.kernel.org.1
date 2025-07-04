Return-Path: <netdev+bounces-204119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69264AF8F31
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB23B0257
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47112EAD11;
	Fri,  4 Jul 2025 09:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C62EE26C
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622725; cv=none; b=k2TcpfqATSuZrCuFdDjZvwg14VRQkNZAPDlbqoz/Tg0EdqFYVLZqqJukRfQ7P/fTfSPORk2Q4XCbScUIiPak/73TPQcbb+XZCkc2+5Kj8/Ne+hYmPaVhUDubyd9zcVw6Qi5j/7QbFKv5KD6glMSbaRxPH11nxG2o6doIA7TjYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622725; c=relaxed/simple;
	bh=9qRKtS+WzjJTTD5QyW//CKZLR7hIfdP81RGgzB4fmR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Sd7a0wKzZKoOabTXM+9fP/rZiDUHfmhz+d4xiiaXDLZKb+nOI5i4T05G4+q7iwIUVDGvjKsLuYej/PC53WoP9050tXfEh6LVAIqlhF2KAkfjVlpMNpjczrrUw+aQCfv52sSc/nZ2tlEQDYwTtAQ2esWnV6OvG/tKcmFGIrJ9PGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622576t21922ff0
X-QQ-Originating-IP: zcwyq5q+SrG6D5EFtj4Mgx4KPcCl6ncCbaVmnBi8FC4=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:49:28 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5266758040471983885
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 00/12] Add vf drivers for wangxun virtual functions
Date: Fri,  4 Jul 2025 17:49:11 +0800
Message-Id: <20250704094923.652-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NYxG6qQjWKuU0ParIIbODkBY396YXIfiZH5IMh+ynXugEJqShHEzd7XF
	36VD9K0nwlLE6NpJl0ibzGFKwxMXY6KLtTBQn/sHhDmiFVV57x0xpYe4q1MAnZ6Ddg6br7o
	xft7BY2BKVDuIxD7CIXo9fD11wrEBstlwZkQA9XdU90nuFHdFKhbV0FqHqQZNm6sNoBUh69
	6KFb8EJ+IKUkSdvDGoSmQOHYypYmLfcqMMfkcVlsubUkwotsCo5LdFoiZu0iqOk0OnMG2lq
	bsssfWmxNNE5OwEmQCoH9ZFeqlytBZ9xCg3F+mpSuW7Ca23Uio2/Z2Dgq8LD+GiaMXE0vuf
	qIysPPI4EExE7+gZF7z2Dt3Tn9OEr5sG1/YSZ4denLvBTf3vNSW0wQ8vk/7c8Xs0ZndPv/s
	53wiKG7+gRB5K6EqTzQN+iX+QHx892B9cvUs97pPFj25KQ9qXTQBVR7N3zl62Rd+Jd1spkn
	dhpeV0PmeIu/7tV5Yrt7cVhcSCuj/nxDReKyegiCHkb27YPs3hvTc7ZejreXlUTsf2XdUGj
	7FFnhKFhay3+IKZQaGxUqI1Mu86lpUrfXNWwZ4iydZSM0+VDY86dbUm2aj6CLIGEcteI8Wr
	rqG4nM9hhfeWxNmwzLAy5EzrnJa8E3payzDvDS8XIA9mRq+KIxj7A3VDrL0O6r97eIy74mF
	vFWsT1/i/krceO851FgrFpFPJCQ6Cx8XLKej3EHRDHGWFuQ6PiTmjz25icnVhhzVQCbOBUc
	q6L4AmDU1SuuigsiEKa0w1MWEWhWIz66/O8ckd9bJImy1+qK/m7x2eX0JUENUMLe8t1C8DY
	KlwqqqssKX1P6lLzkEvnqt1b3gaCHPznDMqU1HuPXcMw2c5oC6TfJQe1VL1UhRLj+8qwBsD
	6I0o1BqGTtESZzUCiQqNZwajU8qkjNgTCZ3sBfhpAdqn6ps1W7H3LoPXQcbMkCMU8hiJnud
	yA9foDJbGCdgYeu2lPmoMkwExCGWuUFHT0Fe337sqNm3/qc4wzabL6O9Zrndu2v6yf1k5aL
	yLbpLGoUhPquhwaI83mCraNwqM+eIP6Pm9ceqREksklves2doenXhRh9RtS5Io0HZD/Kw5d
	H17cfO4d4pes+XAcTTZLfR+iNoULTjwUbzgJV/gGqCJcUHvhLBBgIfeiO0P8MRCcmfD1gBo
	EM+WDJAWYa2s1v+UAU0VNbG6Ub+PHAP1QhE8
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Introduces basic support for Wangxun’s virtual function (VF) network
drivers, specifically txgbevf and ngbevf. These drivers provide SR-IOV
VF functionality for Wangxun 10/25/40G network devices.
The first three patches add common APIs for Wangxun VF drivers, including
mailbox communication and shared initialization logic.These abstractions
are placed in libwx to reduce duplication across VF drivers.
Patches 4–8 introduce the txgbevf driver, including:
PCI device initialization, Hardware reset, Interrupt setup, Rx/Tx datapath
implementation and link status changeing flow.
Patches 9–12 implement the ngbevf driver, mirroring the functionality
added in txgbevf.

v3:
- Remove phylink and add watchdog subtask to check mac link status.
- Add reset subtask to do reset when receive pf reset done msg.
v2: https://lore.kernel.org/netdev/20250625102058.19898-1-mengyuanlou@net-swift.com/
- Fix the compilation issues.
- Standardize the return format of the vf base API in patch2
- Use read_poll_timeout replace vf_bit_check in patch1.
v1: https://lore.kernel.org/netdev/20250611083559.14175-1-mengyuanlou@net-swift.com/

Mengyuan Lou (12):
  net: libwx: add mailbox api for wangxun vf drivers
  net: libwx: add base vf api for vf drivers
  net: libwx: add wangxun vf common api
  net: wangxun: add txgbevf build
  net: txgbevf: add sw init pci info and reset hardware
  net: txgbevf: init interrupts and request irqs
  net: txgbevf: Support Rx and Tx process path
  net: txgbevf: add link update flow
  net: wangxun: add ngbevf build
  net: ngbevf: add sw init pci info and reset hardware
  net: ngbevf: init interrupts and request irqs
  net: ngbevf: add link update flow

 .../device_drivers/ethernet/index.rst         |   2 +
 .../ethernet/wangxun/ngbevf.rst               |  16 +
 .../ethernet/wangxun/txgbevf.rst              |  16 +
 drivers/net/ethernet/wangxun/Kconfig          |  33 +
 drivers/net/ethernet/wangxun/Makefile         |   2 +
 drivers/net/ethernet/wangxun/libwx/Makefile   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  14 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c   | 243 +++++++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  22 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  11 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c    | 599 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    | 127 ++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 414 ++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  22 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 280 ++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |  14 +
 drivers/net/ethernet/wangxun/ngbevf/Makefile  |   9 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 261 ++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h |  29 +
 drivers/net/ethernet/wangxun/txgbevf/Makefile |   9 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 314 +++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  26 +
 24 files changed, 2470 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h

-- 
2.30.1


