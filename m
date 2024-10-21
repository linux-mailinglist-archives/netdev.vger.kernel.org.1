Return-Path: <netdev+bounces-137520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67A9A6C09
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA481F235C5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0813A1F9AAF;
	Mon, 21 Oct 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BllTxixU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4231F5830;
	Mon, 21 Oct 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520685; cv=none; b=mC/T8QWSl11JhZqQZeayJS+03pVLYvfiKNrf4kkAxfxTwvhi6uPRgTK0Imic9ey9HdYXWm+kQWL1NE2sLcP4KqmgfBqGN2lbhi+yJOEH1VBQ9rHnzHxilbm+eJlpr0mUW56RG3giYGB5KLM/Q7Wrt0DDKuMAL5maGj5YqtpNl1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520685; c=relaxed/simple;
	bh=BWH78xnQQ0mBNPfZL+4Dfj88mfDX/d6wVTXi2veRfQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcSvAscRE/u14FpHXVSjWJa7giHj4pAg2CU8E6mT7iCONp4vOe3trZA9iZ9mShzHToQeQHNNNhQ17HeErMznwU/vExN2TUvxzdUJC9UAlmy5o25TCYJLpqN3ZXjRUYmufAaW1qZ7+KuOTOaFNJ0nxLpgPHyom+NaR7Ns/55Ffbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BllTxixU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729520683; x=1761056683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWH78xnQQ0mBNPfZL+4Dfj88mfDX/d6wVTXi2veRfQc=;
  b=BllTxixUdYw3BpXJd3iRlDgNuKCn3lEd7XKeUsaa5rRvROwPE6pTFzQS
   RaSrsisXjq6ndzcLZ6OuilDexgSVDQExgiM0p/ApsnKjG27nXbtW8Jufv
   kvGSf6701NRRgA1YznEKEaLXOjjqrnPD6J5+S40PDkbCxlux+V7ODvHZg
   gWXH55TcuZTobBgJSTkGVGyGj2EL7sb+s0EyZQnPCj8FrmWeCsCtgqECQ
   saQIRPhYsf6Ap6G0hwgtrV9X11/dYP8bUL/CiDhacwLanizRBS7x56Vch
   lceoV//SRyPXkx6ruPbU9G/GQet2kDl63LgTeiqj/ek3fJvWWVqNQMZUu
   Q==;
X-CSE-ConnectionGUID: GjPK5y1ORRWVoHMf4H+GCA==
X-CSE-MsgGUID: R3FjQfKzQEyLgX6VQUEZQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28781487"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28781487"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:24:43 -0700
X-CSE-ConnectionGUID: GSfk1+MeQAai4XGcozJrSg==
X-CSE-MsgGUID: gmDL5iN/TyStqyJJLBmfZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="102857325"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 21 Oct 2024 07:24:40 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 1/2] ptp: add control over HW timestamp latch point
Date: Mon, 21 Oct 2024 16:19:54 +0200
Message-Id: <20241021141955.1466979-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
References: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently HW support of PTP/timesync solutions in network PHY chips can be
implemented with two different approaches, the timestamp maybe latched
either at the beginning or after the Start of Frame Delimiter (SFD) [1].

Allow ptp device drivers to provide user with control over the HW
timestamp latch point with ptp sysfs ABI.

[1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 Documentation/ABI/testing/sysfs-ptp | 12 ++++++++
 drivers/ptp/ptp_sysfs.c             | 44 +++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h    | 29 +++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-ptp b/Documentation/ABI/testing/sysfs-ptp
index 9c317ac7c47a..a0d89e0fd72e 100644
--- a/Documentation/ABI/testing/sysfs-ptp
+++ b/Documentation/ABI/testing/sysfs-ptp
@@ -140,3 +140,15 @@ Description:
 		PPS events to the Linux PPS subsystem. To enable PPS
 		events, write a "1" into the file. To disable events,
 		write a "0" into the file.
+
+What:		/sys/class/ptp/ptp<N>/ts_point
+Date:		October 2024
+Contact:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
+Description:
+		This file provides control over the point in time in
+		which the HW timestamp is latched. As specified in IEEE
+		802.3cx, the latch point can be either at the beginning
+		or after the end of Start of Frame Delimiter (SFD).
+		Value "0" means the timestamp is latched at the
+		beginning of the SFD. Value "1" means that timestamp is
+		latched after the end of SFD.
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6b1b8f57cd95..7e9f6ef368b6 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -28,6 +28,46 @@ static ssize_t max_phase_adjustment_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_phase_adjustment);
 
