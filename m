Return-Path: <netdev+bounces-269590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI5FLMI3vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:52:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99D2D050C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F4583076AD7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF503F7870;
	Thu, 19 Mar 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvuLZEBe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6D3F1640
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942547; cv=none; b=iThSwcwtgOMslHcK6lQgiHSO+kLEd+k3OHIDuVHxajzMGwaVYLnV5L/xYPdBS5uPmnqtW6vgdizTmsk8cNMp5E1pNvRfE+hSMm3aBefbXmP+C1D5kA19gsBee1PPZeUJcNAQyd/1Ha5rEk2Fi9N1xZjGFkU599G/pD+wU7J8Vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942547; c=relaxed/simple;
	bh=xh+2LQGpgXn9Xt225Qej1/MFk8bn5fEUjWLLYQsx3tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HivkgHYaDhB83fqg3ohbHBFFVbLEfD3425VxkKUi5t614Sy7eJvjnPYt3yGhjTdhzZn3/SLd0tKeT9reURHttFtmXzfyH/iwfWuzxMegZBRBVQk5W+adYTORRAZGdYipUfuU5aGH0V4aFt+TwAe443N9QrXVj6gZxeNHllnfwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvuLZEBe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773942540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMQyWSvgloNE5CY207ljWxM5riVSYFQJOR2L8Dy2uco=;
	b=BvuLZEBeRgZbczfmMcf/ZUoyRP4RmcBNMXn9ObXdoAoZnMuz1uyIfgEd9/hXakefaj+Ezr
	ZAcV8Eo55Y6gVaYKL5qTehJtIzHbrbCp2Nb9KPp+3qSN5Ux/DPo8naKqvAFjZi9fuzLZkk
	54vTy1FBlAWrWOewb/Ihg1nR4TJJCxk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-kK9_vKDyNIOlTvjKsl5Qlw-1; Thu,
 19 Mar 2026 13:48:56 -0400
X-MC-Unique: kK9_vKDyNIOlTvjKsl5Qlw-1
X-Mimecast-MFC-AGG-ID: kK9_vKDyNIOlTvjKsl5Qlw_1773942534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25F1918002F0;
	Thu, 19 Mar 2026 17:48:54 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E459B30002DF;
	Thu, 19 Mar 2026 17:48:49 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 5/5] dpll: zl3073x: add ref-sync pair support
Date: Thu, 19 Mar 2026 18:48:26 +0100
Message-ID: <20260319174826.7623-6-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-1-ivecera@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269590-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.917];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C99D2D050C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for ref-sync pair registration using the 'ref-sync-sources'
phandle property from device tree. A ref-sync pair consists of a clock
reference and a low-frequency sync signal where the DPLL locks to the
clock reference but phase-aligns to the sync reference.

The implementation:
- Stores fwnode handle in zl3073x_dpll_pin during pin registration
- Adds ref_sync_get/set callbacks to read and write the sync control
  mode and pair registers
- Validates ref-sync frequency constraints: sync signal must be 8 kHz
  or less, clock reference must be 1 kHz or more and higher than sync
- Excludes sync source from automatic reference selection by setting
  its priority to NONE on connect; on disconnect the priority is left
  as NONE and the user must explicitly make the pin selectable again
- Iterates ref-sync-sources phandles to register declared pairings
  via dpll_pin_ref_sync_pair_add()

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 207 +++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 276f0a92db0b1..8010e2635f641 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/netlink.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 
@@ -30,6 +31,7 @@
  * @dpll: DPLL the pin is registered to
  * @dpll_pin: pointer to registered dpll_pin
  * @tracker: tracking object for the acquired reference
+ * @fwnode: firmware node handle
  * @label: package label
  * @dir: pin direction
  * @id: pin id
