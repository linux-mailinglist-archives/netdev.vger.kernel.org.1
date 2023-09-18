Return-Path: <netdev+bounces-34579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26F7A4C9C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DDE1C2114E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831CE1D6BB;
	Mon, 18 Sep 2023 15:37:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB51CFAD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:37:11 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502A42D49;
	Mon, 18 Sep 2023 08:34:59 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D5871D18CE;
	Mon, 18 Sep 2023 15:08:36 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D59FE1C0010;
	Mon, 18 Sep 2023 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695049716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXlo36LBCUj2fJVHspV5mzdZ8tezb/UMkRcLg5nmmN8=;
	b=mrvAHtBsZnVAqhiOolcqkGyv7OgFWKwio8/WvXqXE7Ir49TMKtCjTnqX4BYJjOdVrutl3F
	RdbsZxt4jqxw+u8P43K83CkzmODVMwO+u90z+4GnfXttn8wEZTPkcp/Qq04T82PoGiWYsC
	sVvtVqeGoYDCP5wnwKnaOLQmXVwKro+yqaVCePKlRl0ytJ3RSLDz0c67I1pVkudOS7zRG7
	234yJ2igJ5rucon7/WRdx07HLc9Zsc7uwX270GtxAl4VSOasqamcVpBUMLwllGS1fF4Yc7
	q3dQ1GiWGWS6tmYxCKaPv84NDPh5u6XdxKpbTVQNZFilIsmOKiWqrupOzq76YA==
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
Subject: [PATCH wpan-next v3 04/11] mac802154: Handle associating
Date: Mon, 18 Sep 2023 17:08:02 +0200
Message-Id: <20230918150809.275058-5-miquel.raynal@bootlin.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Joining a PAN officially goes by associating with a coordinator. This
coordinator may have been discovered thanks to the beacons it sent in
the past. Add support to the MAC layer for these associations, which
require:
- Sending an association request
- Receiving an association response

The association response contains the association status, eventually a
reason if the association was unsuccessful, and finally a short address
that we should use for intra-PAN communication from now on, if we
required one (which is the default, and not yet configurable).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/ieee802154_netdev.h |   5 ++
 net/ieee802154/core.c           |  12 +++
 net/mac802154/cfg.c             |  69 +++++++++++++++++
 net/mac802154/ieee802154_i.h    |  19 +++++
 net/mac802154/main.c            |   2 +
 net/mac802154/rx.c              |   9 +++
 net/mac802154/scan.c            | 127 ++++++++++++++++++++++++++++++++
 7 files changed, 243 insertions(+)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index ca8c827d0d7f..e26ffd079556 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -149,6 +149,11 @@ struct ieee802154_assoc_req_pl {
 #endif
 } __packed;
 
+struct ieee802154_assoc_resp_pl {
+	__le16 short_addr;
+	u8 status;
+} __packed;
+
 enum ieee802154_frame_version {
 	IEEE802154_2003_STD,
 	IEEE802154_2006_STD,
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index cd69bdbfd59f..a08d75dd56ad 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -198,6 +198,16 @@ void wpan_phy_free(struct wpan_phy *phy)
 }
 EXPORT_SYMBOL(wpan_phy_free);
 
