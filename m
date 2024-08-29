Return-Path: <netdev+bounces-123440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FB964DC3
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D20C284EB4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E191B86FA;
	Thu, 29 Aug 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fL5UsbEf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769E1B8E97
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956596; cv=none; b=Qp3g/osdAJ3F3vejyvtpNdIObekA8eUFQT4c4/ZeRPZFEku8llCHe19WcEQn7I+B/uk/lh1QFA+cWCu/GCRXJiAFlF/k8iktLBrg0YZshY49sUgJpSi0Rh+gSXu0DtAnmz4UMEvveC14PnGcDLUPHsCXf09dK7ZY1EfcZL4F1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956596; c=relaxed/simple;
	bh=5PrqF4QzCYMT6+Ei+ymTzindl5rt7fF4x6i/v36l3zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckYJbSu88bK02HW3h5dNW+Ic7vtZdnY1Cbu4P5rK1N0ug98YTec7dz9/ib0iqrcdeuiLCvEoyYD4czrCiFdry4qBXhcnNQ2HKQNGEYj+fkwNC1qPyjq0EtxckZi/eGnuoD/B0pnGRS5kMkstg1/2eeV1cS0EZQwdv7R5Dg8sugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fL5UsbEf; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47TIY3Is012390;
	Thu, 29 Aug 2024 11:36:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=EmJR7eQttSKLl7ffCvlpkLRyeA5+IY9YH2bJoIYeKGo=; b=
	fL5UsbEf9VVoijVQ9LWaToYUcuWHYijotjhVIn684MGPWP8rlm9ZBFJhXK8sZQH6
	WtMRF80I4tVZwFDekG/o6aDQurg3HmjRAk/6v712LoAsRqHg8ViesToztVIX/cBL
	CxsvcCZ7WLQ5N8e6R77Lv9ZuZKeLfWc2yfb52jhG2uYJJKNAsOEygon6R/40AEth
	1pmCpqYqkIyvqY6VwSJiKzsSas2/v2kHhD3uLbKkWgF7U0nyXRXAWQAjZr7CK5uB
	iUjeA0rh7Nhbz0MFCFxXLNhdZvTpYBBBA40YX7iB7uoZt7u5BqTK0CUZKVPWgoXD
	tCsQ0zZHytEqNF/YVw86CA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41axcg00kb-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Aug 2024 11:36:25 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 29 Aug 2024 18:36:15 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v7 1/3] ptp: ocp: convert serial ports to array
Date: Thu, 29 Aug 2024 11:36:01 -0700
Message-ID: <20240829183603.1156671-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829183603.1156671-1-vadfed@meta.com>
References: <20240829183603.1156671-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BEj17HGkjylJfwMCJdX7sJ5-TEv1gZhZ
X-Proofpoint-ORIG-GUID: BEj17HGkjylJfwMCJdX7sJ5-TEv1gZhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01

Simplify serial port management code by using array of ports and helpers
to get the name of the port. This change is needed to make the next
patch simplier.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/ptp/ptp_ocp.c | 120 ++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 63 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index ee2ced88ab34..46369de8e30b 100644
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
+	__PORT_COUNT,
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
+	struct ptp_ocp_serial_port	port[__PORT_COUNT];
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
@@ -1649,6 +1655,15 @@ ptp_ocp_tod_gnss_name(int idx)
 	return gnss_name[idx];
 }
 
