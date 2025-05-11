Return-Path: <netdev+bounces-189514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07FBAB2760
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 10:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5511774A5
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D51A0BD0;
	Sun, 11 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiAkpLnS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F620EB;
	Sun, 11 May 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746953543; cv=none; b=l9B3MTqGEIHo2RFR6Q53l5zidKk2satLuc1CcFUJPwChAq3C9lG6+LH+fiCm1vKnMoJGrRhybL93LflcdJ8epUi1/X9uDaa1WP4alNlaA7vjjLGxFKwyBiZ7Do8n0seYSYy64bb6igaqTYF7v5PG9u+s0rWQEU31l8OeQlznUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746953543; c=relaxed/simple;
	bh=iCVmhlbuMiEmfPg9ixsf1Wsnh7UbrYefZlJgK3bkQTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDdVYb4VVSqChKinWHcLUZN8G6y3iuBVW9XI9rUmK2qjwZGo8S6liSaZdegGRZHgD6REM5pUmcBa0DlBrL/oepDzs1l2oHKhOCXtWkILBsSvhMsgmWk9Eub4u8wws45VXrtnPsO0/a73FGzpOj5tK8jLKdTtKmwAVVsx4uwf7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiAkpLnS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf680d351so25913255e9.0;
        Sun, 11 May 2025 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746953540; x=1747558340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCXMnZztKd0xWOddeYwQ4wPIupiPm3aEG3c6gN5Piqc=;
        b=TiAkpLnSyGFOUcjI+1Zoh1uIJi10O5jv3JTrj4Uds1mnP4e97biVXXqK6QqGSbRPPb
         nCQqKl34mpSq3S/5m8PJF+42BmWoDaoql+Wxw2goLMR4jgACR1VNTvBmFiQeUciZiKYR
         cg9qGy5RWaPmwPuPCeNmO5CumQ+bilvsAUjLJyqSWSkpJsl8WHRGZ2pNiLmcQ1EvV2qF
         Efy7BK0PXln8dQXdvIO07GhdOIw5jFIqRSeKoYckUTTi0O2ag5vMGQLXqUGeq+raBAbW
         6YmXwDvpQjJgX6jsNkLTCIkjxLmZUHoC8NU7D3a0/uPmvTEuCKiPgHZp4+blGamN8n7V
         nXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746953540; x=1747558340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCXMnZztKd0xWOddeYwQ4wPIupiPm3aEG3c6gN5Piqc=;
        b=f80AnCnfTDeVALOtWBDx+5BfPviVhiycecy9ZgjM0WC1M54qV+V4tGs73fwDSgtZLi
         xHIuU0FbCGgqs2C+Y91IO6NqrXcrNj5QVqF23A/I8RlX2jo4gDySh6IWr0YVDPOwx8tC
         A/AVzTHlieliGIxMCmtJZHm9KRySxIFkTMnGrxsQPVFM6PSSHJSTt1pUq0NIOSdNz9xb
         5O9kLX6qGIh5N8RFJmx+d6/6UgtJ+U3U5xtwBKPv7oY9NTaUrvtSA+MPDIcjFXwmUXGt
         S0dJFTk2w6Dm6CLiQ7ayi0ZLkaNthJNuWg5ZFdqu4hAi3QDB9g0AuKR92W6xcCtjgBuY
         0N2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQUr9J165ixSYhb9ZNAX0PcJnrfvo2H41+NbQbeuOTNG2jniAcahYk640ZVc9QpmJjVMJZE0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/hzmTWWZkMtNABn9dc+ANYCD0HududFYBQGPLJRTaZeqB329
	T+AeehzzjZJm5RcZqGOjQov/hc/etr7VidHEpNXmpaaDq2AXTaeS
X-Gm-Gg: ASbGncvLvIOMLGMoINWef8Mo5lBLL9gMzhP6Sk1bPlshzy5KwQE0OyvYtPKY+xSWKSr
	gmL2oLXYxMqcvBmUD9FvQZub4OjvmwcW5TWR51psHSvScf1q5AMOYifIUb+eZA086Wa8qqAi8yc
	7iVUIOAVczjsNUfKvrylnoqBtZfjo5zml1KD9xGcp74H8mJr73cpzPm/wf70FcbrsnOId+ioUmY
	VDe9DYSyXTp48O7AvjXcI08JabloF1YeYqNSdkHj03DhuD1dCyaCviP6dMKvIazJfvCkjo1so+t
	uGMDZyCYO8wl1ahgVwckxypH4xtBDWhcTBD0WEY2xEteOt/AVBIqcmkwv8/Dr9SM9WPSK6PIgDR
	Hsnd/clUnMPGb
X-Google-Smtp-Source: AGHT+IGlhCHo8rrDiUpFZa/34LKW0sh0K8Bq7EbVyr/sApek7GovumGUUVaHqLY/PDgSvwTPxbaqlw==
X-Received: by 2002:a05:600c:4383:b0:442:7c40:fda4 with SMTP id 5b1f17b1804b1-442d02b91a1mr82445845e9.1.1746953539428;
        Sun, 11 May 2025 01:52:19 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67df574sm85407075e9.11.2025.05.11.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 01:52:18 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v3 1/1] ptp: ocp: Limit signal/freq counts in show/store functions
Date: Sun, 11 May 2025 11:52:14 +0300
Message-ID: <20250511085214.76806-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs show/store operations could access uninitialized elements
in the freq_in[] and signal_out[] arrays, leading to NULL pointer
dereferences. This patch introduces u8 fields (nr_freq_in,
nr_signal_out) to track the number of initialized elements, capping
the maximum at 4 for each array. The show/store functions are updated
to respect these limits, preventing out-of-bounds access and ensuring
safe array handling.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
Addressed comments from Jakub Kicinski:
 - https://www.spinics.net/lists/netdev/msg1090604.html
