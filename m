Return-Path: <netdev+bounces-197903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBAADA367
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 22:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF6B167AC1
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62846284690;
	Sun, 15 Jun 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkHsOjcm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26227FB21
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750018434; cv=none; b=Ntq4gvClxwGk9TjlJpIv3CZxaiJs79DNTtF+TJ1K0n65+plGErpKQVl64uXPenkNJtwZ0ONrzJBG4pn5uItJ5ddzGcrEAVuFuaLhgh4ko6D0tOwi7IQzcwSzw2/g9wx7sMCikzKXb6eQcHxMlAgCNaIZriXFAsLvC00B329jJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750018434; c=relaxed/simple;
	bh=uKUUJXncYmKa1DV/YXbxZ+K+/KL/wUbHzyiPrrg9eAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCgktUBFBxQjTMMn6wmlYzHRd5zg+q1fSrZB+ML4OVEqI+YzSdfS6uhECLkJZvx5mTTSUvXCfTudFJbXRWSRR6+MwGcnBvkrlPVd4KwJgvWd92qj+sy2Br47fSgn+TiBQFnkujZhG56bIWKXFcEqtk2bgcaOkpWm4nei/xMjkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkHsOjcm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750018431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3H4mw6MbwkMyOzHHvslvOX+nZRjucBH43FQyAawdfM=;
	b=fkHsOjcmgIbKZDONAqD3yFva8728+FPVtXZdoNwnKeLaoZYI9Sn84WmCPXJlPuwdrOGWqi
	dj+wB/c2Ga0lTFNMP3GemhVR94LRH9rBqPhbLv1ZX7Lx+KiUCo2g0/3WzxDKraSCbw4d7F
	ZFxiD0G8eZBDm9Jw2DsppbQ2h0/zqZ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-sgZ0FWHBPXqnD2bx3cy9RA-1; Sun,
 15 Jun 2025 16:13:48 -0400
X-MC-Unique: sgZ0FWHBPXqnD2bx3cy9RA-1
X-Mimecast-MFC-AGG-ID: sgZ0FWHBPXqnD2bx3cy9RA_1750018426
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA8C1956094;
	Sun, 15 Jun 2025 20:13:45 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0D04180045C;
	Sun, 15 Jun 2025 20:13:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
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
Subject: [PATCH net-next v10 08/14] dpll: zl3073x: Read DPLL types and pin properties from system firmware
Date: Sun, 15 Jun 2025 22:12:17 +0200
Message-ID: <20250615201223.1209235-9-ivecera@redhat.com>
In-Reply-To: <20250615201223.1209235-1-ivecera@redhat.com>
References: <20250615201223.1209235-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add support for reading of DPLL types and optional pin properties from
the system firmware (DT, ACPI...).

The DPLL types are stored in property 'dpll-types' as string array and
possible values 'pps' and 'eec' are mapped to DPLL enums DPLL_TYPE_PPS
and DPLL_TYPE_EEC.

The pin properties are stored under 'input-pins' and 'output-pins'
sub-nodes and the following ones are supported:

* reg
    integer that specifies pin index
* label
    string that is used by driver as board label
* connection-type
    string that indicates pin connection type
* supported-frequencies-hz
    array of u64 values what frequencies are supported / allowed for
    given pin with respect to hardware wiring

Do not blindly trust system firmware and filter out frequencies that
cannot be configured/represented in device (input frequencies have to
be factorized by one of the base frequencies and output frequencies have
to divide configured synthesizer frequency).

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Makefile |   2 +-
 drivers/dpll/zl3073x/core.c   |  41 ++++
 drivers/dpll/zl3073x/core.h   |   7 +
 drivers/dpll/zl3073x/prop.c   | 354 ++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/prop.h   |  34 ++++
 5 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dpll/zl3073x/prop.c
 create mode 100644 drivers/dpll/zl3073x/prop.h

diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
index 8760f358f5447..56d7d9feeaf0d 100644
--- a/drivers/dpll/zl3073x/Makefile
+++ b/drivers/dpll/zl3073x/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ZL3073X)		+= zl3073x.o
-zl3073x-objs			:= core.o
+zl3073x-objs			:= core.o prop.o
 
 obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
 zl3073x_i2c-objs		:= i2c.o
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index ab578c729ac40..3fd7257221338 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -121,6 +121,47 @@ const struct regmap_config zl3073x_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(zl3073x_regmap_config, "ZL3073X");
 
