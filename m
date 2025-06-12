Return-Path: <netdev+bounces-197172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE69AD7BB5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02CA17229C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0132E0B42;
	Thu, 12 Jun 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMB1wT2G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74B2DFA59
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758592; cv=none; b=W2LOnCQ4iUeKrsjOo7K49033vVxh+JmVKEKQDFY7uuFLTZM/FLJ4KiRSiBHANViddpw7oYhgKWY33dt/L0/D3tL2/EO08m4McIAx+DOxu5+EfsXlTSbrMHiSHpImYnafydf6N4hTdGuO1UkeYcgwhRSvjh+FTc9RyXiSYE17CzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758592; c=relaxed/simple;
	bh=kVGMA5tBH4lQS1I3swNwDK8P/Wt5unF1NpjJ3r5gaCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFOp+ztJNHflfHibfpVP2j2dkFStoJll5N29Xc7LDOqMNmEhIZJPFgBsIvAELXQPJyBmO5dhDb0x3frEa+DTWDN+zKyAJSP0pQmpaNYdFvbQuHbfijGD7cTEIWCI0Y82bH6JLQKKyCwfhVszxm1uqZQOc+NA1+Jh6YTUXhRhzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMB1wT2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749758588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A5qylhP1i8o1ZD7ek8dv5eS1tNssS3ISxWCoGGcm/8=;
	b=UMB1wT2GoA+vnEuvq6+pfG0JdLGztF+t+OmmNg1+Yir3LxW28H0rgUp5G6CSe6KbJaXStR
	HskvngtGG+DnK7f3Ewp52V6uUMRP2rzMQUvEnG3wfcpu2pMi0EodTqt23p8rtj+AGUNEUs
	qlB8J4NC1oZ2CBiUZvS/si1ytQapVwY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-RJnW1nOJOIuJ03sq3_VHxQ-1; Thu,
 12 Jun 2025 16:03:03 -0400
X-MC-Unique: RJnW1nOJOIuJ03sq3_VHxQ-1
X-Mimecast-MFC-AGG-ID: RJnW1nOJOIuJ03sq3_VHxQ_1749758581
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 532F01809C88;
	Thu, 12 Jun 2025 20:03:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B502018003FC;
	Thu, 12 Jun 2025 20:02:53 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v9 09/14] dpll: zl3073x: Register DPLL devices and pins
Date: Thu, 12 Jun 2025 22:01:40 +0200
Message-ID: <20250612200145.774195-10-ivecera@redhat.com>
In-Reply-To: <20250612200145.774195-1-ivecera@redhat.com>
References: <20250612200145.774195-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Enumerate all available DPLL channels and registers a DPLL device for
each of them. Check all input references and outputs and register
DPLL pins for them.

Number of registered DPLL pins depends on configuration of references
and outputs. If the reference or output is configured as differential
one then only one DPLL pin is registered. Both references and outputs
can be also disabled from firmware configuration and in this case
no DPLL pins are registered.

All registrable references are registered to all available DPLL devices
with exception of DPLLs that are configured in NCO (numerically
controlled oscillator) mode. In this mode DPLL channel acts as PHC and
cannot be locked to any reference.

Device outputs are connected to one of synthesizers and each synthesizer
is driven by some DPLL channel. So output pins belonging to given output
are registered to DPLL device that drives associated synthesizer.

Finally add kworker task to monitor async changes on all DPLL channels
and input pins and to notify about them DPLL core. Output pins are not
monitored as their parameters are not changed asynchronously by the
device.

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Makefile |   2 +-
 drivers/dpll/zl3073x/core.c   | 103 ++++
 drivers/dpll/zl3073x/core.h   |  17 +
 drivers/dpll/zl3073x/dpll.c   | 899 ++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.h   |  42 ++
 drivers/dpll/zl3073x/regs.h   |  56 +++
 6 files changed, 1118 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dpll/zl3073x/dpll.c
 create mode 100644 drivers/dpll/zl3073x/dpll.h

diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
index 56d7d9feeaf0d..5ccddb6194878 100644
--- a/drivers/dpll/zl3073x/Makefile
+++ b/drivers/dpll/zl3073x/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ZL3073X)		+= zl3073x.o
-zl3073x-objs			:= core.o prop.o
+zl3073x-objs			:= core.o dpll.o prop.o
 
 obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
 zl3073x_i2c-objs		:= i2c.o
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index f2520c48fcf51..f1b77ff14e383 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -15,6 +15,7 @@
 #include <net/devlink.h>
 
 #include "core.h"
+#include "dpll.h"
 #include "regs.h"
 
 /* Chip IDs for zl30731 */
@@ -768,6 +769,103 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 	return rc;
 }
 
