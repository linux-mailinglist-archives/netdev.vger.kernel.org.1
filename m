Return-Path: <netdev+bounces-265193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIBgNuiZrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:34:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5AD22DBA5
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FC8301CCD7
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0ED3290AF;
	Sat,  7 Mar 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ33v8W2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455CF31354D
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919270; cv=none; b=Bv2NHdzSNNyM9A2/zldA15FNHgHSpTqMrBifO3b4j97Veex5Eh6NXekYx+F0qvq6PT8X4HtwrBN6SQMA+whPu2fManuCPb4IRwfClhV4bqfRZMRYpv/HdjOUJ+DfrbHGHZJjmRxrW2Qbylzf4WLJr2jfBnBnptcvQFyHzY6fT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919270; c=relaxed/simple;
	bh=ev1rdSz3lvB9Ehe8iTvbKraS2RGiLo/XPLKnB54eYC8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gQyCLDx0cMyeeJPj0sJU4cRKuhfbKA5mhiLqveWItRLB1JuXVf/jsOeRfzX10QzXmGE7gvzBJ8ImvHEWqSuv4K45yCRm34lOMgHXfObbBHqxship6ZLcBbRrlNNvgHdCjDV9OfNoppgOOCtKnIuaSDpWuyx7DChM1VrcIVMVDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ33v8W2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso90625165e9.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919266; x=1773524066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82046iM7Oim513yPDaii1gcOw4YLIILRg6SzZ4lKPKk=;
        b=WQ33v8W2JBmlZXTMmcH8snM1QkZbNOmlUVUeDsyABzeBqWw9yYc6y78uIjxrrhOH6S
         NMzeV4YEH4VwAXAleIaVwXnuIB3UuabN1Q/IzoU8P9DlcPyJ2TZpXU/xeY3pkJUv6ffm
         Ic5EL3kEPB5D5ZQeMddTqnnZo8T+Ob5YjF3JBPG47n53L7l9oQJIAJfdZ0AR/uvRJfoX
         Gpu+J988PcPy87/LDplADbMJdCyOhKdUxHRX2twYCsotJUBOlDkTRkGLHge46R6cYF3N
         sEWgzt3q3zZ9rLrO6DaQajdY6TztIBRNjKl0RluFBb+5oZZ41HZ7vdcCAXhw5N9sSwv2
         TxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919266; x=1773524066;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82046iM7Oim513yPDaii1gcOw4YLIILRg6SzZ4lKPKk=;
        b=mezXgbkToyl+3BTT/c6AONVb+0dYBqoZOOwnrAfdJ4cLOld7qXQZmN5g/XPUYPwCzU
         KAdjjZnr4V9OM5MIqqQyxl+ut2rCFH8AeHwcYK9Mx19ka+S0CURWCuCNumqO9EDjJq/P
         4N2F0Lxx/148Qir+uuxF4DIHzCBhZJDkiAzelumfTfBGJ3WlCVQUluJqs70L/2aTmWnC
         4VU8UzS7ObkIG+T6qMfPhHXHR7YegLbv2aj3/vDOAblPf+gGM8amf4SW+GQZIIWU4XRC
         9UtirU7ifHA7t1vmXjRuQ7HXeyiXF7ebbTOx4PswhmJmifWPWUS6aqUkJ2Gud1qyajnv
         gOkg==
X-Gm-Message-State: AOJu0YyU8fEhirnOlIQrxYiPrWOsGTPyn8iamMgsl6V2A3AnYUm2aJiL
	ww60GH322vkx6A58XP0LifVrtAg2Sna/NX7Wv/38nKN2UlTSUa0bjfVR
