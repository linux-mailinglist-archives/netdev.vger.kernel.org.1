Return-Path: <netdev+bounces-18144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3575594D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70EF1C20A10
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DED1118;
	Mon, 17 Jul 2023 02:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86267A49
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:00:44 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26491E54
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:00:40 -0700 (PDT)
X-QQ-mid: bizesmtp82t1689559233tf9n749h
Received: from wxdbg.localdomain.com ( [122.235.243.13])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Jul 2023 10:00:24 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKbAoK9pPjI2kO9z/sTxu3PaMy5ApwzZ4hY58BDblOXhaD0f9eWI0
	vvvf4k4irmiWSBtvP6nYRCF291uqhwn9O0p9g63BUznfXBvOZdlVZdWnETRutexykWfoX+L
	6dS/f0hhMgh5E5BhrxOO2WGGmRXBmopSlcDmDAktO38ZGyCl74CwkSGZeDNUIEaGE0zhCoT
	hUmcJYTpw6dGkWIYE0DTR5lwlhy44qUn5z4vEk7j7UJ3r+YPObwftkW78KJvQoWps2/ZMH+
	kDCaFXJbxaGcdIcAL6srpu/U+B1iXw9GO/vRI3BfbwKzq6LetT3gryjm9IAZ3a5IAASEF0W
	+Vj7T1rWX8kIGJPus5E1aAI15KmPHZJa+tRaZQy5px95qIJdhAFoNlPxTvLZA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3956318197950219282
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	simon.horman@corigine.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4] net: txgbe: change LAN reset mode
Date: Mon, 17 Jul 2023 10:13:33 +0800
Message-Id: <20230717021333.94181-1-jiawenwu@trustnetic.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The old way to do LAN reset is sending reset command to firmware. Once
firmware performs reset, it reconfigures what it needs.

In the new firmware versions, veto bit is introduced for NCSI/LLDP to
block PHY domain in LAN reset. At this point, writing register of LAN
reset directly makes the same effect as the old way. And it does not
reset MNG domain, so that veto bit does not change.

Since veto bit was never used, the old firmware is compatible with the
driver before and after this change. The new firmware needs to use with
the driver after this change if it wants to implement the new feature,
otherwise it is the same as the old firmware.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v3 -> v4:
- detail commit log
- drop fixes tag
v2 -> v3:
- post to net-next
v1 -> v2:
- detail commit log
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 65 -------------------
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |  1 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  8 +--
 3 files changed, 4 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 39a9aeee7aab..8f5bba0778c6 100644
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
index 1f93ca32c921..0c4756e6ee06 100644
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
index 0772eb14eabf..6e130d1f7a7b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -257,16 +257,16 @@ static void txgbe_reset_misc(struct wx *wx)
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


