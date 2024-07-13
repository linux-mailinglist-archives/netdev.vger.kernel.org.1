Return-Path: <netdev+bounces-111212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4659303D9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A2C2824B2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBC2110E;
	Sat, 13 Jul 2024 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBRI0XZy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7F4879B;
	Sat, 13 Jul 2024 05:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850108; cv=none; b=kRKSaZRmn3xeeeQXiMtt4kXSs9s+0V+5ijCxAkkmaxBRvfQE78B8JF2m27oNxUow/FKlGAj09YYfKVM2yNgvpqnw/QR35wOspbyr4siNrCguubojldqtI8N7OJylnj0RzxMQxMB9hZAlZ1ySdJD7W2KdEu0EcLuRBOT869rwJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850108; c=relaxed/simple;
	bh=w75m7vuwDkdVv0GXOnFDcJZrp8g04zWV6N/XXtB4B0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7ZMImgl7ffjjqYZLF9lOG7ZmB1YI4IPh5k2tkrsNlWHjENlMOZPBNtSXTVzVbfuM+m97+VAR38ZPkG3SWmLYtghlQ9F1OAoFWmyAbKYdG3w5uqhbscNJOEa9W9prlFgi9zARu941aWyVZxp+9VD2fgPBGd9Mef5TK0P/U2g4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBRI0XZy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so35958971fa.3;
        Fri, 12 Jul 2024 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850105; x=1721454905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8t4/IOXLQvVBBq5agGXjavJDG6OcHVPOXjOJapQ9v0=;
        b=VBRI0XZy9pTkganyvWRSllA3QLO0xbADOjy73BBV/Opd1A91/N///fz4hspVbVTlEw
         Gmhaa5ELiubGYJYBntOVLa1k21qMZGX7ZjNthHb64ptnqvU2ZJIBskumck4eW3nUNNpo
         Ku0lCP+X7o0gh6BAPYvNoie8nMbdOnWdEKmHyNo+/aRSGwAxxK4xM0ZzoJerqKE1m9FJ
         Y9cdInKL2PYUcw0H8rShAaqKcEMMDQcgJmpJORoX3CVCmMGCa2ZA5tOMXhUB6saM6iZ7
         THt5asKwOGPwMNMfmRd4Wz3Edaa1fs7Iy4Z1AU6V9hsrL/cMSJNIzSNOgJuS4pwVZ1zH
         YI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850105; x=1721454905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8t4/IOXLQvVBBq5agGXjavJDG6OcHVPOXjOJapQ9v0=;
        b=b90xv1B7K2kYg97XvPVFjq/03EvuRWo6U81ydbfpiYukz6Bm3vAmtoEixu9IvX4P6z
         Cv2zX+dqTPT0iE2BcowJ9PYt9N+XUXGlJitNRKIKUcKJ2VkxmZTHTpv5Ry9P05HD2x+j
         pCoxrPCQqDfYjv8gsllPo6o6DwJKIV2Shqp6AbfkVp8OT11RtJYkdSYJDm/dsIxBliYq
         9LpHlKkYAjjxOcWi8KyqdEaJt/8AeUxxMuYCr4tsoUrsr35gKNRlwq1tJt/VwQNp+Wro
         Ol8AfSjJLiocWneoZftNPv1G+5wBT1XsY9I5J+WQnMhY7ta5BPU56O45jh1luvfER7ED
         mD1A==
X-Forwarded-Encrypted: i=1; AJvYcCVT6jiS2ofk0yDu0VQLdd+oWlU9iR6LZ1oVvBVQYMtuomx5MNkH2FuLUfcf7KEfzurgTELyvBdBkfeo1/7qGv+oktCOwRpqlHrwR5Ex
X-Gm-Message-State: AOJu0YypqKAkKBU9tHG/EXJ2QQ0OAMlxtn74Cl6ZkGpndwbCqeYQJVk2
	so4YWUKjv92T0r9uC/RGKyQnJBxDCDHczi9qw56sho3Xr5SJ6wiDkJG0EM7K
X-Google-Smtp-Source: AGHT+IGLSB22KV8LlPAx9KdxiKPodRgpyRXCxfmjIFjnUKR5NoG00MRGTDQGsNLNbJHbdfBWeF/KVQ==
X-Received: by 2002:a2e:9b0f:0:b0:2ee:8dce:2f92 with SMTP id 38308e7fff4ca-2eeb30ba7acmr108068451fa.1.1720850104502;
        Fri, 12 Jul 2024 22:55:04 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:04 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/12] net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into dsa_8021q_rcv()
Date: Sat, 13 Jul 2024 07:54:32 +0200
Message-Id: <20240713055443.1112925-5-paweldembicki@gmail.com>
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


