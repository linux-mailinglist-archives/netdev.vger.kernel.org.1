Return-Path: <netdev+bounces-188246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63200AABCF1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816293A266A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3554207A08;
	Tue,  6 May 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkz4Bssz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47BC2206BE;
	Tue,  6 May 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518815; cv=none; b=p7DSzHd7dtt2BFjo5GZcM78T8/3XCmF2TYOERbY3LkZmMJVuwDgngq/Jp1s6SVpYbjEtPe3ZgaF2tCTMbzAC3LuKwCOTmQSS+HVwrpYR2HvuIPhVZmpL9JgCRwIhegbn7+fWWtK4q9Ac2FoX3X9CcWPbZntI+W7ygaYfhkImHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518815; c=relaxed/simple;
	bh=W6UAz9UDBWbujK8/4B16u1li/7N+rlY1PLsYUxw0eps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eReAA506Np77saChYj1crEmIG6WCbDO89ONmoSKNN/rzUvsjBUTbUnnq7H1U1XamQqAa7Lj7ugVlyVIDR0axy3PU4rQ3hRJ5x2hb/r6IKhyH5AVBOcmdUE/3Siwh3GP+ziKvz0ZlwtlUcYMrZAC9GJj1/F8UsPAn9/1vHtahxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkz4Bssz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so34839055e9.1;
        Tue, 06 May 2025 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746518812; x=1747123612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6b4cUQ5rcJKQNEYnrxrGnyBTnIsL8X4xA1lXrOi9Rw=;
        b=hkz4Bssz8wE9OxH4S2eihvd9j9zopizAdtpQ/zdEcoqQaeTlfQ6OL+ehV/hSQ4ZxOG
         rxbGFFL8Ufe6tAKumpFnFhQgbbQHRwHDUwgWptA5IHY50q0q3GXIHvC8HRgoFanb42KN
         /9ozWioT3fHr03L4W+YDFYilUpepYE3dbZXiQ50E5tXpitS39H7AAIhMtrApxGocDoVv
         Tk7ZkAPH8AZU0di44pwhaiJuI+I0grRN14i4ubnxMo7DWGSFQ0iy4wv756IIlA1KUcBe
         MeA6MkNY6f0F6lQiIc+bDaJbRTd0qhkCTBNOO/MeJqoR53hDR4xyuNPoBx0RRnk26e5P
         wT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746518812; x=1747123612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6b4cUQ5rcJKQNEYnrxrGnyBTnIsL8X4xA1lXrOi9Rw=;
        b=qHM1Z+w++PWtcTHdCFu0fV3ELZzDjbbIvSzlLwR2ZjUycZ/1hgcsObEJl8GYLeU1qi
         aD1nyFdFdEf702ZWyk/WSmaYG2UfkEbp9Lu5CzbiDGsfd2Vqss0/JXrhO1dq92n+eJJj
         yktbnA+CueEbhnfnOruiObsk9Cwo3GXKUM83CJ30VKxT2xJV+hG2Y1sF/GseQT9uEeAe
         V8FVAcmOHZODvws1yBGt5jPbeozel8o+7JrdtLJihHTSi/0ZXYAIltrvg7OGgxo4lZFQ
         G5/MjRqth5Hq7SIpSigfnKSXpmufTiCz1bDVzH7sE7v/G4QZ3Txq3gySIZv0Rii2qLNR
         D6kw==
X-Forwarded-Encrypted: i=1; AJvYcCV412/9gT8sUU4XfcAWQBtuJJPXR+ZNA26IBz2qaFRdU4hXNkdBt02a7rickeRBIIy4s4dGhPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgaptRDKdT0DlNjH7HCW7J4KyZtuiG/X1WGOmYMggPgs7M79+
	e76aEp3A786+XFbYO7j/44xhtMYGUNMbgDNWTYi78Wmg1CFOoh8H
X-Gm-Gg: ASbGncsp2Ayxntpyqbf5anC8+ZAGEXT+El1JvUZDCsWO4qsHWEJEY2E8+tpRN+e6TEe
	GsggjcR1DNYg9uBZNkD0oanAy3xbLipeX1ARcHxPb61hBTRxJjGyUxPem6DaFextjLE8yasAkQw
	lRvQUokx0JGm8cVjj6kD4lnlqFpFh1+JrJSCTDBJB1sP93eLPlz9jiEIjkqyu06/+whk9XK/xJO
	f9VOsjrjtPVbfQHQo3GSXoAzgYpgD6jqjw/ogHsZoyVHpKlYAAcrKBGmw+Uv/gV/WjidvvSs+yG
	mCsQvqAx1HOWYvNaZVkh10D10IuEkBVKgX9uSboILL8DecyeS3mIsFw3Y7bghfF49dmX3U213o5
	q9rnItIeMR9yY
X-Google-Smtp-Source: AGHT+IGAfianIzom4PywFaAOGN+pLrKmWg/eTkmbuEy9IxRord1UaV+xOL68wY2iCqzb3ElK5PQ7Fg==
X-Received: by 2002:a05:600c:1e88:b0:43d:97ea:2f4 with SMTP id 5b1f17b1804b1-441c48be0bamr96267475e9.12.1746518811760;
        Tue, 06 May 2025 01:06:51 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc387sm163127765e9.4.2025.05.06.01.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 01:06:51 -0700 (PDT)
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
Subject: [PATCH v1] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
Date: Tue,  6 May 2025 11:06:47 +0300
Message-ID: <20250506080647.116702-1-maimon.sagi@gmail.com>
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
 drivers/ptp/ptp_ocp.c | 50 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 2ccdca4f6960..80481449dcd0 100644
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


