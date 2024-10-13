Return-Path: <netdev+bounces-134955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539F99BAF5
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6EE1C20A22
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170F13DDAA;
	Sun, 13 Oct 2024 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7N8BS7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F218E20;
	Sun, 13 Oct 2024 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845482; cv=none; b=gbjNsosRJkiNxuKLfk6Fv6nORHi7YEkyAeMDR12/IwYB0gp8zya9Bn16+fRebhYFfj2rHSpVIadzMyBoDOImNbBK3sV8TVhDR2U7pGKDtxpGkXLilUHOSpPkzvzqTr6OOTkXu7CaXNRCWDDwHuV5YlGKfHSVfvEvH1JBKHF+FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845482; c=relaxed/simple;
	bh=JDL2wuPFcpu6wq2ydWF1mXO6CiWRnypM6m0Bv/9xFUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhfeXEqlNzMzwT9CZFgr8WQRuFqW4tb8MMWaLktHfPx84E16tSWzf+XOKzxV5L701AghqzreFfFhA0ovULP0CRJm2Tv6At6NJZrVjnr7oFAAOJqAhvoynhEIDizxy79fmbCRUf+AInj6wxGBTYngBEbzpJaKg9rZRK4v2jfKcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7N8BS7I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso1266055a12.3;
        Sun, 13 Oct 2024 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845479; x=1729450279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upE0t48bx6bnFX6rRPJniUFr4RqVvS0QgUcy6/B4hDA=;
        b=Q7N8BS7IKgPeiJgSpCFEz0slI8LIwZMdIXg9+21+WIuJFzhLCZQ5oV4zXYGIOhdCPe
         W6+/IigCmsbk29dud+zlGCgqpvl3Ud8dBP4QZr5NKxzY/D5qxMbX8pLrp0iz0VzkmkQA
         0QMjGMn5hVIkoGhdeiMfqTdnacspftCk8ICuqcGuVuuPmR6I86irVEExfjviWtuiw2F0
         K7hBBph+0e4fiRWm/8YepeNvStEsNakavvnCn2apH+BAju6sqv0DoMvk8hhFs1wi8r6i
         4DdNYoXwtsU3KASmqOtkqdMQkIMNOVnaH0CNNn79ly8zzIraSrrqwMYNdVHNAiOL8GUY
         iXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845479; x=1729450279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upE0t48bx6bnFX6rRPJniUFr4RqVvS0QgUcy6/B4hDA=;
        b=NYHKrb4/YWQyJsrft03tfL4VlXb0XjKxuDFWyvZRn2+Yp8u4/H+KdzRZZ5Jle0hbqc
         ed6ZgMraqiLLFLsz1IqSg5NRwWxtdrQxu8u1Q2ZL9qedwTOICa1frrDyU7sSjtHAgDq+
         zx+rq4OTAL/cnSW+0yolXj+Ncbw1NSCsm44lgaclpoLnvmQQ+M/Qg40ISbcvHl/GJMKA
         J0/ZEQNdDZa9jAV6X57Xkada0UFdpXkk4Xe30oHiHx4RB+0uQxn5HY9wQWT1NJjtWtxt
         XVbhN3Bd9af9t5C9t0W5jAbFc+sdjuf2hCBm3gXseSp2iC+2I9s135wcZ8H3CvMugkwS
         t80Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyOIHvVSqMtTDXPNM4NZcPsdA3xNRRE2YAJZZ6gtRPig28WyX0xp95hqL6F5mPrgoSjVSWaSACXWLkX5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMBv1BwDruTRQYdMp6Dc2Y8NdogAW8anHsPOlDlgDBg3P/IGcV
	m5ptnO/Fnqg7BwQovMGkfsp0a/RgMUgCtF9aArzXtgo+s6E9yXko
X-Google-Smtp-Source: AGHT+IFisFXHNsMThYF5hflDELoTjfJVgJKtvK5aGnjqGXgf/Lkez2iRLHMqqM2Mpjy0m2JcUM5ZOw==
X-Received: by 2002:a05:6402:42c9:b0:5c9:6c03:48ca with SMTP id 4fb4d7f45d1cf-5c96c035050mr2810750a12.31.1728845479275;
        Sun, 13 Oct 2024 11:51:19 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937156781sm4059656a12.56.2024.10.13.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:51:17 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Date: Sun, 13 Oct 2024 20:50:56 +0200
Message-ID: <20241013185056.4077-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
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

As I do not have any documentation of the ppe hardware, I do not
know if there is any other reason to not implement Q-in-Q in
mtk_flow_offload_replace().

Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
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
2.45.2


