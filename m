Return-Path: <netdev+bounces-167845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82490A3C8E7
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB163189CF75
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BD22FE10;
	Wed, 19 Feb 2025 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i/OR+iNN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671A22FE0C;
	Wed, 19 Feb 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993656; cv=none; b=N5XwzwsRgnrttObRZYremCwl5art68uAT9uyDi9deyakp/zvEXYvdD8ggi4SPsknMNTv1zEh60tRcDPIlv5yXCI6DY/GvXdZVH7vvcT/gsxEegfAzipbufl4zJ8SO9rpgXKQVwrkhvzXx1pm6niWzye9cRrLi1DY1Gx+E150F+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993656; c=relaxed/simple;
	bh=9FeOV8opCfObi7tUr9fs/g4qDJP3TkkrH+YNcZHJ7x4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZxZlCcPYBMXCL2irGVYc8J++IxYQf9mSbCgl1FAjIQoedYOwsNag84/9RCkQcyDz5V3INZ+SQoOIqcAu9x70jK8UFRbutRwzO0rxcZkCMif2r88WNqILOIcNotbT2YdIQLVUflqnojjys4/gR+4CRBt2wB9K6dQ9J2myWERRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i/OR+iNN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JB9ZZX031423;
	Wed, 19 Feb 2025 19:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AspjgZU0NXlHOcDl8+7Gm7WhlKv9jpXd70aQl0fbvEo=; b=i/OR+iNNCSj7q64M
	ZndljuuOIPrB6j/Fpo1LxhYuqlVJMXtojSsDqHyQFtuN0fuTQDX4xpxg8Wg2jT0M
	Bl+GE/YZS9aW7WMI5GSwRJT2U07Oo+2NV+qLpu6niVdE44vyD3nep8ZKMf4pKUHk
	JbG/vuCT+o1SdIGGMSVBJe4BN3dsj0QwFwddc30/pgROIOVs7wTw9DmLwnsae677
	vJ4RJiy/fS7uuQbjn4ZXCEa1179Ku97guBHzQ0rdeR6NJXn+HaV52jabk5M2vjMq
	q/aYyfwsU0BBg8DaMOYwf6koCVmjnDhJnZNbCcEWxWO9YzA9v7MFZHTv7uyDNP4K
	mt9CLg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44we69hete-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 19:33:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51JJXr9L023958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 19:33:53 GMT
Received: from PHILBER.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Feb
 2025 11:33:47 -0800
From: Peter Hilber <quic_philber@quicinc.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Peter Hilber <quic_philber@quicinc.com>,
        "Xuan
 Zhuo" <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Ridoux, Julien" <ridouxj@amazon.com>, Marc Zyngier <maz@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Parav Pandit
	<parav@nvidia.com>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        Richard Cochran
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 3/4] virtio_rtc: Add Arm Generic Timer cross-timestamping
Date: Wed, 19 Feb 2025 20:32:58 +0100
Message-ID: <20250219193306.1045-4-quic_philber@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219193306.1045-1-quic_philber@quicinc.com>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _P01MOAEurE50vWQg8Zm_Mj9kSECT_O8
X-Proofpoint-ORIG-GUID: _P01MOAEurE50vWQg8Zm_Mj9kSECT_O8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190151

Add PTP_SYS_OFFSET_PRECISE2 support on platforms using the Arm Generic
Timer.

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