X-Gm-Gg: ATEYQzyrpdsK0myjcIDanPOAfDPhGd0hAOw9/yOoKlIW5DhdDbBeO7LFKvl/T7CU6w0
	jI8d55sqTM3zcXBV5ZO1b/yHR2Be9+yYdaicyTSp7c8KgaBGVBQe6Yzjfn+TK2CqtNHHkSPOgUM
	4Bor5zDEVxehIAuGmgv3mspNZtQtYvmM+vH+t9KZATFF696Jnq04MirtOS4pboiu17vrSQOxYYz
	XwwcFqoDkPvDQ3+ZyeMEpoZJGD2jL/uFNQQ7x6x7X33sBUanUcENjJr7dHzvWN0GA05W4ubVhxf
	/5WBrhuj21HDnmVFSDxWKg/iFRBlfiCqC/G9ooqvPRfttx+/hvclCFdm6PriAgJBJuH0gN472qP
	78QUYfzFubSGbR5z5W5saZD65Ixd3tWD72O9RuNygZaVDpJMNSsivcIgzPjw+EqGWHa1nh9Q2AQ
	3L1QGvNdc5x/cGZYo91oZKr+/4P1rwk4OCnhEiosqUuOd43IpHPmlDzfec7O7vwk0XBKSR215hB
	7LD7QTR45AjozZYCucPuHG5bCjyQwk5BEtRBIoluXcx9d5lgBMjzr0jNdTTMRrAXw==
X-Received: by 2002:a05:600c:620b:b0:483:6a8d:b2fc with SMTP id 5b1f17b1804b1-4852691c73dmr104019915e9.8.1772919266257;
        Sat, 07 Mar 2026 13:34:26 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:7f00:f48b:e818:2b17:74e3? (p200300ea8f0f7f00f48be8182b1774e3.dip0.t-ipconnect.de. [2003:ea:8f0f:7f00:f48b:e818:2b17:74e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba66sm11860646f8f.20.2026.03.07.13.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:34:25 -0800 (PST)
Message-ID: <e4366c43-ce89-43ef-b67e-8c09af3d45f7@gmail.com>
Date: Sat, 7 Mar 2026 22:34:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/5] net: phy: move remaining provider code to
 mdio_bus_provider.c
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Language: en-US
In-Reply-To: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C5AD22DBA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265193-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.854];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This moves definition of mdio_bus class and bus_type to the provider
side, what allows to make them private to libphy.
As a prerequisite MDIO statistics handling is moved to the
provider side as well.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c          | 282 ----------------------------
 drivers/net/phy/mdio_bus_provider.c | 275 +++++++++++++++++++++++++++
 drivers/net/phy/phylib-internal.h   |   3 +
 include/linux/phy.h                 |   3 -
 4 files changed, 278 insertions(+), 285 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 9fb47332602..00d0e4159e9 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -10,20 +10,14 @@
 
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/of_device.h>
-#include <linux/of_mdio.h>
 #include <linux/phy.h>
-#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -64,218 +58,6 @@ bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 }
 EXPORT_SYMBOL(mdiobus_is_registered_device);
 
