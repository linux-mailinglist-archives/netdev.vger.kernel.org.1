Return-Path: <netdev+bounces-34634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335AB7A4EBF
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FF31C2120A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091871CA87;
	Mon, 18 Sep 2023 16:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978C2376C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:25:28 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA7349E2;
	Mon, 18 Sep 2023 09:24:17 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id AF10AD1910;
	Mon, 18 Sep 2023 15:08:44 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 037A31C0014;
	Mon, 18 Sep 2023 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695049724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5Vkva5HZnVM4Ixi9QUntO5y0V2AbU4F4e7tb6GhRRI=;
	b=SxCaaljdNENIY33lLp8j/TFGhnIJlLJMl11K89xczy5wJN+ig6J9q3ETDgG01TIMvwvxsO
	MhVzF07H2GANK2TvT2CPJg3juITXNUXGRU56r6LwocP8PrZtDDz+IcO1w9gqiEvnxJGtDa
	CwwQwytK7RA1T6BHCqgDYBthotaJqFT5e+bhnb7i4pfXUy6CY3Yvr7uJeFDdDBIlxvALrl
	EZgKiN4dmIwl8sdDEntfQYMzEplLBdzgBoO2WH8nUHC7TKPUnpVvR8kXcwuYP8pQzPUKLw
	7sV4ySijdqWBrRlX4s2BmWK2j8/5hOS+8hjGWrUQ0MTCOwq0ReOV+lRThtTsJA==
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
Subject: [PATCH wpan-next v3 09/11] mac802154: Follow the number of associated devices
Date: Mon, 18 Sep 2023 17:08:07 +0200
Message-Id: <20230918150809.275058-10-miquel.raynal@bootlin.com>
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
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Track the count of associated devices. Limit the number of associations
using the value provided by the user if any. If we reach the maximum
number of associations, we tell the device we are at capacity. If the
user do not want to accept any more associations, it may specify the
value 0 to the maximum number of associations, which will lead to an
access denied error status returned to the peers trying to associate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h |  1 +
 net/ieee802154/core.c   |  2 ++
 net/mac802154/cfg.c     |  1 +
 net/mac802154/scan.c    | 33 +++++++++++++++++++++++----------
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index bb09ccaf56c2..fe5310cb8d60 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -507,6 +507,7 @@ struct wpan_dev {
 	struct ieee802154_pan_device *parent;
 	struct list_head children;
 	unsigned int max_associations;
+	unsigned int nchildren;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 2d6fe45efa05..60e8fff1347e 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -212,6 +212,8 @@ static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
 		kfree(child);
 	}
 
+	wpan_dev->nchildren = 0;
+
 	mutex_unlock(&wpan_dev->association_lock);
 }
 
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 0d0aed788f57..4a85fa674f66 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -454,6 +454,7 @@ static int mac802154_disassociate_child(struct wpan_phy *wpan_phy,
 		return ret;
 
 	list_del(&child->node);
+	wpan_dev->nchildren--;
 	kfree(child);
 
 	return 0;
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 76f04550aabb..9ba45984e9de 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -800,20 +800,32 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	child->mode = IEEE802154_EXTENDED_ADDRESSING;
 	ceaddr = swab64((__force u64)child->extended_addr);
 
-	assoc_resp_pl.status = IEEE802154_ASSOCIATION_SUCCESSFUL;
-	if (assoc_req_pl.alloc_addr) {
-		assoc_resp_pl.short_addr = cfg802154_get_free_short_addr(wpan_dev);
-		child->mode = IEEE802154_SHORT_ADDRESSING;
+	if (wpan_dev->nchildren >= wpan_dev->max_associations) {
+		if (!wpan_dev->max_associations)
+			assoc_resp_pl.status = IEEE802154_PAN_ACCESS_DENIED;
+		else
+			assoc_resp_pl.status = IEEE802154_PAN_AT_CAPACITY;
+		assoc_resp_pl.short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
+		dev_dbg(&sdata->dev->dev,
+			"Refusing ASSOC REQ from child %8phC, %s\n", &ceaddr,
+			assoc_resp_pl.status == IEEE802154_PAN_ACCESS_DENIED ?
+			"access denied" : "too many children");
 	} else {
-		assoc_resp_pl.short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+		assoc_resp_pl.status = IEEE802154_ASSOCIATION_SUCCESSFUL;
+		if (assoc_req_pl.alloc_addr) {
+			assoc_resp_pl.short_addr = cfg802154_get_free_short_addr(wpan_dev);
+			child->mode = IEEE802154_SHORT_ADDRESSING;
+		} else {
+			assoc_resp_pl.short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+		}
+		child->short_addr = assoc_resp_pl.short_addr;
+		dev_dbg(&sdata->dev->dev,
+			"Accepting ASSOC REQ from child %8phC, providing short address 0x%04x\n",
+			&ceaddr, le16_to_cpu(child->short_addr));
 	}
-	child->short_addr = assoc_resp_pl.short_addr;
-	dev_dbg(&sdata->dev->dev,
-		"Accepting ASSOC REQ from child %8phC, providing short address 0x%04x\n",
-		&ceaddr, le16_to_cpu(child->short_addr));
 
 	ret = mac802154_send_association_resp_locked(sdata, child, &assoc_resp_pl);
-	if (ret) {
+	if (ret || assoc_resp_pl.status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
 		kfree(child);
 		goto unlock;
 	}
@@ -837,6 +849,7 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	}
 
 	list_add(&child->node, &wpan_dev->children);
+	wpan_dev->nchildren++;
 
 unlock:
 	mutex_unlock(&wpan_dev->association_lock);
-- 
2.34.1


