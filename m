Return-Path: <netdev+bounces-250204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4DD25013
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8803130AB535
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1493A7DF6;
	Thu, 15 Jan 2026 14:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8A312830
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487908; cv=none; b=nky1TGT04+waQm70uBnDBfVCZeTZWlTmtOwVJ9WwcKJFB5pSGrc+34nB0mx6URLa3BJzoDiCB2m4FN5m3eiLUWpditlnRfDgsqhea+pRw9mL6uf0B4lFEPu6qt8DWyrbM/U/KxhUoGodBQTyhUBFo5gbvWH/Gz2dKU6SzEIQRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487908; c=relaxed/simple;
	bh=EDM5owIVyL2DjajXDu3o5iZ+GCzD1U2tQZv0qOHfOAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8/gWx3RlymMdP6FGsnw6qH8rGMwIqT/UsEiMDLy/SZcZwDy+TjoPBJhnOFrUQAmB2bXYhdQ8XJtEjOM/VTG6ZmWd3QLQhvsrl2o+/eiyi3qwQ7TlZXL8MU1xS8NR83tJUd/0uHmYpljtPr3VASTH5Xa8wCUoFY6pCiyNDg5P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4043bcd09f2so352453fac.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487901; x=1769092701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I3QziLtppri025RUH9iC7KG4n81ulsbjnXMb8+qxeEw=;
        b=g8BtU1w9fqM4ntqe5jgcIWvjPr5jsYlqwIJWFD3tKct8W+ydCXEk70FBp8DM6KIgeU
         zJQ6yxKnKRo4y9gV6MMsjbH8o+rxpiTL4A42ssiH2FAooNsvyGcSB/n+CYBQAdyGHtdr
         w/l9w7e8mtt1WU3/ubn0K29IQAoqg9ICq5rqjGUEZoHb4b+FYItV7DuUGt61bMFd+Lo6
         P2MTk/vsitky7SJn8A9THNMpdhksjI5Ng1UxudAQmTmNOClK6bVwLULskI/v5LD3PoHQ
         gZQynKYHFOliMviD8YFtQCTccIAmWUyFtFk8pbfT8aIqBG4eue8aoxySVTdq5Bxk+prG
         6fdg==
X-Gm-Message-State: AOJu0Yz/o/udkU1/F+Q5aN/CgV+aqC506Xq4GQeL3YOXrmQlW1tsJHZ7
	BWNVWjpWmjNCd40MMML9fVTqHl2mipJBltuiq5d4z1p+p+1+Fo0llXMA
X-Gm-Gg: AY/fxX6nKV2sDJ6aQzePCjs6sKtFvpv+/5gK3amphGJ1qD7I4THcSlmuzx4Y+5U/Ki1
	jl5q2YvuU3ipd1XF6/TQ/6EMFIVf5i+pYzhH37Gc1pPuFlx1HJe6HLpgwM7Zq/kwr6bjssQTAy3
	rwDPtFeiNl7BGUhGYik+pxU5QyLNEJxWgT0XFq4T3uDxaNU/MuHERsnTFNXbJzAfv5IdQtB2p/z
	zhKcFbHQHC1w9w9OO8JS6cs33pLTyxzRApiBtVWMo3BH1af3Nb7gD8x25sMw/ir4Lwer5B+2Cj2
	JT9rjercY30tP4atZ/dpsMDQeEi3acCui1e0MVtzgSp0vI/om2ReomNYHXka386cpny3HoBEtCB
	r0LbKMsiLo1BDfqECZyyqvcqXbVz74mqpxzvYxhBiuy/hTrPvlTDh8Wo5iL/KFLRV6io4rznrNL
	kCxg==
X-Received: by 2002:a05:6820:7508:b0:65d:1697:e6ce with SMTP id 006d021491bc7-6610068d279mr3919809eaf.23.1768487901584;
        Thu, 15 Jan 2026 06:38:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-404427177f0sm400425fac.9.2026.01.15.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:55 -0800
Subject: [PATCH net-next 8/9] net: macb: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-8-b3e1b58bced5@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=leitao@debian.org;
 h=from:subject:message-id; bh=EDM5owIVyL2DjajXDu3o5iZ+GCzD1U2tQZv0qOHfOAk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvSl1e/Mq8M8IDjFCUaBOsQM77krGX3tiyP7
 UJQ2NGca2SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70gAKCRA1o5Of/Hh3
 bTjfD/wMzBjLyL7mbyJwNKwc6wxg6I5YpP5F0V0MfH3hnmp955ZI8DFLIKq/u+nPJlokYB22aYt
 1Bplo+zYTfN+TGaRW6KNauxtNSk3BMTcqkeiTWWZ4SI13BT2RJWkI1x0pNcKsCDTy/jzwKVXUmH
 pZFIl2VCZP/VGdI90bGpuzJ2NCJX5OznIHaPnZUrsn3NWmViPkOxaKvchYbloRkbSONSAQPT5eH
 4XaveFvRvIWR8a6jhKCJwHvJ4z+ovYTCY4nQSEXt9Yb7plU9XNWh3jufYzDXv/gtbHdGhZZDxHJ
 2rgPBil9vZwKsxd99nkO3TwH/fQ+btPcSNDi7+bNovV9eGPzEa0GKHYNPIbvxbSppQ57nrQXOCX
 U8HHIZuBgGueWGZjo67G3GUZ+otCCqpD9X5Zkbiy4dLYoZOjAJdZPoFFvds34Pfoq7hd96IZe7D
 5Tn9iZXKP6RzqTskPCc1IwSgqO6hWUnkmrPArVr6yS7mgPf4Ed3TQWv9TjlqWcXN0/Rmvaz16Po
 uYu+x+fenatWmWeGgp5Vq71IelJuxVfwLYkrWbgF1ltF8+/lc51g/6Kv0WeVl6OXVRixs3En+RP
 fKnKPBRdciCbDxzoocETR6oC14LkfWfBT2KUEBpglwPpNa45J9T43hsUu2t55DfC44qRxs9/1yJ
 pIRQaqI/0N1tTeg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2d5f3eb09530..8135c5c2a51a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3850,6 +3850,13 @@ static int gem_get_all_flow_entries(struct net_device *netdev,
 	return 0;
 }
 
+static u32 gem_get_rx_ring_count(struct net_device *netdev)
+{
+	struct macb *bp = netdev_priv(netdev);
+
+	return bp->num_queues;
+}
+
 static int gem_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		u32 *rule_locs)
 {
@@ -3857,9 +3864,6 @@ static int gem_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	int ret = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = bp->num_queues;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = bp->rx_fs_list.count;
 		break;
@@ -3941,6 +3945,7 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.set_ringparam		= macb_set_ringparam,
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
+	.get_rx_ring_count		= gem_get_rx_ring_count,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)

-- 
2.47.3


