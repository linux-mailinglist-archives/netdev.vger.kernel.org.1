Return-Path: <netdev+bounces-131783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61A98F918
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005571F22B42
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0591C3F17;
	Thu,  3 Oct 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXmDJ0f1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FC1BFE01;
	Thu,  3 Oct 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991763; cv=none; b=TdWGeJuMLHLzeDVarjxk3ckHk6psjvblceg/PK7o8y86g6fEPdFpHe8SmKHk7NfmnPGENsrKbDCxHxQdrBJfL40RVOLfFctJLGYGn0vljhpRx56gWUIrle0V4FZvyX6tQ+OXDWNkSdbn2gQEwTPFsFePFr/XLnOnu622n5JeUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991763; c=relaxed/simple;
	bh=1wPx9uI2JOTxSblcfhZCFNWy1M8th2dmxs8o2X69jZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA0rXOpUryfG+NIan2I4Jzx82h8MDkGN6uVgQupYsUnlMwHI/uyEre81GbfGcGpY9dBXacfBOgwmJZlvpZEjJZeruaa4RM9t6DZXtXxSOrm07aiVPzMlnCpaGKOAaIYrqdqGXIMMFZj1CKtCWcUAhJLF9Y0Iy6pBt8MMgUm9PXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXmDJ0f1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727991761; x=1759527761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1wPx9uI2JOTxSblcfhZCFNWy1M8th2dmxs8o2X69jZY=;
  b=aXmDJ0f1QVo2dhsuwFMhkFKKukeosjbYtc4S2B17NTnWwQTMGsEC7mVx
   PCGcbMeQtGEf49bNE5No1IHQ9DlhoQZTtb5TH6N9QUqfmerCyb72XTLVI
   N/AM+1uQcukAb1sVPYYbj4sMD57hBuveiOjD7BJVc23UOvPB7YjjlN2u5
   fFnUvavqgqOHUMcirvYDFxw27knrGwIi6sAZYRNI8MqPZ0ey0UcDPMFhC
   zgeUF//ybMdK2JruS8vyspA/wSpsP2wTChYscqbqG/XOfEZTCO2jc5Ndo
   2twgkSQVc/klqAZ+nFGtuchdVqO884l4vTPCVOV3faEnuML10WSFY5e9B
   A==;
X-CSE-ConnectionGUID: IJjXSOBHT8+EjkCpuRdlFA==
X-CSE-MsgGUID: njjwQS9SQj6tvwDbYn8cIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27379826"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27379826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:42:41 -0700
X-CSE-ConnectionGUID: HnWCfMtaSAWX2yxuc7ZenQ==
X-CSE-MsgGUID: Fj1jQc3RT3asw/1FI0UGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="111952988"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2024 14:42:38 -0700
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
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [RFC PATCH 1/2] ptp: add control over HW timestamp latch point
Date: Thu,  3 Oct 2024 23:37:53 +0200
Message-Id: <20241003213754.926691-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
References: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce:
- ops for getting and setting the HW timestamp latch point,
- enumerate possible HW timestamp latch point,
- new sysfs ptp device attribute as user knob.

HW support of PTP/timesync solutions in network PHY chips can be
achieved with two different approaches, the timestamp maybe latched
either in the beginning or after the Start of Frame Delimiter (SFD) [1].

Allow ptp device drivers to provide user with control over the timestamp
latch point.

[1] https://www.ieee802.org/3/cx/public/april20/tse_3cx_01_0420.pdf

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/ptp/ptp_sysfs.c          | 44 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 26 +++++++++++++++++++
 2 files changed, 70 insertions(+)

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
index c892d22ce0a7..ee4b625bca2c 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -55,6 +55,20 @@ struct ptp_system_timestamp {
 	clockid_t clockid;
 };
 
+/**
+ * enum ptp_ts_point - possible timestamp latch points (IEEE 802.3cx)
+ * PTP_TS_POINT_SFD: timestamp latched at the beginning of sending Start
+ *	of Frame Delimiter (SFD)
+ * PTP_TS_POINT_POST_SFD: timestamp latched at the end of sending Start
+ *	of Frame Delimiter (SFD)
+ */
+enum ptp_ts_point {
+	PTP_TS_POINT_SFD,
+	PTP_TS_POINT_POST_SFD,
+	__PTP_TS_POINT_MAX
+};
+#define PTP_TS_POINT_MAX (__PTP_TS_POINT_MAX - 1)
+
 /**
  * struct ptp_clock_info - describes a PTP hardware clock
  *
@@ -159,6 +173,14 @@ struct ptp_system_timestamp {
  *                scheduling time (>=0) or negative value in case further
  *                scheduling is not required.
  *
+ * @set_ts_point: Request change of timestamp latch point, as the timestamp
+ *                could be latched at the beginning or at the end of start
+ *                frame delimiter (SFD), as described in IEEE 802.3cx
+ *                specification.
+ *
+ * @get_ts_point: Obtain the timestamp measurement latch point, counterpart of
+ *                .set_ts_point() for getting currently configured value.
+ *
  * Drivers should embed their ptp_clock_info within a private
  * structure, obtaining a reference to it using container_of().
  *
@@ -195,6 +217,10 @@ struct ptp_clock_info {
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