+static void
+zl3073x_dev_periodic_work(struct kthread_work *work)
+{
+	struct zl3073x_dev *zldev = container_of(work, struct zl3073x_dev,
+						 work.work);
+	struct zl3073x_dpll *zldpll;
+
+	list_for_each_entry(zldpll, &zldev->dplls, list)
+		zl3073x_dpll_changes_check(zldpll);
+
+	/* Run twice a second */
+	kthread_queue_delayed_work(zldev->kworker, &zldev->work,
+				   msecs_to_jiffies(500));
+}
+
+static void zl3073x_dev_dpll_fini(void *ptr)
+{
+	struct zl3073x_dpll *zldpll, *next;
+	struct zl3073x_dev *zldev = ptr;
+
+	/* Stop monitoring thread */
+	if (zldev->kworker) {
+		kthread_cancel_delayed_work_sync(&zldev->work);
+		kthread_destroy_worker(zldev->kworker);
+		zldev->kworker = NULL;
+	}
+
+	/* Release DPLLs */
+	list_for_each_entry_safe(zldpll, next, &zldev->dplls, list) {
+		zl3073x_dpll_unregister(zldpll);
+		list_del(&zldpll->list);
+		zl3073x_dpll_free(zldpll);
+	}
+}
+
+static int
+zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
+{
+	struct kthread_worker *kworker;
+	struct zl3073x_dpll *zldpll;
+	unsigned int i;
+	int rc;
+
+	INIT_LIST_HEAD(&zldev->dplls);
+
+	/* Initialize all DPLLs */
+	for (i = 0; i < num_dplls; i++) {
+		zldpll = zl3073x_dpll_alloc(zldev, i);
+		if (IS_ERR(zldpll)) {
+			dev_err_probe(zldev->dev, PTR_ERR(zldpll),
+				      "Failed to alloc DPLL%u\n", i);
+			goto error;
+		}
+
+		rc = zl3073x_dpll_register(zldpll);
+		if (rc) {
+			dev_err_probe(zldev->dev, rc,
+				      "Failed to register DPLL%u\n", i);
+			zl3073x_dpll_free(zldpll);
+			goto error;
+		}
+
+		list_add(&zldpll->list, &zldev->dplls);
+	}
+
+	/* Perform initial firmware fine phase correction */
+	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc,
+			      "Failed to init fine phase correction\n");
+		goto error;
+	}
+
+	/* Initialize monitoring thread */
+	kthread_init_delayed_work(&zldev->work, zl3073x_dev_periodic_work);
+	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldev->dev));
+	if (IS_ERR(kworker)) {
+		rc = PTR_ERR(kworker);
+		goto error;
+	}
+
+	zldev->kworker = kworker;
+	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
+
+	/* Add devres action to release DPLL related resources */
+	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
+	if (rc)
+		goto error;
+
+	return 0;
+
+error:
+	zl3073x_dev_dpll_fini(zldev);
+
+	return rc;
+}
+
 static void zl3073x_devlink_unregister(void *ptr)
 {
 	devlink_unregister(ptr);
@@ -844,6 +942,11 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	if (rc)
 		return rc;
 
+	/* Register DPLL channels */
+	rc = zl3073x_devm_dpll_init(zldev, chip_info->num_channels);
+	if (rc)
+		return rc;
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 4fcce761fc5f2..adae94944376a 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -3,6 +3,8 @@
 #ifndef _ZL3073X_H
 #define _ZL3073X_H
 
+#include <linux/kthread.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
@@ -10,6 +12,7 @@
 
 struct device;
 struct regmap;
+struct zl3073x_dpll;
 
 /*
  * Hardware limits for ZL3073x chip family
@@ -18,6 +21,10 @@ struct regmap;
 #define ZL3073X_NUM_REFS	10
 #define ZL3073X_NUM_OUTS	10
 #define ZL3073X_NUM_SYNTHS	5
+#define ZL3073X_NUM_INPUT_PINS	ZL3073X_NUM_REFS
+#define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTS * 2)
+#define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
+				 ZL3073X_NUM_OUTPUT_PINS)
 
 /**
  * struct zl3073x_ref - input reference invariant info
@@ -62,6 +69,9 @@ struct zl3073x_synth {
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
+ * @dplls: list of DPLLs
+ * @kworker: thread for periodic work
+ * @work: periodic work
  */
 struct zl3073x_dev {
 	struct device		*dev;
@@ -73,6 +83,13 @@ struct zl3073x_dev {
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
 	struct zl3073x_out	out[ZL3073X_NUM_OUTS];
 	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
+
+	/* DPLL channels */
+	struct list_head	dplls;
+
+	/* Monitor */
+	struct kthread_worker		*kworker;
+	struct kthread_delayed_work	work;
 };
 
 enum zl3073x_chip_type {
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
new file mode 100644
index 0000000000000..f49ddc30c9eb0
--- /dev/null
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -0,0 +1,899 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/dpll.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/netlink.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
+
+#include "core.h"
+#include "dpll.h"
+#include "prop.h"
+#include "regs.h"
+
+#define ZL3073X_DPLL_REF_NONE		ZL3073X_NUM_REFS
+#define ZL3073X_DPLL_REF_IS_VALID(_ref)	((_ref) != ZL3073X_DPLL_REF_NONE)
+
+/**
+ * struct zl3073x_dpll_pin - DPLL pin
+ * @list: this DPLL pin list entry
+ * @dpll: DPLL the pin is registered to
+ * @dpll_pin: pointer to registered dpll_pin
+ * @label: package label
+ * @dir: pin direction
+ * @id: pin id
+ * @prio: pin priority <0, 14>
+ * @selectable: pin is selectable in automatic mode
+ * @pin_state: last saved pin state
+ */
+struct zl3073x_dpll_pin {
+	struct list_head	list;
+	struct zl3073x_dpll	*dpll;
+	struct dpll_pin		*dpll_pin;
+	char			label[8];
+	enum dpll_pin_direction	dir;
+	u8			id;
+	u8			prio;
+	bool			selectable;
+	enum dpll_pin_state	pin_state;
+};
+
+/**
+ * zl3073x_dpll_is_input_pin - check if the pin is input one
+ * @pin: pin to check
+ *
+ * Return: true if pin is input, false if pin is output.
+ */
+static bool
+zl3073x_dpll_is_input_pin(struct zl3073x_dpll_pin *pin)
+{
+	return pin->dir == DPLL_PIN_DIRECTION_INPUT;
+}
+
+/**
+ * zl3073x_dpll_is_p_pin - check if the pin is P-pin
+ * @pin: pin to check
+ *
+ * Return: true if the pin is P-pin, false if it is N-pin
+ */
+static bool
+zl3073x_dpll_is_p_pin(struct zl3073x_dpll_pin *pin)
+{
+	return zl3073x_is_p_pin(pin->id);
+}
+
+static int
+zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
+			       const struct dpll_device *dpll, void *dpll_priv,
+			       enum dpll_pin_direction *direction,
+			       struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *pin = pin_priv;
+
+	*direction = pin->dir;
+
+	return 0;
+}
+
+/**
+ * zl3073x_dpll_selected_ref_get - get currently selected reference
+ * @zldpll: pointer to zl3073x_dpll
+ * @ref: place to store selected reference
+ *
+ * Check for currently selected reference the DPLL should be locked to
+ * and stores its index to given @ref.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 state, value;
+	int rc;
+
+	switch (zldpll->refsel_mode) {
+	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
+		/* For automatic mode read refsel_status register */
+		rc = zl3073x_read_u8(zldev,
+				     ZL_REG_DPLL_REFSEL_STATUS(zldpll->id),
+				     &value);
+		if (rc)
+			return rc;
+
+		/* Extract reference state */
+		state = FIELD_GET(ZL_DPLL_REFSEL_STATUS_STATE, value);
+
+		/* Return the reference only if the DPLL is locked to it */
+		if (state == ZL_DPLL_REFSEL_STATUS_STATE_LOCK)
+			*ref = FIELD_GET(ZL_DPLL_REFSEL_STATUS_REFSEL, value);
+		else
+			*ref = ZL3073X_DPLL_REF_NONE;
+		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
+		/* For manual mode return stored value */
+		*ref = zldpll->forced_ref;
+		break;
+	default:
+		/* For other modes like NCO, freerun... there is no input ref */
+		*ref = ZL3073X_DPLL_REF_NONE;
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_dpll_connected_ref_get - get currently connected reference
+ * @zldpll: pointer to zl3073x_dpll
+ * @ref: place to store selected reference
+ *
+ * Looks for currently connected the DPLL is locked to and stores its index
+ * to given @ref.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	int rc;
+
+	/* Get currently selected input reference */
+	rc = zl3073x_dpll_selected_ref_get(zldpll, ref);
+	if (rc)
+		return rc;
+
+	if (ZL3073X_DPLL_REF_IS_VALID(*ref)) {
+		u8 ref_status;
+
+		/* Read the reference monitor status */
+		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(*ref),
+				     &ref_status);
+		if (rc)
+			return rc;
+
+		/* If the monitor indicates an error nothing is connected */
+		if (ref_status != ZL_REF_MON_STATUS_OK)
+			*ref = ZL3073X_DPLL_REF_NONE;
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_dpll_ref_prio_get - get priority for given input pin
+ * @pin: pointer to pin
+ * @prio: place to store priority
+ *
+ * Reads current priority for the given input pin and stores the value
+ * to @prio.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 ref, ref_prio;
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read DPLL configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
+			   ZL_REG_DPLL_MB_MASK, BIT(zldpll->id));
+	if (rc)
+		return rc;
+
+	/* Read reference priority - one value for P&N pins (4 bits/pin) */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REF_PRIO(ref / 2),
+			     &ref_prio);
+	if (rc)
+		return rc;
+
+	/* Select nibble according pin type */
+	if (zl3073x_dpll_is_p_pin(pin))
+		*prio = FIELD_GET(ZL_DPLL_REF_PRIO_REF_P, ref_prio);
+	else
+		*prio = FIELD_GET(ZL_DPLL_REF_PRIO_REF_N, ref_prio);
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_ref_state_get - get status for given input pin
+ * @pin: pointer to pin
+ * @state: place to store status
+ *
+ * Checks current status for the given input pin and stores the value
+ * to @state.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
+			   enum dpll_pin_state *state)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 ref, ref_conn, status;
+	int rc;
+
+	ref = zl3073x_input_pin_ref_get(pin->id);
+
+	/* Get currently connected reference */
+	rc = zl3073x_dpll_connected_ref_get(zldpll, &ref_conn);
+	if (rc)
+		return rc;
+
+	if (ref == ref_conn) {
+		*state = DPLL_PIN_STATE_CONNECTED;
+		return 0;
+	}
+
+	/* If the DPLL is running in automatic mode and the reference is
+	 * selectable and its monitor does not report any error then report
+	 * pin as selectable.
+	 */
+	if (zldpll->refsel_mode == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
+	    pin->selectable) {
+		/* Read reference monitor status */
+		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref),
+				     &status);
+		if (rc)
+			return rc;
+
+		/* If the monitor indicates errors report the reference
+		 * as disconnected
+		 */
+		if (status == ZL_REF_MON_STATUS_OK) {
+			*state = DPLL_PIN_STATE_SELECTABLE;
+			return 0;
+		}
+	}
+
+	/* Otherwise report the pin as disconnected */
+	*state = DPLL_PIN_STATE_DISCONNECTED;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 enum dpll_pin_state *state,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *pin = pin_priv;
+
+	return zl3073x_dpll_ref_state_get(pin, state);
+}
+
+static int
+zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
+					  void *pin_priv,
+					  const struct dpll_device *dpll,
+					  void *dpll_priv,
+					  enum dpll_pin_state *state,
+					  struct netlink_ext_ack *extack)
+{
+	/* If the output pin is registered then it is always connected */
+	*state = DPLL_PIN_STATE_CONNECTED;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
+			     enum dpll_lock_status *status,
+			     enum dpll_lock_status_error *status_error,
+			     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 mon_status;
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(zldpll->id),
+			     &mon_status);
+
+	if (rc)
+		return rc;
+
+	if (FIELD_GET(ZL_DPLL_MON_STATUS_LOCK, mon_status)) {
+		if (FIELD_GET(ZL_DPLL_MON_STATUS_HO_READY, mon_status))
+			*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ;
+		else
+			*status = DPLL_LOCK_STATUS_LOCKED;
+	} else if (FIELD_GET(ZL_DPLL_MON_STATUS_HO, mon_status)) {
+		*status = DPLL_LOCK_STATUS_HOLDOVER;
+	} else {
+		*status = DPLL_LOCK_STATUS_UNLOCKED;
+	}
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
+		      enum dpll_mode *mode, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	switch (zldpll->refsel_mode) {
+	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
+	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
+	case ZL_DPLL_MODE_REFSEL_MODE_NCO:
+	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
+		/* Use MANUAL for device FREERUN, HOLDOVER, NCO and
+		 * REFLOCK modes
+		 */
+		*mode = DPLL_MODE_MANUAL;
+		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
+		/* Use AUTO for device AUTO mode */
+		*mode = DPLL_MODE_AUTOMATIC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
+	.direction_get = zl3073x_dpll_pin_direction_get,
+	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
+};
+
+static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
+	.direction_get = zl3073x_dpll_pin_direction_get,
+	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
+};
+
+static const struct dpll_device_ops zl3073x_dpll_device_ops = {
+	.lock_status_get = zl3073x_dpll_lock_status_get,
+	.mode_get = zl3073x_dpll_mode_get,
+};
+
+/**
+ * zl3073x_dpll_pin_alloc - allocate DPLL pin
+ * @zldpll: pointer to zl3073x_dpll
+ * @dir: pin direction
+ * @id: pin id
+ *
+ * Allocates and initializes zl3073x_dpll_pin structure for given
+ * pin id and direction.
+ *
+ * Return: pointer to allocated structure on success, error pointer on error
+ */
+static struct zl3073x_dpll_pin *
+zl3073x_dpll_pin_alloc(struct zl3073x_dpll *zldpll, enum dpll_pin_direction dir,
+		       u8 id)
+{
+	struct zl3073x_dpll_pin *pin;
+
+	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
+	if (!pin)
+		return ERR_PTR(-ENOMEM);
+
+	pin->dpll = zldpll;
+	pin->dir = dir;
+	pin->id = id;
+
+	return pin;
+}
+
+/**
+ * zl3073x_dpll_pin_free - deallocate DPLL pin
+ * @pin: pin to free
+ *
+ * Deallocates DPLL pin previously allocated by @zl3073x_dpll_pin_alloc.
+ */
+static void
+zl3073x_dpll_pin_free(struct zl3073x_dpll_pin *pin)
+{
+	WARN(pin->dpll_pin != NULL, "DPLL pin is still registered\n");
+
+	kfree(pin);
+}
+
+/**
+ * zl3073x_dpll_pin_register - register DPLL pin
+ * @pin: pointer to DPLL pin
+ * @index: absolute pin index for registration
+ *
+ * Registers given DPLL pin into DPLL sub-system.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_pin_props *props;
+	const struct dpll_pin_ops *ops;
+	int rc;
+
+	/* Get pin properties */
+	props = zl3073x_pin_props_get(zldpll->dev, pin->dir, pin->id);
+	if (IS_ERR(props))
+		return PTR_ERR(props);
+
+	/* Save package label */
+	strscpy(pin->label, props->package_label);
+
+	if (zl3073x_dpll_is_input_pin(pin)) {
+		rc = zl3073x_dpll_ref_prio_get(pin, &pin->prio);
+		if (rc)
+			goto err_prio_get;
+
+		if (pin->prio == ZL_DPLL_REF_PRIO_NONE) {
+			/* Clamp prio to max value & mark pin non-selectable */
+			pin->prio = ZL_DPLL_REF_PRIO_MAX;
+			pin->selectable = false;
+		} else {
+			/* Mark pin as selectable */
+			pin->selectable = true;
+		}
+	}
+
+	/* Create or get existing DPLL pin */
+	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
+				     &props->dpll_props);
+	if (IS_ERR(pin->dpll_pin)) {
+		rc = PTR_ERR(pin->dpll_pin);
+		goto err_pin_get;
+	}
+
+	if (zl3073x_dpll_is_input_pin(pin))
+		ops = &zl3073x_dpll_input_pin_ops;
+	else
+		ops = &zl3073x_dpll_output_pin_ops;
+
+	/* Register the pin */
+	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
+	if (rc)
+		goto err_register;
+
+	/* Free pin properties */
+	zl3073x_pin_props_put(props);
+
+	return 0;
+
+err_register:
+	dpll_pin_put(pin->dpll_pin);
+err_prio_get:
+	pin->dpll_pin = NULL;
+err_pin_get:
+	zl3073x_pin_props_put(props);
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_pin_unregister - unregister DPLL pin
+ * @pin: pointer to DPLL pin
+ *
+ * Unregisters pin previously registered by @zl3073x_dpll_pin_register.
+ */
+static void
+zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	const struct dpll_pin_ops *ops;
+
+	WARN(pin->dpll_pin == NULL, "DPLL pin is not registered\n");
+
+	if (zl3073x_dpll_is_input_pin(pin))
+		ops = &zl3073x_dpll_input_pin_ops;
+	else
+		ops = &zl3073x_dpll_output_pin_ops;
+
+	/* Unregister the pin */
+	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
+
+	dpll_pin_put(pin->dpll_pin);
+	pin->dpll_pin = NULL;
+}
+
+/**
+ * zl3073x_dpll_pins_unregister - unregister all registered DPLL pins
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Enumerates all DPLL pins registered to given DPLL device and
+ * unregisters them.
+ */
+static void
+zl3073x_dpll_pins_unregister(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dpll_pin *pin, *next;
+
+	list_for_each_entry_safe(pin, next, &zldpll->pins, list) {
+		zl3073x_dpll_pin_unregister(pin);
+		list_del(&pin->list);
+		zl3073x_dpll_pin_free(pin);
+	}
+}
+
+/**
+ * zl3073x_dpll_pin_is_registrable - check if the pin is registrable
+ * @zldpll: pointer to zl3073x_dpll structure
+ * @dir: pin direction
+ * @index: pin index
+ *
+ * Checks if the given pin can be registered to given DPLL. For both
+ * directions the pin can be registered if it is enabled. In case of
+ * differential signal type only P-pin is reported as registrable.
+ * And additionally for the output pin, the pin can be registered only
+ * if it is connected to synthesizer that is driven by given DPLL.
+ *
+ * Return: true if the pin is registrable, false if not
+ */
+static bool
+zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
+				enum dpll_pin_direction dir, u8 index)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	bool is_diff, is_enabled;
+	const char *name;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
+		u8 ref = zl3073x_input_pin_ref_get(index);
+
+		name = "REF";
+
+		/* Skip the pin if the DPLL is running in NCO mode */
+		if (zldpll->refsel_mode == ZL_DPLL_MODE_REFSEL_MODE_NCO)
+			return false;
+
+		is_diff = zl3073x_ref_is_diff(zldev, ref);
+		is_enabled = zl3073x_ref_is_enabled(zldev, ref);
+	} else {
+		/* Output P&N pair shares single HW output */
+		u8 out = zl3073x_output_pin_out_get(index);
+
+		name = "OUT";
+
+		/* Skip the pin if it is connected to different DPLL channel */
+		if (zl3073x_out_dpll_get(zldev, out) != zldpll->id) {
+			dev_dbg(zldev->dev,
+				"%s%u is driven by different DPLL\n", name,
+				out);
+
+			return false;
+		}
+
+		is_diff = zl3073x_out_is_diff(zldev, out);
+		is_enabled = zl3073x_out_is_enabled(zldev, out);
+	}
+
+	/* Skip N-pin if the corresponding input/output is differential */
+	if (is_diff && zl3073x_is_n_pin(index)) {
+		dev_dbg(zldev->dev, "%s%u is differential, skipping N-pin\n",
+			name, index / 2);
+
+		return false;
+	}
+
+	/* Skip the pin if it is disabled */
+	if (!is_enabled) {
+		dev_dbg(zldev->dev, "%s%u%c is disabled\n", name, index / 2,
+			zl3073x_is_p_pin(index) ? 'P' : 'N');
+
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * zl3073x_dpll_pins_register - register all registerable DPLL pins
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Enumerates all possible input/output pins and registers all of them
+ * that are registrable.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dpll_pin *pin;
+	enum dpll_pin_direction dir;
+	u8 id, index;
+	int rc;
+
+	/* Process input pins */
+	for (index = 0; index < ZL3073X_NUM_PINS; index++) {
+		/* First input pins and then output pins */
+		if (index < ZL3073X_NUM_INPUT_PINS) {
+			id = index;
+			dir = DPLL_PIN_DIRECTION_INPUT;
+		} else {
+			id = index - ZL3073X_NUM_INPUT_PINS;
+			dir = DPLL_PIN_DIRECTION_OUTPUT;
+		}
+
+		/* Check if the pin registrable to this DPLL */
+		if (!zl3073x_dpll_pin_is_registrable(zldpll, dir, id))
+			continue;
+
+		pin = zl3073x_dpll_pin_alloc(zldpll, dir, id);
+		if (IS_ERR(pin)) {
+			rc = PTR_ERR(pin);
+			goto error;
+		}
+
+		rc = zl3073x_dpll_pin_register(pin, index);
+		if (rc)
+			goto error;
+
+		list_add(&pin->list, &zldpll->pins);
+	}
+
+	return 0;
+
+error:
+	zl3073x_dpll_pins_unregister(zldpll);
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_device_register - register DPLL device
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Registers given DPLL device into DPLL sub-system.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 dpll_mode_refsel;
+	int rc;
+
+	/* Read DPLL mode and forcibly selected reference */
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
+			     &dpll_mode_refsel);
+	if (rc)
+		return rc;
+
+	/* Extract mode and selected input reference */
+	zldpll->refsel_mode = FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE,
+					dpll_mode_refsel);
+	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
+				       dpll_mode_refsel);
+
+	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
+					   THIS_MODULE);
+	if (IS_ERR(zldpll->dpll_dev)) {
+		rc = PTR_ERR(zldpll->dpll_dev);
+		zldpll->dpll_dev = NULL;
+
+		return rc;
+	}
+
+	rc = dpll_device_register(zldpll->dpll_dev,
+				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
+				  &zl3073x_dpll_device_ops, zldpll);
+	if (rc) {
+		dpll_device_put(zldpll->dpll_dev);
+		zldpll->dpll_dev = NULL;
+	}
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_device_unregister - unregister DPLL device
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Unregisters given DPLL device from DPLL sub-system previously registered
+ * by @zl3073x_dpll_device_register.
+ */
+static void
+zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
+{
+	WARN(zldpll->dpll_dev == NULL, "DPLL device is not registered\n");
+
+	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
+			       zldpll);
+	dpll_device_put(zldpll->dpll_dev);
+	zldpll->dpll_dev = NULL;
+}
+
+/**
+ * zl3073x_dpll_changes_check - check for changes and send notifications
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Checks for changes on given DPLL device and its registered DPLL pins
+ * and sends notifications about them.
+ *
+ * This function is periodically called from @zl3073x_dev_periodic_work.
+ */
+void
+zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	enum dpll_lock_status lock_status;
+	struct device *dev = zldev->dev;
+	struct zl3073x_dpll_pin *pin;
+	int rc;
+
+	/* Get current lock status for the DPLL */
+	rc = zl3073x_dpll_lock_status_get(zldpll->dpll_dev, zldpll,
+					  &lock_status, NULL, NULL);
+	if (rc) {
+		dev_err(dev, "Failed to get DPLL%u lock status: %pe\n",
+			zldpll->id, ERR_PTR(rc));
+		return;
+	}
+
+	/* If lock status was changed then notify DPLL core */
+	if (zldpll->lock_status != lock_status) {
+		zldpll->lock_status = lock_status;
+		dpll_device_change_ntf(zldpll->dpll_dev);
+	}
+
+	/* Input pin monitoring does make sense only in automatic
+	 * or forced reference modes.
+	 */
+	if (zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
+	    zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
+		return;
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		enum dpll_pin_state state;
+
+		/* Output pins change checks are not necessary because output
+		 * states are constant.
+		 */
+		if (!zl3073x_dpll_is_input_pin(pin))
+			continue;
+
+		rc = zl3073x_dpll_ref_state_get(pin, &state);
+		if (rc) {
+			dev_err(dev,
+				"Failed to get %s on DPLL%u state: %pe\n",
+				pin->label, zldpll->id, ERR_PTR(rc));
+			return;
+		}
+
+		if (state != pin->pin_state) {
+			dev_dbg(dev, "%s state changed: %u->%u\n", pin->label,
+				pin->pin_state, state);
+			pin->pin_state = state;
+			dpll_pin_change_ntf(pin->dpll_pin);
+		}
+	}
+
+}
+
+/**
+ * zl3073x_dpll_init_fine_phase_adjust - do initial fine phase adjustments
+ * @zldev: pointer to zl3073x device
+ *
+ * Performs initial fine phase adjustments needed per datasheet.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int
+zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)
+{
+	int rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_MASK, 0x1f);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_INTVL, 0x01);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u16(zldev, ZL_REG_SYNTH_PHASE_SHIFT_DATA, 0xffff);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
+	if (rc)
+		return rc;
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_alloc - allocate DPLL device
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel number
+ *
+ * Allocates DPLL device structure for given DPLL channel.
+ *
+ * Return: pointer to DPLL device on success, error pointer on error
+ */
+struct zl3073x_dpll *
+zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
+{
+	struct zl3073x_dpll *zldpll;
+
+	zldpll = kzalloc(sizeof(*zldpll), GFP_KERNEL);
+	if (!zldpll)
+		return ERR_PTR(-ENOMEM);
+
+	zldpll->dev = zldev;
+	zldpll->id = ch;
+	INIT_LIST_HEAD(&zldpll->pins);
+
+	return zldpll;
+}
+
+/**
+ * zl3073x_dpll_free - free DPLL device
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
+ */
+void
+zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
+{
+	WARN(zldpll->dpll_dev != NULL, "DPLL device is still registered\n");
+
+	kfree(zldpll);
+}
+
+/**
+ * zl3073x_dpll_register - register DPLL device and all its pins
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Registers given DPLL device and all its pins into DPLL sub-system.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int
+zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
+{
+	int rc;
+
+	rc = zl3073x_dpll_device_register(zldpll);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_dpll_pins_register(zldpll);
+	if (rc) {
+		zl3073x_dpll_device_unregister(zldpll);
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_dpll_unregister - unregister DPLL device and its pins
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Unregisters given DPLL device and all its pins from DPLL sub-system
+ * previously registered by @zl3073x_dpll_register.
+ */
+void
+zl3073x_dpll_unregister(struct zl3073x_dpll *zldpll)
+{
+	/* Unregister all pins and dpll */
+	zl3073x_dpll_pins_unregister(zldpll);
+	zl3073x_dpll_device_unregister(zldpll);
+}
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
new file mode 100644
index 0000000000000..db7388cc377fd
--- /dev/null
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_DPLL_H
+#define _ZL3073X_DPLL_H
+
+#include <linux/dpll.h>
+#include <linux/list.h>
+
+#include "core.h"
+
+/**
+ * struct zl3073x_dpll - ZL3073x DPLL sub-device structure
+ * @list: this DPLL list entry
+ * @dev: pointer to multi-function parent device
+ * @id: DPLL index
+ * @refsel_mode: reference selection mode
+ * @forced_ref: selected reference in forced reference lock mode
+ * @dpll_dev: pointer to registered DPLL device
+ * @lock_status: last saved DPLL lock status
+ * @pins: list of pins
+ */
+struct zl3073x_dpll {
+	struct list_head		list;
+	struct zl3073x_dev		*dev;
+	u8				id;
+	u8				refsel_mode;
+	u8				forced_ref;
+	struct dpll_device		*dpll_dev;
+	enum dpll_lock_status		lock_status;
+	struct list_head		pins;
+};
+
+struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
+void zl3073x_dpll_free(struct zl3073x_dpll *zldpll);
+
+int zl3073x_dpll_register(struct zl3073x_dpll *zldpll);
+void zl3073x_dpll_unregister(struct zl3073x_dpll *zldpll);
+
+int zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev);
+void zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll);
+
+#endif /* _ZL3073X_DPLL_H */
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 753b42d8b2093..34e905053a1ef 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -72,6 +72,40 @@
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
 #define ZL_REG_CUSTOM_CONFIG_VER		ZL_REG(0, 0x07, 4)
 
