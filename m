Return-Path: <netdev+bounces-168398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F49FA3ECDC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4429F421BCF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF31FE443;
	Fri, 21 Feb 2025 06:34:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A641FDA9E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119653; cv=none; b=qdJyo4ynt7PByGlk+x8rkZpk2C2NJEmSNUeklKY0E7v0STbEfw2qw1uulrCQlusaOirSgQWsgwVZlpdwWrBLfuxn9ufrgy1AwwXTtrB1P3n/t/CpUxIQFDz1g+wpwgro6rlfj38WFA/S2m0Nx+3Lz80ieEqFZp4+sloRR33FqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119653; c=relaxed/simple;
	bh=1CRTAyyEg6RV6owCfcSqfmF7K3WYdEqG5Fbt3X7PRys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4KxwtsIESsWw+Dx0rd/tVXavhoIsBrwtRrIbZiift3JWnpBvzJTfMumCZLWmhuc94GDKgY8IgBuOqUoeNm5MJzuEXA/JxwNpdJsXBowBhzidkrke0UIuv1AD+hbsdGYfaR6vDcHAs+CjprtAiOR94Anm5GeiMtPxtrlcNu/MqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp78t1740119536tf5d5mwn
X-QQ-Originating-IP: ICKiPlI1XprJAKGR15fWyqeRQz0rM/LFviOmE/smR5w=
Received: from wxdbg.localdomain.com ( [115.204.250.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Feb 2025 14:32:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15777886853694804327
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 1/2] net: txgbe: Add basic support for new AML devices
Date: Fri, 21 Feb 2025 14:57:17 +0800
Message-Id: <20250221065718.197544-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N55MlACpQQDv/+aAVsZlbLTwbgVX+qW3uKw5n+WZPSfeJXpcD0LAFkzp
	lEn5UmRlO8MMETuKrYhvkt+9Pe4yMq67PB8PZQ3s9lWF9yT6SbTnI9oUpaeIryBTVWzIXb8
	ahRIU0/rCATfSx+6e2y/+xfCGpjaZWEHIlfkv26g/HendIKgqDCGJFzi/zB1zWeIh4MOwSx
	W9f5zWHIJD2ntVVvPlDWmimian1jwkxga9Pvoym46mUWidPGXqyL4yrJXhgMPyyi83vxDsN
	lZDAd6SnBFQMY+n++YBG+jKFjmRhSM2Qmn7DYW4/uCQPQdgzqI57L+1zQJpB4n25LA3Ugo7
	HEDjj0Nia8SyGiIVHiTTIvC5r8yWd9gwMr3FRD4QAmI9Ej4DFDDg2m0iLP8IPJcu4P7R9ml
	L3wxi2daED74G2KdlyD5MXzI2E6quN/YIZLeUGjhz0LIL1Un8SyOHnqIw9euZMw2DXEHpfd
	nL6kvUvJ+TjxlTzmRjmfuy2zv+WuE72LcIFx5X7YB+8v//gFE3z+u7ZTpFSh4TOTcNzAPJF
	Rn0ieUmlxi8XXXUaonE7PUvuXDxd4DNGGBkG+VyCajc+07oxsP0uF6JpaSVrG0XbY2RzTph
	JWmM3dRSwAjIgg3RuesdIFL05dZaZLbfC1gA209dBgawaedy6JQEtrKHWndZ3nYTEDjEyoX
	OBkejUv6ZHjj2Qa6Y6CkgOqMg3NCDuxWuUG7VaCu9MYX7ToJy0yTgzdySbfn6hcxTfFLwKB
	Ga3dizCR5UQaHGLE1vV4WOiBsCSNJGnqJrnHgyvcA3ik3lALhlhQ5hGaNFLKHjTWcgSk3pe
	GtgMEMhldK7oo/UL1cZL+b3BNGmCTZfXiGhC1sHK8kLDkGyHuGZevn7v2zj19obicCJSQRJ
	6AaX+bY5ATpQhY0j225kaRKlOaVYMesF0sGcUWWq5or/zOZJlTdTYHBVDS8uBhJBwzkljsI
	JcrRLgubAoBve/nEOwE9F4DjYzKWNJldyrvE7jQkLxZfTHyeuNRvOF9GnhDNKuQ1g0zXYiJ
	0NxMvXWbizEV1lEaa6SblaRsgsRHE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

There is a new 40/25/10 Gigabit Ethernet device.

To support basic functions, PHYLINK is temporarily skipped as it is
intended to implement these configurations in the firmware. And the
associated link IRQ is also skipped.

And Implement the new SW-FW interaction interface, which use 64 Byte
message buffer.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
Changes in v4:
- Link to v3: https://lore.kernel.org/all/20250115102408.2225055-1-jiawenwu@trustnetic.com/
- Fix the wrong variable assignment in the function for read_poll_timeout()
- Rebase on wangxun PTP patch set

Changes in v3:
- Use 'err' instead of 'status' as error return
- Use might_sleep() instead of WARN_ON(in_interrupt())
- Use read_poll_timeout()
- Add le32_to_cpu() to convert mbox read buffer
- Adjust comma in enums

Changes in v2:
- Add missing 40G devide IDs
- Add condition for wx->do_reset != NULL
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  44 +++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 213 +++++++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  25 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  29 ++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   6 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  43 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   6 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  14 ++
 9 files changed, 333 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 28f982fbc64c..6d3b57233a39 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -219,6 +219,9 @@ int wx_nway_reset(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_nway_reset(wx->phylink);
 }
 EXPORT_SYMBOL(wx_nway_reset);
@@ -228,6 +231,9 @@ int wx_get_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_get_link_ksettings);
@@ -237,6 +243,9 @@ int wx_set_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_set_link_ksettings);
@@ -246,6 +255,9 @@ void wx_get_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return;
+
 	phylink_ethtool_get_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_get_pauseparam);
