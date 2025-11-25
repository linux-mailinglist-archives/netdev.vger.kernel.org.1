Return-Path: <netdev+bounces-241430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9EBC83CD6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D603B04B9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B72DE71A;
	Tue, 25 Nov 2025 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMjOlD5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18222DC33F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057134; cv=none; b=p+SJkP7FVIM/8+wLlLs2eTcxmzhI8puS5RWN3WR396dBFdKakGbhtAhaNnnFlepmHOp8NTqknMABPNMj4Q5VFn8+L2Wrmmf5PI+BmX8VFJG98gQg5bfdt9LKG/Sf3gLraMHyAgbfYZpururn4cwc43uj4jAonTOt1q2I5OSbmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057134; c=relaxed/simple;
	bh=2IDfTgVRfPVoxOoroR4XS8Qg2cGhPJ/8dpwLu49CnJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH+uc2OUoi/zbLkvZD0JB4oN8xtfOx4UVD2D3/s5NxnNjQxWE6oPbieIaRHu3oEJmhJKxOOVMNPbpMY7vFiscQULYwV9847fr3Psay8gT3rLgMEsHergpzxn3ouXStF/yVgjZTewq3UuzzNHAs0VYp8r8fQcJWMlzZ828Rv5JlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMjOlD5l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324204so888515066b.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057130; x=1764661930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYHFwdbxRLbygb/fCHFJ4ddI34Qtby7k1kfsMle3SjE=;
        b=HMjOlD5liIIhpq1k6sAlAjUt07FJxtc1fMQ4s5Cc+yeZkvgr3GAstxp9flCSJGMvP3
         3RMxhgc/cYXCQFRVFuZHXc2wSmZjjEvPvOAYc5Gbb3rWKf7CGat6nOyjoV01xPu/XF4t
         wocjlP8lEQcC7u/dpJI8LAO64/takx4w/1mgr21mCpMvb4A3KZSOzZMY9ZMsYzk7UmjY
         8kscpyhvEdohOfOlEtvqLGZYljxgL3nr62g/EVZOxJJm8+7QyljReW4BVqhKXqtRRKx/
         giFmWVuQKNABXGNBs7fKDzTcyCWTZouN4cgJcpU5KukuRLxlE16wrkM8//J+8GjZR3Lc
         RX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057130; x=1764661930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYHFwdbxRLbygb/fCHFJ4ddI34Qtby7k1kfsMle3SjE=;
        b=TWR6ltnIc860aKX+eMAKKOjj3cpqRp4q/bRnGVFV7W9HfNW4vGV9sOu4Hr7YK85BmP
         0zSXVqxqI6P/cjGSHzjqSxsoY7fnA+ovQd97Y6icg1ZWJKjdU7xj7TfTgz8+4ztQ6Pc5
         MJhigNZ4VV8s66Lu4DtG3W7esdDWDFB0uj8YkTJWjR6Tu8CcY1XPcCwKsyf5+5Lg9Rd9
         F4uJeTa16+H94EkjKAT813K8oGKD1nhwaMf2AWsiCdJ2kypAbJ40XLDeZq6YSDh+Kr5U
         XzfxCZa+zkDn28fCZkM9h5qlLG7OU/Gx/YuwHNse7xPfTGyrgzIudelTOfTxVn1Mv8aE
         nQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx4v5eDFYRSHWW0N04W/VExYiZVspVUEyGL5vcbnTHcL2cnT/lRrGQgXHEDI1NBG08iBI0C88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFStMy4ZEjbjpDaxnbmhW/3qD9K9YdPmf5Uzf25d4ZAGiPJthT
	q90H6iWuK6vctWFSggTGD2tVWJVL1FicOtgxMmoMTbHad55iZaKw1Cj6
X-Gm-Gg: ASbGnctjnahXmn6l37zLENJMzZzIDoH/WlFtQM3OahyudapoWMMZ7pBBCblXSzyNnPJ
	F1dYog1rUqRat0Se3cdU9fZCWy5Oo6wD9ps8k3AI6NOVbaPzvhzo27luviAlsuxkN670CAnj9mO
	zN1AnqLVGBUXcKxc6M9mIyTgzmHllXN7RQv+UEowYIq+LxWFReHETHSSg6RW5D9Z3xhzohU1axs
	JE3R1fI2PH3Fm4RdwbYOuwlph812XQG1j34+SafwEMA0ODNahqqSppeKrGcDVBElaMHDvNnzRu3
	LMeIwmPJhlEmW13B/Mg59EE3k45upESb+08K6Q/o2dpw7bTjQ/HEB67vI9oheDCo+d2hkJXJC+9
	xvZHy5nfBsohxmUWR7mNCp0ogrw8Fon8m3KOwsL/KbHo47Slij/ivc0vkLMldNIwP1Ch4K3JDI9
	xJEt3Tl6baycaIvdLzWLFYJZBc3FOLRDITUZ3wS46Qqivmte52ZPeJO+iI6yMayAwmC9Y=
X-Google-Smtp-Source: AGHT+IFdle32TRioESDmWF/xcaCqK6QYh9FTiqmxWzVBB3FON2HCO36Ge3caO0vVpXHNG1vPejD/rw==
X-Received: by 2002:a17:907:97d1:b0:b76:4010:a890 with SMTP id a640c23a62f3a-b76c550b652mr177846666b.31.1764057129980;
        Mon, 24 Nov 2025 23:52:09 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5ebsm1533132266b.14.2025.11.24.23.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:09 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/7] net: dsa: b53: allow VID 0 for BCM5325/65