-/**
- * mdiobus_release - mii_bus device release callback
- * @d: the target struct device that contains the mii_bus
- *
- * Description: called when the last reference to an mii_bus is
- * dropped, to free the underlying memory.
- */
-static void mdiobus_release(struct device *d)
-{
-	struct mii_bus *bus = to_mii_bus(d);
-
-	WARN(bus->state != MDIOBUS_RELEASED &&
-	     /* for compatibility with error handling in drivers */
-	     bus->state != MDIOBUS_ALLOCATED,
-	     "%s: not in RELEASED or ALLOCATED state\n",
-	     bus->id);
-
-	if (bus->state == MDIOBUS_RELEASED)
-		fwnode_handle_put(dev_fwnode(d));
-
-	kfree(bus);
-}
-
-struct mdio_bus_stat_attr {
-	struct device_attribute attr;
-	int address;
-	unsigned int field_offset;
-};
-
-static struct mdio_bus_stat_attr *to_sattr(struct device_attribute *attr)
-{
-	return container_of(attr, struct mdio_bus_stat_attr, attr);
-}
-
-static u64 mdio_bus_get_stat(struct mdio_bus_stats *s, unsigned int offset)
-{
-	const u64_stats_t *stats = (const void *)s + offset;
-	unsigned int start;
-	u64 val = 0;
-
-	do {
-		start = u64_stats_fetch_begin(&s->syncp);
-		val = u64_stats_read(stats);
-	} while (u64_stats_fetch_retry(&s->syncp, start));
-
-	return val;
-}
-
-static ssize_t mdio_bus_stat_field_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
-	struct mii_bus *bus = to_mii_bus(dev);
-	u64 val = 0;
-
-	if (sattr->address < 0) {
-		/* get global stats */
-		for (int i = 0; i < PHY_MAX_ADDR; i++)
-			val += mdio_bus_get_stat(&bus->stats[i],
-						 sattr->field_offset);
-	} else {
-		val = mdio_bus_get_stat(&bus->stats[sattr->address],
-					sattr->field_offset);
-	}
-
-	return sysfs_emit(buf, "%llu\n", val);
-}
-
-static ssize_t mdio_bus_device_stat_field_show(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
-{
-	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
-	struct mdio_device *mdiodev = to_mdio_device(dev);
-	struct mii_bus *bus = mdiodev->bus;
-	int addr = mdiodev->addr;
-	u64 val;
-
-	val = mdio_bus_get_stat(&bus->stats[addr], sattr->field_offset);
-
-	return sysfs_emit(buf, "%llu\n", val);
-}
-
-#define MDIO_BUS_STATS_ATTR(field)					\
-static const struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {	\
-	.attr = __ATTR(field, 0444, mdio_bus_stat_field_show, NULL),	\
-	.address = -1,							\
-	.field_offset = offsetof(struct mdio_bus_stats, field),		\
-};									\
-static const struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = { \
-	.attr = __ATTR(field, 0444, mdio_bus_device_stat_field_show, NULL), \
-	.field_offset = offsetof(struct mdio_bus_stats, field),		\
-}
-
-MDIO_BUS_STATS_ATTR(transfers);
-MDIO_BUS_STATS_ATTR(errors);
-MDIO_BUS_STATS_ATTR(writes);
-MDIO_BUS_STATS_ATTR(reads);
-
-#define MDIO_BUS_STATS_ADDR_ATTR_DECL(field, addr, file)		\
-static const struct mdio_bus_stat_attr					\
-dev_attr_mdio_bus_addr_##field##_##addr = {				\
-	.attr = { .attr = { .name = file, .mode = 0444 },		\
-		     .show = mdio_bus_stat_field_show,			\
-	},								\
-	.address = addr,						\
-	.field_offset = offsetof(struct mdio_bus_stats, field),		\
-}
-
-#define MDIO_BUS_STATS_ADDR_ATTR(field, addr)				\
-	MDIO_BUS_STATS_ADDR_ATTR_DECL(field, addr,			\
-				 __stringify(field) "_" __stringify(addr))
-
-#define MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(addr)			\
-	MDIO_BUS_STATS_ADDR_ATTR(transfers, addr);			\
-	MDIO_BUS_STATS_ADDR_ATTR(errors, addr);				\
-	MDIO_BUS_STATS_ADDR_ATTR(writes, addr);				\
-	MDIO_BUS_STATS_ADDR_ATTR(reads, addr)				\
-
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(0);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(1);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(2);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(3);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(4);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(5);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(6);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(7);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(8);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(9);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(10);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(11);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(12);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(13);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(14);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(15);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(16);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(17);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(18);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(19);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(20);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(21);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(22);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(23);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(24);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(25);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(26);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(27);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(28);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(29);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(30);
-MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(31);
-
-#define MDIO_BUS_STATS_ADDR_ATTR_GROUP(addr)				\
-	&dev_attr_mdio_bus_addr_transfers_##addr.attr.attr,		\
-	&dev_attr_mdio_bus_addr_errors_##addr.attr.attr,		\
-	&dev_attr_mdio_bus_addr_writes_##addr.attr.attr,		\
-	&dev_attr_mdio_bus_addr_reads_##addr.attr.attr			\
-
-static const struct attribute *const mdio_bus_statistics_attrs[] = {
-	&dev_attr_mdio_bus_transfers.attr.attr,
-	&dev_attr_mdio_bus_errors.attr.attr,
-	&dev_attr_mdio_bus_writes.attr.attr,
-	&dev_attr_mdio_bus_reads.attr.attr,
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(0),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(1),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(2),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(3),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(4),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(5),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(6),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(7),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(8),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(9),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(10),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(11),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(12),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(13),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(14),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(15),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(16),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(17),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(18),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(19),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(20),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(21),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(22),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(23),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(24),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(25),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(26),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(27),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(28),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(29),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(30),
-	MDIO_BUS_STATS_ADDR_ATTR_GROUP(31),
-	NULL,
-};
-
-static const struct attribute_group mdio_bus_statistics_group = {
-	.name		= "statistics",
-	.attrs_const	= mdio_bus_statistics_attrs,
-};
-__ATTRIBUTE_GROUPS(mdio_bus_statistics);
-
-const struct class mdio_bus_class = {
-	.name		= "mdio_bus",
-	.dev_release	= mdiobus_release,
-	.dev_groups	= mdio_bus_statistics_groups,
-};
-EXPORT_SYMBOL_GPL(mdio_bus_class);
-
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
 	preempt_disable();
