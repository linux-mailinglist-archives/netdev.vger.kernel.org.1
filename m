Return-Path: <netdev+bounces-265963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA0ZL0vor2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E40248C2C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00DE63185850
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081243DA51;
	Tue, 10 Mar 2026 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWQ8tMqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2443E481
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135368; cv=none; b=OYNamaSJGQvLOZY99ohdyZ1K68ipPOvO4osCaSCgCKSoHVhd7GAbDvSZ5SIAOOog5BIVAYuQlSVFuMdiX+vY5BviP5X6d/xJlrSQ6Iq+pCZZsXNpnvkvQfetU/ANndEO4pnJh86dUzZ6BVAPsJyVQMGow+spDqJZDujw6WkxdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135368; c=relaxed/simple;
	bh=vB2eIbykiMnA3yfQpooTS6uXpG7mqrONeiuKGg9flgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r93qUpL/gq/I0tnp9KrTKGI3S3t4DVkrDcPfHJYY2Fkgx295UiQL+iqxRDDPcrnYdpfnEr7GOYcnNz5H4N3nzL5TSs53mu7HOtWxeBwz8EqZYOwheCBFCZe7IiQm/o7dTx00yrabWG8sfz3zrzRyAu9ddX50RiT+ThgZWOYxCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWQ8tMqG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so28825875e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773135364; x=1773740164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sNG++RVCuARHyfsWywRbjnWRDMOSZkzCYxWKH0PX6I=;
        b=DWQ8tMqGIg//J4nBxYlXcrauPN1+2k49bhWxkDO49oAnjlDE2bYKsUL59J0L1EN73N
         q9ntcuS8IrkHyg84r/YEOotlfWc2NarKkLQ+uRFlWirqBxu5UrGi9EgwMM4/vaPuUTGZ
         358foWQd4SRQBYWaYMa3dxpZJyfpjQPMACqxmgPtQwgbvtuoB/MDVOZGcsMaVnIl0Fez
         QBnAoElo7C5NL7IQgzSm3h0XHM/CI6hJ6tDKAD6SKYFVHuhFohFfSec3tFlRsm2CpABP
         VV5jLwdF7UAUDwo4CtvQ0TVCpGe+jbZErCVV8gjQ91nfRd/hKNr1KRZi3nq1gxLU/VMw
         5l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135364; x=1773740164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sNG++RVCuARHyfsWywRbjnWRDMOSZkzCYxWKH0PX6I=;
        b=kdgBI4mt8UChKlAGr9aGGCxX0lh5yBojZGV1lDXqWovnBrW3PK3IKYMUxKZ9VLAaCf
         wbvU5hRkB5WdhHXsfl4Sqg8z4aISiTnQGyeYt+KZ2Yk4gyNoaFnvFIklwPDxmVYhw5Hi
         bss6WdEUNhQhe1lYS3I6NN85baKFCiQYS+uaeMl/jeNPcJWGGb71sUUSkfr3BOqN5wMc
         0MXCwdm6GxvUl4dQO1WasS4wGKFZfPi/Re3w6fN5mFFqkwN5kBYOPvc0Ixg1BChHHUV5
         4IHSJ5hSM8wynaKUCapR4bsjU4DK/CTCrRENd9aBzMtB7xhNtPqxiIREivWl0Vx4loH0
         u/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr2KqE5CT6Ca1rGI7nADauROHR5HSCWba1hl5ZLicjBh3529uuwcrqWcT9BHt+FX2FqfC1wEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWxULOofk9jz3KlgmMyMOrX9HwXnuUtdCRbf4Y6Xb7muzIUFq
	WsJfRzJQEAn7LSOoF/JGiqOkr1tQDL1rCSg6YtxhwabVCh/pURR/8Owv