@@ -255,6 +267,9 @@ int wx_set_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_set_pauseparam);
@@ -325,10 +340,17 @@ int wx_set_coalesce(struct net_device *netdev,
 	if (ec->tx_max_coalesced_frames_irq)
 		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
 
-	if (wx->mac.type == wx_mac_sp)
+	switch (wx->mac.type) {
+	case wx_mac_sp:
 		max_eitr = WX_SP_MAX_EITR;
-	else
+		break;
+	case wx_mac_aml:
+		max_eitr = WX_AML_MAX_EITR;
+		break;
+	default:
 		max_eitr = WX_EM_MAX_EITR;
+		break;
+	}
 
 	if ((ec->rx_coalesce_usecs > (max_eitr >> 2)) ||
 	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
@@ -350,10 +372,15 @@ int wx_set_coalesce(struct net_device *netdev,
 		wx->tx_itr_setting = ec->tx_coalesce_usecs;
 
 	if (wx->tx_itr_setting == 1) {
-		if (wx->mac.type == wx_mac_sp)
+		switch (wx->mac.type) {
+		case wx_mac_sp:
+		case wx_mac_aml:
 			tx_itr_param = WX_12K_ITR;
-		else
+			break;
+		default:
 			tx_itr_param = WX_20K_ITR;
+			break;
+		}
 	} else {
 		tx_itr_param = wx->tx_itr_setting;
 	}
@@ -386,10 +413,15 @@ static unsigned int wx_max_channels(struct wx *wx)
 		max_combined = 1;
 	} else {
 		/* support up to max allowed queues with RSS */
-		if (wx->mac.type == wx_mac_sp)
+		switch (wx->mac.type) {
+		case wx_mac_sp:
+		case wx_mac_aml:
 			max_combined = 63;
-		else
+			break;
+		default:
 			max_combined = 8;
+			break;
+		}
 	}
 
 	return max_combined;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 907d13ade404..b5f35b187077 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -112,10 +112,15 @@ static void wx_intr_disable(struct wx *wx, u64 qmask)
 	if (mask)
 		wr32(wx, WX_PX_IMS(0), mask);
 
-	if (wx->mac.type == wx_mac_sp) {
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+	case wx_mac_aml:
 		mask = (qmask >> 32);
 		if (mask)
 			wr32(wx, WX_PX_IMS(1), mask);
+		break;
+	default:
+		break;
 	}
 }
 
@@ -126,10 +131,16 @@ void wx_intr_enable(struct wx *wx, u64 qmask)
 	mask = (qmask & U32_MAX);
 	if (mask)
 		wr32(wx, WX_PX_IMC(0), mask);
-	if (wx->mac.type == wx_mac_sp) {
+
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+	case wx_mac_aml:
 		mask = (qmask >> 32);
 		if (mask)
 			wr32(wx, WX_PX_IMC(1), mask);
+		break;
+	default:
+		break;
 	}
 }
 EXPORT_SYMBOL(wx_intr_enable);