+/*************************
+ * Register Page 2, Status
+ *************************/
+
+#define ZL_REG_REF_MON_STATUS(_idx)					\
+	ZL_REG_IDX(_idx, 2, 0x02, 1, ZL3073X_NUM_REFS, 1)
+#define ZL_REF_MON_STATUS_OK			0 /* all bits zeroed */
+
+#define ZL_REG_DPLL_MON_STATUS(_idx)					\
+	ZL_REG_IDX(_idx, 2, 0x10, 1, ZL3073X_MAX_CHANNELS, 1)
+#define ZL_DPLL_MON_STATUS_LOCK			BIT(0)
+#define ZL_DPLL_MON_STATUS_HO			BIT(1)
+#define ZL_DPLL_MON_STATUS_HO_READY		BIT(2)
+
+#define ZL_REG_DPLL_REFSEL_STATUS(_idx)					\
+	ZL_REG_IDX(_idx, 2, 0x30, 1, ZL3073X_MAX_CHANNELS, 1)
+#define ZL_DPLL_REFSEL_STATUS_REFSEL		GENMASK(3, 0)
+#define ZL_DPLL_REFSEL_STATUS_STATE		GENMASK(6, 4)
+#define ZL_DPLL_REFSEL_STATUS_STATE_LOCK	4
+
+/***********************
+ * Register Page 5, DPLL
+ ***********************/
+
+#define ZL_REG_DPLL_MODE_REFSEL(_idx)					\
+	ZL_REG_IDX(_idx, 5, 0x04, 1, ZL3073X_MAX_CHANNELS, 4)
+#define ZL_DPLL_MODE_REFSEL_MODE		GENMASK(2, 0)
+#define ZL_DPLL_MODE_REFSEL_MODE_FREERUN	0
+#define ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER	1
+#define ZL_DPLL_MODE_REFSEL_MODE_REFLOCK	2
+#define ZL_DPLL_MODE_REFSEL_MODE_AUTO		3
+#define ZL_DPLL_MODE_REFSEL_MODE_NCO		4
+#define ZL_DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
+
 /***********************************
  * Register Page 9, Synth and Output
  ***********************************/
