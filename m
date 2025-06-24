Return-Path: <netdev+bounces-200540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E2AE600D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8181923224
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9B26B740;
	Tue, 24 Jun 2025 08:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A688279DB6
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755471; cv=none; b=VTBoU9G553tNflJpBHCfIXTODuVeeLiXx6D46X7Z0RwfDZQrkhoBvgXtm6k/Qu00/gP08rXjOPDTzRuWYW5QH9Gur+CCkNCVFS47YxCSQjHY0s+VvvmUP5YuASIlnEK030I/3g9wlY8vMHwg9Sama7hnEqaee6+gGS6kU6+oovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755471; c=relaxed/simple;
	bh=whZwd1ug++fzv/f8EezWE/GZXbmnpkbADveBVzYkBNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgc6DSYTDNUmMMHVQ+xXnqUkcv/H11tHHBsgVPNZp9hKvegtcM7mBSz2KR9mxVRHZAMTMRxneS9EqScqwSGbvHxF5FxTiJ3LgIefH4QfD70TvG5einjfao0/1snod8hg/P7z4hoDeiRljbxrdHP2L1bj/VZCXfYZaZjSgxMLN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1750755409tc9f2810a
X-QQ-Originating-IP: FVfKwVUZZSrpb4FMK7btAjq7t2uPgApApRm8nbhq1m8=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 16:56:46 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 954785789516711474
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/3] Fix IRQ vectors
Date: Tue, 24 Jun 2025 16:56:31 +0800
Message-Id: <20250624085634.14372-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MWWUiSUszY9eNdHhzMO4u06tXMKzDTBCDqipyXjAhORqQyII260YFf7D
	54HZXr86QLagHbc68TQpGwqrb6Sr1lvQ7L4qlkwrM1ktWoTxqZoe+BYUPLrqKA/XCDlKeWk
	zPS55jH/mg7uXKfODT4BfTi+szguiILSJLr+Kuc0XHOpsP734KdvFpOiGJk0V9eP1+2LIG7
	R2uIrsWpcy92dvAt8kTMGon8erZhJbMitAd0F47cUrshErv4oUGEB37jFQwLx+YPtK/WYJE
	deNVCr22Bw6OqRE2C4C95v11t+XDbI+I5QrjXI+Z9ST1r580I5rTOEGWjuoSlTmINQbzUmk
	iWWD7JC25zJWqSM9xi1mSKOPN5g5aIYAwj01DfNSm+Nib8ESsfJtVOHNAEvGNESafGS/Bo/
	rcbk1TOvZLhGZpRHfvFF1dwZ2mu7M7KdpByYLhU7YrnVmBOoXlkl3CqAx9OhpHEM1uTlntd
	96dD5933LfJQ5S9WggJMLIxeTqhzMcUoPJjOTrtumnys8dW2CIGRZJdFsLefsFyI6hRfCMa
	49ep/fFLKsmGorl/+wGfNEeX0s5na19UhgTjDAQ/X0jPBBzwYZOeyb86N3sarCzcDeb3ipE
	Yx4IBNKY/zKr+YtclnyYS/oU8xaU0FcVkcxVJrdh97MAXQsouUROAkxlMkmTH6LKv9RoRTY
	w3z2Omagf8wDhxHBTBp8hWHhmrIzbQcmLNM94QNXh+/5VEpSqoGwIWNCpP5FSYaOZS2XV1R
	QJK/vRM9S8lu64cUCI0SSD3KiX//lPGr7Qpagq1ZfU/gLwR6BcPRkX91Iq/LX9N8KUmAlRq
	x+dDrYVppp3CaPpMKV0PFtDOkMo7SGzbABIBdTE6QL0KPtCauDbkdrMXlcX4m1CNvHmTI7l
	hIm8MYyibCiA5vnEFILI6lUMUKQ/vZ0oJRPEg02Nr4cpZ8DDvhHubYKScUck+ZUaeFfyBjV
	8BrAfQJdxteE8HHYGFlGuWAT/qlU7A4/z6HdSee4qZM4SGFQHSEg9zm81iwQ6usXfA5gXvC
	5ax5TjcLGiv7H+CiFq7IbuDhfKLYeavje/+utAm9ncdbxh5fwI3E8yLiYQabApEEqCt0FI2
	1HMWaS09/uT
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

The interrupt vector order was adjusted by [1]commit 937d46ecc5f9 ("net:
wangxun: add ethtool_ops for channel number") in Linux-6.8. Because at
that time, the MISC interrupt acts as the parent interrupt in the GPIO
IRQ chip. When the number of Rx/Tx ring changes, the last MISC
interrupt must be reallocated. Then the GPIO interrupt controller would
be corrupted. So the initial plan was to adjust the sequence of the
interrupt vectors, let MISC interrupt to be the first one and do not
free it.

Later, irq_domain was introduced in [2]commit aefd013624a1 ("net: txgbe:
use irq_domain for interrupt controller") to avoid this problem.
However, the vector sequence adjustment was not reverted. So there is
still one problem that has been left unresolved.

Due to hardware limitations of NGBE, queue IRQs can only be requested
on vector 0 to 7. When the number of queues is set to the maximum 8,
the PCI IRQ vectors are allocated from 0 to 8. The vector 0 is used by
MISC interrupt, and althrough the vector 8 is used by queue interrupt,
it is unable to receive packets. This will cause some packets to be
dropped when RSS is enabled and they are assigned to queue 8.

This patch set fix the above problems.

[1] https://git.kernel.org/netdev/net-next/c/937d46ecc5f9
[2] https://git.kernel.org/netdev/net-next/c/aefd013624a1

v1 -> v2:
- add a patch to fix the issue for ngbe sriov

Jiawen Wu (3):
  net: txgbe: request MISC IRQ in ndo_open
  net: wangxun: revert the adjustment of the IRQ vector sequence
  net: ngbe: specify IRQ vector when the number of VFs is 7

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 26 ++++++++++++-------
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  4 +++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  3 ++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  4 +--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  8 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 +++++++---------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 +--
 8 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.48.1