X-Gm-Gg: ATEYQzwNCGpkGKhcf5LH44TmHf3uzdAfnKopX8xfMc4AWbi4B1RseHzk8LKS4HMIjSs
	f1TXYKpo8xj5t36gg51rSXiKKaQ3q3MMGAWXFG1IeJnIr3NV2/EJoIDAMCLyujl2FNjA7yDsNZB
	4/U9BSeQttminTIWVBUoUWtfBv/RzKsVPbjutgCpemdpjPEyA/OaDbGrMFifJfBy3NU5XChoXjh
	Ju4gjINSktArR44Mq8PCqJ3t/WSOHVkO8mAn3m0oSIb5OFGlnjYws8KyvU0DUajQVc5UNZB3+U5
	Ir95/hJQZvhjHnV/QgcYJC6z5b00ZFqFpG2kjkmWR3dcj3lTpyuxV/Aat5D7ldxVDMurpmGASoB
	oLXL+S5kJPO9Zrt+y/fXyCfDpQEyziFQy4SXRUHSKwmoqJrkcvjCPQ2M/rIO2FWKOy8G3TIAnT4
	xedH27xaw6+x5+EyXMpC/1rXUlpggbrtZBSoeIRs+9Wl0pbxS41yuvTOZG2YUa
X-Received: by 2002:a05:600c:3b83:b0:485:35d3:ce57 with SMTP id 5b1f17b1804b1-48535d3cf0cmr159423665e9.34.1773135364255;
        Tue, 10 Mar 2026 02:36:04 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9ccsm33964056f8f.19.2026.03.10.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:36:03 -0700 (PDT)
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
	Sagi Maimon <maimon.sagi@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4] ptp: ocp: Add support for Xilinx-based Adva TimeCard variant Add support for the Adva TimeCard model built on a Xilinx-based design. This patch enables detection and integration of the new hardware within the existing OCP timecard framework. The Xilinx variant relies on the shared driver infrastructure, requiring only small, targeted additions to accommodate its specific characteristics.
Date: Tue, 10 Mar 2026 11:35:57 +0200
Message-ID: <20260310093559.222360-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36E40248C2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	LONG_SUBJ(3.00)[401];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265963-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maimonsagi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,spinics.net:url]
X-Rspamd-Action: no action

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
---
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603100054.UoKwTVMf-lkp@intel.com/
---
Addressed comments from Simon Horman and Vadim Fedorenko:
 - https://www.spinics.net/lists/netdev/msg1160388.html
 - https://www.spinics.net/lists/netdev/msg1160386.html

Changes since v3:
 - Corrected the Signed-off-by email address (previous version used the wrong one)

Changes since v2:
 - Fix W=1 build warnings reported by kernel test robot
 - Define SMA op structures only after full type is visible

Changes since v1:
 - Removed duplicated Adva init functions
 - Unified logic with variant‑specific data
---
 drivers/ptp/ptp_ocp.c | 365 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 337 insertions(+), 28 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index d88ab2f86b1b..1689ecb592f4 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -35,6 +35,7 @@
 
 #define PCI_VENDOR_ID_ADVA			0xad5a
 #define PCI_DEVICE_ID_ADVA_TIMECARD		0x0400
