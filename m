Return-Path: <netdev+bounces-154699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E049FF7D7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2213A134E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8F1A08B1;
	Thu,  2 Jan 2025 10:11:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580E199938
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812713; cv=none; b=cFzCLxNic259R2WODU/399HZbhuKOBx9PPFJ9ivEHCjeDNm0U3eC5yVWyeV6jT2xKTGAxPOQ6d85poZ7VSgvrENEpxll6OmEaRRQaYuPoa9kBDlM9+YwrVu5lY8bdwGt7UQ3/GrBblddJb3/0jrMvNQoWxF3c7KDTi6GFK/zUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812713; c=relaxed/simple;
	bh=oT1DQLtbL98lvMDSGsgJfIGR30YhJqQ7LC5cIllGddA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGV4givqWHJpDhm5lcEchu2NaHTjAMsSNl4MA98ZZR4haAtBRfrJ4St1bEOEB8/7olfjAe2MG7VH42gtc8biggimtc0kz3LYsVhXObj+bo/PQe8AZoUqD/W3y06NW3XakhbqVtawPDhG3uPU2uktGuebzWgaAhAID3S+1Cy+apU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1735812578tyl2296
X-QQ-Originating-IP: QIZhewiH6f7Gx5X+DjxBmc+8CNKQK5TeZZ6I6V3egZ0=
Received: from wxdbg.localdomain.com ( [115.220.136.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jan 2025 18:09:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10738558831727623288
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
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 4/4] net: ngbe: Add support for 1PPS and TOD
Date: Thu,  2 Jan 2025 18:30:26 +0800
Message-Id: <20250102103026.1982137-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NupK0iGZGlzSATpb5UjKid5MMvIq5w9OPR5/SEr0RADHY8JaD/+ijurk
	uCpPgLvqzJS11S+oPpg+xOoIrpPPDoHv9arX+hE8Dwwkq4ob5QdNEYJJAEoLbQuR1jK6UDh
	frzKFT14MGDzEprHLIoZqVUSNCa/CVTSWfvatHhwPK1Qh4u1Qf+HaYTiay4R6lgVlFZfFeG
	pfcLsd6mtWVSNaiXuVuhoCZseCmfjKhVLj2GcRieGt8WCV4XegO4cOET6GW9QjO1dQ+co9+
	ZrXG3/6PbxRWv7zxqdrA8O8KZmPigHTh5htd0oY67QEYfsNyCSS02z3/0p0e2Hat7wmJJWC
	TD5ScL1KlqrPMqHcbuMai8tpHltmEq+7lYFtXs0EfQ8nv5Ze3GZ/jud0sHUFM3goEidkDLM
	d7Sd3Vr1hMKO478oVl9J9adblz3Ne0KMXAdcrtCxPfOZMx7FUqW94K00L0ADRpIaUSS9uNX
	7F3GVhP2smDWSKnVt7W4Uk8uzu+nTiwz+5TpyUo/sBAEqV35ev6GKc3ck9GKiDtcOmBZmS2
	PAw3QRDFJXDbTnKj/NmoVeyAXPtf2dq9wvyTkGcZUFpY+WF1EQxQNGxQWaPgJeyS4nol8cl
	VEv4vN43VUxK/Ojufm/BGa0BLG8OLycdU6XI44pF/RX2CtdWqrqiCPA8czYd0WiW2RAgDbo
	O9g24Cv7bF+/oeXyZa+i22qkef4hI7BLgyAaOs9fLMAAtMvUiKNzAGucfT8zJHQT+z9ZiCC
	L1Q4awLxKClEqoO8BBuqTOSG6hiMLWlwI72jaOEL72d+abuFxSm7gU1Wy6HnK9+3wWb2zGa
	oufTVFPepDj3fKbLpOU0pmzal0NtioKolSL84C89qu4hCqZrvJsAWwL4UoJzhz03VOgDLiy
	HhejsubmFCVI920vu+SAOnjuBYsNdFMSqwGgLg2Rrmy/rq4DqwXlTJaama8Zn7FMPNckzh4
	f94py2zbNBnlFwFXwatb3xOd5Zg0Vymgaf0k+HKVIsWFxgXOtskgyW+uE
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Implement support for generating a 1pps output signal on SDP0.
And support custom firmware to output TOD.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  19 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 199 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  34 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  12 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   5 +
 7 files changed, 268 insertions(+), 3 deletions(-)

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
index 2047667ce0fe..57846694b59b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -29,6 +29,82 @@
 #define WX_NS_PER_SEC         1000000000ULL
 #define WX_NS_PER_MSEC        1000000ULL
 
+static void wx_ptp_setup_sdp(struct wx *wx)
+{
+	struct cyclecounter *cc = &wx->hw_cc;
+	u32 tsauxc, rem, tssdp, tssdp1;
+	u32 trgttiml0, trgttimh0;
+	u32 trgttiml1, trgttimh1;
+	unsigned long flags;
+	u64 ns = 0;
+
+	if (WX_1588_PPS_WIDTH_EM >= WX_NS_PER_SEC) {
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
+	rem += WX_1588_PPS_WIDTH_EM * WX_NS_PER_MSEC;
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
 /**
  * wx_ptp_adjfine
  * @ptp: the ptp clock structure
@@ -78,6 +154,9 @@ static int wx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	timecounter_adjtime(&wx->hw_tc, delta);
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
 
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	return 0;
 }
 
@@ -137,9 +216,111 @@ static int wx_ptp_settime64(struct ptp_clock_info *ptp,
 	timecounter_init(&wx->hw_tc, &wx->hw_cc, ns);
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
 
+	if (wx->ptp_setup_sdp)
+		wx->ptp_setup_sdp(wx);
+
 	return 0;
 }
 
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
+	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
+		return -EOPNOTSUPP;
+
+	if (on)
+		set_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+	else
+		clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+
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
+		rem += WX_1588_PPS_WIDTH_EM * WX_NS_PER_MSEC;
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
@@ -172,10 +353,14 @@ static long wx_ptp_create_clock(struct wx *wx)
 	wx->ptp_caps.adjtime = wx_ptp_adjtime;
 	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
 	wx->ptp_caps.settime64 = wx_ptp_settime64;
-	if (wx->mac.type == wx_mac_em)
+	if (wx->mac.type == wx_mac_em) {
 		wx->ptp_caps.max_adj = 500000000;
-	else
+		wx->ptp_setup_sdp = wx_ptp_setup_sdp;
+		wx->ptp_caps.enable = wx_ptp_feature_enable;
+	} else {
 		wx->ptp_caps.max_adj = 250000000;
+		wx->ptp_setup_sdp = NULL;
+	}
 
 	wx->ptp_clock = ptp_clock_register(&wx->ptp_caps, &wx->pdev->dev);
 	if (IS_ERR(wx->ptp_clock)) {
@@ -573,6 +758,12 @@ void wx_ptp_reset(struct wx *wx)
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
 
@@ -622,6 +813,10 @@ void wx_ptp_suspend(struct wx *wx)
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
index 4a7a9cda2a35..f98dc2721c83 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
@@ -4,6 +4,7 @@
 #ifndef _WX_PTP_H_
 #define _WX_PTP_H_
 
+void wx_ptp_check_pps_event(struct wx *wx);
 void wx_ptp_start_cyclecounter(struct wx *wx);
 void wx_ptp_reset(struct wx *wx);
 void wx_ptp_init(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 706ee8dd99c1..e9b80ef241fd 100644
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
@@ -1069,6 +1097,7 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_PERFECT,
 	WX_FLAG_RX_HWTSTAMP_ENABLED,
 	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
+	WX_FLAG_PTP_PPS_ENABLED,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1169,10 +1198,15 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	void (*do_reset)(struct net_device *netdev);
+	void (*ptp_setup_sdp)(struct wx *wx);
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
 
+	bool pps_enabled;
+	u64 pps_edge_start;
+	u64 pps_edge_end;
+	u64 sec_to_cc;
 	u32 base_incval;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_skipped;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 83bc0100fb3e..8581fd48d056 100644
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