Date: Tue, 25 Nov 2025 08:51:50 +0100
Message-ID: <20251125075150.13879-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125075150.13879-1-jonas.gorski@gmail.com>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that writing ARL entries works properly, we can actually use VID 0
as the default untagged VLAN for BCM5325 and BCM5365 as well, so use 0
as default PVID always.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 49 +++++++++++---------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index ac995f36ed95..4eff64204897 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -870,14 +870,6 @@ static void b53_enable_stp(struct b53_device *dev)
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
 }
 
-static u16 b53_default_pvid(struct b53_device *dev)
-{
-	if (is5325(dev) || is5365(dev))
-		return 1;
-	else
-		return 0;
-}
-
 static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
@@ -906,14 +898,12 @@ int b53_configure_vlan(struct dsa_switch *ds)
 	struct b53_device *dev = ds->priv;
 	struct b53_vlan vl = { 0 };
 	struct b53_vlan *v;
-	int i, def_vid;
 	u16 vid;
-
-	def_vid = b53_default_pvid(dev);
+	int i;
 
 	/* clear all vlan entries */
 	if (is5325(dev) || is5365(dev)) {
-		for (i = def_vid; i < dev->num_vlans; i++)
+		for (i = 0; i < dev->num_vlans; i++)
 			b53_set_vlan_entry(dev, i, &vl);
 	} else {
 		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
@@ -927,7 +917,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
 	 * entry. Do this only when the tagging protocol is not
 	 * DSA_TAG_PROTO_NONE
 	 */
-	v = &dev->vlans[def_vid];
+	v = &dev->vlans[0];
 	b53_for_each_port(dev, i) {
 		if (!b53_vlan_port_may_join_untagged(ds, i))
 			continue;
@@ -935,16 +925,15 @@ int b53_configure_vlan(struct dsa_switch *ds)
 		vl.members |= BIT(i);
 		if (!b53_vlan_port_needs_forced_tagged(ds, i))
 			vl.untag = vl.members;
-		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
-			    def_vid);
+		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i), 0);
 	}
-	b53_set_vlan_entry(dev, def_vid, &vl);
+	b53_set_vlan_entry(dev, 0, &vl);
 
 	if (dev->vlan_filtering) {
 		/* Upon initial call we have not set-up any VLANs, but upon
 		 * system resume, we need to restore all VLAN entries.
 		 */
-		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
+		for (vid = 1; vid < dev->num_vlans; vid++) {
 			v = &dev->vlans[vid];
 
 			if (!v->members)
@@ -1280,7 +1269,6 @@ static int b53_setup(struct dsa_switch *ds)
 	struct b53_device *dev = ds->priv;
 	struct b53_vlan *vl;
 	unsigned int port;
-	u16 pvid;
 	int ret;
 
 	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
@@ -1310,8 +1298,7 @@ static int b53_setup(struct dsa_switch *ds)
 	}
 
 	/* setup default vlan for filtering mode */
-	pvid = b53_default_pvid(dev);
-	vl = &dev->vlans[pvid];
+	vl = &dev->vlans[0];
 	b53_for_each_port(dev, port) {
 		vl->members |= BIT(port);
 		if (!b53_vlan_port_needs_forced_tagged(ds, port))
@@ -1740,7 +1727,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (pvid)
 		new_pvid = vlan->vid;
 	else if (!pvid && vlan->vid == old_pvid)
-		new_pvid = b53_default_pvid(dev);
+		new_pvid = 0;
 	else
 		new_pvid = old_pvid;
 	dev->ports[port].pvid = new_pvid;
@@ -1790,7 +1777,7 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	vl->members &= ~BIT(port);
 
 	if (pvid == vlan->vid)
-		pvid = b53_default_pvid(dev);
+		pvid = 0;
 	dev->ports[port].pvid = pvid;
 
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
@@ -2269,7 +2256,7 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	struct b53_device *dev = ds->priv;
 	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
-	u16 pvlan, reg, pvid;
+	u16 pvlan, reg;
 	unsigned int i;
 
 	/* On 7278, port 7 which connects to the ASP should only receive
@@ -2278,8 +2265,7 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	if (dev->chip_id == BCM7278_DEVICE_ID && port == 7)
 		return -EINVAL;
 
-	pvid = b53_default_pvid(dev);
-	vl = &dev->vlans[pvid];
+	vl = &dev->vlans[0];
 
 	if (dev->vlan_filtering) {
 		/* Make this port leave the all VLANs join since we will have
@@ -2295,9 +2281,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 				    reg);
 		}
 
-		b53_get_vlan_entry(dev, pvid, vl);
+		b53_get_vlan_entry(dev, 0, vl);
 		vl->members &= ~BIT(port);
-		b53_set_vlan_entry(dev, pvid, vl);
+		b53_set_vlan_entry(dev, 0, vl);
 	}
 
 	b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan);
@@ -2336,7 +2322,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 	unsigned int i;
-	u16 pvlan, reg, pvid;
+	u16 pvlan, reg;
 
 	b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan);
 
@@ -2361,8 +2347,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
-	pvid = b53_default_pvid(dev);
-	vl = &dev->vlans[pvid];
+	vl = &dev->vlans[0];
 
 	if (dev->vlan_filtering) {
 		/* Make this port join all VLANs without VLAN entries */
@@ -2374,9 +2359,9 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 			b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
 		}
 
-		b53_get_vlan_entry(dev, pvid, vl);
+		b53_get_vlan_entry(dev, 0, vl);
 		vl->members |= BIT(port);
-		b53_set_vlan_entry(dev, pvid, vl);
+		b53_set_vlan_entry(dev, 0, vl);
 	}
 }
 EXPORT_SYMBOL(b53_br_leave);
-- 
2.43.0