@@ -278,22 +289,8 @@ static int wx_acquire_sw_sync(struct wx *wx, u32 mask)
 	return ret;
 }
 
-/**
- *  wx_host_interface_command - Issue command to manageability block
- *  @wx: pointer to the HW structure
- *  @buffer: contains the command to write and where the return status will
- *   be placed
- *  @length: length of buffer, must be multiple of 4 bytes
- *  @timeout: time in ms to wait for command completion
- *  @return_data: read and return data from the buffer (true) or not (false)
- *   Needed because FW structures are big endian and decoding of
- *   these fields can be 8 bit or 16 bit based on command. Decoding
- *   is not easily understood without making a table of commands.
- *   So we will leave this up to the caller to read back the data
- *   in these cases.
- **/
-int wx_host_interface_command(struct wx *wx, u32 *buffer,
-			      u32 length, u32 timeout, bool return_data)
+static int wx_host_interface_command_s(struct wx *wx, u32 *buffer,
+				       u32 length, u32 timeout, bool return_data)
 {
 	u32 hdr_size = sizeof(struct wx_hic_hdr);
 	u32 hicr, i, bi, buf[64] = {};
@@ -301,22 +298,10 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 	u32 dword_len;
 	u16 buf_len;
 
-	if (length == 0 || length > WX_HI_MAX_BLOCK_BYTE_LENGTH) {
-		wx_err(wx, "Buffer length failure buffersize=%d.\n", length);
-		return -EINVAL;
-	}
-
 	status = wx_acquire_sw_sync(wx, WX_MNG_SWFW_SYNC_SW_MB);
 	if (status != 0)
 		return status;
 
-	/* Calculate length in DWORDs. We must be DWORD aligned */
-	if ((length % (sizeof(u32))) != 0) {
-		wx_err(wx, "Buffer length failure, not aligned to dword");
-		status = -EINVAL;
-		goto rel_out;
-	}
-
 	dword_len = length >> 2;
 
 	/* The device driver writes the relevant command block
@@ -391,6 +376,139 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 	wx_release_sw_sync(wx, WX_MNG_SWFW_SYNC_SW_MB);
 	return status;
 }
+
+static bool wx_poll_fw_reply(struct wx *wx, u32 *buffer, u8 send_cmd)
+{
+	u32 dword_len = sizeof(struct wx_hic_hdr) >> 2;
+	struct wx_hic_hdr *recv_hdr;
+	u32 i;
+
+	/* read hdr */
+	for (i = 0; i < dword_len; i++) {
+		buffer[i] = rd32a(wx, WX_FW2SW_MBOX, i);
+		le32_to_cpus(&buffer[i]);
+	}
+
+	/* check hdr */
+	recv_hdr = (struct wx_hic_hdr *)buffer;
+	if (recv_hdr->cmd == send_cmd &&
+	    recv_hdr->index == wx->swfw_index)
+		return true;
+
+	return false;
+}
+
+static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
+				       u32 length, u32 timeout, bool return_data)
+{
+	struct wx_hic_hdr *hdr = (struct wx_hic_hdr *)buffer;
+	u32 hdr_size = sizeof(struct wx_hic_hdr);
+	bool busy, reply;
+	u32 dword_len;
+	u16 buf_len;
+	int err = 0;
+	u8 send_cmd;
+	u32 i;
+
+	/* wait to get lock */
+	might_sleep();
+	err = read_poll_timeout(test_and_set_bit, busy, !busy, 1000, timeout * 1000,
+				false, WX_STATE_SWFW_BUSY, wx->state);
+	if (err)
+		return err;
+
+	/* index to unique seq id for each mbox message */
+	hdr->index = wx->swfw_index;
+	send_cmd = hdr->cmd;
+
+	dword_len = length >> 2;
+	/* write data to SW-FW mbox array */
+	for (i = 0; i < dword_len; i++) {
+		wr32a(wx, WX_SW2FW_MBOX, i, (__force u32)cpu_to_le32(buffer[i]));
+		/* write flush */
+		rd32a(wx, WX_SW2FW_MBOX, i);
+	}
+
+	/* generate interrupt to notify FW */
+	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, 0);
+	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
+
+	/* polling reply from FW */
+	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 1000, 50000,
+				true, wx, buffer, send_cmd);
+	if (err) {
+		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
+		       send_cmd, wx->swfw_index);
+		goto rel_out;
+	}
+
+	/* expect no reply from FW then return */
+	if (!return_data)
+		goto rel_out;
+
+	/* If there is any thing in data position pull it in */
+	buf_len = hdr->buf_len;
+	if (buf_len == 0)
+		goto rel_out;
+
+	if (length < buf_len + hdr_size) {
+		wx_err(wx, "Buffer not large enough for reply message.\n");
+		err = -EFAULT;
+		goto rel_out;
+	}
+
+	/* Calculate length in DWORDs, add 3 for odd lengths */
+	dword_len = (buf_len + 3) >> 2;
+	for (i = hdr_size >> 2; i <= dword_len; i++) {
+		buffer[i] = rd32a(wx, WX_FW2SW_MBOX, i);
+		le32_to_cpus(&buffer[i]);
+	}
+
+rel_out:
+	/* index++, index replace wx_hic_hdr.checksum */
+	if (wx->swfw_index == WX_HIC_HDR_INDEX_MAX)
+		wx->swfw_index = 0;
+	else
+		wx->swfw_index++;
+
+	clear_bit(WX_STATE_SWFW_BUSY, wx->state);
+	return err;
+}
+
+/**
+ *  wx_host_interface_command - Issue command to manageability block
+ *  @wx: pointer to the HW structure
+ *  @buffer: contains the command to write and where the return status will
+ *   be placed
+ *  @length: length of buffer, must be multiple of 4 bytes
+ *  @timeout: time in ms to wait for command completion
+ *  @return_data: read and return data from the buffer (true) or not (false)
+ *   Needed because FW structures are big endian and decoding of
+ *   these fields can be 8 bit or 16 bit based on command. Decoding
+ *   is not easily understood without making a table of commands.
+ *   So we will leave this up to the caller to read back the data
+ *   in these cases.
+ **/
+int wx_host_interface_command(struct wx *wx, u32 *buffer,
+			      u32 length, u32 timeout, bool return_data)
+{
+	if (length == 0 || length > WX_HI_MAX_BLOCK_BYTE_LENGTH) {
+		wx_err(wx, "Buffer length failure buffersize=%d.\n", length);
+		return -EINVAL;
+	}
+
+	/* Calculate length in DWORDs. We must be DWORD aligned */
+	if ((length % (sizeof(u32))) != 0) {
+		wx_err(wx, "Buffer length failure, not aligned to dword");
+		return -EINVAL;
+	}
+
+	if (test_bit(WX_FLAG_SWFW_RING, wx->flags))
+		return wx_host_interface_command_r(wx, buffer, length,
+						   timeout, return_data);
+
+	return wx_host_interface_command_s(wx, buffer, length, timeout, return_data);
+}
 EXPORT_SYMBOL(wx_host_interface_command);
 
 int wx_set_pps(struct wx *wx, bool enable, u64 nsec, u64 cycles)
