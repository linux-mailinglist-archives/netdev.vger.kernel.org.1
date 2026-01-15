Return-Path: <netdev+bounces-250206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12AD2500E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E48F30A92BB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3D93A7DFA;
	Thu, 15 Jan 2026 14:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFE3A4F4D
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487909; cv=none; b=pdRrsUXpYisyJbVANLEDgNSevDeqCO5c99ftZ7SzLO3t3KBZ2JbdTdYiU7fErdc607j91bkhAorwoD8/WLiN7h/T0yWgGcig8CJilQYadgjAzDklGYRkK+mW17z0GiQMY8mDkh1cE1/qT9NvpY4AmzxdlWAtgKP85Uyu3FCOiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487909; c=relaxed/simple;
	bh=mTt9g4AIDDCE/wyHFNRn7ITIDqk1FNXdFvVq0NDOWRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/srZ2STBWSfS0+hi+q+Cb98S3yac5ZorLVNi+VEPyOUaxnFkNyYpsKaYYNI6y6LgRklOFTN3nOghNGMJhbVGzBD6WQ7AvKrfPWOVkcREU3RSbZ/vMhVnBay4Wubg4FLPcmYWf3GyfieZeila3vcQsKP/5Jo4I9MDeDNhvg6puA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfd0f349c4so628400a34.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487900; x=1769092700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=otSP3WumEJ9ljtBMFrQYAuqQcsR+pe8+cqNgEJVYYfU=;
        b=LaYctOBdzNxXnEn+HLvpozEXP2ukkVMYurztSSuZgzKRALk6vb6C7RiZPmyDK2GVNF
         ME2pcW8LoRjX5GkcdFA7i7Y9Uyv1UvaAQwgMg6YqHvPC3PWG2a8lcKMr8EXVSRBuv3Vk
         MC/3n9bVJLCuOJhf/kLZ+jYGztRC3VhEAW5w/5pbEHX26n+BrwEfCTXVQsmiMZcWgcb9
         UgnqHAuQT19DopM+NEXxtXfaEKu0YcwPHZN12qVciJ6lxRqf9pfG/bOYerrKdybZe959
         6uFpOP3u55aJrsWKjDV8I4HGqKa+3kdG8JYBXf26vU7Twwz9b4Jlp51sOVhUK8dUs1Xm
         BDcA==
X-Gm-Message-State: AOJu0YxqcVcEz9B18zDO3Eg8fhKfQkDyUnIKnCJF/LQ1AA0IdWzy6RqG
	A93mbND6EHsLrLvKle+MXYclRwT6oYss1yyXtN1fn++2uE2UmHQ6OCjX
X-Gm-Gg: AY/fxX5QghcNmofxvFxf+il16T7r9Gquox/dIMQZ4DSci9m6tU/FSRvXbGYEo9CeqvT
	cj0c14rlNGv8jtZni2H+5mnCYJKjcp/O9xJeT7xUDEz+BSdS0HK9kibOhNrZkxQwbi6POdnS1Ef
	zOQ2hch7kiiEqN6TFzu2WybhBqcfEjH0j1n+GZbGdDG3Vs6APXQTciM0dIk/4zCbtWODQlV3T5p
	/ROXrgCSCau/SwQ93HlmuFohwtREb7Cx2a0AJO4rN6dxATpjmq6KIn63okp6btQFt3d45mW/tdR
	nkMDr4UaHUs+GMJTidvn9POmnuu63beVqSjSi3HvYji2oFGF/8x+w3boJPgLHV/P2ZkX3nhhKVD
	VbfJnYZ7SQSdML2K4nh/bCVMob25T7crQn6tLpOqVbHhb89ZalfWm5wAk5fGezyXjvWywNBH15A
	/T/Q==
X-Received: by 2002:a05:6830:358e:b0:7cf:da97:57d5 with SMTP id 46e09a7af769-7cfda9757ecmr957520a34.34.1768487900523;
        Thu, 15 Jan 2026 06:38:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfd68b13fesm1559488a34.3.2026.01.15.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:54 -0800
Subject: [PATCH net-next 7/9] net: cxgb4: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-7-b3e1b58bced5@debian.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=leitao@debian.org;
 h=from:subject:message-id; bh=mTt9g4AIDDCE/wyHFNRn7ITIDqk1FNXdFvVq0NDOWRs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvSKI56w6S51MA1g4GESPyU+3R/PgLYWFpyg
 RPCz4ftjtyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70gAKCRA1o5Of/Hh3
 bT6nEACvWlpHECCXJWCsSIz2b2fYD3jmE+YC812EOVG5+Zgom6pRSjYRnpNtdw6aB4pt4AqHazt
 HZFziZXiPwrVJ2KHKtvLJZoxKPasMBVoOXL66e2D5tK5/mI0KYr9tm7YPRiMH5dGlcGJKU6XNsA
 G6N+dTc7KGSezfQbek6Bd8dWIpoxHoewdIhlkQFtiQ/X0GnV8CP+YBxfN8e7VxS6ORKI9Eu2w1E
 KRO2JjSj1cz2bfntjyD/I3tzznYWFgp1+ghvduFHDLRfEOFyjxdMyJ9/2hwXO/SiLOUDqhFIK2I
 xHata1GinUobVH5wC/JDB4I24G7sUoqrW1vUQVFScu8p+i90ajthRDbJFsAIEJ3AdeAWWu3VKMI
 57ArKtwl6Qv6V7N6KfHRPi8sFD6PdAv2wVDq4w/LJbAzSfug48nxIM664m9EihWEaVEvEZLpiDZ
 A/ODC9UEICyZdjzs/yEz6P3R3/Oyjrh5u0HffU7u8PEUU48MpBTkw/WaTy+sTzjhAAm3+DYsLGT
 YxghWqGbpydPH6FaGSUgKB8ISAEFYnUsA3Zy0MBeZ4UbwKOTxFAIC3JhDyrH2GLh70WwgTyGEjC
 ZMISm3UWHjF23jaIfJBhLLEk7ANEUDZd0JZ3YumtwhGKWR0ZvjOj/uQRxh1k5rkMRlHSNhqRCZv
 YJxvQ2AHmSnZF5g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 23326235d4ab..faf8f7e86520 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -1784,6 +1784,13 @@ static int cxgb4_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
+static u32 get_rx_ring_count(struct net_device *dev)
+{
+	const struct port_info *pi = netdev_priv(dev);
+
+	return pi->nqsets;
+}
+
 static int get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 		     u32 *rules)
 {
@@ -1793,9 +1800,6 @@ static int get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	int ret = 0;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = pi->nqsets;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		info->rule_cnt =
 		       adap->ethtool_filters->port[pi->port_id].in_use;
@@ -2200,6 +2204,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_regs          = get_regs,
 	.get_rxnfc         = get_rxnfc,
 	.set_rxnfc         = set_rxnfc,
+	.get_rx_ring_count = get_rx_ring_count,
 	.get_rxfh_indir_size = get_rss_table_size,
 	.get_rxfh	   = get_rss_table,
 	.set_rxfh	   = set_rss_table,

-- 
2.47.3


