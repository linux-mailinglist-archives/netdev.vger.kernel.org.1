Return-Path: <netdev+bounces-198563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A1ADCAD1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA443BCDB9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878F2EAD08;
	Tue, 17 Jun 2025 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b4twS8Lg"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787902DBF7E;
	Tue, 17 Jun 2025 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162349; cv=none; b=UsBQIGstGZ/BtuKsAY6OAXc1ZgrLGL81VOZB3w4+gKBtfxvWMq18VJN8WB5KSa0lscTdpCi0qmAW+f0Lq+38IBfMAIemQc4JAXIkfBzTCsVv+YHaMglYK6o9qlrVXwyMPx2qBTNe8dccGcTMl02ApJum0V0YQdYXriAlRSAfE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162349; c=relaxed/simple;
	bh=vzXuKOSsKRAavZBVX6WY+7mR2H+F/LPeSEAWOTu/4WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2GFauqb2QpPAzPLgL81K8JawfBq1CQ5YOirILc1CJo8ljKIoCpxJz4nRf4KKnOw716EzDPv1jJyyMWR48ktmLYF5m3RxcuGPutpEUEL89Vu0/nG/oHEkxwmWadMlJIeSfRFtvJexCZQ0Cg1nipQu5osW0vsfhNki31tMxqyZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b4twS8Lg; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0306B439F1;
	Tue, 17 Jun 2025 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750162339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJp1L2JMIyWyFRAe2oZ8qYnyDYgNSLUvQHYZYkpxQrI=;
	b=b4twS8Lg9WMaleUPPhJfaPhKmuXtRjTqpQ2skfjNgyFa6q3dUs3Jkx5KzsBA3FyK8NEA1l
	5Z/iSeM8ULpzAV05X/no7lW7sEE60rKhf+TL3zyWjtL88LmM2Zw4Lbb4LlML+VZ9q0mIED
	MoHRKLNMd5kW46HsU9AddjUg6Y3HP0NIBHmLAJQLHjddcKuN6fBuTtGo18koGmaHCod/hJ
	IIn7Bwgi4g0mgT65IOJpWxSRPPNT6p8CCb6dnt+vnUIYOL9wBNMtoWh5aje25mFBDyoz4t
	Kpr+YVSDE9TWXAc20zjQ1BLDY0SRVKPINZcgBFdhwMUuqND2vO94Cu63IQK41g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Jun 2025 14:12:03 +0200
Subject: [PATCH net-next v14 04/13] net: pse-pd: Add support for PSE power
 domains
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-feature_poe_port_prio-v14-4-78a1a645e2ee@bootlin.com>
References: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
In-Reply-To: <20250617-feature_poe_port_prio-v14-0-78a1a645e2ee@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce PSE power domain support as groundwork for upcoming port
priority features. Multiple PSE PIs can now be grouped under a single
PSE power domain, enabling future enhancements like defining available
power budgets, port priority modes, and disconnection policies. This
setup will allow the system to assess whether activating a port would
exceed the available power budget, preventing over-budget states
proactively.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v14:
- Forgot to release the pse_pw_d_mutex in __pse_pw_d_release.

Changes in v8:
- Add missing kref_init and an wrong error check condition.

Changes in v7:
- Add reference count and mutex lock for PSE power domain in case of PSE
  from different controllers want to register the same PSE power domain.

Changes in v6:
- nitpick change.

Changes in v4:
- Add kdoc.
- Fix null dereference in pse_flush_pw_ds function.

Changes in v3:
- Remove pw_budget variable.

Changes in v2:
- new patch.
---
 drivers/net/pse-pd/pse_core.c | 140 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    |   2 +
 2 files changed, 142 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 16cc1dc07246..f2fb7ccbc4c2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -16,8 +16,12 @@
 #include <linux/rtnetlink.h>
 #include <net/net_trackers.h>
 
+#define PSE_PW_D_LIMIT INT_MAX
+
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
+static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
+static DEFINE_MUTEX(pse_pw_d_mutex);
 
 /**
  * struct pse_control - a PSE control
@@ -38,6 +42,18 @@ struct pse_control {
 	struct phy_device *attached_phydev;
 };
 
+/**
+ * struct pse_power_domain - a PSE power domain
+ * @id: ID of the power domain
+ * @supply: Power supply the Power Domain
+ * @refcnt: Number of gets of this pse_power_domain
+ */
+struct pse_power_domain {
+	int id;
+	struct regulator *supply;
+	struct kref refcnt;
+};
+
 static int of_load_single_pse_pi_pairset(struct device_node *node,
 					 struct pse_pi *pi,
 					 int pairset_num)
