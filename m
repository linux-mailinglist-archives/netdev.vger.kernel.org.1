Return-Path: <netdev+bounces-156944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB4A085B7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B33A9E6C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BE194A60;
	Fri, 10 Jan 2025 02:56:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7A1E0DF6
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477815; cv=none; b=pypnVoDXgC2+03+dGm6YXowQE46mr6YUlyBZJsAZaXurx+fyeKUywZurndNcTB/mvigRXywWtFuwgP9zvrkF4pAlFOCSs5fd3fQtGulqjmQrllLRvdftDCJZPp3sMDr88y51zW+Ndbde5lMMbAHHgk8EjzdMwJD7wlUZIpvUZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477815; c=relaxed/simple;
	bh=XtqN8KH1Zrv+SSg2VYxO4PVYuLe5PgtSJsHCjuTlVX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhqgMyBoHXKLyzjETE2Ft0y4ZYsTuRsWAFDM9T03fkhBGvcZfxQ7LCJb8wxVNW5nDQNkmBw3niWrNjwWdrU+2SC3uDAsUHVUpzUbddDhL0mG9x+WMkJ73FTDR8K3i/nMHgeKByDG34j5tLEKWMYtrf5Pps65SQK5f0kduRVZS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz4t1736477800tglar0g
X-QQ-Originating-IP: odYCrgGKC8xSEn1apOy6qyENCQJzHBt0gNfQ/8BfpTE=
Received: from wxdbg.localdomain.com ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 10:56:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15688038105177150820
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Date: Fri, 10 Jan 2025 11:17:16 +0800
Message-Id: <20250110031716.2120642-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OST2d686M2k24v8Aa2G9jRupNe6hNLGaw4Ssu3H+1d9kNLj86U6RW5Ai
	+H65Beyya2sP9zbPvhODPiWVRKZManYlvDA9P4r0J+0sT1HNyovaO0wYg050og9C7OzrN1g
	mA0YQECTSde/w8wJVMJcJu5ZVih1MpD7W6Y4bVoFJ9jlSDAMFx0UywiHYwVhSFStmU7CCQ3
	5Y6bBUJi9R1tA8Fh4E67NfGouF0ORjfJIp2ToMgaPFxykJIPoPHf5JvYebNSmFRKFKLwnHN
	PEMH8PKI9kSK3LaA5bi6pZcXsjyzyYw4FMcbeVeJJQdSRbzOrNGEwdfKpwtT7Fs4wVHYSGP
	jWDj1Ni96QHDMLw+SrXL/KNABlv0CAEw6Z94wnl9J6mMT61YwzRJuosA3/nlvi4DGN/vpv3
	J3+UDT7FjyG7qp84/FrXhYkj/jk9YcLuVhuiz6F1DbINlf+a/O0B/hHaHgid+ctP35ij+bA
	UjupAMAAEejM+3/dP2RxuRPNJsxqPgGzOX9RUxKjfv0ZwZI8syRSwlv6VbCLLdrtUFyzS/L
	SAmI8ERuNXHZoj9XStqRl82N/so8xAAEt8u362GTKHBdnPPn1SrwnyujUMAcAh3Z01FDG4o
	R8LiFxPtLptydPVQTlu5gHZklwhdefb6fexNf4O7Y+oI4WjoUKM7FWSl+8OH939PS2EC13b
	1H0U0sxSjqSTNnCgas8uyr9vurrPHxrJ1A4VgUZd8aB7n/QJb3MlYnhNoHAXafbrPDLdsDl
	8QyD6FtIf7LXEA5Zf49yV7dldJjaK1uKohzl5B6wNYP23kk0ZU8P4mBoNksOPrILuGLCXYi
	xqOtf/BnO5nYHo1qGuJAlw/uU19/dEhHw0ZthqouhVJbvZ/wPDEy3o3iMSqcFLf2SqYS8yy
	qV2dwmsBEJbKv/KV/Sw53f6+FThhL6ytynNCXjj2swlRWCRS6aQUz0DR62DBRwMzw8+asO3
	x6bhNZEt7Z8FC5rWu6bmHRIP6BJTAmdOLMGmle9oMULUbuFqN3HAdGCvJTEyrN1gwcOU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Implement support for generating a 1pps output signal on SDP0.
