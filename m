Return-Path: <netdev+bounces-188903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F068AAAF48F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA3D9C440D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529F1DDC23;
	Thu,  8 May 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COe5GbWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC65195FE8;
	Thu,  8 May 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688752; cv=none; b=TXAsM+d2tGTMKQOQ9baNIuArXgFQikbzdUSTdL++Rnsc3x0Ev5KlZ70aPoJSAY+4VY05iv6q95i26onhTpLX7itnUZzEYbUkbltzDxhTomramSClTmVtj34sQF0UF5E48BQ/CdULin5wPdJrxBvLXqcum/uLOn2fx2HT3fpiQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688752; c=relaxed/simple;
	bh=NZlQYIpLCPPm8QwGIxYmSIkLl7+DV7nKI/ccuJdOT90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJn6cz1T7iAxg/u3usY5LJTCfN794nwHLZxYhlxMJ5tZx9b6sVpqNlMlQgf8peTttoD4wy1NNjk4UwLQo4mnNdYiz5ug8mSloPpO/i6IQ+cCsUFFhhxj4JOZZoEEL81ptRO0ihjNlgV+nYjPPhuTZ2Zx7KRY7lk1RmbtQvQq7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COe5GbWY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso3205125e9.3;
        Thu, 08 May 2025 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746688745; x=1747293545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DMfqYapUvhhJ0C6IaEfP+wSqVQID24ZfG48i0fH070=;
        b=COe5GbWYcGcQG4Nia4pwy4GugDkvQzk52WoJvXRjW9LO8sKzeBw/qc8d5RnZPHvmdT
         D4LDtIxo9A9kpqpcUPA2Mi3mWbeEaISPxiTE+y32IVFo1Uxjo4ZvlQOM6wIstBM/mUpe
         dVuyEC7BVvUbze1KjZQe3qnaRxktxcw4S60QDLPyJr8f5g3t/R1DIUqfUdV6nwM6W+/o
         /fdq6tuLrbK7r8Ykx9zSh0mP0MlN722tKyo4RWP33GQIm4dfzX6ciw/+7nipSIucHj/v
         8ok8rVZ+dz0/rqdVIJiGy5MkEFa/RRt/doKT2TzvqKX0f2ZiXbhJhFgVam9yY8rf+BOZ
         85/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688745; x=1747293545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DMfqYapUvhhJ0C6IaEfP+wSqVQID24ZfG48i0fH070=;
        b=t4gb1nNWwrtfcQSzFyvsIxS65Qrv1kktyWq9hrMts+vFoxVFA/ImldcGvkp4kDAyKL
         P1HgwyJ2XIlucWojzcOJAqoeDYdW2FrnNK5Vf+10Go8G7XImks+PSRU2U1/IWJ9aTnd9
         B9BjN4nWQ5ykEJBPF0Q3uapj/6EeG/YORh/qDbgsRmAaCyigSMlpxzC5DXfNGn+QBAvx
         q3nhvDqj66mrBmlvDHakCt28fQhnGicK1UZ6mvXFpkbB50Ufh0A85MPWrwB9nNDtFJGw
         FJOgcl8+LW3XE6cVp0wi6P919wKTnxYEMZAI6dF96NAvz8XH71xYgPimXx6qle4Yq536
         oVYg==
X-Forwarded-Encrypted: i=1; AJvYcCUqvyWCd/H96zy1CIMieUS/H9Frj58yf1yR8hoPfs4FC4m/6oa5WIAHIaUXMvZOCngK8lKqLLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRF3SWqnqb0xcHNxNeZAhUe/8XqZ7m5YCZFW0N71iDjP++a9j
	yGnzhtEdRggooyQmH0sbEK6LbBEpva9OQFiGm2u7fuM6HiJNo1wF
X-Gm-Gg: ASbGnctw5IfUDUmVQi21i6107F5oRg9hCCimAamjpYBf6vk5rvRcuWIOhycdOPe7ZPl
	DDzKr3lMVkth1wQU0uxvnC0TwgfsNTGcKXzwskXhC0llRC5i3kVMGKasOkttllWDmyf0CD2IKjv
	ixUUjUI/9gHbwAN+iG1/W52UB9ZJVoIDJYwl+aPabhDl88mmwL1vWxdvVry3F+MY/QUhAYov+aJ
	Lj+c3jz0szHeFoxCOV2ahnZeNjkIxVk5qF+DBa/peMKYSktjdl5qL0Zo57zzhae/B0LAVaTTm5s
	ZRlHfv6Ri3bwAYvTV7v0WOchlP9OJ0wctlQXjdQHAj3dMWTzrKwd4AdoTtvBZAoq9nwNoUdCNhF
	zNWQBSY+ohalS
X-Google-Smtp-Source: AGHT+IH6UjSvDcCItKtC5aVAK3Yc07nthKfH768rrkBpeeS+skaFj4Sux6VyyVYHhORkoTiBbsYwaA==
X-Received: by 2002:a05:600c:6308:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-441d44bc5d0mr52681325e9.2.1746688745316;
        Thu, 08 May 2025 00:19:05 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aeb79sm26435695e9.27.2025.05.08.00.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 00:19:04 -0700 (PDT)
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
Subject: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
Date: Thu,  8 May 2025 10:19:01 +0300
Message-ID: <20250508071901.135057-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs show/store operations could access uninitialized elements in
the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_out,
nr_sma) to track the actual number of initialized elements, capping the
maximum at 4 for each array. The affected show/store functions are updated to
respect these limits, preventing out-of-bounds access and ensuring safe
array handling.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
Addressed comments from Simon Horman:
 - https://www.spinics.net/lists/netdev/msg1089986.html