+/**
+ * zl3073x_ref_freq_factorize - factorize given frequency
+ * @freq: input frequency
+ * @base: base frequency
+ * @mult: multiplier
+ *
+ * Checks if the given frequency can be factorized using one of the
+ * supported base frequencies. If so the base frequency and multiplier
+ * are stored into appropriate parameters if they are not NULL.
+ *
+ * Return: 0 on success, -EINVAL if the frequency cannot be factorized
+ */
+int
+zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult)
+{
+	static const u16 base_freqs[] = {
+		1, 2, 4, 5, 8, 10, 16, 20, 25, 32, 40, 50, 64, 80, 100, 125,
+		128, 160, 200, 250, 256, 320, 400, 500, 625, 640, 800, 1000,
+		1250, 1280, 1600, 2000, 2500, 3125, 3200, 4000, 5000, 6250,
+		6400, 8000, 10000, 12500, 15625, 16000, 20000, 25000, 31250,
+		32000, 40000, 50000, 62500,
+	};
+	u32 div;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(base_freqs); i++) {
+		div = freq / base_freqs[i];
+
+		if (div <= U16_MAX && (freq % base_freqs[i]) == 0) {
+			if (base)
+				*base = base_freqs[i];
+			if (mult)
+				*mult = div;
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static bool
 zl3073x_check_reg(struct zl3073x_dev *zldev, unsigned int reg, size_t size)
 {
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index fcf142f3f8cb6..4fcce761fc5f2 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -14,6 +14,7 @@ struct regmap;
 /*
  * Hardware limits for ZL3073x chip family
  */
+#define ZL3073X_MAX_CHANNELS	5
 #define ZL3073X_NUM_REFS	10
 #define ZL3073X_NUM_OUTS	10
 #define ZL3073X_NUM_SYNTHS	5
@@ -111,6 +112,12 @@ int zl3073x_write_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 val);
 int zl3073x_write_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 val);
 int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val);
 