@@ -442,7 +560,10 @@ static int wx_read_ee_hostif_data(struct wx *wx, u16 offset, u16 *data)
 	if (status != 0)
 		return status;
 
-	*data = (u16)rd32a(wx, WX_MNG_MBOX, FW_NVM_DATA_OFFSET);
+	if (!test_bit(WX_FLAG_SWFW_RING, wx->flags))
+		*data = (u16)rd32a(wx, WX_MNG_MBOX, FW_NVM_DATA_OFFSET);
+	else
+		*data = (u16)rd32a(wx, WX_FW2SW_MBOX, FW_NVM_DATA_OFFSET);
 
 	return status;
 }
@@ -486,6 +607,7 @@ int wx_read_ee_hostif_buffer(struct wx *wx,
 	u16 words_to_read;
 	u32 value = 0;
 	int status;
+	u32 mbox;
 	u32 i;
 
 	/* Take semaphore for the entire operation. */
@@ -518,8 +640,12 @@ int wx_read_ee_hostif_buffer(struct wx *wx,
 			goto out;
 		}
 
+		if (!test_bit(WX_FLAG_SWFW_RING, wx->flags))
+			mbox = WX_MNG_MBOX;
+		else
+			mbox = WX_FW2SW_MBOX;
 		for (i = 0; i < words_to_read; i++) {
-			u32 reg = WX_MNG_MBOX + (FW_NVM_DATA_OFFSET << 2) + 2 * i;
+			u32 reg = mbox + (FW_NVM_DATA_OFFSET << 2) + 2 * i;
 
 			value = rd32(wx, reg);
 			data[current_word] = (u16)(value & 0xffff);
@@ -569,12 +695,17 @@ void wx_init_eeprom_params(struct wx *wx)
 		}
 	}
 
