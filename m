Return-Path: <netdev+bounces-190974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C323AB98F2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2384A63AB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0981231841;
	Fri, 16 May 2025 09:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A022F76B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388056; cv=none; b=SFVw/yPJ0Z6ojZKY6zOghuxqDN+wS7yhnvHzLz3YFLERJ+0DPYUv013lOSop3iQS6yUwgjWpIwvmPRNjmA5KdkiCJSwouHq9MX9lUHPuT4F0N0ByMKl3UqoOe8QqDLAMBP8A7k15HARg0NSpYEayiwJzFgkrl57G4jg5ryg3uSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388056; c=relaxed/simple;
	bh=3JHwYYBei4MBqXq7AUbL0T1aGSV8Cad9i7YeJMNI9nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc1zlQUznPnqfQ/SnTGPAJOxPMW1czv9zjo85ZpR0dTktm7FeicHUt/yeB6Zmd6nXiNSdpfPPh6YFmJm5nXCPOLbAJwjyeHrD6VwPlFwCbPeSNkzVvXUpkT0CSNNOP3ekbBpgVH4FKNdGa2IxDAucpB6WT2yOLr6dCfOTY0OCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387980tc5f4e71a
X-QQ-Originating-IP: OmF0p9yJXhUXF+in/Rkz4cnkYcXhXhgEvLasRQgwfDk=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:59 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8757114396790303968
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
Subject: [PATCH net-next 9/9] net: txgbe: Implement SRIOV for AML devices
Date: Fri, 16 May 2025 17:32:20 +0800
Message-ID: <CE302004991EAA2C+20250516093220.6044-10-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MHa7XUe+VRiKGh4IT3kHaw/wQTmWZ5u78DMh3vcyWa2bOrCnb5M2rVdL
	v+02pzuOj2Ey6h51wRP4ug5i3yyLosR74XEsqPjIh9wZ3qW94uIf8TybuYA2gbYzAvIJ79U
	/TSXpTUcxS/YJF35+7zZRJdOCQ5b6woYGPgzODj0oGVvZgU+E5IhypYqk0PZrz9o4t7/Krg
	VmQOnZE0vgpP45feaKqDA+Cj/dCdQa2U+iUOBx9QXKYxX/k7JRZisNbu9LpDskscDAieFNj
	JvnrZJhF9bPFo73WIULdC+0dUamqrt+tzJxk7Q+w3cfnLQ+FcqprKMl1Arvs6Xbe7Sow4d5
	BWANnLvwu9QBhR6pbct54gkvq6UUYeUw8NDOlTAvHJ6pewZNP9y8LWDjZz9Ox0uJvsxkYmW
	ecq8MHh3yolA8hUIoA4dJTpax/nMH/XjR4uo6Xy2dXivtfAR9HoXAK+W0pGCrlwbVGjtmpN
	jOPidHZYFGma/TSx/pwqQdBlKLFivrerOAtgo8ry9h55+mipm8kSnWvJe7A1/24ywLJceNT
	Cn3imkchzNNFYF/BOz91hMFnefRrpvdxZgErPNfPbhTBHpFoZq1Ac6ZNSZtIqygravW4p8m
	smqdbxmZArCd9H3Mkb7yeeyNzhXUohcCN5wcOP+QwUiMF49S4SWIIzgThlxvd5egkFiDkSr
	ukyh2l9m1ujgsMtV+wnI3CvKKVyVcDh4fd0a/U4hsXLevFnGeI0jePu4VFX+cx/68X7rBqt
	D3ksLNTgldyw2BLvRUFkfjcTAcTfPHOd1luuqfxdM900aRuhi5Dchw3H2O3CSj0CFXxu6NM
	Xkp1f9unh3e1G8nlE9jSnLf5JFmd0gT6c0YYsK2jc3DzDdaePiyygsAjhclgcuATo3rTZrA
	su476i45A4A04jgPrBHcNH9fA+syx9Gum2V7MOAyCzbSmAPldb5IKW2Zv9yNiil7bWfl9rF
	l9gPXZCmfHnCWBKOPQSQQoPAaAA1MMqfsqT9Tu9DkWfn/M+CwrelqlO7m5qR8V9yK8aXsCN
	WIS9x2/qCQAXFTaJM472TAgGJ6TNnprV9zQmJOLgZZIosW28viBHwlT7klCrJQUvK1i/GwY
	3s1+16jesWPNmexmJijCHE=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Support to bring VFs link up for AML 25G/10G devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 6bcf67bef576..7dbcf41750c1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -10,6 +10,7 @@
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_aml.h"
 #include "txgbe_hw.h"
@@ -315,6 +316,8 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
 	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static void txgbe_mac_link_down_aml(struct phylink_config *config,
@@ -329,6 +332,8 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void txgbe_mac_config_aml(struct phylink_config *config, unsigned int mode,
-- 
2.48.1