+#define PCI_DEVICE_ID_ADVA_TIMECARD_X1	0x0410
 
 static struct class timecard_class = {
 	.name		= "timecard",
@@ -72,6 +73,20 @@ struct ptp_ocp_servo_conf {
 	u32	servo_drift_i;
 };
 
+/*
+ * Combined servo + board-variant parameters for ADVA boards.
+ * Embedded in the resource table .extra so a single ptp_ocp_adva_board_init()
+ * can handle both ADVA and ADVA-X1 without per-variant init functions.
+ */
+struct ptp_ocp_adva_info {
+	struct ptp_ocp_servo_conf	servo;
+	u32				flash_start;
+	const struct ocp_sma_op		*sma_op;
+	u8				signals_nr;
+	u8				freq_in_nr;
+	const struct ocp_attr_group	*attr_groups;
+};
+
 #define OCP_CTRL_ENABLE		BIT(0)
 #define OCP_CTRL_ADJUST_TIME	BIT(1)
 #define OCP_CTRL_ADJUST_OFFSET	BIT(2)
@@ -293,6 +308,20 @@ struct ocp_attr_group {
 	const struct attribute_group *group;
 };
 
+struct ocp_selector {
+	const char *name;
+	int value;
+	u64 frequency;
+};
+
+struct ocp_sma_op {
+	const struct ocp_selector *tbl[2];
+	void (*init)(struct ptp_ocp *bp);
+	u32 (*get)(struct ptp_ocp *bp, int sma_nr);
+	int (*set_inputs)(struct ptp_ocp *bp, int sma_nr, u32 val);
+	int (*set_output)(struct ptp_ocp *bp, int sma_nr, u32 val);
+};
+
 #define OCP_CAP_BASIC	BIT(0)
 #define OCP_CAP_SIGNAL	BIT(1)
 #define OCP_CAP_FREQ	BIT(2)
@@ -420,12 +449,17 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static const struct ocp_sma_op ocp_adva_sma_op;
+static const struct ocp_sma_op ocp_adva_x1_sma_op;
+
 static const struct ocp_attr_group fb_timecard_groups[];
 
 static const struct ocp_attr_group art_timecard_groups[];
 
 static const struct ocp_attr_group adva_timecard_groups[];
 
+static const struct ocp_attr_group adva_timecard_x1_groups[];
+
 struct ptp_ocp_eeprom_map {
 	u16	off;
 	u16	len;
@@ -1020,11 +1054,225 @@ static struct ocp_resource ocp_adva_resource[] = {
 	},
 	{
 		.setup = ptp_ocp_adva_board_init,
-		.extra = &(struct ptp_ocp_servo_conf) {
-			.servo_offset_p = 0xc000,
-			.servo_offset_i = 0x1000,
-			.servo_drift_p = 0,
-			.servo_drift_i = 0,
+		.extra = &(struct ptp_ocp_adva_info) {
+			.servo = {
+				.servo_offset_p = 0xc000,
+				.servo_offset_i = 0x1000,
+				.servo_drift_p = 0,
+				.servo_drift_i = 0,
+			},
+			.flash_start  = 0xA00000,
+			.sma_op       = &ocp_adva_sma_op,
+			.signals_nr   = 2,
+			.freq_in_nr   = 2,
+			.attr_groups  = adva_timecard_groups,
+		},
+	},
+	{ }
+};
+
+static struct ocp_resource ocp_adva_x1_resource[] = {
+	{
+		OCP_MEM_RESOURCE(reg),
+		.offset = 0x01000000, .size = 0x10000,
+	},
+	{
+		OCP_EXT_RESOURCE(ts0),
+		.offset = 0x01010000, .size = 0x10000, .irq_vec = 1,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 0,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts1),
+		.offset = 0x01020000, .size = 0x10000, .irq_vec = 2,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts2),
+		.offset = 0x01060000, .size = 0x10000, .irq_vec = 6,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts3),
+		.offset = 0x01110000, .size = 0x10000, .irq_vec = 15,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 3,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts4),
+		.offset = 0x01120000, .size = 0x10000, .irq_vec = 16,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 4,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	/* Timestamp for PHC and/or PPS generator */
+	{
+		OCP_EXT_RESOURCE(pps),
+		.offset = 0x010C0000, .size = 0x10000, .irq_vec = 0,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 5,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[0]),
+		.offset = 0x010D0000, .size = 0x10000, .irq_vec = 11,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[1]),
+		.offset = 0x010E0000, .size = 0x10000, .irq_vec = 12,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[2]),
+		.offset = 0x010F0000, .size = 0x10000, .irq_vec = 13,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 3,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[3]),
+		.offset = 0x01100000, .size = 0x10000, .irq_vec = 14,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 4,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_ext),
+		.offset = 0x01030000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_clk),
+		.offset = 0x01040000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(tod),
+		.offset = 0x01050000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(image),
+		.offset = 0x00020000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_select),
+		.offset = 0x00130000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map1),
+		.offset = 0x00140000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map2),
+		.offset = 0x00220000, .size = 0x1000,
+	},
+	{
+		OCP_SERIAL_RESOURCE(port[PORT_GNSS]),
+		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 9600,
+		},
+	},
+	{
+		OCP_SERIAL_RESOURCE(port[PORT_MAC]),
+		.offset = 0x00180000 + 0x1000, .irq_vec = 5,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 115200,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[0]),
+		.offset = 0x01200000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[1]),
+		.offset = 0x01210000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[2]),
+		.offset = 0x01220000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[3]),
+		.offset = 0x01230000, .size = 0x10000,
+	},
+	{
+		OCP_SPI_RESOURCE(spi_flash),
+		.offset = 0x00310000, .size = 0x10000, .irq_vec = 9,
+		.extra = &(struct ptp_ocp_flash_info) {
+			.name = "xilinx_spi", .pci_offset = 0,
+			.data_size = sizeof(struct xspi_platform_data),
+			.data = &(struct xspi_platform_data) {
+				.num_chipselect = 1,
+				.bits_per_word = 8,
+				.num_devices = 1,
+				.force_irq = true,
+				.devices = &(struct spi_board_info) {
+					.modalias = "spi-nor",
+				},
+			},
+		},
+	},
+	{
+		OCP_I2C_RESOURCE(i2c_ctrl),
+		.offset = 0x00150000, .size = 0x10000, .irq_vec = 7,
+		.extra = &(struct ptp_ocp_i2c_info) {
+			.name = "xiic-i2c",
+			.fixed_rate = 50000000,
+			.data_size = sizeof(struct xiic_i2c_platform_data),
+			.data = &(struct xiic_i2c_platform_data) {
+				.num_devices = 2,
+				.devices = (struct i2c_board_info[]) {
+					{ I2C_BOARD_INFO("24c02", 0x50) },
+					{ I2C_BOARD_INFO("24mac402", 0x58),
+					  .platform_data = "mac" },
+				},
+			},
+		},
+	},
+	{
+		.setup = ptp_ocp_adva_board_init,
+		.extra = &(struct ptp_ocp_adva_info) {
+			.servo = {
+				.servo_offset_p = 0xc000,
+				.servo_offset_i = 0x1000,
+				.servo_drift_p = 0,
+				.servo_drift_i = 0,
+			},
+			.flash_start  = 0x1000000,
+			.sma_op       = &ocp_adva_x1_sma_op,
+			.signals_nr   = 4,
+			.freq_in_nr   = 4,
+			.attr_groups  = adva_timecard_x1_groups,
 		},
 	},
 	{ }
