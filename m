Return-Path: <netdev+bounces-105950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE92913D5C
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CA71F231B6
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179C183066;
	Sun, 23 Jun 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXRik+r/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5A2F4A;
	Sun, 23 Jun 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165098; cv=none; b=Rcl6Tkn7DDQCjQUOZBDDjYOfy/AibqmFez9kAh7JQE+610enF+DanZq2hd6qRBG/TDUQscRtN34VqCC9SkMDD1O3H62v7XE0rpYw8wb/3xoZtjCp7bpo+8Rw9b0mskQrVXQ+fX6nABQz0ppT+Dfsuhqagoe0tdpd1hqfT2mbxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165098; c=relaxed/simple;
	bh=3+cZbqVvTCMSaBm6siIJAOqPbV7AGVE9ISu2o8jcqXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thXm1IkeITwKNoRmBzUqv4ENUCIKYCri8JxSpNT7XmWDYCGXB97SxmuQH2sPZhZEZrF6ONnA4hsqM6Sak4HeDsb5QUwiqtE6K0vibTupPXbIScyv7J29E/TAv8La//P0s6g4k9NMURraFBjCC+3PzUWAikGsWgkt2LQplyVRblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXRik+r/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bbf73f334so2653705e87.2;
        Sun, 23 Jun 2024 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165095; x=1719769895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdcreUxt3em3AD6YvcpNiMBlzrbyIyl8nuxvmtGXEdY=;
        b=JXRik+r/8ICQHQp25aYkdxk4J+mvConajviSwz9SBxdNjR8apVCh1f3RdGc/Ynv9WK
         I1W8UAOpe3lySVZMbh0w0MPuM8uMwy+weWQq94hiTQdhh8K0fDGKbB3pmRNR6EDa6W2J
         Z9+YWL8p5pcCC51sNUle4ZrORhWatiQb6ShNi7fVjrrgy5fYor1/cJxzRvR8iymh3hzx
         +A3+KZsM8MGYXFf1a9U0viwy0CjXyEPXPl7v+DPJ+TrAvp1qKIlI18SCViaKFpIXq3mt
         BHywimPb6lhhQCjkJ1lnpzyOHFByLvO5xf5Z9lYciazl6efun4h1fFwJV3MozguWzibz
         ezzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165095; x=1719769895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdcreUxt3em3AD6YvcpNiMBlzrbyIyl8nuxvmtGXEdY=;
        b=PPcisOQVuh6seMDFOdR4VVZ4LVYszZXePjNV2YS6y4dKCXU2RB5cZbytcE4uxL5zRc
         elRRbbTtrqr5JcmPMEZnCEadQCIm79oIofpZYewHqDDM0RQMoRB7j1ThLlEi+iJyCWEc
         z/rDTWaTuUII2zkxsPgydQzaO0GXkay2U73I8cRl2CePmZEdIjuDBmpw76BLq6ncamsL
         MF1u2C/MLKfIT9i7zOfMGqVrYmb0x10gv+v6dtMquli6Cl73ZqqmX/CE+/bEGKPeKJlr
         figmtLMqfQ2ifwBfmforSc7Qx4kbcS+iEkWJeu/GCJjCgCKjUwBsqWN9a6R+WJ3WR9vN
         FGSw==
X-Forwarded-Encrypted: i=1; AJvYcCXfUbRiGVDWNr/H7Gp43Xa9bWAMNdCnIZNpGbVaJnnYs+M1+6Rm2tYQXUJzjUvFoV4I00L7nkOp79GG0eC5t0/tu1F0uomMDBZRPOC3HVqt8kLhMgRy39I49TLT7+vwEIyrQX9T
X-Gm-Message-State: AOJu0YxlzntOUMw2Ue1G0Y5hJyMbVcgloUp9vupdT8n8/Ih+0HuOnKXV
	v5DjKFjTr9v0JWEHxL45sK2U46GAng2WU0sJBf2pEdryhxkw8GS5
X-Google-Smtp-Source: AGHT+IEDs9kn2GAQdZwBasIOD1+F5HhqKnWQ7Vdp3GVBS7E9o1Z9R3kZ5rqtaCh9WMX65Fh4ViDg4g==
X-Received: by 2002:a05:6512:2147:b0:52b:bee3:dcc6 with SMTP id 2adb3069b0e04-52cdf820929mr2018737e87.51.1719165094428;
        Sun, 23 Jun 2024 10:51:34 -0700 (PDT)
Received: from yifee.lan (IGLD-84-229-253-201.inter.net.il. [84.229.253.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9667sm106010095e9.15.2024.06.23.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:51:34 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: ppe: prevent ppe update for non-mtk devices
Date: Sun, 23 Jun 2024 20:51:09 +0300
Message-ID: <20240623175113.24437-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an additional validation to ensure that the PPE index
is modified exclusively for mtk_eth ingress devices.
This primarily addresses the issue related
to WED operation with multiple PPEs.

Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index f80af73d0a1b..f20bb390df3a 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -266,7 +266,7 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		flow_rule_match_meta(rule, &match);
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
-			if (idev) {
+			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
 				struct mtk_mac *mac = netdev_priv(idev);
 
 				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))
-- 
2.45.1


