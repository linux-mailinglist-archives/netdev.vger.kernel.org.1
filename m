Return-Path: <netdev+bounces-186851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B49AA1C03
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BA1BC5C54
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F6261362;
	Tue, 29 Apr 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJU4VAj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F907274FE0;
	Tue, 29 Apr 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957863; cv=none; b=FmGqQWeOM6lwWv/9lKJsQAQ65v+oo2wfziE0clB/l9bAa0iLBkTZ85AH1D08w7GZF16LJt+kTygpdJC6hI9Q2cOqUJ7GSdH9A/3NX02S1lUTKHVgC2p84aSIF4RQNaelLi303DePjEQhWkkqcYYZLfBIqM/i65gJr7ia1QrXoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957863; c=relaxed/simple;
	bh=yN2WrUbdu3laYnS9OyLYMWDymv0xbwCtOPLLScc9R6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4iDOqduxlqC8AsbtQtDBwVFJ6UEhMKEKh9hsNpArXQBHyG7ih46AGim8EYqXKcNEZVfvFYyE29GVaM8nNh0mDwj2J8wP3ZbJ4o6YBlRLEzsDkiE6NaKasj7fOp843WRXPAsH64f81E3NnbOwFymEf7Vq008i9+fY3a04lw4kG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJU4VAj/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acec5b99052so237477766b.1;
        Tue, 29 Apr 2025 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957860; x=1746562660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSF/cqgkgiZjMVcssNZkYUh4M79ChrFY2+W6TuDZtn8=;
        b=XJU4VAj/hs84H1n0gZdbnixgt0kEUQVqxUH0pSMxjr4LIlt5HhQWtaEV4vTIJRSqoM
         nvTE7VPWDx/Dj6FUtq0/9RrPtWcoSlQPfvGAIpM3nfGciWFNo7+iPALw3dlHtb/A8w3/
         e9EuRMW5jir6oecwVhtBqSWXVhfuSWDtOH9wzs4VTGx9b0uxmhTFeDyBRvuqRUHD5S42
         0yri1Ir3wGrsG7SCjad9bSnGXRR9x/aHfT80Aazolmn+JfA74DfBIMP7S6ZgBoZdYFIh
         fQfGivvoGBIlmiFQEDShDvJkAg9sfDon0Inne1WeVjKXE5EFq1i6zr+OzauKnu+/wXlu
         gJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957860; x=1746562660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSF/cqgkgiZjMVcssNZkYUh4M79ChrFY2+W6TuDZtn8=;
        b=JHu3J891m38nbc4wgNdy11hpDPwUflwIthrt5LJSK8MEh3STbzoeQMOKtcu27TL0wt
         69v/jMh8M19Qd7YlSXSK3mmb9acSdKzYLHAhidP+0nTpEuk75qoYq4Xo40iwvWAiiIEl
         2T3m2FoulVziemVckla0jJYYeezdTN0FeTgzoZbbIE1Yqn7x0FAo7o8Gjjr75XuA0aMR
         DmKX8OXZXGXPTnem+nFlbwkRbWcIGF6P7jYXFVPiGFwEdJxMv+/Gds1R9XW2Fwunfcx9
         glvmLdsUFkRrWyCM7EeZpJb7BBXrrKKGrBarFjZrdR1jB2jlOO8lTCGi3tJcoh56Ehr+
         Lk1A==
X-Forwarded-Encrypted: i=1; AJvYcCU+vwxp5tSZl4CEj5oCxOCdIq1L86/2jIoW+NSa2WZy1G3B4qXMb+1ro9VVwGbO7oagysHATJEI2q2YJcs=@vger.kernel.org, AJvYcCUFOqIxSlyao0DaDvaTNkDpDcyjfHg2nCtbj2i4953VBZ5NT17IhJ35RoJHvZiTQ4rUuccG0crB@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMIXfoU9LwphUmoqdWmFzT/i3K3xWZvTor7MXnU6hZ6mcc4JI
	mxY0qEHW0Fxu1S1BUFNQUQCaHBKWLnWVAyAq6aleT/0kP4CxAHEp
X-Gm-Gg: ASbGncvFo/dLRycIekhhZMl/yLDzfbiEfsJGwxvdynrxDpuTe6yg6VkcMM1FzZS7UEi
	BHn7U7fnlcMlI0bCJIGtusNlp5T8112Ta2JV42CDhqOHNELpXglJyE8+I01N8tE20JpB0H8FE+C
	xJnKfNOnkqoNalhAwSSUMxU5La/l6JZYE+Exzy+rLpl19tXIkFvTakCDlwtNKeSWYRQcwgtT1Jh
	A+d0MqIYs2cbVReB/VZN+Vq+M5ObtcXvNU9zNIVD4Sk2Z1JHYIVih0fj/xqJjcih62mepG/C9ZL
	uAhK/4DnpJ8Qajn35byt3nummuqwwrE5YLkeTHzy/WBz6BcLDIh036V0doYQCoJDzANEVswPpAP
	NPepnpsK/my7rullwz38=
