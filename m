Return-Path: <netdev+bounces-36599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED437B0BBC
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 12F271C20852
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484C4C870;
	Wed, 27 Sep 2023 18:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDA4C87A
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:12:49 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C6FC;
	Wed, 27 Sep 2023 11:12:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 441C0FF812;
	Wed, 27 Sep 2023 18:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695838365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2g9n9lswzcBo3flKXhguoGxDZMbhMWh7yiUi9YGpu0=;
	b=pgEJKocf3uZZW1/yRqCXbxv04qdfWO/Bt6KrnbCQZIwrquEsmSZiIo6OImni9VSTsl1YKZ
	aaXtiP2ommaSTy4doaMuHXM/PNWlzCyxc6d9EsMz9BTYBjNsP2FVkME5Bcmu4rdR0E262e
	+6wQjaR+PWrTEI8rvAnmG3eMiGcTbXdRGq/tCwDJmq3BT0OGnly298FcAGWBfuEi1MXzk1
	UyfXESpXo40gka8C8/+1beBcOV9kLweuWfVIMTFLze550/mjKGatm+w+s+jSOhhlH54/6v
	NTmtJerahtOCAEIyqLl2rLs3wnKNFYOEfvNEgBVH8zigallW8YbLRGHAAFwMng==
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
Subject: [PATCH wpan-next v5 10/11] mac802154: Handle disassociation notifications from peers
Date: Wed, 27 Sep 2023 20:12:13 +0200
Message-Id: <20230927181214.129346-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-1-miquel.raynal@bootlin.com>
References: <20230927181214.129346-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Peers may decided to disassociate from us, their coordinator, in this
case they will send a disassociation notification which we must
acknowledge. If we don't, the peer device considers itself disassociated
anyway. We also need to drop the reference to this child from our
internal structures.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/ieee802154_i.h |  2 ++
 net/mac802154/rx.c           |  8 ++++++
 net/mac802154/scan.c         | 55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 432bfa87249e..08dd521a51a5 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -318,6 +318,8 @@ static inline bool mac802154_is_associating(struct ieee802154_local *local)
 int mac802154_send_disassociation_notif(struct ieee802154_sub_if_data *sdata,
 					struct ieee802154_pan_device *target,
 					u8 reason);
+int mac802154_process_disassociation_notif(struct ieee802154_sub_if_data *sdata,
+					   struct sk_buff *skb);
 int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 				      struct sk_buff *skb);
 
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 96040b63a4fc..0024341ef9c5 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -110,6 +110,14 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 		mac802154_process_association_req(mac_pkt->sdata, mac_pkt->skb);
 		break;
 
+	case IEEE802154_CMD_DISASSOCIATION_NOTIFY:
+		dev_dbg(&mac_pkt->sdata->dev->dev, "processing DISASSOC NOTIF\n");
+		if (mac_pkt->sdata->wpan_dev.iftype != NL802154_IFTYPE_COORD)
+			break;
+
+		mac802154_process_disassociation_notif(mac_pkt->sdata, mac_pkt->skb);
+		break;
+
 	default:
 		break;
 	}
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 81d2c2bb1f09..7597072aed57 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -852,3 +852,58 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	mutex_unlock(&wpan_dev->association_lock);
 	return ret;
 }
+
+int mac802154_process_disassociation_notif(struct ieee802154_sub_if_data *sdata,
+					   struct sk_buff *skb)
+{
+	struct ieee802154_addr *src = &mac_cb(skb)->source;
+	struct ieee802154_addr *dest = &mac_cb(skb)->dest;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct ieee802154_pan_device *child;
+	struct ieee802154_addr target;
+	bool parent;
+	u64 teaddr;
+
+	if (skb->len != sizeof(u8))
+		return -EINVAL;
+
+	if (unlikely(src->mode != IEEE802154_EXTENDED_ADDRESSING))
+		return -EINVAL;
+
+	if (dest->mode == IEEE802154_EXTENDED_ADDRESSING &&
+	    unlikely(dest->extended_addr != wpan_dev->extended_addr))
+		return -ENODEV;
+	else if (dest->mode == IEEE802154_SHORT_ADDRESSING &&
+		 unlikely(dest->short_addr != wpan_dev->short_addr))
+		return -ENODEV;
+
+	if (dest->pan_id != wpan_dev->pan_id)
+		return -ENODEV;
+
+	target.mode = IEEE802154_EXTENDED_ADDRESSING;
+	target.extended_addr = src->extended_addr;
+	teaddr = swab64((__force u64)target.extended_addr);
+	dev_dbg(&skb->dev->dev, "Processing DISASSOC NOTIF from %8phC\n", &teaddr);
+
+	mutex_lock(&wpan_dev->association_lock);
+	parent = cfg802154_device_is_parent(wpan_dev, &target);
+	if (!parent)
+		child = cfg802154_device_is_child(wpan_dev, &target);
+	if (!parent && !child) {
+		mutex_unlock(&wpan_dev->association_lock);
+		return -EINVAL;
+	}
+
+	if (parent) {
+		kfree(wpan_dev->parent);
+		wpan_dev->parent = NULL;
+	} else {
+		list_del(&child->node);
+		kfree(child);
+		wpan_dev->nchildren--;
+	}
+
+	mutex_unlock(&wpan_dev->association_lock);
+
+	return 0;
+}
-- 
2.34.1