@@ -81,6 +115,11 @@
 #define ZL_SYNTH_CTRL_EN			BIT(0)
 #define ZL_SYNTH_CTRL_DPLL_SEL			GENMASK(6, 4)
 
+#define ZL_REG_SYNTH_PHASE_SHIFT_CTRL		ZL_REG(9, 0x1e, 1)
+#define ZL_REG_SYNTH_PHASE_SHIFT_MASK		ZL_REG(9, 0x1f, 1)
+#define ZL_REG_SYNTH_PHASE_SHIFT_INTVL		ZL_REG(9, 0x20, 1)
+#define ZL_REG_SYNTH_PHASE_SHIFT_DATA		ZL_REG(9, 0x21, 2)
+
 #define ZL_REG_OUTPUT_CTRL(_idx)					\
 	ZL_REG_IDX(_idx, 9, 0x28, 1, ZL3073X_NUM_OUTS, 1)
 #define ZL_OUTPUT_CTRL_EN			BIT(0)
@@ -100,6 +139,23 @@
 #define ZL_REF_CONFIG_ENABLE			BIT(0)
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
 
+/********************************
+ * Register Page 12, DPLL Mailbox
+ ********************************/
+
+#define ZL_REG_DPLL_MB_MASK			ZL_REG(12, 0x02, 2)
+
+#define ZL_REG_DPLL_MB_SEM			ZL_REG(12, 0x04, 1)
+#define ZL_DPLL_MB_SEM_WR			BIT(0)
+#define ZL_DPLL_MB_SEM_RD			BIT(1)
+
+#define ZL_REG_DPLL_REF_PRIO(_idx)					\
+	ZL_REG_IDX(_idx, 12, 0x52, 1, ZL3073X_NUM_REFS / 2, 1)
+#define ZL_DPLL_REF_PRIO_REF_P			GENMASK(3, 0)
+#define ZL_DPLL_REF_PRIO_REF_N			GENMASK(7, 4)
+#define ZL_DPLL_REF_PRIO_MAX			14
+#define ZL_DPLL_REF_PRIO_NONE			15
+
 /*********************************
  * Register Page 13, Synth Mailbox
  *********************************/
-- 
2.49.0


