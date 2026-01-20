Return-Path: <netdev+bounces-251539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BrXN3DNb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:46:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 785F349BED
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7456694AFEE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115DD3242A3;
	Tue, 20 Jan 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAfaTEwY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D6322DBB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925962; cv=none; b=uhguzCt313Otd7wowOo2qpkEmVJPwaZ5ukMp0ENk+ueeGZMRDNujBeG2/qjhc3F7RKUYK2+yVUlfUlFT6Ep9i9MJhSiM9z3xCS6qGreUr9hTtWqe1I5EzL/CotkAgHUTfAHv+dKCZJFZEjEisRRt3wLPAgJyqUBPFJ7nroqw/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925962; c=relaxed/simple;
	bh=NKhIUgUSyO9Fk06b9a9uH1GwfkGRsxyVJQ/4a+sJweQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyyQquMiFXzwIIfHODBueE6CgxMCs3n9Do++Vsh+51N9/Up84WrGFRBOBN0qaocuP/Ifx9Y2aAyWcs8CCVZhvEvjldElggJ7kcV3s+TtE2FL1ehKnvp7fAhbtIo6RqTO99wteayruB89MT/xVJINZheGQzyZwEcXKLLDYH0kc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAfaTEwY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-383153e06d6so46093581fa.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925957; x=1769530757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRpIZJajwiI7zezptJqXk246+DmuAjZJnfUV8MFkMns=;
        b=JAfaTEwYBZKKZ9QRTyykv7caK10Xz3fOgRgWtRcT45jj5lZfK52WnCfHWrxxjzan1M
         YdAJcAbCU+KnM/JJj1qr151cEBUWhfFinhVAMeWmg3UTblhrb5hDLzyWrZkDxLXnrYdB
         tGAMXoWWPnSLj07wDyAJLmAbK8CImeGIm6AvVOGVqZQ9RdMbweWqS/G1y6m3BQzpz2VW
         RMG6VkZ6wrV1RuOBQol93sbNxUD+Ae2ENtXicxDYGGMSJY/NpKoTYzJuBarqE2h3NyJQ
         BmHpI+qJtfOeiUKYBa9vWkBIuwgA3QV8c4TGpVLEHEa+syZWpeU1TzatX/jhyKA+daxJ
         EBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925957; x=1769530757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRpIZJajwiI7zezptJqXk246+DmuAjZJnfUV8MFkMns=;
        b=RdcQYm3QQjhAWSAk3YNG0LkqIC4jjvo2UJsw2b9toOngk9tcKbUyQZd8S/lqGZBvg/
         h71mg9edLcgA+cin8H8bkuboM5c1Ezpcs4XheR2Jjsx80BfHquF4KiIU00wQxvGsWzmI
         NjCImKgO6m5qWf4TzrKQq6JfN2EKBjWWkALBf369ibui5/Q/77dlZCUPo6/oEfTYzCfn
         5SUMUqm7MYNL728GK4EqthBBe1VRlgwiNfB3vCu2WdXDrw5xIOW0Y2wkw12dLWYOczWA
         aR3POYqopiEXmQMqyJIaS/r5R+F8UhbZ1jEpF6rkbUTYwlInuhUJAKUDh+E16reT6HNG
         Ly2g==
X-Gm-Message-State: AOJu0YxU+5kA7I8G4wu38AlmgDvGVrmEgcL8sibyJzIv8CHTluCPQ9Wu
	OaHWlfMLq1P0GCZodPsjrsthuYyBLTfONRYdxei+lo4oxYe+u8I8tj2vpJaGjk6C
X-Gm-Gg: AZuq6aIzN8p8XNlYrfW/WpkEAEnmjA0/aLM4WG6km6hfFih63syzmRBQwU9P1F2JEkY
	4FcJttYakLGLvWm9W+bo96IPdoDbp9QKlCdLMRPcJe/pT/Z6iFe0zBG5pQpxULKZ1tl2fYD51I8
	vuUnjoV3jeRn3EiKfyAQvyDke/LwL93S6oZCnLfrGmNaDfj52k1G4gpT4taeyZ+PSQo+yiSRIE4
	Ni7R6nkWe4TK8RMDq+S+gXPdq8DXqjXYuJrz2kp5Gmb7DHoq7lM5gMMZaselXHs9/BLR9ABky0P
	BWwY4I1bp9/gmxGtIrjrHmTvyRy+L4UyRAhQdwGI+fuUgwRCcqUA1J1T4CyU90KCFQB/WdutRJF
	Qg6yvN2AyX35yEx4FcXPo0LupekNtljQf6p4DTewP0/E/LI1lN/w+HKWrGePXqf+yuSnkOpDBa+
	XE8u7PAJ0U89jXVEdX4A6lGoOJkwx/uwCDdPq2jO93T4IZpg==
