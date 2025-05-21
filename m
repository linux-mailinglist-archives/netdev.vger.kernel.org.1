Return-Path: <netdev+bounces-192173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8AABEC5E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CD81BA6B5C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95A323C50D;
	Wed, 21 May 2025 06:46:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B32356B1
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809966; cv=none; b=szG16bbp9Nweh2tqBvmK4V+uzW0mV4kSPb8MVV9inSgrcjHok5Lb8Uoe8X7P5nHgMnqZMb85nOnvkBBGdZ8RH5LZ3YZxR8WEhwzqDox0XuDkaneoset+iCI8OnIKny75laP0SurctRnFnqoEBrmTUk402AGIBRAup2Yd3J7qAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809966; c=relaxed/simple;
	bh=1DtyOeOJxn9qwMb/WXDD+4QtFFGf+1WvXJ8adx3Le0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sbzh4FisVjXEVovdn3NAbCI65dFMTwBX7UZin8grJ/Lq+8YkG3c5PZQwqd0J0Diy4Rshq1gO6B6CpqUCMhEjIM3OFRRJ+MN0IcPF4baHPDl26qPfuopGScFEms3pcAIKDWqPS4WjFy2Z3vBq0uNJ4ygbQ2qBI4sJAsaGr2Ha7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809879t4a97a986
X-QQ-Originating-IP: mu2GgQsmPn8veE8KqfKzbY8t6EM+ruW7YbcF8+L2KG0=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5836517550751018965
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 7/9] net: txgbe: Restrict the use of mismatched FW versions
Date: Wed, 21 May 2025 14:44:00 +0800
Message-ID: <18283F17BE0FA335+20250521064402.22348-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NhvpCzAv3WKAE8HPVwiOaC7VjEaoIm/BuHtzGwilQNWn7JKIh17h/AJZ
	7T8d6KeGdqgsnw0CRSZeCg+E6T57OAHpVjaVsKgZK+UosqPmjBuvg/GJpU8UA4WK6OMXMcC
	yRWU6cYO41O0c9NchaKogxBAsLW/1BgwUKwAg7teSpOsCAPfhl+EWPg+v9WHlpV/2Vi+Kpi
	EN8VJDIwD7Tk9utheFd41XwKVVcxqr/zvrZAo4lqDlzxSZe8VAm+xIx5fLFFQTipyRuvf28
	iN1gX7QcN08seT3YQfJLA3ig81gCZE2O4MuCjCsuZVD9SeRkFHqUEf66VjAHNV/N2L/9PAH
	b+0GNfDTCn+PfnbWFZ195sB4BVwhFWjU/cibxEeRd6lGqghnvVs7rmSC7DQvdBn8+p/YDf/
	hlzpsdPFpLC2dk1HtrJ0Az44UES4lGux9XRU8XM1cdt0fXSGP1GE79dqPz89FZmSaQ34RYf
	5pCq3MSVg2awqfsB1RaTEk24Q11dAr6HJGwoOn39GqVROQ33eFPGzXdgVVqrFcHF324CgZ6
	oZ8USb20mPIjOJ7id329540lcFrwj42IDv1Yvg2W4L4Ef4xMTxhGX468oqDGnOJnWbNsVQ7
	LuXOO8F4CVM923tvtahzU7kDjX7sCGAm8wN+RcKsIE9lPUKVWvMReDphBhQ9tI6PJnzPo99
	PhO+LhsYiYZjm7bSDHoyAqlEfsDryAnHrLrvRRGeEnvUCRpyZdtKPijZbgbZM5aPRdopAb0
	ok2PII9pg/3jt5vB4k7ZTU1Kv1vdVQVEl0laybkk7zgvUqF9pKpNwDEnOTu3pVucllq9OPz
	80km074P1crqBsaV4IsxxpQ82bj+zvDVfW8JFGaJ7avurlyID82d6++SOMhjElBzqhdgNUq
	JxldTXeZnVb34RuwNyxKUiO/KXZp496U+j+09T63+CxVZM/kizdJAbpQZfvhpsNobgl10yb
	9nx1bNhRtEGsLPDD7EkLxLZIp3NhVyvFgv8D/w6piE8M6VtZ7BwkMj3NpogkNHKSxFOxMkg
	fmV50kpqPnjbxaiFSDIqCDTix7cQZRKfTeIxUYSDAUueqtjZbcQLJQCEO4F+U=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

The new added mailbox commands require a new released firmware version.
Otherwise, a lot of logs "Unknown FW command" would be printed. And the
devices may not work properly. So add the test command in the probe
function.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  | 16 ++++++++++++++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h  |  1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c |  7 +++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index af12ebb89c71..83b383021790 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -50,6 +50,22 @@ irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+int txgbe_test_hostif(struct wx *wx)
+{
+	struct txgbe_hic_ephy_getlink buffer;
+
+	if (wx->mac.type != wx_mac_aml)
+		return 0;
+
+	buffer.hdr.cmd = FW_PHY_GET_LINK_CMD;
+	buffer.hdr.buf_len = sizeof(struct txgbe_hic_ephy_getlink) -
+			     sizeof(struct wx_hic_hdr);
+	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+
+	return wx_host_interface_command(wx, (u32 *)&buffer, sizeof(buffer),
+					WX_HI_COMMAND_TIMEOUT, true);
+}
+
 static int txgbe_identify_sfp_hostif(struct wx *wx, struct txgbe_hic_i2c_read *buffer)
 {
 	buffer->hdr.cmd = FW_READ_SFP_INFO_CMD;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
index 2376a021ba8d..25d4971ca0d9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
@@ -6,6 +6,7 @@
 
 void txgbe_gpio_init_aml(struct wx *wx);
 irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data);
+int txgbe_test_hostif(struct wx *wx);
 int txgbe_set_phy_link(struct wx *wx);
 int txgbe_identify_sfp(struct wx *wx);
 void txgbe_setup_link(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6f3b67def51a..f3d2778b8e35 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -864,6 +864,13 @@ static int txgbe_probe(struct pci_dev *pdev,
 	if (etrack_id < 0x20010)
 		dev_warn(&pdev->dev, "Please upgrade the firmware to 0x20010 or above.\n");
 
+	err = txgbe_test_hostif(wx);
+	if (err != 0) {
+		dev_err(&pdev->dev, "Mismatched Firmware version\n");
+		err = -EIO;
+		goto err_release_hw;
+	}
+
 	txgbe = devm_kzalloc(&pdev->dev, sizeof(*txgbe), GFP_KERNEL);
 	if (!txgbe) {
 		err = -ENOMEM;
-- 
2.48.1


