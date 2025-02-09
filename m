Return-Path: <netdev+bounces-164427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B1A2DCC3
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E86164DD9
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0C17C225;
	Sun,  9 Feb 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUyCYdkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68944C77;
	Sun,  9 Feb 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099385; cv=none; b=KFWkRJtwD4FeVY1ct9/RjmZ0oFw1XcbMm2dXIUOCeD0YSpJB0Hl6lD5Zp2U42GBvp8x5v3QJsoJ1kUr1nqvYyEW6wrTgRd9r+inFO4bpcJoxlRcLyNflHytFIeH0cMIuPBkuQFdvfuyW5yvjX0Jw5fLPbB/nV2XC8iw16fIwGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099385; c=relaxed/simple;
	bh=b9OsKAHrbZHwxShQ9VNqKsuPq52JFnm26veogfMD8qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTfoY8feLDaRFej15EnzSzjxOwK3eVNDl8RlhmYcOSRUj0BKqP40XQGygogTIylPprlACdLqbGAiDCahZQ6MtNPmK0E9onaJrS7mcBOcubuFe1ghnqk3aWU2dUybsLkewCQP4uXfM7Qly5/BnHkKLKc7Q7MlAmFJLmuoKOWo3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUyCYdkC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6069ceb5so1603079a12.1;
        Sun, 09 Feb 2025 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099382; x=1739704182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFQblKrUPUsyUzYqlmv4v4FRDoEKQKJ1p2yWOHyxIcs=;
        b=iUyCYdkCdcSq9RdU1oFCF1YBCsRE55KdB1RlfxygGHsFPYiVmoz0u6fW6Eij+cbG5n
         my/tcFwu58j2txmeHzaJiOck+GFhUyClHAZlwGYb+VGWVtwFWvvxHKXwGkK6vpxISzV9
         O5EjzWA0Z2A3ZPMQyRk9ie+5rTODNYuTf4XE8K7GpJk5fMHz1Hq0wWN/rGTxHKqjyz9U
         sBh0LlAMNzGUhIIkOU5CiR15/7aJSI7RkWy4AppQYWi/LWbEl8cvfTBaTJ+loVyrg+o5
         76eAFX6gocA4HGBRWWyXMKzd+IxqNmUxiFHZ5PdTw70QOq8GR9hRPrL6sbCkkXGSAhqQ
         101w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099382; x=1739704182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFQblKrUPUsyUzYqlmv4v4FRDoEKQKJ1p2yWOHyxIcs=;
        b=EJeGsfalpp/Gm5sQ5+Q+DK0TGvtgE6k7la0ZOlCLZmhWXLZE8g+W0GRB7w1i+H5bDb
         A4aNU91yVb11lBDtEgtnZVxqfPu25HthjEQKlpGhvUKAurfSEKwbBUkAQq0orzqxpppn
         u6bZcoyMVP67u9vZej+de7VB5H4cy9ZtLVS0rnU2sX1aOgAXVle57Pa5k/FUqpxa+Kbb
         gMB9pcflAHZldR2DzCNDhIBgIq4IKQeuntcbhEJGO3bGsAB0c681NXsjH9ENh5KIdcfV
         r5WHpfJzNOew7TCbPXa8ZDU7CXq39cUA63xLN3fWDLBsZDnBqPQ4uEv4/Fyj16AMu3Pk
         82zA==
X-Forwarded-Encrypted: i=1; AJvYcCWXszEoZNTpscRLrqTJ729GVx+Qo4Gc2iOLJK3c65BcmufstaPqnJE37EG2j2hOOuly6VyM/GHysUuLjXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0UuQJdI99LptyTiQ34EM99QIUHFbeBEE1Nk1edBHhINHzXXaI
	PH1+wNZVHvlVZ1iwJJbEEKmiJjrNXZaBufkcfOw0vXmjOBtd71Qb