X-Google-Smtp-Source: AGHT+IH/0oqo25kwxDI8ezVd2VcRRWSqDbzLIZpJCRlGr+q55RfI3Ane0wlbwBauigJLzOlet3AAZA==
X-Received: by 2002:a17:907:9628:b0:ace:6a1e:61e0 with SMTP id a640c23a62f3a-acedc626f58mr74461666b.25.1745957859497;
        Tue, 29 Apr 2025 13:17:39 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c934sm822407766b.8.2025.04.29.13.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:38 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 09/11] net: dsa: b53: fix toggling vlan_filtering
Date: Tue, 29 Apr 2025 22:17:08 +0200
Message-ID: <20250429201710.330937-10-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow runtime switching between vlan aware and vlan non-aware mode,
we need to properly keep track of any bridge VLAN configuration.
Likewise, we need to know when we actually switch between both modes, to
not have to rewrite the full VLAN table every time we update the VLANs.

So keep track of the current vlan_filtering mode, and on changes, apply
the appropriate VLAN configuration.

Fixes: 0ee2af4ebbe3 ("net: dsa: set configure_vlan_while_not_filtering to true by default")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 104 ++++++++++++++++++++++---------
 drivers/net/dsa/b53/b53_priv.h   |   2 +
 2 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index ee2f1be62618..0a7749b416f7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -763,6 +763,22 @@ static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
 	return dev->tag_protocol == DSA_TAG_PROTO_NONE && dsa_is_cpu_port(ds, port);
 }
 
+static bool b53_vlan_port_may_join_untagged(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+	struct dsa_port *dp;
+
+	if (!dev->vlan_filtering)
+		return true;
+
+	dp = dsa_to_port(ds, port);
+
+	if (dsa_port_is_cpu(dp))
+		return true;
+
+	return dp->bridge == NULL;
+}
+
 int b53_configure_vlan(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
@@ -781,7 +797,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
 		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
 	}
 
-	b53_enable_vlan(dev, -1, dev->vlan_enabled, ds->vlan_filtering);
+	b53_enable_vlan(dev, -1, dev->vlan_enabled, dev->vlan_filtering);
 
 	/* Create an untagged VLAN entry for the default PVID in case
 	 * CONFIG_VLAN_8021Q is disabled and there are no calls to
@@ -789,26 +805,39 @@ int b53_configure_vlan(struct dsa_switch *ds)
 	 * entry. Do this only when the tagging protocol is not
 	 * DSA_TAG_PROTO_NONE
 	 */
+	v = &dev->vlans[def_vid];
 	b53_for_each_port(dev, i) {
-		v = &dev->vlans[def_vid];
-		v->members |= BIT(i);
+		if (!b53_vlan_port_may_join_untagged(ds, i))
+			continue;
+
+		vl.members |= BIT(i);
 		if (!b53_vlan_port_needs_forced_tagged(ds, i))
-			v->untag = v->members;
-		b53_write16(dev, B53_VLAN_PAGE,
-			    B53_VLAN_PORT_DEF_TAG(i), def_vid);
+			vl.untag = vl.members;
+		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
+			    def_vid);
 	}
+	b53_set_vlan_entry(dev, def_vid, &vl);
 
-	/* Upon initial call we have not set-up any VLANs, but upon
-	 * system resume, we need to restore all VLAN entries.
-	 */
-	for (vid = def_vid; vid < dev->num_vlans; vid++) {
-		v = &dev->vlans[vid];
+	if (dev->vlan_filtering) {
+		/* Upon initial call we have not set-up any VLANs, but upon
+		 * system resume, we need to restore all VLAN entries.
+		 */
+		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
+			v = &dev->vlans[vid];
 
-		if (!v->members)
-			continue;
+			if (!v->members)
+				continue;
+
+			b53_set_vlan_entry(dev, vid, v);
+			b53_fast_age_vlan(dev, vid);
+		}
 
-		b53_set_vlan_entry(dev, vid, v);
-		b53_fast_age_vlan(dev, vid);
+		b53_for_each_port(dev, i) {
+			if (!dsa_is_cpu_port(ds, i))
+				b53_write16(dev, B53_VLAN_PAGE,
+					    B53_VLAN_PORT_DEF_TAG(i),
+					    dev->ports[i].pvid);
+		}
 	}
 
 	return 0;
