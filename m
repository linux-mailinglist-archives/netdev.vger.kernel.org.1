Return-Path: <netdev+bounces-167844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B589A3C8E3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB1818887A1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DC22F3B0;
	Wed, 19 Feb 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cFBlfDpE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5B22DFFA;
	Wed, 19 Feb 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993653; cv=none; b=T8fr0BoHiatEvlzoTIKV2Af+cL0NXmJ0qBqukJMi0ZKoQCRt1VPkkZeeZu6SIiZASfRj5SESLZqnO/DK44fHQn3gCiug6hK6cYCtOca51ee2Gn4y9BTKPOaIwuf0MFu1h6RpeVEMK0J3NI3vHqDK2kr+JQ8gRJ8h6kzSQ9YqzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993653; c=relaxed/simple;
	bh=dd2TNBBAExI8So2smPjcQXQH0mQ0UDIRymLwGSksPcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4DX2Q9d667unUamy9shmoJjbAKQFkExOJ5JTMrvtEH9C4xNazA0RElGKLTRyPnYwacxnkE/nXV87E3vzYK12L3yMbVKzx2g2yLqHvv6BSRxveuAaKiwii/Oy2iFl3jCnJv5Th+wvRuWkvonm5z9GDQnwgIHlRCGDuhN6yg81Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cFBlfDpE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JB9cLa031441;
	Wed, 19 Feb 2025 19:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eIesvBI7TMi2vvkgo7mpaEgzbA/OME+0j5KO2qg2vjM=; b=cFBlfDpECEE50vkp
	ZwIeLikeuIAV62KBmCZeHcdPOMeXEcYP9s+2FTzXjch9/cSEu6Q95e6qCs1kCCPf
	K6bshuS2wrvz5pzTc7EZxCutriu+jcjgYUCMGjTwc8CW83nG1uj2tai2gOo0u/kB
	6nC539OhV/rPFecOHz25eSI1fNCGXDWermtGe+hyXnfd6zlJ+NtqmP8HO6vfU2kv
	QLJG4I69Wro6PX25Bfxz5ldLG3z5QTmPl4SMP9v9UcjXSF57NXKyDdydi0YTaNrA
	Fv9tvsRThSVVuxKBLZy917K6VPX0ptK13aOllbkvVO29FHy7GZ5SZbSOWC1ETrmm
	t4nmxA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44we69het9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 19:33:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51JJXl0k023906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 19:33:47 GMT
Received: from PHILBER.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Feb
 2025 11:33:42 -0800
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
        Richard Cochran <richardcochran@gmail.com>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        "Ridoux,
 Julien" <ridouxj@amazon.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Parav Pandit
	<parav@nvidia.com>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/4] virtio_rtc: Add PTP clocks
Date: Wed, 19 Feb 2025 20:32:57 +0100
Message-ID: <20250219193306.1045-3-quic_philber@quicinc.com>
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
X-Proofpoint-GUID: 8m8CmUokqMeFuJ5NqzzmYqcbLzdYo8VB
X-Proofpoint-ORIG-GUID: 8m8CmUokqMeFuJ5NqzzmYqcbLzdYo8VB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190151

Expose the virtio_rtc clocks as PTP clocks to userspace, similar to
ptp_kvm. virtio_rtc can expose multiple clocks, e.g. a UTC clock and a
monotonic clock.

Userspace should distinguish different clocks through the name assigned by
the driver. In particular, UTC-like clocks can also be distinguished by if
and how leap seconds are smeared. udev rules such as the following can be
used to get different symlinks for different clock types:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP type 0, variant 0", SYMLINK += "ptp_virtio"
	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP type 1, variant 0", SYMLINK += "ptp_virtio_tai"
	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP type 2, variant 0", SYMLINK += "ptp_virtio_mono"
	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP type 3, variant 0", SYMLINK += "ptp_virtio_smear_unspecified"
	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP type 3, variant 1", SYMLINK += "ptp_virtio_smear_noon_linear"

