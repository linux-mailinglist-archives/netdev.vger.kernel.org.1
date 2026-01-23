Return-Path: <netdev+bounces-252893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHlGJ5aqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:06:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2F78C83
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4AF303D2E4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BEA2C029C;
	Fri, 23 Jan 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb9d+5+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CA28D8FD
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187898; cv=none; b=MEfd/jn7tGpBTVo7Vu9bkEq8tcXcp5Txuw/M1xEburMuiGnaJ1j9Mfl5XPcFrHW6QG4yn18BY4G/Qu6IcUsPeTUo9vhdE5F1I4crhsBIVRQkAiNuQl/zJ5JVDOztvlRWo1HxfjMVm6u5rLEZWIIfQe5qeeljGXFGFv37rMQQGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187898; c=relaxed/simple;
	bh=4d44DzF8jdZooiJ06Z4F1eN6EC1Akys9ZTZ9N6waIs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmQrXl5YMhJSpTJxxBKDXsx8y8aUs8Sep1xfy0kGb33KK1wNgYa/ijHDQF0tQ5wD/9eNNv0R+ffOPPlq20wq4E+LiITMLu3c1HHz5Pwdkbbvqn27dc0GHa+dN3ybdgIqkcuSdFHxt4wqR9jxwwLC4w6OajB0n8PCY3kQh5wKTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb9d+5+I; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59dea72099eso597735e87.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769187894; x=1769792694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lINsEqi2q1q4k1V/Z/pISaCSqKgdNwPjCBFo9g3szW0=;
        b=Pb9d+5+IO956tn3RU4Q2brF8d6MzTNSfgyjC4/2XQpybRG89ygi7FdfXxz7kEcRjqk
         5di9xDUu62kpvODr236OQz3llXylhkdNdkgZElhG+JJPGRaeaHj4iX/OQc/Y89zVQiMY
         cNIA3PrR71Pa2DDBOU2XEButZDz8HGqGwP7R2JhCCfRTTIwS9xY/Cl1CXSFL9rVbhcQj
         2SprTF1UyjgXw0fCvZSQJuh6Ksdq6Oj3aYCDp6WWXbFyzS+zmQ0/C6N9XiVtdL1PU6oi
         hTITOThwgeXx5qHVwFh1dZsZkl6YtRfaqXFoKVR0boNjRFmx+i3WTA8dClXZ95csVPpI
         Lk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187894; x=1769792694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lINsEqi2q1q4k1V/Z/pISaCSqKgdNwPjCBFo9g3szW0=;
        b=JyxklOrlL1qyw0Ti3vw4w3HiVA6qeYUg937F+4MsxFJTPNRQ7XM/aLr8+cwVBBMlGR
         bibdidlab8xioFJ2ALDz8BGlvYsAgh02K4RfE0aPxk4Y07j6t70Q45gl/uGWKzU8Ke/M
         Omh+Dog3iea9P1Qxl/iGfTkZBtCYYOccgiEelewUeXphs/V2g6CdOBxggmtYhR5wHSGN
         Z6x2e5NqjteXt+uWzBw7uH+gQqbwLh+PGjsAUt5WW/NqZgehFZLw35I+PNKEsyYRiXO/
         21WEnryY9VOj/cDUguzYajZZ3QCtcDQxtRnvrQVD0kaWWqm5o67Ulj2JEX+haFhpOroj
         PBNA==
X-Gm-Message-State: AOJu0YzWn77VjyMnwF8yQAiWChggEBgtIQ67349zkVSIpHx2OYQBPBat
	z1Z75J5v5EUR12613IvvL5ptQHb2S+h2UN6n+sqtaN9af/8DNjWOqMc4ukXs8pdzIcY=
