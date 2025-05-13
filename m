Return-Path: <netdev+bounces-189953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9EAB4954
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9F64640A5
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FE1B3950;
	Tue, 13 May 2025 02:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9E1AED5C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102343; cv=none; b=njyq4HZc5J+Cib9jIRVhzxwtwdsvsbzawoFgM2nIWqpgmhKYwStI5UDPbBJT2IGaCmT2qtx+5FktDr99YA/88M/R+3lpPWhjFK5M/JQKuczahKTgfUgkTLKhFJamiSakTUZ7UBNNnUJP11rcq2f1VFPH83C1Muk1mEDL2H3XH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102343; c=relaxed/simple;
	bh=BxftasFDg8AwNJfhFrjoEDSLF8mjqQGubB46r6zPbok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXzwsh4FpDHJtGa6bts7RvjzKiDal/UtFEeM9S1+ZkrX5CHHe8dQbWn4+900h5nwSXCvW/jAYu0yaudwcc3FSdJDvTu7URH6aEcAo9HAoeYlwQydDGRkVrW3pI/i4+DHbd0SOYrS7BZ0r5F2yJQeTYto48Mjieu+31XKTYyDaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1747102226t22290d29
X-QQ-Originating-IP: GvC6GxoBcWgdHITmu3YX6AmAqBts38Tsw17sgfBUe34=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 10:10:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13148003119675519104
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 1/3] net: txgbe: Fix to calculate EEPROM checksum for AML devices
Date: Tue, 13 May 2025 10:10:07 +0800
Message-ID: <1C6BF7A937237F5A+20250513021009.145708-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250513021009.145708-1-jiawenwu@trustnetic.com>
References: <20250513021009.145708-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MP1WLfctJNZWZQRf+ngmmvXWhCbMVpZZY0AQek8QPB9wT7hvOWIpvyP+
	7+FN7KyV90NDBRf3VXcBdOy1Tb70JvPMCma9VMxaSrFCtgSIVfJgxv7x0IE5sYqsloZIE9p
	J+uZ4MIyWdNfueOOBr2osm94XK1ajmauEru+MdJNGXFRhRyGCrWI56X8ru/62WMl0F9Cs3t
	O/NF63/kJTCCd/Vwnd4MdImSBUPbekHI+4Utjgf8GVJUSVluTQFHn6Jli8FqXFeQ+oXX4RG
	LlU7pdpvQCRCvB/N4I1BOeHEuF/eoUm+uH89+BiIWzwGb5pedRQCgNpfpk7ZZOykIziY78C
	3dT2LGA09QoWoyw/i8wkGDMQuiUzfbgWVH9aCHrBDtiifiMziY0BOG52SSAavzp9oMvEHkB
	gTySlRr7RVYk228oTXncvJRJKQloo2IyjZBG1mxJTOKSV16WOaYpNjHl/QJSS0/P5Scx49t
	Xr9SGebFI2zR3MU1Sxbz5TgF7p0X4TSd6XzczqVOWzxsCi0MAjvVXaCad4YED8y/6H/yX0n
	wFYVmsOURdojFLoKY0Dyk1Cj6R1eMsxlTV6lJlHR/7ldQKQI/89fWkLI/1CaubRzKkOqXqn
	1Q0UQHY0X0OuzN4PM1qfLPUARFP5Bx/vPrXWx8QJcDyOtdnY3O/O8sRm9mdRZ3SPigR3861
	NaeUN+zc00mU+TBygu08ohOm51LseI2aK3WgSW+TDbNP5jKKGYGtOoXF3ebHFy8pmvUJrA7
	4PeccEkV6wg0pyOqpdIljL2vAn8EguTvYoNCiXRqkP+4/DSJ0nK6/J0HOnWSzScfAqbqStT
	sHyeeNEFgliDHe+Gmbhp2RpbeM8daFUTDTF30ibSzcWBsRdhKEQCn4EYTmoqGjQhq4bwhfy
	cO1cJ9M8uJccZZ0Mqe0HrAPXMEH73OjXkRG2xk6uuXdQkjtLPN5RHBdYzrtdp1+47Uvhb6Y
	ofYX2jfwUzW3Fd3LJSnqSzIvTSE6eEV5qmR2HNah3Ze7lwMGSOd/a2m8AQfu/d8ZDiJBbQy
	98beiMFw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

In the new firmware version, the shadow ram reserves some space to store
I2C information, so the checksum calculation needs to skip this section.
Otherwise, the driver will fail to probe because the invalid EEPROM
checksum.

Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c   | 8 +++++++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 4b9921b7bb11..a054b259d435 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -99,9 +99,15 @@ static int txgbe_calc_eeprom_checksum(struct wx *wx, u16 *checksum)
 	}
 	local_buffer = eeprom_ptrs;
 
-	for (i = 0; i < TXGBE_EEPROM_LAST_WORD; i++)
+	for (i = 0; i < TXGBE_EEPROM_LAST_WORD; i++) {
+		if (wx->mac.type == wx_mac_aml) {
+			if (i >= TXGBE_EEPROM_I2C_SRART_PTR &&
+			    i < TXGBE_EEPROM_I2C_END_PTR)
+				local_buffer[i] = 0xffff;
+		}
 		if (i != wx->eeprom.sw_region_offset + TXGBE_EEPROM_CHECKSUM)
 			*checksum += local_buffer[i];
+	}
 
 	kvfree(eeprom_ptrs);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 9c1c26234cad..f423012dec22 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -158,6 +158,8 @@
 #define TXGBE_EEPROM_VERSION_L                  0x1D
 #define TXGBE_EEPROM_VERSION_H                  0x1E
 #define TXGBE_ISCSI_BOOT_CONFIG                 0x07
+#define TXGBE_EEPROM_I2C_SRART_PTR              0x580
+#define TXGBE_EEPROM_I2C_END_PTR                0x800
 
 #define TXGBE_MAX_MSIX_VECTORS          64
 #define TXGBE_MAX_FDIR_INDICES          63
-- 
2.48.1


