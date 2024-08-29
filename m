Return-Path: <netdev+bounces-123441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A6B964DC4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768251F23F00
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EA1B8EB6;
	Thu, 29 Aug 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DAMyLLPr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAFB1B8E9E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956596; cv=none; b=T6Keef0OXx+4NeFxV3haQCv+nSTye27gnz+YWQ3nkQA7fgeZujgBL3ftw4I1kragIE9tl1JQezaB8G+NSrS6K98glytPnUAi1OjFa5qsdH5R9cfEDiRc2icSovvb3kDMRXkmJUqRmswp+I55RgF0xi/Lm3e3oyDsq/uc6tJ0nNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956596; c=relaxed/simple;
	bh=RDGS4D199vViLZqaJLWW8B1zF9GHwx2pHkF3lwa9VRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhWSEk6IcVo1Im9fPWKlAO+OWHe3fTl+jNuTEgC45bRDYgYl06hukz6V2LIF2p/2L5sjotog68ezQUE7AhbczFVpmk78Rz6Skv9xckpEE6CWxoUWbda8KbvgmR2BNdC/MXIvevdrteHCRjmpVlx4YOa0CIQVe43Hjr2TWdlbqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DAMyLLPr; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47TIY3It012390;
	Thu, 29 Aug 2024 11:36:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=QZLKuA+5LxEctATHbL4sA0ITTZl+t1sBaizwHhPVlWg=; b=
	DAMyLLPr2x96RKi/LtZr0VTnGZeUZ/7ySq0U3/EyUa0v85iSR2cV98j3Lzb2A+gi
	unhYVjN2VzrfJJVLpymb1Bowct9mQwAUa73ONz+zQVaXn68yojtnMTn0wQB8fgSj
	BhFwWq8pfKHtckG/F5FPOpvW552n74gKi+2dX/Zmg1Zsf+qKythZmIc8A0LSHk7m
	CMQazKgTELmX91k7ofXR5Nmm5fWHswEBoyY45I48/4GIu9iNSQQw3Y/1I/w0w7/N
	3/l7mv6nhqfWUVirPZRO11AKbc1MwlnC17zeziefCEHiE4L4bhhOF1hMZbHMH0vR
	9OqCUhEPfauUkCl8OLd/Hw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41axcg00kb-9
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
Subject: [PATCH net v7 2/3] ptp: ocp: adjust sysfs entries to expose tty information
Date: Thu, 29 Aug 2024 11:36:02 -0700
Message-ID: <20240829183603.1156671-3-vadfed@meta.com>
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
X-Proofpoint-GUID: irLqdfsA7XvU2i54qTQ6CtiYxUor897Z
X-Proofpoint-ORIG-GUID: irLqdfsA7XvU2i54qTQ6CtiYxUor897Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01

Implement additional attribute group to expose serial port information.
Fixes tag points to the commit which introduced the change in serial
port subsystem and made it impossible to use symlinks.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/ptp/ptp_ocp.c | 62 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 46369de8e30b..e7479b9b90cb 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3361,6 +3361,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
 static EXT_ATTR_RO(freq, frequency, 2);
 static EXT_ATTR_RO(freq, frequency, 3);
 
+static ssize_t
+ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
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
+
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
@@ -3790,6 +3838,7 @@ static const struct attribute_group fb_timecard_group = {
 
 static const struct ocp_attr_group fb_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &fb_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal2_group },
@@ -3829,6 +3878,7 @@ static const struct attribute_group art_timecard_group = {
 
 static const struct ocp_attr_group art_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &art_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ },
 };
 
@@ -3856,6 +3906,7 @@ static const struct attribute_group adva_timecard_group = {
 
 static const struct ocp_attr_group adva_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
 	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
@@ -4361,14 +4412,6 @@ ptp_ocp_complete(struct ptp_ocp *bp)
 {
 	struct pps_device *pps;
 	char buf[32];
-	int i;
-
-	for (i = 0; i < __PORT_COUNT; i++) {
-		if (bp->port[i].line != -1) {
-			sprintf(buf, "ttyS%d", bp->port[i].line);
-			ptp_ocp_link_child(bp, buf, ptp_ocp_tty_port_name(i));
-		}
-	}
 
 	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
 	ptp_ocp_link_child(bp, buf, "ptp");
@@ -4440,9 +4483,6 @@ ptp_ocp_detach_sysfs(struct ptp_ocp *bp)
 {
 	struct device *dev = &bp->dev;
 
-	sysfs_remove_link(&dev->kobj, "ttyGNSS");
-	sysfs_remove_link(&dev->kobj, "ttyGNSS2");
-	sysfs_remove_link(&dev->kobj, "ttyMAC");
 	sysfs_remove_link(&dev->kobj, "ptp");
 	sysfs_remove_link(&dev->kobj, "pps");
 }
-- 
2.43.5


