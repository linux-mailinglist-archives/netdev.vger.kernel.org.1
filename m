Return-Path: <netdev+bounces-155088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9CCA00F87
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19A33A44EE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309F1FF1AD;
	Fri,  3 Jan 2025 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OY9P1QuQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E819DF99;
	Fri,  3 Jan 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938873; cv=none; b=LsML8QuWPF/TrCmiJtkllB9uxTpV+RGVojhvuMecQ+ERhIRVXOaNmIl3w5GD6zyDcl0rhp/R2P79BboDeG8fiijwTl5dxETQDV/8id2bzdDb6l0mIoq2/TWVC7Dz3qEWt4+B08gqCx321mm2qQN5HCcVU7i1rDukJHCQCIEj95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938873; c=relaxed/simple;
	bh=KqS8gXQhEsZxdRDuSi72NFVUt+V5uJ7HZJYYjs9sf+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXurlVC5mmSBJ1e2UFLIqGv+IoBi+dkqmxvKEjU3sUGE5pKfdI+OjeNltle3G3SV2zyMHjQy6adgrpMP3kXB1X6mPZP5q+7JbSSPdddcutRB/+hrTERwYHxME6r7Jw3ObpQDNgHepLsp3wQW9bA5jM66QeDYWjQpWJvneHa8smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OY9P1QuQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B26EFF802;
	Fri,  3 Jan 2025 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNkc36KYjfxv4uI022DUO0kIBrguKTjsuzjTt+5coJE=;
	b=OY9P1QuQKAct0vJiwhDuFhcSctvBn9jszbb+C4fFBc828VAtXxGuted4Qeso3tlC0zUn9a
	dRY8ZlhpDgekiRM2SE5GKcccqc3ld5O/v4hSMMdT56yVA1wmYVyeN9IBBnRlOywAZ0wZyD
	I+6GqQ93mSRcAlpi6KyeQcbc4lyyFhhTmjJ6GexR1sWNzzejjCjLACrMkxsLArQblyyn17
	p0How40rF8ajpemIgToMtbwODzKjUkok2P49VCYN/EEduLD8QF6Ad7s3pV+ASIaejARe4a
	yZQwZqCXq2CEWNNpPm+3n610XkaDFVHxYrRhgjY4dRpn1ZAXOF9zjnioCFyAdA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:09 +0100
Subject: [PATCH net-next v4 20/27] net: pse-pd: Add support for PSE power
 domains
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-20-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce PSE power domain support as groundwork for upcoming port
priority features. Multiple PSE PIs can now be grouped under a single
PSE power domain, enabling future enhancements like defining available
power budgets, port priority modes, and disconnection policies. This
setup will allow the system to assess whether activating a port would
exceed the available power budget, preventing over-budget states
proactively.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v4:
- Add kdoc.
- Fix null dereference in pse_flush_pw_ds function.

Changes in v3:
- Remove pw_budget variable.

Changes in v2:
- new patch.
---
 drivers/net/pse-pd/pse_core.c | 114 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    |   2 +
 2 files changed, 116 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 1da974fb83a2..6bfe0fca90b4 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -15,6 +15,7 @@
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
 static DEFINE_IDA(pse_ida);
+static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
 
 /**
  * struct pse_control - a PSE control
@@ -35,6 +36,16 @@ struct pse_control {
 	struct phy_device *attached_phydev;
 };
 
+/**
+ * struct pse_power_domain - a PSE power domain
+ * @id: ID of the power domain
+ * @supply: Power supply the Power Domain
+ */
+struct pse_power_domain {
+	int id;
+	struct regulator *supply;
+};
+
 static int of_load_single_pse_pi_pairset(struct device_node *node,
 					 struct pse_pi *pi,
 					 int pairset_num)
@@ -440,6 +451,103 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	return 0;
 }
 
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
+		if (pw_d) {
+			regulator_put(pw_d->supply);
+			xa_erase(&pse_pw_d_map, pw_d->id);
+		}
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
+	ret = xa_alloc(&pse_pw_d_map, &index, pw_d, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	if (ret)
+		return ERR_PTR(ret);
+
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
+	int i;
+
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
+		if (present)
+			continue;
+
+		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
+		if (IS_ERR_OR_NULL(pw_d))
+			return PTR_ERR(pw_d);
+
+		supply = regulator_get(&rdev->dev, rdev->supply_name);
+		if (IS_ERR(supply)) {
+			xa_erase(&pse_pw_d_map, pw_d->id);
+			return PTR_ERR(supply);
+		}
+
+		pw_d->supply = supply;
+		pcdev->pi[i].pw_d = pw_d;
+	}
+
+	return 0;
+}
+
 /**
  * pse_controller_register - register a PSE controller device
  * @pcdev: a pointer to the initialized PSE controller device
@@ -505,6 +613,11 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 			goto free_pse_ida;
 	}
 
+	ret = pse_register_pw_ds(pcdev);
+
+	if (ret)
+		goto free_pse_ida;
+
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
@@ -523,6 +636,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	ida_free(&pse_ida, pcdev->id);
 	mutex_lock(&pse_list_mutex);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index b3f8d198c5a7..54b88cce5cf5 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -164,12 +164,14 @@ struct pse_pi_pairset {
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
2.34.1


