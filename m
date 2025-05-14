Return-Path: <netdev+bounces-190333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F9AB648B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DB016A039
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12018C933;
	Wed, 14 May 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNlmhIeA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087AE55B;
	Wed, 14 May 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208149; cv=none; b=fWLKh+cssXK/ibzdxXSKfygC2xGjbOEIFDw7J4JwgTUNYtx5CNao2U6oaevdtrhsGpt9kdgskgjQ+muWXbeLIkqwquWqCw0KSHebtBbz1+AHTKSS+VT9p6pIh0gY54OiLdBMoYmlplQjJMueVWUVZeoRHZLLPdNzybYqvDpC6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208149; c=relaxed/simple;
	bh=OOOOn912lXFs2smEIwrvy1xSU9BCFYHFtFCKTzjR2xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIbzWt0nX+3fJMn4aXa0ufh8PeQszWBfUIelOLOkcLSgvxcpRRY9peTeS8njyJKB1GkxOuEl/sqMfWtCq49nSQAkKmD9HCh8lcyiRJHbtsTCE1g0lAE9eTKZHqvB2akqOnyhTRE2Kk4lXxLxvEeup/ETsCtkk9X4s7OTtYn/g4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNlmhIeA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a1fb17bb8cso4145204f8f.0;
        Wed, 14 May 2025 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747208145; x=1747812945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul5ASNAAqaRo57R6T172xXbaOjPecgoWC4kEAPl+0WA=;
        b=PNlmhIeA2GsCzT+Pe5qxzcRqiwLEdqx7g+4Gq5XfcgbEoM7ur67/Lz4nB+Y7mE7pJ5
         WAg32esUM6/Szeky2APvvVZuJGL/d0tx2VDbQzpuDPEnTe5jgsO9CyWHgegNEf0F6gm8
         ZiPurvz8hNlFJAXFxjMw3cCxoj1KZlkO8B5SLZs1//IBk/Px3dsPCqde0XdvubDyjz7Y
         omn8IjbrSnAFK/hOlTaZyy8+67/z1lXDe1Kq3pe8GRGb5zYMbc8Og9q8up9YmPmDR4eF
         2/BXgE0GIj16TDBEeA/dpam10yRKrTTNEboktaTB+xLZOG1auoSMRpyr7sAILISC1J3E
         SpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747208145; x=1747812945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ul5ASNAAqaRo57R6T172xXbaOjPecgoWC4kEAPl+0WA=;
        b=DiuvlfvEaOh7nwhu6uQOKYkwsv8j7lXe3QiGOJlFkRtAaiyGjUyELPxUnXKSbgDNSz
         VqdhmDgRWGXEB2T1VIrW5uvBBAOOtXjfV9gSBtA/v7aKJfJEv5Ygq4KAh75gZYBM+f9k
         LIBP2RDf5ojD53aVgn5vlE5rG45bx5miRy+/mB2dHehHnGzD/cEPG0r1I8bw+jaHCZ3I
         3hbsLeUXy0UbP/trSURlAg+7qMhy88s9l7X2ExkX1XLTkPhTsYP6bZP/xNiNxG/beaF7
         K4EjP1nf5e5ICHXe02BZPox9+jNE7qKuBL+jUwrU3/nvtAF9FkdC5M/rvWpJiPDCUQwh
         CoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYIbv5HRCUZl23HVSN6ISF+KitZW/l1W7KpVN9kCvWzUFThvvaWFpAnO93xHoql92i3dtdyVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKCpVz0norUzosxThzDdbg0aXzYFljEQB+/ijq0K+1yHvyIR4
	R0+aUzMjKohuKDb3J33lBoSDpx/61H2PG3XiUgUndTORnEGMwywbFNCleBsjyec=
X-Gm-Gg: ASbGncupohApScell59T7cztBistfce0iIooGDNuTVEzBrALS6a8y3fHnh8xcxfw9KW
	02l98eO2J/ggLzSyq5zNdAIN9hgIgDKIvZ9dx5BwQKpHTJYS0a2jUzfrtuf0tzYCITmJvo5c72b
	LWHQmcYKZY/IhwH7W+VAfJp0xsX3VXfMp5Tj0RyXWmDeweI7cA/w5bWv+6s5nvUybc0eAJG+jdz
	qI/OiUFZUJwEbCz2qVzLGR0D9L8uH88eZblJPkSLGPeuzrNusdqcCmP9y4MRCeko4N7QTH1HTBc
	2WY0N5TOrHF0DnWVHL0Xtb1gQzsyrnPpc/qjg07UTFsmZ0tqAaTvWBwwP2YP3bYywgDY7Vg5muo
	mR4w07oSl/EiI
X-Google-Smtp-Source: AGHT+IGwSbCTBRmv6Oqn2oCWAU+RV3ceeVmjLx7z/b1CEEgub3G4qNbpYnPJ+pIaA6n08/cBLfamsw==
X-Received: by 2002:a05:6000:1864:b0:3a2:1fd:afd9 with SMTP id ffacd0b85a97d-3a34994faf5mr1882054f8f.58.1747208144654;
        Wed, 14 May 2025 00:35:44 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951b6dsm17924165e9.17.2025.05.14.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 00:35:44 -0700 (PDT)
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
Subject: [PATCH v5] ptp: ocp: Limit signal/freq counts in summary output functions
Date: Wed, 14 May 2025 10:35:41 +0300
Message-ID: <20250514073541.35817-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs summary output could access uninitialized elements in
the freq_in[] and signal_out[] arrays, causing NULL pointer
dereferences and triggering a kernel Oops (page_fault_oops).
This patch adds u8 fields (nr_freq_in, nr_signal_out) to track the
number of initialized elements, with a maximum of 4 per array.
The summary output functions are updated to respect these limits,
preventing out-of-bounds access and ensuring safe array handling.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
Addressed comments from Vadim Fedorenko:
- https://www.spinics.net/lists/kernel/msg5683022.html
Addressed comments from Jakub Kicinski:
- https://www.spinics.net/lists/netdev/msg1091131.html
Changes since v4:
- remove fix from signal/freq show/store routines.
---
---
 drivers/ptp/ptp_ocp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 2ccdca4f6960..e63481f24238 100644
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
@@ -4008,7 +4018,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 {
 	struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
 	struct ptp_ocp_signal *signal = &bp->signal[nr];
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4031,7 +4041,7 @@ static void
 _frequency_summary_show(struct seq_file *s, int nr,
 			struct frequency_reg __iomem *reg)
 {
-	char label[8];
+	char label[16];
 	bool on;
 	u32 val;
 
@@ -4175,11 +4185,11 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
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


