Return-Path: <netdev+bounces-189333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB4BAB19DE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F097BD747
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A42356DA;
	Fri,  9 May 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F0UnNh9u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE5235073;
	Fri,  9 May 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806923; cv=none; b=B8nUh+cMeNKXq14biWRiyATtsETMcP44A7qhSXrXjRe6Vr8qxyxG1mDZklaD2F2ZT6L4BKVlZQcBpifT5hXNSBauzQW+8dRCAnndJrrX9PfDWCqmLPWbTRezLBcyKxeoqPAOW7nR4S0SppTLryaRDKFBuWw9v0dKdfBjDsv9p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806923; c=relaxed/simple;
	bh=RtOPI/DsxM1LZcAWF42dPpfdNPGAFh8TELrLyWLyS1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtgJOGiFZZ2RKOqJN670llg0U6yb7XraLQp+XwGoFwFWL43KtGb1u8/QK4Ja9pJdf+MrudH7dTCaIdKfsVCb/ATXMdeRFc5O8BtOibnOw9yKh+Cp/SiQkUKO+sWQreWSJeeHdwcfnP4ZmdGwTXGHqQJUK1nF2H8eKp7BcmsPV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F0UnNh9u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549Bpi3T002461;
	Fri, 9 May 2025 16:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5s1FY5CT9goxhPTr851JPrtvAQnIM6QWFPyD9XtgGJ0=; b=F0UnNh9uSSgTpLcd
	eWDdR2Sus+u4Yc5Zwt/QMjjo8qpbOtINWI8vCRQD0Xd7F/vZJ76c4UTuqZxoecB1
	AwK55cAeKsE89/ah2CNSbmbYf4tLbslLGh6jbQifpR9RaFClhvKATovONxb2QDFW
	2Fwq4jR4fahRi0ZpyD57xAqDeQlKjAUOORqNd1/mpKKotj3NsjkOQlIWqJFgCcRq
	jntozNpHU2pRTVdzKqjnl9IogaT/XcEA56uqZcA0Zcg5Bzy9O70UtUYBjdoA4pOQ
	sUXTZOZboxIt3ovQh20sTV+cCTyenctThvQQLhBdJFSAmgng8qT79HUF04M1uf2I
	i/wa9Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp5d5vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 16:08:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 549G8GF4029185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 May 2025 16:08:16 GMT
Received: from PHILBER.na.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 9 May 2025 09:08:11 -0700
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
Subject: [PATCH v7 3/4] virtio_rtc: Add Arm Generic Timer cross-timestamping
Date: Fri, 9 May 2025 18:07:24 +0200
Message-ID: <20250509160734.1772-4-quic_philber@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509160734.1772-1-quic_philber@quicinc.com>
References: <20250509160734.1772-1-quic_philber@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=XL0wSRhE c=1 sm=1 tr=0 ts=681e2871 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=7oUh35WbpK7Jc3m_RqkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: X0TyMq46uLtEqPJB9-Bf0oQrryMyX-6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1OSBTYWx0ZWRfX1dyLxOnPtdJl
 ZX3NmqHSswSZ/yAkm5kV5X3GQKs0l7VQF6r1d+5Hnn2Fe80JxKcMWWat8XjuaQ10jsqUbyI1p45
 EMIsJBXKkBfz7PgqFx7+AQV4nDc73MLqOHKbt4cjyYNQimvOmdWyZUKZW08Pph4VcdUTL6/DQUy
 HXs8igIncSxOAQq4kiDVrnmyifOrYOhMeirkXsR4ApLR1QeG9hakTRWJEGvAgc2f3dPVySFSddQ
 6UdjSG144Xgm73mvY2s5LJoz0ykqC1u+9fh7Wi8i/rYVRXCJE7Zyo6v/IujsaBZDcn8kqu9dvbc
 g3U3A1orDF9NUZNz0QDeCs5nlsyp7FIaC4oBdkFqVGHyhtIdJN4BGbldM0JYhfPHi/F63L3ro0J
 xCKcb/Rm8Mr2BIxFymM0R5Lca+VcGJH/sa411VpyY8wPRVEEG3U1Dfk+fTvdJMUrxzu6K56B
X-Proofpoint-ORIG-GUID: X0TyMq46uLtEqPJB9-Bf0oQrryMyX-6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090159

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