@@ -1127,7 +1156,9 @@ EXPORT_SYMBOL(b53_setup_devlink_resources);
 static int b53_setup(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
+	struct b53_vlan *vl;
 	unsigned int port;
+	u16 pvid;
 	int ret;
 
 	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
@@ -1146,6 +1177,15 @@ static int b53_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	/* setup default vlan for filtering mode */
+	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
+	b53_for_each_port(dev, port) {
+		vl->members |= BIT(port);
+		if (!b53_vlan_port_needs_forced_tagged(ds, port))
+			vl->untag |= BIT(port);
+	}
+
 	b53_reset_mib(dev);
 
 	ret = b53_apply_config(dev);
@@ -1499,7 +1539,10 @@ int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 {
 	struct b53_device *dev = ds->priv;
 
-	b53_enable_vlan(dev, port, dev->vlan_enabled, vlan_filtering);
+	if (dev->vlan_filtering != vlan_filtering) {
+		dev->vlan_filtering = vlan_filtering;
+		b53_apply_config(dev);
+	}
 
 	return 0;
 }
@@ -1524,7 +1567,7 @@ static int b53_vlan_prepare(struct dsa_switch *ds, int port,
 	if (vlan->vid >= dev->num_vlans)
 		return -ERANGE;
 
-	b53_enable_vlan(dev, port, true, ds->vlan_filtering);
+	b53_enable_vlan(dev, port, true, dev->vlan_filtering);
 
 	return 0;
 }
@@ -1547,21 +1590,17 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return 0;
 
-	if (!ds->vlan_filtering)
-		return 0;
-
-	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &old_pvid);
+	old_pvid = dev->ports[port].pvid;
 	if (pvid)
 		new_pvid = vlan->vid;
 	else if (!pvid && vlan->vid == old_pvid)
 		new_pvid = b53_default_pvid(dev);
 	else
 		new_pvid = old_pvid;
+	dev->ports[port].pvid = new_pvid;
 
 	vl = &dev->vlans[vlan->vid];
 
-	b53_get_vlan_entry(dev, vlan->vid, vl);
-
 	if (dsa_is_cpu_port(ds, port))
 		untagged = false;
 
@@ -1571,6 +1610,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	else
 		vl->untag &= ~BIT(port);
 
+	if (!dev->vlan_filtering)
+		return 0;
+
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
@@ -1595,23 +1637,22 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	if (vlan->vid == 0)
 		return 0;
 
-	if (!ds->vlan_filtering)
-		return 0;
-
-	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &pvid);
+	pvid = dev->ports[port].pvid;
 
 	vl = &dev->vlans[vlan->vid];
 
-	b53_get_vlan_entry(dev, vlan->vid, vl);
-
 	vl->members &= ~BIT(port);
 
 	if (pvid == vlan->vid)
 		pvid = b53_default_pvid(dev);
+	dev->ports[port].pvid = pvid;
 
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
 		vl->untag &= ~(BIT(port));
 
+	if (!dev->vlan_filtering)
+		return 0;
+
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
@@ -1958,7 +1999,7 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
 
-	if (ds->vlan_filtering) {
+	if (dev->vlan_filtering) {
 		/* Make this port leave the all VLANs join since we will have
 		 * proper VLAN entries from now on
 		 */
@@ -2038,7 +2079,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	pvid = b53_default_pvid(dev);
 	vl = &dev->vlans[pvid];
 
-	if (ds->vlan_filtering) {
+	if (dev->vlan_filtering) {
 		/* Make this port join all VLANs without VLAN entries */
 		if (is58xx(dev)) {
 			b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
@@ -2803,6 +2844,7 @@ struct b53_device *b53_switch_alloc(struct device *base,
 	ds->ops = &b53_switch_ops;
 	ds->phylink_mac_ops = &b53_phylink_mac_ops;
 	dev->vlan_enabled = true;
+	dev->vlan_filtering = false;
 	/* Let DSA handle the case were multiple bridges span the same switch
 	 * device and different VLAN awareness settings are requested, which
 	 * would be breaking filtering semantics for any of the other bridge
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 0166c37a13a7..4636e27fd1ee 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -96,6 +96,7 @@ struct b53_pcs {
 
 struct b53_port {
 	u16		vlan_ctl_mask;
+	u16		pvid;
 	struct ethtool_keee eee;
 };
 
@@ -147,6 +148,7 @@ struct b53_device {
 	unsigned int num_vlans;
 	struct b53_vlan *vlans;
 	bool vlan_enabled;
+	bool vlan_filtering;
 	unsigned int num_ports;
 	struct b53_port *ports;
 
-- 
2.43.0


