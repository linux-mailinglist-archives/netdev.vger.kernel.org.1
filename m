Return-Path: <netdev+bounces-179800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333FA7E879
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5313E1899C09
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFE218ADE;
	Mon,  7 Apr 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNMK/f0o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CA218AC0
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047174; cv=none; b=Dpj2VPgWglv9QCGb8PP9lSUCz2sE1BPC8AMpEk8TNWOE+nFeqv2nah5MD076rLLLmm3dTz/Ot48D2e75mezXId6eOszGGsgRntbj37nAxjT/BccrafO82JyN3oojnAeubf9H7TOaCwfrPLhedJpYtJG5nbPQr8BPsHeQymC5psY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047174; c=relaxed/simple;
	bh=bjhEBABbFfyeL3ryhS1ZcBP1MBr6Yd+wbkegepdkE2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZTzJRgW3cOv2CEqpvfPOpSKI3Qlu3KOSPEE8s8awOKcoAcOGEzH+GLnTG6W2Q4NjL7uZgCbxAtGmd8/9segQxmpDs+w5F9vxwaeX6DMZvREbYrVJadReRvpXwC4SNuBlLPXpKuZS4psydWhsjxujZlEOEsAwDIE64u2uED4NNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNMK/f0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZh2K3E3QGemkZ831hKXCiq0LiByQJrgxf/Rwqw+Kco=;
	b=VNMK/f0oc/rfmePja67DX0ftKBsRXd5EbTNRvVYkDseMYJzkvid5dBF27BGAkcWxGvA19K
	tjtpKFIusPXb0TzcBTEhamQ0TdHlW2RkBNO8J+U9JCG9gj5RAAz9cqYZjmC/xr/4Wb0Dn+
	08g3OPzHoJjFfz7g5APqMAZtrzS9sAs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-8dXyNwatN2aaKvH06GtA5w-1; Mon,
 07 Apr 2025 13:32:49 -0400
X-MC-Unique: 8dXyNwatN2aaKvH06GtA5w-1
X-Mimecast-MFC-AGG-ID: 8dXyNwatN2aaKvH06GtA5w_1744047166
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE9171809CA5;
	Mon,  7 Apr 2025 17:32:46 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 430071955BC0;
	Mon,  7 Apr 2025 17:32:40 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 18/28] dpll: zl3073x: Read optional pin properties from firmware
Date: Mon,  7 Apr 2025 19:31:48 +0200
Message-ID: <20250407173149.1010216-9-ivecera@redhat.com>
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

The firmware (DT, ACPI...) can specify properties for particular
pins. Input pins are stored in 'input-pins' sub-node and output
pins in 'output-pins'. Each pin is represented by separate node
in 'input-pins' or 'output-pins'.

