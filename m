Return-Path: <netdev+bounces-34610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D057A4D93
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAC6282408
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182611E512;
	Mon, 18 Sep 2023 15:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63020B12
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:48:55 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E310CE;
	Mon, 18 Sep 2023 08:45:55 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 3CBB2D18D8;
	Mon, 18 Sep 2023 15:08:40 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 233D21C0009;
	Mon, 18 Sep 2023 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695049719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+oz6temaL2HBEzMB8Ilo3z0BzplmbtBdI7bsgB0az8=;
	b=QNT3WmE4xgMLzJV9SeY44sLP/4PF+rhW/GSWoTeTYS0og+qLYTHNrIBHOLtBm7fIZ62bHn
	Up5IQLqlMquvbD09ej1uGyBf8InrFFS7t5sEEnLcEhFPfjQ8PPEUd0qSlDXTMztEZ8/i3y
	z/ZYnmueUQTQMIFU3OLs5yVUqgFRjmhA4TY8t+dwvpeycmpgp2Kd/1qokrn5h7Yi0lu0+p
	NPmB42B9IgGkWjZoqTtvqLRzrXSCNKYThZBXV0s87ANgluGSnMhyLcu3hfsdDySiA8ungx
	7KLh2OVxbzTSV9QxeLumHeOjxBqgb+tI2jQL+zSSn+B8t2nPy87QC+ZWB10Blg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v3 06/11] mac802154: Handle disassociations
Date: Mon, 18 Sep 2023 17:08:04 +0200
Message-Id: <20230918150809.275058-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150809.275058-1-miquel.raynal@bootlin.com>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Devices may decide to disassociate from their coordinator for different
reasons (device turning off, coordinator signal strength too low, etc),
the MAC layer just has to send a disassociation notification.

If the ack of the disassociation notification is not received, the
device may consider itself disassociated anyway.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/pan.c         |   2 +
 net/mac802154/cfg.c          | 100 +++++++++++++++++++++++++++++++++++
 net/mac802154/ieee802154_i.h |   4 ++
 net/mac802154/scan.c         |  60 +++++++++++++++++++++
 4 files changed, 166 insertions(+)

diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
index 012b5e821d54..78b5099591ae 100644
--- a/net/ieee802154/pan.c
+++ b/net/ieee802154/pan.c
@@ -58,6 +58,7 @@ bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(cfg802154_device_is_parent);
 
 struct ieee802154_pan_device *
 cfg802154_device_is_child(struct wpan_dev *wpan_dev,
@@ -73,3 +74,4 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 0602bc5b8fbd..0d0aed788f57 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -383,6 +383,105 @@ static int mac802154_associate(struct wpan_phy *wpan_phy,
 	return ret;
 }
 
+static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
+					      struct wpan_dev *wpan_dev)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	struct ieee802154_pan_device *child, *tmp;
+	struct ieee802154_sub_if_data *sdata;
+	u64 eaddr;
+	int ret;
+
+	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
+
+	/* Start by disassociating all the children and preventing new ones to
+	 * attempt associations.
+	 */
+	list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
+		ret = mac802154_send_disassociation_notif(sdata, child,
+							  IEEE802154_COORD_WISHES_DEVICE_TO_LEAVE);
+		if (ret) {
+			eaddr = swab64((__force u64)child->extended_addr);
+			dev_err(&sdata->dev->dev,
+				"Disassociation with %8phC may have failed (%d)\n",
+				&eaddr, ret);
+		}
+
+		list_del(&child->node);
+	}
+
+	ret = mac802154_send_disassociation_notif(sdata, wpan_dev->parent,
+						  IEEE802154_DEVICE_WISHES_TO_LEAVE);
+	if (ret) {
+		eaddr = swab64((__force u64)wpan_dev->parent->extended_addr);
+		dev_err(&sdata->dev->dev,
+			"Disassociation from %8phC may have failed (%d)\n",
+			&eaddr, ret);
+	}
+
+	ret = 0;
+
+	kfree(wpan_dev->parent);
+	wpan_dev->parent = NULL;
+	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PAN_ID_BROADCAST);
+	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
+
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		ret = drv_set_pan_id(local, wpan_dev->pan_id);
+		if (ret < 0)
+			return ret;
+
+		ret = drv_set_short_addr(local, wpan_dev->short_addr);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mac802154_disassociate_child(struct wpan_phy *wpan_phy,
+					struct wpan_dev *wpan_dev,
+					struct ieee802154_pan_device *child)
+{
+	struct ieee802154_sub_if_data *sdata;
+	int ret;
+
+	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
+
+	ret = mac802154_send_disassociation_notif(sdata, child,
+						  IEEE802154_COORD_WISHES_DEVICE_TO_LEAVE);
+	if (ret)
+		return ret;
+
+	list_del(&child->node);
+	kfree(child);
+
+	return 0;
+}
+
+static int mac802154_disassociate(struct wpan_phy *wpan_phy,
+				  struct wpan_dev *wpan_dev,
+				  struct ieee802154_addr *target)
+{
+	u64 teaddr = swab64((__force u64)target->extended_addr);
+	struct ieee802154_pan_device *pan_device;
+
+	ASSERT_RTNL();
+
+	if (cfg802154_device_is_parent(wpan_dev, target))
+		return mac802154_disassociate_from_parent(wpan_phy, wpan_dev);
+
+	pan_device = cfg802154_device_is_child(wpan_dev, target);
+	if (pan_device)
+		return mac802154_disassociate_child(wpan_phy, wpan_dev,
+						    pan_device);
+
+	dev_err(&wpan_dev->netdev->dev,
+		"Device %8phC is not associated with us\n", &teaddr);
+
+	return -EINVAL;
+}
+
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 static void
 ieee802154_get_llsec_table(struct wpan_phy *wpan_phy,
@@ -595,6 +694,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.send_beacons = mac802154_send_beacons,
 	.stop_beacons = mac802154_stop_beacons,
 	.associate = mac802154_associate,
+	.disassociate = mac802154_disassociate,
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	.get_llsec_table = ieee802154_get_llsec_table,
 	.lock_llsec_table = ieee802154_lock_llsec_table,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index fff67676b400..92252f86c69c 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -315,6 +315,10 @@ static inline bool mac802154_is_associating(struct ieee802154_local *local)
 	return test_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
 }
 
