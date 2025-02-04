Return-Path: <netdev+bounces-162715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FA7A27BD6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469007A1EE6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E282054EF;
	Tue,  4 Feb 2025 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC3vRE15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8B20370B;
	Tue,  4 Feb 2025 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698425; cv=none; b=MvZ3lJ0g+txgndv5EDJsgnJZ0f9QNHWt9G2OkGRyxBPuZeX6YpqRTbj7M/8O5AL4wixwdjXBis4re2FBQXgu37uuHRKxPkA/nWIdI+GU1O7Lrs4BFv885+2lVHOQY/HcZpcWSFsU3V/sOY3WoEVu8YyBzWlkPOJKEVk+7VGvF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698425; c=relaxed/simple;
	bh=HoUT6LeQGZhQlYzF3JQ5jjZVjEl9IHiJOmwH5EKCMGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWDZs7+ttXdbHVUgHdPILi85cHYWcQdGUZ+cwJn7EV1UufAXVa7NxZo6aDOXlM9ZUq18zmoE+wTg2qzFODXsu/rfCpP/SS4uTgZ0/9iBG+eU5DWRCXdeD/072ksbMgIAIOZhv5+dFEqFPO9ggBpMlw4C5Eyk06qT0qujY4zI/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC3vRE15; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so248076466b.3;
        Tue, 04 Feb 2025 11:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698421; x=1739303221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOviihCd4OWzkU4ZWy+QayOXt7VAoSjwQrUlx7gxEjI=;
        b=nC3vRE15qmDqX4F1wQKgcd68wVxoC81+IKigZbNCajRrLA3tdET+Fs3IrQTY+eGe55
         g4o2HPUv5nza4pLCopN6iU76rLZzZhmi3b/JUAFE23G8KYf19om66eQOkd78HT0Zl2AI
         ycqKSC4l0xCbF72hGb0CRRgEuBZ2LiFxJQiZDAJAZCkbHIIQJpjxei3Cdezx6uL7YSs2
         K22kaiodprYkkS3qJyn07aKl8+a36N9SxhzVgu9+DTSXNDA6b0LZLt76iEPEPCYEh7oR
         T1Kfr9rlfMWnjsEfatpEEmh+8zxjDHF9TZSmuVbLQyP1gQdOFJvyzOLRueCQDKgHEeOV
         urig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698421; x=1739303221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOviihCd4OWzkU4ZWy+QayOXt7VAoSjwQrUlx7gxEjI=;
        b=iDopOMn3OIcOdfGbaK36uRltLWzI/DZ6Cx5FdegfO75MB0hLk6IxG/YmjUhnTAQtjg
         GEbTVgScqDXmtpZZDq0P7gtr4ZZn2oqaN9+Hq3cYctCLFnBucMIuNipOs7c6rbIkmQHe
         kkQ9LmBhKkgq2vMZNOnwgVAQDld2OSZVuNo58PbiG18P+bPexoOaTWYjrCgb9s+cpUnA
         tcWboQRitoZEYv3jjaAqjMeZst/3etz1vgekO0f2I6Wl58CUEJ+y8e7aNA7DGrwwwrbD
         zRqKA4ZeViA390C3hOSmITBqnBlk2UzqKaIykCeZ+tt+8SXS2ro/Y5T+JppAvAAL7Zy4
         M6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYDbVwKA9QgUhZFIM9D9KQxOokA2L1BTkrzZI0H9wRGRLSennRH5bNbIGgdtXzIjpn2II3gWmEuXjzelI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiHds4KC5fE8wWKey12UUHP5KoESjLEUDaMB4QxV9YEYJlJ2D
	OkZ1wl0ZQodOpJEiEHJSCaZnVQzzwQgFLSsmS2b9fbeNOGE7wolU
X-Gm-Gg: ASbGnct0Xld9hHGpkxVD+OmNRpAKFkoEiBue5HVmbKBOoezf+6BV+Lt+Ns1ZHEQIh8F
	3oqU8DaJcBVKj9cY+whNFUS4btaVDQMxCyp2kJbNfcE7vV03n7xqusN8gdqPDXedTP87H6ReFZq
	ay7sTvwhRsmKM8v99DxgwIsJMv/6TtGn6pfa8aZ4+ffOuo37f0ArdmGeZwDMrLN6ktFf8cOJh/D
	plu1a1o10OqjPBN8sFw3uzJdAriNosgg9CqGLvdEcK2ezLosuxAxDH+TS/vGSHYkMjupy/Rz6Aj
	oY1NXwqK/SjouxqA2dyIE7n0rFdFXu/61P1khLeU+KgBNHbeDY4gew82sCeWecM0mMLApRyCmlh
	WhcLTBbNGnbssz8TSXL+tN7syPjXRsMjL
X-Google-Smtp-Source: AGHT+IHeWXuSOX8ugXi7KX2sQvDZA51J6pn9rqEUJAKyCLo9RjU0qJQZ+hTlul88ONSzO+JY3LViIg==
X-Received: by 2002:a17:907:2cc5:b0:aa6:9eac:4b8e with SMTP id a640c23a62f3a-ab6cfdbf7e2mr3456200366b.41.1738698421177;
        Tue, 04 Feb 2025 11:47:01 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc8838d5a1sm7644954a12.42.2025.02.04.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:47:00 -0800 (PST)
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
Subject: [PATCH v2 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Date: Tue,  4 Feb 2025 20:46:24 +0100
Message-ID: <20250204194624.46560-1-ericwouds@gmail.com>
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

Since the RFC v1 did not recieve any comments, I'm sending v2 as PATCH
unchanged.

Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.

 .../net/ethernet/mediatek/mtk_ppe_offload.c   | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index f20bb390df3a..c19789883a9d 100644
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
@@ -450,11 +453,11 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 	if (offload_type == MTK_PPE_PKT_TYPE_BRIDGE)
 		foe.bridge.vlan = data.vlan_in;
 
-	if (data.vlan.num == 1) {
-		if (data.vlan.proto != htons(ETH_P_8021Q))
+	for (i = 0; i < data.vlan.num; i++) {
+		if (data.vlan.vlans[i].proto != htons(ETH_P_8021Q))
 			return -EOPNOTSUPP;
 
-		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.id);
+		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.vlans[i].id);
 	}
 	if (data.pppoe.num == 1)
 		mtk_foe_entry_set_pppoe(eth, &foe, data.pppoe.sid);
-- 
2.47.1


