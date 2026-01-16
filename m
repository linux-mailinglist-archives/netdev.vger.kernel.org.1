Return-Path: <netdev+bounces-250605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89829D384AA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61B1F300B354
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512DE34D385;
	Fri, 16 Jan 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNIMMksr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353E399038
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589242; cv=none; b=cHmQbvzETfF7xe29xSDZ52Bhk0KX/KQrYotWyAynV1nLRH6iHGykc/RMKILvLgWGUgsigCub1XUOOwdTiAa2Fr2z4I7ChWJdqjY1eZY8I2ekxaFQ6X4AUvdjugTW5jQSQVqk7WAf1i70sdvnzQqF/Qvia/uZ63P5DalRDI+mXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589242; c=relaxed/simple;
	bh=YVyaI/YMlUw9XmpZ91BEtdqShHv8DolEetJ39/9Q2dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqdiVs7w+u3k1DV+JvV00qV0bKKBYyUFGUE6qizSsFvC4vNyZMdOwjFQ3+F4vqg8AH8d3bn9ozyyuOx3DkGihgGevJLR+t0bh6OD10+vR6ZK4jaxwV0vy2NopZrk19D+LoLF1hmLzTLV+1QNmx2BXdJujq3+I/n5WezIElDDaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNIMMksr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768589237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA7Q+gdheqeABjG5QsrM8GPEaUvmJYMzWuJ9Dn+RtAg=;
	b=VNIMMksr+ol2LSCwvmrBw8Hq4ZfhLyViCr1eyVJm5tar/38YliSNUEaJvE4ASaesv3UaBZ
	PQYEBCHpaiJ5EliiaXz3QvR87Buapp5vpUtpZeOmD206rdiIKqOSeg6KfrwBSTkc0h/NfE
	l8jD+fo8mta2sX3gaL+nqCGxqqPuX68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-bR3FcElcOmO2cTebQgIWjA-1; Fri,
 16 Jan 2026 13:47:13 -0500
X-MC-Unique: bR3FcElcOmO2cTebQgIWjA-1
X-Mimecast-MFC-AGG-ID: bR3FcElcOmO2cTebQgIWjA_1768589230
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBABD180045C;
	Fri, 16 Jan 2026 18:47:09 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32E3B19560A7;
	Fri, 16 Jan 2026 18:47:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	devicetree@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 06/12] dpll: Support dynamic pin index allocation
Date: Fri, 16 Jan 2026 19:46:04 +0100
Message-ID: <20260116184610.147591-7-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-1-ivecera@redhat.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Allow drivers to register DPLL pins without manually specifying a pin
index.

Currently, drivers must provide a unique pin index when calling
dpll_pin_get(). This works well for hardware-mapped pins but creates
friction for drivers handling virtual pins or those without a strict
hardware indexing scheme.

Introduce DPLL_PIN_IDX_UNSPEC (U32_MAX). When a driver passes this
value as the pin index:
1. The core allocates a unique index using an IDA
2. The allocated index is mapped to a range starting above `INT_MAX`

This separation ensures that dynamically allocated indices never collide
with standard driver-provided hardware indices, which are assumed to be
within the `0` to `INT_MAX` range. The index is automatically freed when
the pin is released in dpll_pin_put().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* fixed integer overflow in dpll_pin_idx_free()
---
 drivers/dpll/dpll_core.c | 48 ++++++++++++++++++++++++++++++++++++++--
 include/linux/dpll.h     |  2 ++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index c0483716a9971..156f95de8e8e8 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/idr.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -25,6 +26,7 @@ DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
 
 static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
+static DEFINE_IDA(dpll_pin_idx_ida);
 
 static u32 dpll_device_xa_id;
 static u32 dpll_pin_xa_id;
@@ -469,6 +471,36 @@ void dpll_device_unregister(struct dpll_device *dpll,
 }
 EXPORT_SYMBOL_GPL(dpll_device_unregister);
 
+static int dpll_pin_idx_alloc(u32 *pin_idx)
+{
+	int ret;
+
+	if (!pin_idx)
+		return -EINVAL;
+
+	/* Alloc unique number from IDA. Number belongs to <0, INT_MAX> range */
+	ret = ida_alloc(&dpll_pin_idx_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	/* Map the value to dynamic pin index range <INT_MAX+1, U32_MAX> */
+	*pin_idx = (u32)ret + INT_MAX + 1;
+
+	return 0;
+}
+
+static void dpll_pin_idx_free(u32 pin_idx)
+{
+	if (pin_idx <= INT_MAX)
+		return; /* Not a dynamic pin index */
+
+	/* Map the index value from dynamic pin index range to IDA range and
+	 * free it.
+	 */
+	pin_idx -= (u32)INT_MAX + 1;
+	ida_free(&dpll_pin_idx_ida, pin_idx);
+}
+
 static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 {
 	kfree(prop->package_label);
@@ -526,9 +558,18 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	struct dpll_pin *pin;
 	int ret;
 
+	if (pin_idx == DPLL_PIN_IDX_UNSPEC) {
+		ret = dpll_pin_idx_alloc(&pin_idx);
+		if (ret)
+			return ERR_PTR(ret);
+	} else if (pin_idx > INT_MAX) {
+		return ERR_PTR(-EINVAL);
+	}
 	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
-	if (!pin)
-		return ERR_PTR(-ENOMEM);
+	if (!pin) {
+		ret = -ENOMEM;
+		goto err_pin_alloc;
+	}
 	pin->pin_idx = pin_idx;
 	pin->clock_id = clock_id;
 	pin->module = module;
@@ -556,6 +597,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	dpll_pin_prop_free(&pin->prop);
 err_pin_prop:
 	kfree(pin);
+err_pin_alloc:
+	dpll_pin_idx_free(pin_idx);
 	return ERR_PTR(ret);
 }
 
@@ -659,6 +702,7 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->ref_sync_pins);
 		dpll_pin_prop_free(&pin->prop);
 		fwnode_handle_put(pin->fwnode);
+		dpll_pin_idx_free(pin->pin_idx);
 		kfree_rcu(pin, rcu);
 	}
 	mutex_unlock(&dpll_lock);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 092abf400552b..65e86c687a6c4 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -250,6 +250,8 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 void dpll_device_unregister(struct dpll_device *dpll,
 			    const struct dpll_device_ops *ops, void *priv);
 
+#define DPLL_PIN_IDX_UNSPEC	U32_MAX
+
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
 	     const struct dpll_pin_properties *prop);
-- 
2.52.0