+int mac802154_send_disassociation_notif(struct ieee802154_sub_if_data *sdata,
+					struct ieee802154_pan_device *target,
+					u8 reason);
+
 /* interface handling */
 int ieee802154_iface_init(void);
 void ieee802154_iface_exit(void);
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 5dd50e1ce329..e2f2e1235ec6 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -637,3 +637,63 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
 
 	return 0;
 }
+
+int mac802154_send_disassociation_notif(struct ieee802154_sub_if_data *sdata,
+					struct ieee802154_pan_device *target,
+					u8 reason)
+{
+	struct ieee802154_disassociation_notif_frame frame = {};
+	u64 teaddr = swab64((__force u64)target->extended_addr);
+	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct sk_buff *skb;
+	int ret;
+
+	frame.mhr.fc.type = IEEE802154_FC_TYPE_MAC_CMD;
+	frame.mhr.fc.security_enabled = 0;
+	frame.mhr.fc.frame_pending = 0;
+	frame.mhr.fc.ack_request = 1;
+	frame.mhr.fc.intra_pan = 1;
+	frame.mhr.fc.dest_addr_mode = (target->mode == IEEE802154_ADDR_LONG) ?
+		IEEE802154_EXTENDED_ADDRESSING : IEEE802154_SHORT_ADDRESSING;
+	frame.mhr.fc.version = IEEE802154_2003_STD;
+	frame.mhr.fc.source_addr_mode = IEEE802154_EXTENDED_ADDRESSING;
+	frame.mhr.source.mode = IEEE802154_ADDR_LONG;
+	frame.mhr.source.pan_id = wpan_dev->pan_id;
+	frame.mhr.source.extended_addr = wpan_dev->extended_addr;
+	frame.mhr.dest.mode = target->mode;
+	frame.mhr.dest.pan_id = wpan_dev->pan_id;
+	if (target->mode == IEEE802154_ADDR_LONG)
+		frame.mhr.dest.extended_addr = target->extended_addr;
+	else
+		frame.mhr.dest.short_addr = target->short_addr;
+	frame.mhr.seq = atomic_inc_return(&wpan_dev->dsn) & 0xFF;
+	frame.mac_pl.cmd_id = IEEE802154_CMD_DISASSOCIATION_NOTIFY;
+	frame.disassoc_pl = reason;
+
+	skb = alloc_skb(IEEE802154_MAC_CMD_SKB_SZ + sizeof(frame.disassoc_pl),
+			GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	skb->dev = sdata->dev;
+
+	ret = ieee802154_mac_cmd_push(skb, &frame, &frame.disassoc_pl,
+				      sizeof(frame.disassoc_pl));
+	if (ret) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	ret = ieee802154_mlme_tx_one_locked(local, sdata, skb);
+	if (ret) {
+		dev_warn(&sdata->dev->dev,
+			 "No DISASSOC ACK received from %8phC\n", &teaddr);
+		if (ret > 0)
+			ret = (ret == IEEE802154_NO_ACK) ? -EREMOTEIO : -EIO;
+		return ret;
+	}
+
+	dev_dbg(&sdata->dev->dev, "DISASSOC ACK received from %8phC\n", &teaddr);
+	return 0;
+}
-- 
2.34.1