@@ -45,6 +47,7 @@ struct zl3073x_dpll_pin {
 	struct zl3073x_dpll	*dpll;
 	struct dpll_pin		*dpll_pin;
 	dpll_tracker		tracker;
+	struct fwnode_handle	*fwnode;
 	char			label[8];
 	enum dpll_pin_direction	dir;
 	u8			id;
@@ -184,6 +187,109 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	return zl3073x_ref_state_set(zldev, ref_id, &ref);
 }
 
+static int
+zl3073x_dpll_input_pin_ref_sync_get(const struct dpll_pin *dpll_pin,
+				    void *pin_priv,
+				    const struct dpll_pin *ref_sync_pin,
+				    void *ref_sync_pin_priv,
+				    enum dpll_pin_state *state,
+				    struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *sync_pin = ref_sync_pin_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_ref *ref;
+	u8 ref_id, mode, pair;
+
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = zl3073x_ref_state_get(zldev, ref_id);
+	mode = zl3073x_ref_sync_mode_get(ref);
+	pair = zl3073x_ref_sync_pair_get(ref);
+
+	if (mode == ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR &&
+	    pair == zl3073x_input_pin_ref_get(sync_pin->id))
+		*state = DPLL_PIN_STATE_CONNECTED;
+	else
+		*state = DPLL_PIN_STATE_DISCONNECTED;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
+				    void *pin_priv,
+				    const struct dpll_pin *ref_sync_pin,
+				    void *ref_sync_pin_priv,
+				    const enum dpll_pin_state state,
+				    struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *sync_pin = ref_sync_pin_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 mode, ref_id, sync_ref_id;
+	struct zl3073x_chan chan;
+	struct zl3073x_ref ref;
+	int rc;
+
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	sync_ref_id = zl3073x_input_pin_ref_get(sync_pin->id);
+	ref = *zl3073x_ref_state_get(zldev, ref_id);
+
+	if (state == DPLL_PIN_STATE_CONNECTED) {
+		const struct zl3073x_ref *sync_ref;
+		u32 ref_freq, sync_freq;
+
+		sync_ref = zl3073x_ref_state_get(zldev, sync_ref_id);
+		ref_freq = zl3073x_ref_freq_get(&ref);
+		sync_freq = zl3073x_ref_freq_get(sync_ref);
+
+		/* Sync signal must be 8 kHz or less and clock reference
+		 * must be 1 kHz or more and higher than the sync signal.
+		 */
+		if (sync_freq > 8000) {
+			NL_SET_ERR_MSG(extack,
+				       "sync frequency must be 8 kHz or less");
+			return -EINVAL;
+		}
+		if (ref_freq < 1000) {
+			NL_SET_ERR_MSG(extack,
+				       "clock frequency must be 1 kHz or more");
+			return -EINVAL;
+		}
+		if (ref_freq <= sync_freq) {
+			NL_SET_ERR_MSG(extack,
+				       "clock frequency must be higher than sync frequency");
+			return -EINVAL;
+		}
+
+		zl3073x_ref_sync_pair_set(&ref, sync_ref_id);
+		mode = ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR;
+	} else {
+		mode = ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF;
+	}
+
+	zl3073x_ref_sync_mode_set(&ref, mode);
+
+	rc = zl3073x_ref_state_set(zldev, ref_id, &ref);
+	if (rc)
+		return rc;
+
+	/* Exclude sync source from automatic reference selection by setting
+	 * its priority to NONE. On disconnect the priority is left as NONE
+	 * and the user must explicitly make the pin selectable again.
+	 */
+	if (state == DPLL_PIN_STATE_CONNECTED) {
+		chan = *zl3073x_chan_state_get(zldev, zldpll->id);
+		zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
+					  ZL_DPLL_REF_PRIO_NONE);
+		return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
+	}
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 			       const struct dpll_device *dpll, void *dpll_priv,
@@ -1100,6 +1206,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
+	.ref_sync_get = zl3073x_dpll_input_pin_ref_sync_get,
+	.ref_sync_set = zl3073x_dpll_input_pin_ref_sync_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
 	.state_on_dpll_set = zl3073x_dpll_input_pin_state_on_dpll_set,
 };
