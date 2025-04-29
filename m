Return-Path: <netdev+bounces-186845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79709AA1BF1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5264686AA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80C26A0AD;
	Tue, 29 Apr 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnHLx8zr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184C2686AA;
	Tue, 29 Apr 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957856; cv=none; b=cokSsGt7eArEVpxOINDr2zvnItw1Ztmc17/n2JOiI/iJzuf7SvesQPbv0MFA0+ejLVyjH5Zuxkvx15WWoVpDUFoJjuCmfqCytbAz5+ci3QLVgY24OAtiESIc77Iy7Jr52C5TIYU9P8uSIgrev2HfhhZ6vdgDpMXI9kTBWxCsxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957856; c=relaxed/simple;
	bh=T0lI2VUmB5CEpO5S7puFi43w7Vie3rHaG4awpQE3pPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVnu51CGGjBYgCFlgv86b7tPyW+D/lJtRktUFHkX2dlYh7tP464pVBnkvBhG4M599sqGN6Tc7kf5GFMRBzgLeiUCNV9h/A3XCrV6puTLL1O1fA5Oj/tbmsSSy0V45Qa4IF8n114SsTPzoUOcaQj8ks1zYRW3EtvarS6yDM27iH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnHLx8zr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1402804966b.0;
        Tue, 29 Apr 2025 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957853; x=1746562653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZuNrs7YE4T2m16nG742v8kNIyjED6LpI5Qr7HTH9X4=;
        b=BnHLx8zrFcxlmu/s8i4j8WhUJcwJ0b0jZqzl4snDFmy3iWXIP6rmYswafULgjBMtrl
         UyBezUZIvXM18LZBkUP8ZgyV7C150EDr862i3fw06PFoKaXM5bXi2i6wogKRhCCWtv0P
         so3tcIIaB3E2jZd/5S7PmNnSRY3BOyhBHbb1mZ5gaWVSG4+smna1YVY8OC5k+PX/xZhn
         msy1ZIPF8cBsamu27tvjZzAHO0wstEz/1IZ5eLoGCoYzlcVvazUuRWM8oqU4aoTO1KTZ
         jFOE038p/rhldI7TTG/wmuFp8yIRUGH4r5PE1DOLDM+LDPlv6N3fvqU55Ipv91L1ZfO0
         UT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957853; x=1746562653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZuNrs7YE4T2m16nG742v8kNIyjED6LpI5Qr7HTH9X4=;
        b=b+fJlu1dTong4UMS2eyKhDigabSUi0rtRzXuzVPXPIS+ZKACPxWUdVeExaPvt1dNiA
         JYjdIQ/2NuZIAm3YGL/PmIHTv0lKnDvPFGxX8sN7b6XGFuxIvx/jvnUzCRFYSY/Udvaq
         W5vdcj6TJUQ7Uv7yJRmhhBRP61WtEQgR5gxfwliKD6VQIEmPVweV1Bne8jcl9m/CPBjw
         C4sG8sUw/+tjCejKdXgi0VudbLvH8uPDQDwW7yd46rAvsUlwwL4CeQbByl97D0qNd1G4
         DiWrHZcMQ5wIsg1ETBCEX7tB/nLhXZupRCHL8Uw3wSUaGfGL6d8imB6bIYxzm3lCPDu0
         qijw==
X-Forwarded-Encrypted: i=1; AJvYcCUr3fTKMqszUDl4jzmY+AlFhkyraFegP847U+aDbkwSVYILA6gxPwSDYut3k2fgMR5ZdBs7NvweClk2QGc=@vger.kernel.org, AJvYcCWVa5icnsdM2BvKW4jEfGFh2bdTBH96+7IZOr6AIhg9mCNJBKX5sIytz43y3bSsFT5HwcIwM4nl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2w5lddaVT7Wzn+Z1DQStPj36Gk4DRRBkd/6NZ4zNaVQ70HYc2
	Pl2EVb5AcHV14P0UFBjxTPril59uzFkBxBLqs+2ZDc/8tCd3eBuQ
X-Gm-Gg: ASbGnctTlBa15Nly9wV79Br2i5vfOjkR5nh2C+XCFxCfK69tFzCI1vKSGK96olVLZcI
	kq9hmlSETF00uegQLdWu5wtzJkKRI9bzN+d+wTZ7eq4ZLeMJiTLnRuitA5lyTd6Uah0kT4uCCpI
	wrHvBHuev8Ezm6lffOgH0JzicvNSnKZ4iQi0KES5Ifdz8KNUbFLndyiQn8lrOy2VElN4JfDUKqc
	wu3jtU5qeyUugVQtnE0Tx1AILrNe6wYv6Df/lZ54qzR0CYjRsUqVScBrFSC6Or/HgJXdiWUwY7R
	mlAQ1FpzMRKAOpasMX9SRoOKpSuhMQ1ui0OlT/H+mx1cPrQwlO234WZ9ocjGp/BZLVLsS9/RCbH
	/X4+pEIqZalVTQcamDTAJEU+8PRjNqg==
X-Google-Smtp-Source: AGHT+IHbb6XwQTMHbcj4NKpTvXJBNArGd63mnfnqwmBAIjXR1+Q7V8XIETFcJtxmdSH3zpB3kqvfag==
X-Received: by 2002:a17:907:6d19:b0:ac3:26ff:11a0 with SMTP id a640c23a62f3a-acedc734321mr76848066b.38.1745957852456;
        Tue, 29 Apr 2025 13:17:32 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703833c8csm7808965a12.72.2025.04.29.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:31 -0700 (PDT)
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
Subject: [PATCH net 03/11] net: dsa: b53: fix clearing PVID of a port
Date: Tue, 29 Apr 2025 22:17:02 +0200
Message-ID: <20250429201710.330937-4-jonas.gorski@gmail.com>
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

Currently the PVID of ports are only set when adding/updating VLANs with
PVID set or removing VLANs, but not when clearing the PVID flag of a
VLAN.

E.g. the following flow

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set sw1p1 master bridge
$ bridge vlan add dev sw1p1 vid 10 pvid untagged
$ bridge vlan add dev sw1p1 vid 10 untagged

Would keep the PVID set as 10, despite the flag being cleared. Fix this
by checking if we need to unset the PVID on vlan updates.

Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9d4fb54b4ced..65d74c455c57 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1537,12 +1537,21 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	struct b53_vlan *vl;
+	u16 old_pvid, new_pvid;
 	int err;
 
 	err = b53_vlan_prepare(ds, port, vlan);
 	if (err)
 		return err;
 
+	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &old_pvid);
+	if (pvid)
+		new_pvid = vlan->vid;
+	else if (!pvid && vlan->vid == old_pvid)
+		new_pvid = b53_default_pvid(dev);
+	else
+		new_pvid = old_pvid;
+
 	vl = &dev->vlans[vlan->vid];
 
 	b53_get_vlan_entry(dev, vlan->vid, vl);
@@ -1562,9 +1571,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
-	if (pvid && !dsa_is_cpu_port(ds, port)) {
+	if (!dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
-			    vlan->vid);
+			    new_pvid);
 		b53_fast_age_vlan(dev, vlan->vid);
 	}
 
-- 
2.43.0


