Return-Path: <netdev+bounces-164277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D24A2D33E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E50D7A50E4
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270863E499;
	Sat,  8 Feb 2025 02:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D21531F9
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738982922; cv=none; b=cC5nwwHOWocYhi5XtE0u3QZ/+4OQNri5TA0ouboY5v/VFDdglYBcYUfjv2n7FK/hDLxb1z9vKqDPeigrNadVqPoOpjImerIIWuap5RfUqwHsItPANU03CRDMWsuAJEYipZkfO0Zmz4LYlGtCNui95Eqvm8Xs3kcL8IzQKTDVHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738982922; c=relaxed/simple;
	bh=JK0is7ZkEKCHgK+L/rSsDYKm2YmkQ13Q8xK3VGG5C0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDpNEIzKp56RbXyUdedun3yPhXMJxFWNuBIBifgE91c/u07lrQLEsLFJ/KIsmdnLqmoJbjRyqks0iBohrwDJryQHPielXc7cVQnQRqMd/y/2wpm8RPBydq2LM+vdMLufc9MFskNNh9VXE8sDi3g16U7KENOMoejGrv43ktekbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz12t1738982912t2y4m9
X-QQ-Originating-IP: jUJirz/B1eyIkkGAPBr4iGf+VXPjLlbcTdajr06eLZU=
Received: from wxdbg.localdomain.com ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 08 Feb 2025 10:48:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11733771835780424666
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
Subject: [PATCH net-next v6 4/4] net: ngbe: Add support for 1PPS and TOD
Date: Sat,  8 Feb 2025 11:13:48 +0800
Message-Id: <20250208031348.4368-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250208031348.4368-1-jiawenwu@trustnetic.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NQzH8pzEc5hGZIz7f+biLeOeFQxUpmCVsK/H46jnz1xq2jEISoxot6jf
	outGvRmHft+nEZw2jo385TVufACgP6U8SZrTzbUM0g3umFQVyj+dQv9Q0vdKQEOWwI6py/o
	psOgzSinuISycGtfccG92nXT12u/6Yjc6GoueU/8RK09pGF+LYTbDQsCsOc2tkoB8kmFeAR
	VrmkCyHG1TWA8OjC07mlhA+iqOaA6fskcx7fW8wPIrI3RskPHrHwzrVb90VcING/c+uHY0q
	JojaqeUhcksK6pCqb28VyezMS0NIHFFVFVDxDwoy0bv8xMf1WqA0vQFDt6M7C7oK7X5adq7
	ccIdHEtKg2pwTT05UHnIXqleo9x4PsSxiKNSlK2avMpA1eaqCPoVi8ufgIIyzxr/lmiUNTw
	VtdEKRTa+Q8M3aMwaspduH1YMGw5hhOSo7hBy30Arm8cfqIYAWCQ27o/qKt7hWije2GeOhI
	ZKnsONx9epqe+uwS0vyj35BYJNsf0EJS5sSZ63FC2esY4LfY2Qc6OgkDVJqrxWwlSOtcc6z
	TFJye/IhX5kqkCU0OTztlyB0GMhq2KDIdPCnL83DvqfPn9LEFI/4QoxwOQecDlbvEwUENIQ
	NkxelaVfwkHKUD3OUjbD0Qd6vTfcGD0Wj7Cn5mA4tdWMj+Tk2UiQxOnKgFGfUSKuqIl8+0w
	vNaUZAreiU+eGH91cUxerCp4xQaJerYQIsO347j4ZaJ+6w9/d+BdP70REuslf6CqlB+IT7+
	ccxqeGmY05YYEs0m4Vcs0Q/OrfxDKPcbFdwESnXpqU9f1xPT/COLH8zZ/rXEgWwwqKsHJJr
	RT5xQcwgt489yDB7YjlsLyBP0XjE6LVtjs/l/SokSAOf+iF38NVzSlLR8LGwsG/bG/xNeaX
	9ItZqPiFVa4X6YiGTg1O3bwPDJOQUDsN8Y6rgFEfFoBpHkgLi0axn1+xijw7R+8SFODZrq+
	Gh/Jv0xnlm048pr5m4j6SJYQ+1O3+RIpfz1uOWfCq2yoK5R5am73hfhGXNQtIaLS4dAs=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Implement support for generating a 1pps output signal on SDP0.
And support custom firmware to output TOD.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  19 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 196 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  35 ++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  12 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   5 +
 7 files changed, 265 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index deaf670c160e..907d13ade404 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -393,6 +393,25 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
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
index 69b8989b7712..721b4ec6e466 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -104,6 +104,9 @@ static int wx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	timecounter_adjtime(&wx->hw_tc, delta);
 	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
 
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	return 0;
 }
 
@@ -153,6 +156,9 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
 	timecounter_init(&wx->hw_tc, &wx->hw_cc, ns);
 	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
 
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	return 0;
 }
 
@@ -376,6 +382,175 @@ static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 	return HZ;
 }
 