+static ssize_t ts_point_show(struct device *dev, struct device_attribute *attr,
+			     char *page)
+{
+	struct ptp_clock *ptp = dev_get_drvdata(dev);
+	enum ptp_ts_point point;
+	int err;
+
+	if (!ptp->info->get_ts_point)
+		return -EOPNOTSUPP;
+	err = ptp->info->get_ts_point(ptp->info, &point);
+	if (err)
+		return err;
+
+	return sysfs_emit(page, "%d\n", point);
+}
+
+static ssize_t ts_point_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct ptp_clock *ptp = dev_get_drvdata(dev);
+	enum ptp_ts_point point;
+	int err;
+	u8 val;
+
+	if (!ptp->info->set_ts_point)
+		return -EOPNOTSUPP;
+	if (kstrtou8(buf, 0, &val))
+		return -EINVAL;
+	if (val > PTP_TS_POINT_MAX)
+		return -EINVAL;
+	point = val;
+
+	err = ptp->info->set_ts_point(ptp->info, point);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_RW(ts_point);
+
 #define PTP_SHOW_INT(name, var)						\
 static ssize_t var##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *page)	\
@@ -335,6 +375,7 @@ static struct attribute *ptp_attrs[] = {
 	&dev_attr_pps_enable.attr,
 	&dev_attr_n_vclocks.attr,
 	&dev_attr_max_vclocks.attr,
+	&dev_attr_ts_point.attr,
 	NULL
 };
 
@@ -363,6 +404,9 @@ static umode_t ptp_is_attribute_visible(struct kobject *kobj,
 	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
 		if (!info->adjphase || !info->getmaxphase)
 			mode = 0;
+	} else if (attr == &dev_attr_ts_point.attr) {
+		if (!info->get_ts_point && !info->set_ts_point)
+			mode = 0;
 	}
 
 	return mode;
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index c892d22ce0a7..921d6615bd39 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -55,6 +55,23 @@ struct ptp_system_timestamp {
 	clockid_t clockid;
 };
 
+/**
+ * enum ptp_ts_point - possible timestamp latch points (IEEE 802.3cx)
+ * @PTP_TS_POINT_SFD:      timestamp latched at the beginning of sending Start
+ *			   of Frame Delimiter (SFD)
+ * @PTP_TS_POINT_POST_SFD: timestamp latched after the end of sending Start
+ *			   of Frame Delimiter (SFD)
+ */
+enum ptp_ts_point {
+	PTP_TS_POINT_SFD,
+	PTP_TS_POINT_POST_SFD,
+
+	/* private: */
+	__PTP_TS_POINT_MAX
+};
+
+#define PTP_TS_POINT_MAX (__PTP_TS_POINT_MAX - 1)
+
 /**
  * struct ptp_clock_info - describes a PTP hardware clock
  *
@@ -159,6 +176,14 @@ struct ptp_system_timestamp {
  *                scheduling time (>=0) or negative value in case further
  *                scheduling is not required.
  *
+ * @set_ts_point: Request change of timestamp latch point, as the timestamp
+ *                could be latched at the beginning or after the end of start
+ *                frame delimiter (SFD), as described in IEEE 802.3cx
+ *                specification.
+ *
+ * @get_ts_point: Obtain the timestamp measurement latch point, counterpart of
+ *                .set_ts_point() for getting currently configured value.
+ *
  * Drivers should embed their ptp_clock_info within a private
  * structure, obtaining a reference to it using container_of().
  *
@@ -195,6 +220,10 @@ struct ptp_clock_info {
 	int (*verify)(struct ptp_clock_info *ptp, unsigned int pin,
 		      enum ptp_pin_function func, unsigned int chan);
 	long (*do_aux_work)(struct ptp_clock_info *ptp);
+	int (*set_ts_point)(struct ptp_clock_info *ptp,
+			    enum ptp_ts_point point);
+	int (*get_ts_point)(struct ptp_clock_info *ptp,
+			    enum ptp_ts_point *point);
 };
 
 struct ptp_clock;
-- 
2.38.1


