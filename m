Return-Path: <netdev+bounces-305667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mb2JJOD2TWo7AwIAu9opvQ
	(envelope-from <netdev+bounces-305667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 09:06:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D518172275F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 09:06:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H8D4DKSn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305667-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305667-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C34030413BA
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67093E7160;
	Wed,  8 Jul 2026 06:56:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B33EB113
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 06:56:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493795; cv=none; b=J3TuZirpo6dLwEkSPw/6SCUhknfHVfol4UFV6bMASnphSBW3FezCd56YYUH/vfXKhXQO/T96WKW8hCfMN3HmBudbIY+n+RfQ/+6AtcTUcCYBsjX6A9F/p7pwzMo3hWcIvlwp9JAFEl/RL3juxVcbGhAYOcmhulm036AfkZ+hLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493795; c=relaxed/simple;
	bh=1FKe2TX7Gjuy3h2xx7B3oAONjhUqS+2QvXwby2KQRaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdMgLv6G6RRW+VATNQn7Xp8Yg3t5TKRGO6z/eyt8ALTeGAH93kXJ2pH2LteYljE4lgwFvQFyNbhaXilDuhgcs1rnUPSVH1ywDuxnipPS+tqtVJ8IpF7MlsSbG0Q0vLzKPdbWL0DdZwIsWHncfy1vnYJa6kokGi/bQE9PaMaDraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8D4DKSn; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472326ca506so191912f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783493781; x=1784098581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vI9njaoHlSmfbrEjfEwM6tvjjM1B+wcf+yru4QfyCHE=;
        b=H8D4DKSn6I6t9aAiB8iZehY8kEklPUL0s82RJ3dLboVyKCvE6IMjcnwW2+ca1UFjQE
         xpswA0okf3veDoAGiSvSTNYGjZNLpDYJ7c4Hd9DSeI1fyLUdMZM6Q2BHYD+RgRlrZOwW
         Y781wo3Ld06AVvkym4S/dB3mmdaqw5f5IzO7PZhgUIJL8OGCWBf54Iz8RMhpc0JgRWn2
         ejkb0M9aSmAekSOkmLAR1P00G3/5jA0XMYDNDVizs2D/xb8iqXVCPY6vzRlQFRmokD5p
         ZeE+Qd7P2IHH02PTMENue9SlGLoob8JL475+lDSVFuonSK+0SypMKRLCntc6tl0IzUa7
         OKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493781; x=1784098581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI9njaoHlSmfbrEjfEwM6tvjjM1B+wcf+yru4QfyCHE=;
        b=YZB7UbEvrNf6/uOKemMN4D+fHCWqGdntCJwmJFN/QV1NVtdIxKGL86z2aCEvUyY4WH
         WdM2/LhKhWjVE653RKsAEWawPc0gvvmDYeYKAldVaBvE1C2O936/5yQ2396Mv0ufiz41
         7uhvgnG7C4INWYkpLGIc//2mpsPNtznsSLLbJ4+IltncrYx8zUOE/z9YeUoo1miIvAnD
         J6dpBiVM8GAOWaDqxG2Y1h6BoeyqD1EiMEgVpJMYtKye7FvOk0Ip1AGUu1Z9oFpxE2ql
         U1pkxF6CLXjK1JLAvBugs2RGXj/LQa1q67hkyug+kXL3PZ5HBfDVGvQdK58Lv+p7FAxe
         9S7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqYNkX8VmzSWo8kvcwduxISG9pWJjbpmiB6Yg+LaWktWbfIAlL4ouq3kfHMgPnLUefSAWESjhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSuyBFc6XsnMdYpb9Z+GVscgB9g+BFs9S7wGyRS0bhGoPJJbP
	llcqKZee5SuCRkpXdFh1HXbtLla4R1yE3HghRujFEyxbUyLPXZ7CHWkk
X-Gm-Gg: AfdE7cmIcVU0JAjmTt06jNdg6u+fDIPf7+emzTr8TWdUPcoep87+bw1Fs4YNXLP+H3Z
	PWwzOyawh2+Tzyy0PPicJxE/Dm3NG1ZCfDeZMTTqkKyc2vdMY3IPgexHlpTiBDAGVJS3BxT00X+
	5QVSYc3ISR/Ba2qK14hH8pyeqYvflSfFyy6mE2n3w7oelUaFik2b3MRAagswCU7Xb0J05pN4DdB
	2nOzSutTuU2Zvpu42hPAo7OGtSDC7ZusYqWEAnGincoSvWyoav2ZfmBBfKAP9JGL7ynUqcfVUZu
	z3ZpOxnGBIn3OqVVKy8fJFhecQS5kKFmPBPcUyqJmoWAyGmIu5MLAfEhN+YuMpeop8FEbaaHszt
	rCVyfj2Pwg1fgPI49g05onakqOHMCzeUuYVj+4jSmldpf8Ic1YMvCbGJNPfq4oqLXHBIB8nYj1c
	OdJdEglLa4Qjj0a26jcXAE61TaW/fRHfOq3zfwZA+WEVefkYBpRHNuY0wNnYdu
X-Received: by 2002:a05:6000:428a:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-47df074a29fmr1045505f8f.26.1783493780459;
        Tue, 07 Jul 2026 23:56:20 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm43288404f8f.1.2026.07.07.23.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:56:20 -0700 (PDT)
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
Subject: [PATCH v4 1/1] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Wed,  8 Jul 2026 09:56:16 +0300
Message-ID: <20260708065616.16814-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305667-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maimonsagi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jonathan.lemon@gmail.com,m:vadim.fedorenko@linux.dev,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:maimon.sagi@gmail.com,m:jonathanlemon@gmail.com,m:andrew@lunn.ch,m:maimonsagi@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maimonsagi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D518172275F

The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
that is programmed over I2C using in-system programming (ISP).

The CPLD is connected to a secondary I2C bus shared with the onboard
MicroBlaze soft CPU.  Add support for taking ownership of this bus and
exposing the required interfaces through sysfs, allowing userspace tools
to perform CPLD programming.

To limit the scope of this functionality, sysfs-based I2C access is
restricted to the ADVA TimeCard X1 variant and only for the two I2C
slave addresses used during ISP (0x40 CPLD, 0x74 mux).

Add two sysfs attributes under /sys/class/timecard/ocpN/ (x1 only):

  i2c_bus_ctrl  - arbitrate the shared I2C bus from the MicroBlaze via
                  a three-step read/write/poll handshake

  cpld_i2c_xfer - binary passthrough for I2C transactions to the CPLD
                  and its PCA9548 mux; one atomic request per write()

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Addressed comments from:
 - Paolo Abeni : https://lore.kernel.org/all/20260707091926.88033-1-pabeni@redhat.com/
 
Changes since v3:

Changes since v3:

 - Make the new ABI X1-specific.  The base ADVA TimeCard variant does
   not expose cpld_i2c_xfer; the new i2c_bus_ctrl and cpld_i2c_xfer
   entries are documented as X1-only in Documentation/ABI/testing/
   sysfs-timecard.

 - Rename struct gpio_reg.__pad1 to i2c_bus_ctrl and document that the
   field at offset 0xC in pps_select is a live register on adva_x1 and
   reserved on the other variants.

 - Document i2c_bus_ctrl as the MicroBlaze I2C bus arbitration register
   and cpld_i2c_xfer as the X1-only binary passthrough ABI, including
   the 4-byte request header, address allowlist, NOSTART flag rules,
   status byte encoding, and partial-read behavior.

 - Guard tap_i2c_lock initialisation and teardown so they run only on
   the adva_x1 path; the base ADVA variant does not use the CPLD I2C
   state.

 - Replace the per-call device_for_each_child() adapter lookup with a
   cached adapter number set by the existing I2C bus notifier.  Use
   i2c_get_adapter()/i2c_put_adapter() in cpld_i2c_write() so the
   adapter is reference-counted and safe against concurrent unbind.
   Remove the now-unused helper.

 - Reject non-zero file offsets in cpld_i2c_write() and honour the
   offset in cpld_i2c_read() so the bin_attribute follows the usual
   partial-read/write rules.

 - Reject TAP_I2C_FLAG_NOSTART when write_len == 0; that flag is only
   valid for the read phase of a combined write+read transfer.

 - Replace the stack read buffer with i2c_get_dma_safe_msg_buf() /
   i2c_put_dma_safe_msg_buf() so the I2C message buffer is safe for
   adapters that use DMA.

 - Serialize the full transfer+publish path with tap_i2c_lock so
   concurrent writers cannot overwrite each other's response in
   tap_i2c_rsp.

 - Add tap_i2c_errno_to_byte() so the one-byte status field does not
   truncate large errno values to a wrong value or false success.
 
 Documentation/ABI/testing/sysfs-timecard |  78 ++++++++
 drivers/ptp/ptp_ocp.c                    | 240 ++++++++++++++++++++++-
 2 files changed, 313 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
index 3ae41b7634ac..c033d2f90d7e 100644
--- a/Documentation/ABI/testing/sysfs-timecard
+++ b/Documentation/ABI/testing/sysfs-timecard
@@ -291,3 +291,81 @@ Description:	(RW) The DCF and IRIG output signals are in UTC, while the
 		these formats.
 
 		The offset may be changed by writing an unsigned integer.
+
+What:		/sys/class/timecard/ocpN/i2c_bus_ctrl
+Date:		July 2026
+Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
+Description:	(RW) MicroBlaze I2C bus arbitration register used on
+		ADVA TimeCard X1 boards.
+
+		This file is a userspace ABI and must remain backward
+		compatible.
+
+		The register controls ownership of the I2C bus shared between
+		the host and the on-board MicroBlaze soft CPU.
+
+		Read 0x00000000 to confirm the bus is free.  Write 0x0000ffff
+		to request ownership, then poll reads until 0xffffffff is
+		returned.  Write 0x00000000 to release the bus.
+
+		Values are read and written as hexadecimal strings, for
+		example 0x0000ffff.
+
+
+What:		/sys/class/timecard/ocpN/cpld_i2c_xfer
+Date:		July 2026
+Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
+Description:	(RW, binary) I2C passthrough endpoint for ADVA TimeCard X1
+		TAP CPLD transactions.
+
+		This file is a userspace ABI and must remain backward
+		compatible.
+
+		The binary attribute is present only on ADVA TimeCard X1
+		boards.  Each write() supplies one complete request and the
+		file offset must be zero.
+
+		Write request layout (byte offsets):
+
+		+--------+----------+-----------+-------+----------------+
+		| Byte 0 | Byte 1   | Byte 2    | Byte3 | Bytes 4..      |
+		+--------+----------+-----------+-------+----------------+
+		| addr   | write_len| read_len  | flags | write_data[]   |
+		+--------+----------+-----------+-------+----------------+
+
+		Header length is 4 bytes.
+
+		Request constraints:
+
+		  - addr allowlist is exactly 0x40 (CPLD) and 0x74 (mux)
+		  - write_len maximum is 67 bytes
+		  - read_len maximum is 20 bytes
+		  - at least one of write_len/read_len must be non-zero
+		  - request write size is 4 + write_len bytes
+
+		flags field:
+
+		  bit 0 (0x01): apply I2C_M_NOSTART to the read segment.
+		                Valid only when write_len > 0 and read_len > 0.
+		  all other bits: reserved for future use.
+
+		Read response layout (byte offsets):
+
+		+--------+----------------+
+		| Byte 0 | Bytes 1..      |
+		+--------+----------------+
+		| status | read_data[]    |
+		+--------+----------------+
+
+		status byte semantics:
+
+		  - 0x00 means transfer succeeded
+		  - non-zero means errno value encoded as a positive byte
+		  - errno values that do not fit in one byte are reported as
+		    EIO
+
+		On success, response length is 1 + read_len bytes.
+		On failure, response length is 1 byte (status only).
+
+		read() supports partial reads at non-zero offsets in the usual
+		bin_attribute manner.
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78..8df9feb030aa 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -163,7 +163,8 @@ struct gpio_reg {
 	u32	gpio1;
 	u32	__pad0;
 	u32	gpio2;
-	u32	__pad1;
+	/* adva_x1: I2C bus ownership register; reserved on other variants */
+	u32	i2c_bus_ctrl;
 };
 
 struct irig_master_reg {
@@ -416,6 +417,11 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* cpld_i2c_xfer sysfs (adva_x1) */
+	struct mutex		tap_i2c_lock;
+	int			tap_i2c_adap_nr; /* adapter nr; -1 if absent */
+	u8			tap_i2c_rsp[21]; /* [status, read_data...] */
+	size_t			tap_i2c_rsp_len;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -3188,6 +3194,12 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	ptp_ocp_nmea_out_init(bp);
 	ptp_ocp_signal_init(bp);
 
+	/* tap_i2c is x1-only; the base adva variant has no CPLD I2C path. */
+	if (info->attr_groups == adva_timecard_x1_groups) {
+		mutex_init(&bp->tap_i2c_lock);
+		bp->tap_i2c_adap_nr = -1;
+	}
+
 	err = ptp_ocp_attr_group_add(bp, info->attr_groups);
 	if (err)
 		return err;
@@ -4224,6 +4236,210 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+/*
+ * i2c_bus_ctrl exposes the MicroBlaze I2C bus arbitration register.
+ *
+ * The shared bus requires a three-step handshake before use:
+ *   read 0x00000000 (free) -> write 0x0000ffff (request) ->
+ *   poll until 0xffffffff (MicroBlaze confirms release).
+ *
+ * The poll is a PCIe non-posted read, which also flushes the preceding
+ * posted write to the FPGA, so no separate kernel read-back is needed.
+ */
+static ssize_t
+i2c_bus_ctrl_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+
+	if (!bp->pps_select)
+		return -ENODEV;
+	return sysfs_emit(buf, "0x%08x\n",
+			  ioread32(&bp->pps_select->i2c_bus_ctrl));
+}
+
+static ssize_t
+i2c_bus_ctrl_store(struct device *dev, struct device_attribute *attr,
+		   const char *buf, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!bp->pps_select)
+		return -ENODEV;
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+	iowrite32(val, &bp->pps_select->i2c_bus_ctrl);
+	return count;
+}
+
+static DEVICE_ATTR_RW(i2c_bus_ctrl);
+
+/*
+ * cpld_i2c_xfer - sysfs binary I2C passthrough for adva_x1 TAP CPLD.
+ *
+ * write: [addr][write_len][read_len][flags][write_data...]
+ *   flags bit 0: I2C_M_NOSTART on the read segment
+ * read:  [status][read_data...]
+ *   status 0 = success, else positive errno
+ *
+ * Only addresses 0x40 (CPLD) and 0x74 (mux) are permitted.
+ */
+#define TAP_I2C_ALLOWED_ADDRS_NUM  2
+static const u8 tap_i2c_allowed_addrs[TAP_I2C_ALLOWED_ADDRS_NUM] = {
+	0x40, /* CPLD */
+	0x74, /* mux  */
+};
+
+/*
+ * tap_i2c_errno_to_byte - encode a kernel errno as a one-byte status.
+ *
+ * Errnos > 255 (e.g. ENOTSUPP=524) or multiples of 256 would truncate
+ * to a wrong or zero value with a plain (u8) cast.  Map those to EIO.
+ */
+static u8 tap_i2c_errno_to_byte(int err)
+{
+	int val = (err < 0) ? -err : EIO;
+
+	return (val > 0 && val <= 0xFF) ? (u8)val : EIO;
+}
+
+#define TAP_I2C_REQ_HDR_LEN   4
+#define TAP_I2C_MAX_WRITE_LEN 67
+#define TAP_I2C_MAX_READ_LEN  20
+#define TAP_I2C_FLAG_NOSTART  BIT(0)
+
+static ssize_t
+ptp_ocp_cpld_i2c_write(struct file *file, struct kobject *kobj,
+		       const struct bin_attribute *attr,
+		       char *buf, loff_t off, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	const u8 *req = (const u8 *)buf;
+	u8 addr, write_len, read_len, flags;
+	struct i2c_adapter *adap;
+	struct i2c_msg msgs[2];
+	u8 *rdbuf = NULL;
+	int nmsgs, ret, i;
+
+	/* Each write is one atomic request; non-zero offset means a
+	 * mid-buffer pwrite() which would misparse the header.
+	 */
+	if (off != 0)
+		return -EINVAL;
+	if (count < TAP_I2C_REQ_HDR_LEN || count > TAP_I2C_REQ_HDR_LEN + TAP_I2C_MAX_WRITE_LEN)
+		return -EINVAL;
+
+	addr      = req[0];
+	write_len = req[1];
+	read_len  = req[2];
+	flags     = req[3];
+
+	/* Validate */
+	for (i = 0; i < TAP_I2C_ALLOWED_ADDRS_NUM; i++)
+		if (addr == tap_i2c_allowed_addrs[i])
+			break;
+	if (i == TAP_I2C_ALLOWED_ADDRS_NUM)
+		return -EPERM;
+
+	if (write_len > TAP_I2C_MAX_WRITE_LEN)
+		return -EINVAL;
+	if (read_len > TAP_I2C_MAX_READ_LEN)
+		return -EINVAL;
+	if (write_len + TAP_I2C_REQ_HDR_LEN > count)
+		return -EINVAL;
+	if (write_len == 0 && read_len == 0)
+		return -EINVAL;
+	/* I2C_M_NOSTART suppresses the repeated START between write and read
+	 * segments; it has no meaning on a first-and-only message.
+	 */
+	if ((flags & TAP_I2C_FLAG_NOSTART) && write_len == 0)
+		return -EINVAL;
+
+	/* i2c_get_adapter() takes a reference under core_lock; safe against
+	 * concurrent adapter unbind.
+	 */
+	adap = i2c_get_adapter(READ_ONCE(bp->tap_i2c_adap_nr));
+	if (!adap)
+		return -ENODEV;
+
+	nmsgs = 0;
+	if (write_len > 0) {
+		msgs[nmsgs].addr  = addr;
+		msgs[nmsgs].flags = 0;
+		msgs[nmsgs].len   = write_len;
+		msgs[nmsgs].buf   = (u8 *)req + TAP_I2C_REQ_HDR_LEN;
+		nmsgs++;
+	}
+	if (read_len > 0) {
+		u16 rd_flags = I2C_M_RD;
+
+		if (flags & TAP_I2C_FLAG_NOSTART)
+			rd_flags |= I2C_M_NOSTART;
+		msgs[nmsgs].addr  = addr;
+		msgs[nmsgs].flags = rd_flags;
+		msgs[nmsgs].len   = read_len;
+		/* Allocate a DMA-safe bounce buffer if needed; see
+		 * Documentation/i2c/dma-considerations.rst.
+		 */
+		rdbuf = i2c_get_dma_safe_msg_buf(&msgs[nmsgs], 1);
+		if (!rdbuf) {
+			i2c_put_adapter(adap);
+			return -ENOMEM;
+		}
+		msgs[nmsgs].buf = rdbuf;
+		nmsgs++;
+	}
+
+	/* Serialise transfer+publish so concurrent writers cannot overwrite
+	 * each other's response in tap_i2c_rsp.
+	 */
+	mutex_lock(&bp->tap_i2c_lock);
+	ret = i2c_transfer(adap, msgs, nmsgs);
+	if (ret == nmsgs) {
+		bp->tap_i2c_rsp[0] = 0;
+		if (read_len > 0)
+			memcpy(&bp->tap_i2c_rsp[1], rdbuf, read_len);
+		bp->tap_i2c_rsp_len = 1 + read_len;
+		ret = count;
+	} else {
+		bp->tap_i2c_rsp[0]  = tap_i2c_errno_to_byte(ret);
+		bp->tap_i2c_rsp_len = 1;
+		ret = (ret < 0) ? ret : -EIO;
+	}
+	mutex_unlock(&bp->tap_i2c_lock);
+	/* Free bounce buffer after data is copied; put adapter reference. */
+	if (read_len > 0)
+		i2c_put_dma_safe_msg_buf(rdbuf, &msgs[nmsgs - 1], ret > 0);
+	i2c_put_adapter(adap);
+
+	return ret;
+}
+
+static ssize_t
+ptp_ocp_cpld_i2c_read(struct file *file, struct kobject *kobj,
+		      const struct bin_attribute *attr,
+		      char *buf, loff_t off, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	ssize_t ret;
+
+	mutex_lock(&bp->tap_i2c_lock);
+	if (off >= bp->tap_i2c_rsp_len) {
+		ret = 0;
+	} else {
+		ret = min(count, bp->tap_i2c_rsp_len - (size_t)off);
+		memcpy(buf, bp->tap_i2c_rsp + off, ret);
+	}
+	mutex_unlock(&bp->tap_i2c_lock);
+	return ret;
+}
+
+static const struct bin_attribute tap_i2c_bin_attr = {
+	.attr  = { .name = "cpld_i2c_xfer", .mode = 0600 },
+	.write = ptp_ocp_cpld_i2c_write,
+	.read  = ptp_ocp_cpld_i2c_read,
+};
+
 static struct attribute *adva_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
 	&dev_attr_gnss_sync.attr,
