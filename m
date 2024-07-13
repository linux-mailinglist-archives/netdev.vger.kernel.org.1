Return-Path: <netdev+bounces-111214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F189303DD
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF77C282856
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC637346C;
	Sat, 13 Jul 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTgRE4S5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECB7316E;
	Sat, 13 Jul 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850115; cv=none; b=eLeN6idmbb49LSBNAyq6Iv+A4y4L03ijJediuSBY2nf/tfk32ZDaVhVBQMuhYNBSNCrSEOsblU+MVLrzIesjDgtoRTKUk6FUObRjzAJumO2epsKulJl4lQke0TNaxFN33GB44VVfrwif8M3DVOo4heBSJOxhlMam5XxCqkPaI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850115; c=relaxed/simple;
	bh=dsvAEFFYi4cEp7LshOu0kyHfHtkr8SJfr3gpVgJwMGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmvuvGTvYepeBs3hiqh5cjjTFy+PBcao2X/vrcRW08VP0S4/aA+9Q1kaKtTC/6Av5xrKbymX1fTu233EtO3S8qv9A84DTZm3rQXTUG4Cgqh8qpPwS9zEArkW9uFKaAZNf7BXmYKQU9yJoFw4YaRY/MLIJILJ+iZCd9nJNnhhYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTgRE4S5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso3297237a12.0;
        Fri, 12 Jul 2024 22:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850111; x=1721454911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0fP5T7J9roHoO7jnqM3i5JEtOTM2w+2+LRIgaQhPxk=;
        b=FTgRE4S5j3ScnQp1ubRlvu4WVcZE0rAcykiDGeGRYVMv4KlNBp0y0bR8RQ22vlcKLZ
         QeC1Msbxqb4jHfhtXsisM/xVlX7OwRBPyA/QK8092i4InjHSlamZRpcXWikPvNavd/Bd
         n5WGUOtEJEwNxV5lcdNGFFQvNuousUxAPXYE+Rm0tiXLL06JI1/pnkT6xTWO9ZiT37Eo
         ER3wg2399SS6HB8X8XhGy24qmgu8C4XkTyWj24+ll7NrQcwvDdFaeVnksbCGAZDLGrWr
         ABcPQEba0iymfErsEXrkRIhEDzTRlbPM6V9DIzdXoma8Z/M2lZcNgjrgb/54MKU+jDH5
         LOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850111; x=1721454911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0fP5T7J9roHoO7jnqM3i5JEtOTM2w+2+LRIgaQhPxk=;
        b=VElVRu0RXvn4UlvHEdvjMBdLvwHfGAE0761XnUvDjTzwgUQ1FED9kGvr2fj6go7szO
         rHuuHn8b5tszcrafxmOcGAbD3sd25wFjYV94Whu8wdm3HSAoAYR48HDo/zun/+NBoG7b
         1nyFnUxRIZ4b8+xSOlSdD7aSIDF+qHzbMmZ9YtAKbX1TmTcWyuc7LD2TEh7Vi8eM7sbD
         YJx0ewNnxDwU+5QRlG6plGWuiJvUEXft5Wer1cOLZ04xT48H0PqaRP8cO7ZqeslIqAh7
         ZrbejK0/qxSEC1NUE9CfFgHUPWZuZWQHsDrcqgPVoIAMjlmnhpPzx2Trs7QvJ3d+iCSw
         aSgw==
X-Forwarded-Encrypted: i=1; AJvYcCVPvCnlIzZs5Y6Vebijr2soRPGmBJBGZXi9JAZolNzASqd8Y11Der5hK12IBD08uANlCseJzyblCOi67AGAabjUesNIL9ya0ZL9/sjN
X-Gm-Message-State: AOJu0YzI572E4B51K2csX8278teXAOOcT9IFEUim2KEHJ2gN8KIdiLba
	wEIrFNn9fQc/g8rgOLgpPQ8DPry10AQZoQgXU/L4g3kd3I0T/bDUDZSS0tea
X-Google-Smtp-Source: AGHT+IExeSH6eS2an84RtlZj0FIKftwPt9gNRnPN6TsktjvL9SujFT5r+sF6QapXFOSH+UWkWLsufQ==
X-Received: by 2002:a17:906:27d6:b0:a72:74d5:8a9a with SMTP id a640c23a62f3a-a780b89cc52mr903691666b.65.1720850111356;
        Fri, 12 Jul 2024 22:55:11 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:10 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 06/12] net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()
Date: Sat, 13 Jul 2024 07:54:34 +0200
Message-Id: <20240713055443.1112925-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055443.1112925-1-paweldembicki@gmail.com>
References: <20240713055443.1112925-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

A new tagging protocol implementation based on tag_8021q is on the
horizon, and it appears that it also has to open-code the complicated
logic of finding a source port based on a VLAN header.

Create a single dsa_tag_8021q_find_user() and make sja1105 call it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v3,v2,v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6, v5:
  - resend only
v4:
  - introduce patch and change from master to conduit and slave to user
---
 net/dsa/tag_8021q.c   | 19 ++++++++++++++++---
 net/dsa/tag_8021q.h   |  5 +++--
 net/dsa/tag_sja1105.c | 17 +++++------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 2d1c554a63ff..c0eee113a2b9 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -468,8 +468,8 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 }
 EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
-						   int vbid)
+static struct net_device *
+dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit, int vbid)
 {
 	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
@@ -495,7 +495,20 @@ struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
+
+struct net_device *dsa_tag_8021q_find_user(struct net_device *conduit,
+					   int source_port, int switch_id,
+					   int vid, int vbid)
+{
+	/* Always prefer precise source port information, if available */
+	if (source_port != -1 && switch_id != -1)
+		return dsa_conduit_find_user(conduit, switch_id, source_port);
+	else if (vbid >= 1)
+		return dsa_tag_8021q_find_port_by_vbid(conduit, vbid);
+
+	return dsa_find_designated_bridge_port_by_vid(conduit, vid);
+}
+EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_user);
 
 /**
  * dsa_8021q_rcv - Decode source information from tag_8021q header
diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
index 0c6671d7c1c2..27b8906f99ec 100644
--- a/net/dsa/tag_8021q.h
+++ b/net/dsa/tag_8021q.h
@@ -16,8 +16,9 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		   int *vbid, int *vid);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
-						   int vbid);
+struct net_device *dsa_tag_8021q_find_user(struct net_device *conduit,
+					   int source_port, int switch_id,
+					   int vid, int vbid);
 
 int dsa_switch_tag_8021q_vlan_add(struct dsa_switch *ds,
 				  struct dsa_notifier_tag_8021q_vlan_info *info);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 35a6346549f2..3e902af7eea6 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -509,12 +509,8 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 */
 		return NULL;
 
-	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-	else if (vbid >= 1)
-		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
+					   vid, vbid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
@@ -652,12 +648,9 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-	else if (vbid >= 1)
-		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
+					   vid, vbid);
+
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


