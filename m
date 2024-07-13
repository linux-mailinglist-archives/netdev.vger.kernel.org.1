Return-Path: <netdev+bounces-111272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CC930763
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224D52827EF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19C16F273;
	Sat, 13 Jul 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK1OdKjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E816D4DA;
	Sat, 13 Jul 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905406; cv=none; b=KvZBNGESM4UUeIWk9Y/hBM/OCtU2jBbws9zp3M1Yq2oBQUB9j1wWu2ucL7GwhRS4pD04OVOzB6xvvZGo4ReXQEmZ0HLLl+/fkGTYeSCKe+ACR3K1+x0Fo8Zk4WhDN3kO5lEMQPqfmmGrKZRmbVRFiuCyJbI3hvx4ybYiobFyP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905406; c=relaxed/simple;
	bh=lXmR+NMQm+fCe3iiVfRjLFCaJoehj2BCOJDAFwubBdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1vwOuEvsW2yOPr0SwJbZNzVXEBrczwDQRWOBx6uJ6MRozY+7paT1swj//givnMFXn8qQxBu28+LaPMNEpsAYldB5G0C6Kz0hTCLTqXc+aUf9rZzyn9rCWWoktL1ck2fQACgXAgN22vCdDdpjGlhTBLKe83X56HPsVqOo62jllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK1OdKjl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso8139741fa.1;
        Sat, 13 Jul 2024 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905403; x=1721510203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2UgQCFrQXxsc8QAncmL+w1FMJOgr3KW+mdvIiQK/h4=;
        b=fK1OdKjlDAesMdCk/sc3iGQWD6/Oi7IQr2w8thhakhOrEQ/D+KrFUQ2fQO0wmF3mIQ
         QEmCqjPql4x8jjW1Uub+yiGCQotr8eCkd44va6E8VeTTcQQueLLbl14Gt1sx+HqhRIAF
         syjsohcQ4CjF6Ni4UqDArhAWJE3PsBYTJQj2kdIX4Irr/7APP8zcRlVbtW6rV7b3wgiB
         ShRbYIcnBanBS/zMzqWm7gNcJVJz/Ouiko+NWiqu1mrLupJqSjfE/qgNNDXLEkVJt9nS
         tDqmYE3VffUU/FyboFHoB3ZC7dufoii5XMxhb4AV4GCpL2QG0F6GaJachJfJ5aGESeRv
         is3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905403; x=1721510203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2UgQCFrQXxsc8QAncmL+w1FMJOgr3KW+mdvIiQK/h4=;
        b=Daz6Xhq7/HYdDuaws0zOxZwmOm9f7gB3FcXzPRXPKlRPVhlpPuxg2IDABwgnA4+rdZ
         nRiM6S+Ddgz6f6S3GoZir7jB/EzN6NnIgjLtiu5nMhDUiptptkFKWmigpFpwUXQXNNOm
         MsMJIAXjeieel8nEy23iyCWG8V26n2EqfBU9m5sQHrjREQZ1zK93Xrw/ZJu0B39GV7gT
         3RIfrKfs5x/z/n8J2g55kzuYjbRSVbfIjPLP3OPGrPpwDhm9W8VFnW05yy9lQwS4qN0T
         YJmM07cfAKp32EkalGWO8etT7IPbacqKDBRy7Q+r32Hy4G1GkW8STRKEHS9iQoRcJuNK
         5Zag==
X-Forwarded-Encrypted: i=1; AJvYcCVuJmOx523Qw3tvbuzW2eZqAf3Xco4Y6HfVx1h5yNlXYjKiTgwo3F0WEkLqgOq5cyiUf7DGYU+rehVdPbzTY9Gs8vu65aRJlCznKEn1
X-Gm-Message-State: AOJu0YyCSvYutoxNRME+oPVBqIsmXS3bBYluf0JHjVrcR1Xt658NPAwW
	iGQB0/2kLKU/ynxSMc1TRRCCrHqHlxXOsfbU2aK1nLmtxTVh0uYf8bi941S5
X-Google-Smtp-Source: AGHT+IEysiSYhpdIUUieW5206mxSf8NvZbVkNwTmkF4tNOAkvZfQWM0m8QiTCTpXP7APqKcUgfYJoQ==
X-Received: by 2002:a2e:a367:0:b0:2ee:7bcd:a3f with SMTP id 38308e7fff4ca-2eeb30eb72amr90288181fa.22.1720905402443;
        Sat, 13 Jul 2024 14:16:42 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:42 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 04/12] net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into dsa_8021q_rcv()
Date: Sat, 13 Jul 2024 23:16:10 +0200
Message-Id: <20240713211620.1125910-5-paweldembicki@gmail.com>
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

tag_sja1105 has a wrapper over dsa_8021q_rcv(): sja1105_vlan_rcv(),
which determines whether the packet came from a bridge with
vlan_filtering=1 (the case resolved via
dsa_find_designated_bridge_port_by_vid()), or if it contains a tag_8021q
header.

Looking at a new tagger implementation for vsc73xx, based also on
tag_8021q, it is becoming clear that the logic is needed there as well.
So instead of forcing each tagger to wrap around dsa_8021q_rcv(), let's
merge the logic into the core.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - resend only
v3:
  - removed goto
  - removed unnecessary vbid assignment
  - added 'Tested-by' and 'Reviewed-by' fields
v2,v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8, v7, v6:
  - resend only
v5:
  - add missing SoB
v4:
  - introduced patch