+/*****************
+ * Misc operations
+ *****************/
+
+int zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult);
+
 static inline bool
 zl3073x_is_n_pin(u8 id)
 {
diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
new file mode 100644
index 0000000000000..bc8b78cfb5ae0
--- /dev/null
+++ b/drivers/dpll/zl3073x/prop.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fwnode.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "core.h"
+#include "prop.h"
+
+/**
+ * zl3073x_pin_check_freq - verify frequency for given pin
+ * @zldev: pointer to zl3073x device
+ * @dir: pin direction
+ * @id: pin index
+ * @freq: frequency to check
+ *
+ * The function checks the given frequency is valid for the device. For input
+ * pins it checks that the frequency can be factorized using supported base
+ * frequencies. For output pins it checks that the frequency divides connected
+ * synth frequency without remainder.
+ *
+ * Return: true if the frequency is valid, false if not.
+ */
+static bool
+zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
+		       u8 id, u64 freq)
+{
+	if (freq > U32_MAX)
+		goto err_inv_freq;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
+		int rc;
+
+		/* Check if the frequency can be factorized */
+		rc = zl3073x_ref_freq_factorize(freq, NULL, NULL);
+		if (rc)
+			goto err_inv_freq;
+	} else {
+		u32 synth_freq;
+		u8 out, synth;
+
+		/* Get output pin synthesizer */
+		out = zl3073x_output_pin_out_get(id);
+		synth = zl3073x_out_synth_get(zldev, out);
+
+		/* Get synth frequency */
+		synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+		/* Check the frequency divides synth frequency */
+		if (synth_freq % (u32)freq)
+			goto err_inv_freq;
+	}
+
+	return true;
+
+err_inv_freq:
+	dev_warn(zldev->dev,
+		 "Unsupported frequency %llu Hz in firmware node\n", freq);
+
+	return false;
+}
+
+/**
+ * zl3073x_prop_pin_package_label_set - get package label for the pin
+ * @zldev: pointer to zl3073x device
+ * @props: pointer to pin properties
+ * @dir: pin direction
+ * @id: pin index
+ *
+ * Generates package label string and stores it into pin properties structure.
+ *
+ * Possible formats:
+ * REF<n> - differential input reference
+ * REF<n>P & REF<n>N - single-ended input reference (P or N pin)
+ * OUT<n> - differential output
+ * OUT<n>P & OUT<n>N - single-ended output (P or N pin)
+ */
+static void
+zl3073x_prop_pin_package_label_set(struct zl3073x_dev *zldev,
+				   struct zl3073x_pin_props *props,
+				   enum dpll_pin_direction dir, u8 id)
+{
+	const char *prefix, *suffix;
+	bool is_diff;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
+		u8 ref;
+
+		prefix = "REF";
+		ref = zl3073x_input_pin_ref_get(id);
+		is_diff = zl3073x_ref_is_diff(zldev, ref);
+	} else {
+		u8 out;
+
+		prefix = "OUT";
+		out = zl3073x_output_pin_out_get(id);
+		is_diff = zl3073x_out_is_diff(zldev, out);
+	}
+
+	if (!is_diff)
+		suffix = zl3073x_is_p_pin(id) ? "P" : "N";
+	else
+		suffix = ""; /* No suffix for differential one */
+
+	snprintf(props->package_label, sizeof(props->package_label), "%s%u%s",
+		 prefix, id / 2, suffix);
+
+	/* Set package_label pointer in DPLL core properties to generated
+	 * string.
+	 */
+	props->dpll_props.package_label = props->package_label;
+}
+
+/**
+ * zl3073x_prop_pin_fwnode_get - get fwnode for given pin
+ * @zldev: pointer to zl3073x device
+ * @props: pointer to pin properties
+ * @dir: pin direction
+ * @id: pin index
+ *
+ * Return: 0 on success, -ENOENT if the firmware node does not exist
+ */
+static int
+zl3073x_prop_pin_fwnode_get(struct zl3073x_dev *zldev,
+			    struct zl3073x_pin_props *props,
+			    enum dpll_pin_direction dir, u8 id)
+{
+	struct fwnode_handle *pins_node, *pin_node;
+	const char *node_name;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT)
+		node_name = "input-pins";
+	else
+		node_name = "output-pins";
+
+	/* Get node containing input or output pins */
+	pins_node = device_get_named_child_node(zldev->dev, node_name);
+	if (!pins_node) {
+		dev_dbg(zldev->dev, "'%s' sub-node is missing\n", node_name);
+		return -ENOENT;
+	}
+
+	/* Enumerate child pin nodes and find the requested one */
+	fwnode_for_each_child_node(pins_node, pin_node) {
+		u32 reg;
+
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))
+			continue;
+
+		if (id == reg)
+			break;
+	}
+
+	/* Release pin parent node */
+	fwnode_handle_put(pins_node);
+
+	/* Save found node */
+	props->fwnode = pin_node;
+
+	dev_dbg(zldev->dev, "Firmware node for %s %sfound\n",
+		props->package_label, pin_node ? "" : "NOT ");
+
+	return pin_node ? 0 : -ENOENT;
+}
+
+/**
+ * zl3073x_pin_props_get - get pin properties
+ * @zldev: pointer to zl3073x device
+ * @dir: pin direction
+ * @index: pin index
+ *
+ * The function looks for firmware node for the given pin if it is provided
+ * by the system firmware (DT or ACPI), allocates pin properties structure,
+ * generates package label string according pin type and optionally fetches
+ * board label, connection type, supported frequencies and esync capability
+ * from the firmware node if it does exist.
+ *
+ * Pointer that is returned by this function should be freed using
+ * @zl3073x_pin_props_put().
+ *
+ * Return:
+ * * pointer to allocated pin properties structure on success
+ * * error pointer in case of error
+ */
+struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
+						enum dpll_pin_direction dir,
+						u8 index)
+{
+	struct dpll_pin_frequency *ranges;
+	struct zl3073x_pin_props *props;
+	int i, j, num_freqs, rc;
+	const char *type;
+	u64 *freqs;
+
+	props = kzalloc(sizeof(*props), GFP_KERNEL);
+	if (!props)
+		return ERR_PTR(-ENOMEM);
+
+	/* Set default pin type */
+	if (dir == DPLL_PIN_DIRECTION_INPUT)
+		props->dpll_props.type = DPLL_PIN_TYPE_EXT;
+	else
+		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+
+	props->dpll_props.phase_range.min = S32_MIN;
+	props->dpll_props.phase_range.max = S32_MAX;
+
+	zl3073x_prop_pin_package_label_set(zldev, props, dir, index);
+
+	/* Get firmware node for the given pin */
+	rc = zl3073x_prop_pin_fwnode_get(zldev, props, dir, index);
+	if (rc)
+		return props; /* Return if it does not exist */
+
+	/* Look for label property and store the value as board label */
+	fwnode_property_read_string(props->fwnode, "label",
+				    &props->dpll_props.board_label);
+
+	/* Look for pin type property and translate its value to DPLL
+	 * pin type enum if it is present.
+	 */
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",
+					 &type)) {
+		if (!strcmp(type, "ext"))
+			props->dpll_props.type = DPLL_PIN_TYPE_EXT;
+		else if (!strcmp(type, "gnss"))
+			props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+		else if (!strcmp(type, "int"))
+			props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
+		else if (!strcmp(type, "synce"))
+			props->dpll_props.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+		else
+			dev_warn(zldev->dev,
+				 "Unknown or unsupported pin type '%s'\n",
+				 type);
+	}
+
+	/* Check if the pin supports embedded sync control */
+	props->esync_control = fwnode_property_read_bool(props->fwnode,
+							 "esync-control");
+
+	/* Read supported frequencies property if it is specified */
+	num_freqs = fwnode_property_count_u64(props->fwnode,
+					      "supported-frequencies-hz");
+	if (num_freqs <= 0)
+		/* Return if the property does not exist or number is 0 */
+		return props;
+
+	/* The firmware node specifies list of supported frequencies while
+	 * DPLL core pin properties requires list of frequency ranges.
+	 * So read the frequency list into temporary array.
+	 */
+	freqs = kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);
+	if (!freqs) {
+		rc = -ENOMEM;
+		goto err_alloc_freqs;
+	}
+
+	/* Read frequencies list from firmware node */
+	fwnode_property_read_u64_array(props->fwnode,
+				       "supported-frequencies-hz", freqs,
+				       num_freqs);
+
+	/* Allocate frequency ranges list and fill it */
+	ranges = kcalloc(num_freqs, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges) {
+		rc = -ENOMEM;
+		goto err_alloc_ranges;
+	}
+
+	/* Convert list of frequencies to list of frequency ranges but
+	 * filter-out frequencies that are not representable by device
+	 */
+	for (i = 0, j = 0; i < num_freqs; i++) {
+		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(freqs[i]);
+
+		if (zl3073x_pin_check_freq(zldev, dir, index, freqs[i])) {
+			ranges[j] = freq;
+			j++;
+		}
+	}
+
+	/* Save number of freq ranges and pointer to them into pin properties */
+	props->dpll_props.freq_supported = ranges;
+	props->dpll_props.freq_supported_num = j;
+
+	/* Free temporary array */
+	kfree(freqs);
+
+	return props;
+
+err_alloc_ranges:
+	kfree(freqs);
+err_alloc_freqs:
+	fwnode_handle_put(props->fwnode);
+	kfree(props);
+
+	return ERR_PTR(rc);
+}
+
+/**
+ * zl3073x_pin_props_put - release pin properties
+ * @props: pin properties to free
+ *
+ * The function deallocates given pin properties structure.
+ */
+void zl3073x_pin_props_put(struct zl3073x_pin_props *props)
+{
+	/* Free supported frequency ranges list if it is present */
+	kfree(props->dpll_props.freq_supported);
+
+	/* Put firmware handle if it is present */
+	if (props->fwnode)
+		fwnode_handle_put(props->fwnode);
+
+	kfree(props);
+}
+
+/**
+ * zl3073x_prop_dpll_type_get - get DPLL channel type
+ * @zldev: pointer to zl3073x device
+ * @index: DPLL channel index
+ *
+ * Return: DPLL type for given DPLL channel
+ */
+enum dpll_type
+zl3073x_prop_dpll_type_get(struct zl3073x_dev *zldev, u8 index)
+{
+	const char *types[ZL3073X_MAX_CHANNELS];
+	int count;
+
+	/* Read dpll types property from firmware */
+	count = device_property_read_string_array(zldev->dev, "dpll-types",
+						  types, ARRAY_SIZE(types));
+
+	/* Return default if property or entry for given channel is missing */
+	if (index >= count)
+		return DPLL_TYPE_PPS;
+
+	if (!strcmp(types[index], "pps"))
+		return DPLL_TYPE_PPS;
+	else if (!strcmp(types[index], "eec"))
+		return DPLL_TYPE_EEC;
+
+	dev_info(zldev->dev, "Unknown DPLL type '%s', using default\n",
+		 types[index]);
+
+	return DPLL_TYPE_PPS; /* Default */
+}
diff --git a/drivers/dpll/zl3073x/prop.h b/drivers/dpll/zl3073x/prop.h
new file mode 100644
index 0000000000000..721a18f05938b
--- /dev/null
+++ b/drivers/dpll/zl3073x/prop.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_PROP_H
+#define _ZL3073X_PROP_H
+
+#include <linux/dpll.h>
+
+#include "core.h"
+
+struct fwnode_handle;
+
+/**
+ * struct zl3073x_pin_props - pin properties
+ * @fwnode: pin firmware node
+ * @dpll_props: DPLL core pin properties
+ * @package_label: pin package label
+ * @esync_control: embedded sync support
+ */
+struct zl3073x_pin_props {
+	struct fwnode_handle		*fwnode;
+	struct dpll_pin_properties	dpll_props;
+	char				package_label[8];
+	bool				esync_control;
+};
+
+enum dpll_type zl3073x_prop_dpll_type_get(struct zl3073x_dev *zldev, u8 index);
+
+struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
+						enum dpll_pin_direction dir,
+						u8 index);
+
+void zl3073x_pin_props_put(struct zl3073x_pin_props *props);
+
+#endif /* _ZL3073X_PROP_H */
-- 
2.49.0


