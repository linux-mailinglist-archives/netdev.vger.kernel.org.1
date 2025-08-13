Return-Path: <netdev+bounces-213152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B08B23DE8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B06E613A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A071C3F36;
	Wed, 13 Aug 2025 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P04yEdgk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E91CCEE9;
	Wed, 13 Aug 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049722; cv=none; b=o+kUGjy3jVCcvPaFRijVnItJ9TyUNGH1ShHC/wkPi9bXoNXoCtelAeayNDIJVUOsZoYlEDGSJcJ+HYv8uj/mIGPCVr4nV349yxQr8uovTpe0qhFEj9tFP3yFWZGf1DxlD+oQCNygff40AdKdSSi2SiCACb7bk3WgC06MkEknmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049722; c=relaxed/simple;
	bh=3RA4BPolg8HJzUegE8vvU73V0FDu//tKui6nBx8k7/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saZGk8B8KXyMb/VYcw8CZDgTblt0ZvTqUOW6j1w0EVT+dGJb/PvVLtajWJtXfbuLRjqPX1cIVhgYV2VKK/CRTktQimrxEXNSF0zaGut76r7bly0nFOKF/bbWyHpBNknZye6yKpFw6T+nEa35yd3WCqZCdKoFluSI5oQloplmCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P04yEdgk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-321c41cdab4so888476a91.2;
        Tue, 12 Aug 2025 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755049720; x=1755654520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNEPtiVWNyz0k5hfirppPx2xAhRHwAbBlwAlyZNXQBs=;
        b=P04yEdgkUh1c4s9j0u7c/2OwyYkrOJdVGuqGlybA+eekHjWBQzFCGvQOGv/rZxlr8U
         +bqQrdt1dc21KiV0YZMnciiRczgklgPo2TJUkkUTEIQK2kOSW67OsRcick5GMQ8AntUw
         AB3WjDDscSFdetSFm5FwHKxlwM7Y7aKqrmSj70J5Hkd2uOROQxusw7V2bbrvh9jcZsvO
         LadPvpeDBQvmVVjhRMsD4bVJIlPZ3zWF4qpfreCB4xWAgziEjTyvTRvoFtEY9wDvQU4Z
         +ogP+6NMoxobVVMGAy05f3qn2u/gxONluxwrT+V53xYQ4Ry5g7wWcNuFxf8VTuQ8PpSO
         vdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049720; x=1755654520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNEPtiVWNyz0k5hfirppPx2xAhRHwAbBlwAlyZNXQBs=;
        b=nQGx2FVD0CJfirPx3Z9mneExB8PJDK4JEsoIu+SA8jAk5MjV4xLN5zH2YDLu4Sak3v
         Vm38r1obEyjwrDEREKcQgUqYgTuOFjfbCDU8CUWATO1QsMilLf6Be/Xqu1QnqA5Dsnb7
         HdzXVFJzdS0cXeT6blL1bQJk49r6CyUGLaXraJ01Hmk5zGj9E/TsiZa8ZNf2hVjjH8Ek
         jI4FypqT6/bAuGq6HDSfyyyi+Rj+pFyQrwk0ZNtQPrC/Cr8V887pEl3JYOcDnxmM4aeH
         RxXBeMZxCMtjUjbWVQvM9BCWZj7UhM9vZXOubLarAwVweGnKeb8jiRwGnBjrgpTziS95
         1oPg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ldslZ4z2lTbSmvdQIuaIYObBsZbzGTRkAa0qqvjfjr56mh0MIsWISDuVwf1SH4Zx87q3hxAB/BP3IeM=@vger.kernel.org, AJvYcCVPDSS9FV9TI3wJabYp6m0J/rZqQ9XqZlMEl+TU+qfL4q1Rjgq02XqCuw89GV3MfLHXXRNxBgb5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhk7ppAPOoaCcCuJcxc67eqAj8Dm/rntX1mSy1agsvzrGcvirE
	86Bfky1i2Rqfhm1481TfalO8Ay1dbn/sB6mKR4mJXiYNcGlUHU+a4LZK
X-Gm-Gg: ASbGncss6sHZoWHFX94zUQNOnCJkaiT0sWMEfBUjTIEBuu/RdL5SPSYVQrXzCy3+ByX
	MbggdCsCtCRn7n5gzmryi/u893UahiGrHrVXYBneWxIZCyAvD+ceLiVZUA45WoeA8O/2ZwYM2kD
	9x3pXj+fog3Byr3z36NwaSGngJiT9EGvUuNUrI3g6MYg7FiNV9UirjETe4imGkCXWCz05kXcLTt
	D6gewDY17VrFt4d3xu0js43v2NGjx3g4RCniX1mBn7S09JV8N1EAgODFa2eEKCnvpvXhUV29qWH
	Acxi9sLM+nHeG0YG/LVKEATW7p5eCwx54HZOmVnInWgKXb61dwY52L2QiK3Y0r76U4PDh2E/tX1
	g92RXQ/P+XG9m0A==
X-Google-Smtp-Source: AGHT+IHiC1yym5R0/cDYZlkWZUsUpaQJz4hN+5buzIoy6vEiOa0/vzx/BS8PkkCS6nRqniff6QWxOw==
X-Received: by 2002:a17:90b:180d:b0:31e:cc6b:321f with SMTP id 98e67ed59e1d1-321d0e98677mr1783138a91.29.1755049719944;
        Tue, 12 Aug 2025 18:48:39 -0700 (PDT)
Received: from gmail.com ([223.166.85.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321d1db52e0sm449652a91.17.2025.08.12.18.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 18:48:39 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 2/2] net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
Date: Wed, 13 Aug 2025 09:48:18 +0800
Message-ID: <20250813014819.262405-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813014819.262405-1-dqfext@gmail.com>
References: <20250813014819.262405-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure ndo_fill_forward_path() is called with RCU lock held.

Fixes: 2830e314778d ("net: ethernet: mtk-ppe: fix traffic offload with bridged wlan")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: New patch

 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index c855fb799ce1..e9bd32741983 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -101,7 +101,9 @@ mtk_flow_get_wdma_info(struct net_device *dev, const u8 *addr, struct mtk_wdma_i
 	if (!IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED))
 		return -1;
 
+	rcu_read_lock();
 	err = dev_fill_forward_path(dev, addr, &stack);
+	rcu_read_unlock();
 	if (err)
 		return err;
 
-- 
2.43.0


