Return-Path: <netdev+bounces-198229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685DADBAD3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29673B7519
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13C28DB76;
	Mon, 16 Jun 2025 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJn81z94"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92AE28B7C8
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104936; cv=none; b=uaeeFXQLQvditsNfoWq/OU1bdRgqbSXhlM2g/EfmBXWV49hxZYYZBrxybLyRfH0BKoeK9OcC5qbuEiPStxlQcDDEo2fagvN6AZgHJQ0vS6MNnQjH3r9WvO/r+kJN3eUiej5F0WnkGKKkzSlUQraLck/YdHd0eiEu+9x8scLqRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104936; c=relaxed/simple;
	bh=d1q/HA9Pr5ZKcepknO7dXUZ4YXuc5K07/Z4NO8cX60k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYOxAPHyUJANct55T6B+hPWDBcNA0n2TEKH3ecXDmVZ0AuvxZ8/VY4wcXnQJVDZfCKZLvfbEbavyqCKAIrstNNpvnZC7wn/DHaSl4+TYGmw/1DnXG7nk9BKcPcxPQe2u0lp63i4OAUOci7dyDjWD5LyohynAqPNtbQuiS/kKnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJn81z94; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750104933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PC33ycQpyMMM+DSnzjKCYZzW6We8j70qodfbGCwwodk=;
	b=cJn81z9449ofYg7BlxUUjuPRjLXSZ+GvOee/wbBVFPcTMEvQvtEgIJ69CCbJciaNsMXIQb
	U9vmFNDQqVy4MLR1KC6SWXuFjDl4iRJ1Y2CKHUoFaiYdGqB/JsZCFr+lmc7u3roPCFXk2p
	hqMgLvd8w2bOD+l/twmEb33lhSi50GQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-tnvad7ByNSiYLHM2zzS99g-1; Mon,
 16 Jun 2025 16:15:29 -0400
X-MC-Unique: tnvad7ByNSiYLHM2zzS99g-1
X-Mimecast-MFC-AGG-ID: tnvad7ByNSiYLHM2zzS99g_1750104926
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0CEA1800296;
	Mon, 16 Jun 2025 20:15:26 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52F9B30001B1;
	Mon, 16 Jun 2025 20:15:20 +0000 (UTC)
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
Subject: [PATCH net-next v11 10/14] dpll: zl3073x: Implement input pin selection in manual mode
Date: Mon, 16 Jun 2025 22:14:00 +0200
Message-ID: <20250616201404.1412341-11-ivecera@redhat.com>
In-Reply-To: <20250616201404.1412341-1-ivecera@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement input pin state setting if the DPLL is running in manual mode.
The driver indicates manual mode if the DPLL mode is one of ref-lock,
forced-holdover, freerun.

Use these modes to implement input pin state change between connected
and disconnected states. When the user set the particular pin as
connected the driver marks this input pin as forced reference and
switches the DPLL mode to ref-lock. When the use set the pin as
disconnected the driver switches the DPLL to freerun or forced holdover
mode. The switch to holdover mode is done if the DPLL has holdover
capability (e.g is currently locked with holdover acquired).

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 118 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/prop.c |   9 ++-
 2 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 56ca5c8dd9155..89da2c34609eb 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -132,6 +132,81 @@ zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_selected_ref_set - select reference in manual mode
+ * @zldpll: pointer to zl3073x_dpll
+ * @ref: input reference to be selected
+ *
+ * Selects the given reference for the DPLL channel it should be
+ * locked to.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_selected_ref_set(struct zl3073x_dpll *zldpll, u8 ref)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 mode, mode_refsel;
+	int rc;
+
+	mode = zldpll->refsel_mode;
+
+	switch (mode) {
+	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
+		/* Manual mode with ref selected */
+		if (ref == ZL3073X_DPLL_REF_NONE) {
+			switch (zldpll->lock_status) {
+			case DPLL_LOCK_STATUS_LOCKED_HO_ACQ:
+			case DPLL_LOCK_STATUS_HOLDOVER:
+				/* Switch to forced holdover */
+				mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
+				break;
+			default:
+				/* Switch to freerun */
+				mode = ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
+				break;
+			}
+			/* Keep selected reference */
+			ref = zldpll->forced_ref;
+		} else if (ref == zldpll->forced_ref) {
+			/* No register update - same mode and same ref */
+			return 0;
+		}
+		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
+	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
+		/* Manual mode without no ref */
+		if (ref == ZL3073X_DPLL_REF_NONE)
+			/* No register update - keep current mode */
+			return 0;
+
+		/* Switch to reflock mode and update ref selection */
+		mode = ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
+		break;
+	default:
+		/* For other modes like automatic or NCO ref cannot be selected
+		 * manually
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	/* Build mode_refsel value */
+	mode_refsel = FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, mode) |
+		      FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+
+	/* Update dpll_mode_refsel register */
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
+			      mode_refsel);
+	if (rc)
+		return rc;
+
+	/* Store new mode and forced reference */
+	zldpll->refsel_mode = mode;
+	zldpll->forced_ref = ref;
+
+	return rc;
+}
+
 /**
  * zl3073x_dpll_connected_ref_get - get currently connected reference
  * @zldpll: pointer to zl3073x_dpll
@@ -283,6 +358,48 @@ zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	return zl3073x_dpll_ref_state_get(pin, state);
 }
 
+static int
+zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 enum dpll_pin_state state,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 new_ref;
+	int rc;
+
+	switch (zldpll->refsel_mode) {
+	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
+	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
+	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
+		if (state == DPLL_PIN_STATE_CONNECTED) {
+			/* Choose the pin as new selected reference */
+			new_ref = zl3073x_input_pin_ref_get(pin->id);
+		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* No reference */
+			new_ref = ZL3073X_DPLL_REF_NONE;
+		} else {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Invalid pin state for manual mode");
+			return -EINVAL;
+		}
+
+		rc = zl3073x_dpll_selected_ref_set(zldpll, new_ref);
+		break;
+	default:
+		/* In other modes we cannot change input reference */
+		NL_SET_ERR_MSG(extack,
+			       "Pin state cannot be changed in current mode");
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -358,6 +475,7 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
+	.state_on_dpll_set = zl3073x_dpll_input_pin_state_on_dpll_set,
 };
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index bc8b78cfb5ae0..c3224e78cbf01 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -201,11 +201,14 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 	if (!props)
 		return ERR_PTR(-ENOMEM);
 
-	/* Set default pin type */
-	if (dir == DPLL_PIN_DIRECTION_INPUT)
+	/* Set default pin type and capabilities */
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
 		props->dpll_props.type = DPLL_PIN_TYPE_EXT;
-	else
+		props->dpll_props.capabilities =
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	} else {
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+	}
 
 	props->dpll_props.phase_range.min = S32_MIN;
 	props->dpll_props.phase_range.max = S32_MAX;
-- 
2.49.0