X-Gm-Gg: AZuq6aJlSz+SfC3g5wZNONRb1jHzReddLmQ5j6x05zsff5av99z0pwS+AT49Pf+cl/S
	pOzT2qMe+cLw29+Yj1qtlCNMcAsUfSJJFjV+6pDh9b2ugo4pDjdrYilvmY59yCjim/Nm+hHtEZk
	eniFHP5vO9Rk1hET4/RzVp1omPNXUl2y2er9+95ZYnt72F83gWw/Sa1UrCPRaWPnC3MAUrk5PIy
	1cnPa1IKqpFRTsSOqehujMIADrisquQgNWXETrr0vlDUb65FRlmZH0EzFMrB67iNCIwlobsIXof
	z06TYb7ewPVR8UStSjZ4YlObvKbYB9Cb22ftVItRHM5s2H+srTl3Ys5HBReaNmAOjqyq/KgfxRz
	ynq9J5+/fAeOsGSy5mGN8fpmnFtg15sCaAeFIDAO1MXN+yMshZOzWv1Rc5nmT5JBrhToFZaamro
	0cLcA4RbA7qdCy1JCp8B3BBnrCOGX8+XJxpqM2LOOLeWZuIg==
X-Received: by 2002:a05:6512:238c:b0:59d:e7b4:f9e5 with SMTP id 2adb3069b0e04-59de7b4fa3cmr838878e87.38.1769187893920;
        Fri, 23 Jan 2026 09:04:53 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e5fd3sm801772e87.33.2026.01.23.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:04:53 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net-next 3/3] ipvlan: common code to handle ipv6/ipv4 address events
Date: Fri, 23 Jan 2026 20:03:56 +0300
Message-ID: <20260123170412.906280-4-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-252893-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,huawei.com,google.com,fomichev.me,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 3FB2F78C83
X-Rspamd-Action: no action

Both IPv4 and IPv6 addr-event functions are very similar. Refactor
to use common funcitons.