-	if (wx->mac.type == wx_mac_sp) {
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+	case wx_mac_aml:
 		if (wx_read_ee_hostif(wx, WX_SW_REGION_PTR, &data)) {
 			wx_err(wx, "NVM Read Error\n");
 			return;
 		}
 		data = data >> 1;
+		break;
+	default:
+		break;
 	}
 
 	eeprom->sw_region_offset = data;
@@ -635,8 +766,15 @@ static int wx_set_rar(struct wx *wx, u32 index, u8 *addr, u64 pools,
 
 	/* setup VMDq pool mapping */
 	wr32(wx, WX_PSR_MAC_SWC_VM_L, pools & 0xFFFFFFFF);
-	if (wx->mac.type == wx_mac_sp)
+
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+	case wx_mac_aml:
 		wr32(wx, WX_PSR_MAC_SWC_VM_H, pools >> 32);
+		break;
+	default:
+		break;
+	}
 
 	/* HW expects these in little endian so we reverse the byte
 	 * order from network order (big endian) to little endian
@@ -774,9 +912,14 @@ void wx_init_rx_addrs(struct wx *wx)
 
 		wx_set_rar(wx, 0, wx->mac.addr, 0, WX_PSR_MAC_SWC_AD_H_AV);
 
-		if (wx->mac.type == wx_mac_sp) {
+		switch (wx->mac.type) {
+		case wx_mac_sp:
+		case wx_mac_aml:
 			/* clear VMDq pool/queue selection for RAR 0 */
 			wx_clear_vmdq(wx, 0, WX_CLEAR_VMDQ_ALL);
+			break;
+		default:
+			break;
 		}
 	}
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 42f90802870b..895f3c96a678 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1823,10 +1823,16 @@ static int wx_alloc_q_vector(struct wx *wx,
 	/* initialize pointer to rings */
 	ring = q_vector->ring;
 
-	if (wx->mac.type == wx_mac_sp)
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+	case wx_mac_aml:
 		default_itr = WX_12K_ITR;
-	else
+		break;
+	default:
 		default_itr = WX_7K_ITR;
+		break;
+	}
+
 	/* initialize ITR */
 	if (txr_count && !rxr_count)
 		/* tx only vector */
@@ -2182,10 +2188,17 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 	int v_idx = q_vector->v_idx;
 	u32 itr_reg;
 
-	if (wx->mac.type == wx_mac_sp)
+	switch (wx->mac.type) {
+	case wx_mac_sp:
 		itr_reg = q_vector->itr & WX_SP_MAX_EITR;
-	else
+		break;
+	case wx_mac_aml:
+		itr_reg = (q_vector->itr >> 3) & WX_AML_MAX_EITR;
+		break;
+	default:
 		itr_reg = q_vector->itr & WX_EM_MAX_EITR;
+		break;
+	}
 
 	itr_reg |= WX_PX_ITR_CNT_WDIS;
 
@@ -2761,7 +2774,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 	netdev->features = features;
 
-	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
 		wx->do_reset(netdev);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
@@ -2793,7 +2806,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 		break;
 	}
 