+static const char *
+ptp_ocp_tty_port_name(int idx)
+{
+	static const char * const tty_name[] = {
+		"GNSS", "GNSS2", "MAC", "NMEA"
+	};
+	return tty_name[idx];
+}
+
 struct ptp_ocp_nvmem_match_info {
 	struct ptp_ocp *bp;
 	const void * const tag;
@@ -3960,16 +3975,11 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 	bp = dev_get_drvdata(dev);
 
 	seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
-	if (bp->gnss_port.line != -1)
-		seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS1",
-			   bp->gnss_port.line);
-	if (bp->gnss2_port.line != -1)
-		seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS2",
-			   bp->gnss2_port.line);
-	if (bp->mac_port.line != -1)
-		seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp->mac_port.line);
-	if (bp->nmea_port.line != -1)
-		seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp->nmea_port.line);
+	for (i = 0; i < __PORT_COUNT; i++) {
+		if (bp->port[i].line != -1)
+			seq_printf(s, "%7s: /dev/ttyS%d\n", ptp_ocp_tty_port_name(i),
+				   bp->port[i].line);
+	}
 
 	memset(sma_val, 0xff, sizeof(sma_val));
 	if (bp->sma_map1) {
@@ -4279,7 +4289,7 @@ ptp_ocp_dev_release(struct device *dev)
 static int
 ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 {
-	int err;
+	int i, err;
 
 	mutex_lock(&ptp_ocp_lock);
 	err = idr_alloc(&ptp_ocp_idr, bp, 0, 0, GFP_KERNEL);
@@ -4292,10 +4302,10 @@ ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_dev *pdev)
 
 	bp->ptp_info = ptp_ocp_clock_info;
 	spin_lock_init(&bp->lock);
-	bp->gnss_port.line = -1;
-	bp->gnss2_port.line = -1;
-	bp->mac_port.line = -1;
-	bp->nmea_port.line = -1;
+
+	for (i = 0; i < __PORT_COUNT; i++)
+		bp->port[i].line = -1;
+
 	bp->pdev = pdev;
 
 	device_initialize(&bp->dev);
@@ -4351,23 +4361,15 @@ ptp_ocp_complete(struct ptp_ocp *bp)
 {
 	struct pps_device *pps;
 	char buf[32];
+	int i;
 
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
+	for (i = 0; i < __PORT_COUNT; i++) {
+		if (bp->port[i].line != -1) {
+			sprintf(buf, "ttyS%d", bp->port[i].line);
+			ptp_ocp_link_child(bp, buf, ptp_ocp_tty_port_name(i));
+		}
 	}
+
 	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
 	ptp_ocp_link_child(bp, buf, "ptp");
 
@@ -4416,23 +4418,20 @@ ptp_ocp_info(struct ptp_ocp *bp)
 	};
 	struct device *dev = &bp->pdev->dev;
 	u32 reg;
+	int i;
 
 	ptp_ocp_phc_info(bp);
 
-	ptp_ocp_serial_info(dev, "GNSS", bp->gnss_port.line,
-			    bp->gnss_port.baud);
-	ptp_ocp_serial_info(dev, "GNSS2", bp->gnss2_port.line,
-			    bp->gnss2_port.baud);
-	ptp_ocp_serial_info(dev, "MAC", bp->mac_port.line, bp->mac_port.baud);
-	if (bp->nmea_out && bp->nmea_port.line != -1) {
-		bp->nmea_port.baud = -1;
+	for (i = 0; i < __PORT_COUNT; i++) {
+		if (i == PORT_NMEA && bp->nmea_out && bp->port[PORT_NMEA].line != -1) {
+			bp->port[PORT_NMEA].baud = -1;
 
-		reg = ioread32(&bp->nmea_out->uart_baud);
-		if (reg < ARRAY_SIZE(nmea_baud))
-			bp->nmea_port.baud = nmea_baud[reg];
-
-		ptp_ocp_serial_info(dev, "NMEA", bp->nmea_port.line,
-				    bp->nmea_port.baud);
+			reg = ioread32(&bp->nmea_out->uart_baud);
+			if (reg < ARRAY_SIZE(nmea_baud))
+				bp->port[PORT_NMEA].baud = nmea_baud[reg];
+		}
+		ptp_ocp_serial_info(dev, ptp_ocp_tty_port_name(i), bp->port[i].line,
+				    bp->port[i].baud);
 	}
 }
 
@@ -4473,14 +4472,9 @@ ptp_ocp_detach(struct ptp_ocp *bp)
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
+	for (i = 0; i < __PORT_COUNT; i++)
+		if (bp->port[i].line != -1)
+			serial8250_unregister_port(bp->port[i].line);
 	platform_device_unregister(bp->spi_flash);
 	platform_device_unregister(bp->i2c_ctrl);
 	if (bp->i2c_clk)
-- 
2.43.5