The properties that are supported:
* reg - integer that specifies pin index
* label - string that is used by driver as board label
* type - string that indicates pin type

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 102 ++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index 3ff53a333a6e9..cf2cdd6dec263 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -73,10 +73,12 @@ ZL3073X_REG8_IDX_DEF(dpll_ref_prio,		0x652,
  * struct zl3073x_dpll_pin_info - DPLL pin info
  * @props: DPLL core pin properties
  * @package_label: pin package label
+ * @fwnode: pin firmware node
  */
 struct zl3073x_dpll_pin_info {
 	struct dpll_pin_properties	props;
 	char				package_label[8];
+	struct fwnode_handle		*fwnode;
 };
 
 /**
@@ -482,6 +484,62 @@ static const struct dpll_device_ops zl3073x_dpll_device_ops = {
 	.mode_get = zl3073x_dpll_mode_get,
 };
 
+/**
+ * zl3073x_dpll_pin_fwnode_get - get fwnode for given pin
+ * pin: pointer to pin structure
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Returns the firmware node for the given pin if it is present or
+ * NULL if it is missing.
+ */
+static struct fwnode_handle *
+zl3073x_dpll_pin_fwnode_get(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	struct fwnode_handle *pins_node, *pin_node;
+	const char *node_name;
+	u8 idx;
+
+	if (zl3073x_dpll_is_input_pin(pin))
+		node_name = "input-pins";
+	else
+		node_name = "output-pins";
+
+	/* Get node containing input or output pins */
+	pins_node = device_get_named_child_node(zldpll->mfd->dev, node_name);
+	if (!pins_node) {
+		dev_dbg(zldpll->mfd->dev, "'%s' sub-node is missing\n",
+			node_name);
+		return NULL;
+	}
+
+	/* Get pin HW index */
+	idx = zl3073x_dpll_pin_index_get(pin);
+
+	/* Enumerate pin nodes and find the requested one */
+	fwnode_for_each_child_node(pins_node, pin_node) {
+		u32 reg;
+
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))
+			continue;
+
+		if (idx == reg)
+			break;
+	}
+
+	/* Release pin parent node */
+	fwnode_handle_put(pins_node);
+
+	dev_dbg(zldpll->mfd->dev, "Firmware node for %s%u%c %sfound\n",
+		zl3073x_dpll_is_input_pin(pin) ? "REF" : "OUT", idx / 2,
+		zl3073x_dpll_is_p_pin(pin) ? 'P' : 'N',
+		pin_node ? "" : "NOT ");
+
+	return pin_node;
+}
+
 /**
  * zl3073x_dpll_pin_info_package_label_set - generate package label for the pin
  * @pin: pointer to pin
@@ -548,8 +606,10 @@ zl3073x_dpll_pin_info_package_label_set(struct zl3073x_dpll_pin *pin,
  * zl3073x_dpll_pin_info_get - get pin info
  * @pin: pin whose info is returned
  *
- * The function allocates pin info structure, generates package label
- * string according pin type and its order number.
+ * The function looks for firmware node for the given pin if it is provided
+ * by the system firmware (DT or ACPI), allocates pin info structure,
+ * generates package label string according pin type and its order number
+ * and optionally fetches board label from the firmware node if it exists.
  *
  * Returns pointer to allocated pin info structure that has to be freed
  * by @zl3073x_dpll_pin_info_put by the caller and in case of error
@@ -558,14 +618,16 @@ zl3073x_dpll_pin_info_package_label_set(struct zl3073x_dpll_pin *pin,
 static struct zl3073x_dpll_pin_info *
 zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
 {
+	struct zl3073x_dev *zldev = pin_to_dev(pin);
 	struct zl3073x_dpll_pin_info *pin_info;
+	const char *pin_type;
 
 	/* Allocate pin info structure */
 	pin_info = kzalloc(sizeof(*pin_info), GFP_KERNEL);
 	if (!pin_info)
 		return ERR_PTR(-ENOMEM);
 
-	/* Set pin type */
+	/* Set default pin type */
 	if (zl3073x_dpll_is_input_pin(pin))
 		pin_info->props.type = DPLL_PIN_TYPE_EXT;
 	else
@@ -577,6 +639,34 @@ zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
 	/* Generate package label for the given pin */
 	zl3073x_dpll_pin_info_package_label_set(pin, pin_info);
 
+	/* Get firmware node for the given pin */
+	pin_info->fwnode = zl3073x_dpll_pin_fwnode_get(pin);
+	if (!pin_info->fwnode)
+		/* Return if it does not exist */
+		return pin_info;
+
+	/* Look for label property and store the value as board label */
+	fwnode_property_read_string(pin_info->fwnode, "label",
+				    &pin_info->props.board_label);
+
+	/* Look for pin type property and translate its value to DPLL
+	 * pin type enum if it is present.
+	 */
+	if (!fwnode_property_read_string(pin_info->fwnode, "type", &pin_type)) {
+		if (!strcmp(pin_type, "ext"))
+			pin_info->props.type = DPLL_PIN_TYPE_EXT;
+		else if (!strcmp(pin_type, "gnss"))
+			pin_info->props.type = DPLL_PIN_TYPE_GNSS;
+		else if (!strcmp(pin_type, "int"))
+			pin_info->props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
+		else if (!strcmp(pin_type, "synce"))
+			pin_info->props.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+		else
+			dev_warn(zldev->dev,
+				 "Unknown or unsupported pin type '%s'\n",
+				 pin_type);
+	}
+
 	return pin_info;
 }
 
@@ -584,11 +674,15 @@ zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
  * zl3073x_dpll_pin_info_put - free pin info
  * @pin_info: pin info to free
  *
- * The function deallocates given pin info structure.
+ * The function deallocates given pin info structure and firmware node handle.
  */
 static void
 zl3073x_dpll_pin_info_put(struct zl3073x_dpll_pin_info *pin_info)
 {
+	/* Put firmware handle if it is present */
+	if (pin_info->fwnode)
+		fwnode_handle_put(pin_info->fwnode);
+
 	/* Free the pin info structure itself */
 	kfree(pin_info);
 }
-- 
2.48.1


