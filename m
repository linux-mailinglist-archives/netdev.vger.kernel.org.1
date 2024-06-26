Return-Path: <netdev+bounces-106753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C110917888
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DB0B21919
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B514D29B;
	Wed, 26 Jun 2024 06:08:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05A14D28F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382116; cv=none; b=dgfVP/CQRp9tmlmsxo6gW4q2X6VPdNuBF9X7H2wcflxM/ylRCPZA1pH9viaVab8UWSJONQEZPAvAE4oe1Z/cSFXz/v61F2P1ktRy18egUNhAox/66UmfCv51cE6xJsfUsthI9C4NKVG37kyv7cRHj66F8LScF5DSwUrLAhiFYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382116; c=relaxed/simple;
	bh=Fq7/OUef+ZJHXJf8zC44cxCgg0D5SR541aqpDZmjk2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rKWaSLPBWY03iqUWbUBuIc0FnxIxo30sEAJAEeCgKmvI8NQcWRAGM43Fq1pXKPvv26OR7OkraMbjyZtKNEbFXWXZPPljOy6pX8/t8pDlANv97TNRuwIz2qbCEszzQio3gM4ytAipCiaSKW26Ca/8+LG4CwF1LtI9lg19Je+BQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1719382030toi8vmn7
X-QQ-Originating-IP: PJpckioFo2WOPURKSHqRODw+uXhrj+fTw/4dsXyLhm8=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jun 2024 14:07:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 664126805949557273
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/2] net: txgbe: fix MSI and INTx interrupts
Date: Wed, 26 Jun 2024 14:07:01 +0800
Message-Id: <20240626060703.31652-1-jiawenwu@trustnetic.com>
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

Fix MSI and INTx interrupts for txgbe driver.

changes in v2:
- Split into two commits.
- Detail commit description.

v1: https://lore.kernel.org/all/20240621080951.14368-1-jiawenwu@trustnetic.com

Jiawen Wu (2):
  net: txgbe: remove separate irq request for MSI and INTx
  net/txgbe: add extra handle for MSI/INTx into thread irq handle

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  13 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 122 +++++++-----------
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   3 +-
 4 files changed, 59 insertions(+), 81 deletions(-)

-- 
2.27.0


