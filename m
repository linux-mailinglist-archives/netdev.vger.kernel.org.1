Return-Path: <netdev+bounces-157702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76EA0B43C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D8F3A8C04
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE821ADA1;
	Mon, 13 Jan 2025 10:12:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02707235C07
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763134; cv=none; b=pChU+EXAjwZmWSwtpuU8LiYpEst6+33TcwJrpzCuSYO4IOZtHZLTnztWYAbo+n1IWbucQ194lo3R1O0ABxnQOyJjPvL4MizNaRqOHbkX/XA1dPEl76+H8Mn+nLM8dLjm2IeTTz00s0qL6O07JaLQpFW4DnPsmAk6o9rEXSnEzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763134; c=relaxed/simple;
	bh=f3Wdyn2C1ucRmxTJgXsW7LCChcN9zCo7N1LT0z4mPsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fyaxmoh/w1l2jQdW8UiF/xcerymZfUr+VBCvENm5aF17IEiwuYP9yib0KvmgXmAwwDBLIPUdNdHmxioJSlpTlHHU7PUIexC2XxOSE5OEskkHZaZUB2bRLSIcw2/AF9Klil1vyMEkBRyOlAAavGOB5u3Cco0qUWiLi7AOp4glG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1736763023tjl8u0
X-QQ-Originating-IP: c8qON7bzQmpEP0E6kfNUnubd5OAyj/LfzGiLU4P4YxY=
Received: from wxdbg.localdomain.com ( [36.20.58.48])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jan 2025 18:10:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5396714508328147714
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 1/2] net: txgbe: Add basic support for new AML devices
Date: Mon, 13 Jan 2025 18:31:01 +0800
Message-Id: <20250113103102.2185782-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M0wYV6TTeeWi88/ZoW7ZNkvYU0RBa9iaeeIi2gJ/xhOBOiLY61FnnGwz
	XDthSi1W4UeS+ah+CVr2v9XJqDeAE9NNQUxsgQfAieTkxVQrawixQFIqgiMOtf6Rr7YA6l3
	QNk0muFQB/USCR3N9+4ZYry6uijk6wWMek1tqT3KU7FBc990SBELo2USbc4eKJJ6GVxIGgY
	fF++6ncQaewrcgN/csqyWIHBXutQNRbOuskVDUcfzSzQ6WIPOj9OiaT1LsI0dqrwZNFdjbs
	zgzjhR7CN66IIDxmEq0ACQ3Xi4diArhBL0/zKdE2E4edx62ZCNXwLRXgL+35DYQSLCSXOwV
	30ZLSY2f70nKi2OTZMtnZ4SAqB/831YspTsL+ctF2ibBoi3BXDp3g2Ko5ebEYQiSk/gF93h
	7d9oQokkDTb6DytJuETXvIOSwD9TAhraq+A7imd8pEr94f5/piLZBTuPBgz5lJI/E7HfQEK
	mfNLIva1fK09w4tH9SEcCqPwN+Ce+djDlV4SKR11MSaZJdHF50MaOW9wuh1U6foSWAAWcwN
	oM6AnIxfoNLJKOplP03kYYnXoj5G/tLXxgn0KMZmOAPDXoJzyEuVPx1TywY1Fb99sNLbMBe
	9hb3SPmCFv7awEAnlBNp5uEA8HM7hfIruHqUH6jzkbf0Y41ExX8Ozfxnz87vTfumYy7tI1p
	FzaoM3zFdp8KA+x1vRgH+pfvyziPtoEqTYMJ/cvZxesBGUa0Dmm0VDyZ2gGpStw6uYKyUcl
	/J0/mny8z6iqGcFbkX1wkeOs/bEytUCgjxp72Y0ROVneiJ5Ah7Xn0ErKk4a4QSPjeKjafAA
	Kw4yEn50H0J6mXF7nhnRaL/7hChsYx4fijgvbIPhWIoj7F2RjZecm56dHlxzanP3QWrFC8j
	G5R4/pm784S9zZKjnCwm9chwgSRQ6Fc1hWYZzfggJtvFuQ2DMOpTmENAceyhu2csFyGnysO
	UQrcnOagxgpP+iKE9XvLTdEXOfPRhvOdQi88AxqhZ74bsnLO+rwsZ8Dud
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

There is a new 40/25/10 Gigabit Ethernet device.

To support basic functions, PHYLINK is temporarily skipped as it is
intended to implement these configurations in the firmware. And the
associated link IRQ is also skipped.