Changes since v2:
 - Handle only freq_in and signal_out NULL pointer dereferences.
 - Return -EINVAL for sysfs requests accessing out-of-bounds elements
   in freq_in and signal_out arrays.
---
---
 drivers/ptp/ptp_ocp.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 2ccdca4f6960..27ff4170f1a3 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -315,6 +315,8 @@ struct ptp_ocp_serial_port {
 #define OCP_BOARD_ID_LEN		13
 #define OCP_SERIAL_LEN			6
 #define OCP_SMA_NUM			4
+#define OCP_SIGNAL_NUM			4
+#define OCP_FREQ_NUM			4
 
 enum {
 	PORT_GNSS,
@@ -342,8 +344,8 @@ struct ptp_ocp {
 	struct dcf_master_reg	__iomem *dcf_out;
 	struct dcf_slave_reg	__iomem *dcf_in;
 	struct tod_reg		__iomem *nmea_out;
-	struct frequency_reg	__iomem *freq_in[4];
-	struct ptp_ocp_ext_src	*signal_out[4];
+	struct frequency_reg	__iomem *freq_in[OCP_FREQ_NUM];
+	struct ptp_ocp_ext_src	*signal_out[OCP_SIGNAL_NUM];
 	struct ptp_ocp_ext_src	*pps;
 	struct ptp_ocp_ext_src	*ts0;
 	struct ptp_ocp_ext_src	*ts1;
@@ -378,10 +380,12 @@ struct ptp_ocp {
 	u32			utc_tai_offset;
 	u32			ts_window_adjust;
 	u64			fw_cap;
-	struct ptp_ocp_signal	signal[4];
+	struct ptp_ocp_signal	signal[OCP_SIGNAL_NUM];
 	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
 	const struct ocp_sma_op *sma_op;
 	struct dpll_device *dpll;
+	int signals_nr;
+	int freq_in_nr;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -2697,6 +2701,8 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	bp->eeprom_map = fb_eeprom_map;
 	bp->fw_version = ioread32(&bp->image->version);
 	bp->sma_op = &ocp_fb_sma_op;
+	bp->signals_nr = 4;
+	bp->freq_in_nr = 4;
 
 	ptp_ocp_fb_set_version(bp);
 
@@ -2862,6 +2868,8 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	bp->fw_version = ioread32(&bp->reg->version);
 	bp->fw_tag = 2;
 	bp->sma_op = &ocp_art_sma_op;
+	bp->signals_nr = 4;
+	bp->freq_in_nr = 4;
 
 	/* Enable MAC serial port during initialisation */
 	iowrite32(1, &bp->board_config->mro50_serial_activate);
@@ -2888,6 +2896,8 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	bp->flash_start = 0xA00000;
 	bp->eeprom_map = fb_eeprom_map;
 	bp->sma_op = &ocp_adva_sma_op;
+	bp->signals_nr = 2;
+	bp->freq_in_nr = 2;
 
 	version = ioread32(&bp->image->version);
 	/* if lower 16 bits are empty, this is the fw loader. */
@@ -3190,6 +3200,9 @@ signal_store(struct device *dev, struct device_attribute *attr,
 	if (!argv)
 		return -ENOMEM;
 
+	if (gen >= bp->signals_nr)
+		return -EINVAL;
+
 	err = -EINVAL;
 	s.duty = bp->signal[gen].duty;
 	s.phase = bp->signal[gen].phase;
@@ -3247,6 +3260,10 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int i;
 
 	i = (uintptr_t)ea->var;
+
+	if (i >= bp->signals_nr)
+		return -EINVAL;
+
 	signal = &bp->signal[i];
 
 	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
@@ -3359,6 +3376,9 @@ seconds_store(struct device *dev, struct device_attribute *attr,
 	u32 val;
 	int err;
 
+	if (idx >= bp->freq_in_nr)
+		return -EINVAL;
+
 	err = kstrtou32(buf, 0, &val);
 	if (err)
 		return err;
@@ -3381,6 +3401,9 @@ seconds_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int idx = (uintptr_t)ea->var;
 	u32 val;
 
+	if (idx >= bp->freq_in_nr)
+		return -EINVAL;
+
 	val = ioread32(&bp->freq_in[idx]->ctrl);
 	if (val & 1)
 		val = (val >> 8) & 0xff;
@@ -3402,6 +3425,9 @@ frequency_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int idx = (uintptr_t)ea->var;
 	u32 val;
 
+	if (idx >= bp->freq_in_nr)
+		return -EINVAL;
+
 	val = ioread32(&bp->freq_in[idx]->status);
 	if (val & FREQ_STATUS_ERROR)
 		return sysfs_emit(buf, "error\n");
@@ -4008,7 +4034,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 {
 	struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
 	struct ptp_ocp_signal *signal = &bp->signal[nr];
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4031,7 +4057,7 @@ static void
 _frequency_summary_show(struct seq_file *s, int nr,
 			struct frequency_reg __iomem *reg)
 {
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4175,11 +4201,11 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 	}
 
 	if (bp->fw_cap & OCP_CAP_SIGNAL)
-		for (i = 0; i < 4; i++)
+		for (i = 0; i < bp->signals_nr; i++)
 			_signal_summary_show(s, bp, i);
 
 	if (bp->fw_cap & OCP_CAP_FREQ)
-		for (i = 0; i < 4; i++)
+		for (i = 0; i < bp->freq_in_nr; i++)
 			_frequency_summary_show(s, i, bp->freq_in[i]);
 
 	if (bp->irig_out) {
-- 
2.47.0