@@ -485,6 +501,125 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	return 0;
 }
 
+static void __pse_pw_d_release(struct kref *kref)
+{
+	struct pse_power_domain *pw_d = container_of(kref,
+						     struct pse_power_domain,
+						     refcnt);
+
+	regulator_put(pw_d->supply);
+	xa_erase(&pse_pw_d_map, pw_d->id);
+	mutex_unlock(&pse_pw_d_mutex);
+}
+
+/**
+ * pse_flush_pw_ds - flush all PSE power domains of a PSE
+ * @pcdev: a pointer to the initialized PSE controller device
+ */
+static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
+{
+	struct pse_power_domain *pw_d;
+	int i;
+
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		if (!pcdev->pi[i].pw_d)
+			continue;
+
+		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
+		if (!pw_d)
+			continue;
+
+		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
+			       &pse_pw_d_mutex);
+	}
+}
+
+/**
+ * devm_pse_alloc_pw_d - allocate a new PSE power domain for a device
+ * @dev: device that is registering this PSE power domain
+ *
+ * Return: Pointer to the newly allocated PSE power domain or error pointers
+ */
+static struct pse_power_domain *devm_pse_alloc_pw_d(struct device *dev)
+{
+	struct pse_power_domain *pw_d;
+	int index, ret;
+
+	pw_d = devm_kzalloc(dev, sizeof(*pw_d), GFP_KERNEL);
+	if (!pw_d)
+		return ERR_PTR(-ENOMEM);
+
+	ret = xa_alloc(&pse_pw_d_map, &index, pw_d, XA_LIMIT(1, PSE_PW_D_LIMIT),
+		       GFP_KERNEL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	kref_init(&pw_d->refcnt);
+	pw_d->id = index;
+	return pw_d;
+}
+
+/**
+ * pse_register_pw_ds - register the PSE power domains for a PSE
+ * @pcdev: a pointer to the PSE controller device
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
+{
+	int i, ret = 0;
+
+	mutex_lock(&pse_pw_d_mutex);
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		struct regulator_dev *rdev = pcdev->pi[i].rdev;
+		struct pse_power_domain *pw_d;
+		struct regulator *supply;
+		bool present = false;
+		unsigned long index;
+
+		/* No regulator or regulator parent supply registered.
+		 * We need a regulator parent to register a PSE power domain
+		 */
+		if (!rdev || !rdev->supply)
+			continue;
+
+		xa_for_each(&pse_pw_d_map, index, pw_d) {
+			/* Power supply already registered as a PSE power
+			 * domain.
+			 */
+			if (regulator_is_equal(pw_d->supply, rdev->supply)) {
+				present = true;
+				pcdev->pi[i].pw_d = pw_d;
+				break;
+			}
+		}
+		if (present) {
+			kref_get(&pw_d->refcnt);
+			continue;
+		}
+
+		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
+		if (IS_ERR(pw_d)) {
+			ret = PTR_ERR(pw_d);
+			goto out;
+		}
+
+		supply = regulator_get(&rdev->dev, rdev->supply_name);
+		if (IS_ERR(supply)) {
+			xa_erase(&pse_pw_d_map, pw_d->id);
+			ret = PTR_ERR(supply);
+			goto out;
+		}
+
+		pw_d->supply = supply;
+		pcdev->pi[i].pw_d = pw_d;
+	}
+
+out:
+	mutex_unlock(&pse_pw_d_mutex);
+	return ret;
+}
+
 /**
  * pse_controller_register - register a PSE controller device
  * @pcdev: a pointer to the initialized PSE controller device
@@ -544,6 +679,10 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			return ret;
 	}
 
+	ret = pse_register_pw_ds(pcdev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
@@ -558,6 +697,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 6eb064722aa8..f736b1677ea5 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -222,12 +222,14 @@ struct pse_pi_pairset {
  * @np: device node pointer of the PSE PI node
  * @rdev: regulator represented by the PSE PI
  * @admin_state_enabled: PI enabled state
+ * @pw_d: Power domain of the PSE PI
  */
 struct pse_pi {
 	struct pse_pi_pairset pairset[2];
 	struct device_node *np;
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
+	struct pse_power_domain *pw_d;
 };
 
 /**

-- 
2.43.0