+static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
+{
+	mutex_lock(&wpan_dev->association_lock);
+
+	kfree(wpan_dev->parent);
+	wpan_dev->parent = NULL;
+
+	mutex_unlock(&wpan_dev->association_lock);
+}
+
 int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 			   struct net *net)
 {
@@ -293,6 +303,8 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 		rdev->opencount++;
 		break;
 	case NETDEV_UNREGISTER:
+		cfg802154_free_peer_structures(wpan_dev);
+
 		/* It is possible to get NETDEV_UNREGISTER
 		 * multiple times. To detect that, check
 		 * that the interface is still on the list
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 5c3cb019f751..0602bc5b8fbd 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -315,6 +315,74 @@ static int mac802154_stop_beacons(struct wpan_phy *wpan_phy,
 	return mac802154_stop_beacons_locked(local, sdata);
 }
 
+static int mac802154_associate(struct wpan_phy *wpan_phy,
+			       struct wpan_dev *wpan_dev,
+			       struct ieee802154_addr *coord)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	u64 ceaddr = swab64((__force u64)coord->extended_addr);
+	struct ieee802154_sub_if_data *sdata;
+	struct ieee802154_pan_device *parent;
+	__le16 short_addr;
+	int ret;
+
+	ASSERT_RTNL();
+
+	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
+
+	if (wpan_dev->parent) {
+		dev_err(&sdata->dev->dev,
+			"Device %8phC is already associated\n", &ceaddr);
+		return -EPERM;
+	}
+
+	if (coord->mode == IEEE802154_SHORT_ADDRESSING)
+		return -EINVAL;
+
+	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	if (!parent)
+		return -ENOMEM;
+
+	parent->pan_id = coord->pan_id;
+	parent->mode = coord->mode;
+	parent->extended_addr = coord->extended_addr;
+	parent->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
+
+	/* Set the PAN ID hardware address filter beforehand to avoid dropping
+	 * the association response with a destination PAN ID field set to the
+	 * "new" PAN ID.
+	 */
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		ret = drv_set_pan_id(local, coord->pan_id);
+		if (ret < 0)
+			goto free_parent;
+	}
+
+	ret = mac802154_perform_association(sdata, parent, &short_addr);
+	if (ret)
+		goto reset_panid;
+
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		ret = drv_set_short_addr(local, short_addr);
+		if (ret < 0)
+			goto reset_panid;
+	}
+
+	wpan_dev->pan_id = coord->pan_id;
+	wpan_dev->short_addr = short_addr;
+	wpan_dev->parent = parent;
+
+	return 0;
+
+reset_panid:
+	if (local->hw.flags & IEEE802154_HW_AFILT)
+		drv_set_pan_id(local, IEEE802154_PAN_ID_BROADCAST);
+
+free_parent:
+	kfree(parent);
+	return ret;
+}
+
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 static void
 ieee802154_get_llsec_table(struct wpan_phy *wpan_phy,
@@ -526,6 +594,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.abort_scan = mac802154_abort_scan,
 	.send_beacons = mac802154_send_beacons,
 	.stop_beacons = mac802154_stop_beacons,
+	.associate = mac802154_associate,
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	.get_llsec_table = ieee802154_get_llsec_table,
 	.lock_llsec_table = ieee802154_lock_llsec_table,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index c347ec9ff8c9..fff67676b400 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -24,6 +24,7 @@
 enum ieee802154_ongoing {
 	IEEE802154_IS_SCANNING = BIT(0),
 	IEEE802154_IS_BEACONING = BIT(1),
+	IEEE802154_IS_ASSOCIATING = BIT(2),
 };
 
 /* mac802154 device private data */
@@ -74,6 +75,13 @@ struct ieee802154_local {
 	struct list_head rx_mac_cmd_list;
 	struct work_struct rx_mac_cmd_work;
 
+	/* Association */
+	struct ieee802154_pan_device *assoc_dev;
+	struct completion assoc_done;
+	__le16 assoc_addr;
+	u8 assoc_status;
+	struct work_struct assoc_work;
+
 	bool started;
 	bool suspended;
 	unsigned long ongoing;
@@ -296,6 +304,17 @@ static inline bool mac802154_is_beaconing(struct ieee802154_local *local)
 
 void mac802154_rx_mac_cmd_worker(struct work_struct *work);
 
+int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
+				  struct ieee802154_pan_device *coord,
+				  __le16 *short_addr);
+int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
+				       struct sk_buff *skb);
+
+static inline bool mac802154_is_associating(struct ieee802154_local *local)
+{
+	return test_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+}
+
 /* interface handling */
 int ieee802154_iface_init(void);
 void ieee802154_iface_exit(void);
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 357ece67432b..9ab7396668d2 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -103,6 +103,8 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_DELAYED_WORK(&local->beacon_work, mac802154_beacon_worker);
 	INIT_WORK(&local->rx_mac_cmd_work, mac802154_rx_mac_cmd_worker);
 
+	init_completion(&local->assoc_done);
+
 	/* init supported flags with 802.15.4 default ranges */
 	phy->supported.max_minbe = 8;
 	phy->supported.min_maxbe = 3;
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index e2434b4fe514..d0e08613a36b 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -93,6 +93,15 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 
 		queue_delayed_work(local->mac_wq, &local->beacon_work, 0);
 		break;
+
+	case IEEE802154_CMD_ASSOCIATION_RESP:
+		dev_dbg(&mac_pkt->sdata->dev->dev, "processing ASSOC RESP\n");
+		if (!mac802154_is_associating(local))
+			break;
+
+		mac802154_process_association_resp(mac_pkt->sdata, mac_pkt->skb);
+		break;
+
 	default:
 		break;
 	}
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index d9658f2c4ae6..5dd50e1ce329 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -510,3 +510,130 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
 
 	return 0;
 }
