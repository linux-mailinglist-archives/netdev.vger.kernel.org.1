Return-Path: <netdev+bounces-118840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D88952EA1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88971F21B32
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AD19DFB8;
	Thu, 15 Aug 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TbDYD9Dj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D819EEB6
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726773; cv=none; b=LtCyIq6RHcKtgwlYHlXLU1V9aGOq4wy3k2AJJqQDtm1JqenKj/ErItUXqAqUx/SU7srS556hkfwsPNzAW5NBLk2fXl3hihBUAQUs4QT7GJNE2L0im02dDwQkoIwPLAN8sHxIIiVDw6a5r4/Xl9yB7g1mnpaG8PZG4qJr9dAjeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726773; c=relaxed/simple;
	bh=l8KALvFU55z/SuZpwLYrvPuayOn5emFuLxfa3tdKSDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhaROIalTbSMnV6DLXaMJWhmKuz7HZWmlbPwWo2MnWyzbCxg+1BYF3KZfVTUPxLCn8d2cDClgoRSgYCKqxQlce16+0ituUOalW9sKDvNooCQFl2IeRFw7ftuC4cmIZO6PaKwnrkYAtqbemzyf4dTaCVo21Hg10o+EBI7vtUvA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TbDYD9Dj; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FC1a8h007134;
	Thu, 15 Aug 2024 05:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=4RQ
	bOXf6HVC3m39sMM1x4nQ+uqwmf9HpbxZHCQsxqe8=; b=TbDYD9DjQADCMAeudlC
	3DW1HYgrdXXNzzwZCmtPN8mcJW6vB0Y+3dngssRBXDuDJyyS6sngZUrQcGzKdukz
	ecAUJ7ae4BPyJozNn7Igs0D91GlS64OkfPgJF7nkP7hqj5EfRh5btxuR5HcRlT+z
	KhGoD1WXRCOtnkt+bGH6f3qsBCsNhfwjWMH2Pv6F7c3zJBjnrvo372h5PWJMeF8+
	JEE0B4xQW9GxGQuWZ/zqaxGcfwn9otuNXB2GkOXodXb5fLJo+b8N+X/qQimBeanH
	38yuFK5E3Fldlh/uOoNPtSrXNvet0Gbi6/qb1uEdR4UxUYcGizsP/MVUoZSFrTxi
	LMA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 410u2c7ang-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 Aug 2024 05:59:18 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 15 Aug 2024 12:59:16 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty information
Date: Thu, 15 Aug 2024 05:59:04 -0700
Message-ID: <20240815125905.1667148-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rEECcQxDY2XQNug4nM4PtK6UY79lZDJ2
X-Proofpoint-ORIG-GUID: rEECcQxDY2XQNug4nM4PtK6UY79lZDJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_03,2024-08-15_01,2024-05-17_01

