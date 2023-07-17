Return-Path: <netdev+bounces-18175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10B755A7D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 06:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B041F1C209C4
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA534C9B;
	Mon, 17 Jul 2023 04:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C163D2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:07:13 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBD120;
	Sun, 16 Jul 2023 21:07:11 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id B2E2D20185; Mon, 17 Jul 2023 12:07:09 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1689566829;
	bh=HIkJLJvmNtOZ/mtGHf116N5mjdINkQwdK/9Zj+8T5HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eGlUR1QFCOjN/uBcilzCdQKa65hgu9AfZh4C646iVXEA9gGoMKUwFnySevzqxE1dk
	 7Y3/UxijOLayo/u+3hweoJqpJnbdXKmtu5UoSIGr4x9wcIoSCST1CZSgTGJEMHXcVn
	 gVYijfOusMT/GpNhY5zw1GUt6cN0te4nfxTDKjajkdXYbWykHj6667Vh6exodZkOuB
	 YLeCL7fZWHa8HecrEyAdOcyglwYO2mphxEtIkRKcLYtnd1i2NUeRjLlUDVd1LFWY7e
	 z29JAPwtZJzfYMzj6UzX8cMvQ9+C1ckfTdefIh0O51q46z2qSLJUInJ2eAOBLxgCAx
	 AEpUQ6hJGjAeQ==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH net-next v2 2/3] i3c: Add support for bus enumeration & notification
Date: Mon, 17 Jul 2023 12:06:37 +0800
Message-Id: <20230717040638.1292536-3-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230717040638.1292536-1-matt@codeconstruct.com.au>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeremy Kerr <jk@codeconstruct.com.au>

This allows other drivers to be notified when new i3c busses are
attached, referring to a whole i3c bus as opposed to individual
devices.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 drivers/i3c/master.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h | 11 +++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a7800..2276abe38bdc 100644
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
@@ -2678,6 +2709,8 @@ int i3c_master_register(struct i3c_master_controller *master,
 	if (ret)
 		goto err_del_dev;
 
+	i3c_bus_notify(i3cbus, I3C_NOTIFY_BUS_ADD);
+
 	/*
 	 * We're done initializing the bus and the controller, we can now
 	 * register I3C devices discovered during the initial DAA.
@@ -2710,6 +2743,8 @@ EXPORT_SYMBOL_GPL(i3c_master_register);
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
2.37.2