@@ -4272,11 +4488,18 @@ static struct attribute *adva_timecard_x1_attrs[] = {
 	&dev_attr_ts_window_adjust.attr,
 	&dev_attr_utc_tai_offset.attr,
 	&dev_attr_tod_correction.attr,
+	&dev_attr_i2c_bus_ctrl.attr,
+	NULL,
+};
+
+static const struct bin_attribute *const bin_adva_x1_timecard_attrs[] = {
+	&tap_i2c_bin_attr,
 	NULL,
 };
 
 static const struct attribute_group adva_timecard_x1_group = {
-	.attrs = adva_timecard_x1_attrs,
+	.attrs     = adva_timecard_x1_attrs,
+	.bin_attrs = bin_adva_x1_timecard_attrs,
 };
 
 static const struct ocp_attr_group adva_timecard_x1_groups[] = {
@@ -4902,6 +5125,8 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
+	if (bp->tap_i2c_adap_nr != 0)	/* initialised only on adva_x1 */
+		mutex_destroy(&bp->tap_i2c_lock);
 	device_unregister(&bp->dev);
 }
 
@@ -5217,11 +5442,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+	if (add) {
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		/* Cache adapter number; cpld_i2c_xfer uses i2c_get_adapter()
+		 * for a reference-counted, unbind-safe lookup.
+		 */
+		WRITE_ONCE(bp->tap_i2c_adap_nr, i2c_verify_adapter(child)->nr);
+	} else {
+		WRITE_ONCE(bp->tap_i2c_adap_nr, -1);	/* invalidate before free */
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
-
+	}
 	return 0;
 }
 
-- 
2.47.0