The preferred PTP clock reading method is ioctl PTP_SYS_OFFSET_PRECISE2,
through the ptp_clock_info.getcrosststamp() op. For now,
PTP_SYS_OFFSET_PRECISE2 will return -EOPNOTSUPP through a weak function.
PTP_SYS_OFFSET_PRECISE2 requires cross-timestamping support for specific
clocksources, which will be added in the following. If the clocksource
specific code is enabled, check that the Virtio RTC device supports the
respective HW counter before obtaining an actual cross-timestamp from the
Virtio device.

The Virtio RTC device response time may be higher than the timekeeper
seqcount increment interval. Therefore, obtain the cross-timestamp before
calling get_device_system_crosststamp().

As a fallback, support the ioctl PTP_SYS_OFFSET_EXTENDED2 for all
platforms.

Assume that concurrency issues during PTP clock removal are avoided by the
posix_clock framework.

Kconfig recursive dependencies prevent virtio_rtc from implicitly enabling
PTP_1588_CLOCK, therefore just warn the user if PTP_1588_CLOCK is not
available. Since virtio_rtc should in the future also expose clocks as RTC
class devices, do not depend VIRTIO_RTC on PTP_1588_CLOCK.

Signed-off-by: Peter Hilber <quic_philber@quicinc.com>
---

Notes:
    v5:
    
    - Fix style issues.
    
    v4:
    
    - Distinguish UTC-like clocks by handling of leap seconds (spec v6).
    
    - For PTP clock name, always use numeric clock type, and numeric variant.
    
    - Update types to spec v6.
    
    - Cosmetic improvements.
    
    v3:
    
    - don't guard cross-timestamping with feature bit (spec v3)
    
    - reduce clock id to 16 bits (spec v3)
    
    v2:
    
    - Depend on prerequisite patch series "treewide: Use clocksource id for
      get_device_system_crosststamp()".
    
    - Check clocksource id before sending crosststamp message to device.
    
    - Do not support multiple hardware counters at runtime any more, since
      distinction of Arm physical and virtual counter appears unneeded after
      discussion with Marc Zyngier.

 drivers/virtio/Kconfig               |  24 +-
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_rtc_driver.c   | 121 +++++++++-
 drivers/virtio/virtio_rtc_internal.h |  46 ++++
 drivers/virtio/virtio_rtc_ptp.c      | 347 +++++++++++++++++++++++++++
 5 files changed, 535 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 83bcb06acb6c..a14a2b77e142 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -194,11 +194,33 @@ config VIRTIO_RTC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	 This driver provides current time from a Virtio RTC device. The driver
-	 provides the time through one or more clocks.
+	 provides the time through one or more clocks. The Virtio RTC PTP
+	 clocks must be enabled to expose the clocks to userspace.
 
 	 To compile this code as a module, choose M here: the module will be
 	 called virtio_rtc.
 
 	 If unsure, say M.
 