And Implement the new SW-FW interaction interface, which use 64 Byte
message buffer.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
Changes in v2:
- Add missing 40G devide IDs
- Add condition for wx->do_reset != NULL
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  44 +++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 209 +++++++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  25 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  27 ++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   6 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  43 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   6 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  14 ++
 9 files changed, 328 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index abe5921dde02..f6b1323e606b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -216,6 +216,9 @@ int wx_nway_reset(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_nway_reset(wx->phylink);
 }
 EXPORT_SYMBOL(wx_nway_reset);
@@ -225,6 +228,9 @@ int wx_get_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_get_link_ksettings);
@@ -234,6 +240,9 @@ int wx_set_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_set_link_ksettings);
@@ -243,6 +252,9 @@ void wx_get_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return;
+
 	phylink_ethtool_get_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_get_pauseparam);
@@ -252,6 +264,9 @@ int wx_set_pauseparam(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_aml)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_set_pauseparam);
@@ -322,10 +337,17 @@ int wx_set_coalesce(struct net_device *netdev,
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
@@ -347,10 +369,15 @@ int wx_set_coalesce(struct net_device *netdev,
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
@@ -383,10 +410,15 @@ static unsigned int wx_max_channels(struct wx *wx)
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
index deaf670c160e..ff39722da98d 100644
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
@@ -391,6 +376,135 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 	wx_release_sw_sync(wx, WX_MNG_SWFW_SYNC_SW_MB);
 	return status;
 }
+
+static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
+				       u32 length, u32 timeout, bool return_data)
+{
+	struct wx_hic_hdr *send_hdr = (struct wx_hic_hdr *)buffer;
+	u32 hdr_size = sizeof(struct wx_hic_hdr);
+	struct wx_hic_hdr *recv_hdr;
+	int status = 0;
+	u32 dword_len;
+	u16 buf_len;
+	u8 send_cmd;
+	u32 i, bi;
+
+	/* wait max to 50ms to get lock */
+	WARN_ON(in_interrupt());
+	while (test_and_set_bit(WX_STATE_SWFW_BUSY, wx->state)) {
+		timeout--;
+		if (!timeout)
+			return -ETIMEDOUT;
+		usleep_range(1000, 2000);
+	}
+
+	/* index to unique seq id for each mbox message */
+	send_hdr->index = wx->swfw_index;
+	send_cmd = send_hdr->cmd;
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
+	dword_len = hdr_size >> 2;
+
+	/* polling reply from FW */
+	timeout = 50;
+	do {
+		timeout--;
+		usleep_range(1000, 2000);
+
+		/* read hdr */
+		for (bi = 0; bi < dword_len; bi++)
+			buffer[bi] = rd32a(wx, WX_FW2SW_MBOX, bi);
+
+		/* check hdr */
+		recv_hdr = (struct wx_hic_hdr *)buffer;
+		if (recv_hdr->cmd == send_cmd &&
+		    recv_hdr->index == wx->swfw_index)
+			break;
+	} while (timeout);
+
+	if (!timeout) {
+		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
+		       send_cmd, wx->swfw_index);
+		status = -ETIMEDOUT;
+		goto rel_out;
+	}
+
+	/* expect no reply from FW then return */
+	if (!return_data)
+		goto rel_out;
+
+	/* If there is any thing in data position pull it in */
+	buf_len = recv_hdr->buf_len;
+	if (buf_len == 0)
+		goto rel_out;
+
+	if (length < buf_len + hdr_size) {
+		wx_err(wx, "Buffer not large enough for reply message.\n");
+		status = -EFAULT;
+		goto rel_out;
+	}
+
+	/* Calculate length in DWORDs, add 3 for odd lengths */
+	dword_len = (buf_len + 3) >> 2;
+	for (; bi <= dword_len; bi++)
+		buffer[bi] = rd32a(wx, WX_FW2SW_MBOX, bi);
+
+rel_out:
+	/* index++, index replace wx_hic_hdr.checksum */
+	if (send_hdr->index == WX_HIC_HDR_INDEX_MAX)
+		wx->swfw_index = 0;
+	else
+		wx->swfw_index = send_hdr->index + 1;
+
+	clear_bit(WX_STATE_SWFW_BUSY, wx->state);
+	return status;
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
 
 /**
@@ -423,7 +537,10 @@ static int wx_read_ee_hostif_data(struct wx *wx, u16 offset, u16 *data)
 	if (status != 0)
 		return status;
 
-	*data = (u16)rd32a(wx, WX_MNG_MBOX, FW_NVM_DATA_OFFSET);
+	if (!test_bit(WX_FLAG_SWFW_RING, wx->flags))
+		*data = (u16)rd32a(wx, WX_MNG_MBOX, FW_NVM_DATA_OFFSET);
+	else
+		*data = (u16)rd32a(wx, WX_FW2SW_MBOX, FW_NVM_DATA_OFFSET);
 
 	return status;
 }
@@ -467,6 +584,7 @@ int wx_read_ee_hostif_buffer(struct wx *wx,
 	u16 words_to_read;
 	u32 value = 0;
 	int status;
+	u32 mbox;
 	u32 i;
 
 	/* Take semaphore for the entire operation. */
