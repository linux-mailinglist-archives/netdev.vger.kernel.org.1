Return-Path: <netdev+bounces-95694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F2C8C3157
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7651F21821
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697D4E1CF;
	Sat, 11 May 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXYnukba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376595028D;
	Sat, 11 May 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431457; cv=none; b=u+Dh+nfsBF6kmW7QscAib/1BVWe4hHWu7xBaCy+2AFLtKVmeRRwhfFypLrp6xxFbK4VriyCcaE6CfdkOdZ8xIPL0OfGEVLP2vJ2DgUzvIGLrS8S+loED5TY/Femb/8cFa2BvPie+8w36m5RysHTphOyqYGLGX3n0Gv4LGHHEfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431457; c=relaxed/simple;
	bh=rAGSY5+dD8abp+PN4nndzwx7t6kgk2/A0M4fxN9D+cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4U0OR25VcdD9KUujT8N6qlcF4DiCfZE6v45LZq2KndAAqtJ1yQswJv2hMQk92f+tD0mLUrfx7kb/W5wNEXiUGjUjqq4qRJV/i1IS+Hc+PxjKS6Ezb9bbqE/j9CvfQLUS2Magk5qKmEz4B8rNAvDIbe5AiUcgJDI5YhjHrISeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXYnukba; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34db6a299b2so2260976f8f.3;
        Sat, 11 May 2024 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715431454; x=1716036254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ8Z0Aarz6dukVwTSg6oFxXKuRw0aMvSSKkaUBN7Jgo=;
        b=BXYnukbavfvEKNwNX4rGv6dNqYcYz6QbxjFtxTKmXA4zjUFm5uqW/ep5c0bwwS2U9k
         VXO0yJzURRqdb5/2fQejaB/78S1h9RQdP03G4y3ZOu6Z5x0foZBMZnOIjgVQ9NnwfL7C
         d4XLzbv0KQoo1J+ArJaGqx12PavA8xlnqnfDbJEhwBCaVDq6j50w4PfAjzAizGkBpfkO
         npnnoH02KoDYBHGZdJ7Je2anErY66ioMQzC3n2QjxKz6p+qHupo5qBVdlaHKd0/066sz
         SYvRwqbZIRZsZf5iBcKNRV56j8EOotoNBlF/Egwb8NCKTeJ9nFX5HVkPmjfZjA6VEFWI
         yzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715431454; x=1716036254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ8Z0Aarz6dukVwTSg6oFxXKuRw0aMvSSKkaUBN7Jgo=;
        b=W9owI03d388hIL+8l9NjVaR+1kK8NezATLHYprMF4p0qDDXIj5ahjLlvXOx5yxmcqH
         8RXmqvf9DgydAw9JGS0KmiLb5+r5Of9XulUIc+h+l+0sesR1TJi6OOeYRNMSQJkIA09m
         x0vmL/OBC5XTYkl/CyG/SY7CekHxElNLelO+LC/ihMfwPVrTpl0YSmf+oxaQAq9ETpIs
         kL15onaPs0pY6OeY2nQ8ZazXnK3kGJIqckrB2rTW14RU2b6NEBUPWwp1xbOZaXLYXAQV
         Bl96bDw7JdMFTUijSNRb+PFk9miyb2HzpDg9wIiC5/98NZ+6geTmpfYnhXEYFVwYvxuh
         SCmg==
X-Forwarded-Encrypted: i=1; AJvYcCUT0oiGos332+IzZMEfe1ctekbCJfogBlD5WWVyTI8cRuA0xrnW/dVDjCDsq8QA836pZhGqtvUs5Pgw9LyAqq/BinrQlB9DJR56CnOgPRkj0uxqAzOGvfamiF6JlhHZy23oNCNa
X-Gm-Message-State: AOJu0Yy/JbAiCy2QiSPINEpD3htMxsbZu+UIJkTRWzaTGzq1U6WI/VoM
	aIHP3vhtllw+dmtXQDAFH2dZzagEmOcjabqBLK28U20VQ7Zn74QD
X-Google-Smtp-Source: AGHT+IHkUpBwdP2Rs+StkRWiK5hqO0KXE+W4zhMPOSox52JFXK9GDaBhCcgl7UPv1pYmQBpqXPckvQ==
X-Received: by 2002:a05:600c:4f4e:b0:41b:a271:60a9 with SMTP id 5b1f17b1804b1-41feaa2f38bmr41453825e9.6.1715431454258;
        Sat, 11 May 2024 05:44:14 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-229-253-184.inter.net.il. [84.229.253.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd10cf8besm49870535e9.1.2024.05.11.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 05:44:14 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	Sam.Shih@mediatek.com,
	steven.liu@mediatek.com,
	bc-bocun.chen@mediatek.com,
	SkyLake.Huang@mediatek.com,
	Henry.Yen@mediatek.com,
	john@phrozen.org,
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
Subject: [PATCH net RFC] net: ethernet: mtk_eth_soc: ppe: add source port comparison
Date: Sat, 11 May 2024 15:42:26 +0300
Message-ID: <20240511124230.13991-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve packet loss issue on the following conditions:
	- utilizing multiple GMACs
	- device has more than 4GB DRAM
	- using PPE

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c      | 4 ++++
 drivers/net/ethernet/mediatek/mtk_ppe_regs.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 6ce0db3a1a92..6415ba618ebf 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -1053,6 +1053,10 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 	      MTK_PPE_GLO_CFG_IP4_L4_CS_DROP |
 	      MTK_PPE_GLO_CFG_IP4_CS_DROP |
 	      MTK_PPE_GLO_CFG_FLOW_DROP_UPDATE;
+
+	if (mtk_is_netsys_v2_or_greater(ppe->eth))
+		val |= MTK_PPE_GLO_CFG_SP_CMP_EN;
+
 	ppe_w32(ppe, MTK_PPE_GLO_CFG, val);
 
 	ppe_w32(ppe, MTK_PPE_DEFAULT_CPU_PORT, 0);
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
index 3ce088eef0ef..61fea4b4b65b 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
@@ -18,6 +18,7 @@
 #define MTK_PPE_GLO_CFG_UDP_LITE_EN		BIT(10)
 #define MTK_PPE_GLO_CFG_UDP_LEN_DROP		BIT(11)
 #define MTK_PPE_GLO_CFG_MCAST_ENTRIES		GNEMASK(13, 12)
+#define MTK_PPE_GLO_CFG_SP_CMP_EN		BIT(25)
 #define MTK_PPE_GLO_CFG_BUSY			BIT(31)
 
 #define MTK_PPE_FLOW_CFG			0x204
-- 
2.44.0


