Return-Path: <netdev+bounces-175724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD2A67439
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CE517E876
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD26198823;
	Tue, 18 Mar 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NH7rE2dP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607728EC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302042; cv=none; b=LbBt7nwhEwa/0JlEK+8r1aFyDm2GXCsDE9tna3E665KbBVchCGrSML2NJrF4taFsYdGd33gMq2fhAD1Xzjk+PuC9uqbtBWep09t5nFIXflwd6RlqfDUlAm/SneqiY5r5iZ8tJjuDQF2YWObGz+8xv97YOEbnz7rVcrz8QOUge8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302042; c=relaxed/simple;
	bh=EXnh73r4aqfGbNWK0QIueEZEqHq1iTUarCqzK5IY3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfEmqQDWnSZe7e7ej6vJf8lUj0quULK60kfLP8pW30MXneyF+yX8lA5pIHJtN/UXVxNPC4PabDwi5QffrDcH6QbWoVQr3PO/2Qy/4QdkSSqPgWvrsQMY/wMXHKV6jaFGBQ5YIZE3gDJDQaif85sfiLjS5azMOcCXb25nBghAt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NH7rE2dP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso3186233f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742302035; x=1742906835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm4iQb/oEt3EwvO0aEaH1El616vybjJw+88aRnelW5g=;
        b=NH7rE2dPX2/WYWKKO+1Yz1/JZ8SVKBdn5Lzscz79ctlSp/iWkQvxuY9CMY5v2nLiCq
         BrItKakZQRQMQ2fJAsz9DYMKd9kL56JwcBOuhujn+DSxMbZQr5GwZK1ftRp6rcBlkTiL
         THyhy4btvp3427ZX/TRgAuUVUm3rJ+Sy4ZpfptgQBZ3Sry8rz15x0c0++xhawRlno+UT
         VWt1Qr8EVl6/mILaTLNg4h1yBQKOch3tDIn/jHzyM756EHLwZCe2nWS3sjSp9FwBVLQ2
         OoaUbiPXIq9ozaiLrShaCcrMIRRwnZN/gopmGFRM6OYGD537pwHcu0qI6sv4DlUXJPY8
         tSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742302035; x=1742906835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm4iQb/oEt3EwvO0aEaH1El616vybjJw+88aRnelW5g=;
        b=rZWXNGjZMMOItrvK+B48AcRP7D+auzws9y0yVfXNW3O3dKTL1NmPlPfyHgK7NO/5vz
         qETc61m9MJeoZuISvn/2oXuSAZ26zwepBGKGsHlKCYc4Wvky8QKo89pNU757f+bnQv/q
         5EM7WExdBixeQq1aILag2lYxi3VjIhHrNPqBsRoadlJ9Vj22MDMR6la0/dFjDCyNdfSA
         feCzRLZgRWy/iYdEicFLWhtXwHqK1m/24uCaMWLz2Fx2cJjzrG2wQe5wwtr25Wx2BOsf
         MCUEM91aixh+gC4ulYeCNxmaSQ7sF3bfd3q0u4ZX/v6rhlIEZA3iUy0tH8oqy5/dJozR
         Veng==
X-Gm-Message-State: AOJu0YyaVpSfsyY9Vjz1dUxoU8bo242naFPGej2QrKt9NR+AGy51d9gE
	4oOHiQcQsWkhJ/KOFS7FCIHo1aMzCC4qSJCd1xpGEP4vkoeNGPZ3k9XPIYrRmsydeTauYuIX+Ry
	M
X-Gm-Gg: ASbGncuW5fdhzlEBUPR06769hcgv0NLzDrJ3/6LRpAgLc1bO5a/zKpDUaA7ug7LSVnX
	gGV+ICCOeFrux+mjx3clRRYhENl/Ft/dId0xXxWPsJ8mOnb3yayyDDEXnlL/4qs8L49fyNqT45v
	DSjrl1LbLkPoUX/6oXIyFnZuWvKikejbJ0uvfKO1byKya3k/a/p7j1sUcz9KKrKwpcazjENeYGe
	Ye2ecFahzllLKasOSph+ypdgO0XbjA3ToWVCFqZyg2TvFuv+FLaJprYPyvljkeNRORebcXHivxb
	LVjRgZdAgMfxL4NJE24mdk/1zrOPzsqQaJLLfw==
X-Google-Smtp-Source: AGHT+IFNH8eTdRw7JOzfGBleCAjxUMCChiFAVPRnALIDonyGnFYxS+e9OzwYCcfY/3O9DIjybnv/Zw==
X-Received: by 2002:a5d:47cf:0:b0:391:2e31:c7e8 with SMTP id ffacd0b85a97d-3971d1362e8mr20574202f8f.2.1742302034665;
        Tue, 18 Mar 2025 05:47:14 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e87sm18617477f8f.32.2025.03.18.05.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:47:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	dakr@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	cratiu@nvidia.com,
	jacob.e.keller@intel.com,
	konrad.knitter@intel.com,
	cjubran@nvidia.com