@@ -1035,6 +1283,7 @@ static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
+	{ PCI_DEVICE_DATA(ADVA, TIMECARD_X1, &ocp_adva_x1_resource) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
@@ -1042,12 +1291,6 @@ MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
 static DEFINE_MUTEX(ptp_ocp_lock);
 static DEFINE_IDR(ptp_ocp_idr);
 
-struct ocp_selector {
-	const char *name;
-	int value;
-	u64 frequency;
-};
-
 static const struct ocp_selector ptp_ocp_clock[] = {
 	{ .name = "NONE",	.value = 0 },
 	{ .name = "TOD",	.value = 1 },
@@ -1137,12 +1380,32 @@ static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
 	{ }
 };
 
-struct ocp_sma_op {
-	const struct ocp_selector *tbl[2];
-	void (*init)(struct ptp_ocp *bp);
-	u32 (*get)(struct ptp_ocp *bp, int sma_nr);
-	int (*set_inputs)(struct ptp_ocp *bp, int sma_nr, u32 val);
-	int (*set_output)(struct ptp_ocp *bp, int sma_nr, u32 val);
+static const struct ocp_selector ptp_ocp_adva_x1_sma_in[] = {
+	{ .name = "PPS1",	.value = 0x0001,      .frequency = 1 },
+	{ .name = "TS1",	.value = 0x0004,      .frequency = 0 },
+	{ .name = "TS2",	.value = 0x0008,      .frequency = 0 },
+	{ .name = "TS3",    .value = 0x0040,      .frequency = 0 },
+	{ .name = "TS4",    .value = 0x0080,      .frequency = 0 },
+	{ .name = "FREQ1",	.value = 0x0100,      .frequency = 0 },
+	{ .name = "FREQ2",	.value = 0x0200,      .frequency = 0 },
+	{ .name = "FREQ3",  .value = 0x0400,      .frequency = 0 },
+	{ .name = "FREQ4",  .value = 0x0800,      .frequency = 0 },
+	{ .name = "None",	.value = SMA_DISABLE, .frequency = 0 },
+	{ }
+};
+
+static const struct ocp_selector ptp_ocp_adva_x1_sma_out[] = {
+	{ .name = "10Mhz",	.value = 0x0000,  .frequency = 10000000},
+	{ .name = "PHC",	.value = 0x0001,  .frequency = 1 },
+	{ .name = "MAC",	.value = 0x0002,  .frequency = 1 },
+	{ .name = "GNSS1",	.value = 0x0004,  .frequency = 1 },
+	{ .name = "GEN1",	.value = 0x0040 },
+	{ .name = "GEN2",	.value = 0x0080 },
+	{ .name = "GEN3",	.value = 0x0100 },
+	{ .name = "GEN4",	.value = 0x0200 },
+	{ .name = "GND",	.value = 0x2000 },
+	{ .name = "VCC",	.value = 0x4000 },
+	{ }
 };
 
 static void
@@ -2639,6 +2902,14 @@ static const struct ocp_sma_op ocp_adva_sma_op = {
 	.set_output	= ptp_ocp_sma_adva_set_output,
 };
 
+static const struct ocp_sma_op ocp_adva_x1_sma_op = {
+	.tbl		= { ptp_ocp_adva_x1_sma_in, ptp_ocp_adva_x1_sma_out },
+	.init		= ptp_ocp_sma_fb_init,
+	.get		= ptp_ocp_sma_fb_get,
+	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
+	.set_output	= ptp_ocp_sma_adva_set_output,
+};
+
 static int
 ptp_ocp_set_pins(struct ptp_ocp *bp)
 {
@@ -2887,18 +3158,19 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	return ptp_ocp_init_clock(bp, r->extra);
 }
 
-/* ADVA specific board initializers; last "resource" registered. */
+/* ADVA board initializer; variant differences come from r->extra. */
 static int
 ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 {
-	int err;
+	struct ptp_ocp_adva_info *info = r->extra;
 	u32 version;
+	int err;
 
-	bp->flash_start = 0xA00000;
-	bp->eeprom_map = fb_eeprom_map;
-	bp->sma_op = &ocp_adva_sma_op;
-	bp->signals_nr = 2;
-	bp->freq_in_nr = 2;
+	bp->flash_start = info->flash_start;
+	bp->eeprom_map  = fb_eeprom_map;
+	bp->sma_op      = info->sma_op;
+	bp->signals_nr  = info->signals_nr;
+	bp->freq_in_nr  = info->freq_in_nr;
 
 	version = ioread32(&bp->image->version);
 	/* if lower 16 bits are empty, this is the fw loader. */
@@ -2906,15 +3178,15 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		version = version >> 16;
 		bp->fw_loader = true;
 	}
-	bp->fw_tag = 3;
+	bp->fw_tag     = 3;
 	bp->fw_version = version & 0xffff;
-	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
+	bp->fw_cap     = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
 
 	ptp_ocp_tod_init(bp);
 	ptp_ocp_nmea_out_init(bp);
 	ptp_ocp_signal_init(bp);
 
-	err = ptp_ocp_attr_group_add(bp, adva_timecard_groups);
+	err = ptp_ocp_attr_group_add(bp, info->attr_groups);
 	if (err)
 		return err;
 
@@ -2923,7 +3195,7 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 		return err;
 	ptp_ocp_sma_init(bp);
 
-	return ptp_ocp_init_clock(bp, r->extra);
+	return ptp_ocp_init_clock(bp, &info->servo);
 }
 
 static ssize_t
@@ -3982,6 +4254,43 @@ static const struct ocp_attr_group adva_timecard_groups[] = {
 	{ },
 };
 
+static struct attribute *adva_timecard_x1_attrs[] = {
+	&dev_attr_serialnum.attr,
+	&dev_attr_gnss_sync.attr,
+	&dev_attr_clock_source.attr,
+	&dev_attr_available_clock_sources.attr,
+	&dev_attr_sma1.attr,
+	&dev_attr_sma2.attr,
+	&dev_attr_sma3.attr,
+	&dev_attr_sma4.attr,
+	&dev_attr_available_sma_inputs.attr,
+	&dev_attr_available_sma_outputs.attr,
+	&dev_attr_clock_status_drift.attr,
+	&dev_attr_clock_status_offset.attr,
+	&dev_attr_ts_window_adjust.attr,
+	&dev_attr_utc_tai_offset.attr,
+	&dev_attr_tod_correction.attr,
+	NULL,
+};
+
+static const struct attribute_group adva_timecard_x1_group = {
+	.attrs = adva_timecard_x1_attrs,
+};
+
+static const struct ocp_attr_group adva_timecard_x1_groups[] = {
+	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_x1_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal2_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal3_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq1_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq2_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq3_group },
+	{ },
+};
+
 static void
 gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
 	       const char *def)
-- 
2.47.0