@@ -499,8 +617,12 @@ int wx_read_ee_hostif_buffer(struct wx *wx,
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
@@ -550,12 +672,17 @@ void wx_init_eeprom_params(struct wx *wx)
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
@@ -616,8 +743,15 @@ static int wx_set_rar(struct wx *wx, u32 index, u8 *addr, u64 pools,
 
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
@@ -755,9 +889,14 @@ void wx_init_rx_addrs(struct wx *wx)
 
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
index 2b3d6586f44a..e12ea4215160 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1781,10 +1781,16 @@ static int wx_alloc_q_vector(struct wx *wx,
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
@@ -2140,10 +2146,17 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
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
 
@@ -2719,7 +2732,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 	netdev->features = features;
 
-	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX && wx->do_reset)
 		wx->do_reset(netdev);
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
@@ -2751,7 +2764,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 		break;
 	}
 
-	if (need_reset)
+	if (need_reset && wx->do_reset)
 		wx->do_reset(netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..2969af0dbb57 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -264,6 +264,10 @@
 #define WX_MNG_MBOX_CTL_FWRDY        BIT(2)
 #define WX_MNG_BMC2OS_CNT            0x1E090
 #define WX_MNG_OS2BMC_CNT            0x1E094
+#define WX_SW2FW_MBOX_CMD            0x1E0A0
+#define WX_SW2FW_MBOX_CMD_VLD        BIT(31)
+#define WX_SW2FW_MBOX                0x1E200
+#define WX_FW2SW_MBOX                0x1E300
 
 /************************************* ETH MAC *****************************/
 #define WX_MAC_TX_CFG                0x11000
@@ -327,6 +331,7 @@ enum WX_MSCA_CMD_value {
 #define WX_12K_ITR                   336
 #define WX_20K_ITR                   200
 #define WX_SP_MAX_EITR               0x00000FF8U
+#define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
 
 /* transmit DMA Registers */
@@ -370,6 +375,7 @@ enum WX_MSCA_CMD_value {
 /****************** Manageablility Host Interface defines ********************/
 #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
 #define WX_HI_COMMAND_TIMEOUT        1000 /* Process HI command limit */
+#define WX_HIC_HDR_INDEX_MAX         255
 
 #define FW_READ_SHADOW_RAM_CMD       0x31
 #define FW_READ_SHADOW_RAM_LEN       0x6
@@ -663,21 +669,30 @@ struct wx_hic_hdr {
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
@@ -716,7 +731,8 @@ struct wx_thermal_sensor_data {
 enum wx_mac_type {
 	wx_mac_unknown = 0,
 	wx_mac_sp,
-	wx_mac_em
+	wx_mac_em,
+	wx_mac_aml
 };
 
 enum sp_media_type {
@@ -1026,10 +1042,12 @@ struct wx_hw_stats {
 
 enum wx_state {
 	WX_STATE_RESETTING,
+	WX_STATE_SWFW_BUSY,
 	WX_STATE_NBITS,		/* must be last */
 };
 
 enum wx_pf_flags {
+	WX_FLAG_SWFW_RING,
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
@@ -1066,6 +1084,7 @@ struct wx {
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
index f77450268036..ffe42b77de3e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -34,6 +34,12 @@ char txgbe_driver_name[] = "txgbe";
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
@@ -89,7 +95,18 @@ static void txgbe_up_complete(struct wx *wx)
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
@@ -167,7 +184,10 @@ void txgbe_down(struct wx *wx)
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
@@ -192,6 +212,14 @@ static void txgbe_init_type_code(struct wx *wx)
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
@@ -279,6 +307,17 @@ static int txgbe_sw_init(struct wx *wx)
 
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
index 1ae68f94dd49..41c86249c339 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -557,6 +557,9 @@ int txgbe_init_phy(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int ret;
 
+	if (wx->mac.type == wx_mac_aml)
+		return 0;
+
 	if (txgbe->wx->media_type == sp_media_copper)
 		return txgbe_ext_phy_init(txgbe);
 
@@ -621,6 +624,9 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
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


