Return-Path: <netdev+bounces-213546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF8B258F0
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A536886993
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B615B0EC;
	Thu, 14 Aug 2025 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNFfxqkX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43728F49;
	Thu, 14 Aug 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134777; cv=none; b=h01I5f4nkjYvb4W/Heovat3DQM1e2ofoswCEDg4fc8o4tpxB+ZZGxV6QK+1AkIKnOM7B+d72QuYyuiI7c/bvNOX9ILCoyTMCFpUR/vPr5BON9D5SwYYm1jSE/crKa9Ti1+0l3hoQhC7F7rP0wftI/IaPNR3rKwenZrsU6Ed+4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134777; c=relaxed/simple;
	bh=kV1QSd/nevJ/7tHqdtAzJDb0wNuPTF8qFufz9xE96eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwVDHroeO5RIEktggcLodJSGzldCTVS2GathB+DMJzTyjPNtrRsYz14OCumFbEo+O8nylnB9Wk1r0Zh5GnaL+AGeZnsj4kejFPKa7kT+CXvNR6BW1OrgkJtCfnme1IbM0zMHu7liaGgKCujkI5oQh+7pTnXvvWLr103NdmxXubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNFfxqkX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso644951b3a.1;
        Wed, 13 Aug 2025 18:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755134775; x=1755739575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQOMBCaDoHlKYhc6z7ZAvpkcb/oHjnoCwkcWxtxbAbE=;
        b=FNFfxqkXntrlzS7N+ysFH2TyL8gTfWDx6TDicf6bhmBl2B439OlLsUG05sKj5C2Ik8
         V8b9UwmQ1BmvJQxhW+rHuioxO2371HeN9UZm3ukt/BEVwnifQxIaHQzAOFwh9aGzOop3
         EKnKz1RFDJVPbL3FuZqCkWNErQoa7qGh/aLD5B9kDIRnwqQFlEIpXLHfjXcJMAkh1/2Y
         7M5+ASqoE+Z5Da65OBP8qoM7yD5LuTWzvZBvI2xWVb0WZQLk0jWa9mE5dhOqPdzJtgQt
         bgcZBHFKN9KU8KQOvcxJHJXWPWxZvxfdEZ9qm0IWi8VlHUn9KtdpSgj3s8ear5g/aaOv
         RvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755134775; x=1755739575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQOMBCaDoHlKYhc6z7ZAvpkcb/oHjnoCwkcWxtxbAbE=;
        b=Pq/By2bROmKzeRr7J7wSMNl1EWRIknqEO91MeHbs8A5zcJQ+sxtudRpnR02n/g82tI
         MU8cg7VDJj/CaxKBPJxptPewH/MLOTt2+3sgNcz7xtaG5ERl92ZAgmzJ9rz9GuXh93mm
         2qfe6LOx/Awv1CiIX5iUP7TtxwphqrrQh1DbOW8o569ZloBxpHEguWHhlysG8VRM2/ve
         hiHZtiLNqX5850NS8kLByM/XqD076XA5YVHmSejSkKDRz20/vMhWnnVxypnU5zolhf7v
         qY7/B0649/KW3Z5yWbNgqZPMN6eN6/8aGt5SB753Ku3kNvOno2YMC3rcQmwEjtjm4iZ3
         Zo3A==
X-Forwarded-Encrypted: i=1; AJvYcCUS5CZYVFI3JdoYFB/zxA3szi/yHma9R6zik+9yLdzyKJmPDgHxzFkY81YGbSHEXEU7W/0ZC/SIXqV58Kc=@vger.kernel.org, AJvYcCWtSgmPYNFU3BbtiIRlf/L9VPrwNnUDNQOgRE4XqN+As7a++qcqhwqE9UclA2ld0y/yi4Edgj2T@vger.kernel.org
X-Gm-Message-State: AOJu0YydvHa3xZrZa0TVzfFjxYrGpiup3Hf0u9pEhg27GtmP/66n7+5I
	1rZ5iFAnhtF9Y9BtYEFjIssATni7pesEwSeevSqZFIkLpr2J19TA2Bao
X-Gm-Gg: ASbGncuWffglUrMsgqHQdTMiSdBiJ8cUHT6MVtbrRthSqBTLNgdwS1OQoIlv119Lme8
	ugWKHwnbhoYcXsrmJGa2GHeMCnQXGQ6K61F6Phv/0Jr8d+RAKjDdzcZrV3XWI/UgTCFmug9TNpa
	xnqJIdOJ06uyvlNwWyyMEJ85hf2FDyfoHhzoX4ER40zH23xXQ5OMM4POqAifwk0YbFTwN5ExWpG
	StBrcxMCEak50IIjwhqhs07r4WmBkTJpAcARAKthOPhkl3LJloIUGPgxA1Ir/JZa5dRkYGBLjy4
	ALy2mrM5yU+TGYlOjSj9YavYVYHiCotnF17QhUB2fjoCCb6uX6FerOpeJtfQvn5+7dO+0aguxBz
	iFKpQAJgkdnf1
X-Google-Smtp-Source: AGHT+IEh+W8HKgLfDi5M/QKUU3nxoRXj22fu9X7Eskeo4rSZSdxEWF8Y0c8Z7alihJjJAt7Dsu1uZw==
X-Received: by 2002:a05:6a20:1611:b0:240:20d:47cc with SMTP id adf61e73a8af0-240bcfbda2emr1411418637.1.1755134774572;
        Wed, 13 Aug 2025 18:26:14 -0700 (PDT)
Received: from gmail.com ([223.166.85.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm23395786a12.40.2025.08.13.18.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 18:26:14 -0700 (PDT)
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
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v3 1/2] net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
Date: Thu, 14 Aug 2025 09:25:57 +0800
Message-ID: <20250814012559.3705-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
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
v3:
 Reorder the patch to be first.
v2:
 New patch
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