+if VIRTIO_RTC
+
+comment "WARNING: Consider enabling VIRTIO_RTC_PTP."
+	depends on !VIRTIO_RTC_PTP
+
+comment "Enable PTP_1588_CLOCK in order to enable VIRTIO_RTC_PTP."
+	depends on PTP_1588_CLOCK=n
+
+config VIRTIO_RTC_PTP
+	bool "Virtio RTC PTP clocks"
+	default y
+	depends on PTP_1588_CLOCK
+	help
+	 This exposes any Virtio RTC clocks as PTP Hardware Clocks (PHCs) to
+	 userspace. The PHC sysfs attribute "clock_name" describes the clock
+	 type.
+
+	 If unsure, say Y.
+
+endif # VIRTIO_RTC
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index c41c4c0f9264..88d6fb8d4731 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
 obj-$(CONFIG_VIRTIO_DEBUG) += virtio_debug.o
 obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index 92f41526e437..dfa0590f9c8b 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -38,11 +38,16 @@ struct viortc_vq {
  * struct viortc_dev - virtio_rtc device data
  * @vdev: virtio device
  * @vqs: virtqueues
+ * @clocks_to_unregister: Clock references, which are only used during device
+ *                        removal.
+ *			  For other uses, there would be a race between device
+ *			  creation and setting the pointers here.
  * @num_clocks: # of virtio_rtc clocks
  */
 struct viortc_dev {
 	struct virtio_device *vdev;
 	struct viortc_vq vqs[VIORTC_MAX_NR_QUEUES];
+	struct viortc_ptp_clock **clocks_to_unregister;
 	u16 num_clocks;
 };
 
@@ -637,6 +642,99 @@ int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
  * init, deinit
  */
 
+/**
+ * viortc_init_ptp_clock() - init and register PTP clock
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @clock_type: virtio_rtc clock type
+ * @leap_second_smearing: virtio_rtc leap second smearing
+ *
+ * Context: Process context.
+ * Return: Positive if registered, zero if not supported by configuration,
+ *         negative error code otherwise.
+ */
+static int viortc_init_ptp_clock(struct viortc_dev *viortc, u16 vio_clk_id,
+				 u8 clock_type, u8 leap_second_smearing)
+{
+	struct device *dev = &viortc->vdev->dev;
+	char ptp_clock_name[PTP_CLOCK_NAME_LEN];
+	struct viortc_ptp_clock *vio_ptp;
+
+	snprintf(ptp_clock_name, PTP_CLOCK_NAME_LEN,
+		 "Virtio PTP type %d, variant %d", clock_type,
+		 leap_second_smearing);
+
+	vio_ptp = viortc_ptp_register(viortc, dev, vio_clk_id, ptp_clock_name);
+	if (IS_ERR(vio_ptp)) {
+		dev_err(dev, "failed to register PTP clock '%s'\n",
+			ptp_clock_name);
+		return PTR_ERR(vio_ptp);
+	}
+
+	viortc->clocks_to_unregister[vio_clk_id] = vio_ptp;
+
+	return !!vio_ptp;
+}
+
+/**
+ * viortc_init_clock() - init local representation of virtio_rtc clock
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ *
+ * Initializes PHC to represent virtio_rtc clock.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_clock(struct viortc_dev *viortc, u16 vio_clk_id)
+{
+	u8 clock_type, leap_second_smearing;
+	bool is_exposed = false;
+	int ret;
+
+	ret = viortc_clock_cap(viortc, vio_clk_id, &clock_type,
+			       &leap_second_smearing);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)) {
+		ret = viortc_init_ptp_clock(viortc, vio_clk_id, clock_type,
+					    leap_second_smearing);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			is_exposed = true;
+	}
+
+	if (!is_exposed)
+		dev_warn(&viortc->vdev->dev,
+			 "cannot expose clock %d (type %d, variant %d) to userspace\n",
+			 vio_clk_id, clock_type, leap_second_smearing);
+
+	return 0;
+}
+
+/**
+ * viortc_clocks_deinit() - unregister PHCs
+ * @viortc: device data
+ */
+static void viortc_clocks_deinit(struct viortc_dev *viortc)
+{
+	struct viortc_ptp_clock *vio_ptp;
+	unsigned int i;
+
+	for (i = 0; i < viortc->num_clocks; i++) {
+		vio_ptp = viortc->clocks_to_unregister[i];
+
+		if (!vio_ptp)
+			continue;
+
+		viortc->clocks_to_unregister[i] = NULL;
+
+		WARN_ON(viortc_ptp_unregister(vio_ptp, &viortc->vdev->dev));
+	}
+}
+
 /**
  * viortc_clocks_init() - init local representations of virtio_rtc clocks
  * @viortc: device data
@@ -647,6 +745,7 @@ int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
 static int viortc_clocks_init(struct viortc_dev *viortc)
 {
 	u16 num_clocks;
+	unsigned int i;
 	int ret;
 
 	ret = viortc_cfg(viortc, &num_clocks);
@@ -660,8 +759,22 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 
 	viortc->num_clocks = num_clocks;
 
-	/* In the future, PTP clocks will be initialized here. */
-	(void)viortc_clock_cap;
+	viortc->clocks_to_unregister =
+		devm_kcalloc(&viortc->vdev->dev, num_clocks,
+			     sizeof(*viortc->clocks_to_unregister), GFP_KERNEL);
+	if (!viortc->clocks_to_unregister)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clocks; i++) {
+		ret = viortc_init_clock(viortc, i);
+		if (ret)
+			goto err_deinit_clocks;
+	}
+
+	return 0;
+
+err_deinit_clocks:
+	viortc_clocks_deinit(viortc);
 
 	return ret;
 }
