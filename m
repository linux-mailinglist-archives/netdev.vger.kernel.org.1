Return-Path: <netdev+bounces-190975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F089AB98F5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CF37B7FA3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C46232365;
	Fri, 16 May 2025 09:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED622230BE9
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388057; cv=none; b=OmqEVDI5Jvix7gt4csb780rr+iYLof2ARHla/o8cuHjx9y0Z95gU5KLdZNdY+B6/pGg1NAu+z78foHehKJoeIM898GnDuOufCWgAaIJKF6PokXF/2Vh/LI0k0g3wI9E74SqM8NDPo2bSqW44V0tL34vroSsCohal7TDG6FX8zck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388057; c=relaxed/simple;
	bh=sOlP9omh66g0xJ1133H6F4TBFZahmeyBYna30iOBxIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orHPJqpnyvUQP6rpzj4q4aXMczX21KeYUBsfDMMkF7fvkq0UqsJJLvoAMGIqCkbrdrWMrMtIk3c25CME/5nkbzeQ/X/BBzPtvXZk3JcvbuEbvTqUyJcCvQ2lh6P73tcBQxegzQAZQ/lBILxhUrJ06x7d4xaQVvxXRFo0ClT41So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387975te6618c23
X-QQ-Originating-IP: L3eWvFYan026Bgwx5IPaX7DOkx0nr3LVLcI66FsSHrk=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:54 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 727843897797265350
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 7/9] net: txgbe: Restrict the use of mismatched FW versions
Date: Fri, 16 May 2025 17:32:18 +0800
Message-ID: <ED7ACBFDFF6405A7+20250516093220.6044-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NcOoHQsD5eyELZ5L4X+hE8peAfsqMC/P0wsumJiVmkXXrKf1ZfphP4pN
	nzgvINY3Fva1ISByO4mDV3QC3hlZEYKFTEdE2um/f9kjW/iD2abb1tQ9tORLZR3TJXKGsuD
	gWvCxTlXlrVDXE6+UZ+bDJxIMGL6h6dJRT2mKDOLcWu94w8Op56ZST1wbj9mGyW+Qo7Eu0A
	eyZeMfY/lOTWzwEfHdc23RmQ9HNJ1s2ni5DQm/75rZonBrR8m4Ueaq52/G95hStAFdV3fyB
	ZvBAWUEGqWC730oLqeU2h8Jo8l3NXE40/hME9XkQ3bsS2vRss7pD7TisAHsACy/F8JVsJvk
	TkdiecCBSf8XGaxDzQblrWQBf/9TSWDQayHPamyDVhstrnJ2GA7X8MiuOS+1g+uM2+Zme2q
	vjcOci5FUZaH/dbmFElUUbQ+K6Qnszzlovx4cLwvTwCz0GlACIA2LwLHc7k1N41+KkUeGMr
	R17U4IaTN19+yl/qTfd5WK+CD2DO6GW9fgaifr4IwqNL8oa+BuNv9jX6l246w2EbwecDe2O
	B++Sy3kLb+u7E506g17KcNAQ5d9jZlwxasxkkEYTRPzbLj5WR2hQfBpGTm6QiN60F/cw/5z
	tYQS0mecsd1EKXIlpZlRT8aPlExeHHChTfOMhINzJJUUAmi9W4LVTjgRN/wqDahtsfkoTcd
	zPXeh40J132yPrXDxDgiXQj0DiQ4PP3k5UtOG7YMMtJW7l30Dj+rCW3Svmowsngz4jvrTax
	/rgYvc/wRFwKnKiaqrwOoILSM0QjwOQ93NndM91l7QbMtE7xDqwxF4lfMke4QwX/PUIeHkp
	jZ9ySltA0DF/jkJA5LrjR/13tEZ0M8unehzPUUzTZ+yFj5ihbVQ4JmWuybMgjvDS6Fgyf5t
	Ym0v2HyCjo3blFicVQXrrgaVJCC/tx/3JZrb83/yOyq05QeGt74UupT6qxCh+Fc6lQq4UWL
	Pb/080IY/M0cj8CLNtT7Rpqcv7FPObdIuUJl1rz28r7GoUy23kvfDhkjCkXb3DS7iaWATw4
	6WVDf+9tKNCFfswg6Nk3oM8k/0+eU5nb+CrPxUlh9/5pc6sICAWPd1Cz3YgKeXT6uKG0Y9h
	9ESQ0pn3G42lcwDyfHmRn8=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The new added mailbox commands require a new released firmware version.
Otherwise, a lot of logs "Unknown FW command" would be printed. And the
devices may not work properly. So add the test command in the probe
function.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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


