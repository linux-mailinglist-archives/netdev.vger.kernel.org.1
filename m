Return-Path: <netdev+bounces-174685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2BA5FE1A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEAE3AA150
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE091DE8B6;
	Thu, 13 Mar 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K6d/Cew+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168E1DDC23;
	Thu, 13 Mar 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887512; cv=none; b=SeBjlO93O5Xp60jy5jy1QQqm6F//bQdZcCwkrZDiAxdA5jyysUFP7k9veeeuXdq0j3zYKX+9AooRhow/lZYbuAxptyImuOMTFs3J5748S14EaRVq3uli68t3IXP8APseYOce1GOC/wqDo73cLEgUxz/A/+YqDH3zljl9+Q3i7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887512; c=relaxed/simple;
	bh=RtOPI/DsxM1LZcAWF42dPpfdNPGAFh8TELrLyWLyS1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEI8DJl/5aV/TzUpHzP+uvC2HJh/GqGEjgoi7ta+IWoNRZlAl4lTbszGvdakJPJnGiLVpw5pgKfzqrTa4+IQptQc/wwJV+QxwFqvVArmKpEVbep8nE4RjGqFwlJANrdZMbS1c9FvPeQD7pMUTXpfmiu7ZsCTu9ocVMgz4zvn9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K6d/Cew+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAYvGD020076;
	Thu, 13 Mar 2025 17:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5s1FY5CT9goxhPTr851JPrtvAQnIM6QWFPyD9XtgGJ0=; b=K6d/Cew+MNxgn3y+
	9wfrfAvbhhkrsQ0G8izXSS0XLCU59B8saiBVjPKLNiAkCimRxYHiWRfay03uPd+o
	KRuxHINTVe1Q2Nj+kl5kwzGxteHBu9tvvG0qOsgGzeS03GDYNDzfoEm2QxXN5u+Q
	RdgLgZNV6H5VA6VV9oQrEMYdxrW2UXQ4U0/LjYv5NyiHkp291Viq7ue4JYupQ2n1
	ZIFeOoUvXzlbjDqlEftX3YSvSB9/sINJ04m2aN4Ovd+XI6qqhaQw82Gq5lvzKtaV
	HoZLAzvUwxMhY4GF5HwhWn1XbM0YGAMyi1Y0txZgB3wn5rW1sg0RPM/o3J6/iqY0
	HbKfxg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p6qax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 17:38:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DHc1XF025928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 17:38:01 GMT
Received: from PHILBER.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 10:37:56 -0700
From: Peter Hilber <quic_philber@quicinc.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: Trilok Soni <quic_tsoni@quicinc.com>,
        Peter Hilber
	<quic_philber@quicinc.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
        "David
 Woodhouse" <dwmw2@infradead.org>,
        "Ridoux, Julien" <ridouxj@amazon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Parav Pandit <parav@nvidia.com>,
        "Matias
 Ezequiel Vara Larsen" <mvaralar@redhat.com>,
        Cornelia Huck
	<cohuck@redhat.com>, Simon Horman <horms@kernel.org>,
        <virtio-dev@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        "Richard Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v6 3/4] virtio_rtc: Add Arm Generic Timer cross-timestamping
Date: Thu, 13 Mar 2025 18:36:59 +0100
Message-ID: <20250313173707.1492-4-quic_philber@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313173707.1492-1-quic_philber@quicinc.com>
References: <20250313173707.1492-1-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d317fa cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=7oUh35WbpK7Jc3m_RqkA:9 a=RVmHIydaz68A:10
 a=h0TWhadJkF0h9-KPms2U:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: c37RmqKH9j9VqGGPXss90_ZvDEGnxZh7
X-Proofpoint-GUID: c37RmqKH9j9VqGGPXss90_ZvDEGnxZh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130135

For platforms using the Arm Generic Timer, add precise cross-timestamping
support to virtio_rtc.

Always report the CP15 virtual counter as the HW counter in use by
arm_arch_timer, since the Linux kernel's usage of the Arm Generic Timer
should always be compatible with this.

Signed-off-by: Peter Hilber <quic_philber@quicinc.com>
---

Notes:
    v4:
    
    - Update names and types to spec v6.
    
    v2:
    
    - Depend on prerequisite patch series "treewide: Use clocksource id for
      get_device_system_crosststamp()".
    
    - Return clocksource id instead of calling dropped arm_arch_timer helpers.
    
    - Always report the CP15 virtual counter to be in use by arm_arch_timer,
      since distinction of Arm physical and virtual counter appears unneeded
      after discussion with Marc Zyngier.

 drivers/virtio/Kconfig          | 13 +++++++++++++
 drivers/virtio/Makefile         |  1 +
 drivers/virtio/virtio_rtc_arm.c | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index a14a2b77e142..3d8b366c0625 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -221,6 +221,19 @@ config VIRTIO_RTC_PTP
 
 	 If unsure, say Y.
 
+config VIRTIO_RTC_ARM
+	bool "Virtio RTC cross-timestamping using Arm Generic Timer"
+	default y
+	depends on VIRTIO_RTC_PTP && ARM_ARCH_TIMER
+	help
+	 This enables Virtio RTC cross-timestamping using the Arm Generic Timer.
+	 It only has an effect if the Virtio RTC device also supports this. The
+	 cross-timestamp is available through the PTP clock driver precise
+	 cross-timestamp ioctl (PTP_SYS_OFFSET_PRECISE2 aka
+	 PTP_SYS_OFFSET_PRECISE).
+
+	 If unsure, say Y.
+
 endif # VIRTIO_RTC
 
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 88d6fb8d4731..dbd77f124ba9 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_VIRTIO_DEBUG) += virtio_debug.o
 obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
 virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_ARM) += virtio_rtc_arm.o
diff --git a/drivers/virtio/virtio_rtc_arm.c b/drivers/virtio/virtio_rtc_arm.c
new file mode 100644
index 000000000000..211299d72870
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_arm.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Provides cross-timestamp params for Arm.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clocksource_ids.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/* see header for doc */
+
+int viortc_hw_xtstamp_params(u8 *hw_counter, enum clocksource_ids *cs_id)
+{
+	*hw_counter = VIRTIO_RTC_COUNTER_ARM_VCT;
+	*cs_id = CSID_ARM_ARCH_COUNTER;
+
+	return 0;
+}
-- 
2.43.0