X-Received: by 2002:a05:651c:1541:b0:37f:c5ca:a6d4 with SMTP id 38308e7fff4ca-385a53b6cb0mr9420661fa.6.1768925957289;
        Tue, 20 Jan 2026 08:19:17 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790d7sm40561531fa.24.2026.01.20.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:19:16 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 2/3] ipvlan: Common code from v6/v4 validator_event
Date: Tue, 20 Jan 2026 19:18:35 +0300
Message-ID: <20260120161852.639238-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
References: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,huawei.com,gmail.com,google.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251539-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 785F349BED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract commond code for ipvlan_addr4_validator_event()/
ipvlan_addr6_validator_event() to own function.

Get rid of separate functions for xxx_validator_event()
and check whether we are called for ipv4 or ipv6 by
looking at "notifier_block *nblock" argument

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 108 +++++++++++++++----------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index cf8c1ea78f4b..dda891911ea4 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -878,6 +878,33 @@ static bool ipvlan_is_valid_dev(const struct net_device *dev)
 	return true;
 }
 
+static int ipvlan_addr_validator_event(struct net_device *dev,
+				       unsigned long event,
+				       struct netlink_ext_ack *extack,
+				       const void *iaddr,
+				       bool is_v6)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	int ret = NOTIFY_OK;
+
+	if (!ipvlan_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_UP:
+		spin_lock_bh(&ipvlan->port->addrs_lock);
+		if (ipvlan_addr_busy(ipvlan->port, iaddr, is_v6)) {
+			NL_SET_ERR_MSG(extack,
+				       "Address already assigned to an ipvlan device");
+			ret = notifier_from_errno(-EADDRINUSE);
+		}
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
+		break;
+	}
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
@@ -922,32 +949,6 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
 
 	return NOTIFY_OK;
 }
-
-static int ipvlan_addr6_validator_event(struct notifier_block *unused,
-					unsigned long event, void *ptr)
-{
-	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
-	struct net_device *dev = (struct net_device *)i6vi->i6vi_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	int ret = NOTIFY_OK;
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		spin_lock_bh(&ipvlan->port->addrs_lock);
-		if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true)) {
-			NL_SET_ERR_MSG(i6vi->extack,
-				       "Address already assigned to an ipvlan device");
-			ret = notifier_from_errno(-EADDRINUSE);
-		}
-		spin_unlock_bh(&ipvlan->port->addrs_lock);
-		break;
-	}
-
-	return ret;
-}
 #endif
 
 static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
@@ -997,38 +998,15 @@ static int ipvlan_addr4_event(struct notifier_block *unused,
 	return NOTIFY_OK;
 }
 
-static int ipvlan_addr4_validator_event(struct notifier_block *unused,
-					unsigned long event, void *ptr)
-{
-	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
-	struct net_device *dev = (struct net_device *)ivi->ivi_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	int ret = NOTIFY_OK;
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		spin_lock_bh(&ipvlan->port->addrs_lock);
-		if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)) {
-			NL_SET_ERR_MSG(ivi->extack,
-				       "Address already assigned to an ipvlan device");
-			ret = notifier_from_errno(-EADDRINUSE);
-		}
-		spin_unlock_bh(&ipvlan->port->addrs_lock);
-		break;
-	}
-
-	return ret;
-}
+static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
+					  unsigned long event, void *ptr);
 
 static struct notifier_block ipvlan_addr4_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_addr4_event,
 };
 
 static struct notifier_block ipvlan_addr4_vtor_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr4_validator_event,
+	.notifier_call = ipvlan_addr_validator_event_cb,
 };
 
 static struct notifier_block ipvlan_notifier_block __read_mostly = {
@@ -1040,10 +1018,32 @@ static struct notifier_block ipvlan_addr6_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_addr6_event,
 };
 
+#endif
+
 static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr6_validator_event,
+	.notifier_call = ipvlan_addr_validator_event_cb,
 };
-#endif
+
+static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
+					  unsigned long event, void *ptr)
+{
+	struct in6_validator_info *i6vi;
+	struct net_device *dev;
+
+	if (nblock == &ipvlan_addr4_vtor_notifier_block) {
+		struct in_validator_info *ivi;
+
+		ivi = (struct in_validator_info *)ptr;
+		dev = ivi->ivi_dev->dev;
+		return ipvlan_addr_validator_event(dev, event, ivi->extack,
+						   &ivi->ivi_addr, false);
+	}
+
+	i6vi = (struct in6_validator_info *)ptr;
+	dev = i6vi->i6vi_dev->dev;
+	return ipvlan_addr_validator_event(dev, event, i6vi->extack,
+					   &i6vi->i6vi_addr, true);
+}
 
 static int __init ipvlan_init_module(void)
 {
-- 
2.43.0


