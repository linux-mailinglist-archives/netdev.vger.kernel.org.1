Return-Path: <netdev+bounces-179795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7BFA7E86C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA94189A32C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441921D581;
	Mon,  7 Apr 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grmZ5u8C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9421B91D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047146; cv=none; b=bqB43HsMQ0woUjXA7pjp5xJUrEHxNDbEy+5BHyS28IVQt61itsS6CtG4WG1P1hvQ1ScutVyykSlZQ+bl2I9Zb6dnBWaJVoPrNlz5+aVKbcgXyWjdDElk4noDFrS0SLPQlZuKNbM/5AAgOfF9vvKbfZ4YUgtFJiVipfqHEJMNW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047146; c=relaxed/simple;
	bh=m1sZ7qgxi4chv4YPU8hkyxOFz39bNoRwJzSDtVjQKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjzB/yzbMKv6Riqb7iDCd9JOG2kSH0DCIjO3TZ9d4/UIgmZCYn3wqw2Oh8tJeseube8PaR1/QtSfDRixZGlxwJ5lzm7RBLKyXHswZ/c3y9Wg1GSU2EfPyt46n1m4u/IyjtSHSPrqNNgoPgGVpYFMX53W3hIV9tTd6HI3YwL6xeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grmZ5u8C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YGpxqzLBpyHnt/c4pOb671V2iscfF8fW2Izjlbw7rc=;
	b=grmZ5u8CZqAsMijG+3xVs00pVGHNTL3kK+NXvJ+iLVk9/covfGT50lm6w6gR16AEsQjfY3
	8aR6CjUMEaQdgULk8Ug67WHV4ck24BgmN07O60Ex+k3tbBcCsq8YreyIVCTyl7YHB33Zwg
	8xYOzijcz9c3eXIqFb6xaxjQpbNXCOE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-9VQx0OHWNZ2kSHIQRtitwg-1; Mon,
 07 Apr 2025 13:32:17 -0400
X-MC-Unique: 9VQx0OHWNZ2kSHIQRtitwg-1
X-Mimecast-MFC-AGG-ID: 9VQx0OHWNZ2kSHIQRtitwg_1744047135
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C254A18001E1;
	Mon,  7 Apr 2025 17:32:15 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F0C71955BC0;
	Mon,  7 Apr 2025 17:32:09 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 13/28] dpll: Add Microchip ZL3073x DPLL driver
Date: Mon,  7 Apr 2025 19:31:43 +0200
Message-ID: <20250407173149.1010216-4-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a DPLL driver for Microchip Azurite chip family with basic
functionality where only required DPLL and pin callbacks are
implemented. Other features are added by subsequent patches.

The driver controls the sub-devices created by zl3073x MFD driver and
each DPLL sub-device represents one of the DPLL channels that are
provided by the device.

For each sub-device the driver registers a DPLL device and also input and
output pins. Number of registered pins depend on their configuration
that is stored in flash memory inside the device. The input pins can be
configured as differential or single-ended ones. If the input/output
is configured as differential then P&N pins form one input/output and only
1 input/output pin is registered. For single-ended case the number of
registered pins is up to 2 depending on whether the pin (P or N) is
enabled or disabled in configuration.

Each DPLL channel (sub-device) can drive up to 5 synthesizers whose
output is connected to up to 10 output pin pairs (P & N). Because output
pin pairs shares synthesizers where each is driven by different DPLL
channel, the driver does not support to change state of output pins.
So the output pins are registered only for DPLL device they are
connected to (based on stored configuration) and are always reported as
connected. This does not apply to the case of input pins where any of
them can be a reference for any DPLL channel.

The driver also creates a kworker task to monitor DPLL channel and input
pins changes and to notify about them DPLL core. Output pins are not
monitored as their parameters are not changed asynchronously by the
device.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 MAINTAINERS                 |    1 +
 drivers/dpll/Kconfig        |   16 +
 drivers/dpll/Makefile       |    2 +
 drivers/dpll/dpll_zl3073x.c | 1073 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h |    5 +
 5 files changed, 1097 insertions(+)
 create mode 100644 drivers/dpll/dpll_zl3073x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c69a69d862310..3d542440d0b2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15999,6 +15999,7 @@ M:	Ivan Vecera <ivecera@redhat.com>
 M:	Prathosh Satish <Prathosh.Satish@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	drivers/dpll/dpll_zl3073x*
 F:	drivers/mfd/zl3073x*
 F:	include/linux/mfd/zl3073x.h
 
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index 20607ed542435..efd867f338dfc 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -3,5 +3,21 @@
 # Generic DPLL drivers configuration
 #
 
+menu "DPLL support"
+
 config DPLL
 	bool
