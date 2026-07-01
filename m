Return-Path: <netdev+bounces-303498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aSUNLZHARGoz0QoAu9opvQ
	(envelope-from <netdev+bounces-303498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:24:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A06EA9A5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:24:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eiVNJkwx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303498-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303498-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AB230465E3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF23B636A;
	Wed,  1 Jul 2026 07:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D280B3B3BED
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:22:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890531; cv=none; b=ocIJOiuUuOstogmUVaGqM9aQUEERNi0ZfH7xbsIgAWmVprdxTsW9M8SRR2Ii1ZgvGAElfo/VLlGnDMmvvCP8QVARsfj7r2rir2JzRD/SbC1SQDZIbAlP0Kr4JoilXmL/J9Esefh6lZ5RsWNGHG7TpRAtpoJJ8aNevaQKcJcnXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890531; c=relaxed/simple;
	bh=F7gC6fVxJoLAxCWWLELzCs+HUH91dTqEh3Z1id9LBDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmLZn1kUPGSULOwWQjfgi2ANTqCi/fnHILE7KH8zfSgP9H2zEGlHsKkLHEVvagavYhkAF0U8v3g2EEzB8BbadaFhGi+boQ4JDE4DZaVkrv3D/SGKVkFVjt6TDOLkXYRNf1PYCpfFMRTquEr2H6ZP2gIisx9FypB5MvEqz1rJUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiVNJkwx; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-472055b0efaso163626f8f.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782890528; x=1783495328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx2Ui+I3a67SiXGJxnNEBspO8LQYZ6ERw4bXMcU/KlQ=;
        b=eiVNJkwxAlLEhOiTXdOSQq1LZHvSsqb+g4W6Awfz2iWSCmQ6h3jG0i869WKumtKFSx
         QZ/cvkJVyUkbpONPgcQmYkIL4JluMy1cwijBTxcEEJAFkGUZhYj5mex3SOlhoe4a4xx4
         U0HU2Hy5qKLV7PWk3OBy6oA0SQwpttx5t/4Pibtxi92BMC6CkcrTBnj2XYCih+kkNc4q
         KhTZ+RdAXyL7TgS9Iaix1b/EYYEmEUijd/NXKMWmNjZXbq8JeLJjlSyUUuXotjqLHDOU
         Ez3Ik64TpCfgblgFZnjN5GTvQuSEPuxfa/M16hwVkf7bg6meniodWbPZobaLgQ7yCCvk
         DuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782890528; x=1783495328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx2Ui+I3a67SiXGJxnNEBspO8LQYZ6ERw4bXMcU/KlQ=;
        b=rJBm2/ei88rug1ujZTe6YIBQTT1Ya66IcUfiUbrK05B2JGWHoqvu087MSV+LvnlskA
         DOIhe4vDZc4Pib+wVBTJQmCuWk5OUw+YAUcn4HME45hfX1UwmK76KIEOgUDDcB5KPrQT
         KX/kSUe7AVKK2EvVG2BUkzSXJgeXhZOKmVSvK4g7qlY4X4Fn5DmCCl99pb1IjC0x6MdW
         6RspSzx8Kp+l0wBugFfU34MNOEnXP6urHs5rFRCipZfYit5TSRunfsEg7Lt/OfT3QBWS
         p3C7gSiOyrkNGgX2v4jiyRXRndorPgGdatg6oYIOtldNdNLLIc6LVfa/QekKtTTZwGe3
         qhiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpgg/U1dEkhMBrkr6GYgPBqwnUNl/C+pnLdLo/9mNrxCOsLQOaLrOznl1jj8c7TMa5V+LxYpt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnnfl3dsSgdc0RpWuHRJMcFIEawX+VNA4gTDVt/7Rk9nxLARuE
	1QfHKgMSZMHWdRnS0w8VgOUz5WjcSD1SO0PuzDRfr0WV/TFiBH5kFfIO
X-Gm-Gg: AfdE7cnV4/AUkS89u4GfeRQNU287i+uwcBCXqKoaIvTuilV/fQiAjKeFGS6NY90UgL8
	+VgnFe69+dC6NKdzl5GAnwFf6mSlHwE+aGCOTGjFfQMzFCZzblZL2Mhrwru9/IDeeSJhkjgTgfO
	BQIJoszCcXKI9feqmhgONdHbw62OlcDHySP+vGqte32QSWjyC0lEqiQi0zzRwVcB4ijswVWZkU/
	8r8hTCwCzqceUZzHcosvKV+LDgQbybPIo/UP7CGqQu0I+YBtn+pZi//bLJ6zdJlwTq5seAWx2Uj
	FPx+xxQRQ5q6yUG5bN++BpeOk2YKNp4pWfP8T1TLOzOtfwu8C5XnWgxG5SDgnCwmyq4XnGCgwe2
	QvCy8kzG4YSWAywx7qc15D7cXpLGGsuz2Bo6DOSaes66qTR05ITUd4cRHVbHmoPFU1TyKD4ngMa
	LW67bfJ/VfQoC3RUi+SjCORkLBOSTUhkOS7zFr7R7gwRw5wg3XRw==
X-Received: by 2002:a05:6000:27c9:20b0:460:70ff:fe14 with SMTP id ffacd0b85a97d-47759754d50mr461355f8f.42.1782890527971;
        Wed, 01 Jul 2026 00:22:07 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47560effc81sm14534095f8f.0.2026.07.01.00.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:22:07 -0700 (PDT)
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
Subject: [PATCH v3] ptp: ocp: add CPLD ISP support for ADVA TimeCard
Date: Wed,  1 Jul 2026 10:22:03 +0300
Message-ID: <20260701072203.4321-1-maimon.sagi@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-303498-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 164A06EA9A5

The ADVA TimeCard uses a Lattice MachXO3 CPLD that is programmed over
I2C using in-system programming (ISP).

The CPLD is connected to a secondary I2C bus controlled by the onboard
MicroBlaze. Add support for taking ownership of this bus and exposing
the required interfaces through sysfs, allowing userspace tools to
perform CPLD programming.

To limit the scope of this functionality, sysfs-based I2C access is
available only on ADVA TimeCard boards and only for the CPLD-related
I2C slave addresses used during ISP.

Add sysfs support to:
  - control ownership of the secondary I2C bus
  - access the CPLD-related I2C slave addresses required for ISP

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Addressed comments from:
 - Vadim Fedorenko : https://lore.kernel.org/all/c6aff5f7-e087-4bd9-b159-7adeb82e19f4@linux.dev/

Changes since version 2:
 - Allow I2C access via sysfs only on ADVA TimeCard boards.
 - Allow access only to the ADVA TimeCard-specific I2C slave
   addresses.
   
 drivers/ptp/ptp_ocp.c | 180 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1ad78..86c341ea4062 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -416,6 +416,10 @@ struct ptp_ocp {
 	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
+	/* cpld_i2c_xfer sysfs (adva_x1) */
+	struct mutex		tap_i2c_lock;
+	u8			tap_i2c_rsp[21]; /* [status, read_data...] */
+	size_t			tap_i2c_rsp_len;
 };
 
 #define OCP_REQ_TIMESTAMP	BIT(0)
@@ -3188,6 +3192,8 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	ptp_ocp_nmea_out_init(bp);
 	ptp_ocp_signal_init(bp);
 
+	mutex_init(&bp->tap_i2c_lock);
+
 	err = ptp_ocp_attr_group_add(bp, info->attr_groups);
 	if (err)
 		return err;
@@ -4224,6 +4230,171 @@ static const struct ocp_attr_group art_timecard_groups[] = {
 	{ },
 };
 
+static ssize_t
+i2c_bus_ctrl_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+
+	if (!bp->pps_select)
+		return -ENODEV;
+	return sysfs_emit(buf, "0x%08x\n",
+			  ioread32(&bp->pps_select->__pad1));
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
+	iowrite32(val, &bp->pps_select->__pad1);
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
+#define TAP_I2C_REQ_HDR_LEN   4
+#define TAP_I2C_MAX_WRITE_LEN 67
+#define TAP_I2C_MAX_READ_LEN  20
+#define TAP_I2C_FLAG_NOSTART  BIT(0)
+
+static int
+ptp_ocp_tap_i2c_find_adapter(struct device *dev, void *data)
+{
+	struct i2c_adapter **adap = data;
+
+	*adap = i2c_verify_adapter(dev);
+	return (*adap) ? 1 : 0;
+}
+
+static ssize_t
+ptp_ocp_cpld_i2c_write(struct file *file, struct kobject *kobj,
+		       const struct bin_attribute *attr,
+		       char *buf, loff_t off, size_t count)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	const u8 *req = (const u8 *)buf;
+	u8 addr, write_len, read_len, flags;
+	struct i2c_adapter *adap = NULL;
+	struct i2c_msg msgs[2];
+	u8 rdbuf[TAP_I2C_MAX_READ_LEN];
+	int nmsgs, ret, i;
+
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
+
+	if (!bp->i2c_ctrl)
+		return -ENODEV;
+	device_for_each_child(&bp->i2c_ctrl->dev, &adap,
+			      ptp_ocp_tap_i2c_find_adapter);
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
+		msgs[nmsgs].buf   = rdbuf;
+		nmsgs++;
+	}
+
+	ret = i2c_transfer(adap, msgs, nmsgs);
+
+	mutex_lock(&bp->tap_i2c_lock);
+	if (ret == nmsgs) {
+		bp->tap_i2c_rsp[0] = 0;
+		if (read_len > 0)
+			memcpy(&bp->tap_i2c_rsp[1], rdbuf, read_len);
+		bp->tap_i2c_rsp_len = 1 + read_len;
+		ret = count;
+	} else {
+		bp->tap_i2c_rsp[0]  = (u8)(ret < 0 ? -ret : EIO);
+		bp->tap_i2c_rsp_len = 1;
+		ret = (ret < 0) ? ret : -EIO;
+	}
+	mutex_unlock(&bp->tap_i2c_lock);
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
+	if (off > 0)
+		return 0;
+
+	mutex_lock(&bp->tap_i2c_lock);
+	ret = min(count, bp->tap_i2c_rsp_len);
+	memcpy(buf, bp->tap_i2c_rsp, ret);
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
@@ -4272,11 +4443,18 @@ static struct attribute *adva_timecard_x1_attrs[] = {
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
-- 
2.47.0