---
 net/dsa/tag_8021q.c        | 34 ++++++++++++++++++++++++++++------
 net/dsa/tag_8021q.h        |  2 +-
 net/dsa/tag_ocelot_8021q.c |  2 +-
 net/dsa/tag_sja1105.c      | 32 ++++----------------------------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 3cb0293793a5..2d1c554a63ff 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -507,27 +507,48 @@ EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
  * @vbid: pointer to storage for imprecise bridge ID. Must be pre-initialized
  *	with -1. If a positive value is returned, the source_port and switch_id
  *	are invalid.
+ * @vid: pointer to storage for original VID, in case tag_8021q decoding failed.
+ *
+ * If the packet has a tag_8021q header, decode it and set @source_port,
+ * @switch_id and @vbid, and strip the header. Otherwise set @vid and keep the
+ * header in the hwaccel area of the packet.
  */
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
-		   int *vbid)
+		   int *vbid, int *vid)
 {
 	int tmp_source_port, tmp_switch_id, tmp_vbid;
-	u16 vid, tci;
+	__be16 vlan_proto;
+	u16 tmp_vid, tci;
 
 	if (skb_vlan_tag_present(skb)) {
+		vlan_proto = skb->vlan_proto;
 		tci = skb_vlan_tag_get(skb);
 		__vlan_hwaccel_clear_tag(skb);
 	} else {
+		struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
+
+		vlan_proto = hdr->h_vlan_proto;
 		skb_push_rcsum(skb, ETH_HLEN);
 		__skb_vlan_pop(skb, &tci);
 		skb_pull_rcsum(skb, ETH_HLEN);
 	}
 
-	vid = tci & VLAN_VID_MASK;
+	tmp_vid = tci & VLAN_VID_MASK;
+	if (!vid_is_dsa_8021q(tmp_vid)) {
+		/* Not a tag_8021q frame, so return the VID to the
+		 * caller for further processing, and put the tag back
+		 */
+		if (vid)
+			*vid = tmp_vid;
+
+		__vlan_hwaccel_put_tag(skb, vlan_proto, tci);
+
+		return;
+	}
 
-	tmp_source_port = dsa_8021q_rx_source_port(vid);
-	tmp_switch_id = dsa_8021q_rx_switch_id(vid);
-	tmp_vbid = dsa_tag_8021q_rx_vbid(vid);
+	tmp_source_port = dsa_8021q_rx_source_port(tmp_vid);
+	tmp_switch_id = dsa_8021q_rx_switch_id(tmp_vid);
+	tmp_vbid = dsa_tag_8021q_rx_vbid(tmp_vid);
 
 	/* Precise source port information is unknown when receiving from a
 	 * VLAN-unaware bridging domain, and tmp_source_port and tmp_switch_id
@@ -546,5 +567,6 @@ void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		*vbid = tmp_vbid;
 
 	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+	return;
 }
 EXPORT_SYMBOL_GPL(dsa_8021q_rcv);
diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
index 41f7167ac520..0c6671d7c1c2 100644
--- a/net/dsa/tag_8021q.h
+++ b/net/dsa/tag_8021q.h
@@ -14,7 +14,7 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 			       u16 tpid, u16 tci);
 
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
-		   int *vbid);
+		   int *vbid, int *vid);
 
 struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 						   int vbid);
diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index b059381310fe..8e8b1bef6af6 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -81,7 +81,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 {
 	int src_port, switch_id;
 
-	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL);
+	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
 	skb->dev = dsa_conduit_find_user(netdev, switch_id, src_port);
 	if (!skb->dev)
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 48886d4b7e3e..7639ccb94d35 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -472,37 +472,14 @@ static bool sja1110_skb_has_inband_control_extension(const struct sk_buff *skb)
 	return ntohs(eth_hdr(skb)->h_proto) == ETH_P_SJA1110;
 }
 
-/* If the VLAN in the packet is a tag_8021q one, set @source_port and
- * @switch_id and strip the header. Otherwise set @vid and keep it in the
- * packet.
- */
-static void sja1105_vlan_rcv(struct sk_buff *skb, int *source_port,
-			     int *switch_id, int *vbid, u16 *vid)
-{
-	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
-	u16 vlan_tci;
-
-	if (skb_vlan_tag_present(skb))
-		vlan_tci = skb_vlan_tag_get(skb);
-	else
-		vlan_tci = ntohs(hdr->h_vlan_TCI);
-
-	if (vid_is_dsa_8021q(vlan_tci & VLAN_VID_MASK))
-		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
-
-	/* Try our best with imprecise RX */
-	*vid = vlan_tci & VLAN_VID_MASK;
-}
-
 static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	int source_port = -1, switch_id = -1, vbid = -1;
+	int source_port = -1, switch_id = -1, vbid = -1, vid = -1;
 	struct sja1105_meta meta = {0};
 	struct ethhdr *hdr;
 	bool is_link_local;
 	bool is_meta;
-	u16 vid;
 
 	hdr = eth_hdr(skb);
 	is_link_local = sja1105_is_link_local(skb);
@@ -525,7 +502,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	 * a tag_8021q VLAN which we have to strip
 	 */
 	if (sja1105_skb_has_tag_8021q(skb))
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
+		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 	else if (source_port == -1 && switch_id == -1)
 		/* Packets with no source information have no chance of
 		 * getting accepted, drop them straight away.
@@ -660,9 +637,8 @@ static struct sk_buff *sja1110_rcv_inband_control_extension(struct sk_buff *skb,
 static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	int source_port = -1, switch_id = -1, vbid = -1;
+	int source_port = -1, switch_id = -1, vbid = -1, vid = -1;
 	bool host_only = false;
-	u16 vid = 0;
 
 	if (sja1110_skb_has_inband_control_extension(skb)) {
 		skb = sja1110_rcv_inband_control_extension(skb, &source_port,
@@ -674,7 +650,7 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 
 	/* Packets with in-band control extensions might still have RX VLANs */
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
+		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
 	if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-- 
2.34.1


