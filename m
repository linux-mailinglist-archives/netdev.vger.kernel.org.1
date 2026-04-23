Return-Path: <netdev+bounces-280647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LS5OpjN6WkKkgIAu9opvQ
	(envelope-from <netdev+bounces-280647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CD44E175
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E9473048118
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77B2D0C97;
	Thu, 23 Apr 2026 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9DdkDvq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE6311957;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930135; cv=none; b=t9zFT13JJS7kqaNTlC58yzVsoIzQJ7fnNXoJsZCA2gnUhOBjLn2Gc7JAMJyb9E4XtHpBrROTDGP0B6n1Wd5IV1BU8UF0iKiYDsT0KQzMhiyXvfuaqvveXE6OfSD6onfsy1twtSry/LHGefTiAK9P5izdShAgZfgzzaRpC0Wd0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930135; c=relaxed/simple;
	bh=+C27/4TFGd6sUuW+X9doh2+F27pm4Xs+1B5NISDWs4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMBtYZ+iBTzDXq/rEXS36Ky7nzUjBu8WfYlLvi1PcBPzQRp+IgVDXXqcFwzsVGeca/+qNLqpZfBZVndgC0Gg3YuJUA1rS1GV5q6ZamBgRd69t+wzZKNZIkLVuVzv5kxYoskydm7W2eYE2zFJU6G1cezPz+R49O+q7hwhzMXYO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9DdkDvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7394CC2BCB5;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930135;
	bh=+C27/4TFGd6sUuW+X9doh2+F27pm4Xs+1B5NISDWs4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F9DdkDvq3j334Jk60iFnILBB7nq701FlaNU4smL6Njeaf0y9vOiAVYQbPUfTi4eDR
	 3vzgePhw5OBOV7f5VkyhB84sBtMxpYwNm5XQo8pse5kPs5suG42X/Mc8KZko6CLOOL
	 5AlfDLIpDgrOEY74hIF7xh1mGVRI+fQ/s8g4g71KPHgFFKW0mgVbc71oEptqUck8mF
	 Oh+tggu93BEkuCjXcq7lJhUIWC9m4zrSL6nz2GqHKmUM/y67/8hn5bbrhNR+wk30dd
	 f1Ib2vZGeqNjbPYxOBrziTZ8YY1p1GGS6k+X49Pq/4sLKIDULaTAlYajgpxIhdIEuq
	 heDGbCg+aeM1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65527F9934E;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
From: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Date: Thu, 23 Apr 2026 01:42:15 -0600
Subject: [PATCH RFC net-next 2/4] net: pse-pd: add notifier chain for
 controller lifecycle events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-pse-notifier-decouple-v1-2-86ed750a9d62@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776930134; l=5160;
 i=corey@leavitt.info; s=default; h=from:subject:message-id;
 bh=JPjkGmRXffHFQfC2I2vGQ0xhYy/8ixYQjJi6kY9CoRc=;
 b=WTrN9hNzFnWYjnegdQXY9EXP6Nb2/tYCtDR/EZpjo+akks/VVElvHkgPuNG14q+u38RSX6vFN
 dnI5aTIvFlkDsOUJQX4rYpQ0JHF937ScFG5zigPZR22XHiX2ckWv6gO
X-Developer-Key: i=corey@leavitt.info; a=ed25519;
 pk=Q3mmZT+4CRYT8qp8RWvab30X2v2JnLdhHuK7YIHKzpI=
X-Endpoint-Received: by B4 Relay for corey@leavitt.info/default with
 auth_id=748
X-Original-From: Corey Leavitt <corey@leavitt.info>
Reply-To: corey@leavitt.info
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280647-lists,netdev=lfdr.de,corey.leavitt.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[corey@leavitt.info];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leavitt.info:email,leavitt.info:replyto,leavitt.info:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79CD44E175
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Corey Leavitt <corey@leavitt.info>

Introduce a blocking notifier chain that allows other subsystems to be
informed when a PSE controller is registered or unregistered, and
provide pse_register_notifier() / pse_unregister_notifier() as the
subscriber interface.

Subsequent patches will use this to let the phy subsystem own the
phydev->psec lifecycle directly, decoupling PSE lookup from
fwnode_mdiobus_register_phy() and removing the probe-time
-EPROBE_DEFER coupling that currently exists between mdio, phy and
pse-pd when the PSE controller driver is modular.

A blocking chain (rather than atomic) is used because callbacks will
take rtnl_lock and call back into pse_core via of_pse_control_get().

The enum pse_controller_event is placed outside the
IS_ENABLED(CONFIG_PSE_CONTROLLER) guard so that subscribers compiled
into a kernel without PSE support can still reference the event
values in dead-code paths without breaking the build.

This patch is pure infrastructure: nothing fires events yet, and
nothing subscribes. No observable behavior change.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
 drivers/net/pse-pd/pse_core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 893ec2185947..80c5c6c1758c 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
@@ -23,6 +24,39 @@ static LIST_HEAD(pse_controller_list);
 static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
 static DEFINE_MUTEX(pse_pw_d_mutex);
 
+static BLOCKING_NOTIFIER_HEAD(pse_controller_notifier);
+
+/**
+ * pse_register_notifier - register a callback for PSE controller events
+ * @nb: notifier block to register
+ *
+ * See enum pse_controller_event for events fired and their subscriber
+ * contract. Callbacks run in process context; they may sleep, take
+ * rtnl, and call of_pse_control_get(). The chain fires synchronously,
+ * so a PSE controller driver's probe/unbind path must not hold any
+ * such lock when calling pse_controller_register() or
+ * pse_controller_unregister().
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int pse_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&pse_controller_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(pse_register_notifier);
+
+/**
+ * pse_unregister_notifier - unregister a previously registered callback
+ * @nb: notifier block previously passed to pse_register_notifier()
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int pse_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&pse_controller_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(pse_unregister_notifier);
+
 /**
  * struct pse_control - a PSE control
  * @pcdev: a pointer to the PSE controller device
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 4e5696cfade7..78fe3a2b1ea8 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -21,6 +21,7 @@ struct net_device;
 struct phy_device;
 struct pse_controller_dev;
 struct netlink_ext_ack;
+struct notifier_block;
 
 /* C33 PSE extended state and substate. */
 struct ethtool_c33_pse_ext_state_info {
@@ -337,6 +338,24 @@ enum pse_budget_eval_strategies {
 	PSE_BUDGET_EVAL_STRAT_DYNAMIC	= 1 << 2,
 };
 
+/**
+ * enum pse_controller_event - PSE controller lifecycle events
+ *
+ * Event data in callbacks is always a pointer to the struct
+ * pse_controller_dev firing the event.
+ *
+ * @PSE_REGISTERED: controller added to pse_controller_list and
+ *	resolvable by of_pse_control_get().
+ * @PSE_UNREGISTERED: controller about to be removed from
+ *	pse_controller_list. Subscribers holding pse_control references
+ *	targeting it must drop them before returning and must not
+ *	acquire new references for it.
+ */
+enum pse_controller_event {
+	PSE_REGISTERED,
+	PSE_UNREGISTERED,
+};
+
 #if IS_ENABLED(CONFIG_PSE_CONTROLLER)
 int pse_controller_register(struct pse_controller_dev *pcdev);
 void pse_controller_unregister(struct pse_controller_dev *pcdev);
@@ -366,6 +385,9 @@ int pse_ethtool_set_prio(struct pse_control *psec,
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
 
+int pse_register_notifier(struct notifier_block *nb);
+int pse_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline struct pse_control *of_pse_control_get(struct device_node *node,
@@ -416,6 +438,16 @@ static inline bool pse_has_c33(struct pse_control *psec)
 	return false;
 }
 
+static inline int pse_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int pse_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
 #endif
 
 #endif

-- 
2.53.0