And support custom firmware to output TOD.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  19 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 217 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  35 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  12 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   5 +
 7 files changed, 286 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1bf9c38e4125..6ba69e41faa6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -395,6 +395,25 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
 }
 EXPORT_SYMBOL(wx_host_interface_command);
 
+int wx_set_pps(struct wx *wx, bool enable, u64 nsec, u64 cycles)
+{
+	struct wx_hic_set_pps pps_cmd;
+
+	pps_cmd.hdr.cmd = FW_PPS_SET_CMD;
+	pps_cmd.hdr.buf_len = FW_PPS_SET_LEN;
+	pps_cmd.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+	pps_cmd.lan_id = wx->bus.func;
+	pps_cmd.enable = (u8)enable;
+	pps_cmd.nsec = nsec;
+	pps_cmd.cycles = cycles;
+	pps_cmd.hdr.checksum = FW_DEFAULT_CHECKSUM;
+
+	return wx_host_interface_command(wx, (u32 *)&pps_cmd,
+					 sizeof(pps_cmd),
+					 WX_HI_COMMAND_TIMEOUT,
+					 false);
+}
+
 /**
  *  wx_read_ee_hostif_data - Read EEPROM word using a host interface cmd
  *  assuming that the semaphore is already obtained.
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 11fb33349482..b883342bb576 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -18,6 +18,7 @@ void wx_control_hw(struct wx *wx, bool drv);
 int wx_mng_present(struct wx *wx);
 int wx_host_interface_command(struct wx *wx, u32 *buffer,
 			      u32 length, u32 timeout, bool return_data);
+int wx_set_pps(struct wx *wx, bool enable, u64 nsec, u64 cycles);
 int wx_read_ee_hostif(struct wx *wx, u16 offset, u16 *data);
 int wx_read_ee_hostif_buffer(struct wx *wx,
 			     u16 offset, u16 words, u16 *data);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index e7dc9196ba54..0155c7f02f5f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -73,6 +73,9 @@ static int wx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	timecounter_adjtime(&wx->hw_tc, delta);
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
 
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	return 0;
 }
 
@@ -132,6 +135,9 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
 	timecounter_init(&wx->hw_tc, &wx->hw_cc, ns);
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
 
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	return 0;
 }
 
@@ -361,6 +367,196 @@ static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 	return HZ;
 }
 
+static void wx_ptp_setup_sdp(struct wx *wx)
+{
+	struct cyclecounter *cc = &wx->hw_cc;
+	u32 tsauxc, rem, tssdp, tssdp1;
+	u32 trgttiml0, trgttimh0;
+	u32 trgttiml1, trgttimh1;
+	unsigned long flags;
+	u64 ns = 0;
+
+	if (wx->pps_width >= WX_NS_PER_SEC) {
+		wx_err(wx, "PTP pps width cannot be longer than 1s!\n");
+		return;
+	}
+
+	/* disable the pin first */
+	wr32ptp(wx, WX_TSC_1588_AUX_CTL, 0);
+	WX_WRITE_FLUSH(wx);
+
+	if (!test_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags)) {
+		if (wx->pps_enabled) {
+			wx->pps_enabled = false;
+			wx_set_pps(wx, false, 0, 0);
+		}
+		return;
+	}
+
+	wx->pps_enabled = true;
+
+	tssdp = WX_TSC_1588_SDP_FUN_SEL_TT0;
+	tssdp |= WX_TSC_1588_SDP_OUT_LEVEL_H;
+	tssdp1 = WX_TSC_1588_SDP_FUN_SEL_TS0;
+	tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
+		WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
+
+	/* Read the current clock time, and save the cycle counter value */
+	spin_lock_irqsave(&wx->tmreg_lock, flags);
+	ns = timecounter_read(&wx->hw_tc);
+	wx->pps_edge_start = wx->hw_tc.cycle_last;
+	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
+	wx->pps_edge_end = wx->pps_edge_start;
+
+	/* Figure out how far past the next second we are */
+	div_u64_rem(ns, WX_NS_PER_SEC, &rem);
+
+	/* Figure out how many nanoseconds to add to round the clock edge up
+	 * to the next full second
+	 */
+	rem = (WX_NS_PER_SEC - rem);
+
+	/* Adjust the clock edge to align with the next full second. */
+	wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
+	trgttiml0 = (u32)wx->pps_edge_start;
+	trgttimh0 = (u32)(wx->pps_edge_start >> 32);
+
+	wx_set_pps(wx, wx->pps_enabled, ns + rem, wx->pps_edge_start);
+
+	rem += wx->pps_width;
+	wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
+	trgttiml1 = (u32)wx->pps_edge_end;
+	trgttimh1 = (u32)(wx->pps_edge_end >> 32);
+
+	wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
+	wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
+	wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
+	wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
+	wr32ptp(wx, WX_TSC_1588_SDP(0), tssdp);
+	wr32ptp(wx, WX_TSC_1588_SDP(1), tssdp1);
+	wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
+	wr32ptp(wx, WX_TSC_1588_INT_EN, WX_TSC_1588_INT_EN_TT1);
+	WX_WRITE_FLUSH(wx);
+
+	rem = WX_NS_PER_SEC;
+	/* Adjust the clock edge to align with the next full second. */
+	wx->sec_to_cc = div_u64(((u64)rem << cc->shift), cc->mult);
+}
+
+/**
+ * wx_ptp_feature_enable
+ * @ptp: the ptp clock structure
+ * @rq: the requested feature to change
+ * @on: whether to enable or disable the feature
+ *
+ * enable (or disable) ancillary features of the phc subsystem.
+ */
+static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
+				 struct ptp_clock_request *rq, int on)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+
+	/**
+	 * When PPS is enabled, unmask the interrupt for the ClockOut
+	 * feature, so that the interrupt handler can send the PPS
+	 * event when the clock SDP triggers. Clear mask when PPS is
+	 * disabled
+	 */
+	if (rq->type != PTP_CLK_REQ_PEROUT || !wx->ptp_setup_sdp)
+		return -EOPNOTSUPP;
+
+	/* Reject requests with unsupported flags */
+	if (rq->perout.flags & ~PTP_PEROUT_PHASE)
+		return -EOPNOTSUPP;
+
+	if (rq->perout.index != 0) {
+		wx_err(wx, "Perout index must be 0\n");
+		return -EINVAL;
+	}
+
+	if (rq->perout.phase.sec || rq->perout.phase.nsec) {
+		wx_err(wx, "Absolute start time not supported.\n");
+		return -EINVAL;
+	}
+
+	if (on)
+		set_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+	else
+		clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+
+	wx->pps_width = rq->perout.period.nsec;
+	wx->ptp_setup_sdp(wx);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_check_pps_event
+ * @wx: the private wx structure
+ *
+ * This function is called by the interrupt routine when checking for
+ * interrupts. It will check and handle a pps event.
+ */
+void wx_ptp_check_pps_event(struct wx *wx)
+{
+	struct cyclecounter *cc = &wx->hw_cc;
+	u32 tsauxc, rem, int_status;
+	u32 trgttiml0, trgttimh0;
+	u32 trgttiml1, trgttimh1;
+	unsigned long flags;
+	u64 ns = 0;
+
+	/* this check is necessary in case the interrupt was enabled via some
+	 * alternative means (ex. debug_fs). Better to check here than
+	 * everywhere that calls this function.
+	 */
+	if (!wx->ptp_clock)
+		return;
+
+	int_status = rd32ptp(wx, WX_TSC_1588_INT_ST);
+	if (int_status & WX_TSC_1588_INT_ST_TT1) {
+		/* disable the pin first */
+		wr32ptp(wx, WX_TSC_1588_AUX_CTL, 0);
+		WX_WRITE_FLUSH(wx);
+
+		tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
+			 WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
+
+		/* Read the current clock time, and save the cycle counter value */
+		spin_lock_irqsave(&wx->tmreg_lock, flags);
+		ns = timecounter_read(&wx->hw_tc);
+		wx->pps_edge_start = wx->hw_tc.cycle_last;
+		spin_unlock_irqrestore(&wx->tmreg_lock, flags);
+		wx->pps_edge_end = wx->pps_edge_start;
+
+		/* Figure out how far past the next second we are */
+		div_u64_rem(ns, WX_NS_PER_SEC, &rem);
+
+		/* Figure out how many nanoseconds to add to round the clock edge up
+		 * to the next full second
+		 */
+		rem = (WX_NS_PER_SEC - rem);
+
+		/* Adjust the clock edge to align with the next full second. */
+		wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
+		trgttiml0 = (u32)wx->pps_edge_start;
+		trgttimh0 = (u32)(wx->pps_edge_start >> 32);
+
+		rem += wx->pps_width;
+		wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
+		trgttiml1 = (u32)wx->pps_edge_end;
+		trgttimh1 = (u32)(wx->pps_edge_end >> 32);
+
+		wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
+		wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
+		wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
+		wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
+		wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
+		WX_WRITE_FLUSH(wx);
+	}
+}
+EXPORT_SYMBOL(wx_ptp_check_pps_event);
+
 /**
  * wx_ptp_create_clock
  * @wx: the private board structure
@@ -387,17 +583,22 @@ static long wx_ptp_create_clock(struct wx *wx)
 	wx->ptp_caps.owner = THIS_MODULE;
 	wx->ptp_caps.n_alarm = 0;
 	wx->ptp_caps.n_ext_ts = 0;
-	wx->ptp_caps.n_per_out = 0;
 	wx->ptp_caps.pps = 0;
 	wx->ptp_caps.adjfine = wx_ptp_adjfine;
 	wx->ptp_caps.adjtime = wx_ptp_adjtime;
 	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
 	wx->ptp_caps.settime64 = wx_ptp_settime64;
 	wx->ptp_caps.do_aux_work = wx_ptp_do_aux_work;
-	if (wx->mac.type == wx_mac_em)
+	if (wx->mac.type == wx_mac_em) {
 		wx->ptp_caps.max_adj = 500000000;
-	else
+		wx->ptp_caps.n_per_out = 1;
+		wx->ptp_setup_sdp = wx_ptp_setup_sdp;
+		wx->ptp_caps.enable = wx_ptp_feature_enable;
+	} else {
 		wx->ptp_caps.max_adj = 250000000;
+		wx->ptp_caps.n_per_out = 0;
+		wx->ptp_setup_sdp = NULL;
+	}
 
 	wx->ptp_clock = ptp_clock_register(&wx->ptp_caps, &wx->pdev->dev);
 	if (IS_ERR(wx->ptp_clock)) {
@@ -681,6 +882,12 @@ void wx_ptp_reset(struct wx *wx)
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
 
 	wx->last_overflow_check = jiffies;
+
+	/* Now that the shift has been calculated and the systime
+	 * registers reset, (re-)enable the Clock out feature
+	 */
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
 }
 EXPORT_SYMBOL(wx_ptp_reset);
 