@@ -841,69 +623,5 @@ int mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
 }
 EXPORT_SYMBOL_GPL(mdiobus_c45_modify_changed);
 
-/**
- * mdio_bus_match - determine if given MDIO driver supports the given
- *		    MDIO device
- * @dev: target MDIO device
- * @drv: given MDIO driver
- *
- * Return: 1 if the driver supports the device, 0 otherwise
- *
- * Description: This may require calling the devices own match function,
- *   since different classes of MDIO devices have different match criteria.
- */
-static int mdio_bus_match(struct device *dev, const struct device_driver *drv)
-{
-	const struct mdio_driver *mdiodrv = to_mdio_driver(drv);
-	struct mdio_device *mdio = to_mdio_device(dev);
-
-	/* Both the driver and device must type-match */
-	if (!(mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY) !=
-	    !(mdio->flags & MDIO_DEVICE_FLAG_PHY))
-		return 0;
-
-	if (of_driver_match_device(dev, drv))
-		return 1;
-
-	if (mdio->bus_match)
-		return mdio->bus_match(dev, drv);
-
-	return 0;
-}
-
-static int mdio_uevent(const struct device *dev, struct kobj_uevent_env *env)
-{
-	int rc;
-
-	/* Some devices have extra OF data and an OF-style MODALIAS */
-	rc = of_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
-	return 0;
-}
-
-static const struct attribute *const mdio_bus_device_statistics_attrs[] = {
-	&dev_attr_mdio_bus_device_transfers.attr.attr,
-	&dev_attr_mdio_bus_device_errors.attr.attr,
-	&dev_attr_mdio_bus_device_writes.attr.attr,
-	&dev_attr_mdio_bus_device_reads.attr.attr,
-	NULL,
-};
-
-static const struct attribute_group mdio_bus_device_statistics_group = {
-	.name		= "statistics",
-	.attrs_const	= mdio_bus_device_statistics_attrs,
-};
-__ATTRIBUTE_GROUPS(mdio_bus_device_statistics);
-
-const struct bus_type mdio_bus_type = {
-	.name		= "mdio_bus",
-	.dev_groups	= mdio_bus_device_statistics_groups,
-	.match		= mdio_bus_match,
-	.uevent		= mdio_uevent,
-};
-EXPORT_SYMBOL(mdio_bus_type);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MDIO bus/device layer");
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index d50fe6eb4b0..bc0f10ba150 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -28,6 +28,281 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
+#include "phylib-internal.h"
+
+/**
+ * mdiobus_release - mii_bus device release callback
+ * @d: the target struct device that contains the mii_bus
+ *
+ * Description: called when the last reference to an mii_bus is
+ * dropped, to free the underlying memory.
+ */
+static void mdiobus_release(struct device *d)
+{
+	struct mii_bus *bus = to_mii_bus(d);
+
+	WARN(bus->state != MDIOBUS_RELEASED &&
+	     /* for compatibility with error handling in drivers */
+	     bus->state != MDIOBUS_ALLOCATED,
+	     "%s: not in RELEASED or ALLOCATED state\n",
+	     bus->id);
+
+	if (bus->state == MDIOBUS_RELEASED)
+		fwnode_handle_put(dev_fwnode(d));
+
+	kfree(bus);
+}
+
+struct mdio_bus_stat_attr {
+	struct device_attribute attr;
+	int address;
+	unsigned int field_offset;
+};
+
+static struct mdio_bus_stat_attr *to_sattr(struct device_attribute *attr)
+{
+	return container_of(attr, struct mdio_bus_stat_attr, attr);
+}
+
+static u64 mdio_bus_get_stat(struct mdio_bus_stats *s, unsigned int offset)
+{
+	const u64_stats_t *stats = (const void *)s + offset;
+	unsigned int start;
+	u64 val = 0;
+
+	do {
+		start = u64_stats_fetch_begin(&s->syncp);
+		val = u64_stats_read(stats);
+	} while (u64_stats_fetch_retry(&s->syncp, start));
+
+	return val;
+}
+
+static ssize_t mdio_bus_stat_field_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
+	struct mii_bus *bus = to_mii_bus(dev);
+	u64 val = 0;
+
+	if (sattr->address < 0) {
+		/* get global stats */
+		for (int i = 0; i < PHY_MAX_ADDR; i++)
+			val += mdio_bus_get_stat(&bus->stats[i],
+						 sattr->field_offset);
+	} else {
+		val = mdio_bus_get_stat(&bus->stats[sattr->address],
+					sattr->field_offset);
+	}
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t mdio_bus_device_stat_field_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct mdio_bus_stat_attr *sattr = to_sattr(attr);
+	struct mdio_device *mdiodev = to_mdio_device(dev);
+	struct mii_bus *bus = mdiodev->bus;
+	int addr = mdiodev->addr;
+	u64 val;
+
+	val = mdio_bus_get_stat(&bus->stats[addr], sattr->field_offset);
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+#define MDIO_BUS_STATS_ATTR(field)					\
+static const struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {	\
+	.attr = __ATTR(field, 0444, mdio_bus_stat_field_show, NULL),	\
+	.address = -1,							\
+	.field_offset = offsetof(struct mdio_bus_stats, field),		\
+};									\
+static const struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = { \
+	.attr = __ATTR(field, 0444, mdio_bus_device_stat_field_show, NULL), \
+	.field_offset = offsetof(struct mdio_bus_stats, field),		\
+}
+
+MDIO_BUS_STATS_ATTR(transfers);
+MDIO_BUS_STATS_ATTR(errors);
+MDIO_BUS_STATS_ATTR(writes);
+MDIO_BUS_STATS_ATTR(reads);
+
+#define MDIO_BUS_STATS_ADDR_ATTR_DECL(field, addr, file)		\
+static const struct mdio_bus_stat_attr					\
+dev_attr_mdio_bus_addr_##field##_##addr = {				\
+	.attr = { .attr = { .name = file, .mode = 0444 },		\
+		     .show = mdio_bus_stat_field_show,			\
+	},								\
+	.address = addr,						\
+	.field_offset = offsetof(struct mdio_bus_stats, field),		\
+}
+
+#define MDIO_BUS_STATS_ADDR_ATTR(field, addr)				\
+	MDIO_BUS_STATS_ADDR_ATTR_DECL(field, addr,			\
+				 __stringify(field) "_" __stringify(addr))
+
+#define MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(addr)			\
+	MDIO_BUS_STATS_ADDR_ATTR(transfers, addr);			\
+	MDIO_BUS_STATS_ADDR_ATTR(errors, addr);				\
+	MDIO_BUS_STATS_ADDR_ATTR(writes, addr);				\
+	MDIO_BUS_STATS_ADDR_ATTR(reads, addr)				\
+
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(0);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(1);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(2);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(3);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(4);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(5);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(6);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(7);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(8);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(9);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(10);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(11);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(12);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(13);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(14);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(15);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(16);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(17);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(18);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(19);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(20);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(21);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(22);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(23);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(24);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(25);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(26);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(27);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(28);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(29);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(30);
+MDIO_BUS_STATS_ADDR_ATTR_GROUP_DECL(31);
+
+#define MDIO_BUS_STATS_ADDR_ATTR_GROUP(addr)				\
+	&dev_attr_mdio_bus_addr_transfers_##addr.attr.attr,		\
+	&dev_attr_mdio_bus_addr_errors_##addr.attr.attr,		\
+	&dev_attr_mdio_bus_addr_writes_##addr.attr.attr,		\
+	&dev_attr_mdio_bus_addr_reads_##addr.attr.attr			\
+
+static const struct attribute *const mdio_bus_statistics_attrs[] = {
+	&dev_attr_mdio_bus_transfers.attr.attr,
+	&dev_attr_mdio_bus_errors.attr.attr,
+	&dev_attr_mdio_bus_writes.attr.attr,
+	&dev_attr_mdio_bus_reads.attr.attr,
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(0),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(1),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(2),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(3),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(4),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(5),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(6),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(7),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(8),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(9),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(10),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(11),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(12),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(13),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(14),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(15),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(16),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(17),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(18),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(19),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(20),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(21),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(22),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(23),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(24),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(25),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(26),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(27),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(28),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(29),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(30),
+	MDIO_BUS_STATS_ADDR_ATTR_GROUP(31),
+	NULL,
+};
+
+static const struct attribute_group mdio_bus_statistics_group = {
+	.name		= "statistics",
+	.attrs_const	= mdio_bus_statistics_attrs,
+};
+__ATTRIBUTE_GROUPS(mdio_bus_statistics);
+
+const struct class mdio_bus_class = {
+	.name		= "mdio_bus",
+	.dev_release	= mdiobus_release,
+	.dev_groups	= mdio_bus_statistics_groups,
+};
+
+/**
+ * mdio_bus_match - determine if given MDIO driver supports the given
+ *		    MDIO device
+ * @dev: target MDIO device
+ * @drv: given MDIO driver
+ *
+ * Return: 1 if the driver supports the device, 0 otherwise
+ *
+ * Description: This may require calling the devices own match function,
+ *   since different classes of MDIO devices have different match criteria.
+ */
+static int mdio_bus_match(struct device *dev, const struct device_driver *drv)
+{
+	const struct mdio_driver *mdiodrv = to_mdio_driver(drv);
+	struct mdio_device *mdio = to_mdio_device(dev);
+
+	/* Both the driver and device must type-match */
+	if (!(mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY) !=
+	    !(mdio->flags & MDIO_DEVICE_FLAG_PHY))
+		return 0;
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (mdio->bus_match)
+		return mdio->bus_match(dev, drv);
+
+	return 0;
+}
+
+static int mdio_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	int rc;
+
+	/* Some devices have extra OF data and an OF-style MODALIAS */
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	return 0;
+}
+
+static const struct attribute *const mdio_bus_device_statistics_attrs[] = {
+	&dev_attr_mdio_bus_device_transfers.attr.attr,
+	&dev_attr_mdio_bus_device_errors.attr.attr,
+	&dev_attr_mdio_bus_device_writes.attr.attr,
+	&dev_attr_mdio_bus_device_reads.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mdio_bus_device_statistics_group = {
+	.name		= "statistics",
+	.attrs_const	= mdio_bus_device_statistics_attrs,
+};
+__ATTRIBUTE_GROUPS(mdio_bus_device_statistics);
+
+const struct bus_type mdio_bus_type = {
+	.name		= "mdio_bus",
+	.dev_groups	= mdio_bus_device_statistics_groups,
+	.match		= mdio_bus_match,
+	.uevent		= mdio_uevent,
+};
 
 /**
  * mdiobus_alloc_size - allocate a mii_bus structure
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index bfb1aa82386..664ed7faa51 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -9,6 +9,9 @@
 struct mdio_device;
 struct phy_device;
 
+extern const struct bus_type mdio_bus_type;
+extern const struct class mdio_bus_class;
+
 /*
  * phy_supported_speeds - return all speeds currently supported by a PHY device
  */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e9b0d7427b0..5de4b172cd0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2446,9 +2446,6 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 
 struct phy_port *phy_get_sfp_port(struct phy_device *phydev);
 
-extern const struct bus_type mdio_bus_type;
-extern const struct class mdio_bus_class;
-
 /**
  * phy_module_driver() - Helper macro for registering PHY drivers
  * @__phy_drivers: array of PHY drivers to register
-- 
2.53.0