-	if (need_reset)
+	if (need_reset && wx->do_reset)
 		wx->do_reset(netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index db446e690dc7..f79746ac6aca 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -309,6 +309,10 @@
 #define WX_MNG_MBOX_CTL_FWRDY        BIT(2)
 #define WX_MNG_BMC2OS_CNT            0x1E090
 #define WX_MNG_OS2BMC_CNT            0x1E094
+#define WX_SW2FW_MBOX_CMD            0x1E0A0
+#define WX_SW2FW_MBOX_CMD_VLD        BIT(31)
+#define WX_SW2FW_MBOX                0x1E200
+#define WX_FW2SW_MBOX                0x1E300
 
 /************************************* ETH MAC *****************************/
 #define WX_MAC_TX_CFG                0x11000
@@ -372,6 +376,7 @@ enum WX_MSCA_CMD_value {
 #define WX_12K_ITR                   336
 #define WX_20K_ITR                   200
 #define WX_SP_MAX_EITR               0x00000FF8U
+#define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
 
 /* transmit DMA Registers */
@@ -415,6 +420,7 @@ enum WX_MSCA_CMD_value {
 /****************** Manageablility Host Interface defines ********************/
 #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
 #define WX_HI_COMMAND_TIMEOUT        1000 /* Process HI command limit */
+#define WX_HIC_HDR_INDEX_MAX         255
 
 #define FW_READ_SHADOW_RAM_CMD       0x31
 #define FW_READ_SHADOW_RAM_LEN       0x6
@@ -711,21 +717,30 @@ struct wx_hic_hdr {
 		u8 cmd_resv;
 		u8 ret_status;
 	} cmd_or_resp;
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	};
 };
 
 struct wx_hic_hdr2_req {
 	u8 cmd;
 	u8 buf_lenh;
 	u8 buf_lenl;
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	};
 };
 
 struct wx_hic_hdr2_rsp {
 	u8 cmd;
 	u8 buf_lenl;
 	u8 buf_lenh_status;     /* 7-5: high bits of buf_len, 4-0: status */
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	};
 };
 
 union wx_hic_hdr2 {
@@ -773,7 +788,8 @@ struct wx_thermal_sensor_data {
 enum wx_mac_type {
 	wx_mac_unknown = 0,
 	wx_mac_sp,
-	wx_mac_em
+	wx_mac_em,
+	wx_mac_aml,
 };
 
 enum sp_media_type {
@@ -1085,12 +1101,14 @@ struct wx_hw_stats {
 
 enum wx_state {
 	WX_STATE_RESETTING,
+	WX_STATE_SWFW_BUSY,
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
-	WX_STATE_NBITS,		/* must be last */
+	WX_STATE_NBITS		/* must be last */
 };
 
 enum wx_pf_flags {
+	WX_FLAG_SWFW_RING,
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
@@ -1130,6 +1148,7 @@ struct wx {
 	char eeprom_id[32];
 	char *driver_name;
 	enum wx_reset_type reset_type;
+	u8 swfw_index;
 
 	/* PHY stuff */
 	unsigned int link;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index cd1372da92a9..4b9921b7bb11 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -197,6 +197,12 @@ int txgbe_reset_hw(struct wx *wx)
 
 	txgbe_reset_misc(wx);
 
+	if (wx->mac.type != wx_mac_sp) {
+		wr32(wx, TXGBE_PX_PF_BME, 0x1);
+		wr32m(wx, TXGBE_RDM_RSC_CTL, TXGBE_RDM_RSC_CTL_FREE_CTL,
+		      TXGBE_RDM_RSC_CTL_FREE_CTL);
+	}
+
 	wx_clear_hw_cntrs(wx);
 
 	/* Store the permanent mac address */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 0ee73a265545..8658a51ee810 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -166,6 +166,9 @@ static void txgbe_del_irq_domain(struct txgbe *txgbe)
 
 void txgbe_free_misc_irq(struct txgbe *txgbe)
 {
+	if (txgbe->wx->mac.type == wx_mac_aml)
+		return;
+
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
@@ -177,6 +180,9 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
+	if (wx->mac.type == wx_mac_aml)
+		goto skip_sp_irq;
+
 	txgbe->misc.nirqs = 1;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
@@ -206,6 +212,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	if (err)
 		goto free_msic_irq;
 
+skip_sp_irq:
 	wx->misc_irq_domain = true;
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 734450af9a43..ce83811a45e2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -35,6 +35,12 @@ char txgbe_driver_name[] = "txgbe";
 static const struct pci_device_id txgbe_pci_tbl[] = {
 	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_SP1000), 0},
 	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_WX1820), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5010), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5110), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5025), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5125), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5040), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBE_DEV_ID_AML5140), 0},
 	/* required last entry */
 	{ .device = 0 }
 };
@@ -90,7 +96,18 @@ static void txgbe_up_complete(struct wx *wx)
 	smp_mb__before_atomic();
 	wx_napi_enable_all(wx);
 
