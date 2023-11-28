Return-Path: <netdev+bounces-51913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF67FCAC3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D1B215B1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74F5C3E8;
	Tue, 28 Nov 2023 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T0IGbL69"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7319A6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oGw+N5kzs6PLCEZE3H4n3sljtFdD1UMjSl7f4IgIA/8=; b=T0IGbL69lxxhUVtGVeaOjDW8JT
	64ichi9qYsCZPG/aKpaBzqtQafWkx5OQ+MYjs56FnYvwTQ1qE92Ecvm34Cvc9QHLPLuXj3sCECdpG
	b0uTLjHgKQOssD/ElKHUrLvELi/WP8cd1WyW5EiB2u07RdAm3CpPJIPl3sp+1cGlqsuU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VJ4-Ks; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 4/8] dsa: Create port LEDs based on DT binding
Date: Wed, 29 Nov 2023 00:21:31 +0100
Message-Id: <20231128232135.358638-5-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow LEDs to be described in each ports DT subnode. Parse these when
setting up the ports, currently supporting brightness and link.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/dsa.h |   3 +
 net/dsa/dsa.c     | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index ae73765cd71c..2e05e4fd0b76 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -325,6 +325,9 @@ struct dsa_port {
 		 */
 		struct list_head	user_vlans;
 	};
+
+	/* List of LEDs associated to this port */
+	struct list_head leds;
 };
 
 /* TODO: ideally DSA ports would have a single dp->link_dp member,
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..b13748f9b519 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -34,6 +34,15 @@
 static DEFINE_MUTEX(dsa2_mutex);
 LIST_HEAD(dsa_tree_list);
 
+struct dsa_led {
+	struct list_head led_list;
+	struct dsa_port *dp;
+	struct led_classdev led_cdev;
+	u8 index;
+};
+
+#define to_dsa_led(d) container_of(d, struct dsa_led, led_cdev)
+
 static struct workqueue_struct *dsa_owq;
 
 /* Track the bridges with forwarding offload enabled */
@@ -461,6 +470,116 @@ static void dsa_tree_teardown_cpu_ports(struct dsa_switch_tree *dst)
 			dp->cpu_dp = NULL;
 }
 