+
+config DPLL_ZL3073X
+	tristate "Microchip Azurite DPLL driver"
+	depends on MFD_ZL3073X_CORE
+	select DPLL
+	help
+	  This driver adds support for DPLL exposed by Microchip Azurite
+	  chip family.
+
+	  The devices handled by this driver are created by MFD zl3073x
+	  driver as sub-devices for each DPLL channel that is present
+	  in the device.
+
+endmenu
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile
index 2e5b278501105..9f7c99261e74d 100644
--- a/drivers/dpll/Makefile
+++ b/drivers/dpll/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_DPLL)      += dpll.o
 dpll-y                  += dpll_core.o
 dpll-y                  += dpll_netlink.o
 dpll-y                  += dpll_nl.o
+
+obj-$(CONFIG_DPLL_ZL3073X)	+= dpll_zl3073x.o
diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
new file mode 100644
index 0000000000000..34bd6964fe001
--- /dev/null
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -0,0 +1,1073 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitfield.h>
+#include <linux/dpll.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/zl3073x.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+/*
+ * Register Map Page 2, Status
+ */
+ZL3073X_REG8_IDX_DEF(ref_mon_status,		0x102,
+						ZL3073X_NUM_INPUT_PINS, 1);
+#define REF_MON_STATUS_LOS_FAIL			BIT(0)
+#define REF_MON_STATUS_SCM_FAIL			BIT(1)
+#define REF_MON_STATUS_CFM_FAIL			BIT(2)
+#define REF_MON_STATUS_GST_FAIL			BIT(3)
+#define REF_MON_STATUS_PFM_FAIL			BIT(4)
+#define REF_MON_STATUS_ESYNC_FAIL		BIT(6)
+#define REF_MON_STATUS_SPLIT_XO_FAIL		BIT(7)
+#define REF_MON_STATUS_OK			0	/* all bits zeroed */
+
+ZL3073X_REG8_IDX_DEF(dpll_mon_status,		0x110, ZL3073X_NUM_CHANNELS, 1);
+#define DPLL_MON_STATUS_LOCK			BIT(0)
+#define DPLL_MON_STATUS_HO			BIT(1)
+#define DPLL_MON_STATUS_HO_READY		BIT(2)
+
+ZL3073X_REG8_IDX_DEF(dpll_refsel_status,	0x130, ZL3073X_NUM_CHANNELS, 1);
+#define DPLL_REFSEL_STATUS_REFSEL		GENMASK(3, 0)
+#define DPLL_REFSEL_STATUS_STATE		GENMASK(6, 4)
+#define DPLL_REFSEL_STATUS_STATE_FREERUN	0
+#define DPLL_REFSEL_STATUS_STATE_HOLDOVER	1
+#define DPLL_REFSEL_STATUS_STATE_FASTLOCK	2
+#define DPLL_REFSEL_STATUS_STATE_ACQUIRING	3
+#define DPLL_REFSEL_STATUS_STATE_LOCK		4
+
+/*
+ * Register Map Page 5, DPLL
+ */
+ZL3073X_REG8_IDX_DEF(dpll_mode_refsel,		0x284, ZL3073X_NUM_CHANNELS, 4);
+#define DPLL_MODE_REFSEL_MODE			GENMASK(2, 0)
+#define DPLL_MODE_REFSEL_MODE_FREERUN		0
+#define DPLL_MODE_REFSEL_MODE_HOLDOVER		1
+#define DPLL_MODE_REFSEL_MODE_REFLOCK		2
+#define DPLL_MODE_REFSEL_MODE_AUTO		3
+#define DPLL_MODE_REFSEL_MODE_NCO		4
+#define DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
+
+/*
+ * Register Map Page 9, Synth and Output
+ */
+ZL3073X_REG8_DEF(synth_phase_shift_ctrl,	0x49e);
+ZL3073X_REG8_DEF(synth_phase_shift_mask,	0x49f);
+ZL3073X_REG8_DEF(synth_phase_shift_intvl,	0x4a0);
+ZL3073X_REG16_DEF(synth_phase_shift_data,	0x4a1);
+
+/*
+ * Register Map Page 12, DPLL Mailbox
+ */
+ZL3073X_REG8_IDX_DEF(dpll_ref_prio,		0x652,
+						ZL3073X_NUM_INPUT_PINS / 2, 1);
+#define DPLL_REF_PRIO_REF_P			GENMASK(3, 0)
+#define DPLL_REF_PRIO_REF_N			GENMASK(7, 4)
+#define DPLL_REF_PRIO_MAX			14
+#define DPLL_REF_PRIO_NONE			15 /* non-selectable */
+
+#define ZL3073X_REF_NONE			ZL3073X_NUM_INPUT_PINS
+#define ZL3073X_REF_IS_VALID(_ref)		((_ref) != ZL3073X_REF_NONE)
+
+/**
+ * struct zl3073x_dpll_pin_info - DPLL pin info
+ * @props: DPLL core pin properties
+ * @package_label: pin package label
+ */
+struct zl3073x_dpll_pin_info {
+	struct dpll_pin_properties	props;
+	char				package_label[8];
+};
+
+/**
+ * struct zl3073x_dpll_pin - DPLL pin
+ * @dpll_pin: pointer to registered dpll_pin
+ * @index: index in zl3073x_dpll.pins array
+ * @prio: pin priority <0, 14>
+ * @selectable: pin is selectable in automatic mode
+ * @pin_state: last saved pin state
+ */
+struct zl3073x_dpll_pin {
+	struct dpll_pin			*dpll_pin;
+	u8				index;
+	u8				prio;
+	bool				selectable;
+	enum dpll_pin_state		pin_state;
+};
+
+/**
+ * struct zl3073x_dpll - ZL3073x DPLL sub-device structure
+ * @dev: device pointer
+ * @mfd: pointer to multi-function parent device
+ * @id: DPLL index
+ * @refsel_mode: reference selection mode
+ * @forced_ref: selected reference in forced reference lock mode
+ * @dpll_dev: pointer to registered DPLL device
+ * @lock_status: last saved DPLL lock status
+ * @pins: array of pins
+ * @kworker: thread for periodic work
+ * @work: periodic work
+ */
+struct zl3073x_dpll {
+	struct device			*dev;
+	struct zl3073x_dev		*mfd;
+	int				id;
+	u8				refsel_mode;
+	u8				forced_ref;
+	struct dpll_device		*dpll_dev;
+	enum dpll_lock_status		lock_status;
+	struct zl3073x_dpll_pin		pins[ZL3073X_NUM_PINS];
+
+	struct kthread_worker		*kworker;
+	struct kthread_delayed_work	work;
+};
+
+#define pin_to_dpll(_pin)						\
+	container_of((_pin), struct zl3073x_dpll, pins[(_pin)->index])
+
+#define pin_to_dev(_pin)						\
+	pin_to_dpll(_pin)->mfd
+
+/**
+ * zl3073x_dpll_is_input_pin - check if the pin is input one
+ * @pin: pin to check
+ *
+ * Returns true if the pin is input or false if output one.
+ */
+static bool
+zl3073x_dpll_is_input_pin(struct zl3073x_dpll_pin *pin)
+{
+	/* Output pins are stored in zl3073x_dpll.pins first and input
+	 * pins follow.
+	 */
+	if (pin->index >= ZL3073X_NUM_OUTPUT_PINS)
+		return true;
+
+	return false;
+}
+
+/**
+ * zl3073x_dpll_pin_index_get - get pin HW index
+ * @pin: pin pointer
+ *
+ * Returns index of the pin from the HW point of view.
+ */
+static u8
+zl3073x_dpll_pin_index_get(struct zl3073x_dpll_pin *pin)
+{
+	if (zl3073x_dpll_is_input_pin(pin))
+		return pin->index - ZL3073X_NUM_OUTPUT_PINS;
+
+	return pin->index;
+}
+
+/**
+ * zl3073x_dpll_is_n_pin - check if the pin is N-pin
+ * @pin: pin to check
+ *
+ * Returns true if the pin is N-pin or false if output one.
+ */
+static bool
+zl3073x_dpll_is_n_pin(struct zl3073x_dpll_pin *pin)
+{
+	/* P-pins indices are even while N-pins are odd */
+	return zl3073x_is_n_pin(zl3073x_dpll_pin_index_get(pin));
+}
+
+/**
+ * zl3073x_dpll_is_p_pin - check if the pin is P-pin
+ * @pin: pin to check
+ *
+ * Returns true if the pin is P-pin or false if output one.
+ */
+static bool
+zl3073x_dpll_is_p_pin(struct zl3073x_dpll_pin *pin)
+{
+	return zl3073x_is_p_pin(zl3073x_dpll_pin_index_get(pin));
+}
+
+/**
+ * zl3073x_dpll_output_pin_output_get - get output index for given output pin
+ * @pin: pointer to pin
+ *
+ * Returns output index for the given output pin
+ */
+static u8
+zl3073x_dpll_output_pin_output_get(struct zl3073x_dpll_pin *pin)
+{
+	WARN_ON(zl3073x_dpll_is_input_pin(pin));
+
+	return zl3073x_dpll_pin_index_get(pin) / 2;
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
+	if (zl3073x_dpll_is_input_pin(pin))
+		*direction = DPLL_PIN_DIRECTION_INPUT;
+	else
+		*direction = DPLL_PIN_DIRECTION_OUTPUT;
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
+ * Return 0 in case of success or negative value otherwise.
+ */
+static int
+zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
+{
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 state, value;
+	int rc;
+
+	switch (zldpll->refsel_mode) {
+	case DPLL_MODE_REFSEL_MODE_AUTO:
+		/* For automatic mode read refsel_status register */
+		rc = zl3073x_read_dpll_refsel_status(zldev, zldpll->id, &value);
+		if (rc)
+			return rc;
+
+		/* Extract reference state */
+		state = FIELD_GET(DPLL_REFSEL_STATUS_STATE, value);
+
+		/* Return the reference only if the DPLL is locked to it */
+		if (state == DPLL_REFSEL_STATUS_STATE_LOCK)
+			*ref = FIELD_GET(DPLL_REFSEL_STATUS_REFSEL, value);
+		else
+			*ref = ZL3073X_REF_NONE;
+		break;
+	case DPLL_MODE_REFSEL_MODE_REFLOCK:
+		/* For manual mode return stored value */
+		*ref = zldpll->forced_ref;
+		break;
+	default:
+		/* For other modes like NCO, freerun... there is no input ref */
+		*ref = ZL3073X_REF_NONE;
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
+ * Return 0 in case of success or negative value otherwise.
+ */
+static int
+zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
+{
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	int rc;
+
+	/* Get currently selected input reference */
+	rc = zl3073x_dpll_selected_ref_get(zldpll, ref);
+	if (rc)
+		return rc;
+
+	if (ZL3073X_REF_IS_VALID(*ref)) {
+		u8 ref_status;
+
+		/* Read the reference monitor status */
+		rc = zl3073x_read_ref_mon_status(zldev, *ref, &ref_status);
+		if (rc)
+			return rc;
+
+		/* If the monitor indicates an error nothing is connected */
+		if (ref_status != REF_MON_STATUS_OK)
+			*ref = ZL3073X_REF_NONE;
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
+ * Returns 0 in case of success or negative value otherwise.
+ */
+static int
+zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 ref_id, ref_prio;
+	int rc;
+
+	/* Read DPLL configuration into mailbox */
+	rc = zl3073x_mb_dpll_read(zldev, zldpll->id);
+	if (rc)
+		return rc;
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Read ref prio nibble */
+	rc = zl3073x_read_dpll_ref_prio(zldev, ref_id / 2, &ref_prio);
+	if (rc)
+		return rc;
+
+	/* Select nibble according pin type */
+	if (zl3073x_dpll_is_p_pin(pin))
+		*prio = FIELD_GET(DPLL_REF_PRIO_REF_P, ref_prio);
+	else
+		*prio = FIELD_GET(DPLL_REF_PRIO_REF_N, ref_prio);
+
+	return rc;
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
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 ref_id, ref_conn, ref_status;
+	int rc;
+
+	guard(zl3073x)(zldev);
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Get currently connected reference */
+	rc = zl3073x_dpll_connected_ref_get(zldpll, &ref_conn);
+	if (rc)
+		return rc;
+
+	if (ref_id == ref_conn) {
+		*state = DPLL_PIN_STATE_CONNECTED;
+		return 0;
+	}
+
+	/* If the DPLL is running in automatic mode and the reference is
+	 * selectable and its monitor does not report any error then report
+	 * pin as selectable.
+	 */
+	if (zldpll->refsel_mode == DPLL_MODE_REFSEL_MODE_AUTO &&
+	    pin->selectable) {
+		/* Read reference monitor status */
+		rc = zl3073x_read_ref_mon_status(zldev, ref_id, &ref_status);
+		if (rc)
+			return rc;
+
+		/* If the monitor indicates errors report the reference
+		 * as disconnected
+		 */
+		if (ref_status == REF_MON_STATUS_OK) {
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
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 mon_status;
+	int rc;
+
+	guard(zl3073x)(zldev);
+
+	rc = zl3073x_read_dpll_mon_status(zldev, zldpll->id, &mon_status);
+
+	if (rc)
+		return rc;
+
+	if (FIELD_GET(DPLL_MON_STATUS_LOCK, mon_status)) {
+		if (FIELD_GET(DPLL_MON_STATUS_HO_READY, mon_status))
+			*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ;
+		else
+			*status = DPLL_LOCK_STATUS_LOCKED;
+	} else if (FIELD_GET(DPLL_MON_STATUS_HO, mon_status)) {
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
+	case DPLL_MODE_REFSEL_MODE_FREERUN:
+	case DPLL_MODE_REFSEL_MODE_HOLDOVER:
+	case DPLL_MODE_REFSEL_MODE_NCO:
+	case DPLL_MODE_REFSEL_MODE_REFLOCK:
+		/* Use MANUAL for device FREERUN, HOLDOVER, NCO and
+		 * REFLOCK modes
+		 */
+		*mode = DPLL_MODE_MANUAL;
+		break;
+	case DPLL_MODE_REFSEL_MODE_AUTO:
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
+ * zl3073x_dpll_pin_info_package_label_set - generate package label for the pin
+ * @pin: pointer to pin
+ * @pin_info: pointer to pin info structure
+ *
+ * Generates package label string and stores it into pin info structure.
+ *
+ * Possible formats:
+ * REF<n> - differential input reference
+ * REF<n>P & REF<n>N - single-ended input reference (P or N pin)
+ * OUT<n> - differential output
+ * OUT<n>P & OUT<n>N - single-ended output (P or N pin)
+ */
+static void
+zl3073x_dpll_pin_info_package_label_set(struct zl3073x_dpll_pin *pin,
+					struct zl3073x_dpll_pin_info *pin_info)
+{
+	struct zl3073x_dev *zldev = pin_to_dpll(pin)->mfd;
+	char suffix;
+	u8 idx;
+
+	suffix = zl3073x_dpll_is_p_pin(pin) ? 'P' : 'N';
+
+	if (zl3073x_dpll_is_input_pin(pin)) {
+		idx = zl3073x_dpll_pin_index_get(pin);
+
+		if (zl3073x_input_is_diff(zldev, idx))
+			/* For differential use REF<n> */
+			snprintf(pin_info->package_label,
+				 sizeof(pin_info->package_label),
+				 "REF%u", idx / 2);
+		else
+			/* For single-ended use REF<n>P/N */
+			snprintf(pin_info->package_label,
+				 sizeof(pin_info->package_label),
+				 "REF%u%c", idx / 2, suffix);
+	} else {
+		idx = zl3073x_dpll_output_pin_output_get(pin);
+
+		switch (zl3073x_output_signal_format_get(zldev, idx)) {
+		case OUTPUT_MODE_SIGNAL_FORMAT_LVDS:
+		case OUTPUT_MODE_SIGNAL_FORMAT_DIFFERENTIAL:
+		case OUTPUT_MODE_SIGNAL_FORMAT_LOWVCM:
+			/* For differential use OUT<n> */
+			snprintf(pin_info->package_label,
+				 sizeof(pin_info->package_label), "OUT%u", idx);
+			break;
+		default:
+			/* For single-ended use OUT<n>P/N */
+			snprintf(pin_info->package_label,
+				 sizeof(pin_info->package_label), "OUT%u%c",
+				 idx, suffix);
+			break;
+		}
+	}
+
+	/* Set package_label pointer in DPLL core properties to generated
+	 * string.
+	 */
+	pin_info->props.package_label = pin_info->package_label;
+}
+
+/**
+ * zl3073x_dpll_pin_info_get - get pin info
+ * @pin: pin whose info is returned
+ *
+ * The function allocates pin info structure, generates package label
+ * string according pin type and its order number.
+ *
+ * Returns pointer to allocated pin info structure that has to be freed
+ * by @zl3073x_dpll_pin_info_put by the caller and in case of error
+ * then error pointer is returned.
+ */
+static struct zl3073x_dpll_pin_info *
+zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll_pin_info *pin_info;
+
+	/* Allocate pin info structure */
+	pin_info = kzalloc(sizeof(*pin_info), GFP_KERNEL);
+	if (!pin_info)
+		return ERR_PTR(-ENOMEM);
+
+	/* Set pin type */
+	if (zl3073x_dpll_is_input_pin(pin))
+		pin_info->props.type = DPLL_PIN_TYPE_EXT;
+	else
+		pin_info->props.type = DPLL_PIN_TYPE_GNSS;
+
+	pin_info->props.phase_range.min = S32_MIN;
+	pin_info->props.phase_range.max = S32_MAX;
+
+	/* Generate package label for the given pin */
+	zl3073x_dpll_pin_info_package_label_set(pin, pin_info);
+
+	return pin_info;
+}
+
+/**
+ * zl3073x_dpll_pin_info_put - free pin info
+ * @pin_info: pin info to free
+ *
+ * The function deallocates given pin info structure.
+ */
+static void
+zl3073x_dpll_pin_info_put(struct zl3073x_dpll_pin_info *pin_info)
+{
+	/* Free the pin info structure itself */
+	kfree(pin_info);
+}
+
+static int
+zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	struct zl3073x_dpll_pin_info *pin_info;
+	const struct dpll_pin_ops *ops;
+	int rc;
+
+	/* Get pin info */
+	pin_info = zl3073x_dpll_pin_info_get(pin);
+	if (IS_ERR(pin_info))
+		return PTR_ERR(pin_info);
+
+	/* Create or get existing DPLL pin */
+	pin->dpll_pin = dpll_pin_get(zldpll->mfd->clock_id, pin->index,
+				     THIS_MODULE, &pin_info->props);
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
+	/* Free pin info */
+	zl3073x_dpll_pin_info_put(pin_info);
+
+	return 0;
+
+err_register:
+	dpll_pin_put(pin->dpll_pin);
+	pin->dpll_pin = NULL;
+err_pin_get:
+	zl3073x_dpll_pin_info_put(pin_info);
+
+	return rc;
+}
+
+static void
+zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	const struct dpll_pin_ops *ops;
+
+	if (IS_ERR_OR_NULL(pin->dpll_pin))
+		return;
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
+static int
+zl3073x_dpll_register_input_pin(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 ref;
+
+	/* Get index of the pin */
+	ref = zl3073x_dpll_pin_index_get(pin);
+
+	/* If the ref is differential then register only for the P-pin */
+	if (zl3073x_input_is_diff(zldev, ref) && zl3073x_dpll_is_n_pin(pin)) {
+		dev_dbg(zldev->dev, "INPUT%u is differential, skipping N-pin\n",
+			ref);
+		return 0;
+	}
+
+	/* If the ref is disabled then skip registration */
+	if (!zl3073x_input_is_enabled(zldev, ref)) {
+		dev_dbg(zldev->dev, "INPUT%u is disabled\n", ref);
+		return 0;
+	}
+
+	scoped_guard(zl3073x, zldev) {
+		int rc;
+
+		rc = zl3073x_dpll_ref_prio_get(pin, &pin->prio);
+		if (rc)
+			return rc;
+	}
+
+	if (pin->prio == DPLL_REF_PRIO_NONE) {
+		/* Clamp priority to max value and make pin non-selectable */
+		pin->prio = DPLL_REF_PRIO_MAX;
+		pin->selectable = false;
+	} else {
+		/* Mark pin as selectable */
+		pin->selectable = true;
+	}
+
+	/* Register the pin */
+	return zl3073x_dpll_pin_register(pin);
+}
+
+static int
+zl3073x_dpll_register_output_pin(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 dpll, output, synth;
+
+	/* Get output id for the pin and synth where it is connected to */
+	output = zl3073x_dpll_output_pin_output_get(pin);
+	synth = zl3073x_output_synth_get(zldev, output);
+
+	/* Get DPLL channel the synth is associated with */
+	dpll = zl3073x_synth_dpll_get(zldev, synth);
+
+	/* If the output's synth is connected to different DPLL channel
+	 * then skip registration.
+	 */
+	if (dpll != zldpll->id) {
+		dev_dbg(zldev->dev, "OUTPUT%u is driven by different DPLL\n",
+			output);
+		return 0;
+	}
+
+	/* If the output is disabled then skip registration */
+	if (!zl3073x_output_is_enabled(zldev, output)) {
+		dev_dbg(zldev->dev, "OUTPUT%u is disabled\n", output);
+		return 0;
+	}
+
+	/* Check ouput's signal format */
+	switch (zldev->output[output].signal_format) {
+	case OUTPUT_MODE_SIGNAL_FORMAT_DISABLED:
+		/* Output is disabled, nothing to register */
+		dev_dbg(zldev->dev, "OUTPUT%u is disabled by signal format\n",
+			output);
+		return 0;
+
+	case OUTPUT_MODE_SIGNAL_FORMAT_LVDS:
+	case OUTPUT_MODE_SIGNAL_FORMAT_DIFFERENTIAL:
+	case OUTPUT_MODE_SIGNAL_FORMAT_LOWVCM:
+		/* Output is differential, skip registration for N-pin */
+		if (zl3073x_dpll_is_n_pin(pin)) {
+			dev_dbg(zldev->dev,
+				"OUTPUT%u is differential, skipping N-pin\n",
+				output);
+			return 0;
+		}
+		break;
+
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO:
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_INV:
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV:
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV_INV:
+		/* Output is two single ended outputs, continue with
+		 * registration.
+		 */
+		break;
+
+	case OUTPUT_MODE_SIGNAL_FORMAT_ONE_P:
+		/* Output is one single ended P-pin output */
+		if (zl3073x_dpll_is_n_pin(pin)) {
+			dev_dbg(zldev->dev,
+				"OUTPUT%u is P-pin only, skipping N-pin\n",
+				output);
+			return 0;
+		}
+		break;
+	case OUTPUT_MODE_SIGNAL_FORMAT_ONE_N:
+		/* Output is one single ended N-pin output */
+		if (zl3073x_dpll_is_p_pin(pin)) {
+			dev_dbg(zldev->dev,
+				"OUTPUT%u is N-pin only, skipping P-pin\n",
+				output);
+			return 0;
+		}
+		break;
+	default:
+		dev_warn(zldev->dev, "Unknown output mode signal format: %u\n",
+			 zldev->output[output].signal_format);
+		return 0;
+	}
+
+	/* Register the pin */
+	return zl3073x_dpll_pin_register(pin);
+}
+
+static int
+zl3073x_dpll_register_pins(struct zl3073x_dpll *zldpll)
+{
+	int i, rc;
+
+	for (i = 0; i < ZL3073X_NUM_PINS; i++) {
+		struct zl3073x_dpll_pin *pin = &zldpll->pins[i];
+
+		pin->index = i;
+
+		if (zl3073x_dpll_is_input_pin(pin))
+			rc = zl3073x_dpll_register_input_pin(pin);
+		else
+			rc = zl3073x_dpll_register_output_pin(pin);
+
+		if (rc)
+			goto err_register;
+	}
+
+	return 0;
+
+err_register:
+	while (i--)
+		zl3073x_dpll_pin_unregister(&zldpll->pins[i]);
+
+	return rc;
+}
+
+static void
+zl3073x_dpll_unregister_pins(struct zl3073x_dpll *zldpll)
+{
+	int i;
+
+	for (i = 0; i < ZL3073X_NUM_PINS; i++)
+		zl3073x_dpll_pin_unregister(&zldpll->pins[i]);
+}
+
+static int
+zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	int rc;
+
+	scoped_guard(zl3073x, zldev) {
+		u8 dpll_mode_refsel;
+
+		/* Read DPLL mode and forcibly selected reference */
+		rc = zl3073x_read_dpll_mode_refsel(zldev, zldpll->id,
+						   &dpll_mode_refsel);
+		if (rc)
+			return rc;
+
+		/* Extract mode and selected input reference */
+		zldpll->refsel_mode = FIELD_GET(DPLL_MODE_REFSEL_MODE,
+						dpll_mode_refsel);
+		zldpll->forced_ref = FIELD_GET(DPLL_MODE_REFSEL_REF,
+					       dpll_mode_refsel);
+	}
+
+	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
+					   THIS_MODULE);
+	if (IS_ERR(zldpll->dpll_dev))
+		return PTR_ERR(zldpll->dpll_dev);
+
+	rc = dpll_device_register(zldpll->dpll_dev, DPLL_TYPE_PPS,
+				  &zl3073x_dpll_device_ops, zldpll);
+	if (rc) {
+		dpll_device_put(zldpll->dpll_dev);
+		zldpll->dpll_dev = NULL;
+	}
+
+	return rc;
+}
+
+static void
+zl3073x_dpll_unregister(struct zl3073x_dpll *zldpll)
+{
+	if (IS_ERR_OR_NULL(zldpll->dpll_dev))
+		return;
+
+	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
+			       zldpll);
+	dpll_device_put(zldpll->dpll_dev);
+	zldpll->dpll_dev = NULL;
+}
+
+static int
+zl3073x_dpll_init(struct zl3073x_dpll *zldpll)
+{
+	int rc;
+
+	rc = zl3073x_dpll_register(zldpll);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_dpll_register_pins(zldpll);
+	if (rc)
+		zl3073x_dpll_unregister(zldpll);
+
+	return rc;
+}
+
+static void
+zl3073x_dpll_periodic_work(struct kthread_work *work)
+{
+	struct zl3073x_dpll *zldpll = container_of(work, struct zl3073x_dpll,
+						   work.work);
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	enum dpll_lock_status lock_status;
+	int i, rc;
+
+	/* Get current lock status for the DPLL */
+	rc = zl3073x_dpll_lock_status_get(zldpll->dpll_dev, zldpll,
+					  &lock_status, NULL, NULL);
+	if (rc) {
+		dev_err(zldpll->mfd->dev,
+			"Failed to get DPLL lock status: %pe", ERR_PTR(rc));
+		goto out;
+	}
+
+	/* If lock status was changed then notify DPLL core */
+	if (zldpll->lock_status != lock_status) {
+		zldpll->lock_status = lock_status;
+		dpll_device_change_ntf(zldpll->dpll_dev);
+	}
+
+	/* Output pins change checks are not necessary because output states
+	 * are constant.
+	 */
+	for (i = 0; i < ZL3073X_NUM_INPUT_PINS; i++) {
+		struct zl3073x_dpll_pin *pin;
+		enum dpll_pin_state state;
+
+		/* Input pins starts are stored after output pins */
+		pin = &zldpll->pins[ZL3073X_NUM_OUTPUT_PINS + i];
+
+		/* Skip non-registered pins */
+		if (!pin->dpll_pin)
+			continue;
+
+		rc = zl3073x_dpll_input_pin_state_on_dpll_get(pin->dpll_pin,
+							      pin,
+							      zldpll->dpll_dev,
+							      zldpll, &state,
+							      NULL);
+		if (rc)
+			goto out;
+
+		if (state != pin->pin_state) {
+			dev_dbg(zldev->dev,
+				"INPUT%u state changed to %u\n",
+				zl3073x_dpll_pin_index_get(pin), state);
+			pin->pin_state = state;
+			dpll_pin_change_ntf(pin->dpll_pin);
+		}
+	}
+
+out:
+	/* Run twice a second */
+	kthread_queue_delayed_work(zldpll->kworker, &zldpll->work,
+				   msecs_to_jiffies(500));
+}
+
+static int
+zl3073x_dpll_init_worker(struct zl3073x_dpll *zldpll)
+{
+	struct kthread_worker *kworker;
+
+	kthread_init_delayed_work(&zldpll->work, zl3073x_dpll_periodic_work);
+	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldpll->dev));
+	if (IS_ERR(kworker))
+		return PTR_ERR(kworker);
+
+	zldpll->kworker = kworker;
+	kthread_queue_delayed_work(zldpll->kworker, &zldpll->work, 0);
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	int rc;
+
+	guard(zl3073x)(zldpll->mfd);
+
+	rc = zl3073x_write_synth_phase_shift_mask(zldev, 0x1f);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_synth_phase_shift_intvl(zldev, 0x01);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_synth_phase_shift_data(zldev, 0xffff);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_synth_phase_shift_ctrl(zldev, 0x01);
+	if (rc)
+		return rc;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_probe(struct platform_device *pdev)
+{
+	struct zl3073x_dpll *zldpll;
+	int rc;
+
+	zldpll = devm_kzalloc(&pdev->dev, sizeof(*zldpll), GFP_KERNEL);
+	if (!zldpll)
+		return -ENOMEM;
+
+	zldpll->dev = &pdev->dev;
+	zldpll->mfd = dev_get_drvdata(pdev->dev.parent);
+	zldpll->id = pdev->mfd_cell->id;
+
+	rc = zl3073x_dpll_init(zldpll);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_dpll_init_worker(zldpll);
+	if (rc)
+		goto err_init_worker;
+
+	platform_set_drvdata(pdev, zldpll);
+
+	/* Initial firmware fine phase correction */
+	rc = zl3073x_dpll_init_fine_phase_adjust(zldpll);
+	if (rc)
+		goto err_init_phase_adjust;
+
+	return rc;
+
+err_init_phase_adjust:
+	kthread_cancel_delayed_work_sync(&zldpll->work);
+	kthread_destroy_worker(zldpll->kworker);
+err_init_worker:
+	zl3073x_dpll_unregister_pins(zldpll);
+	zl3073x_dpll_unregister(zldpll);
+
+	return rc;
+}
+
+static void
+zl3073x_dpll_remove(struct platform_device *pdev)
+{
+	struct zl3073x_dpll *zldpll = platform_get_drvdata(pdev);
+
+	/* Stop worker */
+	kthread_cancel_delayed_work_sync(&zldpll->work);
+	kthread_destroy_worker(zldpll->kworker);
+
+	/* Unregister all pins and dpll */
+	zl3073x_dpll_unregister_pins(zldpll);
+	zl3073x_dpll_unregister(zldpll);
+}
+
+static const struct platform_device_id zl3073x_dpll_platform_id[] = {
+	{ "zl3073x-dpll", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, zl3073x_dpll_platform_id);
+
+static struct platform_driver zl3073x_dpll_driver = {
+	.driver = {
+		.name = "zl3073x-dpll",
+	},
+	.probe = zl3073x_dpll_probe,
+	.remove	= zl3073x_dpll_remove,
+	.id_table = zl3073x_dpll_platform_id,
+};
+
+module_platform_driver(zl3073x_dpll_driver);
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_AUTHOR("Tariq Haddad <tariq.haddad@microchip.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x DPLL driver");
+MODULE_IMPORT_NS("ZL3073X");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 825e6706dc974..3eaa5d96ca9af 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -9,9 +9,14 @@
 /*
  * Hardware limits for ZL3073x chip family
  */
+#define ZL3073X_NUM_CHANNELS	2
 #define ZL3073X_NUM_INPUTS	10
 #define ZL3073X_NUM_OUTPUTS	10
 #define ZL3073X_NUM_SYNTHS	5
+#define ZL3073X_NUM_INPUT_PINS	ZL3073X_NUM_INPUTS
+#define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTPUTS * 2)
+#define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
+				 ZL3073X_NUM_OUTPUT_PINS)
 
 struct zl3073x_input {
 	bool	enabled;
-- 
2.48.1


