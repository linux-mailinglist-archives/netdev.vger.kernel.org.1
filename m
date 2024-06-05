Return-Path: <netdev+bounces-100802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17828FC188
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C678B21043
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48AF38DD6;
	Wed,  5 Jun 2024 02:11:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E928379
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553471; cv=none; b=QCNmuR2+p3tlC3gUIeyamWrfQ/S+ZfaBvlPVkVnEoZnMFFNLFlZeDTyoTdSz8EXsyn9NhMZ5RQXElA+FrErDP7TZEbmwhtQQKHcYx+7hSppQ4CpHqGGHem3PodiWWj/sZwoSTIvQneWSDZFWA7M/29nCwlMuyoTF2foufb3NEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553471; c=relaxed/simple;
	bh=l8YzjwIzvMN6UODSsOjN+1f7H8KjHYEabshbj2jtzPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LgpS5d33Suy3+7Xvf2yjLVeXwu85pBzd9wOqjTxldSHE3x+h8Sg24odC0MY+P5KxXHvoQCmQo0SuPVl6NBr1HIB3qhJyZMD/N8W3nv/PeiRu41GP53TSm96zeF7Fh3kqQyEFK8dAwd16tdcKilfGi7lKGQYRYFMPppJhgUqAwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz3t1717553340txnhsrz
X-QQ-Originating-IP: MfAZP2Bm1IT5Z4WU/DQbksU4z0serl0ehWv+fhiVDYU=
Received: from lap-jiawenwu.trustnetic.com ( [183.159.169.220])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Jun 2024 10:08:58 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: DTGyLHq2j5ksNxXlv9xF+35K23w2aqzlSHTRYQBw5+c/cQy0/K/5PBliUgXyl
	InVh5FEh8pczFTy6KvKGOngDZdEEGw+LQXc9SHIXTNBARdAYEWC1k8tu+JTg3xuyr4+W88l
	CQAm8tKAR1WVAWRHVtLn2Ibb34ha43WhmEhAMad3RZqxuvCPga3XIiqCMegxqOQ87S7cMdk
	FrXJBGnbraDOO6z3PbEdt3MEvWhtZIvBx4PV0joLdUakUsC/6pFWHWPiP/tthcNZWsWBZQt
	cbq6lRORFTwuPPtNLruN3QWJbpDtTcQSPWnM+h3msKYzFJk4auzuAsB3LOlFHqxDpzZtRJZ
	Kihbm8c6ZIP4M3+hjpUoPjMol9bw+NYaoYZ66I2E5Z+VYWFTPXEFY9wGfL6KQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3779691845357915179
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/3] add flow director for txgbe
Date: Wed,  5 Jun 2024 10:08:49 +0800
Message-Id: <20240605020852.24144-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Add flow director support for Wangxun 10Gb NICs.

v1 -> v2:
- Fix build warnings reported by kernel test robot.

Jiawen Wu (3):
  net: txgbe: add FDIR ATR support
  net: txgbe: support Flow Director perfect filters
  net: txgbe: add FDIR info to ethtool ops

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  39 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  32 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  62 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  56 +-
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 417 ++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 631 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.h   |  18 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  18 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 147 ++++
 12 files changed, 1413 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h

-- 
2.27.0


