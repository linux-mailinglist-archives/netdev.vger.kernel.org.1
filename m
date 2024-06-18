Return-Path: <netdev+bounces-104448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B990C91D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78B41F21841
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5B1386DD;
	Tue, 18 Jun 2024 10:17:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90477104
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705874; cv=none; b=Am0zYdYyIXeXLyAymVJfv2dY6n/iVb/EdIOXYkHI97wG6QELTwsUfmx7D8Ni2+sUjx0C53ZnIhzcTp2cl1zwRjHQ9UVUf1oVl1lzZwW+ibfUo4MS6S2QbxxwTfV7lMW10+Q7DBKmE2sBVJZP3kREQlP/TZt2dSyCBPIfA+6Tg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705874; c=relaxed/simple;
	bh=utcvrYsa6+Oxw4NEtLGU3yHRVBflsT53oPb8YA8qUso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jaThmMW52VuXTHrabv4wB3wVHyq12E4cKV3JhFNg8UX72HCWGLR9K9WFtvQJYDTesr1Dsu4SGQZX33upKfbN02ZlLe88Eo6v9VqUK0nQxy+GSHI6D425BvcJrjlUlkUbqY17me+HMWqYKbRETdOH1vPAan25sDfBEIbNCNN6Er0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz9t1718705776tdh05l5
X-QQ-Originating-IP: d+QOTMhYJRyW1F32Pd4TFcDAdXPNOlL4it2Hx602vvI=
Received: from lap-jiawenwu.trustnetic.com ( [183.159.97.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jun 2024 18:16:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6648041797492083366
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	dumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/3] add flow director for txgbe
Date: Tue, 18 Jun 2024 18:16:06 +0800
Message-Id: <20240618101609.3580-1-jiawenwu@trustnetic.com>
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

v2 -> v3: https://lore.kernel.org/all/20240605020852.24144-1-jiawenwu@trustnetic.com/
- Wrap the code at 80 chars where possible. (Jakub Kicinski)
- Add function description address on kernel-doc. (Jakub Kicinski)
- Correct return code. (Simon Horman)
- Remove redundant size check. (Hariprasad Kelam)

v1 -> v2: https://lore.kernel.org/all/20240529093821.27108-1-jiawenwu@trustnetic.com/
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
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 427 ++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 643 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.h   |  20 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  18 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 147 ++++
 12 files changed, 1436 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h

-- 
2.27.0


