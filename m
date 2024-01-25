Return-Path: <netdev+bounces-65761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061383B986
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40EFB2342D
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42910A17;
	Thu, 25 Jan 2024 06:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D210A13
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163853; cv=none; b=mrNJGYKMQkIDJ4ZotM2Ual1bK979IP/EMHznCXm+OGwwZpkUDL4ZKcPkTqirHGdNOtcs+X08qJTMxXXcZOAqB+OeaZj86IgWbybRfzISen+8DepKKMD6MIY3gKEr4u/XuiX5itC7983t9TY58JD79tyIupfWeXycyFumlwZw2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163853; c=relaxed/simple;
	bh=Nyj5UgR7Nx0ZLJKQqLuVrZntFhrLRfDn8Y41L3h5t24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSZUiU9/Z2hExYf+EcM5lRG1+kNq15gC3vcToZKK866Q0LJdoRbfXeIkZklNRVQvSrFsHRx0Jgu+Q12VvECafxEGb2dUFy9lCNJVXVjUBUBLfP9rB5+zRgG+xf6Uxe2GLbUeXWKpD8y2ql8KDWBRCWcozJAvZsj+BvViUIyWut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp66t1706163758trv91ozk
X-QQ-Originating-IP: B3yYYqmbJIuVLjU9ObVeEi1j545rkI+g56PSEATP6Bw=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.185.81])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jan 2024 14:22:35 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: DViCT0MMEKxkBBWqrRTvGwAS6jfyBlVYeqHc8fedR0njdmKaVwKfO8ZjBZVsY
	62GA3a9b3eHGUz4Oo0nCxvWQD29+pobfnkJFGlmjFgaCS9PPupogj5hMxOlZ5UW9tKD4Q94
	m8ChBDNSfNvphbAye9X4Sl5J/ZA0ziLre3lJWPNf17STZZAAVDHtJ+PJdg1uiaDvBSWP7Gq
	4N5YVx43IYgMmBwTV6M1hidvkEZKN555s9p5YShhpNXoxIw8XbpQpXDc++ZNg6mrqyrzMB4
	29VSiu7Cit8o6OnLVGptTRfbKg+21IJj4PQqU0k70Lwi6ScAbITzH/kPM6WYn3Mijus4awW
	JaeLJ9cwBu1Pf+QG2kx2AKhp2DB4BLoZPxNH66wAgzjGiiIYWdLBrO+GgDJuw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16536650653552973329
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
Subject: [PATCH net-next v4 0/2] Implement irq_domain for TXGBE
Date: Thu, 25 Jan 2024 14:22:11 +0800
Message-Id: <20240125062213.28248-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Implement irq_domain for the MAC interrupt and handle the sub-irqs.

v3 -> v4:
- fix build error

v2 -> v3:
- use macro defines instead of magic number

v1 -> v2:
- move interrupt codes to txgbe_irq.c
- add txgbe-link-irq to msic irq domain
- remove functions that are not needed

Jiawen Wu (2):
  net: txgbe: move interrupt codes to a separate file
  net: txgbe: use irq_domain for interrupt controller

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   2 -
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 -
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 269 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 140 +--------
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  59 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  17 ++
 10 files changed, 337 insertions(+), 181 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h

-- 
2.27.0


