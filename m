Return-Path: <netdev+bounces-159267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80FA14F4A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF82B7A37A8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7331FF1B1;
	Fri, 17 Jan 2025 12:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903C1FECD8
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117582; cv=none; b=ORmI/9eOk4IXs3HEURFOfCOnxDchzYXQ2biriBshYCKxJevmtQYa0ajdLt0QX/JaTVZE+4/Pskk/Tq8vgeUoU7Ad7wuYwf8awfSXZc2Dcj7o7vrgheIwJxSoKYMbkfJI/4A8w8ZcWpaEawgN+2y5x3EK1+HWt1cHeFQoR4X8LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117582; c=relaxed/simple;
	bh=NQge+gxHsVTCyOABlwy6Hpmp2Fev2Y1ppuES50064Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9o5UpxZpAcBaTugGtlsP4s8w7Mt4UdRj6q2lwXY5y2QFUf7J8D6tHJQr3/0RUQiXXkOWN9gaqosSFUyB2ztI5tepUIKnNTQTLvISAs5LEcVJBahWOXSv4gctTvQTtjM2HJeHEYCRrf8SRX3nJSLKPEsrBn/WgeiGIqUFt3Azc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5973c90D8A96Dd71A2E03F697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id F23C8FA365;
	Fri, 17 Jan 2025 13:39:38 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 05/10] batman-adv: Map VID 0 to untagged TT VLAN
Date: Fri, 17 Jan 2025 13:39:05 +0100
Message-Id: <20250117123910.219278-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

VID 0 is not a valid VLAN according to "802.1Q-2011" "Table 9-2—Reserved
VID values". It is only used to indicate "priority tag" frames which only
contain priority information and no VID.

The 8021q is also redirecting the priority tagged frames to the underlying
interface since commit ad1afb003939 ("vlan_dev: VLAN 0 should be treated as
"no vlan tag" (802.1p packet)"). But at the same time, it automatically
adds the VID 0 to all devices to ensure that VID 0 is in the allowed list
of the HW filter. This resulted in a VLAN 0 which was always announced in
OGM messages.

batman-adv should therefore not create a new batadv_softif_vlan for VID 0
and handle all VID 0 related frames using the "untagged" global/local
translation tables.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c           |  7 +++++++
 net/batman-adv/soft-interface.c | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8e0f44c71696..333e947afcce 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -637,6 +637,13 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
 
 	vhdr = (struct vlan_ethhdr *)(skb->data + header_len);
 	vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+
+	/* VID 0 is only used to indicate "priority tag" frames which only
+	 * contain priority information and no VID.
+	 */
+	if (vid == 0)
+		return BATADV_NO_FLAGS;
+
 	vid |= BATADV_VLAN_HAS_TAG;
 
 	return vid;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5666c268cead..822d788a5f86 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -637,6 +637,14 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	if (proto != htons(ETH_P_8021Q))
 		return -EINVAL;
 
+	/* VID 0 is only used to indicate "priority tag" frames which only
+	 * contain priority information and no VID. No management structures
+	 * should be created for this VID and it should be handled like an
+	 * untagged frame.
+	 */
+	if (vid == 0)
+		return 0;
+
 	vid |= BATADV_VLAN_HAS_TAG;
 
 	/* if a new vlan is getting created and it already exists, it means that
@@ -684,6 +692,12 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (proto != htons(ETH_P_8021Q))
 		return -EINVAL;
 
+	/* "priority tag" frames are handled like "untagged" frames
+	 * and no softif_vlan needs to be destroyed
+	 */
+	if (vid == 0)
+		return 0;
+
 	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	if (!vlan)
 		return -ENOENT;
-- 
2.39.5