+static u64 wx_ptp_trigger_calc(struct wx *wx)
+{
+	struct cyclecounter *cc = &wx->hw_cc;
+	unsigned long flags;
+	u64 ns = 0;
+	u32 rem;
+
+	/* Read the current clock time, and save the cycle counter value */
+	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
+	ns = timecounter_read(&wx->hw_tc);
+	wx->pps_edge_start = wx->hw_tc.cycle_last;
+	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
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
+	wx->pps_edge_end += div_u64(((u64)(rem + wx->pps_width) <<
+				     cc->shift), cc->mult);
+
+	return (ns + rem);
+}
+
+static int wx_ptp_setup_sdp(struct wx *wx)
+{
+	struct cyclecounter *cc = &wx->hw_cc;
+	u32 tsauxc;
+	u64 nsec;
+
+	if (wx->pps_width >= WX_NS_PER_SEC) {
+		wx_err(wx, "PTP pps width cannot be longer than 1s!\n");
+		return -EINVAL;
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
+		return 0;
+	}
+
+	wx->pps_enabled = true;
+	nsec = wx_ptp_trigger_calc(wx);
+	wx_set_pps(wx, wx->pps_enabled, nsec, wx->pps_edge_start);
+
+	tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
+		WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
+	wr32ptp(wx, WX_TSC_1588_TRGT_L(0), (u32)wx->pps_edge_start);
+	wr32ptp(wx, WX_TSC_1588_TRGT_H(0), (u32)(wx->pps_edge_start >> 32));
+	wr32ptp(wx, WX_TSC_1588_TRGT_L(1), (u32)wx->pps_edge_end);
+	wr32ptp(wx, WX_TSC_1588_TRGT_H(1), (u32)(wx->pps_edge_end >> 32));
+	wr32ptp(wx, WX_TSC_1588_SDP(0),
+		WX_TSC_1588_SDP_FUN_SEL_TT0 | WX_TSC_1588_SDP_OUT_LEVEL_H);
+	wr32ptp(wx, WX_TSC_1588_SDP(1), WX_TSC_1588_SDP_FUN_SEL_TS0);
+	wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
+	wr32ptp(wx, WX_TSC_1588_INT_EN, WX_TSC_1588_INT_EN_TT1);
+	WX_WRITE_FLUSH(wx);
+
+	/* Adjust the clock edge to align with the next full second. */
+	wx->sec_to_cc = div_u64(((u64)WX_NS_PER_SEC << cc->shift), cc->mult);
+
+	return 0;
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
+	if (rq->perout.flags & ~(PTP_PEROUT_DUTY_CYCLE |
+				 PTP_PEROUT_PHASE))
+		return -EOPNOTSUPP;
+
+	if (rq->perout.phase.sec || rq->perout.phase.nsec) {
+		wx_err(wx, "Absolute start time not supported.\n");
+		return -EINVAL;
+	}
+
+	if (rq->perout.period.sec != 1 || rq->perout.period.nsec) {
+		wx_err(wx, "Only 1pps is supported.\n");
+		return -EINVAL;
+	}
+
+	if (rq->perout.flags & PTP_PEROUT_DUTY_CYCLE) {
+		struct timespec64 ts_on;
+
+		ts_on.tv_sec = rq->perout.on.sec;
+		ts_on.tv_nsec = rq->perout.on.nsec;
+		wx->pps_width = timespec64_to_ns(&ts_on);
+	} else {
+		wx->pps_width = 120000000;
+	}
+
+	if (on)
+		set_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+	else
+		clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+
+	return wx->ptp_setup_sdp(wx);
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
+	u32 tsauxc, int_status;
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
+		wx_ptp_trigger_calc(wx);
+
+		tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
+			 WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
+		wr32ptp(wx, WX_TSC_1588_TRGT_L(0), (u32)wx->pps_edge_start);
+		wr32ptp(wx, WX_TSC_1588_TRGT_H(0), (u32)(wx->pps_edge_start >> 32));
+		wr32ptp(wx, WX_TSC_1588_TRGT_L(1), (u32)wx->pps_edge_end);
+		wr32ptp(wx, WX_TSC_1588_TRGT_H(1), (u32)(wx->pps_edge_end >> 32));
+		wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
+		WX_WRITE_FLUSH(wx);
+	}
+}
+EXPORT_SYMBOL(wx_ptp_check_pps_event);
+
 /**
  * wx_ptp_create_clock
  * @wx: the private board structure
@@ -402,17 +577,22 @@ static long wx_ptp_create_clock(struct wx *wx)
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
@@ -691,6 +871,12 @@ void wx_ptp_reset(struct wx *wx)
 
 	wx->last_overflow_check = jiffies;
 	ptp_schedule_worker(wx->ptp_clock, HZ);
+
+	/* Now that the shift has been calculated and the systime
+	 * registers reset, (re-)enable the Clock out feature
+	 */
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
 }
 EXPORT_SYMBOL(wx_ptp_reset);
 
@@ -742,6 +928,10 @@ void wx_ptp_suspend(struct wx *wx)
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
index c2e58de3559a..7f6af62f5e94 100644
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
+	int (*ptp_setup_sdp)(struct wx *wx);
 
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