@@ -1190,8 +1298,11 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	if (IS_ERR(props))
 		return PTR_ERR(props);
 
-	/* Save package label, esync capability and phase adjust granularity */
+	/* Save package label, fwnode, esync capability and phase adjust
+	 * granularity.
+	 */
 	strscpy(pin->label, props->package_label);
+	pin->fwnode = fwnode_handle_get(props->fwnode);
 	pin->esync_control = props->esync_control;
 	pin->phase_gran = props->dpll_props.phase_gran;
 
@@ -1236,6 +1347,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 	pin->dpll_pin = NULL;
 err_pin_get:
+	fwnode_handle_put(pin->fwnode);
+	pin->fwnode = NULL;
 	zl3073x_pin_props_put(props);
 
 	return rc;
@@ -1265,6 +1378,9 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
 
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 	pin->dpll_pin = NULL;
+
+	fwnode_handle_put(pin->fwnode);
+	pin->fwnode = NULL;
 }
 
 /**
@@ -1735,6 +1851,88 @@ zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
 	kfree(zldpll);
 }
 
+/**
+ * zl3073x_dpll_ref_sync_pair_register - register ref_sync pairs for a pin
+ * @pin: pointer to zl3073x_dpll_pin structure
+ *
+ * Iterates 'ref-sync-sources' phandles in the pin's firmware node and
+ * registers each declared pairing.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_sync_pair_register(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dev *zldev = pin->dpll->dev;
+	struct fwnode_handle *fwnode;
+	struct dpll_pin *sync_pin;
+	dpll_tracker tracker;
+	int n, rc;
+
+	for (n = 0; ; n++) {
+		/* Get n'th ref-sync source */
+		fwnode = fwnode_find_reference(pin->fwnode, "ref-sync-sources",
+					       n);
+		if (IS_ERR(fwnode)) {
+			rc = PTR_ERR(fwnode);
+			break;
+		}
+
+		/* Find associated dpll pin */
+		sync_pin = fwnode_dpll_pin_find(fwnode, &tracker);
+		fwnode_handle_put(fwnode);
+		if (!sync_pin) {
+			dev_warn(zldev->dev, "%s: ref-sync source %d not found",
+				 pin->label, n);
+			continue;
+		}
+
+		/* Register new ref-sync pair */
+		rc = dpll_pin_ref_sync_pair_add(pin->dpll_pin, sync_pin);
+		dpll_pin_put(sync_pin, &tracker);
+
+		/* -EBUSY means pairing already exists from another DPLL's
+		 * registration.
+		 */
+		if (rc && rc != -EBUSY) {
+			dev_err(zldev->dev,
+				"%s: failed to add ref-sync source %d: %pe",
+				pin->label, n, ERR_PTR(rc));
+			break;
+		}
+	}
+
+	return rc != -ENOENT ? rc : 0;
+}
+
+/**
+ * zl3073x_dpll_ref_sync_pairs_register - register ref_sync pairs for a DPLL
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Iterates all registered input pins of the given DPLL and establishes
+ * ref_sync pairings declared by 'ref-sync-sources' phandles in the
+ * device tree.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dpll_pin *pin;
+	int rc;
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		if (!zl3073x_dpll_is_input_pin(pin) || !pin->fwnode)
+			continue;
+
+		rc = zl3073x_dpll_ref_sync_pair_register(pin);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 /**
  * zl3073x_dpll_register - register DPLL device and all its pins
  * @zldpll: pointer to zl3073x_dpll structure
@@ -1758,6 +1956,13 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 		return rc;
 	}
 
+	rc = zl3073x_dpll_ref_sync_pairs_register(zldpll);
+	if (rc) {
+		zl3073x_dpll_pins_unregister(zldpll);
+		zl3073x_dpll_device_unregister(zldpll);
+		return rc;
+	}
+
 	return 0;
 }
 
-- 
2.52.0