Get rid of separate functions for ipvlan_addrX_event()
and check whether we are called for ipv4 or ipv6 by
looking at "notifier_block *nblock" argument

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
v2:
  - Fixed warning about unused by specifying __maybe_unused
    for ipvlan_addr6_notifier_block (used only with CONFIG_IPV6)

 drivers/net/ipvlan/ipvlan_main.c | 114 ++++++++++++-------------------
 1 file changed, 43 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index d5b55876d340..03d0f23dbe33 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -905,93 +905,45 @@ static int ipvlan_addr_validator_event(struct net_device *dev,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
+static int ipvlan_add_addr_event(struct ipvl_dev *ipvlan, const void *iaddr,
+				 bool is_v6)
 {
 	int ret = -EINVAL;
 
 	spin_lock_bh(&ipvlan->port->addrs_lock);
-	if (ipvlan_addr_busy(ipvlan->port, ip6_addr, true))
-		netif_err(ipvlan, ifup, ipvlan->dev,
-			  "Failed to add IPv6=%pI6c addr for %s intf\n",
-			  ip6_addr, ipvlan->dev->name);
-	else
-		ret = ipvlan_add_addr(ipvlan, ip6_addr, true);
-	spin_unlock_bh(&ipvlan->port->addrs_lock);
-	return ret;
-}
-
-static void ipvlan_del_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
-{
-	return ipvlan_del_addr(ipvlan, ip6_addr, true);
-}
-
-static int ipvlan_addr6_event(struct notifier_block *unused,
-			      unsigned long event, void *ptr)
-{
-	struct inet6_ifaddr *if6 = (struct inet6_ifaddr *)ptr;
-	struct net_device *dev = (struct net_device *)if6->idev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		if (ipvlan_add_addr6(ipvlan, &if6->addr))
-			return NOTIFY_BAD;
-		break;
-
-	case NETDEV_DOWN:
-		ipvlan_del_addr6(ipvlan, &if6->addr);
-		break;
+	if (ipvlan_addr_busy(ipvlan->port, iaddr, is_v6)) {
+		if (is_v6) {
+			netif_err(ipvlan, ifup, ipvlan->dev,
+				  "Failed to add IPv6=%pI6c addr on %s intf\n",
+				  iaddr, ipvlan->dev->name);
+		} else {
+			netif_err(ipvlan, ifup, ipvlan->dev,
+				  "Failed to add IPv4=%pI4 on %s intf.\n",
+				  iaddr, ipvlan->dev->name);
+		}
+	} else {
+		ret = ipvlan_add_addr(ipvlan, iaddr, is_v6);
 	}
-
-	return NOTIFY_OK;
-}
-#endif
-
-static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
-{
-	int ret = -EINVAL;
-
-	spin_lock_bh(&ipvlan->port->addrs_lock);
-	if (ipvlan_addr_busy(ipvlan->port, ip4_addr, false))
-		netif_err(ipvlan, ifup, ipvlan->dev,
-			  "Failed to add IPv4=%pI4 on %s intf.\n",
-			  ip4_addr, ipvlan->dev->name);
-	else
-		ret = ipvlan_add_addr(ipvlan, ip4_addr, false);
 	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
-static void ipvlan_del_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
-{
-	return ipvlan_del_addr(ipvlan, ip4_addr, false);
-}
-
-static int ipvlan_addr4_event(struct notifier_block *unused,
-			      unsigned long event, void *ptr)
+static int ipvlan_addr_event(struct net_device *dev, unsigned long event,
+			     const void *iaddr, bool is_v6)
 {
-	struct in_ifaddr *if4 = (struct in_ifaddr *)ptr;
-	struct net_device *dev = (struct net_device *)if4->ifa_dev->dev;
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	struct in_addr ip4_addr;
 
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
-		ip4_addr.s_addr = if4->ifa_address;
-		if (ipvlan_add_addr4(ipvlan, &ip4_addr))
+		if (ipvlan_add_addr_event(ipvlan, iaddr, is_v6))
 			return NOTIFY_BAD;
 		break;
 
 	case NETDEV_DOWN:
-		ip4_addr.s_addr = if4->ifa_address;
-		ipvlan_del_addr4(ipvlan, &ip4_addr);
+		ipvlan_del_addr(ipvlan, iaddr, is_v6);
 		break;
 	}
 
@@ -1001,8 +953,11 @@ static int ipvlan_addr4_event(struct notifier_block *unused,
 static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
 					  unsigned long event, void *ptr);
 
+static int ipvlan_addr_event_cb(struct notifier_block *unused,
+				unsigned long event, void *ptr);
+
 static struct notifier_block ipvlan_addr4_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr4_event,
+	.notifier_call = ipvlan_addr_event_cb,
 };
 
 static struct notifier_block ipvlan_addr4_vtor_notifier_block __read_mostly = {
@@ -1013,11 +968,10 @@ static struct notifier_block ipvlan_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_device_event,
 };
 
-#if IS_ENABLED(CONFIG_IPV6)
-static struct notifier_block ipvlan_addr6_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr6_event,
+static struct notifier_block
+ipvlan_addr6_notifier_block __read_mostly __maybe_unused = {
+	.notifier_call = ipvlan_addr_event_cb,
 };
-#endif
 
 static struct notifier_block
 ipvlan_addr6_vtor_notifier_block __read_mostly __maybe_unused = {
@@ -1045,6 +999,24 @@ static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
 					   &i6vi->i6vi_addr, true);
 }
 
+static int ipvlan_addr_event_cb(struct notifier_block *nblock,
+				unsigned long event, void *ptr)
+{
+	struct inet6_ifaddr *if6;
+	struct net_device *dev;
+
+	if (nblock == &ipvlan_addr4_notifier_block) {
+		struct in_ifaddr *if4 = (struct in_ifaddr *)ptr;
+
+		dev = if4->ifa_dev->dev;
+		return ipvlan_addr_event(dev, event, &if4->ifa_address, false);
+	}
+
+	if6 = (struct inet6_ifaddr *)ptr;
+	dev = if6->idev->dev;
+	return ipvlan_addr_event(dev, event, &if6->addr, true);
+}
+
 static int __init ipvlan_init_module(void)
 {
 	int err;
-- 
2.43.0


