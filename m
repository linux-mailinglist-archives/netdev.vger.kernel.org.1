Return-Path: <netdev+bounces-108009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0AD91D8BB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DED281009
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4E82D69;
	Mon,  1 Jul 2024 07:15:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755E80639
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818134; cv=none; b=rHzKRjTwI5WX3E0+AvdagPiIz5Rw5fenPEiTOoYuoM1iAoh7soJ6mpCeMzs2AsA5jJlrCZMF2jsgrCMKBHi1yEV3vjr75gD/znvvHCx04CUirPMiR8vHQMxEmoPI+Z7pR6j9eyqiWq/QKW2R5B7S005JMDDBNYx+y4MVRNXAv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818134; c=relaxed/simple;
	bh=ieACa6hAHe2b6KI2wg3N4ifs6ECNuOmUqULMSakTsKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aKhzb8Ch5fsjBXr3yDYuS6kgoF0jU6dGC+w+REC/dZu6xjJakZYaPpz3IjKF3/ORGmVmDFRyKWejoEjdq4WBdl6KTqt9xQiM44LXeDOsk5OrHClhEKN40C5PS4H5YubpSySn3c95noVrgLbdQvqW2wYrWt1BA1zzlIH610gMz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1719818064tajm14zg
X-QQ-Originating-IP: IMNkOB3Mj+hPJlNyZUkGy6Fr3t2ihIP8Y/y0cRxCjR4=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jul 2024 15:14:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14088595341707731606
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
Subject: [PATCH net v3 0/4] net: txgbe: fix MSI and INTx interrupts
Date: Mon,  1 Jul 2024 15:14:12 +0800
Message-Id: <20240701071416.8468-1-jiawenwu@trustnetic.com>
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

changes in v3:
- Add flag wx->misc_irq_domain.
- Separate commits.
- Detail null-defer events.

changes in v2: https://lore.kernel.org/all/20240626060703.31652-1-jiawenwu@trustnetic.com
- Split into two commits.
- Detail commit description.

v1: https://lore.kernel.org/all/20240621080951.14368-1-jiawenwu@trustnetic.com

Jiawen Wu (4):
  net: txgbe: initialize num_q_vectors for MSI/INTx interrupts
  net: txgbe: remove separate irq request for MSI and INTx
  net: txgbe: add extra handle for MSI/INTx into thread irq handle
  net: txgbe: free isb resources at the right time

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 124 +++++++-----------
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   9 +-
 7 files changed, 64 insertions(+), 85 deletions(-)

-- 
2.27.0


