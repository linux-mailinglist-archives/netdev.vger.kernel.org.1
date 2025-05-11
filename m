Return-Path: <netdev+bounces-189547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9379AB2969
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703597AB4AC
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3BC23E235;
	Sun, 11 May 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEo3H27M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2922907;
	Sun, 11 May 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746978163; cv=none; b=triQ0efe5tz4Ou2lB4LGZSkg/qUmalhqRdmdDtUN0IIlO6om7NJKtU4fFLUcfqL0o0l2JuW6vPxuda71fzjXOVAF/KfBpDJB/Qk8sNlVX2xoqTXJ8RZCq5Q6LD+K/mJfRVONJBdRlXxAYMgHQoAOCM96RbUhqJe/i546eGcqdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746978163; c=relaxed/simple;
	bh=NlqeUqIZdZmkji0hDRwiEmsp/qJoN+HBItdDCNpMVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYKqvWLBWwBJQz+UrvEsLpfdEZMZAT3tJ232IRYuGvmaTBd9QalqWbytTkp6X4levRnlk7kQ9bazQ9eDkrKcu0afQM4BaPZNBE448GE9LRozTGkVYGWFlUUBxhgGFj3PFOaPpV1g76woJpzvSqzM7s3rS98avPt9oyWLnvjyN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEo3H27M; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b9625735so1810288f8f.2;
        Sun, 11 May 2025 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746978159; x=1747582959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYqCvtT8FUAfMoo3aGei4XL6q2rIw/A9DS2ZyzQMU28=;
        b=PEo3H27MR3xzMGonf07ysixcky8tlLau3h1kqDLaefxKD3IVdFmRc/2C+2TSWLIlZo
         czrbufShkXi7tc9BJ+wXcHDo45zJjYo2q2AuzqbaOfAlsun1TYIkXT5HkkKc2TUew5eD
         ycaB0xdWJQjETJMOR4UDGwPj37L7nSkn9jrC9Uld7gKLCmfT5dF+ml9L3MfttTotTlxS
         XIFY7GXiP9MvPEWclOxHzb+guhZO8qGw+SPKkDe9szKysxSrh/FYMx75evDEb0OVMSNt
         2lLnedlTh+ghPiRwR0jmP4777joRQP5z6uUxgSMHG3iDHWvNjBvB5mIfn6ZFnJwm93nh
         abNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746978159; x=1747582959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYqCvtT8FUAfMoo3aGei4XL6q2rIw/A9DS2ZyzQMU28=;
        b=uxEx4zyvwH9otcx+C2OtMbvmt8+POK8o4GFr6qkikLf/bRlayWD8x/EWclFqXpkKRe
         vmGC2I5Kibf2uEYKxK99ypHE/7TZVaVBuo/NLd+Qki+5ZJ3reH3jt+4qa0oLN707eHS+
         vWkS2J7B8I8NySLpS328V4BoyEr8VTkv+tMOxUZXmzeANi1dW91StbIqrEHtde6e/7g9
         UBTr1uon1Wy1M1tayXWl/7ae1YkdP8CzHoUmJ2VDE7vJ0RIWpKWboeb+p+oL38HugVyz
         yWeMZX2bpD9btqD1Zsyaabm/aNt4N2DgtWKiliRxMO3wpxL2317e5GSV1bDm7o3vUmOV
         E+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhar//IYK+sCRS8VnRMPVSigAETAmu5Z8FeBrjVd8rwucpZuseMgrOmMd+xYZdySR2LTHmqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DKJ7Lzcwp4EHWD3ENq4b8uEWXdkIc+te0/61jBkZa+/SIAnI
	SeNK0IYrsb+cKxNRQfASqA2k6t0pha/NE+HkM4ODG5cvG3g2Vjxb
X-Gm-Gg: ASbGnctcYNhEGd9BAI2eOLCj3CS233lE0D1PIv0Z153yB0UgrrM7MUE0XqVBiKhoXBk
	x6iobFybzrfWadQzXJ4483a0pJehr8/w9hs3jgpV6sVVrlMV6Vuu1bovRAIIY7xRAEzJBbEv+KQ
	0usEMw0iwW0y/mYBEzn+/uNogZDACpLn8mY7RgASN25qURT5pbFIyQpLMEH2oXccPp7iHvYnJky
	87NN2vNTh2+TuWjJpXtPH2AvhaT21Y2B2V08C2uX9MoNSpdny54dZMnpaACOxZzfTvQ72ZVaety
	gI6/tw4gfrkDQpvZORUBOYQlt4SR9/qX0QSJsdycebTLKBAXcjp9CM6U9VCzA0CAky3RQ2jteE8
	iY5CNdyrL35c6
X-Google-Smtp-Source: AGHT+IE5+5gLt9dJza7E2LT/Pv2xiPU2SQKS9FwiyRUhE7nQuI8TWpuRKAbzGdsy6P9BxfOUdB0kfw==
X-Received: by 2002:a05:6000:1786:b0:3a0:b565:f1ea with SMTP id ffacd0b85a97d-3a1f6421d7bmr7565768f8f.5.1746978159231;
        Sun, 11 May 2025 08:42:39 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c804sm9706530f8f.95.2025.05.11.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 08:42:38 -0700 (PDT)
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
Subject: [PATCH v4] ptp: ocp: Limit signal/freq counts in show/store functions
Date: Sun, 11 May 2025 18:42:34 +0300
Message-ID: <20250511154235.101780-1-maimon.sagi@gmail.com>
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
Addressed comments from Vadim Fedorenko:
 - https://www.spinics.net/lists/netdev/msg1090730.html
Changes since v3:
 - in signal/freq show routine put constant string "UNSUPPORTED" in
   output instead of returning error.
---
---
 drivers/ptp/ptp_ocp.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 2ccdca4f6960..14b4b3bebccd 100644
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
+		return sysfs_emit(buf, "UNSUPPORTED\n");
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
+		return sysfs_emit(buf, "UNSUPPORTED\n");
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


