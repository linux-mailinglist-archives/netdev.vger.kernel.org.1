Return-Path: <netdev+bounces-111274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260CD930767
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D0C1C20DAF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9B172BDF;
	Sat, 13 Jul 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfRaWA2e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082514A624;
	Sat, 13 Jul 2024 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905413; cv=none; b=HzLJYZ2gDi9NnIYAdT5HJQQBm6ckoNajaBez8u2Ru74Fn8IMFm+q7huV1FD3QzxRqLr/zIynBeyz/0hqiwLYnQHyqiEJGhG6ncsPg8K1H8W16TEr7LOTm8wEuhCdKHf8OuoofUVVc9iiDxYNtG4ka4l0yNu77h9A4P9qsLrpLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905413; c=relaxed/simple;
	bh=jdPYl+PdQen5M1F3EH5BJHeLsVCGlls9QneAudXvNwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSjw8b+rBTfxUgEjrzxkua07/ZG6IYPsc6SybMsbsodjYhM3L1KQa34NzOkyUcOr/zsamB+kE4V0qMuufZtB0qAHtMFNnAki/PAVlh0lm9oNWR0Ik0tqGfJA9bRgYNKX91OaqmjueugzsGYHsSx0e+6pZvtYoCJiJ7x24UETSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfRaWA2e; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eedeca1c79so10976231fa.3;
        Sat, 13 Jul 2024 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905410; x=1721510210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJVP0wGieLQlBcwdShklT/WM8VqJvVmSO/WMUsuT6O0=;
        b=QfRaWA2ehBKnlROgorL0F2gKazuVqtSwr2RQAT3TywThlCl9E+wF7/fVjcp+5KH8Jw
         i3f+8PF45hcs6neJkz21oyOODxb4t4EAVL6jtkxF7rORYEuiAs3T/v2fsd3zDISGs8BZ
         fn1s5AEtJxVKnXsChQXR9rrmKjDuupq3T5zOz8MmwBZRTcgJHboOMs/8BCpBh94IwSVa
         k4wKos5iFUBsEjHIrE/mNL9O+0Jq+MTzuqwiVvB647Y4C1wVH0tLeVEcjBXey5IqX0e8
         n4K5MNCEVsbltDTQQCjtgBWCCjreyPZPGfsR7Gvr5CWuUzId40B88eimsJOdmhax6CTF
         bOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905410; x=1721510210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJVP0wGieLQlBcwdShklT/WM8VqJvVmSO/WMUsuT6O0=;
        b=lJf6EphwR7kDkV9oeY/gU4IXd3svyZukccdWjcGljOcnahJ1oBX1N9COb9XOAyt2mi
         d689ei7mcPFk+L/l6ca0SFBh6xJ3MQILYWWGfx2V5siBEe2ZthFe+2WuNJDyQE66m75L
         MqRPDKrlIl444u01qiyMTPIoS6uYt9RnX1rH0xq0uLBQPGfMadsK8wXXLFT41Zj/59C8
         HL/1yAYGZByv61yWnck4j/54J4v8K+T+/gWlMKrJWf37QBpdhP0IbYnkMAm0psSrqFQY
         gxHc6lNE7R08FHw8KYJuohzpFk0Wds25LAxCTiXVsXz37mdP/CsbEoOC2oZF9ktiwREt
         zR7g==
X-Forwarded-Encrypted: i=1; AJvYcCU5FfO1CqjllRdJXI1bfIPziHDz9f7KsGeJdrIw9oxFkjgywMY8rDm7/esZrmxc8FYvnrM9Yj7vwT+eBNRbNr4VF6UbEeCr0gdTtdtV
X-Gm-Message-State: AOJu0Yyo3ukv5LWotyq4JX19Y3FfaHrHD/poO2pnUIYhtjKncioxrw4S
	yOykZpx4U3yW0CJAVI9s9mVcI6HY+2CsOGbEefsmpGtxeghMQUYGhPOtdpmO
X-Google-Smtp-Source: AGHT+IEhOBFnCdI5ul6qwg7VKFsZm/6wIhcx9Yv8SE15N9BkQWPqLcb3TtszEB0bZMfhkacHNzm6mQ==
X-Received: by 2002:a2e:a612:0:b0:2ec:5668:3b93 with SMTP id 38308e7fff4ca-2eeb30dc16emr106493541fa.12.1720905409760;
        Sat, 13 Jul 2024 14:16:49 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:49 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/12] net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()
Date: Sat, 13 Jul 2024 23:16:12 +0200
Message-Id: <20240713211620.1125910-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
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
v4-v1:
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


