Return-Path: <netdev+bounces-12499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C069D737DD3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 10:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F812814D7
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1156C8C7;
	Wed, 21 Jun 2023 08:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B05A95B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:52:24 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B0D170C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 01:52:21 -0700 (PDT)
X-QQ-mid: bizesmtp64t1687337535tvp7sqy9
Received: from wxdbg.localdomain.com ( [122.235.139.240])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 Jun 2023 16:52:05 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: D2GZf6M6C/j9o+n1r3Uz2qtEkrscrR41n7nvKpon3IbLlz3/cdPBWe6bMba/q
	MKm92ItEtRWVAF1zvcqqkNmpKkjpEeKTW66wLn5G9pUaFC2QIcgOPXODGFAaioNeviNXHWx
	DABCiGjC7l1aogKHqL5Dq+UU2euyseBNbwzYP96ztYbZhhnKZtB/ZimfGDqwwHSHwMczRTs
	4ITaOA4jtiEQr0pGePUmkvWNY3R+u+jFI7yUEn00PBqjBD7GNaKhxspBmtSR7ZC7/os3Hwy
	0XhBhI35VXaIUOHer2IEJgK9mgIr9ZmMZBWjmjGQYz8G8j5sMW4aFCeq49C7y+ZSwgPQJXn
	16wywZFMAR9hujBZVyTtSASPGgGHmAZ6poxAVb38Ae/4IV7KxrVW7MCLiyF0Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3130668812617229589
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: change hw reset mode
Date: Wed, 21 Jun 2023 17:06:45 +0800
Message-Id: <20230621090645.125466-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The old way to do hardware reset is sending reset command to firmware.
In order to adapt to the new firmware, driver directly write register
of LAN reset instead of the old way. And remove the redundant functions
wx_reset_hostif() and wx_calculate_checksum().

Fixes: b08012568ebb ("net: txgbe: Reset hardware")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 65 -------------------
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |  1 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  8 +--
 3 files changed, 4 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index ca409b4054d0..6cf49db55938 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -431,71 +431,6 @@ int wx_read_ee_hostif_buffer(struct wx *wx,
 }
 EXPORT_SYMBOL(wx_read_ee_hostif_buffer);
 
-/**
- *  wx_calculate_checksum - Calculate checksum for buffer
- *  @buffer: pointer to EEPROM
- *  @length: size of EEPROM to calculate a checksum for
- *  Calculates the checksum for some buffer on a specified length.  The
- *  checksum calculated is returned.
- **/
-static u8 wx_calculate_checksum(u8 *buffer, u32 length)
-{
-	u8 sum = 0;
-	u32 i;
-
-	if (!buffer)
-		return 0;
-
-	for (i = 0; i < length; i++)
-		sum += buffer[i];
-
-	return (u8)(0 - sum);
-}
-
-/**
- *  wx_reset_hostif - send reset cmd to fw
- *  @wx: pointer to hardware structure
- *
- *  Sends reset cmd to firmware through the manageability
- *  block.
- **/
-int wx_reset_hostif(struct wx *wx)
-{
-	struct wx_hic_reset reset_cmd;
-	int ret_val = 0;
-	int i;
-
-	reset_cmd.hdr.cmd = FW_RESET_CMD;
-	reset_cmd.hdr.buf_len = FW_RESET_LEN;
-	reset_cmd.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
-	reset_cmd.lan_id = wx->bus.func;
-	reset_cmd.reset_type = (u16)wx->reset_type;
-	reset_cmd.hdr.checksum = 0;
-	reset_cmd.hdr.checksum = wx_calculate_checksum((u8 *)&reset_cmd,
-						       (FW_CEM_HDR_LEN +
-							reset_cmd.hdr.buf_len));
-
-	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
-		ret_val = wx_host_interface_command(wx, (u32 *)&reset_cmd,
-						    sizeof(reset_cmd),
-						    WX_HI_COMMAND_TIMEOUT,
-						    true);
-		if (ret_val != 0)
-			continue;
-
-		if (reset_cmd.hdr.cmd_or_resp.ret_status ==
-		    FW_CEM_RESP_STATUS_SUCCESS)
-			ret_val = 0;
-		else
-			ret_val = -EFAULT;
-
-		break;
-	}
-
-	return ret_val;
-}
-EXPORT_SYMBOL(wx_reset_hostif);
-
 /**
  *  wx_init_eeprom_params - Initialize EEPROM params
  *  @wx: pointer to hardware structure
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index c173c56f0ab5..9faacf0c51d1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -14,7 +14,6 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 int wx_read_ee_hostif(struct wx *wx, u16 offset, u16 *data);
 int wx_read_ee_hostif_buffer(struct wx *wx,
 			     u16 offset, u16 words, u16 *data);
-int wx_reset_hostif(struct wx *wx);
 void wx_init_eeprom_params(struct wx *wx);
 void wx_get_mac_addr(struct wx *wx, u8 *mac_addr);
 void wx_init_rx_addrs(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index ebc46f3be056..e571f494bb4a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -270,16 +270,16 @@ static void txgbe_reset_misc(struct wx *wx)
 int txgbe_reset_hw(struct wx *wx)
 {
 	int status;
+	u32 val;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	status = wx_stop_adapter(wx);
 	if (status != 0)
 		return status;
 
-	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
-	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP)))
-		wx_reset_hostif(wx);
-
+	val = WX_MIS_RST_LAN_RST(wx->bus.func);
+	wr32(wx, WX_MIS_RST, val | rd32(wx, WX_MIS_RST));
+	WX_WRITE_FLUSH(wx);
 	usleep_range(10, 100);
 
 	status = wx_check_flash_load(wx, TXGBE_SPI_ILDR_STATUS_LAN_SW_RST(wx->bus.func));
-- 
2.27.0