Starting v6.8 the serial port subsystem changed the hierarchy of devices
and symlinks are not working anymore. Previous discussion made it clear
that the idea of symlinks for tty devices was wrong by design. Implement
additional attributes to expose the information. Fixes tag points to the
commit which introduced the change.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v2 -> v3:
- replace serial ports definitions with array and enum for index
- replace pointer math with direct array access
- nit in documentation spelling
v1 -> v2:
- add Documentation/ABI changes
---
 drivers/ptp/ptp_ocp.c | 158 +++++++++++++++++++++++++-----------------
 1 file changed, 96 insertions(+), 62 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index ee2ced88ab34..7d50b49bf684 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -316,6 +316,15 @@ struct ptp_ocp_serial_port {
 #define OCP_SERIAL_LEN			6
 #define OCP_SMA_NUM			4
 
+enum {
+	PORT_GNSS,
+	PORT_GNSS2,
+	PORT_MAC, /* miniature atomic clock */
+	PORT_NMEA,
+
+	PORT_NUM_MAX
+};
+
 struct ptp_ocp {
 	struct pci_dev		*pdev;
 	struct device		dev;
@@ -357,10 +366,7 @@ struct ptp_ocp {
 	struct delayed_work	sync_work;
 	int			id;
 	int			n_irqs;
-	struct ptp_ocp_serial_port	gnss_port;
-	struct ptp_ocp_serial_port	gnss2_port;
-	struct ptp_ocp_serial_port	mac_port;   /* miniature atomic clock */
-	struct ptp_ocp_serial_port	nmea_port;
+	struct ptp_ocp_serial_port	port[PORT_NUM_MAX];
 	bool			fw_loader;
 	u8			fw_tag;
 	u16			fw_version;
@@ -655,28 +661,28 @@ static struct ocp_resource ocp_fb_resource[] = {
 		},
 	},
 	{
-		OCP_SERIAL_RESOURCE(gnss_port),
+		OCP_SERIAL_RESOURCE(port[PORT_GNSS]),
 		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 115200,
 		},
 	},
 	{
-		OCP_SERIAL_RESOURCE(gnss2_port),
+		OCP_SERIAL_RESOURCE(port[PORT_GNSS2]),
 		.offset = 0x00170000 + 0x1000, .irq_vec = 4,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 115200,
 		},
 	},
 	{
-		OCP_SERIAL_RESOURCE(mac_port),
+		OCP_SERIAL_RESOURCE(port[PORT_MAC]),
 		.offset = 0x00180000 + 0x1000, .irq_vec = 5,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 57600,
 		},
 	},
 	{
-		OCP_SERIAL_RESOURCE(nmea_port),
+		OCP_SERIAL_RESOURCE(port[PORT_NMEA]),
 		.offset = 0x00190000 + 0x1000, .irq_vec = 10,
 	},
 	{
@@ -740,7 +746,7 @@ static struct ocp_resource ocp_art_resource[] = {
 		.offset = 0x01000000, .size = 0x10000,
 	},
 	{
-		OCP_SERIAL_RESOURCE(gnss_port),
+		OCP_SERIAL_RESOURCE(port[PORT_GNSS]),
 		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 115200,
@@ -839,7 +845,7 @@ static struct ocp_resource ocp_art_resource[] = {
 		},
 	},
 	{
-		OCP_SERIAL_RESOURCE(mac_port),
+		OCP_SERIAL_RESOURCE(port[PORT_MAC]),
 		.offset = 0x00190000, .irq_vec = 7,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 9600,
@@ -950,14 +956,14 @@ static struct ocp_resource ocp_adva_resource[] = {
 		.offset = 0x00220000, .size = 0x1000,
 	},
 	{
-		OCP_SERIAL_RESOURCE(gnss_port),
+		OCP_SERIAL_RESOURCE(port[PORT_GNSS]),
 		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 9600,
 		},
 	},
 	{
-		OCP_SERIAL_RESOURCE(mac_port),
+		OCP_SERIAL_RESOURCE(port[PORT_MAC]),
 		.offset = 0x00180000 + 0x1000, .irq_vec = 5,
 		.extra = &(struct ptp_ocp_serial_port) {
 			.baud = 115200,
@@ -3346,6 +3352,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
 static EXT_ATTR_RO(freq, frequency, 2);
 static EXT_ATTR_RO(freq, frequency, 3);
 
+static ssize_t
+ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+	struct ptp_ocp_serial_port *port;
+
+	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
+}
+
+static umode_t
+ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ptp_ocp_serial_port *port;
+	struct device_attribute *dattr;
+	struct dev_ext_attribute *ea;
+
+	if (strncmp(attr->name, "tty", 3))
+		return attr->mode;
+
+	dattr = container_of(attr, struct device_attribute, attr);
+	ea = container_of(dattr, struct dev_ext_attribute, attr);
+	port = &bp->port[(uintptr_t)ea->var];
+	return port->line == -1 ? 0 : 0444;
+}
+#define EXT_TTY_ATTR_RO(_name, _val)			\
+	struct dev_ext_attribute dev_attr_tty##_name =	\
+		{ __ATTR(tty##_name, 0444, ptp_ocp_tty_show, NULL), (void *)_val }
+
+static EXT_TTY_ATTR_RO(GNSS, PORT_GNSS);
+static EXT_TTY_ATTR_RO(GNSS2, PORT_GNSS2);
+static EXT_TTY_ATTR_RO(MAC, PORT_MAC);
+static EXT_TTY_ATTR_RO(NMEA, PORT_NMEA);
+static struct attribute *ptp_ocp_timecard_tty_attrs[] = {
+	&dev_attr_ttyGNSS.attr.attr,
+	&dev_attr_ttyGNSS2.attr.attr,
+	&dev_attr_ttyMAC.attr.attr,
+	&dev_attr_ttyNMEA.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ptp_ocp_timecard_tty_group = {
+	.name = "tty",
+	.attrs = ptp_ocp_timecard_tty_attrs,
+	.is_visible = ptp_ocp_timecard_tty_is_visible,
+};
+
 static ssize_t
 serialnum_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -3775,6 +3829,7 @@ static const struct attribute_group fb_timecard_group = {
 
 static const struct ocp_attr_group fb_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &fb_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal2_group },
@@ -3814,6 +3869,7 @@ static const struct attribute_group art_timecard_group = {
 
 static const struct ocp_attr_group art_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &art_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ },
 };
 
@@ -3841,6 +3897,7 @@ static const struct attribute_group adva_timecard_group = {
 
 static const struct ocp_attr_group adva_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
 	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
@@ -3960,16 +4017,16 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 	bp = dev_get_drvdata(dev);
 
 	seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
-	if (bp->gnss_port.line != -1)
+	if (bp->port[PORT_GNSS].line != -1)
 		seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS1",
-			   bp->gnss_port.line);
-	if (bp->gnss2_port.line != -1)
+			   bp->port[PORT_GNSS].line);
+	if (bp->port[PORT_GNSS2].line != -1)
 		seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS2",
-			   bp->gnss2_port.line);
-	if (bp->mac_port.line != -1)
-		seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp->mac_port.line);
-	if (bp->nmea_port.line != -1)
-		seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp->nmea_port.line);
+			   bp->port[PORT_GNSS2].line);
+	if (bp->port[PORT_MAC].line != -1)
+		seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp->port[PORT_MAC].line);
+	if (bp->port[PORT_NMEA].line != -1)
+		seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp->port[PORT_NMEA].line);
 
 	memset(sma_val, 0xff, sizeof(sma_val));
 	if (bp->sma_map1) {
@@ -4279,7 +4336,7 @@ ptp_ocp_dev_release(struct device *dev)
 static int
 ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 {
-	int err;
+	int i, err;
 
 	mutex_lock(&ptp_ocp_lock);
 	err = idr_alloc(&ptp_ocp_idr, bp, 0, 0, GFP_KERNEL);
@@ -4292,10 +4349,10 @@ ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 
 	bp->ptp_info = ptp_ocp_clock_info;
 	spin_lock_init(&bp->lock);
-	bp->gnss_port.line = -1;
-	bp->gnss2_port.line = -1;
-	bp->mac_port.line = -1;
-	bp->nmea_port.line = -1;
+
+	for (i = 0; i < PORT_NUM_MAX; i++)
+		bp->port[i].line = -1;
+
 	bp->pdev = pdev;
 
 	device_initialize(&bp->dev);
@@ -4352,22 +4409,6 @@ ptp_ocp_complete(struct ptp_ocp *bp)
 	struct pps_device *pps;
 	char buf[32];
 
-	if (bp->gnss_port.line != -1) {
-		sprintf(buf, "ttyS%d", bp->gnss_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyGNSS");
-	}
-	if (bp->gnss2_port.line != -1) {
-		sprintf(buf, "ttyS%d", bp->gnss2_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyGNSS2");
-	}
-	if (bp->mac_port.line != -1) {
-		sprintf(buf, "ttyS%d", bp->mac_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyMAC");
-	}
-	if (bp->nmea_port.line != -1) {
-		sprintf(buf, "ttyS%d", bp->nmea_port.line);
-		ptp_ocp_link_child(bp, buf, "ttyNMEA");
-	}
 	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
 	ptp_ocp_link_child(bp, buf, "ptp");
 
@@ -4419,20 +4460,21 @@ ptp_ocp_info(struct ptp_ocp *bp)
 
 	ptp_ocp_phc_info(bp);
 
-	ptp_ocp_serial_info(dev, "GNSS", bp->gnss_port.line,
-			    bp->gnss_port.baud);
-	ptp_ocp_serial_info(dev, "GNSS2", bp->gnss2_port.line,
-			    bp->gnss2_port.baud);
-	ptp_ocp_serial_info(dev, "MAC", bp->mac_port.line, bp->mac_port.baud);
-	if (bp->nmea_out && bp->nmea_port.line != -1) {
-		bp->nmea_port.baud = -1;
+	ptp_ocp_serial_info(dev, "GNSS", bp->port[PORT_GNSS].line,
+			    bp->port[PORT_GNSS].baud);
+	ptp_ocp_serial_info(dev, "GNSS2", bp->port[PORT_GNSS2].line,
+			    bp->port[PORT_GNSS2].baud);
+	ptp_ocp_serial_info(dev, "MAC", bp->port[PORT_MAC].line,
+			    bp->port[PORT_MAC].baud);
+	if (bp->nmea_out && bp->port[PORT_NMEA].line != -1) {
+		bp->port[PORT_NMEA].baud = -1;
 
 		reg = ioread32(&bp->nmea_out->uart_baud);
 		if (reg < ARRAY_SIZE(nmea_baud))
-			bp->nmea_port.baud = nmea_baud[reg];
+			bp->port[PORT_NMEA].baud = nmea_baud[reg];
 
-		ptp_ocp_serial_info(dev, "NMEA", bp->nmea_port.line,
-				    bp->nmea_port.baud);
+		ptp_ocp_serial_info(dev, "NMEA", bp->port[PORT_NMEA].line,
+				    bp->port[PORT_NMEA].baud);
 	}
 }
 
@@ -4441,9 +4483,6 @@ ptp_ocp_detach_sysfs(struct ptp_ocp *bp)
 {
 	struct device *dev = &bp->dev;
 
-	sysfs_remove_link(&dev->kobj, "ttyGNSS");
-	sysfs_remove_link(&dev->kobj, "ttyGNSS2");
-	sysfs_remove_link(&dev->kobj, "ttyMAC");
 	sysfs_remove_link(&dev->kobj, "ptp");
 	sysfs_remove_link(&dev->kobj, "pps");
 }
@@ -4473,14 +4512,9 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	for (i = 0; i < 4; i++)
 		if (bp->signal_out[i])
 			ptp_ocp_unregister_ext(bp->signal_out[i]);
-	if (bp->gnss_port.line != -1)
-		serial8250_unregister_port(bp->gnss_port.line);
-	if (bp->gnss2_port.line != -1)
-		serial8250_unregister_port(bp->gnss2_port.line);
-	if (bp->mac_port.line != -1)
-		serial8250_unregister_port(bp->mac_port.line);
-	if (bp->nmea_port.line != -1)
-		serial8250_unregister_port(bp->nmea_port.line);
+	for (i = 0; i < PORT_NUM_MAX; i++)
+		if (bp->port[i].line != -1)
+			serial8250_unregister_port(bp->port[i].line);
 	platform_device_unregister(bp->spi_flash);
 	platform_device_unregister(bp->i2c_ctrl);
 	if (bp->i2c_clk)
-- 
2.43.5


