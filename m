Return-Path: <netdev+bounces-218984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EFB3F2A8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 05:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BF4484F34
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D22DECA5;
	Tue,  2 Sep 2025 03:25:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75A2853E2
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756783559; cv=none; b=OFCo3FVlDTfanEWS/w7r7UsaW8WG63u4jqV8yZWNBYxgiGLmO1EqxlTD3bQMLVFJY9EE8dCpur5nd4g0DypfYw4U0OYpPQDBxzcmxpPE9AbZAnOR3YEXYXF8bJ4LluLHWatuK74OdaVrVeHCdc2t0BrNNaNAjXpLwAh/7ieRsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756783559; c=relaxed/simple;
	bh=44vd6kk8nGf5TzMMpre0czvBAj4F2H60fBd+7xlfjjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pamu+Y8aoTUdL4tdbqfqzjFbfesEKeuRWrOfMPZvRqmaZwsd//69rKXsTqZHJnytSE2laGue0J0v3SPa218P2nq3Tp1H7UfhM/R3xeBFybMQjKV05CexqWsR3eR828bNsSIu1xtBTgHHdv24XLGvSeKsRsQjJG1MkcmKi7INsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1756783450t0b2791b7
X-QQ-Originating-IP: 3EovV9lr3nucfhPHuEDPjySRxKLHT3Za+Icht/IMlOs=
Received: from lap-jiawenwu.trustnetic.com ( [115.227.135.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Sep 2025 11:24:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3328409408913337717
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/2] net: wangxun: support to configure RSS
Date: Tue,  2 Sep 2025 11:23:57 +0800
Message-Id: <20250902032359.9768-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MJCg9QO2iP47nNGmkEnyID+YpkGS8rcgSZQ9SIjLX78Vf01gFAwHyA3j
	6CpkGAtZ4lDkTGDo3XnwEx2oy237MKxxvlYmwJhV0ca/tlN5j+Gw5AiGfCaofblH/W019BZ
	KV7oJaVlVKtLb3wdHb/H+vqpzdBKFvSY1C6mBCLWr4W6pDoZYhLQng4zSTc9i9ZxVx1sCcM
	JIIKjZTQ3L4oEejlBN0oMDjEUVxiOLG5YNoKf4TiEcuvEgw5q+4Hy6KwzFWJdcDOV4U8ikn
	A+qkZGPWmvvmsJ+EQaCwUUirOhNcYSW0XTBgZs0qv+0YPwqGLP1OFxOCjj/LkYkkoIuBLoj
	+mtnGjd0h4scCDqiki1GOnIkPOmEmUFsPMgCuDPzyPXYVHq3Cp3lCb07WeWiPJLGfQn8fVg
	2UhnU81Poq9D5rCmuY0fzTauKFmpsjdP8rEtK71jbrb0iMUlSDbXyiDlZ2RDNL+otkbL37s
	soz9y0kAgBqs7pu4njshBgcRapCA+RzeLbmQS255wubV+RMHwB31YVyKHBsbTAFCRuM3N/e
	lKaVLR8Me2rsVqbkbvIST7wGybO8qPPePNjXcqWWyqIgvTTNE8MHKXeFD+DTEJvhaGrNgob
	Opk2TmkPFT3TqtJ58HGq05FlbOkdaHw+Y6QlUv9ZrNy7zncWGeuHVWVxfDPUY8x4OYFxuul
	h96r/EcU93UH0ydF3cn2q7glpQ+d7loE7HVq0LQRMEDj/7oxl7HtII9rfOM5CH26GbmXIQi
	IwHpKRLBuxB1nuLaV3v+NqPK7ChE1rqiZnQ2DfRRhIPd2RFd+bz8AxOBiqcz9kzhOiOSXyy
	2Gqer/gAA88xGQx0gXb9GenYoRC1/s7lex7CmPqUMs7uvOUq741mhkg2jGnhXjexKnAMY05
	/WX1GwfJw02sUcPeerma1HZ+lWomff0R/6sXqQ7MaHXgrisl9OZfRzDcl8cwusT/74XeJOq
	dPnkX/52fO8o1TrXmzWxmpaXR8P8QgL7xwT9zFJY32DFCzJ8pDtPnDY1GR1lXZ7pW91HBR2
	XcOmKpnr8GYoUStdRLtdMAJzlXnLpHB+2UjySgSNzupGusVD+A6G27fccaJ6++Luai8V4KP
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Implement ethtool ops for RSS configuration, and support multiple RSS
for multiple pools.

---
v3:
- remove the redundant check of .set_rxfh
- add a dependance of the new fix patch

v2: https://lore.kernel.org/all/20250829091752.24436-1-jiawenwu@trustnetic.com/
- embed iterator declarations inside the loop declarations
- replace int with u32 for the number of queues
- add space before '}'
- replace the offset with FIELD_PREP()

v1: https://lore.kernel.org/all/20250827064634.18436-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (2):
  net: libwx: support multiple RSS for every pool
  net: wangxun: add RSS reta and rxfh fields support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 136 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 111 ++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 8 files changed, 278 insertions(+), 31 deletions(-)

-- 
2.48.1