+static int dsa_led_brightness_set(struct led_classdev *led_cdev,
+				  enum led_brightness value)
+{
+	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
+	struct dsa_port *dp = dsa_led->dp;
+	struct dsa_switch *ds = dp->ds;
+
+	return ds->ops->led_brightness_set(ds, dp->index, dsa_led->index,
+					   value);
+}
+
+static int dsa_led_blink_set(struct led_classdev *led_cdev,
+			     unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
+	struct dsa_port *dp = dsa_led->dp;
+	struct dsa_switch *ds = dp->ds;
+
+	return ds->ops->led_blink_set(ds, dp->index, dsa_led->index,
+				      delay_on, delay_off);
+}
+
+static int dsa_port_led_setup(struct dsa_port *dp,
+			      struct device_node *led)
+{
+	struct led_init_data init_data = {};
+	struct dsa_switch *ds = dp->ds;
+	struct led_classdev *cdev;
+	struct dsa_led *dsa_led;
+	u32 index;
+	int err;
+
+	dsa_led = devm_kzalloc(ds->dev, sizeof(*dsa_led), GFP_KERNEL);
+	if (!dsa_led)
+		return -ENOMEM;
+
+	dsa_led->dp = dp;
+	cdev = &dsa_led->led_cdev;
+
+	err = of_property_read_u32(led, "reg", &index);
+	if (err)
+		return err;
+	if (index > 255)
+		return -EINVAL;
+
+	dsa_led->index = index;
+
+	if (ds->ops->led_brightness_set)
+		cdev->brightness_set_blocking = dsa_led_brightness_set;
+	if (ds->ops->led_blink_set)
+		cdev->blink_set = dsa_led_blink_set;
+
+	cdev->max_brightness = 1;
+
+	init_data.fwnode = of_fwnode_handle(led);
+	if (dp->user) {
+		init_data.devicename = dev_name(&dp->user->dev);
+		err = devm_led_classdev_register_ext(&dp->user->dev, cdev,
+						     &init_data);
+	} else {
+		init_data.devicename = kasprintf(GFP_KERNEL, "%s:%d",
+						 dev_name(ds->dev), dp->index);
+		err = devm_led_classdev_register_ext(ds->dev, cdev, &init_data);
+	}
+	if (err)
+		return err;
+
+	INIT_LIST_HEAD(&dsa_led->led_list);
+	list_add(&dsa_led->led_list, &dp->leds);
+
+	if (!dp->user)
+		kfree(init_data.devicename);
+
+	return 0;
+}
+
+static int dsa_port_leds_setup(struct dsa_port *dp)
+{
+	struct device_node *leds, *led;
+	int err;
+
+	if (!dp->dn)
+		return 0;
+
+	leds = of_get_child_by_name(dp->dn, "leds");
+	if (!leds)
+		return 0;
+
+	for_each_available_child_of_node(leds, led) {
+		err = dsa_port_led_setup(dp, led);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void dsa_port_leds_teardown(struct dsa_port *dp)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct device *dev = ds->dev;
+	struct led_classdev *cdev;
+	struct dsa_led *dsa_led;
+
+	list_for_each_entry(dsa_led, &dp->leds, led_list) {
+		cdev = &dsa_led->led_cdev;
+		devm_led_classdev_unregister(dev, cdev);
+	}
+}
+
 static int dsa_port_setup(struct dsa_port *dp)
 {
 	bool dsa_port_link_registered = false;
@@ -494,6 +613,11 @@ static int dsa_port_setup(struct dsa_port *dp)
 		err = dsa_port_enable(dp, NULL);
 		if (err)
 			break;
+
+		err = dsa_port_leds_setup(dp);
+		if (err)
+			break;
+
 		dsa_port_enabled = true;
 
 		break;
@@ -512,12 +636,22 @@ static int dsa_port_setup(struct dsa_port *dp)
 		err = dsa_port_enable(dp, NULL);
 		if (err)
 			break;
+
+		err = dsa_port_leds_setup(dp);
+		if (err)
+			break;
+
 		dsa_port_enabled = true;
 
 		break;
 	case DSA_PORT_TYPE_USER:
 		of_get_mac_address(dp->dn, dp->mac);
 		err = dsa_user_create(dp);
+		if (err)
+			break;
+
+		err = dsa_port_leds_setup(dp);
+
 		break;
 	}
 
@@ -544,11 +678,13 @@ static void dsa_port_teardown(struct dsa_port *dp)
 	case DSA_PORT_TYPE_UNUSED:
 		break;
 	case DSA_PORT_TYPE_CPU:
+		dsa_port_leds_teardown(dp);
 		dsa_port_disable(dp);
 		if (dp->dn)
 			dsa_shared_port_link_unregister_of(dp);
 		break;
 	case DSA_PORT_TYPE_DSA:
+		dsa_port_leds_teardown(dp);
 		dsa_port_disable(dp);
 		if (dp->dn)
 			dsa_shared_port_link_unregister_of(dp);
@@ -556,6 +692,7 @@ static void dsa_port_teardown(struct dsa_port *dp)
 	case DSA_PORT_TYPE_USER:
 		if (dp->user) {
 			dsa_user_destroy(dp->user);
+			dsa_port_leds_teardown(dp);
 			dp->user = NULL;
 		}
 		break;
@@ -1108,6 +1245,7 @@ static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
 	INIT_LIST_HEAD(&dp->mdbs);
 	INIT_LIST_HEAD(&dp->vlans); /* also initializes &dp->user_vlans */
 	INIT_LIST_HEAD(&dp->list);
+	INIT_LIST_HEAD(&dp->leds);
 	list_add_tail(&dp->list, &dst->ports);
 
 	return dp;
-- 
2.42.0