X-Gm-Gg: ASbGncumtD+kA1WP4MPR9z85Jd9XMCuddMXASPo3KHqC8cVBHUzTFCzea6Y5f5U6uQD
	WCw1jy446kT9fzbiq0CWWaAcYJm+/90mve3jxjw0ft78/EKRYW50a4nMOqx64UWuS2SdTI3yopB
	fXBf5WfYKd68+8jfiWa/AOG5YLwK1/G/Olr9/n9wXZNw0/bF8wgIXM3NRdyMLUffGryhONPi7Ii
	Ea/o2Y5yQFFt+RAri0uOOteAFxUJ/731oPOQjeZPnaoUYhp9TXvkNy3eXF1/j9POD/ELb7/XZB9
	7sZYxU9dODOBMl3N4KdFDUn9FCkWyGc55F2ghD4ZLH1qgDXuitAw2t3Y4iAiaXQ9xzbG3mZH50P
	aGxlvTZGU/xGCKCv+FsoIXd5tNHj8yUhE
X-Google-Smtp-Source: AGHT+IEo6Ozc2zXCqL86RQlmR/7Ph/AUPkjCkQRNEm9/1bvXI5GT4AQEumf4kPi+YCr2l95/7ECTNg==
X-Received: by 2002:a17:907:94c2:b0:ab6:c726:2843 with SMTP id a640c23a62f3a-ab76e98834amr1371080466b.22.1739099381438;
        Sun, 09 Feb 2025 03:09:41 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b88aa451sm82595066b.133.2025.02.09.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:09:41 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v3 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Date: Sun,  9 Feb 2025 12:09:36 +0100
Message-ID: <20250209110936.241487-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_foe_entry_set_vlan() in mtk_ppe.c already seems to support
double vlan tagging, but mtk_flow_offload_replace() in
mtk_ppe_offload.c only allows for 1 vlan tag, optionally in
combination with pppoe and dsa tags.

This patch adds QinQ support to mtk_flow_offload_replace().

Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
of PPPoE and Q-in-Q is not allowed.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---

Changes in v3:
- Removed unnecessary second check for ETH_P_8021Q.

Changes in v2:
- Unchanged, only RFC to PATCH.

Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.

 .../net/ethernet/mediatek/mtk_ppe_offload.c   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index f20bb390df3a..c855fb799ce1 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -34,8 +34,10 @@ struct mtk_flow_data {
 	u16 vlan_in;
 
 	struct {
-		u16 id;
-		__be16 proto;
+		struct {
+			u16 id;
+			__be16 proto;
+		} vlans[2];
 		u8 num;
 	} vlan;
 	struct {
@@ -349,18 +351,19 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		case FLOW_ACTION_CSUM:
 			break;
 		case FLOW_ACTION_VLAN_PUSH:
-			if (data.vlan.num == 1 ||
+			if (data.vlan.num + data.pppoe.num == 2 ||
 			    act->vlan.proto != htons(ETH_P_8021Q))
 				return -EOPNOTSUPP;
 
-			data.vlan.id = act->vlan.vid;
-			data.vlan.proto = act->vlan.proto;
+			data.vlan.vlans[data.vlan.num].id = act->vlan.vid;
+			data.vlan.vlans[data.vlan.num].proto = act->vlan.proto;
 			data.vlan.num++;
 			break;
 		case FLOW_ACTION_VLAN_POP:
 			break;
 		case FLOW_ACTION_PPPOE_PUSH:
-			if (data.pppoe.num == 1)
+			if (data.pppoe.num == 1 ||
+			    data.vlan.num == 2)
 				return -EOPNOTSUPP;
 
 			data.pppoe.sid = act->pppoe.sid;
@@ -450,12 +453,9 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 	if (offload_type == MTK_PPE_PKT_TYPE_BRIDGE)
 		foe.bridge.vlan = data.vlan_in;
 
-	if (data.vlan.num == 1) {
-		if (data.vlan.proto != htons(ETH_P_8021Q))
-			return -EOPNOTSUPP;
+	for (i = 0; i < data.vlan.num; i++)
+		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.vlans[i].id);
 
-		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.id);
-	}
 	if (data.pppoe.num == 1)
 		mtk_foe_entry_set_pppoe(eth, &foe, data.pppoe.sid);
 
-- 
2.47.1