@@ -740,7 +853,9 @@ static int viortc_probe(struct virtio_device *vdev)
  */
 static void viortc_remove(struct virtio_device *vdev)
 {
-	/* In the future, PTP clocks will be deinitialized here. */
+	struct viortc_dev *viortc = vdev->priv;
+
+	viortc_clocks_deinit(viortc);
 
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
diff --git a/drivers/virtio/virtio_rtc_internal.h b/drivers/virtio/virtio_rtc_internal.h
index 9c249c15b68f..2e589903d04f 100644
--- a/drivers/virtio/virtio_rtc_internal.h
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -9,6 +9,7 @@
 #ifndef _VIRTIO_RTC_INTERNAL_H_
 #define _VIRTIO_RTC_INTERNAL_H_
 
+#include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
 
 /* driver core IFs */
@@ -21,4 +22,49 @@ int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
 int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
 		     bool *supported);
 
+/* PTP IFs */
+
+struct viortc_ptp_clock;
+
+#if IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)
+
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u16 vio_clk_id,
+					     const char *ptp_clock_name);
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev);
+
+#else
+
+static inline struct viortc_ptp_clock *
+viortc_ptp_register(struct viortc_dev *viortc, struct device *parent_dev,
+		    u16 vio_clk_id, const char *ptp_clock_name)
+{
+	return NULL;
+}
+
+static inline int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+					struct device *parent_dev)
+{
+	return -ENODEV;
+}
+
+#endif
+
+/* HW counter IFs */
+
+/**
+ * viortc_hw_xtstamp_params() - get HW-specific xtstamp params
+ * @hw_counter: virtio_rtc HW counter type
+ * @cs_id: clocksource id corresponding to hw_counter
+ *
+ * Gets the HW-specific xtstamp params. Returns an error if the driver cannot
+ * support xtstamp.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_hw_xtstamp_params(u8 *hw_counter, enum clocksource_ids *cs_id);
+
 #endif /* _VIRTIO_RTC_INTERNAL_H_ */