@@ -731,6 +938,10 @@ void wx_ptp_suspend(struct wx *wx)
 	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
 		return;
 
+	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	cancel_work_sync(&wx->ptp_tx_work);
 	wx_ptp_clear_tx_timestamp(wx);
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
index 8742d2797363..50db90a6e3ee 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
@@ -4,6 +4,7 @@
 #ifndef _WX_PTP_H_
 #define _WX_PTP_H_
 
+void wx_ptp_check_pps_event(struct wx *wx);
 void wx_ptp_reset_cyclecounter(struct wx *wx);
 void wx_ptp_reset(struct wx *wx);
 void wx_ptp_init(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 867d92547b61..128dbe742e43 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -281,6 +281,23 @@
 #define WX_TSC_1588_SYSTIML          0x11F0C
 #define WX_TSC_1588_SYSTIMH          0x11F10
 #define WX_TSC_1588_INC              0x11F14
+#define WX_TSC_1588_INT_ST           0x11F20
+#define WX_TSC_1588_INT_ST_TT1       BIT(5)
+#define WX_TSC_1588_INT_EN           0x11F24
+#define WX_TSC_1588_INT_EN_TT1       BIT(5)
+#define WX_TSC_1588_AUX_CTL          0x11F28
+#define WX_TSC_1588_AUX_CTL_EN_TS0   BIT(8)
+#define WX_TSC_1588_AUX_CTL_EN_TT1   BIT(2)
+#define WX_TSC_1588_AUX_CTL_PLSG     BIT(1)
+#define WX_TSC_1588_AUX_CTL_EN_TT0   BIT(0)
+#define WX_TSC_1588_TRGT_L(i)        (0x11F2C + ((i) * 8)) /* [0,1] */
+#define WX_TSC_1588_TRGT_H(i)        (0x11F30 + ((i) * 8)) /* [0,1] */
+#define WX_TSC_1588_SDP(i)           (0x11F5C + ((i) * 4)) /* [0,3] */
+#define WX_TSC_1588_SDP_OUT_LEVEL_H  FIELD_PREP(BIT(4), 0)
+#define WX_TSC_1588_SDP_OUT_LEVEL_L  FIELD_PREP(BIT(4), 1)
+#define WX_TSC_1588_SDP_FUN_SEL_MASK GENMASK(2, 0)
+#define WX_TSC_1588_SDP_FUN_SEL_TT0  FIELD_PREP(WX_TSC_1588_SDP_FUN_SEL_MASK, 1)
+#define WX_TSC_1588_SDP_FUN_SEL_TS0  FIELD_PREP(WX_TSC_1588_SDP_FUN_SEL_MASK, 5)
 
 /************************************** MNG ********************************/
 #define WX_MNG_SWFW_SYNC             0x1E008
@@ -410,6 +427,8 @@ enum WX_MSCA_CMD_value {
 #define FW_CEM_CMD_RESERVED          0X0
 #define FW_CEM_MAX_RETRIES           3
 #define FW_CEM_RESP_STATUS_SUCCESS   0x1
+#define FW_PPS_SET_CMD               0xF6
+#define FW_PPS_SET_LEN               0x14
 
 #define WX_SW_REGION_PTR             0x1C
 
@@ -730,6 +749,15 @@ struct wx_hic_reset {
 	u16 reset_type;
 };
 
+struct wx_hic_set_pps {
+	struct wx_hic_hdr hdr;
+	u8 lan_id;
+	u8 enable;
+	u16 pad2;
+	u64 nsec;
+	u64 cycles;
+};
+
 /* Bus parameters */
 struct wx_bus_info {
 	u8 func;
@@ -1068,6 +1096,7 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_PERFECT,
 	WX_FLAG_RX_HWTSTAMP_ENABLED,
 	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
+	WX_FLAG_PTP_PPS_ENABLED,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1168,7 +1197,13 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	void (*do_reset)(struct net_device *netdev);
+	void (*ptp_setup_sdp)(struct wx *wx);
 
+	bool pps_enabled;
+	u64 pps_width;
+	u64 pps_edge_start;
+	u64 pps_edge_end;
+	u64 sec_to_cc;
 	u32 base_incval;
 	u32 tx_hwtstamp_pkts;
 	u32 tx_hwtstamp_timeouts;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index c60a96cc3508..a6159214ec0a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -168,7 +168,7 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 	struct wx_q_vector *q_vector;
 	struct wx *wx  = data;
 	struct pci_dev *pdev;
-	u32 eicr;
+	u32 eicr, eicr_misc;
 
 	q_vector = wx->q_vector[0];
 	pdev = wx->pdev;
@@ -186,6 +186,10 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 	if (!(pdev->msi_enabled))
 		wr32(wx, WX_PX_INTA, 1);
 
+	eicr_misc = wx_misc_isb(wx, WX_ISB_MISC);
+	if (unlikely(eicr_misc & NGBE_PX_MISC_IC_TIMESYNC))
+		wx_ptp_check_pps_event(wx);
+
 	wx->isb_mem[WX_ISB_MISC] = 0;
 	/* would disable interrupts here but it is auto disabled */
 	napi_schedule_irqoff(&q_vector->napi);
@@ -199,6 +203,12 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
 {
 	struct wx *wx = data;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+
+	if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
+		wx_ptp_check_pps_event(wx);
 
 	/* re-enable the original interrupt state, no lsc, no queues */
 	if (netif_running(wx->netdev))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index f48ed7fc1805..992adbb98c7d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -70,15 +70,20 @@
 
 /* Extended Interrupt Enable Set */
 #define NGBE_PX_MISC_IEN_DEV_RST		BIT(10)
+#define NGBE_PX_MISC_IEN_TIMESYNC		BIT(11)
 #define NGBE_PX_MISC_IEN_ETH_LK			BIT(18)
 #define NGBE_PX_MISC_IEN_INT_ERR		BIT(20)
 #define NGBE_PX_MISC_IEN_GPIO			BIT(26)
 #define NGBE_PX_MISC_IEN_MASK ( \
 				NGBE_PX_MISC_IEN_DEV_RST | \
+				NGBE_PX_MISC_IEN_TIMESYNC | \
 				NGBE_PX_MISC_IEN_ETH_LK | \
 				NGBE_PX_MISC_IEN_INT_ERR | \
 				NGBE_PX_MISC_IEN_GPIO)
 
+/* Extended Interrupt Cause Read */
+#define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
+
 #define NGBE_INTR_ALL				0x1FF
 #define NGBE_INTR_MISC				BIT(0)
 
-- 
2.27.0