Changes since v1:
 - Increase label buffer size from 8 to 16 bytes to prevent potential buffer
   overflow warnings from GCC 14.2.0 during string formatting.
---
---
 drivers/ptp/ptp_ocp.c | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 2ccdca4f6960..dd6de70de29b 100644
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
@@ -378,10 +380,13 @@ struct ptp_ocp {
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
+	int sma_nr;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -2697,6 +2702,9 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	bp->eeprom_map = fb_eeprom_map;
 	bp->fw_version = ioread32(&bp->image->version);
 	bp->sma_op = &ocp_fb_sma_op;
+	bp->signals_nr = 4;
+	bp->freq_in_nr = 4;
+	bp->sma_nr  = 4;
 
 	ptp_ocp_fb_set_version(bp);
 
@@ -2862,6 +2870,9 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	bp->fw_version = ioread32(&bp->reg->version);
 	bp->fw_tag = 2;
 	bp->sma_op = &ocp_art_sma_op;
+	bp->signals_nr = 4;
+	bp->freq_in_nr = 4;
+	bp->sma_nr  = 4;
 
 	/* Enable MAC serial port during initialisation */
 	iowrite32(1, &bp->board_config->mro50_serial_activate);
@@ -2888,6 +2899,9 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	bp->flash_start = 0xA00000;
 	bp->eeprom_map = fb_eeprom_map;
 	bp->sma_op = &ocp_adva_sma_op;
+	bp->signals_nr = 2;
+	bp->freq_in_nr = 2;
+	bp->sma_nr  = 2;
 
 	version = ioread32(&bp->image->version);
 	/* if lower 16 bits are empty, this is the fw loader. */
@@ -3002,6 +3016,9 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_nr, char *buf,
 	const struct ocp_selector * const *tbl;
 	u32 val;
 
+	if (sma_nr > bp->sma_nr)
+		return 0;
+
 	tbl = bp->sma_op->tbl;
 	val = ptp_ocp_sma_get(bp, sma_nr) & SMA_SELECT_MASK;
 
@@ -3091,6 +3108,9 @@ ptp_ocp_sma_store(struct ptp_ocp *bp, const char *buf, int sma_nr)
 	enum ptp_ocp_sma_mode mode;
 	int val;
 
+	if (sma_nr > bp->sma_nr)
+		return 0;
+
 	mode = sma->mode;
 	val = sma_parse_inputs(bp->sma_op->tbl, buf, &mode);
 	if (val < 0)
@@ -3190,6 +3210,9 @@ signal_store(struct device *dev, struct device_attribute *attr,
 	if (!argv)
 		return -ENOMEM;
 
+	if (gen >= bp->signals_nr)
+		return 0;
+
 	err = -EINVAL;
 	s.duty = bp->signal[gen].duty;
 	s.phase = bp->signal[gen].phase;
@@ -3247,6 +3270,10 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int i;
 
 	i = (uintptr_t)ea->var;
+
+	if (i >= bp->signals_nr)
+		return 0;
+
 	signal = &bp->signal[i];
 
 	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
@@ -3359,6 +3386,9 @@ seconds_store(struct device *dev, struct device_attribute *attr,
 	u32 val;
 	int err;
 
+	if (idx >= bp->freq_in_nr)
+		return 0;
+
 	err = kstrtou32(buf, 0, &val);
 	if (err)
 		return err;
@@ -3381,6 +3411,9 @@ seconds_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int idx = (uintptr_t)ea->var;
 	u32 val;
 
+	if (idx >= bp->freq_in_nr)
+		return 0;
+
 	val = ioread32(&bp->freq_in[idx]->ctrl);
 	if (val & 1)
 		val = (val >> 8) & 0xff;
@@ -3402,6 +3435,9 @@ frequency_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int idx = (uintptr_t)ea->var;
 	u32 val;
 
+	if (idx >= bp->freq_in_nr)
+		return 0;
+
 	val = ioread32(&bp->freq_in[idx]->status);
 	if (val & FREQ_STATUS_ERROR)
 		return sysfs_emit(buf, "error\n");
@@ -3975,7 +4011,7 @@ gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
 {
 	int i;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < bp->sma_nr; i++) {
 		if (bp->sma[i].mode != SMA_MODE_IN)
 			continue;
 		if (map[i][0] & (1 << bit)) {
@@ -3995,7 +4031,7 @@ gpio_output_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit)
 	int i;
 
 	strcpy(ans, "----");
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < bp->sma_nr; i++) {
 		if (bp->sma[i].mode != SMA_MODE_OUT)
 			continue;
 		if (map[i][1] & (1 << bit))
@@ -4008,7 +4044,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 {
 	struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
 	struct ptp_ocp_signal *signal = &bp->signal[nr];
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4031,7 +4067,7 @@ static void
 _frequency_summary_show(struct seq_file *s, int nr,
 			struct frequency_reg __iomem *reg)
 {
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4175,11 +4211,11 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
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