+
+int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
+				  struct ieee802154_pan_device *coord,
+				  __le16 *short_addr)
+{
+	u64 ceaddr = swab64((__force u64)coord->extended_addr);
+	struct ieee802154_association_req_frame frame = {};
+	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct sk_buff *skb;
+	int ret;
+
+	frame.mhr.fc.type = IEEE802154_FC_TYPE_MAC_CMD;
+	frame.mhr.fc.security_enabled = 0;
+	frame.mhr.fc.frame_pending = 0;
+	frame.mhr.fc.ack_request = 1; /* We always expect an ack here */
+	frame.mhr.fc.intra_pan = 0;
+	frame.mhr.fc.dest_addr_mode = (coord->mode == IEEE802154_ADDR_LONG) ?
+		IEEE802154_EXTENDED_ADDRESSING : IEEE802154_SHORT_ADDRESSING;
+	frame.mhr.fc.version = IEEE802154_2003_STD;
+	frame.mhr.fc.source_addr_mode = IEEE802154_EXTENDED_ADDRESSING;
+	frame.mhr.source.mode = IEEE802154_ADDR_LONG;
+	frame.mhr.source.pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
+	frame.mhr.source.extended_addr = wpan_dev->extended_addr;
+	frame.mhr.dest.mode = coord->mode;
+	frame.mhr.dest.pan_id = coord->pan_id;
+	if (coord->mode == IEEE802154_ADDR_LONG)
+		frame.mhr.dest.extended_addr = coord->extended_addr;
+	else
+		frame.mhr.dest.short_addr = coord->short_addr;
+	frame.mhr.seq = atomic_inc_return(&wpan_dev->dsn) & 0xFF;
+	frame.mac_pl.cmd_id = IEEE802154_CMD_ASSOCIATION_REQ;
+	frame.assoc_req_pl.device_type = 1;
+	frame.assoc_req_pl.power_source = 1;
+	frame.assoc_req_pl.rx_on_when_idle = 1;
+	frame.assoc_req_pl.alloc_addr = 1;
+
+	skb = alloc_skb(IEEE802154_MAC_CMD_SKB_SZ + sizeof(frame.assoc_req_pl),
+			GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	skb->dev = sdata->dev;
+
+	ret = ieee802154_mac_cmd_push(skb, &frame, &frame.assoc_req_pl,
+				      sizeof(frame.assoc_req_pl));
+	if (ret) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	local->assoc_dev = coord;
+	reinit_completion(&local->assoc_done);
+	set_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+
+	ret = ieee802154_mlme_tx_one_locked(local, sdata, skb);
+	if (ret) {
+		if (ret > 0)
+			ret = (ret == IEEE802154_NO_ACK) ? -EREMOTEIO : -EIO;
+		dev_warn(&sdata->dev->dev,
+			 "No ASSOC REQ ACK received from %8phC\n", &ceaddr);
+		goto clear_assoc;
+	}
+
+	ret = wait_for_completion_killable_timeout(&local->assoc_done, 10 * HZ);
+	if (ret <= 0) {
+		dev_warn(&sdata->dev->dev,
+			 "No ASSOC RESP received from %8phC\n", &ceaddr);
+		ret = -ETIMEDOUT;
+		goto clear_assoc;
+	}
+
+	if (local->assoc_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
+		if (local->assoc_status == IEEE802154_PAN_AT_CAPACITY)
+			ret = -ERANGE;
+		else
+			ret = -EPERM;
+
+		dev_warn(&sdata->dev->dev,
+			 "Negative ASSOC RESP received from %8phC: %s\n", &ceaddr,
+			 local->assoc_status == IEEE802154_PAN_AT_CAPACITY ?
+			 "PAN at capacity" : "access denied");
+	}
+
+	ret = 0;
+	*short_addr = local->assoc_addr;
+
+clear_assoc:
+	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+	local->assoc_dev = NULL;
+
+	return ret;
+}
+
+int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
+				       struct sk_buff *skb)
+{
+	struct ieee802154_addr *src = &mac_cb(skb)->source;
+	struct ieee802154_addr *dest = &mac_cb(skb)->dest;
+	u64 deaddr = swab64((__force u64)dest->extended_addr);
+	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct ieee802154_assoc_resp_pl resp_pl = {};
+
+	if (skb->len != sizeof(resp_pl))
+		return -EINVAL;
+
+	if (unlikely(src->mode != IEEE802154_EXTENDED_ADDRESSING ||
+		     dest->mode != IEEE802154_EXTENDED_ADDRESSING))
+		return -EINVAL;
+
+	if (unlikely(dest->extended_addr != wpan_dev->extended_addr ||
+		     src->extended_addr != local->assoc_dev->extended_addr))
+		return -ENODEV;
+
+	memcpy(&resp_pl, skb->data, sizeof(resp_pl));
+	local->assoc_addr = resp_pl.short_addr;
+	local->assoc_status = resp_pl.status;
+
+	dev_dbg(&skb->dev->dev,
+		"ASSOC RESP 0x%x received from %8phC, getting short address %04x\n",
+		local->assoc_status, &deaddr, local->assoc_addr);
+
+	complete(&local->assoc_done);
+
+	return 0;
+}
-- 
2.34.1


