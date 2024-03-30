Return-Path: <netdev+bounces-83526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D5892C8C
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC01B21746
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001E41C7A;
	Sat, 30 Mar 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ch8qUCXF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5641206
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823563; cv=none; b=lpFshnFIhu2IcjCGDmRXW9KBItuLRdzsrA0uyY4Fw1F+g2z8Wy6DF2/kmEZUtHoUIdd+K3wrPpmskMJtxhYOawyXbK6b/2lBfwXc2EoBU+pRjAEGvzaym2UmWPFtBTif4ec5X8MKOj0CdsEeHGCcHUcYl+3YgXx3kczvR9TTrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823563; c=relaxed/simple;
	bh=jN06A6RN74/A9JG07iAr7h9U1L7CPt7cjU7nOZyzbGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utgvc4DYiPAHWwdU7ocpgikYotrhtfeJYF1neCpKvC1u3ZgkjbezUFUhAf2kGCdd6KuQOKzX79B94hz4ARwv53b9mcXDjZi1cMbSHCQLK1XaWyq/1dR/XQuVNRlWK2himthYs038qHWB7H8jbnt17wqv7bCcB67vTtmGa6w8jGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ch8qUCXF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jQR7P1Q5Se8GixNYzr/FafPy3P2nvqlYT8DftTiAOhc=; b=ch
	8qUCXFhoBFmLhDZPqiJMb/UJdXj9sW9lje8UPMFrZm/MOcQVKAoYmzSFqWFT1vEY4hUomlT3fpb0I
	IWqyS6zJBxaCRoU41zVmBgrRxhk552l6f1RK/4K22cyfYqpf9wcL9FLBk1NVDefrvtrqC5KrvtC7P
	aoHU7DurLs3074M=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqdVN-00Bjfq-V1; Sat, 30 Mar 2024 19:32:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Mar 2024 13:32:02 -0500
Subject: [PATCH net-next v2 5/7] net: dsa: Add helpers to convert netdev to
 ds or port index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-5-fc5beb9febc5@lunn.ch>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=jN06A6RN74/A9JG07iAr7h9U1L7CPt7cjU7nOZyzbGA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCFq2Td1WHwr0XPpsQqH/Q8FknzI1G9ClIu8Ge
 AmV7LKNVPKJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZghatgAKCRDmvw3LpmlM
 hJ5sD/9BHQlhCcOy4vq/D4PlCc35t/nm75n/KmG78VNVkaMLVpnBdt4H84QdHHZaevGYGk6wTWM
 s/LB9teZvc2jydMcMwa/1nd8Dk2ZmFy56RAgiVzPOaZ733WY8t0eOZ2QdmiM7oslDYA9YZMERjH
 8UB5r9HUoP19pQHY6jLcKDzu5hmCliOjpYTlHYRbZCEM+N0QSJ0R9JR8Q2dQgv7h0goySQP0N97
 /EJkI/LssuDFsxoN9oQkMLIKZ9RIirJCte+dlpQRQXJHLGocOXhpzu1iHJDzB0BJ2vgZtexGhvP
 FTy2m80JQxDg0gsNuYn7LDYcPyaTPDXz2gJeJH50RyvFvEf2Y4HhzY6yVc2Gq5NNKWXMvOZjg2l
 BGm6mStIHa+aA1r6gebfwxuLAOzTK10fh9+m36Z/tIuxwCv8lPPvfbtNZ0oWdCPm8vBfKJnTwLT
 A5SACgpGQdvDedQAaxc/ONVZaZYX8ASjTi2bbvjM9thZaxGJey0sh2w4F7CkIOBaSVjUslLcSuT
 LhLOvbX89I8fkRTRY/iZ+r0dxog1OwN9lna/q4TW6ZaA/hj5ZX/1mNM2BPjnJfhoHG3LSMh/M76
 AoKaQFXDZydIRgO9ARKUyycpVoNgY6TBDuuvjihtMsKkCzGlfCZQHML6C9VWYCHWChjDTnEsjz/
 eJ8LoJHNonDVDHA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The LED helpers make use of a struct netdev. Add helpers a DSA driver
can use to convert a netdev to a struct dsa_switch and the port index.

To do this, dsa_user_to_port() has to be made available out side of
net/dev, to convert the inline function in net/dsa/user.h into a
normal function, and export it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/dsa.h | 17 +++++++++++++++++
 net/dsa/user.c    |  8 ++++++++
 net/dsa/user.h    |  7 -------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..1fbfada6678d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1359,6 +1359,23 @@ int dsa_register_switch(struct dsa_switch *ds);
 void dsa_switch_shutdown(struct dsa_switch *ds);
 struct dsa_switch *dsa_switch_find(int tree_index, int sw_index);
 void dsa_flush_workqueue(void);
+
+struct dsa_port *dsa_user_to_port(const struct net_device *dev);
+
+static inline struct dsa_switch *dsa_user_to_ds(const struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+
+	return dp->ds;
+}
+
+static inline unsigned int dsa_user_to_index(const struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+
+	return dp->index;
+}
+
 #ifdef CONFIG_PM_SLEEP
 int dsa_switch_suspend(struct dsa_switch *ds);
 int dsa_switch_resume(struct dsa_switch *ds);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 16d395bb1a1f..bbee3f63e2c7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3699,3 +3699,11 @@ void dsa_user_unregister_notifier(void)
 	if (err)
 		pr_err("DSA: failed to unregister user notifier (%d)\n", err);
 }
+
+struct dsa_port *dsa_user_to_port(const struct net_device *dev)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+
+	return p->dp;
+}
+EXPORT_SYMBOL_GPL(dsa_user_to_port);
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 996069130bea..b6bcf027643e 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -51,13 +51,6 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 int dsa_user_manage_vlan_filtering(struct net_device *dev,
 				   bool vlan_filtering);
 
-static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
-{
-	struct dsa_user_priv *p = netdev_priv(dev);
-
-	return p->dp;
-}
-
 static inline struct net_device *
 dsa_user_to_conduit(const struct net_device *dev)
 {

-- 
2.43.0


