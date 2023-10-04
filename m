Return-Path: <netdev+bounces-37866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E577B76CE
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 05:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD4CD281D24
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389515CA;
	Wed,  4 Oct 2023 03:13:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E55EC6;
	Wed,  4 Oct 2023 03:13:29 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D6DB0;
	Tue,  3 Oct 2023 20:13:26 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 2CCC5202F9; Wed,  4 Oct 2023 11:13:25 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1696389205;
	bh=GV10my1RxpWCjWq/vQWHQIa/D77u1vCTBLLPWlRoMhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nGZB6c3drz6kS+W2cRgXKxhbMXTvSJsihXQlSXpRlCso+qPcT/vs/3s2BxammULQR
	 1UoMn6ipLiOV1H9dIWqAQcpc/a0A4BSEu7pWfENVBtgIG/83fz57L9U4AYe2Aq+LRB
	 F9ECAMWaVjpvRZqD9j92UXiE0rlk9oVszM5colmf3+tFF5WFQl0oqQBg0ks+baVTab
	 vJNW0pinYcYoJcMS8fxjwhM2vTg+CnqGqhAVZpQz++IqlFXbD/Ux2VKOh5Zp2YzpRs
	 W1L0xZIj7mv5gl9rh7mgzRU+EoHRyZlGeow7uT3LaNJYXw/wfEgYAYpqsf3fIhX0C7
	 tdg/yvQPtRo4Q==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH net-next v4 2/3] i3c: Add support for bus enumeration & notification
Date: Wed,  4 Oct 2023 11:13:15 +0800
Message-Id: <20231004031316.725107-3-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004031316.725107-1-matt@codeconstruct.com.au>
References: <20231004031316.725107-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeremy Kerr <jk@codeconstruct.com.au>

This allows other drivers to be notified when new i3c busses are
attached, referring to a whole i3c bus as opposed to individual
devices.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i3c/master.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h | 11 +++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 87283e4a4607..959ec5269376 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -22,6 +22,7 @@
 static DEFINE_IDR(i3c_bus_idr);
 static DEFINE_MUTEX(i3c_core_lock);
 static int __i3c_first_dynamic_bus_num;
+static BLOCKING_NOTIFIER_HEAD(i3c_bus_notifier);
 
 /**
  * i3c_bus_maintenance_lock - Lock the bus for a maintenance operation
@@ -453,6 +454,36 @@ static int i3c_bus_init(struct i3c_bus *i3cbus, struct device_node *np)
 	return 0;
 }
 
+void i3c_for_each_bus_locked(int (*fn)(struct i3c_bus *bus, void *data),
+			     void *data)
+{
+	struct i3c_bus *bus;
+	int id;
+
+	mutex_lock(&i3c_core_lock);
+	idr_for_each_entry(&i3c_bus_idr, bus, id)
+		fn(bus, data);
+	mutex_unlock(&i3c_core_lock);
+}
+EXPORT_SYMBOL_GPL(i3c_for_each_bus_locked);
+
+int i3c_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&i3c_bus_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(i3c_register_notifier);
+
+int i3c_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&i3c_bus_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(i3c_unregister_notifier);
+
+static void i3c_bus_notify(struct i3c_bus *bus, unsigned int action)
+{
+	blocking_notifier_call_chain(&i3c_bus_notifier, action, bus);
+}
+
 static const char * const i3c_bus_mode_strings[] = {
 	[I3C_BUS_MODE_PURE] = "pure",
 	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
@@ -2682,6 +2713,8 @@ int i3c_master_register(struct i3c_master_controller *master,
 	if (ret)
 		goto err_del_dev;
 
+	i3c_bus_notify(i3cbus, I3C_NOTIFY_BUS_ADD);
+
 	/*
 	 * We're done initializing the bus and the controller, we can now
 	 * register I3C devices discovered during the initial DAA.
@@ -2714,6 +2747,8 @@ EXPORT_SYMBOL_GPL(i3c_master_register);
  */
 void i3c_master_unregister(struct i3c_master_controller *master)
 {
+	i3c_bus_notify(&master->bus, I3C_NOTIFY_BUS_REMOVE);
+
 	i3c_master_i2c_adapter_cleanup(master);
 	i3c_master_unregister_i3c_devs(master);
 	i3c_master_bus_cleanup(master);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 0b52da4f2346..db909ef79be4 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -24,6 +24,12 @@
 
 struct i2c_client;
 
+/* notifier actions. notifier call data is the struct i3c_bus */
+enum {
+	I3C_NOTIFY_BUS_ADD,
+	I3C_NOTIFY_BUS_REMOVE,
+};
+
 struct i3c_master_controller;
 struct i3c_bus;
 struct i3c_device;
@@ -652,4 +658,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
 
 struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
 
+void i3c_for_each_bus_locked(int (*fn)(struct i3c_bus *bus, void *data),
+			     void *data);
+int i3c_register_notifier(struct notifier_block *nb);
+int i3c_unregister_notifier(struct notifier_block *nb);
+
 #endif /* I3C_MASTER_H */
-- 
2.39.2