diff --git a/drivers/virtio/virtio_rtc_ptp.c b/drivers/virtio/virtio_rtc_ptp.c
new file mode 100644
index 000000000000..19c353ca22b0
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Expose virtio_rtc clocks as PTP clocks.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Derived from ptp_kvm_common.c, virtual PTP 1588 clock for use with KVM
+ * guests.
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/**
+ * struct viortc_ptp_clock - PTP clock abstraction
+ * @ptp_clock: PTP clock handle for unregistering
+ * @viortc: virtio_rtc device data
+ * @ptp_info: PTP clock description
+ * @vio_clk_id: virtio_rtc clock id
+ * @have_cross: device supports crosststamp with available HW counter
+ */
+struct viortc_ptp_clock {
+	struct ptp_clock *ptp_clock;
+	struct viortc_dev *viortc;
+	struct ptp_clock_info ptp_info;
+	u16 vio_clk_id;
+	bool have_cross;
+};
+
+/**
+ * struct viortc_ptp_cross_ctx - context for get_device_system_crosststamp()
+ * @device_time: device clock reading
+ * @system_counterval: HW counter value at device_time
+ *
+ * Provides the already obtained crosststamp to get_device_system_crosststamp().
+ */
+struct viortc_ptp_cross_ctx {
+	ktime_t device_time;
+	struct system_counterval_t system_counterval;
+};
+
+/* Weak function in case get_device_system_crosststamp() is not supported */
+int __weak viortc_hw_xtstamp_params(u8 *hw_counter, enum clocksource_ids *cs_id)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_get_time_fn() - callback for get_device_system_crosststamp()
+ * @device_time: device clock reading
+ * @system_counterval: HW counter value at device_time
+ * @ctx: context with already obtained crosststamp
+ *
+ * Return: zero (success).
+ */
+static int viortc_ptp_get_time_fn(ktime_t *device_time,
+				  struct system_counterval_t *system_counterval,
+				  void *ctx)
+{
+	struct viortc_ptp_cross_ctx *vio_ctx = ctx;
+
+	*device_time = vio_ctx->device_time;
+	*system_counterval = vio_ctx->system_counterval;
+
+	return 0;
+}
+
+/**
+ * viortc_ptp_do_xtstamp() - get crosststamp from device
+ * @vio_ptp: virtio_rtc PTP clock
+ * @hw_counter: virtio_rtc HW counter type
+ * @cs_id: clocksource id corresponding to hw_counter
+ * @ctx: context for get_device_system_crosststamp()
+ *
+ * Reads HW-specific crosststamp from device.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_do_xtstamp(struct viortc_ptp_clock *vio_ptp,
+				 u8 hw_counter, enum clocksource_ids cs_id,
+				 struct viortc_ptp_cross_ctx *ctx)
+{
+	u64 max_ns, ns;
+	int ret;
+
+	ctx->system_counterval.cs_id = cs_id;
+
+	ret = viortc_read_cross(vio_ptp->viortc, vio_ptp->vio_clk_id,
+				hw_counter, &ns,
+				&ctx->system_counterval.cycles);
+	if (ret)
+		return ret;
+
+	max_ns = (u64)ktime_to_ns(KTIME_MAX);
+	if (ns > max_ns)
+		return -EINVAL;
+
+	ctx->device_time = ns_to_ktime(ns);
+
+	return 0;
+}
+
+/*
+ * PTP clock operations
+ */
+
+/**
+ * viortc_ptp_getcrosststamp() - PTP clock getcrosststamp op
+ * @ptp: PTP clock info
+ * @xtstamp: crosststamp
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
+				     struct system_device_crosststamp *xtstamp)
+{
+	struct viortc_ptp_clock *vio_ptp =
+		container_of(ptp, struct viortc_ptp_clock, ptp_info);
+	struct system_time_snapshot history_begin;
+	struct viortc_ptp_cross_ctx ctx;
+	enum clocksource_ids cs_id;
+	u8 hw_counter;
+	int ret;
+
+	if (!vio_ptp->have_cross)
+		return -EOPNOTSUPP;
+
+	ret = viortc_hw_xtstamp_params(&hw_counter, &cs_id);
+	if (ret)
+		return ret;
+
+	ktime_get_snapshot(&history_begin);
+	if (history_begin.cs_id != cs_id)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Getting the timestamp can take many milliseconds with a slow Virtio
+	 * device. This is too long for viortc_ptp_get_time_fn() passed to
+	 * get_device_system_crosststamp(), which has to usually return before
+	 * the timekeeper seqcount increases (every tick or so).
+	 *
+	 * So, get the actual cross-timestamp first.
+	 */
+	ret = viortc_ptp_do_xtstamp(vio_ptp, hw_counter, cs_id, &ctx);
+	if (ret)
+		return ret;
+
+	ret = get_device_system_crosststamp(viortc_ptp_get_time_fn, &ctx,
+					    &history_begin, xtstamp);
+	if (ret)
+		pr_debug("%s: get_device_system_crosststamp() returned %d\n",
+			 __func__, ret);
+
+	return ret;
+}
+
+/** viortc_ptp_adjfine() - unsupported PTP clock adjfine op */
+static int viortc_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+/** viortc_ptp_adjtime() - unsupported PTP clock adjtime op */
+static int viortc_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+/** viortc_ptp_settime64() - unsupported PTP clock settime64 op */
+static int viortc_ptp_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_gettimex64() - PTP clock gettimex64 op
+ *
+ * Context: Process context.
+ */
+static int viortc_ptp_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct viortc_ptp_clock *vio_ptp =
+		container_of(ptp, struct viortc_ptp_clock, ptp_info);
+	int ret;
+	u64 ns;
+
+	ptp_read_system_prets(sts);
+	ret = viortc_read(vio_ptp->viortc, vio_ptp->vio_clk_id, &ns);
+	ptp_read_system_postts(sts);
+
+	if (ret)
+		return ret;
+
+	if (ns > (u64)S64_MAX)
+		return -EINVAL;
+
+	*ts = ns_to_timespec64((s64)ns);
+
+	return 0;
+}
+
+/** viortc_ptp_enable() - unsupported PTP clock enable op */
+static int viortc_ptp_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * viortc_ptp_info_template - ptp_clock_info template
+ *
+ * The .name member will be set for individual virtio_rtc PTP clocks.
+ *
+ * The .getcrosststamp member will be cleared for PTP clocks not supporting
+ * crosststamp.
+ */
+static const struct ptp_clock_info viortc_ptp_info_template = {
+	.owner = THIS_MODULE,
+	/* .name is set according to clock type */
+	.adjfine = viortc_ptp_adjfine,
+	.adjtime = viortc_ptp_adjtime,
+	.gettimex64 = viortc_ptp_gettimex64,
+	.settime64 = viortc_ptp_settime64,
+	.enable = viortc_ptp_enable,
+	.getcrosststamp = viortc_ptp_getcrosststamp,
+};
+
+/**
+ * viortc_ptp_unregister() - PTP clock unregistering wrapper
+ * @vio_ptp: virtio_rtc PTP clock
+ * @parent_dev: parent device of PTP clock
+ *
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev)
+{
+	int ret = ptp_clock_unregister(vio_ptp->ptp_clock);
+
+	if (!ret)
+		devm_kfree(parent_dev, vio_ptp);
+
+	return ret;
+}
+
+/**
+ * viortc_ptp_get_cross_cap() - get xtstamp support info from device
+ * @viortc: virtio_rtc device data
+ * @vio_ptp: virtio_rtc PTP clock abstraction
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_get_cross_cap(struct viortc_dev *viortc,
+				    struct viortc_ptp_clock *vio_ptp)
+{
+	enum clocksource_ids cs_id;
+	bool xtstamp_supported;
+	u8 hw_counter;
+	int ret;
+
+	ret = viortc_hw_xtstamp_params(&hw_counter, &cs_id);
+	if (ret) {
+		vio_ptp->have_cross = false;
+		return 0;
+	}
+
+	ret = viortc_cross_cap(viortc, vio_ptp->vio_clk_id, hw_counter,
+			       &xtstamp_supported);
+	if (ret)
+		return ret;
+
+	vio_ptp->have_cross = xtstamp_supported;
+
+	return 0;
+}
+
+/**
+ * viortc_ptp_register() - prepare and register PTP clock
+ * @viortc: virtio_rtc device data
+ * @parent_dev: parent device for PTP clock
+ * @vio_clk_id: id of virtio_rtc clock which backs PTP clock
+ * @ptp_clock_name: PTP clock name
+ *
+ * Context: Process context.
+ * Return: Pointer on success, ERR_PTR() otherwise; NULL if PTP clock support
+ *         not available.
+ */
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u16 vio_clk_id,
+					     const char *ptp_clock_name)
+{
+	struct viortc_ptp_clock *vio_ptp;
+	struct ptp_clock *ptp_clock;
+	ssize_t len;
+	int ret;
+
+	vio_ptp = devm_kzalloc(parent_dev, sizeof(*vio_ptp), GFP_KERNEL);
+	if (!vio_ptp)
+		return ERR_PTR(-ENOMEM);
+
+	vio_ptp->viortc = viortc;
+	vio_ptp->vio_clk_id = vio_clk_id;
+	vio_ptp->ptp_info = viortc_ptp_info_template;
+	len = strscpy(vio_ptp->ptp_info.name, ptp_clock_name,
+		      sizeof(vio_ptp->ptp_info.name));
+	if (len < 0) {
+		ret = len;
+		goto err_free_dev;
+	}
+
+	ret = viortc_ptp_get_cross_cap(viortc, vio_ptp);
+	if (ret)
+		goto err_free_dev;
+
+	if (!vio_ptp->have_cross)
+		vio_ptp->ptp_info.getcrosststamp = NULL;
+
+	ptp_clock = ptp_clock_register(&vio_ptp->ptp_info, parent_dev);
+	if (IS_ERR(ptp_clock))
+		goto err_on_register;
+
+	vio_ptp->ptp_clock = ptp_clock;
+
+	return vio_ptp;
+
+err_on_register:
+	ret = PTR_ERR(ptp_clock);
+
+err_free_dev:
+	devm_kfree(parent_dev, vio_ptp);
+	return ERR_PTR(ret);
+}
-- 
2.43.0


