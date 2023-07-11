Return-Path: <netdev+bounces-16699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535ED74E6FD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746CA1C20BB8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B971640C;
	Tue, 11 Jul 2023 06:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2933D7B
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:13:46 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C02C4
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:13:43 -0700 (PDT)
X-QQ-mid: bizesmtp70t1689056015t9p7fibz
Received: from wxdbg.localdomain.com ( [183.128.130.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Jul 2023 14:13:08 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: SFhf6fKhx/+6pWEfW5teZ1S9u5R34FZw8DCl751SqqVcHfjrn1QzFffbibt/q
	Kx3ROUAXaHfPfGMPX3RbWTTufPwqjlcCy8cJPV3TT5Bhz4FEtN/tfFu/5khWAbiTMM+j+im
	tN2pV4A48LECHMRDuJz1s2UH039UnYeg3JOL6izoYw0vxVEHMg4DB5khoUWBWpqjGdnXyAJ
	2GJmeo0rEHE3AcJPV4CsjAAwZtIIcCjeP5nkP6qN8HIw6QFqHSqGhBICjC/NWXEArvsnLXk
	41pZsq0xBFkVoiW3Y4D6Pju9mq1w+NzjjSGXQQXaRSsrI2Vi1BphtXFRTh+sIuSBE4ytApN
	KmpVHM/JmW9+M+vtcI82Aso9Xuk7yBCSH5XQAUowM85tJsbxYY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11223655557796289168
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3] net: txgbe: change LAN reset mode
Date: Tue, 11 Jul 2023 14:26:23 +0800
Message-Id: <20230711062623.3058-1-jiawenwu@trustnetic.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The old way to do LAN reset is sending reset command to firmware. Once
firmware performs reset, it reconfigures what it needs.

In the new firmware versions, veto bit is introduced for NCSI/LLDP to
block PHY domain in LAN reset. At this point, writing register of LAN
reset directly makes the same effect as the old way. And it does not
reset MNG domain, so that veto bit does not change.

And this change is compatible with old firmware versions, since veto
bit was never used.

Fixes: b08012568ebb ("net: txgbe: Reset hardware")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
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