Subject: [PATCH net-next RFC 1/3] faux: extend the creation function for module namespace
Date: Tue, 18 Mar 2025 13:47:04 +0100
Message-ID: <20250318124706.94156-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318124706.94156-1-jiri@resnulli.us>
References: <20250318124706.94156-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

It is hard for the faux user to avoid potential name conflicts, as it is
only in control of faux devices it creates. Therefore extend the faux
device creation function by module parameter, embed the module name into
the device name in format "modulename_permodulename" and allow module to
control it's namespace.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/base/faux.c         | 20 ++++++++++++--------
 include/linux/device/faux.h |  6 ++++--
 include/linux/module.h      |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 531e9d789ee0..b1fcac6b0946 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -85,8 +85,9 @@ static void faux_device_release(struct device *dev)
  * faux_device_create_with_groups - Create and register with the driver
  *		core a faux device and populate the device with an initial
  *		set of sysfs attributes.
- * @name:	The name of the device we are adding, must be unique for
- *		all faux devices.
+ * @module:	Pointer to module this device is associated.
+ * @name:	The name of the device we are adding, must be unique for all
+ *		faux devices within a single module.
  * @parent:	Pointer to a potential parent struct device.  If set to
  *		NULL, the device will be created in the "root" of the faux
  *		device tree in sysfs.
@@ -108,7 +109,8 @@ static void faux_device_release(struct device *dev)
  * * NULL if an error happened with creating the device
  * * pointer to a valid struct faux_device that is registered with sysfs
  */
-struct faux_device *faux_device_create_with_groups(const char *name,
+struct faux_device *faux_device_create_with_groups(const struct module *module,
+						   const char *name,
 						   struct device *parent,
 						   const struct faux_device_ops *faux_ops,
 						   const struct attribute_group **groups)
@@ -137,12 +139,12 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 		dev->parent = &faux_bus_root;
 	dev->bus = &faux_bus_type;
 	dev->groups = groups;
-	dev_set_name(dev, "%s", name);
+	dev_set_name(dev, "%s_%s", module_name(module), name);
 
 	ret = device_add(dev);
 	if (ret) {
 		pr_err("%s: device_add for faux device '%s' failed with %d\n",
-		       __func__, name, ret);
+		       __func__, dev_name(dev), ret);
 		put_device(dev);
 		return NULL;
 	}
@@ -153,8 +155,9 @@ EXPORT_SYMBOL_GPL(faux_device_create_with_groups);
 
 /**
  * faux_device_create - create and register with the driver core a faux device
+ * @module:	Pointer to module this device is associated.
  * @name:	The name of the device we are adding, must be unique for all
- *		faux devices.
+ *		faux devices within a single module.
  * @parent:	Pointer to a potential parent struct device.  If set to
  *		NULL, the device will be created in the "root" of the faux
  *		device tree in sysfs.
@@ -174,11 +177,12 @@ EXPORT_SYMBOL_GPL(faux_device_create_with_groups);
  * * NULL if an error happened with creating the device
  * * pointer to a valid struct faux_device that is registered with sysfs
  */
-struct faux_device *faux_device_create(const char *name,
+struct faux_device *faux_device_create(const struct module *module,
+				       const char *name,
 				       struct device *parent,
 				       const struct faux_device_ops *faux_ops)
 {
-	return faux_device_create_with_groups(name, parent, faux_ops, NULL);
+	return faux_device_create_with_groups(module, name, parent, faux_ops, NULL);
 }
 EXPORT_SYMBOL_GPL(faux_device_create);
 
diff --git a/include/linux/device/faux.h b/include/linux/device/faux.h
index 9f43c0e46aa4..b1393a34b4f9 100644
--- a/include/linux/device/faux.h
+++ b/include/linux/device/faux.h
@@ -47,10 +47,12 @@ struct faux_device_ops {
 	void (*remove)(struct faux_device *faux_dev);
 };
 
-struct faux_device *faux_device_create(const char *name,
+struct faux_device *faux_device_create(const struct module *module,
+				       const char *name,
 				       struct device *parent,
 				       const struct faux_device_ops *faux_ops);
-struct faux_device *faux_device_create_with_groups(const char *name,
+struct faux_device *faux_device_create_with_groups(const struct module *module,
+						   const char *name,
 						   struct device *parent,
 						   const struct faux_device_ops *faux_ops,
 						   const struct attribute_group **groups);
diff --git a/include/linux/module.h b/include/linux/module.h
index 30e5b19bafa9..8d1a7e65d2e4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -744,7 +744,7 @@ static inline void __module_get(struct module *module)
 /* This is a #define so the string doesn't get put in every .o file */
 #define module_name(mod)			\
 ({						\
-	struct module *__mod = (mod);		\
+	const struct module *__mod = (mod);	\
 	__mod ? __mod->name : "kernel";		\
 })
 
-- 
2.48.1


