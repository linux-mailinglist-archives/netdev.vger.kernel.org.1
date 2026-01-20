Return-Path: <netdev+bounces-251540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M5EAlLAb2lsMQAAu9opvQ
	(envelope-from <netdev+bounces-251540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:50:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639748DA8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24F1846D5BA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7AF44D6A6;
	Tue, 20 Jan 2026 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDv9LIz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281F44CF39
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925965; cv=none; b=XdJWHSQPBi6hUwEq5GV2/H/y+RqCt+3RpccdtiS0tzxhIeULz6hoe9DzkllKvLX0u1d93F3K4wgLKlr53NMXLPzI7nvA+pssbVtIQYRaD3krIuBZAFQ/nl8PkUYgv/Ohm0wqv7/lUquDuNT/Ijs/HAHrPLfASAfNYLHslPupPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925965; c=relaxed/simple;
	bh=0Ze5qPbZr/CD4GrrNtSahxVQmMNdSSXiafXF63g98Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6lyTNtobF/V3FQu+x6orpuvM0egLYoQkC6Pw9Cj1ipoeJmEPjiUduXKvnzBoJyi3dEdHWEzh17qaoeDouqqNdCnfk3e3QT0BUA//sHYDXF6LXX36OFpIGfWEH3IkxbDfiaOzWRsi8DOUtES0fWvHXP0fEPizUncDn/WhcRfExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDv9LIz0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-382fb6d38f7so40040201fa.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925962; x=1769530762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnU6wvo/eukSL1UUkOOfW8Bq0esgoFWYEdwYnwASYLM=;
        b=EDv9LIz0jebmRTeqlSTiSlo9KCbNPAqsTeRjOCZ5o5mZbxt2syKM1o57wSW5VSi4M2
         Nxx2OK41Y/FCTelO1720lbAkOtVFk0CyjYIgLJYhNnTNx0K+osdUZB7Gvkw9wIYJUbi/
         5ArC9eA4YkBfI/rKoHeOy8K4FU7EnByCuBbq6Yx2eF7TB95xUdKJS5ao5POfCfYhUwGQ
         ACgmP3XSEWkPnbnGFX7TmvsLpeAxIDG8miQzLhGWROEPTg3kVzVbMF1f+5hnmYXH4o12
         +qCgSDfQOIU6AOMER/kvIYiIP9M82B9015oITc5FyBhK2H4oRjlRdFgds4URUDGLGGWi
         jifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925962; x=1769530762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnU6wvo/eukSL1UUkOOfW8Bq0esgoFWYEdwYnwASYLM=;
        b=GjWqw+3JcIUWUf7z+YRXYOT+Ajq3nkfp5wSGh+1EwzRSHmmk9Iv7LIdk6yrkgHAJQK
         pwDhlcyX+DupRZwkkfpZpZeeCs1nk7TOdtgw6lKl7Y56756vte4uF4dTgvgc9Y/s4Nae
         03GZ7hn/2iZx5/QeI1er5sj4ihuBnLHJusHNmXPE5OSIzE3S1zfJT5cdjWRg2/lhuAnG
         JjrhWlAJxV+t8+qRf5LB9rCJ9ZXkU9QvV/dRn7ypI7Ev993OJ1FnV60NKxxtnV0mS1v1
         ipu4zIKK+vdJT2myWuMDbVWg4LRz0INroESMgy/n2g9bEhrjnE1wVi5Ar49kgz8FLVH0
         vykA==
X-Gm-Message-State: AOJu0YwXdavzsWslForjdu2A/iJtSUHtLuPS0EAS3gTa8ItuQorHOI66
	56t5JPRrjOriF5wLiNuQaltgR3xUlyWRb6GhAjrc4tU52W2+X3WKQO6qlXtlihr0
X-Gm-Gg: AZuq6aLFnsqcxbrFpYJFEp1ZdX/Di193AQxtvV4fLih3X75usvUqIY4NOziym+HLG4h
	jcpO4Cu6fFzQincBkfaX07FwS2TYwkBW96BHcSE5o4Umn3Xz8H2zIaeF3y+qzqzC3hIRhs40dRr
	ziSmltPMAdgYxc0lHnUA7fOKU4XTOe4zM6wrj4Mo1gcUBovzWUonfu0mqF5DOdGHb9EjHLR0ehw
	CEb8d8k5xDLyej7N3mCzSCo7Yr2MlSCaiOB+oG+zEg9BYCO+87IrbgBL/cyh/jejBrqnlZS+js7
	JEmUS47/564K1KqSakcAQ9syhrNRcJTwud3eFkcTJYyFn8dw3GfwrvUSeOay+RlTK6JYgJ2pRvM
	GHln/XnaKDQajYI11S7VxWXTQVpeUXCIeJ7L/LSbF+EiNny5iQi/AoilmmKck8sxRzuPaCrRpUp
	t7IFDYBj3aBIi74fSP9+RtgmQFTYCyxgXvfNjb92sHyXJ90A==
X-Received: by 2002:a05:651c:221a:b0:383:5ea:e9be with SMTP id 38308e7fff4ca-385a54a1bc0mr9036821fa.32.1768925961392;
        Tue, 20 Jan 2026 08:19:21 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790d7sm40561531fa.24.2026.01.20.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:19:21 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 3/3] ipvlan: common code to handle ipv6/ipv4 address events
Date: Tue, 20 Jan 2026 19:18:36 +0300
Message-ID: <20260120161852.639238-4-skorodumov.dmitry@huawei.com>
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
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,huawei.com,fomichev.me,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251540-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 3639748DA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both IPv4 and IPv6 addr-event functions are very similar. Refactor
to use common funcitons.

Get rid of separate functions for ipvlan_addrX_event()
and check whether we are called for ipv4 or ipv6 by
looking at "notifier_block *nblock" argument

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 112 +++++++++++--------------------
 1 file changed, 41 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index dda891911ea4..88b32998ce54 100644
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
@@ -1013,13 +968,10 @@ static struct notifier_block ipvlan_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_device_event,
 };
 
-#if IS_ENABLED(CONFIG_IPV6)
 static struct notifier_block ipvlan_addr6_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr6_event,
+	.notifier_call = ipvlan_addr_event_cb,
 };
 
-#endif
-
 static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_addr_validator_event_cb,
 };
@@ -1045,6 +997,24 @@ static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
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