-	phylink_start(wx->phylink);
+	if (wx->mac.type == wx_mac_aml) {
+		u32 reg;
+
+		reg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
+		reg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
+		reg |= TXGBE_AML_MAC_TX_CFG_SPEED_25G;
+		wr32(wx, WX_MAC_TX_CFG, reg);
+		txgbe_enable_sec_tx_path(wx);
+		netif_carrier_on(wx->netdev);
+	} else {
+		phylink_start(wx->phylink);
+	}
 
 	/* clear any pending interrupts, may auto mask */
 	rd32(wx, WX_PX_IC(0));
@@ -171,7 +188,10 @@ void txgbe_down(struct wx *wx)
 {
 	txgbe_disable_device(wx);
 	txgbe_reset(wx);
-	phylink_stop(wx->phylink);
+	if (wx->mac.type == wx_mac_aml)
+		netif_carrier_off(wx->netdev);
+	else
+		phylink_stop(wx->phylink);
 
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
@@ -197,6 +217,14 @@ static void txgbe_init_type_code(struct wx *wx)
 	case TXGBE_DEV_ID_WX1820:
 		wx->mac.type = wx_mac_sp;
 		break;
+	case TXGBE_DEV_ID_AML5010:
+	case TXGBE_DEV_ID_AML5110:
+	case TXGBE_DEV_ID_AML5025:
+	case TXGBE_DEV_ID_AML5125:
+	case TXGBE_DEV_ID_AML5040:
+	case TXGBE_DEV_ID_AML5140:
+		wx->mac.type = wx_mac_aml;
+		break;
 	default:
 		wx->mac.type = wx_mac_unknown;
 		break;
@@ -284,6 +312,17 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->do_reset = txgbe_do_reset;
 
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+		break;
+	case wx_mac_aml:
+		set_bit(WX_FLAG_SWFW_RING, wx->flags);
+		wx->swfw_index = 0;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 7e17d727c2ba..85f022ceef4f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -567,6 +567,9 @@ int txgbe_init_phy(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int ret;
 
+	if (wx->mac.type == wx_mac_aml)
+		return 0;
+
 	if (txgbe->wx->media_type == sp_media_copper)
 		return txgbe_ext_phy_init(txgbe);
 
@@ -631,6 +634,9 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
+	if (txgbe->wx->mac.type == wx_mac_aml)
+		return;
+
 	if (txgbe->wx->media_type == sp_media_copper) {
 		phylink_disconnect_phy(txgbe->wx->phylink);
 		phylink_destroy(txgbe->wx->phylink);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 629a13e96b85..9c1c26234cad 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -10,6 +10,12 @@
 /* Device IDs */
 #define TXGBE_DEV_ID_SP1000                     0x1001
 #define TXGBE_DEV_ID_WX1820                     0x2001
+#define TXGBE_DEV_ID_AML5010                    0x5010
+#define TXGBE_DEV_ID_AML5110                    0x5110
+#define TXGBE_DEV_ID_AML5025                    0x5025
+#define TXGBE_DEV_ID_AML5125                    0x5125
+#define TXGBE_DEV_ID_AML5040                    0x5040
+#define TXGBE_DEV_ID_AML5140                    0x5140
 
 /* Subsystem IDs */
 /* SFP */
@@ -137,6 +143,14 @@
 #define TXGBE_RDB_FDIR_FLEX_CFG_MSK             BIT(2)
 #define TXGBE_RDB_FDIR_FLEX_CFG_OFST(v)         FIELD_PREP(GENMASK(7, 3), v)
 
+/*************************** Amber Lite Registers ****************************/
+#define TXGBE_PX_PF_BME                         0x4B8
+#define TXGBE_AML_MAC_TX_CFG                    0x11000
+#define TXGBE_AML_MAC_TX_CFG_SPEED_MASK         GENMASK(30, 27)
+#define TXGBE_AML_MAC_TX_CFG_SPEED_25G          BIT(28)
+#define TXGBE_RDM_RSC_CTL                       0x1200C
+#define TXGBE_RDM_RSC_CTL_FREE_CTL              BIT(7)
+
 /* Checksum and EEPROM pointers */
 #define TXGBE_EEPROM_LAST_WORD                  0x800
 #define TXGBE_EEPROM_CHECKSUM                   0x2F
-- 
2.27.0


