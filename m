Return-Path: <netdev+bounces-169608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA9A44C39
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3686F7A3A4A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0220918DB05;
	Tue, 25 Feb 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/xT8DXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975513B5B6;
	Tue, 25 Feb 2025 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514521; cv=none; b=JmTdYamp8z0ETljvfA5FG2q+ZYQ4GsCn4lFlCS9FJZBgxZIleyiP5yvPRHmSukykZggsh5lHy93D2/Xwp1vMMCrTZCl+/pT4CNw9x6E7bjT5WP7uI82XsCRtpudJAi486VpkEt81rlNRKcwgIwy2SFtKKjlNz+XrXKUCuZ4Gu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514521; c=relaxed/simple;
	bh=x7KMfYayOQ7XLuhGr168+uyXuMaa//GCKqhF03tCjas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+7ozAiCezTmFEB3izaC+9JY8u3m0IuNe1+DVuuB2fmYLxMXEjsrdGz1hHKUk3UoTXRAkOOjpi5+GzYBJJnTKdyeMow8jhm/0GuBxoeYNsthjAj2cYTKVSLr3GY294teMsjiEmckWt2oc+AoZUBjayOhAubwiJ/kcGvEkBd/TtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/xT8DXJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so7968294a12.3;
        Tue, 25 Feb 2025 12:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514518; x=1741119318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2BBGmbLI1nr/65Z65ONI0gv2HpVmeamawdFIgGF+JQ=;
        b=a/xT8DXJrkrxzXBb1Ncd8aen1wnY+daaXYhueH9aH5NtIKkS5tZnObRt9aOosiXIM7
         icgRAOlsuc/ak8YmkBQKrDYslLvx7Kho7iwA1tyzELuUfrzNMnOLVJQpaeJIKGbmG1BZ
         HMbefQSu+hnlackV2/T7Ml9iFjMokUV8C+9WBDEUjFWZQEKtxZlzpu8GpMKW/Sz7tGJX
         uNZIsffQ7YvWFRq2rVf0imjVev1xn1SQumgsHq37TOlpPTW6qQHZEFpiB491VxUnVqnh
         hFCDd9vy91t7wZ6j05deK+gZiS0nM9vnDM/T5TCXos4A+jAgcMxuvrERj0Ksm9Eqn86h
         t0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514518; x=1741119318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2BBGmbLI1nr/65Z65ONI0gv2HpVmeamawdFIgGF+JQ=;
        b=MI+nl7SawwBILh5mMkU8p68/p/FTBn+Dxc79KWQMkXfvRFqBvTHKcgrXHG6DhIAh4U
         f8AAnmxRA5iDkRuooZCOlUq4S0FzWMYJrzGtDrWakT39zqzVG8a0d/pWNxsYKqdnymwm
         Zfo+5i4wt2Y6JKAuuKJpqHPMM6cKib9GPYUc95Q415IK12bG4+iIoK/Aqyk5CgqJMS5K
         AGopuYjOfyZKbUtu50kREEeG81zc3mFdkTpNC2ylKa5vwJSCA4g1iQjECl01vxdZU80D
         QSbV9rdIb+P4eJyGV8QU2kCEzra8k4KTnuv2I2qaTFco1QEkaV6giUJTnn84fhit0Sfk
         hFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu1nRPYRTS7efPFVf+hGn5EenyEcZztK7PE+1iu3issG9qBV0ptKKNTbbDBhl/iSJ2cnQ0RznDzv503t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlPJwHt9UcfExnZ+96kCeMxu3jU4JngBpwPvwulEaSTd/i0P0
	ZGWRw+48A8EkOuAJwKYfiFxUb5/W7vWuqVnJ3jsCPLg94RjqYYXv
X-Gm-Gg: ASbGncuJA9jwTyEEys7Yngu7d9hmqYc2yC/CM9GAwceIlJRj5orQTnxrGViGx2piWYb
	vyJn3OucosKtO3/62ud2RZY9vcBlcg7v1xaBDJHeN5m5jSLVqA7PE/pTn+e3TWCru1BcAekEkGu
	zIRg9F4X33ytHXr1ltWw16gg4o1uoArZvqfOolHaWO4gsOsknOy40W116i5bNkEJxHoDWIcskHf
	oJX96o0Fq1MFHCpsdnLJkcVez2dO+Wy7o8ajFyYzxxMNHeSYJzuMVv+OFnBvuxDFvrm1vQlfsLr
	rqE4g80ae/20eBvGrQkGPD8e623wLNYTaP7T60OORsa9/sOqv92Uf5+e58uOwnUBLrzMo9sbKen
	wOctkpqqqtjlby85XWOdhoZ9wJbS0NlB+OVV/qO13Idg=
X-Google-Smtp-Source: AGHT+IHroxxCR3JqcHk3B/BB2QKboxFSx/yXhrjGWREQjGgy7ImL6JVfDRnn1C0NlLFmeDqy09etbw==
X-Received: by 2002:a05:6402:4604:b0:5e0:8b68:e2c3 with SMTP id 4fb4d7f45d1cf-5e44bb369d9mr9617140a12.29.1740514518140;
        Tue, 25 Feb 2025 12:15:18 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e461c61e97sm1721710a12.65.2025.02.25.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:15:17 -0800 (PST)
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
Subject: [PATCH v4 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ, double ETH_P_8021Q only
Date: Tue, 25 Feb 2025 21:15:09 +0100
Message-ID: <20250225201509.20843-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_foe_entry_set_vlan() in mtk_ppe.c already supports double vlan
tagging, but mtk_flow_offload_replace() in mtk_ppe_offload.c only allows
for 1 vlan tag, optionally in combination with pppoe and dsa tags.

However, mtk_foe_entry_set_vlan() only allows for setting the vlan id.
The protocol cannot be set, it is always ETH_P_8021Q, for inner and outer
tag. This patch adds QinQ support to mtk_flow_offload_replace(), only in
the case that both inner and outer tags are ETH_P_8021Q.

Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
of PPPoE and Q-in-Q is not allowed.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---

Changes in v4:
- Describe in commit title and message it is for double ETH_P_8021Q only.

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


