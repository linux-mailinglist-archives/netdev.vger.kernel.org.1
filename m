Return-Path: <netdev+bounces-265656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM1kBA//rmkLLgIAu9opvQ
	(envelope-from <netdev+bounces-265656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC4D23D69F
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EEE312E508
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF612D0610;
	Mon,  9 Mar 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inLTl2t0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D32BEFF5
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075855; cv=none; b=LM1uv12BYgxokg4gAQxycsVpHDY6XO2nMI8laFc9yqVvYcGc22X4YRbr7ohAqayXDSob+63sqpEErJtm4rsimJvnkvB28l7MXEz374h0inNEg9jZf/zVqEQfodhQCUvDZSJbYu+/2dujOSGwcDd8uAtZA2rflgSG0iSDm1QrSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075855; c=relaxed/simple;
	bh=IalBsRFpE5x5/xFaVHrbb4x+6gUF1qCnEMvJ6Qfnoas=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uwBzFd0Pieh1k7af7T+HW+AhuEu5oslp9ejjivAJm6lv+yYZi8ztsl9vP6UJaBWnF++NBvyj8PnHDaAwMH+gkAX5rc6UCV4vJCwODXVWajGrLn5jqermhhpsegdN2IXAxpJHWmPawqq70gckvTrODghXCtw5Njfc4VMioCoZCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inLTl2t0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b9b190easo5661143f8f.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075850; x=1773680650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pR5q5r3Mes7TJAyUzECgg8kfuz01nC9/URwKM/qNQHw=;
        b=inLTl2t0adVHlFsNLFOyYc6KwwSqajwuQr5apUbnnM9ZpgpjSXeSpDUF2+7CC2KBsO
         Q0mKWCcFWlNPyALGIfoCm15bMgrliDvbqH3ZlJRbquSinVlPiRn6O9wEuwm/fF2wz/3i
         5rXZTJkBy6fFXQensOsSDqx/yhrlG7kaFI5kFcw57dPcBudTD/guE/4vw7weMjKLD2SS
         cn1uregf8biES+SB2Y2/GZZVPU4oKrtHDOvc9Z+BJbIeSqv1E7lr2nW1sXShkM6IhWVK
         ux5KOu3gBPIoPtJ72bwXr2sMNYOiKaDEvjD0Wts27QEfCq6XnkbUJKqxx7V5wOiUK9Mb
         PtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075850; x=1773680650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR5q5r3Mes7TJAyUzECgg8kfuz01nC9/URwKM/qNQHw=;
        b=l2OcdboPGnp78cja+2ZvyMN/i5BXaCRkP+qCd+m9yLBmy4WQAHTKIfdQQ2dD558CSM
         w67LPbumWQDBUaSq3LRBjVxZJKPK4ATzWipzxMSKywkadftP5B+hXHUF5/Xj4ZpFx44S
         gDZrGcza9j5HDwGaw4NZY0qlCIMRfrtghkMTt8adF6JTG/WpNyBRRp2tAAjdr8N2pvvn
         KxWZFAsyJ+GOfpivmohGHzxpD2GGRfPUio2AeDSh3u2w+BajlQPQcH6udD6w6w4h2oGa
         Wq/Xy0atYL4LZ5NcnFt20RSukDJ5TwL4sx8qD/Xe4cQ5fX57OVeNOhmhenYI58bAkTni
         xbbA==
X-Gm-Message-State: AOJu0Yw+D07P9whRSaPqh0h4fvvP+Ph7eSfxKess2nKmhZwcGALWXbt5
	8A0XHgMfk7paBsNPa4etGG5c6/ONKPpSddBKQoDo0VA/1FiMhTjprphK
X-Gm-Gg: ATEYQzxDKUXRuUZRR7vdMpzJK6m+wzXAmQd1Fzssik4suufYoZ3EDMpa3IDnyPXHkNy
	WNBqsrePKEb8GG1hNVZef5cNEMd6AJBDvTIXip/zSQFvGzBrGDVXM/vYgWYfo1rYE1g5lU0VePz
	bJBfxWCzSIs5fKwSEPwhO+6X3M2/pQZYCERIdHj3RXn4uEpnf9FZPllQbKuIAJ9+zbcZO6PHiHK
	bTmGOys2B0rVK5JuOpF4tQzUE1sF5ZwbC9Ms7b79CShvXDqchBNxLDafQyeN6zxOVJeNJqMNRBU
	EfxqCZS9bXvbp378z2ez1NKrNnKDhzLAAz/HwRSqRXpvLZZCSprZxyoKw5qlR1nW5LnN6vgNA8d
	Xf29tbqLdHTsmLnIEieWBC5llaMG4MPV9XJOIJ8pS7RBdCKccew9pFQHNtGa5g3cNcSaCDlSt+5
	0yWRJuTbsU2pBNsetJF4WNZIXBF2n19uqDIXq5CipQeLy4wizyxqLi/oXuJ3DR/wbC83bzEH/ra
	kzpXP5xr7KDLO3S1kLEi7u1K85pfRPUlfrOLa5qu/Dh8MJ2h+ZYZFeOP3VKlcg=
X-Received: by 2002:a05:6000:2482:b0:439:ad2d:99f1 with SMTP id ffacd0b85a97d-439da86ed01mr19072989f8f.54.1773075849398;
        Mon, 09 Mar 2026 10:04:09 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d? (p200300ea8f46ce0005f97f3c5f9a2a3d.dip0.t-ipconnect.de. [2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm26937481f8f.6.2026.03.09.10.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:04:09 -0700 (PDT)
Message-ID: <b6161c64-68ac-4524-82ec-5b7d81b86dbc@gmail.com>
Date: Mon, 9 Mar 2026 18:04:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 3/5] net: phy: move (of_)mdio_find_bus to
 mdio_bus_provider.c
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Content-Language: en-US
In-Reply-To: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFC4D23D69F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Functionality outside libphy shouldn't access mdio_bus_class directly.
So move both functions to the provider side. This is a step towards
making mdio_bus_class private to libphy.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c          | 44 -----------------------------
 drivers/net/phy/mdio_bus_provider.c | 44 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a30c679feec..c9a495390d2 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -276,50 +276,6 @@ const struct class mdio_bus_class = {
 };
 EXPORT_SYMBOL_GPL(mdio_bus_class);
 
-/**
- * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
- * @mdio_name: The name of a mdiobus.
- *
- * Return: a reference to the mii_bus, or NULL if none found. The
- * embedded struct device will have its reference count incremented,
- * and this must be put_deviced'ed once the bus is finished with.
- */
-struct mii_bus *mdio_find_bus(const char *mdio_name)
-{
-	struct device *d;
-
-	d = class_find_device_by_name(&mdio_bus_class, mdio_name);
-	return d ? to_mii_bus(d) : NULL;
-}
-EXPORT_SYMBOL(mdio_find_bus);
-
-#if IS_ENABLED(CONFIG_OF_MDIO)
-/**
- * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
- * @mdio_bus_np: Pointer to the mii_bus.
- *
- * Return: a reference to the mii_bus, or NULL if none found. The
- * embedded struct device will have its reference count incremented,
- * and this must be put once the bus is finished with.
- *
- * Because the association of a device_node and mii_bus is made via
- * of_mdiobus_register(), the mii_bus cannot be found before it is
- * registered with of_mdiobus_register().
- *
- */
-struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
-{
-	struct device *d;
-
-	if (!mdio_bus_np)
-		return NULL;
-
-	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
-	return d ? to_mii_bus(d) : NULL;
-}
-EXPORT_SYMBOL(of_mdio_find_bus);
-#endif
-
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
 	preempt_disable();
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 4b063740574..d50fe6eb4b0 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -440,3 +440,47 @@ void mdiobus_free(struct mii_bus *bus)
 	put_device(&bus->dev);
 }
 EXPORT_SYMBOL(mdiobus_free);
+
+/**
+ * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
+ * @mdio_name: The name of a mdiobus.
+ *
+ * Return: a reference to the mii_bus, or NULL if none found. The
+ * embedded struct device will have its reference count incremented,
+ * and this must be put_deviced'ed once the bus is finished with.
+ */
+struct mii_bus *mdio_find_bus(const char *mdio_name)
+{
+	struct device *d;
+
+	d = class_find_device_by_name(&mdio_bus_class, mdio_name);
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(mdio_find_bus);
+
+#if IS_ENABLED(CONFIG_OF_MDIO)
+/**
+ * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
+ * @mdio_bus_np: Pointer to the mii_bus.
+ *
+ * Return: a reference to the mii_bus, or NULL if none found. The
+ * embedded struct device will have its reference count incremented,
+ * and this must be put once the bus is finished with.
+ *
+ * Because the association of a device_node and mii_bus is made via
+ * of_mdiobus_register(), the mii_bus cannot be found before it is
+ * registered with of_mdiobus_register().
+ *
+ */
+struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
+{
+	struct device *d;
+
+	if (!mdio_bus_np)
+		return NULL;
+
+	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
+	return d ? to_mii_bus(d) : NULL;
+}
+EXPORT_SYMBOL(of_mdio_find_bus);
+#endif
-- 
2.53.0



